Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A43696EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBNVLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjBNVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E942CFF7;
        Tue, 14 Feb 2023 13:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA13618D1;
        Tue, 14 Feb 2023 21:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F2DC4339B;
        Tue, 14 Feb 2023 21:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676409059;
        bh=fDIAaeLvnV9bS7cSr3lrCN+H7tSKNpzTS60LB1VS550=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OYpoOHHcfZA2DoLCNbBAVzJp8sFxNPyS2f/SZUonAGV6v84jwoP6HqzaINqJtJx+V
         eNmLIK6bSwMZgADeM3pRNmocG+FeYNk+b2jLHgYGEO4Syrmg1sms51h2Pt1t/JASMr
         YnRDg5v8rcyKFFpsgpX5QG1bx89dNfflDCBybv4Y0t943O27UPUnPCpGi1M2wRZYDv
         ydw57lZOktRsllTgxazuatWX1dI+cHkYEl/g3N0VhTVcuQON4t471d8GUtHahLcnQ6
         r+PRS9MX7YFgBVhye1WUn+fM7FlmI66WbRT7vi9zOQaMcfmuR/grFUbU7g36CKCWBf
         FShqN3cntzCKA==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Takahiro.Kuwano@infineon.com,
        Pratyush Yadav <ptyadav@amazon.de>,
        Pratyush Yadav <pratyush@kernel.org>
In-Reply-To: <20230125081023.1573712-1-d-gole@ti.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
Subject: Re: [PATCH v2 0/4] STIG Mode Fixes for spi-cadence-qspi driver
Message-Id: <167640905650.3115947.2076945563527929294.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 21:10:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 13:40:19 +0530, Dhruva Gole wrote:
> * Reset the CMD_CTRL Register, without which read/writes in STIG mode
> were failing in some cases. The issue came to light while using STIG
> Mode for small reads.
> * Also add a flag that can allow us to do direct reads but distinguish
> direct writes, thus enabling us to disable writes in DAC mode in some
> cases that require it. (Like to write to some connected Flash registers)
> * Fix register reads in STIG mode and also use STIG mode while reading flash
> registers.
> Currently if you try to read a register while in STIG mode there is no
> support for ADDR and thus naturally a register never gets read from the
> flash.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/4] spi: cadence-quadspi: Reset CMD_CTRL Reg on cmd r/w completion
      commit: d4f43a2d05faf7febb839edb2e9e8f85dfb9d2d2
[2/4] spi: cadence-quadspi: Add flag for direct mode writes
      commit: e8c51b164355c1d519a4b8ad0873f131035d26b7
[3/4] spi: cadence-quadspi: setup ADDR Bits in cmd reads
      commit: a8674ae02db232927385c2d0a063e10c0118f5ca
[4/4] spi: cadence-quadspi: use STIG mode for small reads
      commit: d403fb6e76bf854ef0f7d84e797e51b9494788e0

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

