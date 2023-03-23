Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2B6C71CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjCWUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCWUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:47:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C495E1A48C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:47:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q102so8059237pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1679604424;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33hr9ajSe0YnAiQJm19Ru2Vx/JgzBbQYDL+Eh3T+DxA=;
        b=uPUevAsTbPERMZ9UzPnMpWZpA6MU+hTx4tPsxMM/iRRtXOBRNmlA3gGW3k6X40ivbj
         ATIZujp9Ud08EWx/MXuArXsjtSW0P07Cy0p0WLChG7s6/WQKBzWyJXQ0GcPiMGhOL7YM
         vdUBGHPgPs32E03rhnYFNlkxy6U5OKk3Tv8nNeqndvShEF/u5hysNMcGgluxqTJi8o2p
         x7EdmcbmzjoXtrL8goRzRThlLgLIz24guwjPZAOZt1hxnYVGG407lREMog3KH2bpVXFm
         t20/8GNAVrvWRmJs4NT4Kdh3zXuVEWg8NXJGwnbUJP0ae0yjxoLSu1bdNbbtcagVUGWF
         bz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679604424;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33hr9ajSe0YnAiQJm19Ru2Vx/JgzBbQYDL+Eh3T+DxA=;
        b=1mgQHJxxBCjVz8wWi07L463sl4GZ7mj7gFiuwzk5YjsgPz7F8ybecTZE2WDiMoXNX0
         5JCzX7nIFz2OSXZDAWxZioskffCXW6F5MozxuWbxI8ZEvYdVSvcGHtX/hG6hZeMKh1+j
         DLOYha4YpDeVSSyU23bxc1lTCovIbOHzaxQZ2x2ZSSwVhunPDWegBioKBUdW2SxIr2Va
         btnPpHO2TI8fUik2fzCTJZjt1eIBhAvaERuNUhfja2onhEHb5YR1E+HdgsUrVWcfGcZA
         XuFcpWr3/gUg3i/LJUTLyv0n41UcUHaZE/vk/Lc3DUzWOa90GMrJFaef4wSZAKvn+osx
         lmxg==
X-Gm-Message-State: AO0yUKVQxIpTrk/AY1h+0WCn1PHluTbSSOJ29MnY+DzjLd5JR15qWjdo
        ys5u4EQImXaMmeb4s/RCUL6g9g==
X-Google-Smtp-Source: AKy350a2H1I2/v0FEd3V8KcFa8dpdbVCUU1EG1EKaQttqOIB2bp1YpHz8060guGvg4wLLvbqK16S9g==
X-Received: by 2002:a17:90b:3b4d:b0:234:7ccf:3c7c with SMTP id ot13-20020a17090b3b4d00b002347ccf3c7cmr288308pjb.9.1679604423897;
        Thu, 23 Mar 2023 13:47:03 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090a4d4500b00233aacab89esm1639744pjh.48.2023.03.23.13.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:47:03 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:47:03 -0700 (PDT)
X-Google-Original-Date: Thu, 23 Mar 2023 13:46:06 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: mm: Fix incorrect ASID argument when flushing TLB
In-Reply-To: <mhng-41e9d23d-0d17-4b38-ba7c-1f8369f157d7@palmer-ri-x1c9>
CC:     zongbox@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@kernel.org,
        sergey.matyukevich@syntacore.com, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, x5710999x@gmail.com,
        tim609@andestech.com, peterlin@andestech.com,
        ycliang@andestech.com, Alistair Francis <Alistair.Francis@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dylan@andestech.com
