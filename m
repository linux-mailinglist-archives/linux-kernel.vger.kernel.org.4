Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC716E51DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDQU1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDQU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95B1FC0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CAFC6208F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDADC4339B;
        Mon, 17 Apr 2023 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681763266;
        bh=jTUKGS4yE6dGIJLV1sOj+vFZpr3b/IpFoTct4m0Hq2g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XZCyyjyxzcZQzG6lCLUfJCEqUBRP0qLMwCzDSoB+ZjpdCHx0IB5PPsL0btoPeUmyR
         cUN8Sw0p7Vsk8oyw1KslYMeJH+JaZ839letabf4nApeHj4jPvi6VBDLXxikYNddoGK
         Ra2h3wrArKnQWdR982Uf3YO3Wie6EEZ8sX9J++nUKGlwJG8/zBwRF8CTuSL9zPPzVO
         etVpnrG23fGEV6lLIn7lfO5cfoxw1BdFfpKr6yrGTNM4wmb6Lmc9XMl9LqrAnvk2bM
         45zYm/PBs6eNBw+itcI3v+mq92HzJNfWsrxg1erv2INbnw4uaHwTc3Ff/+Z+8Yxe1g
         BpRwBKz11Hdlw==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <error27@gmail.com>, Liliang Ye <yll@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230403152647.17638-1-yll@hust.edu.cn>
References: <20230403152647.17638-1-yll@hust.edu.cn>
Subject: Re: [PATCH 1/2] ASoC: fsl_mqs: move of_node_put() to the correct
 location
Message-Id: <168176326315.1296984.11419887064802720363.b4-ty@kernel.org>
Date:   Mon, 17 Apr 2023 21:27:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 23:26:47 +0800, Liliang Ye wrote:
> of_node_put() should have been done directly after
> mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
> otherwise it creates a reference leak on the success path.
> 
> To fix this, of_node_put() is moved to the correct location, and change
> all the gotos to direct returns.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_mqs: move of_node_put() to the correct location
      commit: 1c34890273a020d61d6127ade3f68ed1cb21c16a

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

