Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDACB621C02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKHShR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKHShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:37:14 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9435985F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XeMVXpoT1t4lK7idcj3wjrc3Xj7qUJiPfKa3wEvEpTM=; b=x95g8jFnboLBdWHiSufIhFcc2J
        mW39h6H+YJrJGWsMx+BAhRXCe5Gs6RqZjbBi1Tbw1M7uZSAl6z4CJAOsgFlD/J8ofU4kHyY4jD0Bj
        H8MZfvLTbnphaP0Tot1fNMxsbto0Ws1ShgI4pnAAfjwZV6PNn3H0bdfV+86Sew1YKhIAec46OAcj7
        K9DG38HygB4nVhd9ufyQp0qXSo+IAUGs3VhPg3qNP/WfnPJypUkZ6/HDoicWQhBJ9Ihw0pJqbziEM
        IA+gTGHUYh8fc/RKI/f9RUm+DmX+7Rtf7TEifWRvImRD2kBVOSMYuAOpGI47hAwcNcqrjHi3gH9+U
        hl/vLo/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35174)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1osTT5-0003dK-Ms; Tue, 08 Nov 2022 18:37:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1osTT4-0004wt-4C; Tue, 08 Nov 2022 18:37:02 +0000
Date:   Tue, 8 Nov 2022 18:37:02 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/4] ARM: use .arch directives instead of assembler
 command line flags
Message-ID: <Y2qhzhgLIiDD0EI9@shell.armlinux.org.uk>
References: <20221014201354.3190007-1-ndesaulniers@google.com>
 <20221014201354.3190007-3-ndesaulniers@google.com>
 <Y2qgTyFcPdnNfkpj@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qgTyFcPdnNfkpj@dev-arch.thelio-3990X>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:30:39AM -0700, Nathan Chancellor wrote:
> I noticed that this series appears to be partially applied in
> next-20221108:
> 
> 59247fe730db ARM: 9265/1: pass -march= only to compiler
> bc21212c5564 ARM: 9264/1: only use -mtp=cp15 for the compiler
> 5aa4860eb50f ARM: 9262/1: remove lazy evaluation in Makefile
> 
> This patch (submitted as 9263/1) is needed by 9265/1; without it, builds
> are going to break:
> 
> https://builds.tuxbuild.com/2HGSpQMAKxJuaMAz2ZZc1UgUvvu/build.log
> 
> Was there a problem with applying this patch or just an oversight? It
> would be great to get this whole series applied so that we can turn
> -Wunused-command-line-argument into a hard error.

Patching 9263/1...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.726086 2>&1
exited with non-zero status: 256
error: patch failed: arch/arm/mach-mvebu/Makefile:1
error: arch/arm/mach-mvebu/Makefile: patch does not apply

The problem appears to be:

84fc86360623 ARM: make ARCH_MULTIPLATFORM user-visible

which is not in my misc branch. I've applied your patch using GNU
patch with a fuzz of 2, and the resulting diff looks sensible. I'll
push it out later this evening.

Thanks for the heads-up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
