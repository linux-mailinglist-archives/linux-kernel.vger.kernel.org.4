Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486D702B22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbjEOLKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbjEOLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:09:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09A173F;
        Mon, 15 May 2023 04:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51163615FE;
        Mon, 15 May 2023 11:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B5EC4339C;
        Mon, 15 May 2023 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148993;
        bh=gXRA0nB5EWSDYL8F6QDt7vDePbCehsXI5agSRfHB28s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AWylQUx74RbmjbagscJ4FxKcu8N/agIk/pvC5m3ORLychlc50t5NEsA41r2hDgPHa
         2/F8LJwn2GX+hN91KKRtvdBQPgSmj/B//DJHn2JatFZjhP4NgkoX7NbyRUhDN3JSHU
         BgmfzArthwg0NXqpm9y7AOr10d+pCy5MLACEkaPGFPChb14TByznQ9ovS/nW+oNZhG
         9Jpsxpb/7PnjVagqHtLc9SYr+GFa5BhFpyiRmOMVjNH3W3fsaAUmx6d6T9c7n0ICER
         8MzeY6Qod6FLqJRFxOinHX089OKQjvmuqxNg+I6x5y+WiRK3thnfjROOOSopsoPdUA
         hymXLTR/z5yrQ==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     srinivas.goud@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
References: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its
 ready
Message-Id: <168414899233.394221.4060404073458234493.b4-ty@kernel.org>
Date:   Mon, 15 May 2023 20:09:52 +0900
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

On Tue, 09 May 2023 17:41:52 +0100, Charles Keepax wrote:
> Recent changes to cdns_spi_irq introduced some issues.
> 
> Firstly, when writing the end of a longer transaction, the code in
> cdns_spi_irq will write data into the TX FIFO, then immediately
> fall into the if (!xspi->tx_bytes) path and attempt to read data
> from the RX FIFO. However this required waiting for the TX FIFO to
> empty before the RX data was ready.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-cadence: Avoid read of RX FIFO before its ready
      commit: a84c11e16dc2cc1faad2e688f8c12beeb369d80c
[2/2] spi: spi-cadence: Only overlap FIFO transactions in slave mode
      commit: a0eb7be22c0f934d1fe7e1131f174ef5bc59d3f9

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

