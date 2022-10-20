Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96C606B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJTWkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:40:33 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F2157887
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=Subject:Date:CC:To:From:Resent-To:Resent-Message-ID:Resent-Date
        :Resent-From:Sender:Reply-To:Message-ID:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Sender:
        Resent-Cc:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=coXtx0USiDLSpfVdQ5VKcP/qYOiVY5HTpwq4HXsB3Pk=; b=nosLc/o/HqRgbC5VV5MpbrNLkZ
        NI5q8knaPrEyhfA4KG8yl/IGiQXjev58nL1voQXiJTA3HKnwQgW2QVGTffqRLjl4y3lgXUs67ponM
        dlbI30Fu7VGU/IdAHX54kHWTGDR4b5jctvPer7ryy0xY9GrUA52UtcoBJ80U/bMhmoYY=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oleDE-009OWQ-Vk
        for linux-kernel@vger.kernel.org; Fri, 21 Oct 2022 00:40:28 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-kernel@vger.kernel.org
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Khalil Blaiech <kblaiech@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>, linux-i2c@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org
Date:   Thu, 20 Oct 2022 23:08:05 +0200
Subject: [PATCH 0/6] a pile of randconfig fixes
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_MID,
        PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S229853AbiJTWkg/20221020224036Z+12888@vger.kernel.org>

Hi!
I've been doing randconfig build tests for quite a while, here's a pile of
fixes.  I'm not sure what's the best way to submit these: do you folks
prefer a series like this, or a number of individual submissions?

With these applied, it seems that archs I run (64-bit x86 arm riscv) are
clean now -- at least for the values of "haven't failed build in a while".

My restrictions were:
[amd64]
CONFIG_64BIT=y
CONFIG_COMPILE_TEST=y
CONFIG_AIC79XX_BUILD_FIRMWARE=n
CONFIG_AIC7XXX_BUILD_FIRMWARE=n
[arm64]
CONFIG_AIC79XX_BUILD_FIRMWARE=n
CONFIG_AIC7XXX_BUILD_FIRMWARE=n
[riscv64]
!CONFIG_ARCH_RV32I=y #yay "selects"
CONFIG_CMODEL_MEDANY=y
CONFIG_BPF_PRELOAD_UMD=n
CONFIG_AIC79XX_BUILD_FIRMWARE=n
CONFIG_AIC7XXX_BUILD_FIRMWARE=n
and applied fixes for dwc3-qcom riscv_cbom_block_size dump_emit_page
riscv:jump_label.

All builds were done with gcc-12 on Debian unstable.

[apologies for the broken first attempt to send, mbox is too new technology
for me I guess]


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ Quis trollabit ipsos trollos?
⠈⠳⣄⠀⠀⠀⠀

