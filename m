Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3726DFB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDLQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CE6181
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A8D62D59
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B7C4339B;
        Wed, 12 Apr 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317268;
        bh=0Kypuuix/45eqaiQVvX4QCLy6NM1yWXFS/W4aXnnR68=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CZHSN/y+mwu43+o3bQ9xOtHMgYCt1GxbhaveFbEC9Hqo2gO9er73B6DD/n8hYLTzc
         wpAcDij2EJFcxATc/trI8bQpHRrwAOaiTcn/6e8FPuW3HSzNAyygGua/2tclcC3nVG
         CXf9Clvb4lJhZ1O1wxgCXGJRIT+21uBFSnWeA2eEbULROMbZj7O/jJabQSL2CtSMre
         jBay7dWsI+BiWWO+GqHZaQ89G4BVTS/gQlwzCKbuP2WDT8kSgd7KyNrxKeyc18PxPv
         yWLVEMZfAB+DrDDKB+OlnHAPYbz8zAURHme5dXogwBinfsc538dDCJyOJwbzoXRhGc
         L+SzDkvrKb3xw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        YAN SHI <m202071378@hust.edu.cn>
Cc:     kernel test robot <lkp@intel.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230412033529.18890-1-m202071378@hust.edu.cn>
References: <20230412033529.18890-1-m202071378@hust.edu.cn>
Subject: Re: [PATCH v2] Regulator: stm32-pwr: fix of_iomap leak
Message-Id: <168131726636.91225.12994590690622263841.b4-ty@kernel.org>
Date:   Wed, 12 Apr 2023 17:34:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 11:35:29 +0800, YAN SHI wrote:
> Smatch reports:
> drivers/regulator/stm32-pwr.c:166 stm32_pwr_regulator_probe() warn:
> 'base' from of_iomap() not released on lines: 151,166.
> 
> In stm32_pwr_regulator_probe(), base is not released
> when devm_kzalloc() fails to allocate memory or
> devm_regulator_register() fails to register a new regulator device,
> which may cause a leak.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] Regulator: stm32-pwr: fix of_iomap leak
      commit: c4a413e56d16a2ae84e6d8992f215c4dcc7fac20

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

