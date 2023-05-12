Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332106FFFA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbjELETo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjELETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5915F5FDD
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E66C64FA5
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A40EC433EF;
        Fri, 12 May 2023 04:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683865166;
        bh=Ss0d/YlpNBJa+gq9dsQPpsQfi1oSiK4LQ3MruNXU5xQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F5dR0xeYaI/MotfZ4qBTqT2TgpnvhwnliULLdjjbnBOHvJ5ckyDslH+1VsszLTSvg
         sW7Utit1l35f7p0gb1AqkGeeQGC7Y1rpSkD8gl40JU1eFn7cPwhL9Ds45lxrcg5jJp
         WxLWdC9ZQ8RWZsT+fG1/OC4unDgZifozoi+jRt1DV6NIPgDA4H15B7EC3TFSVaEUpX
         4iZ/ZWSgmbba5pdn7pIu6ADP1W9W6q5bG5xoD3/evBdXDZ8xdQpQDiAaz1g+qXvzb1
         34Yi6bDHJ9D8sEbehHJDrijnIxU9MyDPS9PRUiPLCyzZb3xEP/ZJrt/uPrxfRpV5eR
         PsssHvFTf+zIA==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexis.lothore@bootlin.com
In-Reply-To: <20230511142735.316445-1-maxime.chevallier@bootlin.com>
References: <20230511142735.316445-1-maxime.chevallier@bootlin.com>
Subject: Re: [PATCH] regmap: mmio: Allow passing an empty
 config->reg_stride
Message-Id: <168386516384.353123.11293244589798997385.b4-ty@kernel.org>
Date:   Fri, 12 May 2023 13:19:23 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 16:27:35 +0200, Maxime Chevallier wrote:
> Regmap's stride is used for MMIO regmaps to check the correctness of
> reg_width. However, it's acceptable to pass an empty config->reg_stride,
> in that case the actual stride used is 1.
> 
> There are valid cases now to pass an empty stride, when using
> down/upshifting of register address. In this case, the stride value
> loses its sense, so ignore the reg_width when the stride isn't set.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: mmio: Allow passing an empty config->reg_stride
      commit: e12ff28764937dd58c8613f16065da60da149048

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

