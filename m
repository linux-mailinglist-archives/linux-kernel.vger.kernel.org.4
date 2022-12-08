Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A964727A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLHPIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLHPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:07:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8465D696;
        Thu,  8 Dec 2022 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670512068; x=1702048068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K1zeRRB0P1vQrCEO4Ljp8etp14D4iEp/Sa7Cz8AzstE=;
  b=SLPn8RhFtlbwFP974RwUEna01gk63Uam2WjLn5FKQTavTNF/Rub0drwy
   6iZc3ol+9tB75aXYp4/F3oIdGodbJoC4TpcxBDqSJij1Ps0jMb+qFrARN
   6sSAwV+E/VIRNvOLEGP3gbUjl+/Wf+GfFCLhkayV2nH6KtYajKhiXkKu9
   yjeWOmv0hrv3w5XUcCUy3P0UJYH5VQRdvRB1hhS98SEL8xR/vY/rtTUbh
   MgcCTtzTTovX/JvqWOcUsy+z97ukz33XmFmw9Ib2fi9uf1jqFwJuJbr3P
   Nj9AM6+XhIh1FNRdQKT87Cx3PMlGLnPqVmGy5aieHzuAiKSPX6NZ/xjMV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="318349483"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="318349483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 06:41:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="735819572"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="735819572"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.223]) ([10.99.249.223])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 06:41:32 -0800
Message-ID: <78f245e5-da9f-ffb5-e88b-eeb60d7d49fc@linux.intel.com>
Date:   Thu, 8 Dec 2022 15:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ACPICA: Fix operand resolution
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <20221208195046.1980312-1-amadeuszx.slawinski@linux.intel.com>
 <CAJZ5v0jvEf=7qTqRkdS1v+fDActtZ1mxoyLBL60Vs6FH8b8OFQ@mail.gmail.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <CAJZ5v0jvEf=7qTqRkdS1v+fDActtZ1mxoyLBL60Vs6FH8b8OFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2022 12:55 PM, Rafael J. Wysocki wrote:
> On Thu, Dec 8, 2022 at 12:51 PM Amadeusz Sławiński
> <amadeuszx.slawinski@linux.intel.com> wrote:
>>
>> In our tests we get UBSAN warning coming from ACPI parser. This is
>> caused by trying to resolve operands when there is none.
>>
>> [    0.000000] Linux version 5.15.0-rc3chromeavsrel1.0.184+ (root@...) (gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP PREEMPT Sat Oct 16 00:08:27 UTC 2021
>> ...
>> [ 14.719508] ================================================================================
>> [ 14.719551] UBSAN: array-index-out-of-bounds in /.../linux/drivers/acpi/acpica/dswexec.c:401:12
>> [ 14.719594] index -1 is out of range for type 'acpi_operand_object *[9]'
>> [ 14.719621] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc3chromeavsrel1.0.184+ #1
>> [ 14.719657] Hardware name: Intel Corp. Geminilake/GLK RVP2 LP4SD (07), BIOS GELKRVPA.X64.0214.B50.2009111159 09/11/2020
>> [ 14.719694] Call Trace:
>> [ 14.719712] dump_stack_lvl+0x38/0x49
>> [ 14.719749] dump_stack+0x10/0x12
>> [ 14.719775] ubsan_epilogue+0x9/0x45
>> [ 14.719801] __ubsan_handle_out_of_bounds.cold+0x44/0x49
>> [ 14.719835] acpi_ds_exec_end_op+0x1d7/0x6b5
>> [ 14.719870] acpi_ps_parse_loop+0x942/0xb34
>> ...
>>
>> Problem happens because WalkState->NumOperands is 0 and it is used when
>> trying to access into operands table. Actual code is:
>> WalkState->Operands [WalkState->NumOperands -1]
>> which causes out of bound access. Improve the check before above access
>> to check if ACPI opcode should have any arguments (operands) at all.
>>
>> Link: https://github.com/acpica/acpica/pull/745
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> ---
>>   drivers/acpi/acpica/dswexec.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
>> index e8ad41387f84..489c9b9d8d15 100644
>> --- a/drivers/acpi/acpica/dswexec.c
>> +++ b/drivers/acpi/acpica/dswexec.c
>> @@ -389,9 +389,11 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
>>
>>                  /*
>>                   * All opcodes require operand resolution, with the only exceptions
>> -                * being the object_type and size_of operators.
>> +                * being the object_type and size_of operators as well as operands that
> 
> Should this be "opcodes that take no arguments" rather?
> 

Yes, it makes more sense that way. I've send v2 and updated pull request 
to acpica.

>> +                * take no arguments.
>>                   */
>> -               if (!(walk_state->op_info->flags & AML_NO_OPERAND_RESOLVE)) {
>> +               if (!(walk_state->op_info->flags & AML_NO_OPERAND_RESOLVE) &&
>> +                   (walk_state->op_info->flags & AML_HAS_ARGS)) {
>>
>>                          /* Resolve all operands */
>>
>> --

