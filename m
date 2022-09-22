Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D095E6888
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiIVQgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:35:59 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D830E90C7C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:35:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 3so9669971pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=Mqld70dhyuaOgiw/IPgHbm/MG9Kx5PxLIdME9+hbze8=;
        b=A30P2TsTzTPSfroNaeVGSOJDziZGrMjNKiU0gQJMb0we6OZrmatXbG+f68xUEnJfSF
         ZPdF5/Ch1dk+k3rY6OKt8FKbqXw8RgOyWqpFGEuC5H/daki1BNlx0RJiEy73G4aIUEdf
         eYaz5SIprR0YqM9br4OkbwywItMplvBbJks+uP/J6RbtwE4cby5QDauzG/DzmP7Tn2zr
         7+J3vgf4KUp1rFyg90nuSZj94WuQCA31UjFNfgK5WNmrT5gjp2CVIwgdv5W+QKY2FSh7
         EbybjTh52uN3o1Ei5N+KaTuzhhvqQMYS/VLu3RgT/GC5Ux53KmFYlmBuTYRyTkHYKPyD
         sAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Mqld70dhyuaOgiw/IPgHbm/MG9Kx5PxLIdME9+hbze8=;
        b=B/O62FWZGNkYlewMOMWSyNNkhQbJ5q/e3MvDlM0YtlMStIXeqp2/IlFu1SC5fFhp0+
         k5D5JLoSoxv+1zpCR8xpSmW880G69w94GZ1rD4K3qdRxj6EN9daC89XUCE2BDEodV2nP
         IsaO4dNH8VTfymw3b9bXNB08YI+uROcwut0SkZoISyT3TM3kPUy/K+NpO4jXuSO7fZ6D
         Z9DKdNRrepyZiUUntrMIj4txjG158uM+NXbGQDs3m8AnXWOnBqAsbbT56sJrzm8tVTkt
         DoJeisIgurjMcR/M56BybjJ31Tf19ieqEFj6X1sCVJfh2t3K5ZUbMYe1rY2vSxarGNEv
         MVGw==
X-Gm-Message-State: ACrzQf2KZ0WvvO1260C6gLq/TJmARAFUT1JqVaIoFqDQwzDSBwq8H4Ul
        CgcSoQkVSS2qYhmxMYTmykNCSZJ2j9NBXBfAQwQsvQ==
X-Google-Smtp-Source: AMsMyM5m7T2Tjst45VejNFeB39v+vAogLCRE9CTffZ8cdOVYxhy1rLX2AqkBX5N/uTLppk485h9OFQ==
X-Received: by 2002:a63:1a1f:0:b0:438:d11b:e23d with SMTP id a31-20020a631a1f000000b00438d11be23dmr3627146pga.335.1663864557302;
        Thu, 22 Sep 2022 09:35:57 -0700 (PDT)
Received: from localhost (pop.92-184-98-183.mobile.abo.orange.fr. [92.184.98.183])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902c38a00b001750b31faabsm4245176plg.262.2022.09.22.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:35:56 -0700 (PDT)
Date:   Thu, 22 Sep 2022 09:35:56 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Sep 2022 09:35:50 PDT (-0700)
Subject:     Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
In-Reply-To: <CAK9=C2WkqVgg58sKyDEMWue_vL8Pz7bCfERuaW_4DGnYTpcSMw@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, atishp@atishpatra.org,
        heiko@sntech.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mchitale@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-37586d5e-5576-448a-8d9c-4d277c252365@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 19:24:55 PDT (-0700), apatel@ventanamicro.com wrote:
> Hi Palmer,
>
> On Tue, Aug 30, 2022 at 10:17 AM Anup Patel <apatel@ventanamicro.com> wrote:
>>
>> Currently, all flavors of ioremap_xyz() function maps to the generic
>> ioremap() which means any ioremap_xyz() call will always map the
>> target memory as IO using _PAGE_IOREMAP page attributes. This breaks
>> ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
>> remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
>> page attributes.
>>
>> To address above (just like other architectures), we implement RISC-V
>> specific ioremap_cache() and ioremap_wc() which maps memory using page
>> attributes as defined by the Svpbmt specification.
>>
>> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
>> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> This is a crucial RC fix. Can you please take this ?

Sorry I missed this, I thought it was just part of the rest of this 
patch set.  That said, I'm not actually sure this is a critical fix: 
sure it's a performance problem, and if some driver is expecting 
ioremap_cache() to go fast then possibly a pretty big one, but the only 
Svpmbt hardware that exists is the D1 and that was just supported this 
release so it's not a regression.  Maybe that's a bit pedantic, but all 
this travel has kind of made things a mess and I'm trying to make sure 
nothing goes off the rails.

Probably a pointless distinction as it'll just get backported anyway, 
but I'm going to hold off on this for now -- it generally looks OK, but 
I don't get back until this weekend and I'm super tired so I'm trying to 
avoid screwing anything up.

>
> Regards,
> Anup
>
>> ---
>>  arch/riscv/include/asm/io.h      | 10 ++++++++++
>>  arch/riscv/include/asm/pgtable.h |  2 ++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
>> index 69605a474270..07ac63999575 100644
>> --- a/arch/riscv/include/asm/io.h
>> +++ b/arch/riscv/include/asm/io.h
>> @@ -133,6 +133,16 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
>>  #define outsq(addr, buffer, count) __outsq((void __iomem *)addr, buffer, count)
>>  #endif
>>
>> +#ifdef CONFIG_MMU
>> +#define ioremap_wc(addr, size)         \
>> +       ioremap_prot((addr), (size), _PAGE_IOREMAP_WC)
>> +#endif
>> +
>>  #include <asm-generic/io.h>
>>
>> +#ifdef CONFIG_MMU
>> +#define ioremap_cache(addr, size)      \
>> +       ioremap_prot((addr), (size), _PAGE_KERNEL)
>> +#endif
>> +
>>  #endif /* _ASM_RISCV_IO_H */
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 7ec936910a96..346b7c1a3eeb 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -182,6 +182,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
>>  #define PAGE_TABLE             __pgprot(_PAGE_TABLE)
>>
>>  #define _PAGE_IOREMAP  ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
>> +#define _PAGE_IOREMAP_WC       ((_PAGE_KERNEL & ~_PAGE_MTMASK) | \
>> +                                _PAGE_NOCACHE)
>>  #define PAGE_KERNEL_IO         __pgprot(_PAGE_IOREMAP)
>>
>>  extern pgd_t swapper_pg_dir[];
>> --
>> 2.34.1
>>
