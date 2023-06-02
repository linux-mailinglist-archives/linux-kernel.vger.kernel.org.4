Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E94720827
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjFBRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBRKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DF1A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6593A617A4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDB9C4339B;
        Fri,  2 Jun 2023 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685725802;
        bh=Sm9tqdONmLaACZgnEVSVfiPc4+bYFHegJgO3G2ZQySs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T4HBsuapNljICDcLypo93MZPmrKun/442h0PJT1po9Gl2s9PPfeYgHpLKEdmZZInm
         sTfysp9TP0A6fHTcFKdoJorTkO3M0TyZCd4kqh/Ot74C7o5c0V8Jk3QG6nIz8sNm/A
         S/uAyaWedYNMVZyKTRDxftCB2SMrVWYl7pskLL2t9o5/2dVbvba5yLXwfH4D8e1Umj
         gvxLjRePIN3u0IpZiUxefVs+DJV9G7xgZjYkJK+bEpxpPgR/EK2T6vWEvF+E5znMss
         BPOhJ9qu7I7fpTXUBfPy+RPjQI/r7G1mtENuKTx7n3RMgz8HClCQqH202HtOUoTmd3
         d5Ywa9rfjNugg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Hancock <robert.hancock@calian.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230602011936.231931-1-robert.hancock@calian.com>
References: <20230602011936.231931-1-robert.hancock@calian.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: fix PCM constraint error
 check
Message-Id: <168572580128.93025.9865775498537143509.b4-ty@kernel.org>
Date:   Fri, 02 Jun 2023 18:10:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 19:19:35 -0600, Robert Hancock wrote:
> The code in asoc_simple_startup was treating any non-zero return from
> snd_pcm_hw_constraint_minmax as an error, when this can return 1 in some
> normal cases and only negative values indicate an error.
> 
> When this happened, it caused asoc_simple_startup to disable the clocks
> it just enabled and return 1, which was not treated as an error by the
> calling code which only checks for negative return values. Then when the
> PCM is eventually shut down, it causes the clock framework to complain
> about disabling clocks that were not enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card-utils: fix PCM constraint error check
      commit: 635071f5fee31550e921644b2becc42b3ff1036c

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

