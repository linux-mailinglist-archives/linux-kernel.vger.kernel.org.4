Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874D6660541
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjAFRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjAFREz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:04:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2567BDE7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:04:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EC2461EC9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87288C433D2;
        Fri,  6 Jan 2023 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673024693;
        bh=UVKsY5pp2vhAxXKSR8hDZtBUPV1iYvpC4veubRkiAQg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tOlTP9ghvlqltjOiiof5qkpx2g2ojkcl/zhvtpXVyt03L6izlU51CXAGkcV97/Lwg
         x8NSUq9I8h94J5IVEx728F11JGuVtPYqCdDB4jIFZPsxRttZ0p0G0hf2761oxYYhS0
         iLKCRIaHb3YZKe1GEDu+E/ultJct6NCNXkk+rkBF4ezRwS8HZ93i6iSuOVXOK/SYaf
         7FHEEvf7cTyry+6DoaNMgXWnPacVSl27ZIG3oXlyhbVDaH6N5JH8kwUFc1NOb0h9Ip
         Gd+OMd2kDIotZn+qPQhGfKYItOkDbvJqRdyNiXIsr6yVQBOoSePUiNewEYkwB2+IE3
         koRWLWQwOsI4g==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Message-Id: <167302469126.215080.4413513420785608198.b4-ty@kernel.org>
Date:   Fri, 06 Jan 2023 17:04:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-214b3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023 22:30:33 +0200, Andy Shevchenko wrote:
> Instead of calling put_device(&adev->dev) where adev is a pointer
> to an ACPI device, use specific call, i.e. acpi_dev_put().
> 
> Also move it out of the conditional to make it more visible in case
> some other code will be added which may use that pointer. We need
> to keep a reference as long as we use the pointer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded acpi_dev_put()
      commit: 7baff1a9debc5f4ff0d6bc1496358e251f66e396
[2/5] ASoC: Intel: bytcht_da7213: Replace open coded acpi_dev_put()
      commit: 4afda6de02285758c9b892a2e79658966d3cfbb0
[3/5] ASoC: Intel: cht_bsw_rt5645: Replace open coded acpi_dev_put()
      commit: 5360a1c0f251b8000e9b2ea7b9f9e40c2e8f1c83
[4/5] ASoC: Intel: cht_bsw_rt5672: Replace open coded acpi_dev_put()
      commit: 6736dd4e5b58f27983ab3dba5fa96ed97768beaf
[5/5] ASoC: Intel: sof-wm8804: Replace open coded acpi_dev_put()
      commit: 892dbe0ecf658fd23e0a7255fca26a216cf54f96

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
