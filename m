Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACFC5E80B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiIWRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIWRaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:30:22 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4B191DA9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:30:21 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12c8312131fso1213687fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+N5oyJcUF3g1nnHU8kFVJBXuR6Tvqo+haLUBkWOmg1k=;
        b=cbYNEyjgOIPQtU2o5K7hMM8JO4382oIKH0Sk7l/bQecXKjHVzblInrltQc1kaeTuL3
         nUlEg/vcaK+KRt+6Xh/j9ty9gXqxBfDu+ftIF6MhLUv5lsOGNYU9kwinFlAC6AgadvAx
         N9+AWcNagwT31KeH1mluHfkjjceYjzf3hdiB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+N5oyJcUF3g1nnHU8kFVJBXuR6Tvqo+haLUBkWOmg1k=;
        b=l7vBd+CFtkMpkuG3DAavO9wJCKv8T8DIZiwDprzx0jAkoSchokOppbIk6NYQw6R9Bm
         hvlw9CFEFBt5T6j9ie6L+5PI8ith92M08ugWLRt2xVCMBoMZx2pSlpJVa8D0c+f6+es2
         kkC9wDIrIyxPP3r8Aaw/c5sxq4TS3c2tsdnDVgrkAxh/7kQ1IQJj/409hJZaqWPSnw5c
         7hLsmjUOZ6791y/Enr2wfbsmX8h9c6AMZTcquViG9u1onIQwV+BEAhfeAIoiyfzyRUw0
         ZJx+v9wDwZxohOpAmLOXfTq7WCRVvgQFdAMCvXBb5Ep+8EYbQr0XNAVqJte0I8mVxOho
         4VWw==
X-Gm-Message-State: ACrzQf2WjN7S0x8eNInEcTjB3Gm1NJNvM4ivT5+gTbLFqENbxARXYUHb
        5ymastizKG9kHpegB2WKvYsLTCoUO6LVmg==
X-Google-Smtp-Source: AMsMyM4ZRZQ0iFy/rdL/ZDsuHaKTgou0QWgVFL1H5PFvlzbIllPBQ3LYPUUR/TOVAinOLfDhRdIVAA==
X-Received: by 2002:a05:6871:98:b0:12c:8f0d:c868 with SMTP id u24-20020a056871009800b0012c8f0dc868mr11900684oaa.295.1663954219345;
        Fri, 23 Sep 2022 10:30:19 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0685000000b00655bab150d6sm4189501otx.59.2022.09.23.10.30.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:30:15 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so477904oth.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:30:15 -0700 (PDT)
X-Received: by 2002:a9d:3623:0:b0:655:dae2:6852 with SMTP id
 w32-20020a9d3623000000b00655dae26852mr4667060otb.176.1663954214778; Fri, 23
 Sep 2022 10:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170218.1188423-1-ndesaulniers@google.com>
In-Reply-To: <20220923170218.1188423-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Sep 2022 10:29:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAwEA5KekL4+t+v6qAdKLSOQvBkGbumvk+Rxhaay8aFg@mail.gmail.com>
Message-ID: <CAHk-=wiAwEA5KekL4+t+v6qAdKLSOQvBkGbumvk+Rxhaay8aFg@mail.gmail.com>
Subject: Re: [PATCH] x86, mem: move memmove to out of line assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Lutomirski <luto@kernel.org>, Ma Ling <ling.ma@intel.com>
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

On Fri, Sep 23, 2022 at 10:02 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> memmove is quite large and probably shouldn't be inlined due to size
> alone. A noinline function attribute would be the simplest fix, but
> there's a few things that stand out with the current definition:

I don't think your patch is wrong, and it's not that different from
what the x86-64 code did long ago back in 2011 in commit 9599ec0471de
("x86-64, mem: Convert memmove() to assembly file and fix return value
bug")

But I wonder if we might be better off getting rid of that horrid
memmove thing entirely. The original thing seems to be from 2010,
where commit 3b4b682becdf ("x86, mem: Optimize memmove for small size
and unaligned cases") did this thing for both 32-bit and 64-bit code.

And it's really not likely used all that much - memcpy is the *much*
more important function, and that's the one that has actually been
updated for modern CPU's instead of looking like it's some copy from
glibc or whatever.

To make things even stranger, on the x86-64 side, we actually have
*two* copies of 'memmove()' - it looks like memcpy_orig() is already a
memmove, in that it does that

        cmp  %dil, %sil
        jl .Lcopy_backward

thing that seems to mean that it already handles the overlapping case.

Anyway, that 32-bit memmove() implemented (badly) as inline asm does
need to go. As you point out, it seems to get the clobbers wrong too,
so it's actively buggy and just happens to work because there's
nothing else in that function, and it clobbers %bx that is supposed to
be callee-saved, but *presumably* the compile has to allocate %bx one
of the other registers, so it will save and restore %bx anyway.

So that current memmove() seems to be truly horrendously buggy, but in
a "it happens to work" way. Your patch seems an improvement, but I get
the feeling that it could be improved a lot more...

              Linus
