Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E65E818C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiIWSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiIWSIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:08:37 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438413F29C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:06:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n124so767449oih.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7MxhNKa1pvBKJp28Xv5e7IbSBJSuN9UMxkwoiOtIFKY=;
        b=Uus7wQdUDWk44FDSQwJEpQB43nLtULU3gyubvF9ig6sLMhsYrBW/fT2eLkiDXP/j6F
         P8xdVmW3N/dGsk8WF9zq/xPDaInuSjL/UbWGHKH4lK2Gs07qj03YePC6fPmCyOZPJojh
         hz5XN5aYK3eXpYOOVGRIC5XgtO0t1EVMFkDuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7MxhNKa1pvBKJp28Xv5e7IbSBJSuN9UMxkwoiOtIFKY=;
        b=l+mmocHLizTAPPTpnytgxrkntZnd44q2Caeklv9kgPewEf8WnQ0DONJHuQWVI54UeV
         D0cryvyM+UHBgX/A6Y/ZKF/CvmMd+YsXQAq0oh8dhixQ8K/12rIIPzWUF1mEWRwdG5J+
         PbpZEH/TjWK1BggHKLtoheOdmHOphdDsAWP8eMSflHTUDDb3bb7RUmo9Lbi1L0tvs4rV
         n0MF5h9CHMrl3lBhu3yuNC3bI7J35jhp0yauLM7qgJTD56JeG3axWRNBoqnx2QvIgifA
         1TkieU9rO+9cPIMS+2IAO+HI6RCdFl2UsOx+j1P8IW+SapBYKYXUVa/7IxSPqeAEM/lb
         UbiQ==
X-Gm-Message-State: ACrzQf2tnEUuO/vEienmzpa5IqWQGu+hhSMXV9BKzSc+nrumIYYBUBfY
        D5gN5lZZkxfY1rSDSl5ThmgRdMbbHSxpKA==
X-Google-Smtp-Source: AMsMyM77LnmnnYiy+LpLVf11fD7ZZMbu3XhMCIHajapewcioTKMT9M97TTh3FypNCX0TQRlK1UA3VQ==
X-Received: by 2002:a05:6808:1687:b0:347:cbd3:3dcf with SMTP id bb7-20020a056808168700b00347cbd33dcfmr4866546oib.53.1663956380417;
        Fri, 23 Sep 2022 11:06:20 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id x18-20020a056870b41200b0012d6f3d370bsm5144727oap.55.2022.09.23.11.06.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 11:06:18 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11eab59db71so1295758fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:06:16 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5725740oad.126.1663956375518; Fri, 23
 Sep 2022 11:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170218.1188423-1-ndesaulniers@google.com>
 <CAHk-=wiAwEA5KekL4+t+v6qAdKLSOQvBkGbumvk+Rxhaay8aFg@mail.gmail.com> <CAKwvOd=r+9X6JkikpuTvjdTn7DXusevoJBFjXtGQ1SZYCZ6f6g@mail.gmail.com>
In-Reply-To: <CAKwvOd=r+9X6JkikpuTvjdTn7DXusevoJBFjXtGQ1SZYCZ6f6g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Sep 2022 11:05:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whknQuJCqbzjtBrkjGOPrZPX6fjv8HSms2p0kw-NTdMZA@mail.gmail.com>
Message-ID: <CAHk-=whknQuJCqbzjtBrkjGOPrZPX6fjv8HSms2p0kw-NTdMZA@mail.gmail.com>
Subject: Re: [PATCH] x86, mem: move memmove to out of line assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Lutomirski <luto@kernel.org>
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

On Fri, Sep 23, 2022 at 10:55 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> We could remove __HAVE_ARCH_MEMMOVE from
> arch/x86/include/asm/string_32.h for ARCH=i386 then rip this
> arch-specific definition of memmove out.
>
> Might performance regressions be a concern with that approach?

memmove() isn't particularly common, but it does happen for some paths
that can be hot - the usual case of moving parts of an array around. I
see filesystems and networking paths doing that.

The generic memmove() is a horrendous byte-at-a-time thing and only
good for bring-up of new architectures. That's not an option.

But I'm looking at that x86-64 memcpy_orig, and I think it looks
fairly good as a template for doing the same on x86-32. And we could
get rid of the duplication on the x86-64 side.

That said, your patch looks fine too, as a "minimal changes" thing.

                Linus
