Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E269640804
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiLBNyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiLBNyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:54:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D148DA22A;
        Fri,  2 Dec 2022 05:54:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A12F2B82172;
        Fri,  2 Dec 2022 13:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1CEC433D6;
        Fri,  2 Dec 2022 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669989250;
        bh=RFXCeixnCunq7uJ4AjC78qdV2fWmcwMrZZsz81rWnIM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SPfxmdxf9gwCFoh//pEuYmUPLbbBzxchJnkaB8/P9bagFZFkCT3YUalsgfm3eu9ta
         qLrwpQ0FYMdGUlrXgFXrDIzeWS8MCI1Cc3RSga9uYWqGjSLrCi1lDo48dv21iuLnlE
         kJv1h1FSSCkgpp9rZ7hqMttcfQSazDd/zUk50Do6FQpBM+i8t8EnUTE21DpdyG3dMU
         rm2Amo6XlIM3Qh0F7G7pVQjEAaEW9aif51+fOJS3d1CNO7HeEilmg4kBqkMlrlQmE1
         sCc2zKbgGc/7pObJV0p4z8cIs9Zyqxn7ymDwd3OtPb1KPrDktOqdFESfXhaoq3WllD
         RXCBy0KDBOrLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
Subject: Re: (subset) [PATCH v7 0/8] Add MediaTek MT6357 PMIC support
Message-Id: <166998924420.1252747.5635155323391634201.b4-ty@kernel.org>
Date:   Fri, 02 Dec 2022 13:54:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 16:56:59 +0100, Alexandre Mergnat wrote:
> This patch series adds MFD, PMIC keys, and regulator support for MT6357.
> MT6357 is a MediaTek PMIC very similar to MT6358.
> 
> Currently, MTK bindings related to the PMICs are not converted yet (still .txt):
> 
> soc/mediatek/pwrap.txt (all PMIC parent)
>       |
>       V
> mfd/mt6397.txt (support lot of mt63XX PMIC)
>       +---------------+----------------+---...
>       V               V                V
> regulator/...      rtc/...          codec/...
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[2/8] regulator: dt-bindings: Add binding schema for mt6357 regulators
      commit: b4387db19d7f1caf166852782a5f0e5a393bdf24
[7/8] regulator: add mt6357 regulator
      commit: dafc7cde23dca239987d3cd000b11cdccc3728ea

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
