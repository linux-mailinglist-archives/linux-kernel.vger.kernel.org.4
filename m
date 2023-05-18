Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0870792C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEREkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEREkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6E1997
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E93F64C1F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDF34C433D2;
        Thu, 18 May 2023 04:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684384820;
        bh=zdsEqaqS3JpK9sFlyjYtWo1EbzvejYyTBP+Z2Lduh64=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VdVmIwXLCnU8X8uw1888wRvCw3xo2LFwjMXtBIMY6n+xZr9CJpqGE5P4Uyt5ceYFl
         rGnzMKfevF+Pg1NhLkAEUTC8I/qCYYBNXb3GNDxRDcjqrdbfv6oWLOMPV6cb9l7+kl
         cPD1VqBrTEXUzlIiBRp+luS64YXFOSIzjYbFvpzgMR+myT/33nq/bVA4dXYlp3by7w
         Fx2JqWlUG7h2T17gXXA/3NCB4dP/iKomxDmRBBqmRIV1xjhALNn4J6vVyqUW1J7zL7
         dezPmdWBUeF4DPPLMJbJyOkkVLUcxqcz7/Aw/1igKPDC7mtoLBN/XSMuHvGEg7eqxS
         +7KRauf7I9WMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A22CBE54223;
        Thu, 18 May 2023 04:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] net: isa: include net/Space.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168438482065.9978.1003238399432793847.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 04:40:20 +0000
References: <20230516194625.549249-1-arnd@kernel.org>
In-Reply-To: <20230516194625.549249-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 May 2023 21:45:33 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The legacy drivers that still get called from net/Space.c have prototypes
> in net/Space, but this header is not included in most of the files that
> define those functions:
> 
> drivers/net/ethernet/cirrus/cs89x0.c:1649:28: error: no previous prototype for 'cs89x0_probe' [-Werror=missing-prototypes]
> drivers/net/ethernet/8390/ne.c:947:28: error: no previous prototype for 'ne_probe' [-Werror=missing-prototypes]
> drivers/net/ethernet/8390/smc-ultra.c:167:28: error: no previous prototype for 'ultra_probe' [-Werror=missing-prototypes]
> drivers/net/ethernet/amd/lance.c:438:28: error: no previous prototype for 'lance_probe' [-Werror=missing-prototypes]
> drivers/net/ethernet/3com/3c515.c:422:20: error: no previous prototype for 'tc515_probe' [-Werror=missing-prototypes]
> 
> [...]

Here is the summary with links:
  - [1/4] net: isa: include net/Space.h
    https://git.kernel.org/netdev/net/c/067dee65751b
  - [2/4] atm: hide unused procfs functions
    https://git.kernel.org/netdev/net/c/fb1b7be9b16c
  - [3/4] bridge: always declare tunnel functions
    https://git.kernel.org/netdev/net/c/89dcd87ce534
  - [4/4] mdio_bus: unhide mdio_bus_init prototype
    https://git.kernel.org/netdev/net/c/2e9f8ab68f42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


