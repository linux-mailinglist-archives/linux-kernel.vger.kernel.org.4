Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0172865FCE5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjAFIix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjAFIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:38:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26AF30;
        Fri,  6 Jan 2023 00:38:46 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NpGq64HNhzJq3M;
        Fri,  6 Jan 2023 16:34:42 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 16:38:44 +0800
Message-ID: <3108ffb4-c158-a5b1-b2a3-8bcdd1bba0ab@huawei.com>
Date:   Fri, 6 Jan 2023 16:38:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <20221215153749.1947570-1-haowenchao@huawei.com>
 <02d139a3-1886-dd6e-8812-dac4d292f064@opensource.wdc.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <02d139a3-1886-dd6e-8812-dac4d292f064@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml100006.china.huawei.com (7.185.36.169) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/4 12:29, Damien Le Moal wrote:
> On 12/16/22 00:37, Wenchao Hao wrote:
>> If ap->ops->error_handler is NULL just return. This patch also
>> fixes some comment style issue.
>>
>> ---
>> v3:
>> - Start with a "/*" empty line for multi-line comments.
>> - Correct the commit subject
>>
>> v2:
>> - Check ap->ops->error_handler without taking the spin lock
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> 
> Ah, so your SoB is here. Wrong patch format. The changelog needs to go
> right below the "---" below here and your SoB above it. You added a "---"
> above, which tells git that this is the end of the commit message and so
> your SoB below it is ignored. I fixed that up when applying to for-6.3,
> together with Niklas suggested edits. In the future, please format your
> patches correctly.

OK, I would use correct format in future patches.

> 
>> ---
>>  drivers/ata/libata-eh.c | 101 +++++++++++++++++++++-------------------
>>  1 file changed, 52 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 34303ce67c14..56820b8e953a 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -565,13 +565,19 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>  {
>>  	int i;
>>  	unsigned long flags;
>> +	struct scsi_cmnd *scmd, *tmp;
>> +	int nr_timedout = 0;
>>  
>>  	/* make sure sff pio task is not running */
>>  	ata_sff_flush_pio_task(ap);
>>  
>> +	if (!ap->ops->error_handler)
>> +		return;
>> +
>>  	/* synchronize with host lock and sort out timeouts */
>>  
>> -	/* For new EH, all qcs are finished in one of three ways -
>> +	/*
>> +	 * For new EH, all qcs are finished in one of three ways -
>>  	 * normal completion, error completion, and SCSI timeout.
>>  	 * Both completions can race against SCSI timeout.  When normal
>>  	 * completion wins, the qc never reaches EH.  When error
>> @@ -584,62 +590,59 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>  	 * timed out iff its associated qc is active and not failed.
>>  	 */
>>  	spin_lock_irqsave(ap->lock, flags);
>> -	if (ap->ops->error_handler) {
>> -		struct scsi_cmnd *scmd, *tmp;
>> -		int nr_timedout = 0;
>> -
>> -		/* This must occur under the ap->lock as we don't want
>> -		   a polled recovery to race the real interrupt handler
>> -
>> -		   The lost_interrupt handler checks for any completed but
>> -		   non-notified command and completes much like an IRQ handler.
>>  
>> -		   We then fall into the error recovery code which will treat
>> -		   this as if normal completion won the race */
>> -
>> -		if (ap->ops->lost_interrupt)
>> -			ap->ops->lost_interrupt(ap);
>> +	/*
>> +	 * This must occur under the ap->lock as we don't want
>> +	 * a polled recovery to race the real interrupt handler
>> +	 *
>> +	 * The lost_interrupt handler checks for any completed but
>> +	 * non-notified command and completes much like an IRQ handler.
>> +	 *
>> +	 * We then fall into the error recovery code which will treat
>> +	 * this as if normal completion won the race
>> +	 */
>> +	if (ap->ops->lost_interrupt)
>> +		ap->ops->lost_interrupt(ap);
>>  
>> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>> -			struct ata_queued_cmd *qc;
>> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>> +		struct ata_queued_cmd *qc;
>>  
>> -			ata_qc_for_each_raw(ap, qc, i) {
>> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> -				    qc->scsicmd == scmd)
>> -					break;
>> -			}
>> +		ata_qc_for_each_raw(ap, qc, i) {
>> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> +			    qc->scsicmd == scmd)
>> +				break;
>> +		}
>>  
>> -			if (i < ATA_MAX_QUEUE) {
>> -				/* the scmd has an associated qc */
>> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>> -					/* which hasn't failed yet, timeout */
>> -					qc->err_mask |= AC_ERR_TIMEOUT;
>> -					qc->flags |= ATA_QCFLAG_FAILED;
>> -					nr_timedout++;
>> -				}
>> -			} else {
>> -				/* Normal completion occurred after
>> -				 * SCSI timeout but before this point.
>> -				 * Successfully complete it.
>> -				 */
>> -				scmd->retries = scmd->allowed;
>> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>> +		if (i < ATA_MAX_QUEUE) {
>> +			/* the scmd has an associated qc */
>> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>> +				/* which hasn't failed yet, timeout */
>> +				qc->err_mask |= AC_ERR_TIMEOUT;
>> +				qc->flags |= ATA_QCFLAG_FAILED;
>> +				nr_timedout++;
>>  			}
>> +		} else {
>> +			/* Normal completion occurred after
>> +			 * SCSI timeout but before this point.
>> +			 * Successfully complete it.
>> +			 */
>> +			scmd->retries = scmd->allowed;
>> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>>  		}
>> +	}
>>  
>> -		/* If we have timed out qcs.  They belong to EH from
>> -		 * this point but the state of the controller is
>> -		 * unknown.  Freeze the port to make sure the IRQ
>> -		 * handler doesn't diddle with those qcs.  This must
>> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
>> -		 */
>> -		if (nr_timedout)
>> -			__ata_port_freeze(ap);
>> -
>> +	/*
>> +	 * If we have timed out qcs.  They belong to EH from
>> +	 * this point but the state of the controller is
>> +	 * unknown.  Freeze the port to make sure the IRQ
>> +	 * handler doesn't diddle with those qcs.  This must
>> +	 * be done atomically w.r.t. setting QCFLAG_FAILED.
>> +	 */
>> +	if (nr_timedout)
>> +		__ata_port_freeze(ap);
>>  
>> -		/* initialize eh_tries */
>> -		ap->eh_tries = ATA_EH_MAX_TRIES;
>> -	}
>> +	/* initialize eh_tries */
>> +	ap->eh_tries = ATA_EH_MAX_TRIES;
>>  	spin_unlock_irqrestore(ap->lock, flags);
>>  
>>  }
> 

