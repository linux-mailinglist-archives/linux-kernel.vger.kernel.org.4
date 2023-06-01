Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B08719E60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjFANkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjFANkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4D8107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAA666450C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A23C433D2;
        Thu,  1 Jun 2023 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685626847;
        bh=ls6nnKdbCQm2SfOzX63qsOieNFEUI12bwZv2GnDTIKQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Oa6MdHvKvSMveq9vB6osp8Wwlrpg3dUhsDmimR+XPDoGXUwA7A/gEvYz2D2X4Q/1Y
         yFXbJi9xbpfsnNKgVhomFSxyowyadbBDGLJRxFYe4W5wE43gqFq69w92MtBsjaaJCU
         e8wBRgAWvruD6n3VNaRpTXSmVEJ/Wt6pteCzMnTqPAm3liHSRn0oPovxdLQzk715TG
         lSw2q7XMhMVi6nFdYjeSpj+ZgkXza412gjGprcfMG+i5eXK80eJZ9jDx+2nXeq+UMv
         PiCSkbnzwcnt+rVNCTp7Bdt+WWWNw1LO3se+awiOrx4wB0+VRQM/Vy9DsJ17A/QY7o
         1PA1eO6IGQVWw==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20230601101036.1499612-1-ckeepax@opensource.cirrus.com>
References: <20230601101036.1499612-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] regmap: regmap-irq: Move handle_post_irq to before
 pm_runtime_put
Message-Id: <168562684586.62862.2063265056919048748.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 14:40:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 11:10:35 +0100, Charles Keepax wrote:
> Typically handle_post_irq is going to be used to manage some
> additional chip specific hardware operations required on each IRQ,
> these are very likely to want the chip to be resumed. For example the
> current in tree user max77620 uses this to toggle a global mask bit,
> which would obviously want the device resumed. It is worth noting this
> device does not specify the runtime_pm flag in regmap_irq_chip, so
> there is no actual issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: regmap-irq: Move handle_post_irq to before pm_runtime_put
      commit: 02534c8e967b51940ae7c0cd99befe216f1c2c8d
[2/2] regmap: Add missing cache_only checks
      commit: 99e8dd39f34333d745e6c220be5d166e85214e6c

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

