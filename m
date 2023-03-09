Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050476B2AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCIQbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCIQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:31:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391512821A;
        Thu,  9 Mar 2023 08:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E67961AE0;
        Thu,  9 Mar 2023 16:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5104C4339B;
        Thu,  9 Mar 2023 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678378188;
        bh=Vs5yR73fwenbspC7Hc7MZqjQddF+NqnLXNP8Zyl3t5I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=alKJkV+TfvLPRdueZ1xcZnxDkXUBPNyJmhNvaOyn3Yko+Z8MknKt40SxrToOw1lmT
         NMcYCCb/dLiF1ZAZghf5v/Zi+KW1vcCojkX9dmPVsDAmSpeEIdFMzetdk5YTk4WtyZ
         XPrDwHV5LsZqIZiS30nYkAMsQ3G2/jQPJhpOyyUccduBTRWAKtSkgcHaqgJnIJ2dO+
         bP42RdWk5zO+VNLw9uU2V5iPJDhjZX5T0qpsDnHuRRE6t110JuPu+wDvuzDehAgCA3
         tGmCWZax8mMqz8v3XzNOZDrZisMXFA7KegDEBmyWWRGSNYqJyABTqEfWdlvDY9ygFr
         C7r8+LxONRvxw==
From:   Mark Brown <broonie@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Herve Codina <herve.codina@bootlin.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230307141503.159766-1-herve.codina@bootlin.com>
References: <20230307141503.159766-1-herve.codina@bootlin.com>
Subject: Re: [PATCH 0/3] Fix the PowerQUICC audio support using the QMC
Message-Id: <167837818442.37742.7557223272230360155.b4-ty@kernel.org>
Date:   Thu, 09 Mar 2023 16:09:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 15:15:00 +0100, Herve Codina wrote:
> A previous series added the PowerQUICC audio support using the QMC.
> The v6 version of this previous series was applied but some feedbacks
> lead to a v7 version.
> 
> The v6 can be found here:
>  https://lore.kernel.org/linux-kernel/20230217145645.1768659-1-herve.codina@bootlin.com/
> and the v7, here:
>  https://lore.kernel.org/linux-kernel/20230306161754.89146-1-herve.codina@bootlin.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Remove unneeded property
      commit: 33a33005b2db0966c00d4f58dd2a36e5a44217db
[2/3] dt-bindings: soc: fsl: cpm_qe: cpm1-tsa: Remove unneeded property
      commit: 0fb6f518cb46cf8bac7c30c29171050e355cd738
[3/3] soc: fsl: cpm1: qmc: Fix assigned timeslot masks
      commit: f37acbde076d8dbf5e4c694f29760e608fdffe11

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

