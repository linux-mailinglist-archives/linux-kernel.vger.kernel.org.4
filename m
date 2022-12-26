Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF9E65660E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 00:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiLZXei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 18:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiLZXeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 18:34:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B202726
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 15:34:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C353160F5A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29EBC433D2;
        Mon, 26 Dec 2022 23:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672097648;
        bh=cDwu4kM8l3cgFD8Zxb1eDDB1DVSOVJ1DhZGICqs0pmQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C95e+8c64hIE8JKGxitFFNlla73ZMlVfdmZmc6486jHMzIb0CDVVAhLSMU/Si6mub
         lGmDJb3PAhehUUUIQkky8A88xGqxuwDPf4aQrOwsu71+rhWjGLp29JdlHB+KXVtzj1
         0ZaQlYAsR8nngpwZTi3KfO8Cz91Dj9bzr6KPxYxP2e7/f51QPz3HocGKEXd39n+yqO
         5T6LicKw/SfJiuUxbUEkg5Wl6kvzPpg5hIgOng85CxUjtJV8kElsGRxul1PwR+hQ83
         66p6aMMX5PEibVS+t5Q7X6Th6d6gMwlse2PJKTAddoI/sOXM8YU2jLBJdxyqUpJ9jW
         wbx84QRIG5vlg==
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        "balamurugan.c" <balamurugan.c@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221221132559.2402341-1-arnd@kernel.org>
References: <20221221132559.2402341-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix sof-nau8825 link failure
Message-Id: <167209764451.330820.11826897991352846067.b4-ty@kernel.org>
Date:   Mon, 26 Dec 2022 23:34:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 14:25:48 +0100, Arnd Bergmann wrote:
> The snd-soc-sof_nau8825.ko module fails to link unless the
> sof_realtek_common support is also enabled:
> 
> ERROR: modpost: "sof_rt1015p_codec_conf" [sound/soc/intel/boards/snd-soc-sof_nau8825.ko] undefined!
> ERROR: modpost: "sof_rt1015p_dai_link" [sound/soc/intel/boards/snd-soc-sof_nau8825.ko] undefined!
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: fix sof-nau8825 link failure
      commit: 63f3d99b7efe4c5404a9388c05780917099cecf4

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
