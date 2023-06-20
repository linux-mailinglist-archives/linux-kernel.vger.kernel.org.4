Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059FE73772E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFTWDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFTWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F71729
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCB3561236
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00546C433C0;
        Tue, 20 Jun 2023 22:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687298625;
        bh=i/deUk2eOdt2WdYb5h5I/k3xhjP07Y14gcGog2379Fs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j2dVtePKX1opDjOY8755YiN/tIJUN17lT0giVcv/X6Ev/Z0HHStlrtzyaqbNGao/t
         AAFotgwfVEZOdgeQ+TmHQiSKctCXZzLV+X6jnAtMbSlF7WaCOiyMVfV4bU7OrPfFRJ
         8lmhsr2/Jbu+iVn1eTnPnXzQdnuq1rU+ndEXhYyHmMb3I6qt/lQWT2ScqYqxuBFLwK
         yxgUtymVAZbRL3Xv9Ed8YOHTnzAy4rg/1rGPBMUY9pwu7WtI0XgUXmZXjZbw9PXZc/
         3HJ5W15IPtx4/WlOWo8rrDRSUg2LlRpc2CuZK+qU+/7LChW4NK31nzLqfq+JrqEtZD
         Nt4v9niDqCaAQ==
From:   Mark Brown <broonie@kernel.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
Cc:     yilun.xu@intel.com, matthew.gerlach@linux.intel.com
In-Reply-To: <20230620202824.380313-1-russell.h.weight@intel.com>
References: <20230620202824.380313-1-russell.h.weight@intel.com>
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
Message-Id: <168729862371.184128.9402324691745241836.b4-ty@kernel.org>
Date:   Tue, 20 Jun 2023 23:03:43 +0100
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

On Tue, 20 Jun 2023 13:28:24 -0700, Russ Weight wrote:
> The max_raw_write member of the regmap_spi_avmm_bus structure is defined
> as:
> 	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT
> 
> SPI_AVMM_VAL_SIZE == 4 and MAX_WRITE_CNT == 1 so this results in a
> maximum write transfer size of 4 bytes which provides only enough space to
> transfer the address of the target register. It provides no space for the
> value to be transferred. This bug became an issue (divide-by-zero in
> _regmap_raw_write()) after the following was accepted into mainline:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
      commit: c8e796895e2310b6130e7577248da1d771431a77

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

