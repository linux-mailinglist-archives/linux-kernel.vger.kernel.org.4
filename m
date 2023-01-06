Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A81660905
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjAFV5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjAFV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:56:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96F7A3B7;
        Fri,  6 Jan 2023 13:56:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 626ACCE1E7F;
        Fri,  6 Jan 2023 21:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC6C433EF;
        Fri,  6 Jan 2023 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673042209;
        bh=W8Jp+Iv7U6tzDRr3G/V0I5zmQ7OAuAiols6tlyh1DdU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O0Ei8LxZHTZ3xU2wjzz5MfpxwoKPc6JqtOvkj6mxx3qtRqHbcu7EA+1uDviDUR7Ak
         jF+E8iHN1F5JQdmSVkU3b11wCtn/5y9eKTS6rhxQNlvVn8G9r6JDMuJJt9FHGdeoxb
         tN38w7RgwVSL8+WHn5G15aRsCUU+Evf+yi374xzKbwo3yiVJyLW96jZw6yZDqPmKCZ
         oGWcG5BIONwRSfy9UhYUnqr6+Z4GF387HldCWo2G3r3S1ezkQkmbVV51jMGKT0fg0d
         yfuCQ5rHOgcVbhEDVOn+MliejuqAKl7rChp0nELmB50nvmt7dyOKVrHm/vqas81Mdk
         uK0BGEX8FOBgQ==
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20230106100719.196243-1-brgl@bgdev.pl>
References: <20230106100719.196243-1-brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing
 spidev->spi
Message-Id: <167304220835.799739.15392427246183345092.b4-ty@kernel.org>
Date:   Fri, 06 Jan 2023 21:56:48 +0000
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

On Fri, 06 Jan 2023 11:07:18 +0100, Bartosz Golaszewski wrote:
> There's a spinlock in place that is taken in file_operations callbacks
> whenever we check if spidev->spi is still alive (not null). It's also
> taken when spidev->spi is set to NULL in remove().
> 
> This however doesn't protect the code against driver unbind event while
> one of the syscalls is still in progress. To that end we need a lock taken
> continuously as long as we may still access spidev->spi. As both the file
> ops and the remove callback are never called from interrupt context, we
> can replace the spinlock with a mutex.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spidev: fix a race condition when accessing spidev->spi
      commit: 1f4d2dd45b6ef9c047f620d2812326a7813d2354
[2/2] spi: spidev: remove debug messages that access spidev->spi without locking
      commit: 50028988403ab8e031093655af9c6919ecba3aa6

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
