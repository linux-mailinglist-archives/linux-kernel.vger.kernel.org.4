Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1584068C03D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjBFOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjBFOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:36:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C46927D5E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CA77B811AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAE5C433EF;
        Mon,  6 Feb 2023 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675694196;
        bh=nTY8sKhJB1bjGQ0iOiBjQUEA0vT3H8gc99+No3TROzI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ozChjcG2/QL1D8LvTg3RxVTexij9GkMUrnlMzj+2qnYQvDyez+oliTgTdU8aE3mKp
         kWObJbISjFyfwUXHMhYlp2aGpZd5CoIlWOqK3H+NrncNE0xc7/65iqDhoOiHUV0Rz7
         VuNcl+5w3nCaizpg+1JjeVtBqiRlCNN9yY/szE1HM+gvR9OxMxyiz1AnX7TgbIr63z
         wSiP1pAdMX93crgGe0aamjkMgfDQ6ZIwuxZd6NCkQwWYm+57nDuLhiCrCQX8bomQeH
         +WHGs6sR76DPQVh7l/dC0ObWCkH8hE4o0f4f4LwpXu8yS414sxbjCgcAsFn7nwT9Ow
         ks0SXUtwEowrw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        liweilei@awinic.com, colin.i.king@gmail.com,
        wangweidong.a@awinic.com, zhaolei@awinic.com,
        Tom Rix <trix@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230205015733.1721009-1-trix@redhat.com>
References: <20230205015733.1721009-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: codecs: aw88395: initialize cur_scene_id to 0
Message-Id: <167569419441.112200.7737939979688207071.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 14:36:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2023 17:57:33 -0800, Tom Rix wrote:
> cppcheck reports
> sound/soc/codecs/aw88395/aw88395_lib.c:789:6: error: Uninitialized variable: cur_scene_id [uninitvar]
>  if (cur_scene_id == 0) {
>      ^
> 
> Passing a garbage value to aw_dev_parse_data_by_sec_type_v1() will cause a crash
> when the value is used as an array index.  This check assumes cur_scene_id is
> initialized to 0, so initialize it to 0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: aw88395: initialize cur_scene_id to 0
      commit: 983272a2a223de59dbb4cb189aa4d02d7156d209

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

