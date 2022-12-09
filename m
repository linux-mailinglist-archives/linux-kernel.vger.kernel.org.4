Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4364C6488B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLIS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:59:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A479A86F5A;
        Fri,  9 Dec 2022 10:59:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0880B828E3;
        Fri,  9 Dec 2022 18:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EB4C433EF;
        Fri,  9 Dec 2022 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670612350;
        bh=u9JbrEw8bMPzMlBbbg6zIoTZM6sm4BIZ15e9+7rWxNY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Cj7oRguuwuw10YG0DzwSj6HcIHEzpu+lGW/pOJPCSe2O+2EwE9zfls34/58u+q740
         7ghbPsYHBEpViaUjfZgBzxFSV6ruA7fqvtTWE9Vwtnf3n+20wZ+M50TXBhGNPrBm6p
         udFYzxj3viPottv/oX47nhLoVWwRqFdUbDcIGPkDZ8fS7Fg1MuyZM++K+s57MXareu
         n19ZF0svQmnITk85x2Dgdrri+xDIjsKOA+nVS49XLv85j07Ry/WrLyQVkwkbKFXASO
         wLUGPu/UkAgSQcCYSmBWa8pZO7uYOmfvRo4pFmSOEF9fEVW+14oqX0MZ9TStE8VQ/r
         UifAw2j3rMXPQ==
From:   Mark Brown <broonie@kernel.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc
In-Reply-To: <cover.1669100542.git.william.gray@linaro.org>
References: <cover.1669100542.git.william.gray@linaro.org>
Subject: Re: (subset) [PATCH v3 0/9] Migrate i8255 GPIO drivers to regmap API
Message-Id: <167061234874.211735.3835253512376897426.b4-ty@kernel.org>
Date:   Fri, 09 Dec 2022 18:59:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-64ef0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 02:10:57 -0500, William Breathitt Gray wrote:
> Changes in v3:
>  - Changed handle_mask_sync description to show range using a more
>    typical mathematical notation ('[' changed to ')')
>  - Split addition of new i8255 library regmap interface and removal of
>    old i8255 library interface to separate patches
>  - Split migration of 104-dio-48e, 104-idi-48, and gpio-mm modules to
>    regmap-irq, gpio-regmap, and new i8255 library interface to separate
>    patches
>  - Simplified logic in dio48e_handle_mask_sync(); the previous version
>    separated the conditional evaluations from the if statements which
>    made it more complicated than it needed to be
>  - Removed initial interrupt clearing in dio48e_probe(); superfluous
>    because clear_on_unmask is set to true so the interrupts will be
>    cleared anyway later.
>  - Replace IDI48_IRQ_REG with IDI48_IRQ_STATUS and IDI48_IRQ_ENABLE to
>    make the intent of this register clear
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[2/9] regmap-irq: Add handle_mask_sync() callback
      commit: 69af4bcaa08d06fd4d788a7f7193fb3c40ac6aba

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
