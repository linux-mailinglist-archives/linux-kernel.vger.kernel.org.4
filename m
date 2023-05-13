Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0347701823
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEMQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6471BFB
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 09:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53A6560AF0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 16:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BDACC4339B;
        Sat, 13 May 2023 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683994219;
        bh=sx+B0qUutwEArzZfFFqKmWL/adJRiJ4tbQH6/9N34h8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f6gUkRlzlM/quDX4c8tmF3xNm4LkBm51DSUuYusd2unuH+5/LJNXmYqo3Su+IQ1ZM
         4Uw+LoXis5iNwVOeOoOWPoLUYpr1Q4MkiN2SwCACvjxnm/MpgkBUC/0qtielhMMV8j
         egR1mcCbqMTIrz8x23y4tBOCsbd89ZDs6yx2WNkM6gIdzEu3pSUBXgcI6VLX/XHtkO
         RA0ZEgCXaHNA8ujnleKHpwJNcqaOUzPtfxqrFo3Hq7kFykN+mHoodnNDUcn/KIqZAx
         6qVfAGCRaCI/sNy3A2xgwxKyszhDFtGpy9av4GjMZ3m3tdxc+y8Q5A31nV7si7D/6N
         LvEtJ2zDxkdMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 812EAE49F61;
        Sat, 13 May 2023 16:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] Support for Wake-on-LAN for Broadcom PHYs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168399421952.32415.2895956813317833456.git-patchwork-notify@kernel.org>
Date:   Sat, 13 May 2023 16:10:19 +0000
References: <20230511172110.2243275-1-f.fainelli@gmail.com>
In-Reply-To: <20230511172110.2243275-1-f.fainelli@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, opendmb@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        kabel@kernel.org, pgwipeout@gmail.com, Frank.Sae@motor-comm.com,
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 May 2023 10:21:07 -0700 you wrote:
> This patch series adds support for Wake-on-LAN to the Broadcom PHY
> driver. Specifically the BCM54210E/B50212E are capable of supporting
> Wake-on-LAN using an external pin typically wired up to a system's GPIO.
> 
> These PHY operate a programmable Ethernet MAC destination address
> comparator which will fire up an interrupt whenever a match is received.
> Because of that, it was necessary to introduce patch #1 which allows the
> PHY driver's ->suspend() routine to be called unconditionally. This is
> necessary in our case because we need a hook point into the device
> suspend/resume flow to enable the wake-up interrupt as late as possible.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: phy: Allow drivers to always call into ->suspend()
    https://git.kernel.org/netdev/net-next/c/a7e3448086d5
  - [net-next,v3,2/3] net: phy: broadcom: Add support for Wake-on-LAN
    https://git.kernel.org/netdev/net-next/c/8baddaa9d4ba
  - [net-next,v3,3/3] net: bcmgenet: Add support for PHY-based Wake-on-LAN
    https://git.kernel.org/netdev/net-next/c/7e400ff35cbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


