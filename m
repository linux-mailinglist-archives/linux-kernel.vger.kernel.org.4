Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821F70DDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbjEWNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjEWNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A349FD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41516328A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A3D8C4339B;
        Tue, 23 May 2023 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684849219;
        bh=Xpwc0uMMenl8jokEfehO6+CpiK4LHBWvEX6sJPnK5Sg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fHYmi3pptGp50C+8SY1IhpS6+eRQX13Qo/OGsePO+e9cTbYVCkI7eOc/Cw4T5wJjs
         l5AvrLIO1keKNzxRBYh9WbAnVqRRbKeyCD+OA9iAI7UNgGJR2NI2pUDClyCq8xA2Gj
         +TF4qEEGZIYvixHDTgcDz6RBxVBb7YYfVkgdYKTE3JTBYdgZjj2yEFWAdWUmXYS8Cb
         dKbbrx53wgGr3zNd6VNo3NkJCZ3eZ/3nDYLZPMVhPcpqfojYUy1fyA2R1BbQ9SRj8j
         epoW0uDos0vaNARE1wC4YUidrC6sYzlpXvETQCy1j6JTImGeu7crYT8Shq9NuOvwKU
         En9/gKmMv6bMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F0E4C04E32;
        Tue, 23 May 2023 13:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] lan966x: Fix unloading/loading of the driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168484921912.23799.4816780617642499694.git-patchwork-notify@kernel.org>
Date:   Tue, 23 May 2023 13:40:19 +0000
References: <20230522120038.3749026-1-horatiu.vultur@microchip.com>
In-Reply-To: <20230522120038.3749026-1-horatiu.vultur@microchip.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, UNGLinuxDriver@microchip.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 May 2023 14:00:38 +0200 you wrote:
> It was noticing that after a while when unloading/loading the driver and
> sending traffic through the switch, it would stop working. It would stop
> forwarding any traffic and the only way to get out of this was to do a
> power cycle of the board. The root cause seems to be that the switch
> core is initialized twice. Apparently initializing twice the switch core
> disturbs the pointers in the queue systems in the HW, so after a while
> it would stop sending the traffic.
> Unfortunetly, it is not possible to use a reset of the switch here,
> because the reset line is connected to multiple devices like MDIO,
> SGPIO, FAN, etc. So then all the devices will get reseted when the
> network driver will be loaded.
> So the fix is to check if the core is initialized already and if that is
> the case don't initialize it again.
> 
> [...]

Here is the summary with links:
  - [net] lan966x: Fix unloading/loading of the driver
    https://git.kernel.org/netdev/net/c/600761245952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


