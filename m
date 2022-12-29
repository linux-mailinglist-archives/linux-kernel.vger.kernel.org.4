Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78401658917
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiL2DRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL2DRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:17:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B986A12AA3;
        Wed, 28 Dec 2022 19:17:33 -0800 (PST)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NjD7F1kVvzRpGW;
        Thu, 29 Dec 2022 11:16:09 +0800 (CST)
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Dec 2022 11:17:31 +0800
Message-ID: <703686f3-19aa-eb15-dd54-00f463e6e620@huawei.com>
Date:   Thu, 29 Dec 2022 11:17:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH] ata: libata-eh: Retry the cmnd when normal complete
 occurrd after scsi timeout
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiuchangqi.qiu@huawei.com" <qiuchangqi.qiu@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>, <chenchunxiao@huawei.com>
References: <1672220216-46938-1-git-send-email-wubo40@huawei.com>
 <Y6yD7Jy0vNr2ZAmE@x1-carbon>
From:   Wu Bo <wubo40@huawei.com>
In-Reply-To: <Y6yD7Jy0vNr2ZAmE@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/29 1:59, Niklas Cassel wrote:
> On Wed, Dec 28, 2022 at 05:36:56PM +0800, Wu Bo wrote:
>> From: wubo <wubo40@huawei.com>
>>
>> Hi,
>>
>> Now SCSI middle layer EH and normal IO handler can only choose one of them,
>> after the SCSI command is completed normally after scsi timeout period,
>> Should this scenario be given a chance to retry?
>>
>> Signed-off-by: wubo <wubo40@huawei.com>
>> ---
>>   drivers/ata/libata-eh.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 34303ce..8d1856f 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -617,14 +617,8 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>   					qc->flags |= ATA_QCFLAG_FAILED;
>>   					nr_timedout++;
>>   				}
>> -			} else {
>> -				/* Normal completion occurred after
>> -				 * SCSI timeout but before this point.
>> -				 * Successfully complete it.
>> -				 */
>> -				scmd->retries = scmd->allowed;
>> +			} else
>>   				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>> -			}
>>   		}
>>
> 
> Hello Wu,
> 
> 
> The function comment looks like this:
> 	/* For new EH, all qcs are finished in one of three ways -
> 	 * normal completion, error completion, and SCSI timeout.
> 	 * Both completions can race against SCSI timeout.  When normal
> 	 * completion wins, the qc never reaches EH.  When error
> 	 * completion wins, the qc has ATA_QCFLAG_FAILED set.
> 	 *
> 	 * When SCSI timeout wins, things are a bit more complex.
> 	 * Normal or error completion can occur after the timeout but
> 	 * before this point.  In such cases, both types of
> 	 * completions are honored.  A scmd is determined to have
> 	 * timed out iff its associated qc is active and not failed.
> 	 */
> 
> And the code looks like this:
> 
> 			if (i < ATA_MAX_QUEUE) {
> 				/* the scmd has an associated qc */
> 				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> 					/* which hasn't failed yet, timeout */
> 					qc->err_mask |= AC_ERR_TIMEOUT;
> 					qc->flags |= ATA_QCFLAG_FAILED;
> 					nr_timedout++;
> 				}
> 			} else {
> 				/* Normal completion occurred after
> 				 * SCSI timeout but before this point.
> 				 * Successfully complete it.
> 				 */
> 				scmd->retries = scmd->allowed;
> 				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> 			}
> 
> 
> 
> If SCSI timeout wins, but there came an error completion after,
> then we will go into the if (i < ATA_MAX_QUEUE) case, but we will
> not enter the if !(qc->flags & ATA_QCFLAG_FAILED), as ATA_QCFLAG_FAILED
> will already be set by the irq handler. This QC will be completed
> by the ata_scsi_port_error_handler(), which gets to run just after
> this function has returned:
> https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/ata/libata-eh.c#L546
> 
> 
> 
> The else clause you are modifying however is for the case where SCSI timeout
> wins, but there came a normal completion occurred after the SCSI timeout.
> 
> In more detail, what happens first is that scsi_timeout() gets called,
> and if scsi timeout wins, it sets SCMD_STATE_COMPLETE:
> https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/scsi/scsi_error.c#L355
> and then schedules EH for that command using scsi_eh_scmd_add().
> 
> What happens next in this specific case is that the IRQ handler is called,
> takes the ap->lock (which is also taken is this function so that it can run
> at the same time as the IRQ handler), then the IRQ handler calls
> __ata_qc_complete() for the QC, however, when scsi_done() is finally called
> in ata_qc_done() (from IRQ context), it will not be a no-op, since
> SCMD_STATE_COMPLETE is already set:
> https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/scsi/scsi_lib.c#L1623
> 
> Since scsi_done() never finished the scsi_cmd, we need to finish it here,
> in the else clause, by calling scsi_eh_finish_cmd().
> 
> When the EH queue is flushed, it will check if scsi_cmd_retry_allowed()
> and if it is, the command will be retried, otherwise it will call scsi_finish()
> on the command:
> https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/scsi/scsi_error.c#L2150
> 
> Considering that we want to only finish the scmd here, libata sets
> scmd->retries = scmd->allowed; such that the check:
> 	return ++cmd->retries <= cmd->allowed;
> in scsi_cmd_retry_allowed() will evaulate to false.
> 
> 
> So TL;DR:
> It is absolutely essential to set scmd->retries = scmd->allowed;
> in this else clause, as that is the only reason why this command will
> be finished instead of retried.
> Since this else clause is for a command that timed out, but got completed
> successfully via the IRQ handler after timing out (so the QC got freed),
> we only need to finish the scmd. Retrying the scmd is wrong in this case.
> 
> 
> Kind regards,
> Niklas.

Hi Niklas,

Thanks for your detailed reply.

The case where SCSI timeout wins,
but there came a normal completion occurred after the SCSI timeout.
in this scenario, The EH process cannot get the command status
from the IRQ handler process.

If the command is not retried, it can only be returned to the upper 
layer with timeout state.

Log as fllows:
sd 1:0:0:0: [sda] tag#30 scsi_eh_1: flush retry cmd, scmd->retries:3, 
scmd->allowed:2
sd 1:0:0:0: [sda] tag#30 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_TIMEOUT
sd 1:0:0:0: [sda] tag#30 CDB: Read(10) 28 00 07 5e e6 7b 00 00 01 00
print_req_error: I/O error, dev sda, sector 123659899

In fact, The I/O can be completed normally, but it takes a little 
longer. In this scenario, do we give the opportunity as much as possible
so that the IO can return successfully?

-- 
Wu Bo
