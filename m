Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5964F70EF23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbjEXHOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbjEXHNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321EE73
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42BA8639C4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4EB8C4339B;
        Wed, 24 May 2023 07:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684912220;
        bh=5Edlffa6wzk6Sb6/TX+84tNyag5aI6qgOyHYRihIjTg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LOd3xsjDHca39yjO67fAnLUs6lBSMz3Nc/tEtRv1nNonCS5gRg+zwcnx2La/qoNHN
         xe32v+vhrbt+pCWZsfC8tl7zOfZ49zL4SuONWWzQr/b/M/OOgZKXQUlpSwJbTLCTvW
         6HZmFSpdWho40KZs99wgkyw+I8brQMprT95WFsdMF6Jpnb097EA3h0L3juwMLkkBqw
         bJWJi4mhj/enWt3qGX03yosqMNa7k/dplBdlW8aKytqySMkZEjjbmmCbVzAin5XhAQ
         fegmZLYJVvrLmhDFl7G7rHkiHm/DBeKrdblTK0tyOdsDXZbOGbUZUA3pUfpHs5yqIH
         0nARRU7qrozsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 887A2E21ECD;
        Wed, 24 May 2023 07:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix QoS on DSA MAC on non
 MTK_NETSYS_V2 SoCs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168491222055.16342.9541453168146805082.git-patchwork-notify@kernel.org>
Date:   Wed, 24 May 2023 07:10:20 +0000
References: <20230522105744.37227-1-arinc.unal@arinc9.com>
In-Reply-To: <20230522105744.37227-1-arinc.unal@arinc9.com>
To:     =?utf-8?b?QXLEsW7DpyDDnE5BTCA8YXJpbmM5LnVuYWxAZ21haWwuY29tPg==?=@ci.codeaurora.org
Cc:     nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        arinc.unal@arinc9.com, frank-w@public-files.de,
        bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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
by David S. Miller <davem@davemloft.net>:

On Mon, 22 May 2023 13:57:43 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The commit c6d96df9fa2c ("net: ethernet: mtk_eth_soc: drop generic vlan rx
> offload, only use DSA untagging") makes VLAN RX offloading to be only used
> on the SoCs without the MTK_NETSYS_V2 ability (which are not just MT7621
> and MT7622). The commit disables the proper handling of special tagged
> (DSA) frames, added with commit 87e3df4961f4 ("net-next: ethernet:
> mediatek: add CDM able to recognize the tag for DSA"), for non
> MTK_NETSYS_V2 SoCs when it finds a MAC that does not use DSA. So if the
> other MAC uses DSA, the CDMQ component transmits DSA tagged frames to the
> CPU improperly. This issue can be observed on frames with TCP, for example,
> a TCP speed test using iperf3 won't work.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: fix QoS on DSA MAC on non MTK_NETSYS_V2 SoCs
    https://git.kernel.org/netdev/net/c/04910d8cbfed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


