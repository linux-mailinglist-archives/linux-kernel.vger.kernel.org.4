Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89AD5ED1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiI1AY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiI1AYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:24:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461911138EB;
        Tue, 27 Sep 2022 17:24:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rk17so10740732ejb.1;
        Tue, 27 Sep 2022 17:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yrRvoMA2qzsQLaNGkBWV3qKU0u6GXYvGhupTkuY6VEY=;
        b=N4SqAspV6MMkhBYCFIyWw1zoLE0Rd7s2OcFI1DceVn/pHLgQQpIGuPVe/Y5xz2rq7u
         4AwEph2NeuV3pICsTTUzwRekddH0yOeND7JGqULNGiEUieyWRG6v6tDzpLe64Ks46WYl
         +E7aPSySmJM5rrRbU/QTtIuWWnrypBa5Nee0vTcASR26Pbtt3a1rnWEXJiAhZ0LuaF3z
         G0Kpy5TJl/IDsRofANqT6QeQSyO+rxKfvYX1lEVX/uIl1opJ/g6T4wX2v3xFu9sWUBhf
         nxjbUpm/gkJf8RF8BM1xVL9NUSyaLL/yweBBM9Jtss7d1JdDL1D0xSUAW2CB9lb+daDC
         gCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yrRvoMA2qzsQLaNGkBWV3qKU0u6GXYvGhupTkuY6VEY=;
        b=j0VYDRs5klCIdfjk4CA9knBeIGVZqAtIdfICpLMQqP27BrwyAW5SGw/vh/uN3U/4ln
         Dv64rBpQ/TRjU0hI38+OVJm8ILu5ALNqyw8msGbnoWAV1qeYPon3n8woM1N+EP+L3hcU
         0nPTtLaw7+/DtWkQtQrN+BjUNOlC61YyAN5Xz42BD3OXxCeiuOQBNsZT2GdfjiDJ010A
         Y4e+91GkAGyuQBszYDJnU1SaGtl0Zqt5+KXcHx751q6Z0HvK+D+peCGaqFjCKEXD8Lfu
         8eWt0ZrXG/1KiY9A9Rpse28+b6Ws3SUNNOgJIlZaKCOnMVdONvlQ03uRbjSlX1onCKqz
         m8pw==
X-Gm-Message-State: ACrzQf0Gxq6q7ET/Zi31BKEHCz2cMfP3p4e4OqAbwkURdOAxqfjcylnX
        TbIf0H3cwqkmZ0q4/7WDFhTDCxPHRxLEkJ/7+ffqRfDt1nc=
X-Google-Smtp-Source: AMsMyM7eMgPelqF9CjnEbxsTqqXy6pmBZpLW9pueVjK2kG6gmJQBXY3G4jO1eBrNDVmQMCspWLB2ar5LjeuRSz4OCpA=
X-Received: by 2002:a17:907:7eaa:b0:782:3d2b:20b0 with SMTP id
 qb42-20020a1709077eaa00b007823d2b20b0mr25078507ejc.746.1664324641882; Tue, 27
 Sep 2022 17:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com> <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com> <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
In-Reply-To: <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 28 Sep 2022 13:23:50 +1300
Message-ID: <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        yangyicong@hisilicon.com, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, huzhanyuan@oppo.com,
        lipeifeng@oppo.com, zhangshiming@oppo.com, guojian@oppo.com,
        realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>
> On 2022/9/27 14:16, Anshuman Khandual wrote:
> > [...]
> >
> > On 9/21/22 14:13, Yicong Yang wrote:
> >> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> >> +{
> >> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
> >> +    if (num_online_cpus() <= 4)
> >
> > It would be great to have some more inputs from others, whether 4 (which should
> > to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
> > is optimal for an wide range of arm64 platforms.
> >

I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
with 5,6,7
cores.
I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
this patch.

so it seems safe to have
if (num_online_cpus()  < 8)

>
> Do you prefer this macro to be static or make it configurable through kconfig then
> different platforms can make choice based on their own situations? It maybe hard to
> test on all the arm64 platforms.

Maybe we can have this default enabled on machines with 8 and more cpus and
provide a tlbflush_batched = on or off to allow users enable or
disable it according
to their hardware and products. Similar example: rodata=on or off.

Hi Anshuman, Will,  Catalin, Andrew,
what do you think about this approach?

BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/

I do believe we need it based on the expensive cost of tlb shootdown in arm64
even by hardware broadcast.

>
> Thanks.
>
> >> +            return false;> +
> >> +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
> >> +    if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
> >> +            return false;
> >> +#endif
> >> +
> >> +    return true;
> >> +}
> >> +
> >
> > [...]
> >
> > .
> >

Thanks
Barry
