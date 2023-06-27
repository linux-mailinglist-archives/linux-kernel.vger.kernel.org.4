Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5337740181
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjF0Qkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjF0QkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6292FF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E97D611E6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA253C43397;
        Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687884023;
        bh=PbkyuIVD6RQEoyWEDMK/0ZpQxw2fsmAvvIUXJqLTZqk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ViPPo0tTQrVz4P89e+OmJgob9ZBpLV1PbqrIBi8q2NVcfmjW7E/sFz7jMOsk+qa+d
         wdQDWJlIwczFWeGR4aKFbPlpC6tU8opKTVFvBXI0INiRr++oZZQdraVe1UYCD4M9YX
         nn+8Qt3FxE5jGtZ030cHXQQOaQwg2tgDlpa50FIRLDxcm9fK9M1BDGptfeTZn5qsyN
         1PEgia3bxASUwDHFaCxt9pNIu6W40OVttwlDb42n2E1xjL8pyss/ZwUcVN95ATTWu1
         WJ0JW7nQ52UtUarSFN63F8PqTD23gMLUGgg7X7T6fCsaUGGLsQtGCjg/O+UpC2Xeir
         XhrCSc/DknjYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97363C6445B;
        Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: mscc: fix packet loss due to RGMII
 delays
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168788402361.21860.15787851338716786080.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 16:40:23 +0000
References: <20230627134235.3453358-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230627134235.3453358-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        harini.katakam@amd.com
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 16:42:35 +0300 you wrote:
> Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
> if phy-mode = "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-ps"
> override exists. The negative error code from phy_get_internal_delay()
> does not get overridden with the delay deduced from the phy-mode, and
> later gets committed to hardware. Also, the rx_delay gets overridden by
> what should have been the tx_delay.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: mscc: fix packet loss due to RGMII delays
    https://git.kernel.org/netdev/net-next/c/528a08bcd820

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


