Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3764E6336D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiKVIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiKVIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:14:56 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29402183B;
        Tue, 22 Nov 2022 00:14:53 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NGcVP5Kjbz15Mqx;
        Tue, 22 Nov 2022 16:14:21 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:14:51 +0800
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:14:50 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "Mike Christie" <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH] scsi:iscsi: Record session's startup mode in kernel
Date:   Tue, 22 Nov 2022 21:30:41 +0000
Message-ID: <20221122213040.4128105-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

There are 3 iscsi session's startup mode which are onboot, manual and
automatic. We can boot from iSCSI disks with help of dracut's service
in initrd, which would set node's startup mode to onboot, then create
iSCSI sessions.

While the configure of onboot mode is recorded in file of initrd stage
and would be lost when switch to rootfs. Even if we update the startup
mode to onboot by hand after switch to rootfs, it is possible that the
configure would be covered by another discovery command.

root would be mounted on iSCSI disks when boot from iSCSI disks, if the
sessions is logged out, the related disks would be removed, which would
cause the whole system halt.

So we need record session's start up mode in kernel and check this
mode before logout this session.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
 drivers/scsi/be2iscsi/be_iscsi.c         | 1 +
 drivers/scsi/bnx2i/bnx2i_iscsi.c         | 1 +
 drivers/scsi/cxgbi/libcxgbi.c            | 1 +
 drivers/scsi/iscsi_tcp.c                 | 1 +
 drivers/scsi/libiscsi.c                  | 5 +++++
 drivers/scsi/qedi/qedi_iscsi.c           | 1 +
 drivers/scsi/qla4xxx/ql4_os.c            | 1 +
 drivers/scsi/scsi_transport_iscsi.c      | 4 ++++
 include/scsi/iscsi_if.h                  | 1 +
 include/scsi/libiscsi.h                  | 1 +
 11 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 620ae5b2d80d..778c023673ea 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -947,6 +947,7 @@ static umode_t iser_attr_is_visible(int param_type, int param)
 		case ISCSI_PARAM_IFACE_NAME:
 		case ISCSI_PARAM_INITIATOR_NAME:
 		case ISCSI_PARAM_DISCOVERY_SESS:
+		case ISCSI_PARAM_NODE_STARTUP:
 			return S_IRUGO;
 		default:
 			return 0;
diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index 8aeaddc93b16..a21a4d9ab8b8 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -1401,6 +1401,7 @@ umode_t beiscsi_attr_is_visible(int param_type, int param)
 		case ISCSI_PARAM_LU_RESET_TMO:
 		case ISCSI_PARAM_IFACE_NAME:
 		case ISCSI_PARAM_INITIATOR_NAME:
+		case ISCSI_PARAM_NODE_STARTUP:
 			return S_IRUGO;
 		default:
 			return 0;
diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
index a3c800e04a2e..d1fb06d8a92e 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -2237,6 +2237,7 @@ static umode_t bnx2i_attr_is_visible(int param_type, int param)
 		case ISCSI_PARAM_BOOT_ROOT:
 		case ISCSI_PARAM_BOOT_NIC:
 		case ISCSI_PARAM_BOOT_TARGET:
+		case ISCSI_PARAM_NODE_STARTUP:
 			return S_IRUGO;
 		default:
 			return 0;
diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index af281e271f88..111b2ac78964 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -3063,6 +3063,7 @@ umode_t cxgbi_attr_is_visible(int param_type, int param)
 		case ISCSI_PARAM_TGT_RESET_TMO:
 		case ISCSI_PARAM_IFACE_NAME:
 		case ISCSI_PARAM_INITIATOR_NAME:
+		case ISCSI_PARAM_NODE_STARTUP:
 			return S_IRUGO;
 		default:
 			return 0;
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 5fb1f364e815..47a73fb3e4b0 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -1036,6 +1036,7 @@ static umode_t iscsi_sw_tcp_attr_is_visible(int param_type, int param)
 		case ISCSI_PARAM_TGT_RESET_TMO:
 		case ISCSI_PARAM_IFACE_NAME:
 		case ISCSI_PARAM_INITIATOR_NAME:
