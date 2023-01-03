Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1AA65B903
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbjACBpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjACBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:45:39 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24E6300
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 17:45:39 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-142b72a728fso35322300fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 17:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tQTxcF2kZv4wRvqcsIJ1yFTjIynEnuDUEOYIkd31nY=;
        b=VrLDwYXe1s/fEBRTSbLyNixsSi7ht/R7eUAtUTyses6ZbvkQL17KSTDly+vbM84l4E
         cwwgTj1LfnFa3mc8XRxYH4HKCXUQreW591/IM1zCTqutJWV9j7XIke9SNYRG89y2Xri0
         CmYWCN+I87gcZ0uNqW1vkEhrkGakl+STdDkLbxz/BBkLhXHyRPhvj79I8kIDN8iRzje8
         hZ5UsTHxu8yp/PIM8dusta0p1veP63/6EndAWF1T5S9peIHKlZyB0OFRytqsOShZnjVP
         NLpQo3X3e310grIloJbvl0ga9fHs43K7+N+Mhyw64Y40DqFCf42wtX7BRHcneQvlHE6l
         NDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tQTxcF2kZv4wRvqcsIJ1yFTjIynEnuDUEOYIkd31nY=;
        b=yAliTAp+4cqcjWfKMvCFTzLS8q6eHbsYMuIZE+GKjXFNr3AxLxQUL6ZrmgvbqeIONc
         f9sxwcpleWwPk1JG3KGDF54IWLVbgbKbsd5sP4owsiYnv62VVkQBaFYduYJWotOSam8s
         V0asEkq+0SDASFdWhUxcB6R5a/Bfhe2slY00qr5VYgT37Pcogss+8iJiHUJrCpM32s+n
         lZgbmrnh5FRrTfHESSb0kjVZdZJ7lDqOzrdnMU5DAaocj1jKhborYlntAM1pjKn8anvE
         a42W6nFJRVDD00wyE2yGuGag0mM2oOsnJCuJ04iuhDZnDtvhMztVugm1gW/yxWRQb/OV
         0vpA==
X-Gm-Message-State: AFqh2kpE31sIV8aCA/HW/QYHYbpi9jHElIq4ebz5p+orAieH65lzUHWt
        xyqFXyQ2XiW+qNHN4WzZKho=
X-Google-Smtp-Source: AMrXdXsyTcarFyp4Fo89QdKyuxRgpz9jmIUuB4rtBGW8CP9a+KzccvGWbnAAfZWPlP/rYoMvFUSxOg==
X-Received: by 2002:a05:6870:4b91:b0:150:8095:2687 with SMTP id lx17-20020a0568704b9100b0015080952687mr6532964oab.11.1672710337673;
        Mon, 02 Jan 2023 17:45:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cy4-20020a056870b68400b0013bc40b09dasm13574500oab.17.2023.01.02.17.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:45:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 2 Jan 2023 17:45:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Linux 6.2-rc2
Message-ID: <20230103014535.GA313835@roeck-us.net>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
 <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:21:41PM -0800, Linus Torvalds wrote:
> [ Adding Jason in case he has any ideas, and seeing if sh maintainer
> emails are still valid, and Arnd in case they aren't ]
> 
> On Mon, Jan 2, 2023 at 2:57 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > One detail to mention, though, is that sh:rts7751r2dplus_defconfig
> > no longer builds with older versions of binutils (2.32). Trying to
> > do so results in the following build error.
> >
> > `.exit.text' referenced in section `__bug_table' of drivers/char/hw_random/core.o:
> >         defined in discarded section `.exit.text' of drivers/char/hw_random/core.o
> >
> > To make this more interesting, kernels older than v5.10 do not boot
> > (at least not in qemu) when images are built with binutils 2.27 or newer.
> > That is why I had used binutils 2.32 in the first place.
> >
> > I didn't bother tracking this down but switched to binutils 2.39 when
> > building v5.10+ images.
> 
> I have to admit that I can't really see myself carding deeply about
> SH, but somebody else may. I don't think I've gotten an arch/sh pull
> in a couple of years.
> 
> That said, I also don't see anything wrong with the arch/sh version of
> BUG() and friends, so I don't see why this would hit arch/sh and not
> somebody else.
> 
> I _assume_ it is the BUG_ON() in hwrng_modexit() that triggers this:
> 
>   static void __exit hwrng_modexit(void)
>   {
>         mutex_lock(&rng_mutex);
>         BUG_ON(current_rng);
>         kfree(rng_buffer);
>         ...
> 
> but again, I don't see what's special about sh here apart from maybe
> "not well maintained binutils support".
> 
> Does removing the BUG_ON() fix the build?
> 

It does, but it wasn't changed recently. Bisect results:

# bad: [88603b6dc419445847923fcb7fe5080067a30f98] Linux 6.2-rc2
# good: [c8451c141e07a8d05693f6c8d0e418fbb4b68bb7] Merge tag 'acpi-6.2-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect start 'HEAD' 'c8451c141e07'
# bad: [8b41948296b76588f5ebaf7cbc5be5c803ece70a] Merge tag 'drm-fixes-2023-01-01' of git://anongit.freedesktop.org/drm/drm
git bisect bad 8b41948296b76588f5ebaf7cbc5be5c803ece70a
# bad: [6a5e25fc3e0b94301734e8abb1d311a1e02d360d] fixdep: remove unneeded <stdarg.h> inclusion
git bisect bad 6a5e25fc3e0b94301734e8abb1d311a1e02d360d
# bad: [9c9b55a59416a87fc73c479d78cb3218076dbc30] kbuild: add a missing line for help message
git bisect bad 9c9b55a59416a87fc73c479d78cb3218076dbc30
# bad: [99cb0d917ffa1ab628bb67364ca9b162c07699b1] arch: fix broken BuildID for arm64 and riscv
git bisect bad 99cb0d917ffa1ab628bb67364ca9b162c07699b1
# good: [da8daff9405e55baa1f797b77a7c629a89f4d764] kconfig: Add static text for search information in help menu
git bisect good da8daff9405e55baa1f797b77a7c629a89f4d764
# first bad commit: [99cb0d917ffa1ab628bb67364ca9b162c07699b1] arch: fix broken BuildID for arm64 and riscv

... and reverting commit 99cb0d917ff indeed fixes the problem.
Copying those involved for comments.

Guenter
