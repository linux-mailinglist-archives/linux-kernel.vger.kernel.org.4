Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CBC6FAFBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjEHMOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjEHMOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:14:46 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC93847E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:14:45 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:6a18:41e7:fcfe:24c0])
        by albert.telenet-ops.be with bizsmtp
        id uCEY2900F2WBekD06CEYzh; Mon, 08 May 2023 14:14:43 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pvzlA-001VjV-5u;
        Mon, 08 May 2023 14:14:32 +0200
Date:   Mon, 8 May 2023 14:14:32 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-um@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.4-rc1
In-Reply-To: <20230508115727.2597864-1-geert@linux-m68k.org>
Message-ID: <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com> <20230508115727.2597864-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.4-rc1[1] compared to v6.3[2].
>
> Summarized:
>  - build errors: +9/-16
>  - build warnings: +1/-1439
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ac9a78681b921877518763ba0e89202254349d1b/ (all 152 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/457391b0380335d5e9a5babdec90ac53928b23b4/ (all 152 configs)
>
>
> *** ERRORS ***
>
> 9 error regressions:
>  + /kisskb/src/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c: error: 'mxc_isi_pm_resume' defined but not used [-Werror=unused-function]:  => 328:12
>  + /kisskb/src/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c: error: 'mxc_isi_pm_suspend' defined but not used [-Werror=unused-function]:  => 314:12

sparc64-gcc{5,11}/sparc-allmodconfig
(fix was available before the merge window)

>  + /kisskb/src/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined [-Werror=undef]:  => 66:5, 33:5, 51:5
>  + /kisskb/src/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]:  => 51:5, 66:5, 33:5

mips-gcc{8,11}/mips-allmodconfig
xtensa-gcc11/xtensa-allmodconfig
powerpc-gcc5/ppc32_allmodconfig
(fix was available before the merge window)

>  + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27

um-x86_64-gcc12/um-allyesconfig

>  + /kisskb/src/fs/xfs/scrub/scrub.h: error: initializer element is not constant:  => 112:28

powerpc-gcc5/ppc64_book3e_allmodconfig
powerpc-gcc5/powerpc-allmodconfig
powerpc-gcc5/ppc32_allmodconfig
powerpc-gcc5/powerpc-allyesconfig
powerpc-gcc5/ppc64le_allmodconfig
arm64-gcc5/arm64-allmodconfig
(fix sent)

>  + error: modpost: "__floatunsidf" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!:  => N/A
>  + error: modpost: "__gedf2" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!:  => N/A
>  + error: modpost: "__ltdf2" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] undefined!:  => N/A

sparc64-gcc5/sparc64-allmodconfig

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
