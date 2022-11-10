Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A862624CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiKJVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiKJVNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:13:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0625E5987A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:13:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98F4361E59
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0FBC433C1;
        Thu, 10 Nov 2022 21:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668114791;
        bh=xUlbt8lGL6/L92+ucepUNIZaiQsElYKjBgacD5hX4Kg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HyN9oylItR/fEeomFjfYfKEglkZuB3C3J/vie/Emny1hloo2ZfTEDRd30TCqF3b31
         TM9UVJqZsKL96JIa58tv3IVWHSISATZLbDnn9NVfVomSEyTrfCvoTz24f/TIaYbTDJ
         NffStNG7jlWJQ7rY2f5H5u9Eut1HoWT6clljJ1ITaZkhnEjASshtLmDPM6sxfeFeDN
         rUjVr3MP3HfqBO4xmnuAc6kac2yCjQGcWRYpNsnRvDtz0+jKBkXwoahDwJFfnrQFKy
         A8CB+GjrM72PaNF+hvIjLM1mGNpVzckbhmc6EENDJRv2vGXkcyyXRD1Bqe2p1wdfWV
         srSqxi1EjHzBg==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
In-Reply-To: <20221107202114.823975-1-y.oudjana@protonmail.com>
References: <20221107202114.823975-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] regmap-irq: Use the new num_config_regs property in regmap_add_irq_chip_fwnode
Message-Id: <166811478949.1075638.10692622037510321259.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 21:13:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 23:21:14 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Commit faa87ce9196d ("regmap-irq: Introduce config registers for irq
> types") added the num_config_regs, then commit 9edd4f5aee84 ("regmap-irq:
> Deprecate type registers and virtual registers") suggested to replace
> num_type_reg with it. However, regmap_add_irq_chip_fwnode wasn't modified
> to use the new property. Later on, commit 255a03bb1bb3 ("ASoC: wcd9335:
> Convert irq chip to config regs") removed the old num_type_reg property
> from the WCD9335 driver's struct regmap_irq_chip, causing a null pointer
> dereference in regmap_irq_set_type when it tried to index d->type_buf as
> it was never allocated in regmap_add_irq_chip_fwnode:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Use the new num_config_regs property in regmap_add_irq_chip_fwnode
      commit: 84498d1fb35de6ab71bdfdb6270a464fb4a0951b

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
