Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB963ADEE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiK1QjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiK1QjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:39:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842B124F3E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:39:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21ABE6124B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA245C433C1;
        Mon, 28 Nov 2022 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669653557;
        bh=+RjjnLRA0PH8CYlIY/YFg0sUTEF2nzMQyaZ7sugZIYo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JhANnu9z5ZuAosDh25F5kpHEJXhjyuzHPJaWxhZo9rvSZdNYotJ4h2n+S/YkowGCR
         RQez6rjW/CEAfvsWdtWwO1D8m71nTp9ir7lbwknHvYjChSciVNprWJzR9LN1nTGvPo
         Y+e81bnqbDtH6NaNaPG0JUJQ1m7O796X6yddRn1asQctb3a97k0wwCVWDmoTDovFX6
         wsQjqPpB/IYyTkCB8TrcEaUOhcBMbuNjrrvNbiDFmhmxMpV6vmvajQ4pO8/tRp98Hq
         GQq5cjW/2wlHxjHs37xTWhzT/0PQNM1U4HgXmWPkJUJu7VDvd8XRufzOZ5XI1Yr6EU
         CGi5PgF10k8wQ==
From:   Mark Brown <broonie@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20221127193549.211bf8f7@endymion.delvare>
References: <20221127193549.211bf8f7@endymion.delvare>
Subject: Re: [PATCH] ASoC: SOF: Drop obsolete dependency on COMPILE_TEST
Message-Id: <166965355561.629583.9704123228167531546.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 16:39:15 +0000
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

On Sun, 27 Nov 2022 19:35:49 +0100, Jean Delvare wrote:
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Drop obsolete dependency on COMPILE_TEST
      commit: 11e87890dab52d14af2b2f3945835ec6db473e3b

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
