Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5462C89B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiKPTBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiKPTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:01:02 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551A2937E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:01:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so17517900pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+m20rR3qhKhCrc29Q5gHN0J/IycK26+ExfyYRWAbxM=;
        b=oPjKBUJip/NbE0rH0KF9GTjzHqfPLWKTiHey//bhup5ED99PU9TNEQMSrYZgx5MCBN
         7IwZmAtSSdsfFSKdujd1ZdetFBP20bZRhPbT9qXb1ZF7vkOshGLYSWApXRY6aIPn/yog
         O7VytRKfLSQaXk8Uol773dYXc+9VGmQoWCPTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+m20rR3qhKhCrc29Q5gHN0J/IycK26+ExfyYRWAbxM=;
        b=O++DBqGMIiMHK1U5vrPda7axohSpEEYDboulOpym/XYtwuORnAqjBKzyg+fBG4UfLA
         hn/ybDXQcq/Z+mO51ax+/mzdmjGVSGFlBYmdgJoWCZSvA89TT6td+nkIwcu/5Lpi8A9t
         m4ONRqckDCNxS15klW4HeBA+uIQlNx4JU8sIDdmg5vfxrt1r9vv43v2FviG3ilkjPEIv
         fpzgQb6BOwnwHe9/ZgFBRoQCP1o6Q1I7roOxiUcZqriNc4Kcz+tughhls0A5WnaQna3F
         ogAPkGV1JeMg+QlFqv30Fq/giGb5+ei66iQ/h7mFq0CGNoN6KHWJSZOk9PIbuXtBuAbm
         BgCQ==
X-Gm-Message-State: ANoB5pmYAvpr7jFeTaVkn5GMGgdWQuroHsPzr7Ph8vZcRlbofpsEQVKB
        Hb9pIamzNq3MP4ozPaNsAKPOwA==
X-Google-Smtp-Source: AA0mqf4p6evEu4ZN/N8pP4qI1fAjq39YR/zQPw1X1lUbbEqe/ZUAu/HpErifB2QIOfINRYqX5Sg4RA==
X-Received: by 2002:a63:b5b:0:b0:46e:a4ed:467e with SMTP id a27-20020a630b5b000000b0046ea4ed467emr21973376pgl.319.1668625260178;
        Wed, 16 Nov 2022 11:01:00 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z19-20020a630a53000000b00476db6fe510sm2287032pgk.75.2022.11.16.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:00:59 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:00:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] kbuild: fix SIGPIPE error message for AR=gcc-ar and
 AR=llvm-ar
Message-ID: <202211161056.1B9611A@keescook>
References: <20221027162839.410720-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027162839.410720-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:28:39AM +0900, Masahiro Yamada wrote:
> Jiri Slaby reported that building the kernel with AR=gcc-ar shows:
>   /usr/bin/ar terminated with signal 13 [Broken pipe]
> 
> Nathan Chancellor reported the latest AR=llvm-ar shows
>   error: write on a pipe with no reader
> 
> The latter occurs since LLVM commit 51b557adc131 ("Add an error message
> to the default SIGPIPE handler").
> 
> The resulting vmlinux is correct, but it is better to silence it.
> 
> 'head -n1' exits after reading the first line, so the pipe is closed.
> 
> Use 'sed -n 1p' to eat the stream till the end.

I think this is wrong because it needlessly consumes CPU time. SIGPIPE
is _needed_ to stop a process after we found what we needed, but it's up
to the caller (the shell here) to determine what to do about it.

Similarly, that LLVM commit is wrong -- tools should _not_ catch their
own SIGPIPEs. They should be caught by their callers.

For example, see:

$ seq 10000 | head -n1
1

^^^ no warnings from the shell (caller of "seq")
And you can see it _is_ being killed by SIGPIPE:

$ strace seq 1000 | head -n1
...
write(1, "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14"..., 8192) = 8192
1
write(1, "\n1861\n1862\n1863\n1864\n1865\n1866\n1"..., 4096) = -1 EPIPE (Broken pipe)
--- SIGPIPE {si_signo=SIGPIPE, si_code=SI_USER, si_pid=3503448, si_uid=1000} ---
+++ killed by SIGPIPE +++

If we use "sed -n 1p" seq will continue to run, consuming needless time
and CPU resources.

So, I strongly think this is the wrong solution. SIGPIPE should be
ignored for ar, and LLVM should _not_ catch its own SIGPIPE.

-Kees

> 
> Fixes: 321648455061 ("kbuild: use obj-y instead extra-y for objects placed at the head")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1651
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> 
> Changes in v2:
>   - Update commit description to mention llvm-ar
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index e90bb2b38607..e9e7eff906a5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
>        cmd_ar_vmlinux.a = \
>  	rm -f $@; \
>  	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> -	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
> +	$(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
>  
>  targets += vmlinux.a
>  vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
> -- 
> 2.34.1
> 

-- 
Kees Cook
