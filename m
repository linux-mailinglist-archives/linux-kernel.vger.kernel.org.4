Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D35EAD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIZRHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIZRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:06:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE547675D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2g1jNd7RoCV8uaNvrD8hgkCyQ475E63SOZYup2mZQtI=; b=G3F1SnkTc9868BCk6viiQFXKMS
        CByAduDNutveIsblq7R+qFhZedhpJa3fdDU94/FIzU6Nm0brW14fJADPEnVrEN1txtDwAtxvSfYEu
        ozBkzI/OGFzJIhf8AIUZ/yUI6juo2KYewEwYT93obGHlc1isyN+YW2cVb4Pph6DiobdAd1sUzjFMq
        gipgdWtVGVI5QwlOJD4Y9OYLgY4GwFBu4WhYPuMnizBqMb/fyAEhXElRwmvjfaBsFpoQJFCBq2ruL
        kvgngOBSsTdRSvmPAMQmJiijz3Gwvd1geEWNL1zhpE8YMZ+HlH6ilsf2uesGH1JbFU333zTwkUIj7
        Bx6aoPSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34502)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ocqhL-0000iR-5j; Mon, 26 Sep 2022 17:11:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ocqhG-0005Gk-KV; Mon, 26 Sep 2022 17:11:06 +0100
Date:   Mon, 26 Sep 2022 17:11:06 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Subject: Re: arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must
 precede .save or .vsave directives
Message-ID: <YzHPGvhLkdQcDYzx@shell.armlinux.org.uk>
References: <CA+G9fYvyD9OWF53ua2EZmyf+=YTx4f1mezDNkVLMxf3BKXW=_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvyD9OWF53ua2EZmyf+=YTx4f1mezDNkVLMxf3BKXW=_w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks to me like a failure caused by Chen Zhongjin's change:
"Recover kretprobes return address for EABI stack unwinder"

I will drop this patch; please submit a replacement that builds.

Thanks.

On Mon, Sep 26, 2022 at 06:57:00PM +0530, Naresh Kamboju wrote:
> Following build warnings / errors noticed on arm with clang-13 / 14
> on Linux next-20220923.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Regressions found on arm:
> 
>    - build-clang-13-bcm2835_defconfig
>    - build-clang-nightly-imx_v6_v7_defconfig
>    - build-clang-nightly-orion5x_defconfig
>    - build-clang-13-keystone_defconfig
>    - build-clang-13-omap2plus_defconfig
>    - build-clang-14-imx_v6_v7_defconfig
>    - build-clang-nightly-omap2plus_defconfig
>    - build-clang-nightly-multi_v5_defconfig
>    - build-clang-nightly-bcm2835_defconfig
>    - build-clang-13-imx_v6_v7_defconfig
>    - build-clang-13-imx_v4_v5_defconfig
>    - build-clang-14-imx_v4_v5_defconfig
>    - build-clang-13-orion5x_defconfig
>    - build-clang-14-multi_v5_defconfig-65236a87
>    - build-clang-14-lkftconfig
>    - build-clang-nightly-imx_v4_v5_defconfig
>    - build-clang-13-multi_v5_defconfig
>    - build-clang-13-lkftconfig
>    - build-clang-nightly-keystone_defconfig
>    - build-clang-14-multi_v5_defconfig
>    - build-clang-14-orion5x_defconfig
>    - build-clang-14-omap2plus_defconfig
>    - build-clang-nightly-multi_v5_defconfig-65236a87
>    - build-clang-14-bcm2835_defconfig
>    - build-clang-14-keystone_defconfig
>    - build-clang-nightly-lkftconfig
> 
> arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
> .save or .vsave directives
>                 "stmdb  sp, {sp, lr, pc}        \n\t"
>                                                   ^
> <inline asm>:3:2: note: instantiated into assembly here
>         .save   {sp, lr, pc}
>         ^
> /builds/linux/arch/arm/probes/kprobes/core.c:412:29: error: .fnstart
> must precede .pad directive
>                 "stmdb  sp!, {r0 - r11}         \n\t"
>                                                   ^
> <inline asm>:6:2: note: instantiated into assembly here
>         .pad    #52
>         ^
> 2 errors generated.
> make[5]: *** [/builds/linux/scripts/Makefile.build:250:
> arch/arm/probes/kprobes/core.o] Error 1
> 
> build log:
> https://builds.tuxbuild.com/2FAyD1qcTlzjIYE7mjrugjCsxu1/
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
