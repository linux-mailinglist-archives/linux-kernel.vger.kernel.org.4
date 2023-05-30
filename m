Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA87169A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjE3Qdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjE3Qdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9912A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B43A62E81
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D3C433D2;
        Tue, 30 May 2023 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685464357;
        bh=2pvX4QGEsmlyGliLYQpywm7bs43IcnoElyDYvs9X10g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H2DhVF1Dit4JQZNyvnfenJy804ebmU0fa87f0uSElWZjaXyPsm7XuAUZTzjs1/Pjb
         vCVm0jYgsuujMXblluel+gSQfN2KS7WIQKQKQBbU3fcsZuqpjyeCuvLEOvKBI1kEy7
         4oSBkT9voZgv04vDX8Snum9pci14Im4RtHgvuY1SPl4xEeBUINhyVURU9h7++nNNrT
         zPQ/Vc8vrbWwO0XQm9WuVdgZzdyNZGsfe1vzsf41zKvA7KapNctvWDHo21XWYv333O
         7NU4vJH/4CdJy2mc6U5N9D8JlbZw3nsOPZnYknWFUxH8LsQJ6zBXXi2YQz9NksGkfJ
         w5nP1Anb+9viw==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230525113000.1290758-1-Vijendar.Mukunda@amd.com>
References: <20230525113000.1290758-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: fix for acp_lock access in pdm driver
Message-Id: <168546435447.570240.2693613153905931649.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 17:32:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 16:59:55 +0530, Vijendar Mukunda wrote:
> Sending the mutex address(acp_lock) as platform
> data during ACP PDM platform driver register sequence,
> its creating copy of the platform data.
> Referencing this platform data in ACP PDM driver results
> incorrect reference to the common lock usage.
> 
> Instead of directly passing the lock address as platform
> data, retrieve it from parent driver data structure
> and use the same lock reference in ACP PDM driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: fix for acp_lock access in pdm driver
      commit: b6b5c6426efe27cbd954409a50604d99c79bd42b

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

