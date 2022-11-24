Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA49637ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKXSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:11:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F774ABB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 466BCB8289F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187A2C433D6;
        Thu, 24 Nov 2022 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669313499;
        bh=M+OgCzevn1D6Qoo4mZhnn71uBpfyqgXXoGTqdcZD/D0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cTirMyPtLDFz3uon0yERZQRRIOycwf+qiChXWvFpYqu69ikxQhCpIL5fuzhG98Kbw
         8cKlrV1p3gypfeSFrbn+WFFRmL8xLRuueMmE792OVhF1B6QcGz90s78d2qungkpnY6
         pviau679xw1BD4OSd+HRTSDxu2BH2nVgwkfe3o51rLL6tvV9/S8Fd692ZJLwjb+0Ry
         x5XIdTPgEiqGEQCF8ustBqTVV3FiEXlXcTHdFeiJxmJcm9oZQwPkdD1W0DcyKObfl0
         uZEWKzt6HWqawirORO0vSKuzBvahH+JG2akJnZmTiSMYdCO9ml+HM9wuPdBADDrUAM
         z86IL/uLGN83g==
From:   Mark Brown <broonie@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
In-Reply-To: <20221124144708.64371b98@endymion.delvare>
References: <20221124144708.64371b98@endymion.delvare>
Subject: Re: [PATCH] regulator: Drop obsolete dependencies on COMPILE_TEST
Message-Id: <166931349882.593518.13153579998902548078.b4-ty@kernel.org>
Date:   Thu, 24 Nov 2022 18:11:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 14:47:08 +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Drop obsolete dependencies on COMPILE_TEST
      commit: c4b02c92d9673ef4704fd0c8f008fec183517b64

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
