Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1233C70182F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjEMQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEMQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B62689;
        Sat, 13 May 2023 09:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42EDA60F79;
        Sat, 13 May 2023 16:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B5DDC4339C;
        Sat, 13 May 2023 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683995421;
        bh=Rm1B/Tz+qEEuzzgM/Dcy1wNsz3PFzjdL0rMTDxR3Y/o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XG09ILYUmOfqlLRnYrSBcPvN6b1ak51XidSLs05b4AuoOuq+vS8wv/McSW5muA75X
         lvs5IPm4e7whMu3ecGTmJfJXF9wqRnJ5TFpaS7hwsav0x/j2tABSGHmZoEWpcOmJCi
         UOH/WPE/1YsbeXYc4nWnzPN8po7ivjhhV2FbNkl7jRIb4tz48Z3YjMnQJnXUfwrvsM
         v7n+wlW3rf/7MrdRc6wrsNIwR5femu2uI63X2jrTRVrXu5AfgTqM/jkp1x+MAasrOg
         pAnFJTaZC6JDNK1IEWlhz/qqDplobwqMzZVxKz3zn1F6OShdK5rH9k8geQd7McV27p
         tGxO21HbBqqlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64A5BE4D011;
        Sat, 13 May 2023 16:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: dsa: rzn1-a5psw: fix STP states handling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168399542140.7347.2797429777879901839.git-patchwork-notify@kernel.org>
Date:   Sat, 13 May 2023 16:30:21 +0000
References: <20230512072712.82694-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230512072712.82694-1-alexis.lothore@bootlin.com>
To:     =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@ci.codeaurora.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, herve.codina@bootlin.com,
        miquel.raynal@bootlin.com, milan.stevanovic@se.com,
        jimmy.lalande@se.com, pascal.eberhard@se.com
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 May 2023 09:27:09 +0200 you wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> This small series fixes STP support and while adding a new function to
> enable/disable learning, use that to disable learning on standalone ports
> at switch setup as reported by Vladimir Oltean.
> 
> This series was initially submitted on net-next by Clement Leger, but some
> career evolutions has made him hand me over those topics.
> Also, this new revision is submitted on net instead of net-next for V1
> based on Vladimir Oltean's suggestion
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: dsa: rzn1-a5psw: enable management frames for CPU port
    https://git.kernel.org/netdev/net/c/9e4b45f20c5a
  - [net,v3,2/3] net: dsa: rzn1-a5psw: fix STP states handling
    https://git.kernel.org/netdev/net/c/ebe9bc509527
  - [net,v3,3/3] net: dsa: rzn1-a5psw: disable learning for standalone ports
    https://git.kernel.org/netdev/net/c/ec52b69c046a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


