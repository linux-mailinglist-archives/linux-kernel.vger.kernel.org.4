Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C65B42B2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIIW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIIW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:57:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C004108737
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 15:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E915CE2479
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 22:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF068C433D6;
        Fri,  9 Sep 2022 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662764221;
        bh=T7EGkQFNZ4TLhBEc3jwOP5d1nX+ofEwNi7R64f46odM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tjl+0alfiIdUyGpBWXwXaZHMw3rsOXnUCjKZH9df0E6f8qHfzzIqEDemLdNSWc2PR
         PsAsJh4T6SSuTnhQLaPZxVnN6C9b1y9YSEaTSW3t/6iTRLhASzEXF30J7ETf6QOEIU
         XdtqbLW2wX8Q8r8pXAO1cYTcoRDWJPfgEZkee7YDGwtmhlerQkXIFH/Wg2L6hBr4/+
         yiAA3I2BpO5/9Ye6vTVjDIAaVHr9eiaseN3LGKskOE9N54eFL9DVo8hLdxDJMrbWGp
         LLHLYOc5aoDjMeOghAejkVp1LBOYkVbVzVW8oHTlBjFDutjHYf4fWtATrtREsJAFVc
         vVbEzh/o+Qukw==
From:   Mark Brown <broonie@kernel.org>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220909125954.577669-1-patrick.rudolph@9elements.com>
References: <20220909125954.577669-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH] regulator: core: Prevent integer underflow
Message-Id: <166276422064.339577.12378154352653239391.b4-ty@kernel.org>
Date:   Fri, 09 Sep 2022 23:57:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 14:59:53 +0200, Patrick Rudolph wrote:
> By using a ratio of delay to poll_enabled_time that is not integer
> time_remaining underflows and does not exit the loop as expected.
> As delay could be derived from DT and poll_enabled_time is defined
> in the driver this can easily happen.
> 
> Use a signed iterator to make sure that the loop exits once
> the remaining time is negative.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Prevent integer underflow
      commit: 8d8e16592022c9650df8aedfe6552ed478d7135b

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
