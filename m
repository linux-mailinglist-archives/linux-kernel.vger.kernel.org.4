Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6651D61F330
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiKGM2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiKGM2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:28:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA601B7B0;
        Mon,  7 Nov 2022 04:28:05 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5Vmc2drZzJnXD;
        Mon,  7 Nov 2022 20:25:04 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 20:28:02 +0800
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 20:28:01 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "Mike Christie" <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event sent to userspace
Date:   Mon, 7 Nov 2022 20:44:14 -0500
Message-ID: <20221108014414.3510940-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
for multiple times which should be fixed.

This patch introduce target_state in iscsi_cls_session to make
sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.

But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
Report unbind session event when the target has been removed"). The issue
is iscsid died for any reason after it send unbind session to kernel, once
iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.

Now kernel think iscsi_cls_session has already sent an
ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
would cause userspace unable to logout. Actually the session is in
invalid state(it's target_id is INVALID), iscsid should not sync this
session in it's restart.

So we need to check session's target state during iscsid restart,
if session is in unbound state, do not sync this session and perform
session teardown. It's reasonable because once a session is unbound, we
can not recover it any more(mainly because it's target id is INVALID)

V6:
- Set target state to ALLOCATED in iscsi_add_session
- Rename state BOUND to SCANNED
- Make iscsi_session_target_state_name() more efficient

V5:
- Add ISCSI_SESSION_TARGET_ALLOCATED to indicate the session's
  target has been allocated but not scanned yet. We should
  sync this session and scan this session when iscsid restarted.

V4:
- Move debug print out of spinlock critical section

V3:
- Make target bind state to a state kind rather than a bool.

V2:
- Using target_unbound rather than state to indicate session has been
  unbound

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 57 ++++++++++++++++++++++++++++-
 include/scsi/scsi_transport_iscsi.h |  9 +++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index cd3db9684e52..4bbd1aa4a609 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1676,6 +1676,21 @@ static const char *iscsi_session_state_name(int state)
 	return name;
 }
 
+static char *iscsi_session_target_state_names[] = {
+	"UNBOUND",
+	"ALLOCATED",
+	"SCANNED",
+	"UNBINDING",
+};
+
+static const char *iscsi_session_target_state_name(int state)
+{
+	if (state > ISCSI_SESSION_TARGET_MAX)
+		return NULL;
+
+	return iscsi_session_target_state_names[state];
+}
+
 int iscsi_session_chkready(struct iscsi_cls_session *session)
 {
 	int err;
@@ -1785,9 +1800,13 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
 		if ((scan_data->channel == SCAN_WILD_CARD ||
 		     scan_data->channel == 0) &&
 		    (scan_data->id == SCAN_WILD_CARD ||
-		     scan_data->id == id))
+		     scan_data->id == id)) {
 			scsi_scan_target(&session->dev, 0, id,
 					 scan_data->lun, scan_data->rescan);
+			spin_lock_irqsave(&session->lock, flags);
+			session->target_state = ISCSI_SESSION_TARGET_SCANNED;
+			spin_unlock_irqrestore(&session->lock, flags);
+		}
 	}
 
 user_scan_exit:
@@ -1961,6 +1980,21 @@ static void __iscsi_unbind_session(struct work_struct *work)
 	unsigned long flags;
 	unsigned int target_id;
 
+	spin_lock_irqsave(&session->lock, flags);
+	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
+		spin_unlock_irqrestore(&session->lock, flags);
+		if (session->ida_used)
+			ida_free(&iscsi_sess_ida, session->target_id);
+		ISCSI_DBG_TRANS_SESSION(session, "Donot unbind sesison: allocated\n");
+		goto unbind_session_exit;
+	}
+	if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
+		spin_unlock_irqrestore(&session->lock, flags);
+		ISCSI_DBG_TRANS_SESSION(session, "Donot unbind sesison: unbinding or unbound\n");
+		return;
+	}
+	spin_unlock_irqrestore(&session->lock, flags);
+
 	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
 
 	/* Prevent new scans and make sure scanning is not in progress */
@@ -1972,6 +2006,7 @@ static void __iscsi_unbind_session(struct work_struct *work)
 		goto unbind_session_exit;
 	}
 
+	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
 	target_id = session->target_id;
 	session->target_id = ISCSI_MAX_TARGET;
 	spin_unlock_irqrestore(&session->lock, flags);
@@ -1983,6 +2018,10 @@ static void __iscsi_unbind_session(struct work_struct *work)
 		ida_free(&iscsi_sess_ida, target_id);
 
 unbind_session_exit:
+	spin_lock_irqsave(&session->lock, flags);
+	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
+	spin_unlock_irqrestore(&session->lock, flags);
+
 	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
 	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
 }
@@ -2061,6 +2100,9 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
 		session->ida_used = true;
 	} else
 		session->target_id = target_id;
+	spin_lock_irqsave(&session->lock, flags);
+	session->target_state = ISCSI_SESSION_TARGET_ALLOCATED;
+	spin_unlock_irqrestore(&session->lock, flags);
 
 	dev_set_name(&session->dev, "session%u", session->sid);
 	err = device_add(&session->dev);
@@ -4368,6 +4410,16 @@ iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
 iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
 iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
 
+static ssize_t
+show_priv_session_target_state(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct iscsi_cls_session *session = iscsi_dev_to_session(dev->parent);
+	return sysfs_emit(buf, "%s\n",
+			iscsi_session_target_state_name(session->target_state));
+}
+static ISCSI_CLASS_ATTR(priv_sess, target_state, S_IRUGO,
+			show_priv_session_target_state, NULL);
 static ssize_t
 show_priv_session_state(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -4470,6 +4522,7 @@ static struct attribute *iscsi_session_attrs[] = {
 	&dev_attr_sess_boot_target.attr,
 	&dev_attr_priv_sess_recovery_tmo.attr,
 	&dev_attr_priv_sess_state.attr,
+	&dev_attr_priv_sess_target_state.attr,
 	&dev_attr_priv_sess_creator.attr,
 	&dev_attr_sess_chap_out_idx.attr,
 	&dev_attr_sess_chap_in_idx.attr,
@@ -4583,6 +4636,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
 		return S_IRUGO | S_IWUSR;
 	else if (attr == &dev_attr_priv_sess_state.attr)
 		return S_IRUGO;
+	else if (attr == &dev_attr_priv_sess_target_state.attr)
+		return S_IRUGO;
 	else if (attr == &dev_attr_priv_sess_creator.attr)
 		return S_IRUGO;
 	else if (attr == &dev_attr_priv_sess_target_id.attr)
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index cab52b0f11d0..34c03707fb6e 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -236,6 +236,14 @@ enum {
 	ISCSI_SESSION_FREE,
 };
 
+enum {
+	ISCSI_SESSION_TARGET_UNBOUND,
+	ISCSI_SESSION_TARGET_ALLOCATED,
+	ISCSI_SESSION_TARGET_SCANNED,
+	ISCSI_SESSION_TARGET_UNBINDING,
+	ISCSI_SESSION_TARGET_MAX,
+};
+
 #define ISCSI_MAX_TARGET -1
 
 struct iscsi_cls_session {
@@ -264,6 +272,7 @@ struct iscsi_cls_session {
 	 */
 	pid_t creator;
 	int state;
+	int target_state;			/* session target bind state */
 	int sid;				/* session id */
 	void *dd_data;				/* LLD private data */
 	struct device dev;	/* sysfs transport/container device */
-- 
2.32.0

