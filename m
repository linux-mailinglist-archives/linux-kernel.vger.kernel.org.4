Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC76FBF52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjEIGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjEIGix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCCD052
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0002E62E90
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153E7C433D2;
        Tue,  9 May 2023 06:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614322;
        bh=lAOoAECVpMoCOowjJYUiemBGQR7sN94PdRfyG4VySYE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MGM6PYlCqDWUw1JwT+EFrLng4WmNtRpTlTldeioTgOdsoAHRl8NHJxzhT0itnxoAU
         AdUZ56frI9ZG09zhSS7qnRn77F9spA0Vv8wEgvQ1KE32SFQtQ9NVyZtkFyta6JtQ3b
         oFCYPs9C8EVpkObuk1cMyKu9hYxE+cSp1yVxliWFvT8AGRLXZwNRnAFuB2Zwvo7gRq
         /Z4V4LvyFOlWkiYJQM8g6rk+HtOsOcfFwBI+aV0MD1kwr33gUA1Oev1jnY29lyLYWr
         U/Pc4bvsqc79LRQAekTM+Uoq4Ch/+NwX17h9+wFAZMVMCpJP/cPderHYfnx/hqQlsv
         WOfrXKebn7VmA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, nicolas.ferre@microchip.com,
        u.kleine-koenig@pengutronix.de, chunxu.li@mediatek.com,
        tinghan.shen@mediatek.com, error27@gmail.com, ribalda@chromium.org,
        yc.hung@mediatek.com, Allen-KH.Cheng@mediatek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
In-Reply-To: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
References: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 0/5] ASoC: MediaTek MT8195/86 Cleanups
Message-Id: <168361431059.303059.10248668166730992280.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 15:38:30 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2023 13:34:08 +0200, AngeloGioacchino Del Regno wrote:
> This series performs some cleanups for mainly MT8195 and switches
> both MT8195 and MT8186's SOF driver to the snd_sof_ipc_process_reply()
> helper.
> 
> AngeloGioacchino Del Regno (5):
>   ASoC: SOF: mediatek: mt8195: Use snd_sof_ipc_process_reply() helper
>   ASoC: SOF: mediatek: mt8186: Use snd_sof_ipc_process_reply() helper
>   ASoC: mediatek: mt8195-afe-pcm: Simplify runtime PM during probe
>   ASoC: mediatek: mt8195-afe-pcm: Simplify with dev_err_probe()
>   ASoC: mediatek: mt8195-afe-pcm: Clean up unnecessary functions
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: SOF: mediatek: mt8195: Use snd_sof_ipc_process_reply() helper
      commit: 06ba8020287f43fc13962b158d8dec2689448a5a
[2/5] ASoC: SOF: mediatek: mt8186: Use snd_sof_ipc_process_reply() helper
      commit: 709f34b41ceffedec17d1150018cf62f8ea95842
[3/5] ASoC: mediatek: mt8195-afe-pcm: Simplify runtime PM during probe
      commit: 2ca0ec01d49c9c2742c2151ae94c94bdf36bb1b8
[4/5] ASoC: mediatek: mt8195-afe-pcm: Simplify with dev_err_probe()
      commit: 863da1c17616e45f1472370892b6c925cee27e24
[5/5] ASoC: mediatek: mt8195-afe-pcm: Clean up unnecessary functions
      commit: 686d041685639493a608bdcdb0d00551796721c9

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

