Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB06E7B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjDSNwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjDSNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF073118DB;
        Wed, 19 Apr 2023 06:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5565D636A6;
        Wed, 19 Apr 2023 13:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC255C433D2;
        Wed, 19 Apr 2023 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681912317;
        bh=5i4cIzN8TwYjPI9xJWVhpK6iSjWWktcyEBZa+5fNb2o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f66H0mMCEZm3K1hXHhntDw/hEpd/tqVMpCwZJvjftc2HXPDDQQ4BXX2U7eNmHGulo
         pVJNyGUlY+p1vsxqDu/b00dv74xXwgPPotbBRLLcTuR/zD/5ZixRU5kfhP8W7JZDqR
         1D9VqgJ14pk13gS1JX3LIj7aWXb/j9Eg3NOAlJCzoQuEBS320TdBGk67z3Z9tfAHhS
         zV5QCZOP4FIie4s54vpoU8L12qNsKu2q+GbdoHnFAz8u+u5FleuuSO2ipNrGAhiBCp
         Iigfo4FnuCLEJi27U38Sc7cGgak189oTUfykH8D88ftNdXE6bl/WahPWF84hm5Izf+
         oBdZH8X8XGQuw==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jon Lin <jon.lin@rock-chips.com>,
        Li Lanzhe <u202212060@hust.edu.cn>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230419115030.6029-1-u202212060@hust.edu.cn>
References: <20230419115030.6029-1-u202212060@hust.edu.cn>
Subject: Re: [PATCH] spi: spi-rockchip: Fix missing unwind goto in
 rockchip_sfc_probe()
Message-Id: <168191231525.73880.1269643228977123432.b4-ty@kernel.org>
Date:   Wed, 19 Apr 2023 14:51:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 07:50:29 -0400, Li Lanzhe wrote:
> If devm_request_irq() fails, then we are directly return 'ret' without
> clk_disable_unprepare(sfc->clk) and clk_disable_unprepare(sfc->hclk).
> 
> Fix this by changing direct return to a goto 'err_irq'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-rockchip: Fix missing unwind goto in rockchip_sfc_probe()
      commit: 359f5b0d4e26b7a7bcc574d6148b31a17cefe47d

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