Message-ID: <mhng-6b5819a5-7587-415b-bf97-badb96e106a9@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 22:45:17 PDT (-0700), Palmer Dabbelt wrote:
> On Mon, 20 Mar 2023 19:42:37 PDT (-0700), dylan@andestech.com wrote:
>> On Tue, Mar 14, 2023 at 03:27:30PM +0800, Dylan Jhong wrote:
>>> On Tue, Mar 14, 2023 at 10:22:43AM +0800, Zong Li wrote:
>>> > Dylan Jhong <dylan@andestech.com> 於 2023年3月13日 週一 下午12:29寫道：
>>> > >
>>> > > Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
>>> > > function. We should only take the ASID field to prevent from touching
>>> > > the reserved bit field.
>>> > >
>>> > > Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
>>> > > Signed-off-by: Dylan Jhong <dylan@andestech.com>
>>> > > ---
>>> >
>>> > Hi Dylan,
>>> > Thanks for your patch, if I remember correctly, there was a patch from
>>> > Alistair Francis did the similar fix. Perhaps we should track that
>>> > patch to see why it doesn't be merged. Thanks.
>>> >
>>> > http://lists.infradead.org/pipermail/linux-riscv/2022-March/013558.html
>>> >
>>> Hi Zong,
>>> Thanks for the reminder, I didn't notice that Alistair had sent the same patch before.
>>>
>>> Hi Palmer, Alistair
>>> http://lists.infradead.org/pipermail/linux-riscv/2022-March/013597.html
>>> This patch does not seem to be cherry-picked back to the released linux kernel,
>>> and I have not seen the v4 patch. May I ask how is the follow-up progress of this patch?
>
> Sorry about that, I guess I left it kind of vague as to who was doing
> what.  It looks like we've ended up with enough includes that v3
> actually builds now, it's queued up and should end up in fixes tomorrow
> morning.

Turns out that one still fails some configs, and the one posted here 
doesn't.   So I've got the new one on fixes.

Thanks!

>
> Thanks!
>
>>>
>>> Best,
>>> Dylan
>>>
>>
>> Hi Palmer,
>>
>> Ping. Any update on this?
>>
>> Best,
>> Dylan
>>
>>> > > Changes from v2:
>>> > > - Remove unsued EXPORT_SYMBOL()
>>> > > ---
>>> > >  arch/riscv/include/asm/tlbflush.h | 2 ++
>>> > >  arch/riscv/mm/context.c           | 2 +-
>>> > >  arch/riscv/mm/tlbflush.c          | 2 +-
>>> > >  3 files changed, 4 insertions(+), 2 deletions(-)
>>> > >
>>> > > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>>> > > index 907b9efd39a8..597d6d8aec28 100644
>>> > > --- a/arch/riscv/include/asm/tlbflush.h
>>> > > +++ b/arch/riscv/include/asm/tlbflush.h
>>> > > @@ -12,6 +12,8 @@
>>> > >  #include <asm/errata_list.h>
>>> > >
>>> > >  #ifdef CONFIG_MMU
>>> > > +extern unsigned long asid_mask;
>>> > > +
>>> > >  static inline void local_flush_tlb_all(void)
>>> > >  {
>>> > >         __asm__ __volatile__ ("sfence.vma" : : : "memory");
>>> > > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>>> > > index 80ce9caba8d2..6d1aeb063e81 100644
>>> > > --- a/arch/riscv/mm/context.c
>>> > > +++ b/arch/riscv/mm/context.c
>>> > > @@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>>> > >
>>> > >  static unsigned long asid_bits;
>>> > >  static unsigned long num_asids;
>>> > > -static unsigned long asid_mask;
>>> > > +unsigned long asid_mask;
>>> > >
>>> > >  static atomic_long_t current_version;
>>> > >
>>> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>>> > > index ce7dfc81bb3f..ba4c27187c95 100644
>>> > > --- a/arch/riscv/mm/tlbflush.c
>>> > > +++ b/arch/riscv/mm/tlbflush.c
>>> > > @@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>>> > >         /* check if the tlbflush needs to be sent to other CPUs */
>>> > >         broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>>> > >         if (static_branch_unlikely(&use_asid_allocator)) {
>>> > > -               unsigned long asid = atomic_long_read(&mm->context.id);
>>> > > +               unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
>>> > >
>>> > >                 /*
>>> > >                  * TLB will be immediately flushed on harts concurrently
>>> > > --
>>> > > 2.34.1
>>> > >
