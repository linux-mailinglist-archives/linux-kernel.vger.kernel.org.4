Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8B6335B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiKVHMI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Nov 2022 02:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:12:06 -0500
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 23:12:03 PST
Received: from mx3.uni-regensburg.de (mx3.uni-regensburg.de [194.94.157.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691E30572;
        Mon, 21 Nov 2022 23:12:03 -0800 (PST)
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 499246000052;
        Tue, 22 Nov 2022 08:02:41 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 175566000051;
        Tue, 22 Nov 2022 08:02:41 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Tue, 22 Nov 2022 08:02:41 +0100
Message-Id: <637C740F020000A10004FEA6@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.1 
Date:   Tue, 22 Nov 2022 08:02:39 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "open-iscsi" <open-iscsi@googlegroups.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        "Chris Leech" <cleech@redhat.com>, "Lee Duncan" <lduncan@suse.com>
Cc:     <linfeilong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Antw: [EXT] Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi
 session unbind event sent to userspace
References: <20221108014414.3510940-1-haowenchao@huawei.com>
 <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com>
 <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
In-Reply-To: <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> "'Wenchao Hao' via open-iscsi" <open-iscsi@googlegroups.com> schrieb am
21.11.2022 um 15:17 in Nachricht
<89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>:
> On 2022/11/9 11:47, Mike Christie wrote:
>> On 11/7/22 7:44 PM, Wenchao Hao wrote:
>>> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
>>> for multiple times which should be fixed.
>>>  
>>> +static char *iscsi_session_target_state_names[] = {
>>> +	"UNBOUND",
>>> +	"ALLOCATED",
>>> +	"SCANNED",
>>> +	"UNBINDING",
>>> +};
>> 
>> I think maybe Lee meant you to do something like:
>> 
>> static int iscsi_target_state_to_name[] = {
>> 	[ISCSI_SESSION_TARGET_UNBOUND] = "UNBOUND",
>> 	[ISCSI_SESSION_TARGET_ALLOCATED] = "ALLOCATED",
>> 	.....
>> 
>> 
> 
> Define array as following and remove previous helper function:
> 
> static char *iscsi_session_target_state_name[] = {
>        [ISCSI_SESSION_TARGET_UNBOUND]   = "UNBOUND",
>        [ISCSI_SESSION_TARGET_ALLOCATED] = "ALLOCATED",
>        [ISCSI_SESSION_TARGET_SCANNED]   = "SCANNED",
>        [ISCSI_SESSION_TARGET_UNBINDING] = "UNBINDING",
> };
> 
> Reference the array directly:

Actually I think with a modern optimizing compiler there should be little difference in the code created.

> 
> static ssize_t
> show_priv_session_target_state(struct device *dev, struct device_attribute 
> *attr,
>                        char *buf)
> {
>        struct iscsi_cls_session *session = iscsi_dev_to_session(dev->parent);
>        return sysfs_emit(buf, "%s\n",
>                        
> iscsi_session_target_state_name[session->target_state]);
> }
> 
>>> +	spin_lock_irqsave(&session->lock, flags);
>>> +	if (session->target_state == ISCSI_SESSION_TARGET_ALLOCATED) {
>>> +		spin_unlock_irqrestore(&session->lock, flags);
>>> +		if (session->ida_used)
>>> +			ida_free(&iscsi_sess_ida, session->target_id);
>>> +		ISCSI_DBG_TRANS_SESSION(session, "Donot unbind sesison: allocated\n");
>> 
>> Could you change the error message to "Skipping target unbinding: Session 
> not yet scanned.\n"
>> 
>>> +		goto unbind_session_exit;
>>> +	}
>> 
>> Just add a newline/return here.
> 
> Actually we should skip unbind this session if call into 
> __iscsi_unbind_session() with target state
> is ALLOCATED. So I removed the check, and check only one condition in 
> __iscsi_unbind_session(): if the
> target state is SCANNED.
> 
>> 
>> I think you want to move both state checks to after the we take the host 
> lock and
>> session lock after the line above. You don't have to take the lock multiple 
> times
>> and we can drop the target_id == ISCSI_MAX_TARGET since it would then rely 
> on the
>> state checks (I left out the ISCSI_DBG_TRANS_SESSION because I'm lazy):
>> 
>> 	bool remove_target = false;
>> .....
>> 
>> 
> I think it's not necessary to add a flag remove_target, here is my changes 
> for function __iscsi_unbind_session:
> 
> @@ -1966,23 +1977,28 @@ static void __iscsi_unbind_session(struct 
> work_struct *work)
>         /* Prevent new scans and make sure scanning is not in progress */
>         mutex_lock(&ihost->mutex);
>         spin_lock_irqsave(&session->lock, flags);
> -       if (session->target_id == ISCSI_MAX_TARGET) {
> +       if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
>                 spin_unlock_irqrestore(&session->lock, flags);
>                 mutex_unlock(&ihost->mutex);
> -               goto unbind_session_exit;
> +               ISCSI_DBG_TRANS_SESSION(session, "Skipping target unbinding: 
> Session is %s.\n",
> +                                       
> iscsi_session_target_state_name[session->target_state]);
> +               return;
>         }
> -
>         target_id = session->target_id;
>         session->target_id = ISCSI_MAX_TARGET;
> +       session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
>         spin_unlock_irqrestore(&session->lock, flags);
>         mutex_unlock(&ihost->mutex);
>  
>         scsi_remove_target(&session->dev);
>  
> +       spin_lock_irqsave(&session->lock, flags);
> +       session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
> +       spin_unlock_irqrestore(&session->lock, flags);
> +
>         if (session->ida_used)
>                 ida_free(&iscsi_sess_ida, target_id);
>  
> -unbind_session_exit:
>         iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
>         ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
>  }
> 
> And the function looks like following after change:
> 
> static void __iscsi_unbind_session(struct work_struct *work)
> {
> 	struct iscsi_cls_session *session =
> 			container_of(work, struct iscsi_cls_session,
> 				     unbind_work);
> 	struct Scsi_Host *shost = iscsi_session_to_shost(session);
> 	struct iscsi_cls_host *ihost = shost->shost_data;
> 	unsigned long flags;
> 	unsigned int target_id;
> 
> 	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
> 
> 	/* Prevent new scans and make sure scanning is not in progress */
> 	mutex_lock(&ihost->mutex);
> 	spin_lock_irqsave(&session->lock, flags);
> 	if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
> 		spin_unlock_irqrestore(&session->lock, flags);
> 		mutex_unlock(&ihost->mutex);
> 		ISCSI_DBG_TRANS_SESSION(session, "Skipping target unbinding: Session is 
> %s.\n",
> 					iscsi_session_target_state_name[session->target_state]);
> 		return;
> 	}
> 	target_id = session->target_id;
> 	session->target_id = ISCSI_MAX_TARGET;
> 	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
> 	spin_unlock_irqrestore(&session->lock, flags);
> 	mutex_unlock(&ihost->mutex);
> 
> 	scsi_remove_target(&session->dev);
> 
> 	spin_lock_irqsave(&session->lock, flags);
> 	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
> 	spin_unlock_irqrestore(&session->lock, flags);
> 
> 	if (session->ida_used)
> 		ida_free(&iscsi_sess_ida, target_id);
> 
> 	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
> 	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
> }
> 
> 
> 
> -- 
> You received this message because you are subscribed to the Google Groups 
> "open-iscsi" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
> email to open-iscsi+unsubscribe@googlegroups.com.
> To view this discussion on the web visit 
> https://groups.google.com/d/msgid/open-iscsi/89692b2b-90f7-e8e8-fa77-f14dbe99 
> 6b72%40huawei.com.



