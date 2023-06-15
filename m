Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D273227E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjFOWKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjFOWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8421732;
        Thu, 15 Jun 2023 15:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC12262324;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3357EC433C8;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686867021;
        bh=RZLiGCH1qdhSMndwaQxQgDZRZGsdxP72mh/YBckc+GE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qbUPrEIeR7rEjexBT3bhE+02gQShNouW6O5TIA6hL+zl2aeFYq4ejKA/eUpTsziWD
         78saCJANrcB2oMSAVF/qvScR7iIDkoZ5h305SZcEZEp81p8sCnc2GDFalPItZcyGgj
         HtIJZGAlqhmLBtQUbJ2mhBSy2gdxDG7fn1eliGOdtyPsIKb89neKaJinsiwxauaQsi
         7ezLQOOKnbkJG0rDp4qsHur4u/Jx86GFJRl2vprbOyOrYqfGEtXHEB6KDBARhQABMK
         dBlj3Xc6fyKKbDoOxFzLDWakKe1D8RhK5HXOYKdtaV91Ngik1sYbmfJ7aTkR6GIv8N
         nvTgI84VYC8Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C8B0C3274B;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] net: ethernet: stmicro: stmmac: fix possible memory
 leak in __stmmac_open
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168686702104.9701.257014821594710577.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 22:10:21 +0000
References: <20230614091714.15912-1-ansuelsmth@gmail.com>
In-Reply-To: <20230614091714.15912-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jose.Abreu@synopsys.com, stable@vger.kernel.org
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

On Wed, 14 Jun 2023 11:17:14 +0200 you wrote:
> Fix a possible memory leak in __stmmac_open when stmmac_init_phy fails.
> It's also needed to free everything allocated by stmmac_setup_dma_desc
> and not just the dma_conf struct.
> 
> Drop free_dma_desc_resources from __stmmac_open and correctly call
> free_dma_desc_resources on each user of __stmmac_open on error.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: stmicro: stmmac: fix possible memory leak in __stmmac_open
    https://git.kernel.org/netdev/net/c/30134b7c47bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


