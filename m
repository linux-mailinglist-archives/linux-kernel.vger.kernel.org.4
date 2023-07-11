Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34174F93F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGKUog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjGKUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F310FA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D53A361625
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C4C433CD;
        Tue, 11 Jul 2023 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689108249;
        bh=1guEqJf5+OkgpLUyXf9dWW0/CtKqT6vSVMJIe9pjt6w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t9MzO8bSHRogekgPqKQpViXQsUSYHnmrn/b5ADQd7TFmZUxIznnN9T4uK/ZVKhbEF
         4W+cZC8yhKmusTA5Rbipm7Gv0ixhYP7DLfrUAGCYWde4j+zTYmb5RQPZQaIrIaRN8D
         unpkZfIJufw2ulmeopTd2U79F0qShAAjw9ZfP7eqlmDLEDlIBX3WUca0ZLBepHtGg0
         L91nsuSd0qK6TpFzAZjNxn/ChxGS6YhFuYaprTzM3Yy9OdAGN/255Gqa9hSn69Xcdj
         /8JAPhRISwxr7LSWHb2qjl2SAwovW5FqIF/PfmZ4MGR1yoFvJXVWa3MfrI4C/4wGFZ
         zWRxTYs5P+R5g==
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705123018.30903-1-johan+linaro@kernel.org>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 0/8] ASoC/soundwire/qdsp6/wcd: fix leaks and
 probe deferral
Message-Id: <168910824667.478364.6400848972625194425.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 21:44:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2023 14:30:10 +0200, Johan Hovold wrote:
> I've been hitting a race during boot which breaks probe of the sound
> card on the Lenovo ThinkPad X13s as I've previously reported here:
> 
> 	https://lore.kernel.org/all/ZIHMMFtuDtvdpFAZ@hovoldconsulting.com/
> 
> The immediate issue appeared to be a probe deferral that was turned into
> a hard failure, but addressing that in itself only made things worse as
> it exposed further bugs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/8] ASoC: qdsp6: audioreach: fix topology probe deferral
      commit: 46ec420573cefa1fc98025e7e6841bdafd6f1e20
[3/8] ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
      commit: ed0dd9205bf69593edb495cb4b086dbae96a3f05
[4/8] ASoC: codecs: wcd938x: fix resource leaks on component remove
      commit: a3406f87775fee986876e03f93a84385f54d5999
[5/8] ASoC: codecs: wcd934x: fix resource leaks on component remove
      commit: 798590cc7d3c2b5f3a7548d96dd4d8a081c1bc39
[6/8] ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
      commit: a5475829adcc600bc69ee9ff7c9e3e43fb4f8d30
[7/8] ASoC: topology: suppress probe deferral errors
      commit: b6c3bdda3a7e43acfcec711ce20e7cfe44744740
[8/8] ASoC: core: suppress probe deferral errors
      commit: f09b6e96796056633453cb0d07b720d09f1efc68

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

