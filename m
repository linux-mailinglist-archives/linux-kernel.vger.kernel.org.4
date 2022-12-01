Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15863F189
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiLANYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiLANYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:24:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74BA8971
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3C32B81F4E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C92C433D7;
        Thu,  1 Dec 2022 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669901070;
        bh=Gv1L8mzWruf2kZR4j/EYe8/gBg6CpJ2Iwl+lSe2cYlU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rtcjb9wRiUPjaixp6sq8FPIgVytUtFthmbkaJM+OHZ3xk+CVBhmSI/8IVGKZlpn8S
         F+PonSJgWHrnP6y7d0MYptOMu6lMvQ3to1NkPBDwLRrC90oHcNXZJi110O8k4UpZNh
         rNCBWapwkziD3lMPYAsBucIlRp2UvJeMa+yFfiaQ3yMNNVsPVjb7v+69YJ/oYypyPa
         Zot5izBv9BcJ8rzeJvtacwN01cC7V2UtNvzyUaP071yN9DiV5/BEANNhBqOjCmsj9S
         8Y3YgwlhiMQffHYDzrxDH/p6X6dBp6fc2SYdEEbsKuoWRwKJxSmwoIDnHM8A7RUMSC
         OUMZtMzivLLdA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rui Zhang <zr.zhang@vivo.com>
In-Reply-To: <20221201033806.2567812-1-zr.zhang@vivo.com>
References: <20221201033806.2567812-1-zr.zhang@vivo.com>
Subject: Re: [PATCH v2 RESEND] regulator: core: fix use_count leakage when handling boot-on
Message-Id: <166990106941.78829.14597904585516332414.b4-ty@kernel.org>
Date:   Thu, 01 Dec 2022 13:24:29 +0000
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

On Thu, 1 Dec 2022 11:38:06 +0800, Rui Zhang wrote:
> I found a use_count leakage towards supply regulator of rdev with
> boot-on option.
> 
> ┌───────────────────┐           ┌───────────────────┐
> │  regulator_dev A  │           │  regulator_dev B  │
> │     (boot-on)     │           │     (boot-on)     │
> │    use_count=0    │◀──supply──│    use_count=1    │
> │                   │           │                   │
> └───────────────────┘           └───────────────────┘
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix use_count leakage when handling boot-on
      commit: 0591b14ce0398125439c759f889647369aa616a0

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
