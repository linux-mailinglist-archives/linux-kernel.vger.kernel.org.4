Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218C162BF29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiKPNOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKPNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:14:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B80C5E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:14:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9076B81D47
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5955C433D6;
        Wed, 16 Nov 2022 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668604440;
        bh=TMop0E7cDzLpxQZWWEdBbOBwZYi0t6s7bS46e8wbaOc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TNTdoac/GLjnZVSunzWXi21xEL+p3a/XH6GucDkCgYr3tS3iVhInnZn1JCV3r79Ev
         8OwhhWGQlyaie0g15UruZiP6VoBBwZd5o31qZeo+E0cuPSSMt+W+dbVjIYi3Ic6cvs
         7lwGU999MQyXkZliLTJ48cBfapYQvEbr5mXLm1AeYDDA0Ar3wKG4DfKuG1Lye71bxg
         V7Xy/NUNjFQmpgS68PpYVHnnnvIf4nw7lP+PZHPQ4xuKf1FEMSmoIwRd6ydXIEefss
         640tR9JE7XP/AiuZrvbco3aiFrr6PHB2dpSU1cVbMEBOc1QB8OjkzOY2lQsHIGcgYg
         CEIjt3hHmxIjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        David Lin <CTLIN0@nuvoton.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
In-Reply-To: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
References: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v1 0/2] Adds the combination of headset codec ALC5682I-VD + amp rt1019p
Message-Id: <166860443597.370630.8092094089019337733.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 13:13:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 12:27:14 +0800, Ajye Huang wrote:
> v1:
> - machine driver:
>   - Adds the combination of headset codec ALC5682I-VD + amp rt1019p.
>   - Remove the duplicate code in machine driver.
> 
> Ajye Huang (2):
>   ASoC: Intel: sof_rt5682: add support for ALC5682I-VD with amp rt1019p
>   ASoC: Intel: sof rt5682: remove the duplicate codes
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: sof_rt5682: add support for ALC5682I-VD with amp rt1019p
      commit: 1a9a5ebe1175537dc817531fe74c5949c3a823c1
[2/2] ASoC: Intel: sof rt5682: remove the duplicate codes
      commit: c7a79f546100300d18585506f8fd0460a874df4a

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
