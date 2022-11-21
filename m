Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F392B632569
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKUOSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiKUOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:17:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA401110;
        Mon, 21 Nov 2022 06:17:26 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NG8bD1WLkz15Mnk;
        Mon, 21 Nov 2022 22:16:56 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 22:17:24 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 22:17:23 +0800
Message-ID: <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
Date:   Mon, 21 Nov 2022 22:17:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
References: <20221108014414.3510940-1-haowenchao@huawei.com>
 <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/9 11:47, Mike Christie wrote:
> On 11/7/22 7:44 PM, Wenchao Hao wrote:
>> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
>> for multiple times which should be fixed.
>>  
>> +static char *iscsi_session_target_state_names[] = {
>> +	"UNBOUND",
>> +	"ALLOCATED",
>> +	"SCANNED",
>> +	"UNBINDING",
>> +};
> 
> I think maybe Lee meant you to do something like:
> 
> static int iscsi_target_state_to_name[] = {
> 	[ISCSI_SESSION_TARGET_UNBOUND] = "UNBOUND",
> 	[ISCSI_SESSION_TARGET_ALLOCATED] = "ALLOCATED",
> 	.....
> 
> 

Define array as following and remove previous helper function:

static char *iscsi_session_target_state_name[] = {
       [ISCSI_SESSION_TARGET_UNBOUND]   = "UNBOUND",
       [ISCSI_SESSION_TARGET_ALLOCATED] = "ALLOCATED",
       [ISCSI_SESSION_TARGET_SCANNED]   = "SCANNED",
       [ISCSI_SESSION_TARGET_UNBINDING] = "UNBINDING",
};

Reference the array directly:

static ssize_t
show_priv_session_target_state(struct device *dev, struct device_attribute *attr,
                       char *buf)
{
       struct iscsi_cls_session *session = iscsi_dev_to_session(dev->parent);
       return sysfs_emit(buf, "%s\n",
                       iscsi_session_target_state_name[session->target_state]);
}

>> +	spin_lock_irqsave(&session->lock, flags);
>> +	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
>> +		spin_unlock_irqrestore(&session->lock, flags);
>> +		if (session->ida_used)
>> +			ida_free(&iscsi_sess_ida, session->target_id);
>> +		ISCSI_DBG_TRANS_SESSION(session, "Donot unbind sesison: allocated\n");
> 
> Could you change the error message to "Skipping target unbinding: Session not yet scanned.\n"
> 
>> +		goto unbind_session_exit;
>> +	}
> 
> Just add a newline/return here.

Actually we should skip unbind this session if call into __iscsi_unbind_session() with target state
is ALLOCATED. So I removed the check, and check only one condition in __iscsi_unbind_session(): if the
target state is SCANNED.

> 
> I think you want to move both state checks to after the we take the host lock and
> session lock after the line above. You don't have to take the lock multiple times
> and we can drop the target_id == ISCSI_MAX_TARGET since it would then rely on the
> state checks (I left out the ISCSI_DBG_TRANS_SESSION because I'm lazy):
> 
> 	bool remove_target = false;
> .....
> 
> 
I think it's not necessary to add a flag remove_target, here is my changes for function __iscsi_unbind_session:

@@ -1966,23 +1977,28 @@ static void __iscsi_unbind_session(struct work_struct *work)
        /* Prevent new scans and make sure scanning is not in progress */
        mutex_lock(&ihost->mutex);
        spin_lock_irqsave(&session->lock, flags);
-       if (session->target_id == ISCSI_MAX_TARGET) {
+       if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
                spin_unlock_irqrestore(&session->lock, flags);
                mutex_unlock(&ihost->mutex);
-               goto unbind_session_exit;
+               ISCSI_DBG_TRANS_SESSION(session, "Skipping target unbinding: Session is %s.\n",
+                                       iscsi_session_target_state_name[session->target_state]);
+               return;
        }
-
        target_id = session->target_id;
        session->target_id = ISCSI_MAX_TARGET;
+       session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
        spin_unlock_irqrestore(&session->lock, flags);
        mutex_unlock(&ihost->mutex);
 
        scsi_remove_target(&session->dev);
 
+       spin_lock_irqsave(&session->lock, flags);
+       session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
+       spin_unlock_irqrestore(&session->lock, flags);
+
        if (session->ida_used)
                ida_free(&iscsi_sess_ida, target_id);
 
-unbind_session_exit:
        iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
        ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
 }

And the function looks like following after change:

static void __iscsi_unbind_session(struct work_struct *work)
{
	struct iscsi_cls_session *session =
			container_of(work, struct iscsi_cls_session,
				     unbind_work);
	struct Scsi_Host *shost = iscsi_session_to_shost(session);
	struct iscsi_cls_host *ihost = shost->shost_data;
	unsigned long flags;
	unsigned int target_id;

	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");

	/* Prevent new scans and make sure scanning is not in progress */
	mutex_lock(&ihost->mutex);
	spin_lock_irqsave(&session->lock, flags);
	if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
		spin_unlock_irqrestore(&session->lock, flags);
		mutex_unlock(&ihost->mutex);
		ISCSI_DBG_TRANS_SESSION(session, "Skipping target unbinding: Session is %s.\n",
					iscsi_session_target_state_name[session->target_state]);
		return;
	}
	target_id = session->target_id;
	session->target_id = ISCSI_MAX_TARGET;
	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
	spin_unlock_irqrestore(&session->lock, flags);
	mutex_unlock(&ihost->mutex);

	scsi_remove_target(&session->dev);

	spin_lock_irqsave(&session->lock, flags);
	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
	spin_unlock_irqrestore(&session->lock, flags);

	if (session->ida_used)
		ida_free(&iscsi_sess_ida, target_id);

	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
}



