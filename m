Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB76AC110
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCFNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCFNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:31:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B642E81F;
        Mon,  6 Mar 2023 05:31:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E00FD60F29;
        Mon,  6 Mar 2023 13:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5A3C4339B;
        Mon,  6 Mar 2023 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109512;
        bh=lOMMXCrqcZ0WdD9lu+uR7/4pU15uVAojtXmRh6v04yw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AeZk/3JJHagl8xaCuTIAc3M4RebSNAzb28psjHJWhcCVhm4M/S6iy+HVD5gJkc0mh
         n/10jZHJnvbWRU9xkVYRXrc0H2K4Y9H07xtpRiwr9CezUBbB+x88PDR1TPfWOTJqOO
         o9vQtdgOvi1MXdiKZQKLIFsavxcz6t2x6zP2FnkVjOT4fMr4/ePXE9RlPDvlztXPBT
         TYOYldIygLg1602a+elpTozZ92cX8OJofiE+Y0d6+xkr8uV5bFBgFLX1TVDbvMrPR+
         rXjC0fTyXdCg2kR+u7N6h7UH38u1RXgQQ4TBoPSyb8NPmpS5rPZxsY8CzR3gcueMvA
         Vl6dtQ/x0XsjA==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <Y/gyIg1qZduhigPi@work>
References: <Y/gyIg1qZduhigPi@work>
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Replace fake flexible
 arrays with flexible-array member
Message-Id: <167810950942.75807.970526676500961922.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:31:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 21:42:26 -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members, instead.
> 
> Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
> arrays in unions with flexible-array members.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> sound/soc/sof/ipc4-control.c:176:77: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:78:29: warning: array subscript 0 is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:80:33: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:95:53: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:96:53: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:93:53: warning: array subscript 0 is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:140:58: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:141:29: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-control.c:142:29: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-topology.c:1475:36: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> sound/soc/sof/ipc4-topology.c:1476:36: warning: array subscript i is outside array bounds of ‘struct sof_ipc4_ctrl_value_chan[0]’ [-Warray-bounds=]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Replace fake flexible arrays with flexible-array member
      commit: 587cbe99152fd735605f3502f42f640bb54f6048

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

