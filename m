Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752AB6FBF66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjEIGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjEIGji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:39:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275BDC53;
        Mon,  8 May 2023 23:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4640A61BB8;
        Tue,  9 May 2023 06:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D82C433EF;
        Tue,  9 May 2023 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614356;
        bh=INBPQ8y3g/7EUeHHHVr3w5P6C4GQfzSlBDZrauXOIOg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e9vK78zS97QkvcJoQT5DpVwfb7YnqqQRm6YUkseC8Wib9fzMIMVGsOoxurlNOSHWi
         7HrvxlTZa0tYgRpJht19+lZ/zqn05VKWE5FI2eKDfXPcXdmehNy2nxuQFBUXmc+TYo
         hYq7tDsniCGTNUhTV0CxpcEjXTU/f6DDOzp9vqmkYI1/yGOXm2HjZqrn+wK1WgTkTw
         yuweZx0+iuga43ADxxqLs0cA1UPImcsF1yxRpCS9gv8NK1CW/kN+jRVX2xfuFRlFNR
         BIV4qb4KRlX9wH1q2lglnrUZ4b/Hv9cCmCIKFgtX5RWs0f2RBJKh1cTTcN5PRWcoIq
         AKP1g8QD6JXOA==
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     stable@vger.kernel.org, khilman@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com
In-Reply-To: <20230507144656.192800-1-krzysztof.kozlowski@linaro.org>
References: <20230507144656.192800-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] regulator: tps65219: Fix matching interrupts
 for their regulators
Message-Id: <168361435149.303261.3406346409850990450.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 15:39:11 +0900
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

On Sun, 07 May 2023 16:46:56 +0200, Krzysztof Kozlowski wrote:
> The driver's probe() first registers regulators in a loop and then in a
> second loop passes them as irq data to the interrupt handlers.  However
> the function to get the regulator for given name
> tps65219_get_rdev_by_name() was a no-op due to argument passed by value,
> not pointer, thus the second loop assigned always same value - from
> previous loop.  The interrupts, when fired, where executed with wrong
> data.  Compiler also noticed it:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65219: Fix matching interrupts for their regulators
      commit: f050e56de80591fee55bedbdf5b6b998c740cd0c

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

