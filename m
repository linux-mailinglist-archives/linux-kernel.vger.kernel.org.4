Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE3650CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiLSNcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiLSNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:32:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB03B4AF;
        Mon, 19 Dec 2022 05:32:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 65so6216698pfx.9;
        Mon, 19 Dec 2022 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBdUZZuJPOmpy2Xr6QADuWry9xil1hvmnye/zX2ZeGs=;
        b=fudn22QQR0cZNc/3RoQpxRlTLjwWSHPdJ3HbEt/WxpuONQEkIQnkWpBlerF9kEPodJ
         nHhQFOykKEx6IwR5/KfRtAGdVyduWE4KKnkENOc2szemL+pJqARz2salHLoW95MwEbdA
         4l8C9DgDXblVaaqJ7qI9X4RGT4ChxV2bMC1ENtWvdqwdBfsedCwcpXE4H+LW+wNxHezu
         PrVxhEJl0r5aoDk7qfpvB3XMyrRfWqp0XjyDX+nwKDJBCaYRg3q9T6oErlC4ykTpLMIo
         lmb8XMScdS8JKQTabKQpf5aytupGC3t56WCAiBDQ8xriUGgm665URRddp66Cq+IxHZ93
         WjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBdUZZuJPOmpy2Xr6QADuWry9xil1hvmnye/zX2ZeGs=;
        b=NZze9NEex9MfOc3iDBsBjPey57X6RG+vs1+b1piUzXC3ZmeHi+YKiYDGXk5tMcM1Wu
         v2NlhLwVhZVfS8mIa1xlOEewoQWtlivWQTZlwBeKgly/FGPV3+P63jbBwlxc833WvSJw
         8GMShVvwHUubpVvSfIa4ChKAkrreH5J9Vssxkmik2tEwcu8WIk6OJUotjlkUjx1UOWZB
         O7MdQdr5cyA5IT91+mIoX55aa5bXnSbFSIIXzZEkJN8PgCRH9ITeQd8xeJya8apC0bGM
         6ehcNMV4XVQvcWgQDKnYwQiRGmoIbCwoMlGDHZATXQqJGaAs58jjoKrVdzd090dOuMYo
         N+aw==
X-Gm-Message-State: ANoB5plLRspcAG57ULJdBOpNZf0OVn2hoTze/BxoaW26Jb0BxDL7D39W
        cICNpP0eybCdI1h9WwzvIxA+CS+twxCXGNJ65U8=
X-Google-Smtp-Source: AA0mqf7lo7GM8x5UdwEdtv60/3460fbiPsGJh8g4HC8TKv3RHlSb+qHW4uv3yzbalqxIGN7bytAd6Q==
X-Received: by 2002:aa7:9f04:0:b0:577:4168:b5ef with SMTP id g4-20020aa79f04000000b005774168b5efmr42472793pfr.3.1671456729555;
        Mon, 19 Dec 2022 05:32:09 -0800 (PST)
Received: from localhost ([124.248.219.206])
        by smtp.gmail.com with ESMTPSA id s7-20020a625e07000000b0057691fb0d37sm6553392pfb.193.2022.12.19.05.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Dec 2022 05:32:09 -0800 (PST)
Date:   Mon, 19 Dec 2022 05:32:04 -0800
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
Message-ID: <20221219132731.6ng4sz2nv6ujvu7i@ubuntu>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <Y6A/k7/KrCCDuux6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6A/k7/KrCCDuux6@hirez.programming.kicks-ass.net>
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

Hi Peter,

On 12/19, Peter Zijlstra wrote:
> On Sun, Dec 18, 2022 at 10:17:58PM -0800, Dan Li wrote:
> 
> > 1. When a typeid mismatch is detected, the cfi_check_failed function
> >    will be called instead of the brk instruction. This function needs
> >    to be implemented by the compiler user.
> >    If there are user mode programs or other systems that want to use
> >    this feature, it may be more convenient to use a callback (so this
> >    compilation option is set to -fsanitize=cfi instead of kcfi).
> 
> This is not going to be acceptible for x86_64.

I'm not familiar enough with the x86_64 platform, could you please
tell me why this is not acceptable? Is there a similar situation
on the arm64 platform?

> > 5. The current implementation of gcc only supports the aarch64 platform.
> 
> What, if any, are the plans for x86_64 support?

I'd like to implement something similar on x86_64 later, but
currently I'm doing this in my spare time, so it might take a
little longer. :(

Thanks,
Dan
