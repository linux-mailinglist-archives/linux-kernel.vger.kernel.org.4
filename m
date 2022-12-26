Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64D65660B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 00:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiLZXed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 18:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiLZXeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 18:34:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9D271D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 15:34:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A90AEB80DCC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2235BC433EF;
        Mon, 26 Dec 2022 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672097644;
        bh=U8xN5fqN2RpLO0+0uf2AAte4B5MTp6owYgnVxY3XP9g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Dz7mQxD08oUWwRqgseibhWjRzBHJWwOSTl1xIGj4Gs3hOeW5GOpqKB7AvpR9l7ui5
         cJRqxucj+FQucllQVISjYq+TdykyKwmDpKGOzerZw2X/73v3rvwFJ7v1R0F5NfOZTN
         y+3szaN7bhpPwau8BI9Y7znhfWnFYBGMbO7hzyLfu1V6Sl+7H1o41ZrUO4NHHTmO3y
         0wZ9soWrSaL08cVgckBgPlQvTGy9gJ+wG8rjOqlEE03Fp3V7vXd0SsE+lWHppdFJjD
         nqE9op8jP46vczOSBsqDMewy2Bd/LdsIdfOwHtCU8hIAfLRKgKUmmuq+wJEHcCwhLc
         nu5qpLQyheU0g==
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
        Takashi Iwai <tiwai@suse.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        David Lin <CTLIN0@nuvoton.com>,
        Libin Yang <libin.yang@intel.com>,
        Mac Chiang <mac.chiang@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221221132515.2363276-1-arnd@kernel.org>
References: <20221221132515.2363276-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sof-nau8825: fix module alias overflow
Message-Id: <167209763984.330820.8290497539067890342.b4-ty@kernel.org>
Date:   Mon, 26 Dec 2022 23:33:59 +0000
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

On Wed, 21 Dec 2022 14:24:56 +0100, Arnd Bergmann wrote:
> The maximum name length for a platform_device_id entry is 20 characters
> including the trailing NUL byte. The sof_nau8825.c file exceeds that,
> which causes an obscure error message:
> 
> sound/soc/intel/boards/snd-soc-sof_nau8825.mod.c:35:45: error: illegal character encoding in string literal [-Werror,-Winvalid-source-encoding]
> MODULE_ALIAS("platform:adl_max98373_nau8825<U+0018><AA>");
>                                                    ^~~~
> include/linux/module.h:168:49: note: expanded from macro 'MODULE_ALIAS'
>                                                 ^~~~~~
> include/linux/module.h:165:56: note: expanded from macro 'MODULE_INFO'
>                                                        ^~~~
> include/linux/moduleparam.h:26:47: note: expanded from macro '__MODULE_INFO'
>                 = __MODULE_INFO_PREFIX __stringify(tag) "=" info
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof-nau8825: fix module alias overflow
      commit: 3e78986a840d59dd27e636eae3f52dc11125c835

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
