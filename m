Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208425F1032
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiI3Qnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiI3Qnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:43:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FDA19868F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:43:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r62so4602571pgr.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bsd0Z4BBhM7Ch09POH37+LOvSTGUvuf/hXwL96S/REQ=;
        b=myU24/86ibLxLmheNjBfWjX5LgM0eddArBW/+Q+BITGiD1A8K4kRbVv9B1lPfVH1o1
         Oj7xtMHs8tottc7saHhuUkj5pzYmny8OqrA/fGdif0kkxTvm484ZVeOOxZjB5n5SzY8o
         T6ZSiTayWcLrkmAJhI/Qu3cBBiElwIUvl5LOU2W9UH5SzUBPtU1jsq9k7JUn4ij3PLFJ
         Dfmh//YNBOXnENrUm8NZHM2AkGUHOUIE84puM8T392QFLV6y+1iDWAOQdlq6IVYDyslc
         8V1D4+Ma+wAthCBAxvThO7qL8D/EamgAuNBnQzJpqWK5Onu2UdYwiIwphF1EEv7FZiaF
         yuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bsd0Z4BBhM7Ch09POH37+LOvSTGUvuf/hXwL96S/REQ=;
        b=lDTx/OHhqXKjoZJD4o6aQde/a7dRk83EbpsAYoJNdXC7dRkJVzgnu2S3MzYRYM32Ox
         Gci7RCniQOUk0zaVjsHOcpBwjhaQ+zKPODIYBMSZGkH1lbT7Rwb13R2TE8DsSowkLG/w
         AUVidiuL62KT/9yFK5BIuxW7Wl94kT+nS1nEz/iqzpVkgAbPxPXSHX+OP9MIvmD1eM59
         BxAQYeZ4pepe5/WNmiuk/96gJSytAJpvZ1xIXDYqWwBp2mYJy6j5knNOsCQQIzYAhpI9
         Kl0kzfQWUXpvrioKEJxfbm+XqyoUIcL7qLDe1ByNX7NqVd97ScNUh3fMzJAiKOiy9uCC
         9K7Q==
X-Gm-Message-State: ACrzQf0Iv+bzOupgn4SZ/i+GaxmRAFLRi5G7vAUk5h3wy/RenmbbrhKK
        kMH/mU9uvmBxCXEnDiSwFsLdVd7yYzrp4TzrmWZjzA==
X-Google-Smtp-Source: AMsMyM6maCc05NRZH/ztoF2+9Ke0YJa7WnQh0ThBhaX7R2rZhWITniCQz909Jxl0QDHkmSJywdFSHrY+3PrjQgQZRQk=
X-Received: by 2002:a05:6a00:4c11:b0:53e:4f07:fce9 with SMTP id
 ea17-20020a056a004c1100b0053e4f07fce9mr10192779pfb.66.1664556218944; Fri, 30
 Sep 2022 09:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
 <20220928210512.642594-1-ndesaulniers@google.com> <5672845ec66744df9ee0f0c56031ab00@AcuMS.aculab.com>
In-Reply-To: <5672845ec66744df9ee0f0c56031ab00@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Sep 2022 09:43:27 -0700
Message-ID: <CAKwvOd=QsUGZ2ZF_3xHb0dG0JF=f9e3_vHvU+rsj0eXfAQP86g@mail.gmail.com>
Subject: Re: [PATCH v4] x86, mem: move memmove to out of line assembler
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 2:55 AM David Laight <David.Laight@aculab.com> wrote:
>
> Oh - and why do all the labels have 'byteswap' in them?

.Lbyteswap is swapping single bytes at a time.
.L4_byteswap is swapping 4 bytes at a time.
.L8_byteswap is swapping 8 bytes at a time.
.L16_byteswap, .L16_byteswap_backwards_loop, and
.L16_byteswap_forwards_loop are swapping 16 bytes at a time.

When doing a move that has to be delicate with respect to overlap, I
thought it was helpful to know how many bytes are being swapped in a
given run of instructions. The names were chosen were based on the
comparison/guards/conditional jmps.

---

Linus pointed out that this 32b memmove looks similar to 64b
memcpy_orig.  Would you prefer me use those labels?

s/.Lbyteswap/.Lstore_1byte/
s/.L4_byteswap/.Lless_3bytes/
s/.L8_byteswap/.Lless_8bytes/
s/.L16_byteswap/.Lless_16bytes/
s/.L16_byteswap_backwards_loop/.Lcopy_backward_loop/
s/.L16_byteswap_forwards_loop/.Lcopy_forward_loop/

or something else?
-- 
Thanks,
~Nick Desaulniers
