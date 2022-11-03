Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603856174C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKCDJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKCDJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:09:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F189DF76;
        Wed,  2 Nov 2022 20:09:10 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N2pcw3CKBz15MJq;
        Thu,  3 Nov 2022 11:09:04 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 11:09:06 +0800
Subject: Re: [PATCH RFC v3 21/22] scsi: libsas: Queue internal abort commands
 as requests
To:     John Garry <john.g.garry@oracle.com>,
        John Garry <john.garry@huawei.com>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <hare@suse.de>, <bvanassche@acm.org>, <hch@lst.de>,
        <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-22-git-send-email-john.garry@huawei.com>
 <0cbc86ea-09c9-2654-a795-9230e4b00a1e@hisilicon.com>
 <152bcd77-bcd6-ea75-0572-01e0f16902aa@oracle.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <3179b779-ef99-cec0-8524-76f1b25fb7f1@hisilicon.com>
Date:   Thu, 3 Nov 2022 11:09:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <152bcd77-bcd6-ea75-0572-01e0f16902aa@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/2 18:04, John Garry 写道:
> On 29/10/2022 02:15, chenxiang (M) wrote:
>> Hi John,
>>
>> For internal abort commands, it allocates and deliver requests 
>> through sdev->request_queue.
>>
>> Is it possible that we still need to send internal abort commands 
>> even if sdev is freed?
>>
>> I  notices that in sas_destruct_devices, it calls sas_rphy_delete() 
>> to remove target, and then call i->dft->lldd_dev_gone()
>>
>> which will call internal abort commands.
>
> Good question. I did not properly check the removal path and, indeed, 
> the sdev would be gone when we call lldd_dev_gone -> 
> internal_task_abort_dev, so that should fail to execute.
>
> However I do wonder why we really need to call internal_task_abort_dev 
> in the lldd_dev_gone callback. At the point lldd_dev_gone is called 
> all IO should be complete - indeed, it is now accounted for as 
> requests associated with the sdev. If it is really required to be 
> called (HW requirement?) then maybe it could be relocated to 
> sdev/starget teardown callback.

