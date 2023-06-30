Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AAE7440DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjF3RII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjF3RIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB03ABD;
        Fri, 30 Jun 2023 10:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DAD5617C1;
        Fri, 30 Jun 2023 17:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA85EC433C0;
        Fri, 30 Jun 2023 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688144876;
        bh=hrxpSi6TuuolWxR7KX8iVhhKvwNa6g0/omT/CMjj44w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S6muFlS64hSp57AMw20ylJybvF/6sI0y+KNfKJ5xwChdTKNyKfvlpZ1u0wtQ4rf3I
         Yf65lolH7Ws7mXowPhA/GuNin2ITr0L739vhGsWdDtoI76bceA0GHidlSuXiBU503Y
         q7Yfa+Vjof/dynrhj6FpW/fnQdhMvF0oYaDfaMaaCzBzJgReWmhgUxDhiWS2kf4yBh
         Znmg4AD2T1Bv5Vi1pDo/L8m6pywAOHIOMV2e8PFXYlYvybJytfWd8uQqsx17gCypz4
         h9faWHFFSRDIsNDFvlf7jtv6Uu1YvnpbJnuceJJvbkX2YKnD3Zg7Pl8L0TDs6gLdM0
         oCKFaHQWKUV/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230629134306.95823-1-jonas.gorski@gmail.com>
References: <20230629134306.95823-1-jonas.gorski@gmail.com>
Subject: Re: [PATCH] spi: bcm-qspi: return error if neither hif_mspi nor
 mspi is available
Message-Id: <168814487467.51089.16336966927742443437.b4-ty@kernel.org>
Date:   Fri, 30 Jun 2023 18:07:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 15:43:05 +0200, Jonas Gorski wrote:
> If neither a "hif_mspi" nor "mspi" resource is present, the driver will
> just early exit in probe but still return success. Apart from not doing
> anything meaningful, this would then also lead to a null pointer access
> on removal, as platform_get_drvdata() would return NULL, which it would
> then try to dereferce when trying to unregister the spi master.
> 
> Fix this by unconditionally calling devm_ioremap_resource(), as it can
> handle a NULL res and will then return a viable ERR_PTR() if we get one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
      commit: 7c1f23ad34fcdace50275a6aa1e1969b41c6233f

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

