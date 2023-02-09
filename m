Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D7691055
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBISgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBISgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:36:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDAE5AB3B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:36:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C41BB8224F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106B0C433D2;
        Thu,  9 Feb 2023 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675967774;
        bh=+LSLpRI2R2Ci3s4pXgdPq4Kud/VwskP44G1eoKLygiQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T/sHbWR3IGHrpqVlGeJksvfqHio+DShjt8uKpZEws0ZRAgGhrqTyT3CkeKOseSaX2
         l3ajwKHBotVkLQw/+fmdknFaOvJHvCKwuNQ8QXCfB0JYqtSSPfBz9OfQVpwP9I4h/f
         Lwpg+lHZY0aRQ66xZtQAX8fN39wZca5af8Z5S1usvGHBlfXGG7031wBlRYvDUwO08B
         bZnocuwqGJxU9oplCbZnLHkS6EeABF8D0Wvjf/Nup1l4d0+spL0b5wsVk5bQ1jplZi
         C4tnUbM02jAr8o9DJaGxw9Ph7oZvj5Fvg5NLv8ViqKplzOwvFhUdLr/NPpa4Ny8cLD
         0KooswT3/m5+w==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com
In-Reply-To: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/8] ASoC: qcom: q6dsp and lpass codec stablity fixes
Message-Id: <167596777266.879652.13238381832493725395.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 18:36:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023 12:27:58 +0000, Srinivas Kandagatla wrote:
> While testing X13s audio, we found multiple stablity issues this patchset
> fixes these issues.
> From q6dsp side issues are around locking of position pointer and handle
> multiple prepare cases along with pulse audio timerbased scheduling workaround.
> 
> From LPASS codec side most of the staiblity issues were around runtime pm,
> hitting various issues as the codec was firstly resetting the soundwire block
> for every clk disable/enable which is taking the slaves out of sync and
> resulting in re-enumerating. Second issue was around fsgen clk is not
> brining up the codec out of suspend as it was not added after
> runtime pm enabled. Final issue was with codec mclk rate which should
> have been 192KHz same as npl instead of 96KHz. We were getting lucky as
> wsa drivers are setting the same clk to 192KHz.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: qcom: q6apm-lpass-dai: unprepare stream if its already prepared
      commit: c2ac3aec474da0455df79c4a182f19687bc98d1d
[2/8] ASoC: qcom: q6apm-dai: fix race condition while updating the position pointer
      commit: 84222ef54bfd8f043c23c8603fd5257a64b00780
[3/8] ASoC: qcom: q6apm-dai: Add SNDRV_PCM_INFO_BATCH flag
      commit: aa759f3f9f4394a3af65ad1772fca6cb9dd9e4cc
[4/8] ASoC: qcom: audioreach: fix ADSP ready check
      commit: dd33c2e7b21d72b151a87b5dafffee2c019043e5
[5/8] ASoC: codecs: lpass: register mclk after runtime pm
      commit: 1dc3459009c33e335f0d62b84dd39a6bbd7fd5d2
[6/8] ASoC: codecs: lpass: fix incorrect mclk rate
      commit: e7621434378c40b62ef858c14ae6415fb6469a8e
[7/8] ASoC: codecs: lpass: do not reset soundwire block on clk enable
      commit: ddffe3b82849ba2774d7a06fbe1cc7e83378c4d2
[8/8] ASoC: codecs: lpass: remove not so useful verbose log
      commit: 777af241a7ce6ed95f8d3fcb028c08f9b40addb6

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

