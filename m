Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865A86D9BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbjDFPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbjDFPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:04:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0DE35B1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BCEA60E8E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F2DC433EF;
        Thu,  6 Apr 2023 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793423;
        bh=/X1tH0n4t2uJDd/53PFTPMGPSc3qPfpbDoW0shsZexs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RTZ+ZRPVqTTZDql6ttWSPJ6+ZxzfXTzQ0tkmW08ZnM9VKNgon/ZT/5QEs4luJMedN
         D+eaHbiO5FSgy+BiL/hbC6FkAbTywIZzChyQ3B0AIJ4+kxOC8tUtNK1s0WfvGu6KfI
         w+i9n0rPluPetXSKcI4d+7X08KQqR+m4nSJCA4AX4DwTFFGuMECbHZDmGxsRv8eZdD
         spkCjnlo3Bb5zqVmVWR8UJzl5vpFfkVZ5rjZIBEsS21DaYtzb6vN4dtF/LNqXZj3S8
         A+mddE2vwXM1ZUfhJ9lWGwy0VqO1VuEc7aIXpVfU2EoVgFpMOb7+3SlN+lpxbKEnN6
         ThJpPlaxaEYLg==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Collins <quic_collinsd@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
References: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
Subject: Re: [RFC PATCH v2 1/2] regulator: core: Consistently set
 mutex_owner when using ww_mutex_lock_slow()
Message-Id: <168079342195.66497.14611938382730505037.b4-ty@kernel.org>
Date:   Thu, 06 Apr 2023 16:03:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 14:33:53 -0700, Douglas Anderson wrote:
> When a codepath locks a rdev using ww_mutex_lock_slow() directly then
> that codepath is responsible for incrementing the "ref_cnt" and also
> setting the "mutex_owner" to "current".
> 
> The regulator core consistently got that right for "ref_cnt" but
> didn't always get it right for "mutex_owner". Let's fix this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()
      commit: b83a1772be854f87602de14726737d3e5b06e1f4
[2/2] regulator: core: Avoid lockdep reports when resolving supplies
      commit: cba6cfdc7c3f1516f0d08ddfb24e689af0932573

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

