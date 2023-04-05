Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48B26D7DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbjDENnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbjDENnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8225FEA;
        Wed,  5 Apr 2023 06:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58877622F5;
        Wed,  5 Apr 2023 13:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60639C4339C;
        Wed,  5 Apr 2023 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680702217;
        bh=nzW9GXu4fJr8MQ7q2D6750aX7OayA7bf+IqPNBUaxn0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bslrsp54BFh3IVhBrd0bMDqAcFYex9mGzEwOpzb6/JrzTGH33pAMhWsFkrGUZ+fPP
         NmoB2MjzdLGwwZ9l3fUZhFP+czmBE8dGvCuhPx57HFsn1giSSWkJJLzZ2fu2ViC2Ym
         QQw2NU+Ii7HOIXMDqI6mEk1uy+EU6MQOLPeNf1aGN2f8CQpmluzHF4ve3d2wqNBGqu
         jIoie6+V2WLIHIe/KbTyt51Sq7eiZCbh0c9IEtJH9LnHEEnzbx4UC/pmkw+Wa12crw
         wM8s4VjDvFnOdyPf2eVioKITTwVqZo0J1c7ZKGgKT45ELTUtTL6NwFeAF/V4NM/tb5
         fFnzo5LTAekUQ==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
In-Reply-To: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
References: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/5] spi: fsl-spi: Fix CPM/QE mode Litte Endian
Message-Id: <168070221612.64941.15188602893204160397.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 14:43:36 +0100
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

On Sat, 01 Apr 2023 19:59:46 +0200, Christophe Leroy wrote:
> CPM has the same problem as QE so for CPM also use the fix added
> by commit 0398fb70940e ("spi/spi_mpc8xxx: Fix QE mode Litte Endian"):
> 
>   CPM mode uses Little Endian so words > 8 bits are byte swapped.
>   Workaround this by always enforcing wordsize 8 for 16 and 32 bits
>   words. Unfortunately this will not work for LSB transfers
>   where wordsize is > 8 bits so disable these for now.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: fsl-spi: Fix CPM/QE mode Litte Endian
      commit: c20c57d9868d7f9fd1b2904c7801b07e128f6322
[2/5] spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      commit: 8a5299a1278eadf1e08a598a5345c376206f171e
[3/5] spi: fsl-cpm: Use 16 bit mode for large transfers with even size
      commit: fc96ec826bced75cc6b9c07a4ac44bbf651337ab
[4/5] spi: fsl-spi: Change mspi_apply_cpu_mode_quirks() to void
      commit: 99aebb3c1b418d865461aa0813ef1b55285cbda4
[5/5] spi: fsl-spi: No need to check transfer length versus word size
      commit: 4084c8ca1266ba09554de8df19aac82b6dd2e079

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

