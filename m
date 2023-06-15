Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB579730F18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbjFOGK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFOGKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5233A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63010629BB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B86C3C433CB;
        Thu, 15 Jun 2023 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686809420;
        bh=yBsF2yGxy6+m0GRyOTF57Yhzmj3bXyoRjSsZnLT9nDU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rX946Bf04W9+IZQq6hSADW0tllmhWn0eC3T9uP9K+9sGab6av7979hKhZC6OY3pGK
         BYsU2Qj3rxEY4Dqj6pbaofS/icFRxC+sYLtO/QpVjFNnyoN/v43QNM3L5ds5mlvJyY
         iSq2/tOe6xKgn5MNaR7m7P+KCFHAhi0S7mJVDlLQ5s4OdftjE9/lqvvkPHQeGYa7Vk
         R5JumZm3idS/YkA793guJ3zMS3+FmfBZ48qpAsxBT4nUlMSb5z0OhKGeLMCv5mNpH+
         m8RIT9yZSs5SVyXQi9WewICfYw/HTOij7Lv+tYeveomqNHnkdEaJ9Np7OWiNCZXZj6
         N7a7wTjYD009w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F21BE21EEA;
        Thu, 15 Jun 2023 06:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: felix: fix taprio guard band overflow at 10Mbps
 with jumbo frames
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168680942064.31160.5418454678967580591.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 06:10:20 +0000
References: <20230613170907.2413559-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230613170907.2413559-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        xiaoliang.yang_1@nxp.com, linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jun 2023 20:09:07 +0300 you wrote:
> The DEV_MAC_MAXLEN_CFG register contains a 16-bit value - up to 65535.
> Plus 2 * VLAN_HLEN (4), that is up to 65543.
> 
> The picos_per_byte variable is the largest when "speed" is lowest -
> SPEED_10 = 10. In that case it is (1000000L * 8) / 10 = 800000.
> 
> Their product - 52434400000 - exceeds 32 bits, which is a problem,
> because apparently, a multiplication between two 32-bit factors is
> evaluated as 32-bit before being assigned to a 64-bit variable.
> In fact it's a problem for any MTU value larger than 5368.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: felix: fix taprio guard band overflow at 10Mbps with jumbo frames
    https://git.kernel.org/netdev/net/c/6ac7a27a8b07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


