Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4D6FB175
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjEHN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjEHN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6733877;
        Mon,  8 May 2023 06:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2CD63D41;
        Mon,  8 May 2023 13:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3898DC4339E;
        Mon,  8 May 2023 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683552434;
        bh=7oT2N+sWhq6x1bL7qwv1+/z8qSDQX8Sm1yQFs8XmMJg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KlrDT8qcLs08Q7PVN9U7iQB88i2jPSzY9jnYKxD11Lo+uBolYUZu7BnDJeSxJ25DL
         0DLXHCcUwEr6ojp2wnC9fkqkroDHaMuMR/EIGlyO4fVfWphaxxL9gdb8MpqJgTLg/s
         mssiKmtbAOAyMdXBF384bp9es7xLv+gDLhotvG98KqzqzGKTyHiPZXaHQa6iupK0uB
         UsW5S3T6e4dvjvDlbD52XpcLfcph7Kf2kefHCqNrZdUSiQXWD1cO1qjipkEbS9WtOp
         hYuDu2OqG0CMmkFvFXnH5Pf6e6B+y/p0CGg7MWS7xmt7HzLmkm4Hmdnrq+ChQ42poZ
         PljL3+24WZU0A==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
In-Reply-To: <20230502062813.112434-1-jaewon02.kim@samsung.com>
References: <CGME20230502065025epcas2p16f5a02e6990d6f2b2257f001979ebcf9@epcas2p1.samsung.com>
 <20230502062813.112434-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH v3 0/3] Improve polling mode of s3c64xx driver
Message-Id: <168355243249.260152.7852993602343568798.b4-ty@kernel.org>
Date:   Mon, 08 May 2023 22:27:12 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 May 2023 15:28:10 +0900, Jaewon Kim wrote:
> Previously, polling mode was supported as quirk for SOC without DMA.
> In order to use it more flexibly, it is supported when there is
> no dmas property in devicetree, and the issue of using excessive CPU
> usage in polling mode is solved by adding sleep during transfer time and
> supporting interrupt mode.
> 
> Changes in V3.
> - Fix patch commit message.
> - Change of_find_property() to of_property_present() with code cleanup
> - Remove cpu_relax() related patch.
> - Changes use_irq variable type to bool
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: s3c64xx: change polling mode to optional
      commit: d1a7718ee8dbcc488d3243d52e19c755123e0024
[2/3] spi: s3c64xx: add sleep during transfer
      commit: 3456674f54d3cfdedb28ce8a3db2b6f975392ac8
[3/3] spi: s3c64xx: support interrupt based pio mode
      commit: 1ee806718d5ef7de31c6063c4493f3d6527c9427

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

