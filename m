Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3FB636194
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiKWOXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiKWOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:22:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B07AF5F;
        Wed, 23 Nov 2022 06:21:51 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHNbD276FzHw6Z;
        Wed, 23 Nov 2022 22:21:12 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 22:21:49 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 22:21:48 +0800
Message-ID: <3a2ba8f0-3a86-36cf-cafd-969298594830@huawei.com>
Date:   Wed, 23 Nov 2022 22:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Wenchao Hao <haowenchao22@gmail.com>
CC:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
References: <20221108014414.3510940-1-haowenchao@huawei.com>
 <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com>
 <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
 <418c7f6f-0bc3-45bb-2abf-e866df6f4b62@oracle.com>
 <CAOptpSO6=sUPUwgj1og8088djiNA=Bw9um0p024L=0Gb=-ja5w@mail.gmail.com>
 <856ccad2-19a4-32b4-b41f-5a230a55ee30@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <856ccad2-19a4-32b4-b41f-5a230a55ee30@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500005.china.huawei.com (7.185.36.59) To
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

On 2022/11/23 2:15, Mike Christie wrote:
> On 11/22/22 11:29 AM, Wenchao Hao wrote:
>> On Wed, Nov 23, 2022 at 1:04 AM Mike Christie
>> <michael.christie@oracle.com> wrote:
>>>
>>> On 11/21/22 8:17 AM, Wenchao Hao wrote:
>>>> And the function looks like following after change:
>>>>
>>>> static void __iscsi_unbind_session(struct work_struct *work)
>>>> {
>>>>       struct iscsi_cls_session *session =
>>>>                       container_of(work, struct iscsi_cls_session,
>>>>                                    unbind_work);
>>>>       struct Scsi_Host *shost = iscsi_session_to_shost(session);
>>>>       struct iscsi_cls_host *ihost = shost->shost_data;
>>>>       unsigned long flags;
>>>>       unsigned int target_id;
>>>>
>>>>       ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>>>>
>>>>       /* Prevent new scans and make sure scanning is not in progress */
>>>>       mutex_lock(&ihost->mutex);
>>>>       spin_lock_irqsave(&session->lock, flags);
>>>>       if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
>>>
>>> What was the reason for not checking for ALLOCATED and freeing the ida
>>> in that case?
>>>
>>
>> target_state would be in "ALLOCATED" state if iscsid died after add
>> session successfully.
>> When iscsid restarted, if the session's target_state is "ALLOCATED",
>> it should scan
>> the session and the target_state would switch to "SCANNED".
>>
>> So I think we would not call in __iscsi_unbind_session() with
>> session's target_state
>> is ALLOCATED.
> 
> Makes sense for the normal case.
> 
> The only issue is when __iscsi_unbind_session is called via
> iscsi_remove_session for the cases where userspace didn't do
> the  UNBIND event. Some tools don't do unbind or open-iscsi
> sometimes doesn't if the session is down. We will leak the ida,
> so you need some code to handle that.
> 
> .

Sorry, I did not take this condition in consideration. I would change
the __iscsi_unbind_session as following:

1. do not check if target_id is ISCSI_MAX_TARGET
2. define remove_target and default set to true, if target_state is ALLOCATED, then set
   it to false and continue the unbind flow; else if target_state not SCANNED, just return.
3. set target_state to ISCSI_SESSION_TARGET_UNBOUND after is sent to avoid potential race condition.

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index cd3db9684e52..9264c75ad9ea 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1960,31 +1960,40 @@ static void __iscsi_unbind_session(struct work_struct *work)
        struct iscsi_cls_host *ihost = shost->shost_data;
        unsigned long flags;
        unsigned int target_id;
+       bool remove_target = true;
 
        ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
 
        /* Prevent new scans and make sure scanning is not in progress */
        mutex_lock(&ihost->mutex);
        spin_lock_irqsave(&session->lock, flags);
-       if (session->target_id == ISCSI_MAX_TARGET) {
+       if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
+               remove_target = false;
+       } else if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
                spin_unlock_irqrestore(&session->lock, flags);
                mutex_unlock(&ihost->mutex);
-               goto unbind_session_exit;
+               ISCSI_DBG_TRANS_SESSION(session, "Skipping target unbinding: Session is unbound/unbinding.\n");
+               return;
        }
 
+       session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
        target_id = session->target_id;
        session->target_id = ISCSI_MAX_TARGET;
        spin_unlock_irqrestore(&session->lock, flags);
        mutex_unlock(&ihost->mutex);
 
-       scsi_remove_target(&session->dev);
+       if (remove_target)
+               scsi_remove_target(&session->dev);
 
        if (session->ida_used)
                ida_free(&iscsi_sess_ida, target_id);
 
-unbind_session_exit:
        iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
        ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
+
+       spin_lock_irqsave(&session->lock, flags);
+       session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
+       spin_unlock_irqrestore(&session->lock, flags);
 }

And the function would be:

static void __iscsi_unbind_session(struct work_struct *work)
{
	struct iscsi_cls_session *session =
			container_of(work, struct iscsi_cls_session,
				     unbind_work);
	struct Scsi_Host *shost = iscsi_session_to_shost(session);
	struct iscsi_cls_host *ihost = shost->shost_data;
	unsigned long flags;
	unsigned int target_id;
	bool remove_target = true;

	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");

	/* Prevent new scans and make sure scanning is not in progress */
	mutex_lock(&ihost->mutex);
	spin_lock_irqsave(&session->lock, flags);
	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
		remove_target = false;
	} else if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
		spin_unlock_irqrestore(&session->lock, flags);
		mutex_unlock(&ihost->mutex);
		ISCSI_DBG_TRANS_SESSION(session, "Skipping target unbinding: Session is unbound/unbinding.\n");
		return;
	}

	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
	target_id = session->target_id;
	session->target_id = ISCSI_MAX_TARGET;
	spin_unlock_irqrestore(&session->lock, flags);
	mutex_unlock(&ihost->mutex);

	if (remove_target)
		scsi_remove_target(&session->dev);

	if (session->ida_used)
		ida_free(&iscsi_sess_ida, target_id);

	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");

	spin_lock_irqsave(&session->lock, flags);
	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
	spin_unlock_irqrestore(&session->lock, flags);
}

