Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF973AEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFWCud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjFWCu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A52110
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AEA461956
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C623C433CC;
        Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687488626;
        bh=ko3k7IlM110GNzMw7xNvyXOMwO9tnROCH67Bg+x6p2c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mXjrtKdAOLVrhijlbn3v9TmQ8VrYFqxlT38GeuRDBkBSBadiHvGK13z6JgXiKCnjl
         gGqZCynUgfbi7K8TA/FjqEfbrYwWlF+oALRwsH/6R3DtGd2ghZdR3GFBQbvoKvTV5V
         /Z5XZnGhLdNH9Feu+q+wWCyLx5nG/pMEyQntXsBdywLOhVLJtJypGF6Drmo+OfFshx
         7Yo5wxOUc2Z6gwAKHem2GvPBdtDIeTfk2HBn6pkfqFIJMWftiRoOZtGYr2hBG8G08m
         SVhOrZv1ITARpqtCG8qaIROmCBoZ7i6qEdA4BdAPdTAfuhioX+LpiWJx+CYv+oKsxc
         6go9jBpvRocQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F874C691F1;
        Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: dsa: microchip: fix writes to phy registers
 >= 0x10
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748862638.32034.4855934302738922357.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 02:50:26 +0000
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 13:38:51 +0200 you wrote:
> Patch 1 is just a simplification, technically unrelated to the other
> two patches. But it would be a bit inconsistent to have the new
> ksz_prmw32() introduced in patch 2 use ksz_rmw32() while leaving
> ksz_prmw8() as-is.
> 
> The actual fix is of course patch 3. I can definitely see some weird
> behaviour on our ksz9567 when writing to phy registers 0x1e and 0x1f
> (with phytool from userspace), though it does not seem that the effect
> is always to write zeroes to the buddy register as the errata sheet
> says would be the case. In our case, the switch is connected via i2c;
> I hope somebody with other switches and/or the SPI variants can test
> this.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: dsa: microchip: simplify ksz_prmw8()
    https://git.kernel.org/netdev/net-next/c/3b42fbd59511
  - [net-next,2/3] net: dsa: microchip: add ksz_prmw32() helper
    https://git.kernel.org/netdev/net-next/c/ece28ecbec9f
  - [net-next,3/3] net: dsa: microchip: fix writes to phy registers >= 0x10
    https://git.kernel.org/netdev/net-next/c/5c844d57aa78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