Call internal abort in lldd_dev_gone callback comes from the commit 
(40f2702b57eb16ef "scsi: hisi_sas: add internal abort in 
hisi_sas_dev_gone()"), and it seems not descript why adding it.
But those internal IOs are sent to SAS controller to do something in it, 
and it is not depend on scsi device. Like SMP IO, it allocates 
scsi_device for expander, why not allocate a scsi_device for controller?

>
> Thanks,
> John
>
>>
>>
>>
>> 在 2022/10/25 18:18, John Garry 写道:
>>> Like what we did for SMP commands, send internal abort commands through
>>> the block layer.
>>>
>>> At this point we can delete special handling in sas_task_abort() for 
>>> SAS
>>> "internal" commands, as every slow task now has a request associated.
>>>
>>> Function sas_task_internal_timedout() is no longer referenced, so 
>>> delete
>>> it.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/scsi/hisi_sas/hisi_sas_main.c | 36 +++++++++----------
>>>   drivers/scsi/libsas/sas_expander.c    |  2 +-
>>>   drivers/scsi/libsas/sas_init.c        | 12 +++++--
>>>   drivers/scsi/libsas/sas_internal.h    |  3 +-
>>>   drivers/scsi/libsas/sas_scsi_host.c   | 52 
>>> ++++++---------------------
>>>   include/scsi/libsas.h                 |  1 -
>>>   6 files changed, 38 insertions(+), 68 deletions(-)
>>>
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c 
>>> b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> index fe2752d24fe8..65475775c844 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> @@ -465,7 +465,7 @@ static int hisi_sas_queue_command(struct 
>>> sas_task *task, gfp_t gfp_flags)
>>>       struct hisi_sas_port *port;
>>>       struct hisi_hba *hisi_hba;
>>>       struct hisi_sas_slot *slot;
>>> -    struct request *rq = NULL;
>>> +    struct request *rq;
>>>       struct device *dev;
>>>       int rc;
>>> @@ -485,6 +485,21 @@ static int hisi_sas_queue_command(struct 
>>> sas_task *task, gfp_t gfp_flags)
>>>       hisi_hba = dev_to_hisi_hba(device);
>>>       dev = hisi_hba->dev;
>>> +    rq = sas_task_find_rq(task);
>>> +    if (rq) {
>>> +        unsigned int dq_index;
>>> +        u32 blk_tag;
>>> +
>>> +        blk_tag = blk_mq_unique_tag(rq);
>>> +        dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
>>> +        dq = &hisi_hba->dq[dq_index];
>>> +    } else {
>>> +        struct Scsi_Host *shost = hisi_hba->shost;
>>> +        struct blk_mq_queue_map *qmap = 
>>> &shost->tag_set.map[HCTX_TYPE_DEFAULT];
>>> +        int queue = qmap->mq_map[raw_smp_processor_id()];
>>> +
>>> +        dq = &hisi_hba->dq[queue];
>>> +    }
>>>       switch (task->task_proto) {
>>>       case SAS_PROTOCOL_SSP:
>>> @@ -519,22 +534,6 @@ static int hisi_sas_queue_command(struct 
>>> sas_task *task, gfp_t gfp_flags)
>>>                   return -ECOMM;
>>>           }
>>> -
>>> -        rq = sas_task_find_rq(task);
>>> -        if (rq) {
>>> -            unsigned int dq_index;
>>> -            u32 blk_tag;
>>> -
>>> -            blk_tag = blk_mq_unique_tag(rq);
>>> -            dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
>>> -            dq = &hisi_hba->dq[dq_index];
>>> -        } else {
>>> -            struct Scsi_Host *shost = hisi_hba->shost;
>>> -            struct blk_mq_queue_map *qmap = 
>>> &shost->tag_set.map[HCTX_TYPE_DEFAULT];
>>> -            int queue = qmap->mq_map[raw_smp_processor_id()];
>>> -
>>> -            dq = &hisi_hba->dq[queue];
>>> -        }
>>>           break;
>>>       case SAS_PROTOCOL_INTERNAL_ABORT:
>>>           if (!hisi_hba->hw->prep_abort)
>>> @@ -543,13 +542,10 @@ static int hisi_sas_queue_command(struct 
>>> sas_task *task, gfp_t gfp_flags)
>>>           if (test_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags))
>>>               return -EIO;
>>> -        hisi_hba = dev_to_hisi_hba(device);
>>> -
>>>           if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, 
>>> &hisi_hba->flags)))
>>>               return -EINVAL;
>>>           port = to_hisi_sas_port(sas_port);
>>> -        dq = &hisi_hba->dq[task->abort_task.qid];
>>>           break;
>>>       default:
>>>           dev_err(hisi_hba->dev, "task prep: unknown/unsupported 
>>> proto (0x%x)\n",
>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>> b/drivers/scsi/libsas/sas_expander.c
>>> index cc41127ea5cc..e852f1565fe7 100644
>>> --- a/drivers/scsi/libsas/sas_expander.c
>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>> @@ -50,7 +50,7 @@ static int smp_execute_task_sg(struct 
>>> domain_device *dev,
>>>               break;
>>>           }
>>> -        task = sas_alloc_slow_task_rq(dev, GFP_KERNEL);
>>> +        task = sas_alloc_slow_task_rq(dev, GFP_KERNEL, -1U);
>>>           if (!task) {
>>>               res = -ENOMEM;
>>>               break;
>>> diff --git a/drivers/scsi/libsas/sas_init.c 
>>> b/drivers/scsi/libsas/sas_init.c
>>> index 5f9e71a54799..c3f602bd2c4c 100644
>>> --- a/drivers/scsi/libsas/sas_init.c
>>> +++ b/drivers/scsi/libsas/sas_init.c
>>> @@ -56,7 +56,7 @@ struct sas_task *sas_alloc_slow_task(gfp_t flags)
>>>       return task;
>>>   }
>>> -struct sas_task *sas_alloc_slow_task_rq(struct domain_device 
>>> *device, gfp_t flags)
>>> +struct sas_task *sas_alloc_slow_task_rq(struct domain_device 
>>> *device, gfp_t flags, unsigned int qid)
>>>   {
>>>       struct sas_ha_struct *sas_ha = device->port->ha;
>>>       struct Scsi_Host *shost = sas_ha->core.shost;
>>> @@ -86,8 +86,14 @@ struct sas_task *sas_alloc_slow_task_rq(struct 
>>> domain_device *device, gfp_t flag
>>>       task->dev = device;
>>>       task->task_done = sas_task_complete_internal;
>>> -    rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
>>> -                BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
>>> +    if (qid == -1U) {
>>> +        rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
>>> +                    BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
>>> +    } else {
>>> +        rq = scsi_alloc_request_hwq(sdev->request_queue, 
>>> REQ_OP_DRV_IN,
>>> +                    BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
>>> +                    qid);
>>> +    }
>>>       if (IS_ERR(rq)) {
>>>           sas_free_task(task);
>>>           return NULL;
>>> diff --git a/drivers/scsi/libsas/sas_internal.h 
>>> b/drivers/scsi/libsas/sas_internal.h
>>> index 9b58948c57c2..af4a4bf88830 100644
>>> --- a/drivers/scsi/libsas/sas_internal.h
>>> +++ b/drivers/scsi/libsas/sas_internal.h
>>> @@ -54,7 +54,8 @@ void sas_free_event(struct asd_sas_event *event);
>>>   struct sas_task *sas_alloc_task(gfp_t flags);
>>>   struct sas_task *sas_alloc_slow_task(gfp_t flags);
>>> -struct sas_task *sas_alloc_slow_task_rq(struct domain_device 
>>> *device, gfp_t flags);
>>> +struct sas_task *sas_alloc_slow_task_rq(struct domain_device 
>>> *device, gfp_t flags,
>>> +                      unsigned int qid);
>>>   void sas_free_task(struct sas_task *task);
>>>   int  sas_register_ports(struct sas_ha_struct *sas_ha);
>>> diff --git a/drivers/scsi/libsas/sas_scsi_host.c 
>>> b/drivers/scsi/libsas/sas_scsi_host.c
>>> index e6ee8dd56a45..a93e019a7dbf 100644
>>> --- a/drivers/scsi/libsas/sas_scsi_host.c
>>> +++ b/drivers/scsi/libsas/sas_scsi_host.c
>>> @@ -920,23 +920,6 @@ void sas_task_complete_internal(struct sas_task 
>>> *task)
>>>       scsi_done(scmd);
>>>   }
>>> -void sas_task_internal_timedout(struct timer_list *t)
>>> -{
>>> -    struct sas_task_slow *slow = from_timer(slow, t, timer);
>>> -    struct sas_task *task = slow->task;
>>> -    bool is_completed = true;
>>> -    unsigned long flags;
>>> -
>>> -    spin_lock_irqsave(&task->task_state_lock, flags);
>>> -    if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
>>> -        task->task_state_flags |= SAS_TASK_STATE_ABORTED;
>>> -        is_completed = false;
>>> -    }
>>> -    spin_unlock_irqrestore(&task->task_state_lock, flags);
>>> -
>>> -    if (!is_completed)
>>> -        complete(&task->slow_task->completion);
>>> -}
>>>   enum blk_eh_timer_return sas_internal_timeout(struct scsi_cmnd *scmd)
>>>   {
>>>       struct sas_task *task = TO_SAS_TASK(scmd);
>>> @@ -978,28 +961,23 @@ static int sas_execute_internal_abort(struct 
>>> domain_device *device,
>>>       int res, retry;
>>>       for (retry = 0; retry < TASK_RETRY; retry++) {
>>> -        task = sas_alloc_slow_task(GFP_KERNEL);
>>> +        struct request *rq;
>>> +
>>> +        task = sas_alloc_slow_task_rq(device, GFP_KERNEL, qid);
>>>           if (!task)
>>>               return -ENOMEM;
>>>           task->dev = device;
>>>           task->task_proto = SAS_PROTOCOL_INTERNAL_ABORT;
>>> -        task->task_done = sas_task_internal_done;
>>> -        task->slow_task->timer.function = sas_task_internal_timedout;
>>> -        task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
>>> -        add_timer(&task->slow_task->timer);
>>> +        task->task_done = sas_task_complete_internal;
>>>           task->abort_task.tag = tag;
>>>           task->abort_task.type = type;
>>> -        task->abort_task.qid = qid;
>>> -        res = i->dft->lldd_execute_task(task, GFP_KERNEL);
>>> -        if (res) {
>>> - del_timer_sync(&task->slow_task->timer);
>>> -            pr_err("Executing internal abort failed %016llx (%d)\n",
>>> -                   SAS_ADDR(device->sas_addr), res);
>>> -            break;
>>> -        }
>>> +        rq = scsi_cmd_to_rq(task->uldd_task);
>>> +        rq->timeout = TASK_TIMEOUT;
>>> +
>>> +        blk_execute_rq_nowait(rq, true);
>>> wait_for_completion(&task->slow_task->completion);
>>>           res = TMF_RESP_FUNC_FAILED;
>>> @@ -1069,7 +1047,7 @@ int sas_execute_tmf(struct domain_device 
>>> *device, void *parameter,
>>>       for (retry = 0; retry < TASK_RETRY; retry++) {
>>>           struct request *rq;
>>> -        task = sas_alloc_slow_task_rq(device, GFP_KERNEL);
>>> +        task = sas_alloc_slow_task_rq(device, GFP_KERNEL, -1U);
>>>           if (!task)
>>>               return -ENOMEM;
>>> @@ -1251,17 +1229,7 @@ void sas_task_abort(struct sas_task *task)
>>>   {
>>>       struct scsi_cmnd *sc = task->uldd_task;
>>> -    /* Escape for libsas internal commands */
>>> -    if (!sc) {
>>> -        struct sas_task_slow *slow = task->slow_task;
>>> -
>>> -        if (!slow)
>>> -            return;
>>> -        if (!del_timer(&slow->timer))
>>> -            return;
>>> -        slow->timer.function(&slow->timer);
>>> -        return;
>>> -    }
>>> +    WARN_ON_ONCE(!sc);
>>>       if (dev_is_sata(task->dev) && !task->slow_task)
>>>           sas_ata_task_abort(task);
>>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>>> index f02156ccd376..60543d8b01d4 100644
>>> --- a/include/scsi/libsas.h
>>> +++ b/include/scsi/libsas.h
>>> @@ -565,7 +565,6 @@ enum sas_internal_abort {
>>>   struct sas_internal_abort_task {
>>>       enum sas_internal_abort type;
>>> -    unsigned int qid;
>>>       u16 tag;
>>>   };
>>
>>
>>
>
> .
>

