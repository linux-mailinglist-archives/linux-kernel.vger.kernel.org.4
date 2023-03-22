Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3456C4253
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCVFpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVFpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:45:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA151C87
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:45:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z19so7898646plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1679463918;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUKAUL85Wxi4b4hEHbzNnUHiPyWHwr8K1HugEBDKlCY=;
        b=7Bt9C3b0x5bzvZmhwOdMEbFaokkffe4BeXZf9spQfTQTV/uGRfGWzxbI/GZf40finz
         nbuRFRh3BMXJFA4ovpUHWwzAAupSiH1FhEJg/nwoGXRajRt2G0yPnU8hITvBtYJLKBKY
         izK/ScSuoSAa7JYCAiitB4zEtwwEjrtHf5yi+81KR/BQKw+Ft0qUmn1qB3Eja7xNsv4J
         JV4g9eJuzou/iGVT6xRrU4NYAQqzvfFh8ILs5YoUzJJE++AM6yhGBryt1Y3JBgYqDBrF
         CteDpmyE1uoN+P58dQRPiFc+q4A2mvehrJK/G0eHSOkkHqmkhnQVCzAKcROvwN9PgT7a
         1N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679463918;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUKAUL85Wxi4b4hEHbzNnUHiPyWHwr8K1HugEBDKlCY=;
        b=X7EA6j4tyaisZi+NylGKLli18fLzsxRd/oEFvPttfqVlOaaY0eVOZB6rdtlsL0wLhq
         Jc8i4/FbSS10n2OUwOzaF68ymwj6lW/68Vsz6IP03xraZu2zDkgeMT+PWSAWRiUZui4Y
         vBIOOXHJ/gx30KWe/fhb9XrEyhcDuKpifDPabffdZohYRuZOJsIcLWyWNlvMqnytCHfg
         KmqYPA2jxXvRvFrZZhpK1X1xdyFtgaTFy2mXoIuTH7YGFP8/qrha5n9a4eRAW4JBJKnB
         R1YBzv9JSuNSPFLlWXoBNtKNo507fwjhC605UzLZ2liVBcePaHaz6M5VNqnkemL+W8L1
         N1ww==
X-Gm-Message-State: AO0yUKXozgqexYc/HFS9aUu0gMEemtw/kAg9Ukp+nS6K0xmG3sffJfw0
        DSud9/HZz02/H8VUjHeAkPWndg==
X-Google-Smtp-Source: AK7set9hFoIwQ5Kio4YFlSmi5wONLtFpJp7xTQyWo86igN/jztcMv43XvZLZYd2HwBUUV7XaimRunw==
X-Received: by 2002:a17:902:da8e:b0:19f:3b31:4d3 with SMTP id j14-20020a170902da8e00b0019f3b3104d3mr1666171plx.41.1679463918547;
        Tue, 21 Mar 2023 22:45:18 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b00183c6784704sm7756487plr.291.2023.03.21.22.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 22:45:17 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:45:17 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Mar 2023 22:45:08 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: mm: Fix incorrect ASID argument when flushing TLB
In-Reply-To: <ZBkZnRG4FYqjGiLz@APC323>
CC:     zongbox@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@kernel.org,
        sergey.matyukevich@syntacore.com, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, x5710999x@gmail.com,
        tim609@andestech.com, peterlin@andestech.com,
        ycliang@andestech.com, Alistair Francis <Alistair.Francis@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dylan@andestech.com
Message-ID: <mhng-41e9d23d-0d17-4b38-ba7c-1f8369f157d7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 19:42:37 PDT (-0700), dylan@andestech.com wrote:
> On Tue, Mar 14, 2023 at 03:27:30PM +0800, Dylan Jhong wrote:
>> On Tue, Mar 14, 2023 at 10:22:43AM +0800, Zong Li wrote:
>> > Dylan Jhong <dylan@andestech.com> 於 2023年3月13日 週一 下午12:29寫道：
>> > >
>> > > Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
>> > > function. We should only take the ASID field to prevent from touching
>> > > the reserved bit field.
>> > >
>> > > Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
>> > > Signed-off-by: Dylan Jhong <dylan@andestech.com>
>> > > ---
>> >
>> > Hi Dylan,
>> > Thanks for your patch, if I remember correctly, there was a patch from
>> > Alistair Francis did the similar fix. Perhaps we should track that
>> > patch to see why it doesn't be merged. Thanks.
>> >
>> > http://lists.infradead.org/pipermail/linux-riscv/2022-March/013558.html
>> >
>> Hi Zong,
>> Thanks for the reminder, I didn't notice that Alistair had sent the same patch before.
>>
>> Hi Palmer, Alistair
>> http://lists.infradead.org/pipermail/linux-riscv/2022-March/013597.html
>> This patch does not seem to be cherry-picked back to the released linux kernel,
>> and I have not seen the v4 patch. May I ask how is the follow-up progress of this patch?

Sorry about that, I guess I left it kind of vague as to who was doing 
what.  It looks like we've ended up with enough includes that v3 
actually builds now, it's queued up and should end up in fixes tomorrow 
morning.

Thanks!

>>
>> Best,
>> Dylan
>>
>
> Hi Palmer,
>
> Ping. Any update on this?
>
> Best,
> Dylan
>
>> > > Changes from v2:
>> > > - Remove unsued EXPORT_SYMBOL()
>> > > ---
>> > >  arch/riscv/include/asm/tlbflush.h | 2 ++
>> > >  arch/riscv/mm/context.c           | 2 +-
>> > >  arch/riscv/mm/tlbflush.c          | 2 +-
>> > >  3 files changed, 4 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>> > > index 907b9efd39a8..597d6d8aec28 100644
>> > > --- a/arch/riscv/include/asm/tlbflush.h
>> > > +++ b/arch/riscv/include/asm/tlbflush.h
>> > > @@ -12,6 +12,8 @@
>> > >  #include <asm/errata_list.h>
>> > >
>> > >  #ifdef CONFIG_MMU
>> > > +extern unsigned long asid_mask;
>> > > +
>> > >  static inline void local_flush_tlb_all(void)
>> > >  {
>> > >         __asm__ __volatile__ ("sfence.vma" : : : "memory");
>> > > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>> > > index 80ce9caba8d2..6d1aeb063e81 100644
>> > > --- a/arch/riscv/mm/context.c
>> > > +++ b/arch/riscv/mm/context.c
>> > > @@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>> > >
>> > >  static unsigned long asid_bits;
>> > >  static unsigned long num_asids;
>> > > -static unsigned long asid_mask;
>> > > +unsigned long asid_mask;
>> > >
>> > >  static atomic_long_t current_version;
>> > >
>> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> > > index ce7dfc81bb3f..ba4c27187c95 100644
>> > > --- a/arch/riscv/mm/tlbflush.c
>> > > +++ b/arch/riscv/mm/tlbflush.c
>> > > @@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>> > >         /* check if the tlbflush needs to be sent to other CPUs */
>> > >         broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>> > >         if (static_branch_unlikely(&use_asid_allocator)) {
>> > > -               unsigned long asid = atomic_long_read(&mm->context.id);
>> > > +               unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
>> > >
>> > >                 /*
>> > >                  * TLB will be immediately flushed on harts concurrently
>> > > --
>> > > 2.34.1
>> > >
