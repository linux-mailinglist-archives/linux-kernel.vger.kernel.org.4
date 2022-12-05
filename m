Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84EC642891
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiLEMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiLEMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:36:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9D617E07;
        Mon,  5 Dec 2022 04:36:11 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQjbj2QvSzqSsj;
        Mon,  5 Dec 2022 20:32:01 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 20:36:08 +0800
Message-ID: <105fcfc2-2518-cf61-c17c-9848b32da8fd@huawei.com>
Date:   Mon, 5 Dec 2022 20:36:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20221126010752.231917-1-haowenchao@huawei.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <20221126010752.231917-1-haowenchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml100024.china.huawei.com (7.185.36.115) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/26 9:07, Wenchao Hao wrote:
> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
> for multiple times which should be fixed.
> 
> This patch introduce target_state in iscsi_cls_session to make
> sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.
> 
> But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
> Report unbind session event when the target has been removed"). The issue
> is iscsid died for any reason after it send unbind session to kernel, once
> iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.
> 
> Now kernel think iscsi_cls_session has already sent an
> ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
> would cause userspace unable to logout. Actually the session is in
> invalid state(it's target_id is INVALID), iscsid should not sync this
> session in it's restart.
> 
> So we need to check session's target state during iscsid restart,
> if session is in unbound state, do not sync this session and perform
> session teardown. It's reasonable because once a session is unbound, we
> can not recover it any more(mainly because it's target id is INVALID)
> 
> V7:
> - Define target state to string map and refer this map directly
> - Cleanup __iscsi_unbind_session, drop check for session's
>   target_id == ISCSI_MAX_TARGET since it can be handled by target_state
> 
> V6:
> - Set target state to ALLOCATED in iscsi_add_session
> - Rename state BOUND to SCANNED
> - Make iscsi_session_target_state_name() more efficient
> 
> V5:
> - Add ISCSI_SESSION_TARGET_ALLOCATED to indicate the session's
>   target has been allocated but not scanned yet. We should
>   sync this session and scan this session when iscsid restarted.
> 
> V4:
> - Move debug print out of spinlock critical section
> 
> V3:
> - Make target bind state to a state kind rather than a bool.
> 
> V2:
> - Using target_unbound rather than state to indicate session has been
>   unbound
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 47 ++++++++++++++++++++++++++---
>  include/scsi/scsi_transport_iscsi.h |  9 ++++++
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index cd3db9684e52..812578c20fe5 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -1676,6 +1676,13 @@ static const char *iscsi_session_state_name(int state)
>  	return name;
>  }
>  
> +static char *iscsi_session_target_state_name[] = {
> +	[ISCSI_SESSION_TARGET_UNBOUND]   = "UNBOUND",
> +	[ISCSI_SESSION_TARGET_ALLOCATED] = "ALLOCATED",
> +	[ISCSI_SESSION_TARGET_SCANNED]   = "SCANNED",
> +	[ISCSI_SESSION_TARGET_UNBINDING] = "UNBINDING",
> +};
> +
>  int iscsi_session_chkready(struct iscsi_cls_session *session)
>  {
>  	int err;
> @@ -1785,9 +1792,13 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
>  		if ((scan_data->channel == SCAN_WILD_CARD ||
>  		     scan_data->channel == 0) &&
>  		    (scan_data->id == SCAN_WILD_CARD ||
> -		     scan_data->id == id))
> +		     scan_data->id == id)) {
>  			scsi_scan_target(&session->dev, 0, id,
>  					 scan_data->lun, scan_data->rescan);
> +			spin_lock_irqsave(&session->lock, flags);
> +			session->target_state = ISCSI_SESSION_TARGET_SCANNED;
> +			spin_unlock_irqrestore(&session->lock, flags);
> +		}
>  	}
>  
>  user_scan_exit:
> @@ -1960,31 +1971,41 @@ static void __iscsi_unbind_session(struct work_struct *work)
>  	struct iscsi_cls_host *ihost = shost->shost_data;
>  	unsigned long flags;
>  	unsigned int target_id;
> +	bool remove_target = true;
>  
>  	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>  
>  	/* Prevent new scans and make sure scanning is not in progress */
>  	mutex_lock(&ihost->mutex);
>  	spin_lock_irqsave(&session->lock, flags);
> -	if (session->target_id == ISCSI_MAX_TARGET) {
> +	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
> +		remove_target = false;
> +	} else if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
>  		spin_unlock_irqrestore(&session->lock, flags);
>  		mutex_unlock(&ihost->mutex);
> -		goto unbind_session_exit;
> +		ISCSI_DBG_TRANS_SESSION(session,
> +			"Skipping target unbinding: Session is unbound/unbinding.\n");
> +		return;
>  	}
>  
> +	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
>  	target_id = session->target_id;
>  	session->target_id = ISCSI_MAX_TARGET;
>  	spin_unlock_irqrestore(&session->lock, flags);
>  	mutex_unlock(&ihost->mutex);
>  
> -	scsi_remove_target(&session->dev);
> +	if (remove_target)
> +		scsi_remove_target(&session->dev);
>  
>  	if (session->ida_used)
>  		ida_free(&iscsi_sess_ida, target_id);
>  
> -unbind_session_exit:
>  	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
>  	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
> +
> +	spin_lock_irqsave(&session->lock, flags);
> +	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
> +	spin_unlock_irqrestore(&session->lock, flags);
>  }
>  
>  static void __iscsi_destroy_session(struct work_struct *work)
> @@ -2061,6 +2082,9 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
>  		session->ida_used = true;
>  	} else
>  		session->target_id = target_id;
> +	spin_lock_irqsave(&session->lock, flags);
> +	session->target_state = ISCSI_SESSION_TARGET_ALLOCATED;
> +	spin_unlock_irqrestore(&session->lock, flags);
>  
>  	dev_set_name(&session->dev, "session%u", session->sid);
>  	err = device_add(&session->dev);
> @@ -4368,6 +4392,16 @@ iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
>  iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
>  iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
>  
> +static ssize_t
> +show_priv_session_target_state(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct iscsi_cls_session *session = iscsi_dev_to_session(dev->parent);
> +	return sysfs_emit(buf, "%s\n",
> +			iscsi_session_target_state_name[session->target_state]);
> +}
> +static ISCSI_CLASS_ATTR(priv_sess, target_state, S_IRUGO,
> +			show_priv_session_target_state, NULL);
>  static ssize_t
>  show_priv_session_state(struct device *dev, struct device_attribute *attr,
>  			char *buf)
> @@ -4470,6 +4504,7 @@ static struct attribute *iscsi_session_attrs[] = {
>  	&dev_attr_sess_boot_target.attr,
>  	&dev_attr_priv_sess_recovery_tmo.attr,
>  	&dev_attr_priv_sess_state.attr,
> +	&dev_attr_priv_sess_target_state.attr,
>  	&dev_attr_priv_sess_creator.attr,
>  	&dev_attr_sess_chap_out_idx.attr,
>  	&dev_attr_sess_chap_in_idx.attr,
> @@ -4583,6 +4618,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
>  		return S_IRUGO | S_IWUSR;
>  	else if (attr == &dev_attr_priv_sess_state.attr)
>  		return S_IRUGO;
> +	else if (attr == &dev_attr_priv_sess_target_state.attr)
> +		return S_IRUGO;
>  	else if (attr == &dev_attr_priv_sess_creator.attr)
>  		return S_IRUGO;
>  	else if (attr == &dev_attr_priv_sess_target_id.attr)
> diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
> index cab52b0f11d0..34c03707fb6e 100644
> --- a/include/scsi/scsi_transport_iscsi.h
> +++ b/include/scsi/scsi_transport_iscsi.h
> @@ -236,6 +236,14 @@ enum {
>  	ISCSI_SESSION_FREE,
>  };
>  
> +enum {
> +	ISCSI_SESSION_TARGET_UNBOUND,
> +	ISCSI_SESSION_TARGET_ALLOCATED,
> +	ISCSI_SESSION_TARGET_SCANNED,
> +	ISCSI_SESSION_TARGET_UNBINDING,
> +	ISCSI_SESSION_TARGET_MAX,
> +};
> +
>  #define ISCSI_MAX_TARGET -1
>  
>  struct iscsi_cls_session {
> @@ -264,6 +272,7 @@ struct iscsi_cls_session {
>  	 */
>  	pid_t creator;
>  	int state;
> +	int target_state;			/* session target bind state */
>  	int sid;				/* session id */
>  	void *dd_data;				/* LLD private data */
>  	struct device dev;	/* sysfs transport/container device */

ping...
