Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C727B624A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKJTEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKJTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:04:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F8245A2E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:04:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A2EEB822E0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BAFC4347C;
        Thu, 10 Nov 2022 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668107066;
        bh=P84Ae0OVSjLriM+LMwCx/4pQY5c2hZAQryWUgrF5sKs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MdCBhY/ZxXyc2FJPPprOdUJVW6KsAQuyH506It9HaZHpZM84C4O1qhUqcdDrFxEIn
         9ATgl+41Nt7d9xv0B6Me5lb1MWFCos1ONMK7ly80XhS7TmefG/quxkOUv7JGXKc6Js
         f4kzDU3SGs/k86bxQBHpU1CltDzMpNI0zx4wgcu9kKhexxwK7p+90MoHy0WSyBiDLJ
         oJbysYsZPuqOEzQ68zI1kVC7vkwhMl+UdqdayeWqYqSp55hWb8W5z8qnBqvus+iSU7
         ElULPMqvMPhJQKEBBKqs+ravPC3yDL4alE+RDMUH3OO0Zv6EkHNcXUEzshJR/mZ97a
         0ag2bK5TrdlHA==
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221110084406.287117-1-olivier.moysan@foss.st.com>
References: <20221110084406.287117-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: stm32: i2s: remove irqf_oneshot flag
Message-Id: <166810706385.995851.10605818222907923454.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 19:04:23 +0000
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

On Thu, 10 Nov 2022 09:44:06 +0100, Olivier Moysan wrote:
> The IRQF_ONESHOT flag allows to ensure that the interrupt is not
> unmasked after the hard interrupt context handler has been executed
> and the thread has been woken. The interrupt line is unmasked after
> the thread handler function has been executed.
> 
> The STM32 I2S driver does not implement a threaded IRQ handler.
> So, the IRQF_ONESHOT flag is not useful in I2S driver.
> Remove this flag to allow the interrupt routine to be managed
> as a thread in RT mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: i2s: remove irqf_oneshot flag
      commit: 7c0f8f1462c9edeaa202a2cbea1bde0960434b09

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
