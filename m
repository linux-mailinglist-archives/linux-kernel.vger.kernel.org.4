Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1958C618B2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiKCWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiKCWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:11:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31622B06;
        Thu,  3 Nov 2022 15:11:36 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 88186660295F;
        Thu,  3 Nov 2022 22:11:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667513495;
        bh=pgY0dvtyM8FwNva19FmPelXivw7RaAAO4XKizZMcieY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFxur4ptUBDg7nGhx6dDOLzWzdzgMgpxTlSmAPSCP55GF1G+wVuCCHQeFU6+igc2b
         jOhlKLfU2M0GUXM+S0c6g/JTL6GBReHOEz3BEbJsm9rTAe9hkY9ASLOMVKu9HY+y1T
         H8YQpaU63a+D1cbi+B2YA5wUoFHz0n+L+rUTdURifcJPTfF0vf8BOmGrfAquN1YTsc
         5LLR36LQ7R30Ony0YDIp59ut26FmT5HX79waVCxst2/XyNkDt+Pkb5gVHmRRKDaXKZ
         1bHzhBQtXoHsmBvyRI6thybjEcHTPudxLp360clRIl7OlICUHJj+uVW2GcAxHHkEQ9
         Qv6dp8PWOTxEw==
Date:   Thu, 3 Nov 2022 18:11:30 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rex-BC Chen =?utf-8?B?KOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        Runyang Chen =?utf-8?B?KOmZiOa2pua0iyk=?= 
        <Runyang.Chen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Miles Chen =?utf-8?B?KOmZs+awkeaouik=?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] reset: mediatek: Move MediaTek system clock reset
 to reset/mediatek
Message-ID: <20221103221130.eosmwl2vjo36va6c@notapiano>
References: <20221021104804.21391-1-rex-bc.chen@mediatek.com>
 <20221021104804.21391-2-rex-bc.chen@mediatek.com>
 <8b73e38b-ae78-1f85-f5f0-f13bce6e45de@collabora.com>
 <bcfd608b029377565dc656adf24effeba95d2433.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcfd608b029377565dc656adf24effeba95d2433.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 05:14:40AM +0000, Rex-BC Chen (陳柏辰) wrote:
> On Tue, 2022-10-25 at 12:36 +0200, AngeloGioacchino Del Regno wrote:
> > Il 21/10/22 12:48, Bo-Chen Chen ha scritto:
[..]
> > > --- a/drivers/clk/mediatek/Kconfig
> > > +++ b/drivers/clk/mediatek/Kconfig
> > > @@ -8,6 +8,7 @@ menu "Clock driver for MediaTek SoC"
> > >   config COMMON_CLK_MEDIATEK
> > >   	tristate
> > >   	select RESET_CONTROLLER
> > > +	select RESET_MEDIATEK_SYSCLK
> > >   	help
> > >   	  MediaTek SoCs' clock support.
> > >   
> > 
> > ..snip..
> > 
> > > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > > index 3e7e5fd633a8..5cef7ccc9a7d 100644
> > > --- a/drivers/reset/Makefile
> > > +++ b/drivers/reset/Makefile
> > > @@ -1,6 +1,7 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   obj-y += core.o
> > >   obj-y += hisilicon/
> > > +obj-y += mediatek/
> > 
> > I'd be more for
> > 
> > obj-$(CONFIG_ARCH_MEDIATEK) += mediatek/
> > 
> > as there's no reason to even compile these if MTK support isn't
> > enabled at all.
> > 
> 
> Hello Angelo,
> 
> thanks for your review.
> I obj-y += mediatek/ because if I don't write like this, it will build
> fail for x86.
> Is there any suggestion for this?
> 
> /tmp/src_kernel/prebuilt/toolchain/0day/gcc/x86_64-linux/bin/x86_64-
> linux-ld: vmlinux.o: in function `mtk_pericfg_init':
> clk-mt8135.c:(.init.text+0x12a2b7): undefined reference to
> `mtk_reset_init_with_node'
> /tmp/src_kernel/prebuilt/toolchain/0day/gcc/x86_64-linux/bin/x86_64-
> linux-ld: vmlinux.o: in function `mtk_infrasys_init':
> clk-mt8135.c:(.init.text+0x12a3bb): undefined reference to
> `mtk_reset_init_with_node'
> /tmp/src_kernel/prebuilt/toolchain/0day/gcc/x86_64-linux/bin/x86_64-
> linux-ld: vmlinux.o: in function `mtk_infrasys_init':
> clk-mt8173.c:(.init.text+0x12ac47): undefined reference to
> `mtk_reset_init_with_node'
> /tmp/src_kernel/prebuilt/toolchain/0day/gcc/x86_64-linux/bin/x86_64-
> linux-ld: vmlinux.o: in function `mtk_pericfg_init':
> clk-mt8173.c:(.init.text+0x12ad25): undefined reference to
> `mtk_reset_init_with_node'
> /tmp/src_kernel/kernel/mediatek/scripts/Makefile.vmlinux:34: recipe for
> target 'vmlinux' failed
> make[3]: *** [vmlinux] Error 1
> make[3]: Target '__default' not remade because of errors.
> /tmp/src_kernel/kernel/mediatek/Makefile:1236: recipe for target
> 'vmlinux' failed
> make[2]: *** [vmlinux] Error 2
> make[2]: Target '__all' not remade because of errors.
> make[2]: Leaving directory '/tmp/out_kernel/out/allyesconfig.x86_64'
> Makefile:231: recipe for target '__sub-make' failed
> make[1]: *** [__sub-make] Error 2
> make[1]: Target '__all' not remade because of errors.
> make[1]: Leaving directory '/tmp/src_kernel/kernel/mediatek'
> build/core/kbuild_test.mk:61: recipe for target 'all' failed
> make: *** [all] Error 2
> [11:44:04] Error: failed to build allyesconfig.x86_64

From the errors it seems like you're compiling the clock drivers (like
clk-mt8135.c) but not the sysclk reset driver (reset-mediatek-sysclk.c). Given
that this happened when you added CONFIG_ARCH_MEDIATEK to that Makefile, then it
must mean that that config is disabled, which would make sense for a x86 build.
But then the fact that the clock driver was built even in this case must mean
that you have COMPILE_TEST enabled.

I guess in order to have a working COMPILE_TEST=y build, you do need to have
obj-y += mediatek/, and on the Kconfig below...

> 
> > >   obj-$(CONFIG_ARCH_STI) += sti/
> > >   obj-$(CONFIG_ARCH_TEGRA) += tegra/
> > >   obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
> > > diff --git a/drivers/reset/mediatek/Kconfig
> > > b/drivers/reset/mediatek/Kconfig
> > > new file mode 100644
> > > index 000000000000..a416cb938753
> > > --- /dev/null
> > > +++ b/drivers/reset/mediatek/Kconfig
> > > @@ -0,0 +1,5 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > 
> > Similarly, we should at this point also do....
> > 
> > if ARCH_MEDIATEK

... have instead

if ARCH_MEDIATEK || COMPILE_TEST

I think that should fix the issue.

Thanks,
Nícolas

> > 
> > > +config RESET_MEDIATEK_SYSCLK
> > > +	tristate "MediaTek System Clock Reset Driver"
> > > +	help
> > > +	  This enables the system clock reset driver for MediaTek SoCs.
> > 
> > endif # ARCH_MEDIATEK
