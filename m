Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4A667E70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjALSyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjALSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:53:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74885C89
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:24:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DB72B81FB3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33347C433D2;
        Thu, 12 Jan 2023 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673547825;
        bh=3imop1nfFEnzeDa06BtYeQWlSuMolSQ7BMbFpqXcv+g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bTRUbuns7Dj7Sr+RfeJbnOAnkV+eqjwJpDpA4wkpyIlHZBAcwdRpm/VjKDtWDFVfJ
         DaMzyaH+eeC0h0XLkDUPsea51EpuQqlCUCR9RlOC5+xWbZltiHlRbjeMnaY/vE5D78
         HLVGEYizweadjUhnKJ5BWTIobJ5NWItVA/3vq9glwzffYU3q7lSl4RDhZMnfXjJtXV
         5sqHKHVniZLtTCgghPQTb7EJrIW2VuEhxLKWfQ7ywD6SMat5KRsIwzQXIPxnsIhnZ9
         DBgDs7qp12dyWDmSMrxQR+PtwleZG3r52FkRiTunWrDesy4uE9qlJJxAOvUNDa4yFY
         MjIqDWpPA3Hzw==
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
References: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: Balance ACPI device refcount
Message-Id: <167354782291.2217680.16107261306458603255.b4-ty@kernel.org>
Date:   Thu, 12 Jan 2023 18:23:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 13:28:47 +0200, Andy Shevchenko wrote:
> While looking for the open coded put_device(&adev->dev) cases, where
> adev stands for ACPI device, I noticed that in a few ASoC Intel driver,
> among others, the refcount is not balanced properly in some cases.
> 
> This series fixes that issue and converts to use acpi_dev_put().
> 
> Changelog v2:
> - split Intel drivers out from others (Pierre)
> - sent with cover letter (Mark)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: Intel: bytcht_es8316: Drop reference count of ACPI device after use
      commit: 6b1c0bd6fdefbf3c3d75680c2708f5423ef72e46
[2/5] ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after use
      commit: 721858823d7cdc8f2a897579b040e935989f6f02
[3/5] ASoC: Intel: bytcr_rt5640: Drop reference count of ACPI device after use
      commit: cbf87bcf46e399e9a5288430d940efbad3551c68
[4/5] ASoC: Intel: bytcr_wm5102: Drop reference count of ACPI device after use
      commit: c8aa49abdeda2ab587aadb083e670f6aa0236f93
[5/5] ASoC: Intel: sof_es8336: Drop reference count of ACPI device after use
      commit: 64e57b2195725c1ae2246a8a2ce224abb60620ac

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
