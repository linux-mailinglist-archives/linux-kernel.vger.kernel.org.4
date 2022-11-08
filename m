Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30984621C17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKHSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKHSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:40:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC76220E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D07A7B81C0A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 18:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79BFC433D6;
        Tue,  8 Nov 2022 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667932830;
        bh=jjF5Yq9ooqSu67PuLpajmGKnq/YI9I38yCrZ+QF9xZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZ6foW7RZBnob6gVPZtIrJJitq3jOcU+nBe2WkHctOKYtOQCBSY075bEAbQFXqCjQ
         XlEWSch7hROb/9RaSzzx0oQnKSRUMUJ7WC2P0MSi4jzCw3oPYRms6QaoBmltptA0IO
         eCgqshcOF3sWgXCVK8Hcc1/oweHVGST4EK772VvU88G9iOlp9ospIliYzHFYcCCGrA
         ccs3jvVz6H5Maot5k/LYW0vMy65PO5XGwdOSowZCyA1gidYaZvqO8nZ0RcQNsmysA+
         EMCgL7VfIZ6Bkof7EawCjcLRfN5tke8FYJMeUDLWch8D8BBG/iNYDdZs8FkcItPDbB
         y0JFcCOqKsjxg==
Date:   Tue, 8 Nov 2022 11:40:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/4] ARM: use .arch directives instead of assembler
 command line flags
Message-ID: <Y2qinCG/Bmq9zGCK@dev-arch.thelio-3990X>
References: <20221014201354.3190007-1-ndesaulniers@google.com>
 <20221014201354.3190007-3-ndesaulniers@google.com>
 <Y2qgTyFcPdnNfkpj@dev-arch.thelio-3990X>
 <Y2qhzhgLIiDD0EI9@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qhzhgLIiDD0EI9@shell.armlinux.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 06:37:02PM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 08, 2022 at 11:30:39AM -0700, Nathan Chancellor wrote:
> > I noticed that this series appears to be partially applied in
> > next-20221108:
> > 
> > 59247fe730db ARM: 9265/1: pass -march= only to compiler
> > bc21212c5564 ARM: 9264/1: only use -mtp=cp15 for the compiler
> > 5aa4860eb50f ARM: 9262/1: remove lazy evaluation in Makefile
> > 
> > This patch (submitted as 9263/1) is needed by 9265/1; without it, builds
> > are going to break:
> > 
> > https://builds.tuxbuild.com/2HGSpQMAKxJuaMAz2ZZc1UgUvvu/build.log
> > 
> > Was there a problem with applying this patch or just an oversight? It
> > would be great to get this whole series applied so that we can turn
> > -Wunused-command-line-argument into a hard error.
> 
> Patching 9263/1...
> git apply --whitespace=fix -p1 --index --check > /tmp/pdb.726086 2>&1
> exited with non-zero status: 256
> error: patch failed: arch/arm/mach-mvebu/Makefile:1
> error: arch/arm/mach-mvebu/Makefile: patch does not apply
> 
> The problem appears to be:
> 
> 84fc86360623 ARM: make ARCH_MULTIPLATFORM user-visible
> 
> which is not in my misc branch. I've applied your patch using GNU
> patch with a fuzz of 2, and the resulting diff looks sensible. I'll
> push it out later this evening.
> 
> Thanks for the heads-up.

Perfect, thanks a lot for the quick response! I figured it was something
like that. I will keep an eye out for any additional breakage and follow
up with patches or additional emails as necessary.

Cheers,
Nathan
