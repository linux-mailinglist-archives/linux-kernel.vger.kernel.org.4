Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7264DDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLOPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiLOPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:22:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE85FEA;
        Thu, 15 Dec 2022 07:20:44 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NXwrg15MmzJqb0;
        Thu, 15 Dec 2022 23:19:47 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 23:20:42 +0800
Message-ID: <8cba5193-6628-43ba-b9e8-46f78da3e53b@huawei.com>
Date:   Thu, 15 Dec 2022 23:20:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <20221215105747.1927412-1-haowenchao@huawei.com>
 <f552f2ab-895a-14dd-d391-a7b1c9930c88@gmail.com>
 <d991d4fd-3b5f-f0ef-5c96-2352a08e1262@opensource.wdc.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <d991d4fd-3b5f-f0ef-5c96-2352a08e1262@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml100013.china.huawei.com (7.185.36.238) To
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


On 2022/12/15 19:34, Damien Le Moal wrote:
> On 12/15/22 20:30, Sergei Shtylyov wrote:
>> Hello!
>>
>>   The subject should really look like "ata: libata-eh: Cleanup
>> ata_scsi_cmd_error_handler()"...
>>
>> On 12/15/22 1:57 PM, Wenchao Hao wrote:
>>
>>> If ap->ops->error_handler is NULL, just return.
>>>
>>> V2:
>>> - Check ap->ops->error_handler without taking the spin lock
>>
>>    This normally belongs under ---...
> 
> I should read all emails before replying. I commented exactly the same :)
> 
>>
>>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>>> ---
>>>  drivers/ata/libata-eh.c | 96 ++++++++++++++++++++---------------------
>>>  1 file changed, 48 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 34303ce67c14..c445c272e77f 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>> [...]
>>> @@ -584,62 +589,57 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>>  	 * timed out iff its associated qc is active and not failed.
>>>  	 */
>>>  	spin_lock_irqsave(ap->lock, flags);
>>> -	if (ap->ops->error_handler) {
>>> -		struct scsi_cmnd *scmd, *tmp;
>>> -		int nr_timedout = 0;
>>> -
>>> -		/* This must occur under the ap->lock as we don't want
>>> -		   a polled recovery to race the real interrupt handler
>>> -
>>> -		   The lost_interrupt handler checks for any completed but
>>> -		   non-notified command and completes much like an IRQ handler.
>>>  
>>> -		   We then fall into the error recovery code which will treat
>>> -		   this as if normal completion won the race */
>>> -
>>> -		if (ap->ops->lost_interrupt)
>>> -			ap->ops->lost_interrupt(ap);
>>> +	/* This must occur under the ap->lock as we don't want
>>
>>    The multi-line comments should start with /* on its own line...
>>
>>> +	 * a polled recovery to race the real interrupt handler
>>> +	 *
>>> +	 * The lost_interrupt handler checks for any completed but
>>> +	 * non-notified command and completes much like an IRQ handler.
>>> +	 *
>>> +	 * We then fall into the error recovery code which will treat
>>> +	 * this as if normal completion won the race
>>> +	 */
>>> +	if (ap->ops->lost_interrupt)
>>> +		ap->ops->lost_interrupt(ap);
>>>  
>>> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>>> -			struct ata_queued_cmd *qc;
>>> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>>> +		struct ata_queued_cmd *qc;
>>>  
>>> -			ata_qc_for_each_raw(ap, qc, i) {
>>> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
>>> -				    qc->scsicmd == scmd)
>>> -					break;
>>> -			}
>>> +		ata_qc_for_each_raw(ap, qc, i) {
>>> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>>> +			    qc->scsicmd == scmd)
>>> +				break;
>>> +		}
>>>  
>>> -			if (i < ATA_MAX_QUEUE) {
>>> -				/* the scmd has an associated qc */
>>> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>>> -					/* which hasn't failed yet, timeout */
>>> -					qc->err_mask |= AC_ERR_TIMEOUT;
>>> -					qc->flags |= ATA_QCFLAG_FAILED;
>>> -					nr_timedout++;
>>> -				}
>>> -			} else {
>>> -				/* Normal completion occurred after
>>> -				 * SCSI timeout but before this point.
>>> -				 * Successfully complete it.
>>> -				 */
>>> -				scmd->retries = scmd->allowed;
>>> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>>> +		if (i < ATA_MAX_QUEUE) {
>>> +			/* the scmd has an associated qc */
>>> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>>> +				/* which hasn't failed yet, timeout */
>>> +				qc->err_mask |= AC_ERR_TIMEOUT;
>>> +				qc->flags |= ATA_QCFLAG_FAILED;
>>> +				nr_timedout++;
>>>  			}
>>> +		} else {
>>> +			/* Normal completion occurred after
>>
>>    Here as well...
>>
>>> +			 * SCSI timeout but before this point.
>>> +			 * Successfully complete it.
>>> +			 */
>>> +			scmd->retries = scmd->allowed;
>>> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>>>  		}
>>> +	}
>>>  
>>> -		/* If we have timed out qcs.  They belong to EH from
>>> -		 * this point but the state of the controller is
>>> -		 * unknown.  Freeze the port to make sure the IRQ
>>> -		 * handler doesn't diddle with those qcs.  This must
>>> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
>>> -		 */
>>> -		if (nr_timedout)
>>> -			__ata_port_freeze(ap);
>>> -
>>> +	/* If we have timed out qcs.  They belong to EH from
>>
>>    And here...
>>
>> [...]
>>
>> MBR, Sergey
> 

Thanks a lot for review, I would update them.
