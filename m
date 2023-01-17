Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FC666E6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjAQTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjAQTLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:11:17 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2703831E23
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:25:36 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o5so6919263qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/Yj1dkETHJ3x/vd9B2cSXc0BtF92b0sf7AI+rPbVN0=;
        b=XCLE/+dWnhPFHp0Rjc45XkkaJtd/3aeBb1T0m6KOH6FOQ3duqOHkSne6Erdt0xqRvR
         LQe+kifp9lcJdtA03kTU5SGMsqQugmGdSLpd2Q2WTVkHIhWK7chONEMxksCRtnlBR/+e
         GyV+R9HcOZ5gfXDs6DPbyI/iCP1P/BakruKyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/Yj1dkETHJ3x/vd9B2cSXc0BtF92b0sf7AI+rPbVN0=;
        b=XcK3YXyk6ShgUlMPA2tJbyrLSo1NTGh2Bgz0iGecXI6Tb4wUWnpfivFOzxddr1KDlf
         zHJfpCk+KeUbRE65012XbhmYdNtEO9BbiSFn+mwda4wYZZ/PspLFnzcvTmljKMSuilqX
         2xLTDSvT3TYBaf7PzYiw09+F5oMbqd2xcKPDrT+Wek0ZTnT4WW78LZDQP+y5D8uhgUju
         TojsGabErmsEVMSoPm1JF8rtxpHanEdg19rPTXp5wquTk8L6N94tb/tywl9zvPfOvLcA
         oHKzQGWS5jkrzaVSqPfn/HLo7hIBSVr+h6hmwyYt3NYO7FMy/dfsNH33qwdf+4bj7mxp
         HH+Q==
X-Gm-Message-State: AFqh2ko/CwF+ZIZIgMupUaayrI4pZP/Ya8zt6jc7jhjszmSvMVXyGB4n
        TyXdXcqAf1AzARd6KXKU1oWczvHieD/dS6Xs
X-Google-Smtp-Source: AMrXdXvhZodODcUcsGNV0xgEFIC+hQHL5K5fWgufnCQKt8N5gkAlUjOo9Coc4z1iJo0EcjWQg5vueA==
X-Received: by 2002:ac8:4686:0:b0:3a5:7a30:bd22 with SMTP id g6-20020ac84686000000b003a57a30bd22mr4876696qto.53.1673979934890;
        Tue, 17 Jan 2023 10:25:34 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a0e0f00b006f7ee901674sm20500073qkm.2.2023.01.17.10.25.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 10:25:34 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id s19so3115645qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:25:33 -0800 (PST)
X-Received: by 2002:a37:4651:0:b0:705:b232:4ed9 with SMTP id
 t78-20020a374651000000b00705b2324ed9mr143177qka.216.1673979933694; Tue, 17
 Jan 2023 10:25:33 -0800 (PST)
MIME-Version: 1.0
References: <202301170941.49728982-oliver.sang@intel.com> <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
 <Y8ZVxJSZdtEk8Nco@feng-clx> <Y8aSc5xGO+rW2pyo@feng-clx>
In-Reply-To: <Y8aSc5xGO+rW2pyo@feng-clx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 10:25:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
Message-ID: <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906: kernel_BUG_at_lib/list_debug.c
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, hongjiu.lu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 4:22 AM Feng Tang <feng.tang@intel.com> wrote:
>
> With the following patch to use 'O1' instead 'O2' gcc optoin for
> page_alloc.c, the list corruption issue can't be reproduced for
> commit 7118fc2906 in 1000 runs.

Ugh.

It would be lovely if you could just narrow it down with

  #pragma GCC optimize ("O1")
 ...
  #pragma GCC optimize ("O2")

around just that prep_compound_page(), but when I tried it myself I
get some function attribute mismatch errors.


> As is can't be reproduced with X86_64 build, it could be i386
> compiling related.

Your particular config causes a huge amount of nasty 64-bit arithmetic
according to the objdump code, with sequences like

  c13b3cbb:       83 05 d0 28 6c c5 01    addl   $0x1,0xc56c28d0
  c13b3cc2:       83 15 d4 28 6c c5 00    adcl   $0x0,0xc56c28d4

which seems to be just from some coverage profiling being on
(CONFIG_GCOV?), or something. It makes it very hard to read the code.

You also have UBSAN enabled, which - again - makes for some really
grotty asm that hides any actual logic.

Finally, your objdump version also does some horrendous decoding, like

  c13b3e29:       8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi

which is just a 7-byte 'nop' instruction, but again, it makes it
rather hard to actually read the code.

With the i386 defconfig, gcc generates a function that is just ~30
instructions for me, so this makes a huge difference in the legibility
of the code.

I wonder if you can recreate the issue with a much more
straightforward config. By all means, leave DEBUG_PAGEALLOC and SLUB
debugging on, but without the things like UBSAN and GCOV.

> I also objdumped 'prep_compound_page' for vmlinux of 7118fc2906 and
> its parent commit 48b8d744ea84, which have big difference than the
> simple 'set_page_count()' change, but I can't tell which part is
> abnormal, so attach them for further check.

Yeah, I can't make heads or tails of them either, see above on how
illegible the objdump files are. And that's despite not even having
all of prep_compound_page() in them (it's missing
prep_compound_page.cold, which is probably just UBSAN fixup code, but
who knows..)

That said, with the i386 defconfig, the only change from adding
set_page_count() to the loop seems to be exactly that:

 .L589:
-       movl    $1024, 12(%eax)
+       movl    $0, 28(%eax)
        addl    $32, %eax
+       movl    $1024, -20(%eax)
        movl    %esi, -28(%eax)
        movl    $0, -12(%eax)
        cmpl    %edx, %eax

(don't ask me why gcc does *one* access using the pre-incremented
pointer, and then the rest to the post-incremented ones, but whatever
- it means that it's not just "add a mov $0", it's also changing how
the

        p->mapping = TAIL_MAPPING;

instruction is done, which is that

-       movl    $1024, 12(%eax)
+       movl    $1024, -20(%eax)

part of the change)

             Linus
