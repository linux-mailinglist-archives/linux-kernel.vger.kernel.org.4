Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1DC6D8923
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDEU5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDEU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A930F9;
        Wed,  5 Apr 2023 13:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F89C628B5;
        Wed,  5 Apr 2023 20:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47581C433EF;
        Wed,  5 Apr 2023 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680728257;
        bh=wf6YWrJlfwzYT6H2M5qNGDN0nezwrbGZ7P9NANYYYCE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G17btjVVanPqfd6bTQ7BauH5VSiiLmvLFE+WZFjU8VZxBc0eTFbKydiD4emIN7Yky
         +B2oc+t+efgTNPhS+WCQUXOgEx3Tym6TROT+L1InX+mKAuLH3tfxs6p1d4lOO+6BJV
         qoOt22QmfeteKsOOmSFyMCJZfXUA0SizzC4FA3Vva8712mDfWIHlwe+jFHKQ/MdCmm
         JlX5RXwfO6f62TNmiPg77nVPCjMsECPlAqD8nMc5nsf78pBw+Hv4K25aQiECP7VVZk
         bBJS4f2Rl9bi6budwy9sUSj5X+Zl9EhfJ+8a6keeXXlpY61LiauDO+EFH/dIPMCgCK
         IOVH2fht3zO5w==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
In-Reply-To: <cover.1680708357.git.william.gray@linaro.org>
References: <cover.1680708357.git.william.gray@linaro.org>
Subject: Re: (subset) [PATCH v6 0/3] Migrate the PCIe-IDIO-24 and WS16C48
 GPIO drivers to the regmap API
Message-Id: <168072825499.2180850.13929278411634961607.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 21:57:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 11:45:41 -0400, William Breathitt Gray wrote:
> Changes in v6:
>  - Wrap lines to 80 characters rather than 100 for set_type_config()
>  - Remove regmap_config max_register lines as superfluous
>  - Enable use_raw_spinlock to prevent deadlocks when running -rt kernels
>  - Check regmap_update_bit() ret value before goto exit_unlock
>  - Rename exit_early label to the more descriptive exit_unlock
>  - Add sparse annotations for lock acquire/release in
>    ws16c48_handle_pre_irq() and ws16c48_handle_post_irq()
>  - Explicitly add 0 to WS16C48_ENAB in ws16c48_irq_init_hw() for sake of
>    symmetry to match the other WS16C48_ENAB operations
> Changes in v5:
>  - Refactor for map parameter removal from handle_mask_sync()
>  - Cleanups and line wrappings to 100 characters rather than 80
>  - Adjust to change mutex/spinlock_t type locks to raw_spin_lock_t type
>  - Remove pex8311_intcsr table configurations as superfluous
>  - Adjust to set pex8311_intcsr_regmap_config reg_base to
>    PLX_PEX8311_PCI_LCS_INTCSR
>  - Rename PAGE_FIELD_PAGE_* defines to POL_PAGE, ENAB_PAGE, and
>    INT_ID_PAGE
> Changes in v4:
>  - Allocate idio24gpio before using it in idio_24_probe()
> Changes in v3:
>  - Drop map from set_type_config() parameter list; regmap can be passed
>    by irq_drv_data instead
>  - Adjust idio_24_set_type_config() for parameter list
>  - Add mutex to prevent clobbering the COS_ENABLE register when masking
>    IRQ and setting their type configuration
> Changes in v2:
>  - Simplify PCIe-IDIO-24 register offset defines to remove superfluous
>    arithmetic
>  - Check for NULL pointer after chip->irq_drv_data allocation
>  - Set gpio_regmap drvdata and use gpio_regmap_get_drvdata() to get the
>    regmap in idio_24_reg_map_xlate()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/3] regmap: Pass irq_drv_data as a parameter for set_type_config()
      commit: 7697c64b9e4908196f0ae68aa6d423dd40607973

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

