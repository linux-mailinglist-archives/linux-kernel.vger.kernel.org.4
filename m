Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5C5749140
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGEXAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjGEXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E61992;
        Wed,  5 Jul 2023 16:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52576182C;
        Wed,  5 Jul 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2577C433CD;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688598024;
        bh=dmhwZA3FcpfgoYkFfK0f8ZtZqryqQgsRp0crWis6QbQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NqytIV+i2Y1Mb4sTJ1R7sBGsVT1PgQkczXX6gi/AYTubNeHdwSGFJ31WPHoDBw1rQ
         gnwqa07At6SoXEqar8mS4ipJRSUZgee4S53d6fPcUUpnknNxTTt/YZ6mUd7BQOaovA
         r+KJo9njiudLdukssL5l4c5HQ0mZyaxNngdu3r/xgpnbybI1L3K+hcdd2cfbtrmy9C
         m1caFfOz8kB//TjnuKireidE8dZgR8DE2AKB9VaUbD11T8GIx40boljBb/gCvdHK+2
         s9HCtZJPzKh88Y+heVvZNh0DuT7b7oBcXfbEdaiAIx+xFSzgMmWnnP9DMa89nVAtnr
         wk9PLTvsO7row==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA50AC691EF;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: coredump: fix building with coredump disabled
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168859802475.24898.14279072242552303522.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:00:24 +0000
References: <20230703113112.380663-1-arnd@kernel.org>
In-Reply-To: <20230703113112.380663-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        chris.lu@mediatek.com, sean.wang@mediatek.com,
        jing.cai@mediatek.com, abhishekpandit@chromium.org,
        mmandlik@google.com, arnd@arndb.de, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, brian.gix@intel.com, pav@iki.fi,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Jul 2023 13:30:48 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The btmtk driver uses an IS_ENABLED() check to conditionally compile
> the coredump support, but this fails to build because the hdev->dump
> member is in an #ifdef:
> 
> drivers/bluetooth/btmtk.c: In function 'btmtk_process_coredump':
> drivers/bluetooth/btmtk.c:386:30: error: 'struct hci_dev' has no member named 'dump'
>   386 |   schedule_delayed_work(&hdev->dump.dump_timeout,
>       |                              ^~
> 
> [...]

Here is the summary with links:
  - Bluetooth: coredump: fix building with coredump disabled
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ca03ff0da3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


