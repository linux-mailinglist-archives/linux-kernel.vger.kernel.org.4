Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1573CD4E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 00:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjFXWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFXWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 18:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438C1706
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 15:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53C8F60A70
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 22:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9878AC433C9;
        Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687646424;
        bh=wFuYPKBZDVE/KNCfDf5udJ5FGoqcIIHcICXY9FCaBa0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GQnPbwWsakuOPo9NzsCGnu7VNIBsah5Ar0vvOSOu4YvOtGm9lpi/EL4HqoankMgSk
         u53Ss4+2kPxA2IeJYK5BqFk3RcrMSdSEErTSz7iC3XPxgs6D9wzBy0ciln9FfI0Ex7
         UjsjzMayscYiFKLujaUqU00GpN/41SCRrZVqm4Vvwv8DMe78lgJPO3upHOIschQx3t
         qJTdVgj2u5Evpw/u0rwZUNwhUn+fXGdRIE0xLreoBqUbCu1BaMjNdY3Ws2i9L2TR7z
         89+Ho/l2s3/nanrku3QTTn/WZlQamw1sY2v//Cku+fxVTKTjds6CDQzl2EEeTzPk72
         mjmW5S/7uKrNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C429C395C7;
        Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: introduce devres helpers for
 stmmac platform drivers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168764642450.414.12816371572473277561.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jun 2023 22:40:24 +0000
References: <20230623100417.93592-1-brgl@bgdev.pl>
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        junxiao.chang@intel.com, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bartosz.golaszewski@linaro.org
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

On Fri, 23 Jun 2023 12:04:06 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The goal of this series is two-fold: to make the API for stmmac platforms more
> logically correct (by providing functions that acquire resources with release
> counterparts that undo only their actions and nothing more) and to provide
> devres variants of commonly use registration functions that allows to
> significantly simplify the platform drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: stmmac: platform: provide stmmac_pltfr_init()
    https://git.kernel.org/netdev/net-next/c/97117eb51ec8
  - [net-next,v2,02/11] net: stmmac: dwmac-generic: use stmmac_pltfr_init()
    https://git.kernel.org/netdev/net-next/c/4450e7d4231a
  - [net-next,v2,03/11] net: stmmac: platform: provide stmmac_pltfr_exit()
    https://git.kernel.org/netdev/net-next/c/5b0acf8dd2c1
  - [net-next,v2,04/11] net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
    https://git.kernel.org/netdev/net-next/c/40db9f1ddfcc
  - [net-next,v2,05/11] net: stmmac: platform: provide stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/3d5bf75d76ea
  - [net-next,v2,06/11] net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/0a68a59493e0
  - [net-next,v2,07/11] net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
    https://git.kernel.org/netdev/net-next/c/1be0c9d65e17
  - [net-next,v2,08/11] net: stmmac: platform: provide devm_stmmac_probe_config_dt()
    https://git.kernel.org/netdev/net-next/c/d74065427374
  - [net-next,v2,09/11] net: stmmac: dwmac-qco-ethqos: use devm_stmmac_probe_config_dt()
    https://git.kernel.org/netdev/net-next/c/061425d933ef
  - [net-next,v2,10/11] net: stmmac: platform: provide devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/fc9ee2ac4f9c
  - [net-next,v2,11/11] net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/4194f32a4b2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


