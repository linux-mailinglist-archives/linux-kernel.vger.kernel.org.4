Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8DE624A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKJTEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiKJTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:04:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0CC45A12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 62266CE1FE3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6071C433D7;
        Thu, 10 Nov 2022 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668107063;
        bh=Fdos3yrig/YXWCfSadWY8NvihYdcZRISicY+GY0Ipcw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=NXVr4lyeQVWvqb4XDgmn7Jfa5mZK9g9CwSwIyT45X1m4FvlPd4ROb+00w98eeXCfF
         tuoMDsc51DSxTIfPX7KkEZ5HPudWT5mmkVet+C07b8eYl21GAyqGWDbgrN3bO1fHrv
         AWk40g/Z6iEL7GggYIa3XzOQy8rYvJh5Df3lJGJRBoRrhhbw/FFyn+l80bD6q/Nx2q
         vmVkiPDgvn3kErJzBkkD1krpiiR9AWpGJ1+esWrksNbRKeAJvT/e+xTssYavxEiLoQ
         HWTvs0GyQSCywidOPwtNxklgIzEA7F7B0tUn9buV3cisDVslGfMjf0J4LB+UN2vSuY
         SzYEnel8JVP1g==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Junxiao Chang <junxiao.chang@intel.com>,
        alsa-devel@alsa-project.org, perex@perex.cz, lgirdwood@gmail.com,
        kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        linux-kernel@vger.kernel.org, furong.zhou@intel.com, tiwai@suse.com
In-Reply-To: <20221109234023.3111035-1-junxiao.chang@intel.com>
References: <20221109234023.3111035-1-junxiao.chang@intel.com>
Subject: Re: [PATCH] ASoC: hdac_hda: fix hda pcm buffer overflow issue
Message-Id: <166810706137.995851.18267350374607278167.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 19:04:21 +0000
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

On Thu, 10 Nov 2022 07:40:23 +0800, Junxiao Chang wrote:
> When KASAN is enabled, below log might be dumped with Intel EHL hardware:
> [   48.583597] ==================================================================
> [   48.585921] BUG: KASAN: slab-out-of-bounds in hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
> [   48.587995] Write of size 4 at addr ffff888103489708 by task pulseaudio/759
> 
> [   48.589237] CPU: 2 PID: 759 Comm: pulseaudio Tainted: G     U      E     5.15.71-intel-ese-standard-lts #9
> [   48.591272] Hardware name: Intel Corporation Elkhart Lake Embedded Platform/ElkhartLake LPDDR4x T3 CRB, BIOS EHLSFWI1.R00.4251.A01.2206130432 06/13/2022
> [   48.593010] Call Trace:
> [   48.593648]  <TASK>
> [   48.593852]  dump_stack_lvl+0x34/0x48
> [   48.594404]  print_address_description.constprop.0+0x1f/0x140
> [   48.595174]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
> [   48.595868]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
> [   48.596519]  kasan_report.cold+0x7f/0x11b
> [   48.597003]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
> [   48.597885]  hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdac_hda: fix hda pcm buffer overflow issue
      commit: 37882100cd0629d830db430a8cee0b724fe1fea3

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
