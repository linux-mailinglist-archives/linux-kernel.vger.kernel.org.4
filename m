Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78636BCBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCPJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCPJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:58:22 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6B1B71AD;
        Thu, 16 Mar 2023 02:57:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Ve-ExPS_1678960672;
Received: from 30.240.112.112(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Ve-ExPS_1678960672)
          by smtp.aliyun-inc.com;
          Thu, 16 Mar 2023 17:57:54 +0800
Message-ID: <c1040a40-239b-f8c1-13b3-37b40a90ddee@linux.alibaba.com>
Date:   Thu, 16 Mar 2023 17:57:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "lvying6@huawei.com" <lvying6@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-2-xueshuai@linux.alibaba.com>
 <20230316072031.GA354196@hori.linux.bs1.fc.nec.co.jp>
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230316072031.GA354196@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tony Luck for MCE

On 2023/3/16 PM3:21, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Feb 27, 2023 at 01:03:14PM +0800, Shuai Xue wrote:
>> There are two major types of uncorrected recoverable (UCR) errors :
>>
>> - Action Required (AR): The error is detected and the processor already
>>   consumes the memory. OS requires to take action (for example, offline
>>   failure page/kill failure thread) to recover this uncorrectable error.
>>
>> - Action Optional (AO): The error is detected out of processor execution
>>   context. Some data in the memory are corrupted. But the data have not
>>   been consumed. OS is optional to take action to recover this
>>   uncorrectable error.
>>
>> The essential difference between AR and AO errors is that AR is a
>> synchronous event, while AO is an asynchronous event. The hardware will
>> signal a synchronous exception (Machine Check Exception on X86 and
>> Synchronous External Abort on Arm64) when an error is detected and the
>> memory access has been architecturally executed.
>>
>> When APEI firmware first is enabled, a platform may describe one error
>> source for the handling of synchronous errors (e.g. MCE or SEA notification
>> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
>> notification). In other words, we can distinguish synchronous errors by
>> APEI notification. For AR errors, kernel will kill current process
>> accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
>> addition, for AO errors, kernel will notify the process who owns the
>> poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
>> However, the GHES driver always sets mf_flags to 0 so that all UCR errors
>> are handled as AO errors in memory failure.
>>
>> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
>> events.
>>
>> Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 28 ++++++++++++++++++++++------
>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 34ad071a64e9..5d37fb4bca67 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -101,6 +101,19 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>>  	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>>  }
>>  
>> +/*
>> + * A platform may describe one error source for the handling of synchronous
>> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>> + * or External Interrupt).
>> + */
>> +static inline bool is_hest_sync_notify(struct ghes *ghes)
>> +{
>> +	int notify_type = ghes->generic->notify.type;
>> +
>> +	return notify_type == ACPI_HEST_NOTIFY_SEA ||
>> +	       notify_type == ACPI_HEST_NOTIFY_MCE;
>> +}
> 
> This code seems to read that all MCEs are synchronous, which I think is
> not correct.  The scenario I'm worrying about is that is_hest_sync_notify()
> returns true when this code is called for AO MCE (so asynchronous one).
> Then, ghes_do_memory_failure() (updated by your patch 2/2) will choose to
> use task_work instead of memory_failure_queue().  This should not be expected.
> Or does that never happen?

I think you are right.

On x86 platform with MCA, patrol scrub errors are asynchronous error, which are
by default signaled with MCE. It is possible to downgrade the patrol scrub SRAO
to UCNA or other correctable error in the logging/signaling behavior and signal
CMCI only.

As far as I know, on X86 platform, MCE is handled in do_machche_check() and only
asynchronous error is notified through HEST. Can we safely drop ACPI_HEST_NOTIFY_MCE
and only consider ACPI_HEST_NOTIFY_SEA as synchronous notification?

Tony, do you have any comments on this? Please point out if I am wrong. Thank you.

> 
> - Naoya Horiguchi

Glad to hear from you and thank you for your comments.

Best regards
Shuai

> 
>> +
>>  /*
>>   * This driver isn't really modular, however for the time being,
>>   * continuing to use module_param is the easiest way to remain
>> @@ -477,7 +490,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>  }
>>  
>>  static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>> -				       int sev)
>> +				       int sev, bool sync)
>>  {
>>  	int flags = -1;
>>  	int sec_sev = ghes_severity(gdata->error_severity);
>> @@ -491,7 +504,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>  	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>>  		flags = MF_SOFT_OFFLINE;
>>  	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>> -		flags = 0;
>> +		flags = sync ? MF_ACTION_REQUIRED : 0;
>>  
>>  	if (flags != -1)
>>  		return ghes_do_memory_failure(mem_err->physical_addr, flags);
>> @@ -499,12 +512,14 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>  	return false;
>>  }
>>  
>> -static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
>> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>> +				       int sev, bool sync)
>>  {
>>  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>>  	bool queued = false;
>>  	int sec_sev, i;
>>  	char *p;
>> +	int flags = sync ? MF_ACTION_REQUIRED : 0;
>>  
>>  	log_arm_hw_error(err);
>>  
>> @@ -526,7 +541,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
>>  		 * and don't filter out 'corrected' error here.
>>  		 */
>>  		if (is_cache && has_pa) {
>> -			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
>> +			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
>>  			p += err_info->length;
>>  			continue;
>>  		}
>> @@ -647,6 +662,7 @@ static bool ghes_do_proc(struct ghes *ghes,
>>  	const guid_t *fru_id = &guid_null;
>>  	char *fru_text = "";
>>  	bool queued = false;
>> +	bool sync = is_hest_sync_notify(ghes);
>>  
>>  	sev = ghes_severity(estatus->error_severity);
>>  	apei_estatus_for_each_section(estatus, gdata) {
>> @@ -664,13 +680,13 @@ static bool ghes_do_proc(struct ghes *ghes,
>>  			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
>>  
>>  			arch_apei_report_mem_error(sev, mem_err);
>> -			queued = ghes_handle_memory_failure(gdata, sev);
>> +			queued = ghes_handle_memory_failure(gdata, sev, sync);
>>  		}
>>  		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>>  			ghes_handle_aer(gdata);
>>  		}
>>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>> -			queued = ghes_handle_arm_hw_error(gdata, sev);
>> +			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
>>  		} else {
>>  			void *err = acpi_hest_get_payload(gdata);
>>  
>> -- 
>> 2.20.1.12.g72788fdb
