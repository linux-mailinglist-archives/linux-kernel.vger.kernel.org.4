Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4573AEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjFWCkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFWCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9801FD2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52F96194E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCB4C433CB;
        Fri, 23 Jun 2023 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687488021;
        bh=4hiiv6LScRba5gRm6+zidOGp6fL3y8sB78Jonq7Yi5o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fx6mJKzWzurGakGjbLbiZNJRv8ANfgoWDY1jbcuzIFoyq9xPlZwGpF099Bu0ycueW
         rRBkXpQ8LrNUO6zLMsswwxoCAoqxIn4dxPDQQekEun9+ObmSAMdOI0x+5mTNlEzidG
         VpfsuoAs2/H5hF+mDOiJzWAynk4Kn5GpNFCLxqrVoW2KIWrFiGjXDhXMl8S/SjH1R4
         z4lIKs4FJqTdh1gPvATsRHfJpz6gGYyIr9UvmwgnYe/v99dMgY3MvzALCOSU47CHVI
         6UuPqak4OYTYx68mpIxMfwsc3rSj5xsjIa8i8wz1XUg7Nf9ao6WhsJ/kbtiNFnYLUj
         vYvM8wMA7BdlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7DEAC691EE;
        Fri, 23 Jun 2023 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix double serdes powerdown
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748802087.26940.10386965323581685154.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 02:40:20 +0000
References: <20230621135537.376649-1-brgl@bgdev.pl>
In-Reply-To: <20230621135537.376649-1-brgl@bgdev.pl>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        junxiao.chang@intel.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bartosz.golaszewski@linaro.org
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

On Wed, 21 Jun 2023 15:55:37 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
> stmmac_open/release") correctly added a call to the serdes_powerdown()
> callback to stmmac_release() but did not remove the one from
> stmmac_remove() which leads to a doubled call to serdes_powerdown().
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix double serdes powerdown
    https://git.kernel.org/netdev/net/c/c4fc88ad2a76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


