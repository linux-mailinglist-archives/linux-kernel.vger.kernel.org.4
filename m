Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6312C6516C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiLSXiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLSXis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:38:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDA4EE37;
        Mon, 19 Dec 2022 15:38:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so10405093pjo.3;
        Mon, 19 Dec 2022 15:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXhT24A08qIcxdPTrS8ABQk+wBAUtPj45USUD+WsbiA=;
        b=ikqXE5Sv3C0Z7QeUtZToua8qSUDYVrSpl1Z9eJm2snZpS6OYsJc66Mfj20vV+0kPqu
         dJhRFfhQtTYN1idfPqN83/0d5vmM5VLsImAkcxhWamazE/Rzr8GOW4qft50gVwJ4Hhme
         9FnDCgoMYp+l81g3xM7zvGN5i5vgKDqndedskEpd/sQeT2H2JIeNd14Z3ce5m6XtXvot
         t6C0qffyNuSAAtBnkYOAXx8MwJ/Del1fMjSU8HT5jS04SBiPtD2lzNOJZJliwGOsDDBk
         VC10uCA4xKtmWCbS/HtqbWj3Q2c/3GeZueSi6nzS4zUf2jKbbiY97HjsaePUMSCqfFFm
         lxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXhT24A08qIcxdPTrS8ABQk+wBAUtPj45USUD+WsbiA=;
        b=iyskpS0iD2qszOGQTkI9DUXtYv3h/XcqJZsKy44aii4IdDeNJ0k28N9WE72uZfPLop
         Ut5JEbEwZyaSDf/QW2FDkdJORW0H+cJ5zlvo8rJy3wJIu0de1LJtIMMVbz4MahmBxDto
         DBLzVJo7Kx0SAbRPsViINcMGFt8wUtZCkDb0lfrZm5tSAEJrRPvv6AgYkIVn35tEy40T
         vvXfcPlExAv4qzqTKro/pEzzswETWTq4bt8EaNimW/Lv2SRTn+4bh3HIZX4C0tSz6iYr
         yvyoE1VSuYrhCEhbF/Xtk1dAFq25dYUpcOWD0F91AOrTNydKHE0iohP73PzP1VhlV5e3
         m8Pg==
X-Gm-Message-State: ANoB5pnX94wWLlciXObOxgdXKElpiA5DQZgcQSR06W031ZxqC1bhlXGP
        lKYOQB2oa3JTqzjjyn35YoI=
X-Google-Smtp-Source: AA0mqf55hr5HQ4Ig2SkTPhbHUQlrDlMKeYo/BxR2QRmG3IvAb7Xasm3E+qJ9b5UhrNWehUFuiwNBQA==
X-Received: by 2002:a05:6a20:9c8f:b0:a2:17a6:3e86 with SMTP id mj15-20020a056a209c8f00b000a217a63e86mr32379941pzb.55.1671493126783;
        Mon, 19 Dec 2022 15:38:46 -0800 (PST)
Received: from localhost ([124.248.219.206])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0017f8094a52asm7790420plg.29.2022.12.19.15.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Dec 2022 15:38:46 -0800 (PST)
Date:   Mon, 19 Dec 2022 15:38:41 -0800
From:   Dan Li <ashimida.1990@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC/RFT] CFI: Add support for gcc CFI in aarch64
Message-ID: <20221219233841.4ywyegnzqhzfr4fo@ubuntu>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <Y6A/k7/KrCCDuux6@hirez.programming.kicks-ass.net>
 <20221219132731.6ng4sz2nv6ujvu7i@ubuntu>
 <Y6B9l/aDnsek8Zyl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B9l/aDnsek8Zyl@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Peter Zijlstra wrote:
> On Mon, Dec 19, 2022 at 05:32:04AM -0800, Dan Li wrote:
> > Hi Peter,
> > 
> > On 12/19, Peter Zijlstra wrote:
> > > On Sun, Dec 18, 2022 at 10:17:58PM -0800, Dan Li wrote:
> > > 
> > > > 1. When a typeid mismatch is detected, the cfi_check_failed function
> > > >    will be called instead of the brk instruction. This function needs
> > > >    to be implemented by the compiler user.
> > > >    If there are user mode programs or other systems that want to use
> > > >    this feature, it may be more convenient to use a callback (so this
> > > >    compilation option is set to -fsanitize=cfi instead of kcfi).
> > > 
> > > This is not going to be acceptible for x86_64.
> > 
> > I'm not familiar enough with the x86_64 platform, could you please
> > tell me why this is not acceptable? Is there a similar situation
> > on the arm64 platform?
> 
> Mostly because the call would be a 5 byte instruction while the trap
> (UD2) is only 2 bytes.

Oh ok, got it.

> I suspect Argh64 has a similar problem if the to be called function is
> outside the immediate range (26 bits or thereabout), in which case you
> end up with a multi-instruction sequence to construct the call target or
> so. A trap is always a single instruction.
> 

Yes, IIRC, long jumps also typically require at least three instructions
in arm64.

Thanks,
Dan.
