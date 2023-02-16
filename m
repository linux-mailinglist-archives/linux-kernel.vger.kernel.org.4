Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81875699123
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBPK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBPK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:28:04 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9EBA366B0;
        Thu, 16 Feb 2023 02:28:03 -0800 (PST)
Received: from [192.168.2.24] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id DE5FB20B9C3D;
        Thu, 16 Feb 2023 02:28:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE5FB20B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676543283;
        bh=TiBxPy2bvn90kEvfNZ1gm0HLB1XTqCcNsA01CVVqYb8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JyXq/lCzwM9AJxO1fMQCJmJtleLVhCXG/by6cwTcunoSQAI0tabjzAmYKVuZSwmo9
         1vfOOjaiahoaeWP40hPJtw3BWp1oIxSHjvLVh6HCQuY3S6Nw3EK8U7FVDsm/0rod8H
         5nkVviFRLPMchx6Qe9yYktGkwoC36HIfBKgx9YsA=
Message-ID: <f2632137-3d9f-1ed6-a5b4-f13c67afdaea@linux.microsoft.com>
Date:   Thu, 16 Feb 2023 11:28:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/8] include/acpi: add definition of ASPT table
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
 <20230213092429.1167812-2-jpiotrowski@linux.microsoft.com>
 <CAJZ5v0hcyWs49ttGA2sjyWe5f++jvCORLeTX1eiP5O2qOAOGgQ@mail.gmail.com>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <CAJZ5v0hcyWs49ttGA2sjyWe5f++jvCORLeTX1eiP5O2qOAOGgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/02/2023 19:43, Rafael J. Wysocki wrote:
> On Mon, Feb 13, 2023 at 10:25 AM Jeremi Piotrowski
> <jpiotrowski@linux.microsoft.com> wrote:
>>
>> The AMD Secure Processor ACPI Table provides the memory location of the
>> register window and register offsets necessary to communicate with AMD's
>> PSP (Platform Security Processor). This table is exposed on Hyper-V VMs
>> configured with support for AMD's SNP isolation technology.
>>
>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> 
> Please add a Link tag pointing to the corresponding upstream ACPICA
> pull request (or upstream ACPICA commit if already pulled) to this
> patch and analogously for patch [2/8].
> 
> Thanks!
> 

Will do when I post v3. I'll poke the ACPICA maintainer again after the specification
gets published this friday.

Jeremi

>> ---
>>  include/acpi/actbl1.h | 46 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 15c78678c5d3..00d40373df37 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -26,6 +26,7 @@
>>   */
>>  #define ACPI_SIG_AEST           "AEST" /* Arm Error Source Table */
>>  #define ACPI_SIG_ASF            "ASF!" /* Alert Standard Format table */
>> +#define ACPI_SIG_ASPT           "ASPT" /* AMD Secure Processor Table */
>>  #define ACPI_SIG_BERT           "BERT" /* Boot Error Record Table */
>>  #define ACPI_SIG_BGRT           "BGRT" /* Boot Graphics Resource Table */
>>  #define ACPI_SIG_BOOT           "BOOT" /* Simple Boot Flag Table */
>> @@ -106,6 +107,51 @@ struct acpi_whea_header {
>>         u64 mask;               /* Bitmask required for this register instruction */
>>  };
>>
>> +/* https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/acpitabl/ns-acpitabl-aspt_table */
>> +#define ASPT_REVISION_ID 0x01
>> +struct acpi_table_aspt {
>> +       struct acpi_table_header header;
>> +       u32 num_entries;
>> +};
>> +
>> +struct acpi_aspt_header {
>> +       u16 type;
>> +       u16 length;
>> +};
>> +
>> +enum acpi_aspt_type {
>> +       ACPI_ASPT_TYPE_GLOBAL_REGS = 0,
>> +       ACPI_ASPT_TYPE_SEV_MBOX_REGS = 1,
>> +       ACPI_ASPT_TYPE_ACPI_MBOX_REGS = 2,
>> +};
>> +
>> +/* 0: ASPT Global Registers */
>> +struct acpi_aspt_global_regs {
>> +       struct acpi_aspt_header header;
>> +       u32 reserved;
>> +       u64 feature_reg_addr;
>> +       u64 irq_en_reg_addr;
>> +       u64 irq_st_reg_addr;
>> +};
>> +
>> +/* 1: ASPT SEV Mailbox Registers */
>> +struct acpi_aspt_sev_mbox_regs {
>> +       struct acpi_aspt_header header;
>> +       u8 mbox_irq_id;
>> +       u8 reserved[3];
>> +       u64 cmd_resp_reg_addr;
>> +       u64 cmd_buf_lo_reg_addr;
>> +       u64 cmd_buf_hi_reg_addr;
>> +};
>> +
>> +/* 2: ASPT ACPI Mailbox Registers */
>> +struct acpi_aspt_acpi_mbox_regs {
>> +       struct acpi_aspt_header header;
>> +       u32 reserved1;
>> +       u64 cmd_resp_reg_addr;
>> +       u64 reserved2[2];
>> +};
>> +
>>  /*******************************************************************************
>>   *
>>   * ASF - Alert Standard Format table (Signature "ASF!")
>> --
>> 2.25.1
>>
