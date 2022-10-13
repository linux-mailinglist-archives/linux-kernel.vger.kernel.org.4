Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC435FDC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJMOny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B75B1DCA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD771617CE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3294C433D6;
        Thu, 13 Oct 2022 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665672230;
        bh=ro9CrNSvl8TcVF1RUG4m+aq9GS+b83O2H6ir8tV8WqM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oF2s0M4AGwUjGYJWlpnv+uW12QFlnxn3XYSOMUCbnF7MNM63hT3wAw8O8DsYTR/yL
         8p9Z2bFBHIxkr7jLDQ5sUWCxr5ll2XTxHcfDggDvpW2Ws6gcGMa7N+Y/tSdsxzV/2s
         /vdUXt8mXh/qCVxjCUrLLFVB5RDLzoTB1m7YH6diGNCtEUN1Ex5+Qf608fUkBJ3b9J
         RLrGHKn/bfju8rbxn8yGOI1GxzvlGbW4RPrSSX1CxZemJXiCTUblWY2vA1RUE4CnDj
         WVmiKByWSI1X7Ld/RHOoHfY8QDRwORbSHWRaLOWFuwmWiqaPPntdT2aTZBc4mWZ7+V
         HyBJa+r3AAMSg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, geert+renesas@glider.be, lgirdwood@gmail.com,
        aford173@gmail.com, Xiaolei Wang <xiaolei.wang@windriver.com>,
        steve@sk2.org, ckeepax@opensource.cirrus.com,
        chi.minghao@zte.com.cn, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20221010092014.2229246-1-xiaolei.wang@windriver.com>
References: <20221010092014.2229246-1-xiaolei.wang@windriver.com>
Subject: Re: [PATCH] ASoC: wm8962: Add an event handler for TEMP_HP and TEMP_SPK
Message-Id: <166567222742.170727.16401679138704885027.b4-ty@kernel.org>
Date:   Thu, 13 Oct 2022 15:43:47 +0100
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

On Mon, 10 Oct 2022 17:20:14 +0800, Xiaolei Wang wrote:
> In wm8962 driver, the WM8962_ADDITIONAL_CONTROL_4 is used as a volatile
> register, but this register mixes a bunch of volatile status bits and a
> bunch of non-volatile control bits. The dapm widgets TEMP_HP and
> TEMP_SPK leverages the control bits in this register. After the wm8962
> probe, the regmap will bet set to cache only mode, then a read error
> like below would be triggered when trying to read the initial power
> state of the dapm widgets TEMP_HP and TEMP_SPK.
>   wm8962 0-001a: ASoC: error at soc_component_read_no_lock
>   on wm8962.0-001a: -16
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Add an event handler for TEMP_HP and TEMP_SPK
      commit: ee1aa2ae3eaa96e70229fa61deee87ef4528ffdf

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
