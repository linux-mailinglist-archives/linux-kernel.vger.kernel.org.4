Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F873AEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFWCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjFWCuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944AA210E;
        Thu, 22 Jun 2023 19:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BBDE61947;
        Fri, 23 Jun 2023 02:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50123C433C9;
        Fri, 23 Jun 2023 02:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687488620;
        bh=nil53usVHzZEl98eGBgwg8grEDlY3XKRAjW/MwQOux0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VX+fA4ahPQV2gOe12mGyaYILTu/CEGUPSFwCfnX072+QSJ44QLrmbFR9b5/oTWB61
         oSX/Fo4LVWAtW6k8zC3aXWHy5+aABHTMZx9ovjmu/oGwqaOAk1IbmfC4RSHSSQtO2N
         80o6sJ8FWX0KQiF4WYUo91YoegYRAg2IvO3jnofWgIah8auvX9djj7+bYRFrWlivdJ
         P9UTU0BZVGqRuzPYD16b3H2qUIVJS2X3nN++Pfj3MWOgt7Bu9mUYCtsIlHuqAQcKhd
         Xfnuqtyd5/XiFMmtu35lSNhB3mtpYOF3YVwFS4IsSXNN5676CwJ0vfoNYELrVO94UQ
         4WLEkI5F8z6Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C76DC395F1;
        Fri, 23 Jun 2023 02:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net: phy: dp83td510: fix kernel stall during netboot
 in DP83TD510E PHY driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748862017.32034.11932493767244915559.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 02:50:20 +0000
References: <20230621043848.3806124-1-o.rempel@pengutronix.de>
In-Reply-To: <20230621043848.3806124-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        stable@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 06:38:48 +0200 you wrote:
> Fix an issue where the kernel would stall during netboot, showing the
> "sched: RT throttling activated" message. This stall was triggered by
> the behavior of the mii_interrupt bit (Bit 7 - DP83TD510E_STS_MII_INT)
> in the DP83TD510E's PHY_STS Register (Address = 0x10). The DP83TD510E
> datasheet (2020) states that the bit clears on write, however, in
> practice, the bit clears on read.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver
    https://git.kernel.org/netdev/net/c/fc0649395dca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


