Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38928730066
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbjFNNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbjFNNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21E180
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DACBF64263
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0517C433CC;
        Wed, 14 Jun 2023 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750462;
        bh=wuDVEmVy7ZfrpvnVH6Afr8INW+EeROqcZv0MGRWCGEw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hApTnJUUcjC43BKP75NpdZZFIjNJlWj91JjmxoTejeXZhI0wdU7jtrcLbTLiErn+s
         TNQ+h7Y9GgHt5VUL+/h90kL413uOfI7VCcsK0Z0DoMwK8ncwWpCIrg0bI9NGJD+1b5
         BSeaZicogmF0aRyPo95thP3d55Y3CpYZTR7SyIPhTCoSpWrlUMI3cCz1dEc90Snb7h
         1IxiQKQisHdsOZqbBxdCL7QD49ZTNLqGmpokYYleCEqmCgHvmyoh/woJkBTOWg+qFp
         haSNpEiuQ/kcTmyJtRtkgFuQSg1iwwVWFVFd3NVbcGah34zBhnf+F8ClB/1y28LPTG
         hxb6V3dRR58Qg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     vsujithkumar.reddy@amd.com, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        syed.sabakareem@amd.com, mastan.katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230614103707.2246296-1-venkataprasad.potturu@amd.com>
References: <20230614103707.2246296-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: Add support for IPC with a reply_size
 set to zero
Message-Id: <168675045755.162323.4223921014573078943.b4-ty@kernel.org>
Date:   Wed, 14 Jun 2023 14:47:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 16:07:05 +0530, Venkata Prasad Potturu wrote:
> Add support for IPC tx_message with a reply_size set to zero,
> return zero when message reply_size is zero at acp_dsp_ipc_get_reply().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: Add support for IPC with a reply_size set to zero
      commit: fd01a15164a15328fd96f9ce820f0fc9f700f00b

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