+		case ISCSI_PARAM_NODE_STARTUP:
 			return S_IRUGO;
 		default:
 			return 0;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index d95f4bcdeb2e..1f2b0a9a029e 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3576,6 +3576,8 @@ int iscsi_set_param(struct iscsi_cls_conn *cls_conn,
 		break;
 	case ISCSI_PARAM_LOCAL_IPADDR:
 		return iscsi_switch_str_param(&conn->local_ipaddr, buf);
+	case ISCSI_PARAM_NODE_STARTUP:
+		return iscsi_switch_str_param(&session->node_startup, buf);
 	default:
 		return -ENOSYS;
 	}
@@ -3712,6 +3714,9 @@ int iscsi_session_get_param(struct iscsi_cls_session *cls_session,
 		else
 			len = sysfs_emit(buf, "\n");
 		break;
+	case ISCSI_PARAM_NODE_STARTUP:
+		len = sysfs_emit(buf, "%s\n", session->node_startup);
+		break;
 	default:
 		return -ENOSYS;
 	}
diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 31ec429104e2..b947a5bca380 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -1437,6 +1437,7 @@ static umode_t qedi_attr_is_visible(int param_type, int param)
 		case ISCSI_PARAM_BOOT_ROOT:
 		case ISCSI_PARAM_BOOT_NIC:
 		case ISCSI_PARAM_BOOT_TARGET:
+		case ISCSI_PARAM_NODE_STARTUP:
 			return 0444;
 		default:
 			return 0;
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 9e849f6b0d0f..1cb7c6dbe9d3 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -468,6 +468,7 @@ static umode_t qla4_attr_is_visible(int param_type, int param)
 		case ISCSI_PARAM_DISCOVERY_PARENT_IDX:
 		case ISCSI_PARAM_DISCOVERY_PARENT_TYPE:
 		case ISCSI_PARAM_LOCAL_IPADDR:
+		case ISCSI_PARAM_NODE_STARTUP:
 			return S_IRUGO;
 		default:
 			return 0;
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index c3fe5ecfee59..39c14d2a8aad 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -4367,6 +4367,7 @@ iscsi_session_attr(tsid, ISCSI_PARAM_TSID, 0);
 iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
 iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
 iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
+iscsi_session_attr(node_startup, ISCSI_PARAM_NODE_STARTUP, 0);
 
 static ssize_t
 show_priv_session_state(struct device *dev, struct device_attribute *attr,
@@ -4488,6 +4489,7 @@ static struct attribute *iscsi_session_attrs[] = {
 	&dev_attr_sess_def_taskmgmt_tmo.attr,
 	&dev_attr_sess_discovery_parent_idx.attr,
 	&dev_attr_sess_discovery_parent_type.attr,
+	&dev_attr_sess_node_startup.attr,
 	NULL,
 };
 
@@ -4587,6 +4589,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
 		return S_IRUGO;
 	else if (attr == &dev_attr_priv_sess_target_id.attr)
 		return S_IRUGO;
+	else if (attr == &dev_attr_sess_node_startup.attr)
+		param = ISCSI_PARAM_NODE_STARTUP;
 	else {
 		WARN_ONCE(1, "Invalid session attr");
 		return 0;
diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
index 5225a23f2d0e..e46e69c1fd02 100644
--- a/include/scsi/iscsi_if.h
+++ b/include/scsi/iscsi_if.h
@@ -610,6 +610,7 @@ enum iscsi_param {
 	ISCSI_PARAM_DISCOVERY_PARENT_IDX,
 	ISCSI_PARAM_DISCOVERY_PARENT_TYPE,
 	ISCSI_PARAM_LOCAL_IPADDR,
+	ISCSI_PARAM_NODE_STARTUP,
 	/* must always be last */
 	ISCSI_PARAM_MAX,
 };
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 654cc3918c94..af4ccdcc1140 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -327,6 +327,7 @@ struct iscsi_session {
 	char			*boot_target;
 	char			*portal_type;
 	char			*discovery_parent_type;
+	char			*node_startup;
 	uint16_t		discovery_parent_idx;
 	uint16_t		def_taskmgmt_tmo;
 	uint16_t		tsid;
-- 
2.35.3

