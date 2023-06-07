Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80227726AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjFGUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjFGURz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B664D2129;
        Wed,  7 Jun 2023 13:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A78164367;
        Wed,  7 Jun 2023 20:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C655AC4339C;
        Wed,  7 Jun 2023 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686169051;
        bh=EnhsOR6kucpdK0EOSLdjc3AK/uSODOaGZXYxak38Ha8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WMAbdwrps7m7m85JIqoJJrvQxmam1frNR+HR81CoNY/zg6lhLodxJnA4TddOTqbjx
         PZv2skSn8qXfz5a5RFdSrk94Tmb7MGANXF2PYHAk/mvn3vHR+7eEa6zX4/onzQu6Bh
         HK5apALdrFPKp2Gpbx/aXqQ4OFQiHifP4+uygOhs4BYQmBBQF7AT95aj0ggKNjotkG
         pIcKWCyybe8qdhW/g8h7UQnAIIS5MjA4xTb6PP9iY505z+cbcwKgZix+s1Ab0qFqTi
         Wxt4DDCKwPud8Bnr/zow/AUoAj/7ylCYRtLBjdu2ZO4a2v8HrEGN/hu2aMmWHexE/l
         /acSByfho4/bw==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230531140912.819373-1-olivier.moysan@foss.st.com>
References: <20230531140912.819373-1-olivier.moysan@foss.st.com>
Subject: Re: (subset) [PATCH 0/3] ASoC: stm32: fix dtbs_check warnings
Message-Id: <168616904749.205102.9240096518191845115.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 21:17:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 16:09:09 +0200, Olivier Moysan wrote:
> Fix dtbs_check warnings in STM32MP15 DK boards Devices Trees for
> STM32 I2S and Cirrus CS42L51 codec.
> 
> - Add OF graph port property in I2S and CS42L51 DT bindings.
>   Fixes warnings:
>   audio-controller@4000b000: Unevaluated properties are not allowed
>   ('port' was unexpected)
>   cs42l51@4a: Unevaluated properties are not allowed
>   ('port' was unexpected)
> - Correct OF graph DAI audio format property for STM32MP15x Dkx I2S node
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: stm32: document audio of graph port for i2s
      commit: 401ec2b8878f34b6baf64fba3e29411c246b785c
[2/3] ASoC: dt-bindings: document audio of graph port for cs42l51
      commit: fe748da7c216528d46adb4c6f4a969346ec3a452

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

