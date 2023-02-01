Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B006862F1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjBAJhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjBAJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:37:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191404A1C4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:37:28 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P6Gxd61dSzJrSM;
        Wed,  1 Feb 2023 17:35:49 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 17:37:25 +0800
Message-ID: <9a4f98a7-fa03-7960-29ce-0bff018c0ac9@huawei.com>
Date:   Wed, 1 Feb 2023 17:37:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: Add header include guards to insn.h
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <heiko.stuebner@vrull.eu>,
        <ajones@ventanamicro.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jszhang@kernel.org>,
        <vincent.chen@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230129094242.282620-1-liaochang1@huawei.com>
 <Y9fZ2ZxdMmXgO5aB@wendy>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <Y9fZ2ZxdMmXgO5aB@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor

在 2023/1/30 22:53, Conor Dooley 写道:
> Hey!
> 
> On Sun, Jan 29, 2023 at 05:42:42PM +0800, Liao Chang wrote:
>> Add header include guards to insn.h to prevent repeating declaration of
>> any identifiers in insn.h.
> 
> I'm curious, did you spot this "by hand" while doing other work, or do
> you have a tool that found it for you?

I found this "by hand", inspired by scripts/checkdeclares.pl, i write a tiny tool
to analyse the missing header guards in header file.

#!/usr/bin/env perl
use strict;

sub usage {
        print "Usage: checkguards.pl file1.h ...\n";
        print "Warn of missing header guards\n";
        exit 1;
}

if ($#ARGV < 0) {
        usage();
}

foreach my $file (@ARGV) {
        open(my $f, '<', $file)
            or die "Cannot open $file: $!.\n";

        my $scan_area = 1;
        my $guards_warn = 0;

        # The lines of header file are divided into several areas as follows:
        #
        # ... area1 ...
        # #ifndef _HEADER_GUARD
        # ... area2 ...
        # #define _HEADER_GUARD
        # ... area3 ...
        # #endif /* _HEADER_GUARD */
        # ... area4 ...
        # EOF
        #
        # If any statement is found in area1, area2, and area4, it
        # throws a warning of illegal usage of header guard usage.
        while (<$f>) {
                if (m/^(.*);\s*$/o) {
                        if ($scan_area == 1 || $scan_area == 2 || $scan_area == 4) {
                                ++$guards_warn;
                        }
                } elsif (m/^\s*(#ifndef\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
                        ++$scan_area;
                } elsif (m/^\s*(#define\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
                        ++$scan_area;
                } elsif (m/^\s*(#endif)\s*\/\*\s*[a-zA-Z0-9_]*_H[_]*\s*\*\/\s*$/o) {
                        ++$scan_area;
                }
        }

        close($f);

        if ($guards_warn) {
                print "Illegal usage of header guard found in $file.\n";
        }
}

Thanks.

> 
>> Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")
> 
> Heh, I appreciate you going back to the file's original name to find the
> correct fixes tag!
> I figure that it's probably worth adding a fixes tag for the rename too,
> so that the stable bots don't get confused? That would be:
> Fixes: c9c1af3f186a ("RISC-V: rename parse_asm.h to insn.h")
> 
> Probably overkill when you have Drew's already for something so trivial,
> but:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/riscv/include/asm/insn.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
>> index 25ef9c0b19e7..22c7613bfda3 100644
>> --- a/arch/riscv/include/asm/insn.h
>> +++ b/arch/riscv/include/asm/insn.h
>> @@ -3,6 +3,9 @@
>>   * Copyright (C) 2020 SiFive
>>   */
>>  
>> +#ifndef _ASM_RISCV_INSN_H
>> +#define _ASM_RISCV_INSN_H
>> +
>>  #include <linux/bits.h>
>>  
>>  #define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
>> @@ -365,3 +368,4 @@ static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype
>>  	*utype_insn |= (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1);
>>  	*itype_insn |= ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF);
>>  }
>> +#endif /* _ASM_RISCV_INSN_H */
>> -- 
>> 2.25.1
>>
>>

-- 
BR,
Liao, Chang
