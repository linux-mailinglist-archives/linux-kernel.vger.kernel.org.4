Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C5719272
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFAFms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjFAFmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9571BB
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E73666411F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FB22C4339C;
        Thu,  1 Jun 2023 05:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685598021;
        bh=9VRWBEJhrWb/3G3bXkrO2WxkPaRrh2Yu36UNolKKbL0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jeD//TAH1mFDt57ZEQr0QyetZEtXKOWAzBU6vDEgcNVL9fOZxR4OPkMS4D2TwQEH5
         kkAdzhLkYYJWmwTzo3dDoJ8CoGRUcI+peq3giKQ3jO5xmvCw8RcH/twwa+bI9p6nMX
         +/0eURJYF+jIKnkqdj99ESzvtfeAkiNC3cGtBDjggiZaAHKn+rN1rfoEH+9LusgxH9
         P+dTnTtXCJGe2YNMx82hhnU1cUu+ldMvEgpDSdT9u8Lg35QzhLTLGMfTbwviyybftV
         3dRwbkNNamEjbvIs/OtPhz0I29RcGY4Pxx+Y34SYtE6yjsaGDjSmkJmtnM5s6gERjR
         JVPv8O0xrTllA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20F85C395E5;
        Thu,  1 Jun 2023 05:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] Add support for VSC85xx DT RGMII delays
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168559802112.10778.15941032546106214780.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Jun 2023 05:40:21 +0000
References: <20230529122017.10620-1-harini.katakam@amd.com>
In-Reply-To: <20230529122017.10620-1-harini.katakam@amd.com>
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, vladimir.oltean@nxp.com,
        wsa+renesas@sang-engineering.com, simon.horman@corigine.com,
        david.epping@missinglinkelectronics.com, mk+kernel@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Mon, 29 May 2023 17:50:15 +0530 you wrote:
> Provide an option to change RGMII delay value via devicetree.
> 
> v5:
> - Rebase after VSC8501 series is merged, to avoid conflicts
> - Rename _internal_delay to use vsc86xx, move declaration and
> simplify format of pointer to above
> - Acquire DT delay values in vsc85xx_update_rgmii_cntl instead of
> vsc85xx_config_init to accommodate all VSC phy versions
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] phy: mscc: Use PHY_ID_MATCH_VENDOR to minimize PHY ID table
    https://git.kernel.org/netdev/net-next/c/31605c01fb24
  - [net-next,v5,2/2] phy: mscc: Add support for RGMII delay configuration
    https://git.kernel.org/netdev/net-next/c/dbb050d2bfc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


