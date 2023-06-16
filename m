Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC47326D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjFPFu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjFPFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493C2702;
        Thu, 15 Jun 2023 22:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73BFE61138;
        Fri, 16 Jun 2023 05:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD033C433CA;
        Fri, 16 Jun 2023 05:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686894620;
        bh=vPvaMx7LQ5tK+7m2aafkX3FWMbfT4memLCs/OWWMj0k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ahUumr4ZTjdJ071pWpWg5d1VWOaJ0UgaciMrjALOcbNDyhYyiy5D3OsnX/ATgrXVa
         NwJTe0h8oRww2xnzzmCeOTgkccjC8z7FOiyGaMHgqPEdWp66OawQZBbVT1V0NlN7Xx
         icok10Am3xK+8B/0tmY8aejTzrI+WWkvFcjZ62Yg2XOhIfCSRAA8UaUiPfex+Ilovl
         7Y8rmzVzdZ4AD0KGCVsH2NR24G8O5UVBzb1T2xzii7aIi+O9ZoNAqoHkgY/2BAAxOU
         OBRrNZrGf1zP9D2BrV1ICFLUItKZ9A07gdi45B7kQCe9b7LF67ifvI0Pkc2euNZIDr
         kRmgGPqTlECeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E718E49BBF;
        Fri, 16 Jun 2023 05:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: linux-next: build failure after merge of the net-next tree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168689462057.26047.14551601662113522861.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Jun 2023 05:50:20 +0000
References: <20230613164639.164b2991@canb.auug.org.au>
In-Reply-To: <20230613164639.164b2991@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jun 2023 16:46:39 +1000 you wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (sparc64
> defconfig) failed like this:
> 
> drivers/net/ethernet/sun/sunvnet_common.c: In function 'vnet_handle_offloads':
> drivers/net/ethernet/sun/sunvnet_common.c:1277:16: error: implicit declaration of function 'skb_gso_segment'; did you mean 'skb_gso_reset'? [-Werror=implicit-function-declaration]
>  1277 |         segs = skb_gso_segment(skb, dev->features & ~NETIF_F_TSO);
>       |                ^~~~~~~~~~~~~~~
>       |                skb_gso_reset
> drivers/net/ethernet/sun/sunvnet_common.c:1277:14: warning: assignment to 'struct sk_buff *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>  1277 |         segs = skb_gso_segment(skb, dev->features & ~NETIF_F_TSO);
>       |              ^
> 
> [...]

Here is the summary with links:
  - linux-next: build failure after merge of the net-next tree
    https://git.kernel.org/netdev/net-next/c/d9ffa069e006

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


