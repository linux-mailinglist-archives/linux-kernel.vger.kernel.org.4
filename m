Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76973ADCD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFWAcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjFWAch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B12105;
        Thu, 22 Jun 2023 17:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8545661937;
        Fri, 23 Jun 2023 00:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063D3C433C8;
        Fri, 23 Jun 2023 00:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687480350;
        bh=rGrpoxT2JrB6gIl6SWv/cI8uqEJ1qle+1MaoCZ8MyQo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UGKn0LdI9edM5zspg3LLVLtUP1m/qVoh5pTUFvB/oE81127MpoNWZrxWa0pCPa0k0
         hKSytPl6HEI8MZ6qB4IuDl2ceb0xcsuWIh0ke0w8i/dtLim0LfA0LhLrUoW0bsQxla
         JHAZ65/A2e4ButgEra8GNOroIdPKf3D9wsVWFaXUgWcsctbDF8GM8ibanQbSkHBde4
         x31Eycwo8hjk7sLg2RKN5/sdaUaaCxT2ombsC9ibNP7gYG6GBNE7W8SeybUSxpPzgv
         w+0j/kIioKqo8BC/XwrN9dHNHLfArPH99GRQ7Q3lnphEDjCki61vMt3atxGxfnxMrO
         iC1ehJNJxh9YQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
In-Reply-To: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v2 0/5] spi: Add CSI support for Renesas RZ/V2M
Message-Id: <168748034127.332493.277333132642198960.b4-ty@kernel.org>
Date:   Fri, 23 Jun 2023 01:32:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 12:33:36 +0100, Fabrizio Castro wrote:
> This series is to add support for the Clocked Serial Interface (CSI)
> IP found in the Renesas RZ/V2M SoC.
> 
> Thanks,
> Fab
> 
> v2: edited list of include files in drivers/spi/spi-rzv2m-csi.c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI
      commit: db63e7ad2895409f78a04f331f781baa7a879dd7
[2/5] clk: renesas: r9a09g011: Add CSI related clocks
      commit: 7c78eb3e5d30eaa217cecaa32711e41cd849d498
[3/5] spi: Add support for Renesas CSI
      commit: dcf92036cb3e1b7bf3472109e4290a0937b270dd
[4/5] arm64: dts: renesas: r9a09g011: Add CSI nodes
      commit: ef643c6b57020ee279d18636d9d967ee048dbffa
[5/5] arm64: defconfig: Enable Renesas RZ/V2M CSI driver
      commit: dfbd12ae0e7c761e07369f5a2d55fe06eb54ad31

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

