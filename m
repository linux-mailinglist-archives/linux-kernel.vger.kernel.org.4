Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788B5F1039
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiI3QrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiI3QrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:47:06 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BCC4B9A1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:47:05 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-13189cd5789so6079051fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ejkO549z4V4tBXsuJSnJcLjr+xb5uPcOfoYg03WmHAU=;
        b=JWB4zGbVaYzLZLBUCo+rtY5Wi5gTziOGiA84Mq5RidDu/lAUxPTTaeXI5+yUYVWkvk
         ZQltiVOIX7xrhl3wJp8NqRGhWaEQmiZDtRSb8Wn0AsWYyoLgq4PsZv024rzhpq+ZKzoi
         INpypXwPxYs3sBVwItsvqi5cdqG9vt2TkU0WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ejkO549z4V4tBXsuJSnJcLjr+xb5uPcOfoYg03WmHAU=;
        b=RMEnO3c0XJzPUuxbsGbw1BI41tVlwJa9V8jlEIYRmG0UQJ356aKU9b8S1g4NMNLW3X
         CBJJXByAlJfviZSDLwcrBgiGHDsTa4GH9HMPRtlMr8QeyrF1MuN1R4UWO/qYmwiMbXqx
         6DTYuqlqiPlygxPFFmPiSA5AgUgxLSlOoD9wmimskwTH1tsacb2Lz1JeSRUJzdUaDXsC
         LMrn35C9R0meQmMcNkpDQV0ISQzAfkx5NM1zdCbNv7Wn4kjD5JQr5B+RY04ul9s7u6Rn
         edY6RA8s+g/sF/1yRyBHygmxn6nD9idGjwKvTL2v4zi8i3OK8T09+AH/vkQKtPqoFpZI
         fwrw==
X-Gm-Message-State: ACrzQf1LX5s3Y9Nc4w/uMSmVxbQBGmt/nOGgHsPbW/RmVxA8t8W+Yeyu
        X/NKAOucNypX2PazBKSth7cqL5UDgMUpXQ==
X-Google-Smtp-Source: AMsMyM49yo0z3YMTCKXEJIRoxYPOmTlPr0+jfmVd+RXbpkO4c1n62JSWjCHuqTf+cUlB5NYd4+gUPQ==
X-Received: by 2002:a05:6870:350d:b0:127:51b9:30a1 with SMTP id k13-20020a056870350d00b0012751b930a1mr5335818oah.65.1664556425170;
        Fri, 30 Sep 2022 09:47:05 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a4a3f41000000b00432ac97ad09sm552608ooe.26.2022.09.30.09.47.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 09:47:05 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-13189cd5789so6079003fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:47:04 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr5502798oab.229.1664556424468; Fri, 30
 Sep 2022 09:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
 <20220928210512.642594-1-ndesaulniers@google.com> <5672845ec66744df9ee0f0c56031ab00@AcuMS.aculab.com>
 <CAKwvOd=QsUGZ2ZF_3xHb0dG0JF=f9e3_vHvU+rsj0eXfAQP86g@mail.gmail.com>
In-Reply-To: <CAKwvOd=QsUGZ2ZF_3xHb0dG0JF=f9e3_vHvU+rsj0eXfAQP86g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Sep 2022 09:46:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXWNx_c7XsYLRtKTpG2L0uVJuSm=hOX81m7Lb=U4PWHA@mail.gmail.com>
Message-ID: <CAHk-=wgXWNx_c7XsYLRtKTpG2L0uVJuSm=hOX81m7Lb=U4PWHA@mail.gmail.com>
Subject: Re: [PATCH v4] x86, mem: move memmove to out of line assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 9:43 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 30, 2022 at 2:55 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > Oh - and why do all the labels have 'byteswap' in them?
>
> .Lbyteswap is swapping single bytes at a time.
> .L4_byteswap is swapping 4 bytes at a time.
> .L8_byteswap is swapping 8 bytes at a time.
> .L16_byteswap, .L16_byteswap_backwards_loop, and
> .L16_byteswap_forwards_loop are swapping 16 bytes at a time.

I think the objection here is that there is no "swap".

A "byte swap" in particular is generally a byte order operation (ie
swapping bytes within one word). And "swap" in general is about
switching the value of two things.

Here, the "byteswap" code sequences just move data in one direction.
No "swap" anywhere that I can see.

             Linus
