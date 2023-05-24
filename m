Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64FF70F5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjEXL6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjEXL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1818B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2B963163
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4478FC433EF;
        Wed, 24 May 2023 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684929520;
        bh=/B0vdMufjSzg+kWpfRvse4iAzkRz1UKFhqFiVIC2l3g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MqhflI3Gwts1TEZhQ9dRco3qCqLLYolvjSx+5bt9qY3IxV9KmhdfIkiMcyR3atk4U
         +8EbZbat46iKnI2t9WIpFyBhnaj5oC6FFdbzaSlq8jj1oZFX2vMwYXBIB+eLy4XLBO
         ScZzjaIjqJBOZkHeMpxlRQI3ypqu4Le1NBUiZaxC4CHanI+xwMUk/6Q7quV4kcbWFD
         5bCypJgj7hTWQd9lXQtmFNXlhvYuucDfhb3u8MNMQlZPuTcxuupJEY9Pue8S94uQS5
         WHK7FyQwDF+ldm7tBAJAVg6gKR682aDqjhDYTnFoJNmafur9YKu2EexS2599PW95eV
         +Qv61NgH2FADA==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230523-regcache-maple-sync-lock-v1-1-530e4d68dfab@kernel.org>
References: <20230523-regcache-maple-sync-lock-v1-1-530e4d68dfab@kernel.org>
Subject: Re: [PATCH] regmap: maple: Drop the RCU read lock while syncing
 registers
Message-Id: <168492951899.55912.11663734518532161454.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:58:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 23:18:19 +0100, Mark Brown wrote:
> Unfortunately the maple tree requires us to explicitly lock it so we need
> to take the RCU read lock while iterating. When syncing this means that we
> end up trying to write out register values while holding the RCU read lock
> which triggers lockdep issues since that is an atomic context but most
> buses can't be used in atomic context. Pause the iteration and drop the
> lock for each register we check to avoid this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: Drop the RCU read lock while syncing registers
      commit: 0cc6578048e0980d254aee345130cced4912f723

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

