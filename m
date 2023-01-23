Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097B5677CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAWNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjAWNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:39:47 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C25D52F;
        Mon, 23 Jan 2023 05:39:43 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B60C100011;
        Mon, 23 Jan 2023 13:39:36 +0000 (UTC)
Message-ID: <95d81c9a-11de-7f92-cb76-e4492e9faba8@ghiti.fr>
Date:   Mon, 23 Jan 2023 14:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] riscv: Allow to downgrade paging mode from the command
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20230123104841.813999-1-alexghiti@rivosinc.com>
 <Y851L2KgfIF3V6of@wendy>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Y851L2KgfIF3V6of@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 1/23/23 12:53, Conor Dooley wrote:
> Hey Alex,
>
> On Mon, Jan 23, 2023 at 11:48:41AM +0100, Alexandre Ghiti wrote:
>> Add 2 early command line parameters that allow to downgrade satp mode
>> (using the same naming as x86):
>> - "no5lvl": use a 4-level page table (down from sv57 to sv48)
>> - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
>>
>> Note that going through the device tree to get the kernel command line
>> works with ACPI too since the efi stub creates a device tree anyway with
>> the command line.
>>
>> Also, as those params are treated very early in the boot process and we
>> use standard device tree functions that may be kasan instrumented, we
>> only enable them for !KASAN configurations.
>>
>> Reviewed-by: Björn Töpel <bjorn@kernel.org>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
> A changelog would be nice here, especially since this is a resend.


I think you may have commented the wrong patch, this one is wrong, hence 
the resend!


>
>>   .../admin-guide/kernel-parameters.txt         |  9 ++-
>>   arch/riscv/mm/init.c                          | 72 +++++++++++++++++--
>>   2 files changed, 74 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 6cfa6e3996cf..fd647412ec91 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3578,8 +3578,15 @@
>>   			emulation library even if a 387 maths coprocessor
>>   			is present.
>>   
>> -	no5lvl		[X86-64] Disable 5-level paging mode. Forces
>> +	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
>> +			kernel to use 3-level paging instead.
>> +			Note: On RISC-V, this can't be used when KASAN is
>> +			enabled.
>> +
>> +	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
>>   			kernel to use 4-level paging instead.
>> +			Note: On RISC-V, this can't be used when KASAN is
>> +			enabled.
>>   
>>   	nofsgsbase	[X86] Disables FSGSBASE instructions.
>>   
> For the improved descriptions & commit message:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


Thanks for that, would you mind adding that to the resend patch?

Thanks again,

Alex


>
> Thanks,
> Conor.
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
