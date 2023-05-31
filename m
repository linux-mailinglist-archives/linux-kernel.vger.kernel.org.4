Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B747189B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEaTA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEaTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B1D10F;
        Wed, 31 May 2023 12:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C560636D3;
        Wed, 31 May 2023 19:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55AFCC433EF;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685559621;
        bh=7tIpZFIQl95R1cp6v/3cSGVf+Xav4tAXip6VYqUqPH4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aBVzyo/wPSGhUN+f1BCkHEjYR4gSvrHHxpwyzFsRP50wJ/CnF0mwYsz7/PFk5bHWk
         Z4dvIb63WA4bhpMiu+v5Wxh3AcBYjLmSIiYhO592qoSShMSAwF2NiLB8NSePZzVmqC
         5a684OZc4hrv0ki91+w5DOrq3tPRsqjF6eGmEwUYpUBK0sSSpIgr2aJ8V2TUzx4cu+
         ma7HATDPt13J567RdVLtKWfIxGYEqqyAbKiSRRnX0zWxyYEcOBv/E5fmZuZMRc0b3h
         cULEzlfUby1SuREn2JY1fWuS7zBYDHQHwIzQSfympPMP1f02PxIAHOe5c3z5kHErov
         h0Jqxk8U0oiaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3629FE52C03;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_ready_cb
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168555962120.19706.18323323574942852959.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 19:00:21 +0000
References: <20230531053955.2467043-1-iam@sung-woo.kim>
In-Reply-To: <20230531053955.2467043-1-iam@sung-woo.kim>
To:     Sungwoo Kim <iam@sung-woo.kim>
Cc:     wuruoyu@me.com, benquike@gmail.com, daveti@purdue.edu,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 31 May 2023 01:39:56 -0400 you wrote:
> l2cap_sock_release(sk) frees sk. However, sk's children are still alive
> and point to the already free'd sk's address.
> To fix this, l2cap_sock_release(sk) also cleans sk's children.
> 
> ==================================================================
> BUG: KASAN: use-after-free in l2cap_sock_ready_cb+0xb7/0x100 net/bluetooth/l2cap_sock.c:1650
> Read of size 8 at addr ffff888104617aa8 by task kworker/u3:0/276
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f514cf70050

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


