Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C43717C32
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjEaJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjEaJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692C191
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3A6638DC
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1541C4339B;
        Wed, 31 May 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685526020;
        bh=vzvd6yc3uH+kPoLgYGUShqKeP2ccEjuSqbdKW85AxJ4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WwaeNRFm5kfOSFhWjpAQK9fUkpP/0mQ4JKHpBOjV28xn0OlkfXl859Rd+PA6VRwHN
         j+x1BQdxSIqZz+BvWAQJn51dmoc6gR6FkO0L7ZQ6/uoeA0emR7iOVFHs4WGysereF9
         IhXhupu3IXgmKuaLDLVWjwAcIX7V38+geWvIzcsnm8Zg6yl5mjgWI+SZWMwwh0i//W
         ZkkWiRsUKrTIxtfuTCeH86n+4davNfPmfZvS9MVM8lXa4syXEWiKNTUzdfw3RhWryA
         5VfH8k7BGRStvbAtfqWOHmGagHGUFnzN7ROnM3pchhcgMkmqp2+OCOR7hHlldMAKZ7
         eeNyWZcOYA52A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2EE3E52C03;
        Wed, 31 May 2023 09:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] udp6: Fix race condition in udp6_sendmsg & connect
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168552602072.29725.226588999597106916.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 09:40:20 +0000
References: <20230530113941.1674072-1-VEfanov@ispras.ru>
In-Reply-To: <20230530113941.1674072-1-VEfanov@ispras.ru>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 30 May 2023 14:39:41 +0300 you wrote:
> Syzkaller got the following report:
> BUG: KASAN: use-after-free in sk_setup_caps+0x621/0x690 net/core/sock.c:2018
> Read of size 8 at addr ffff888027f82780 by task syz-executor276/3255
> 
> The function sk_setup_caps (called by ip6_sk_dst_store_flow->
> ip6_dst_store) referenced already freed memory as this memory was
> freed by parallel task in udpv6_sendmsg->ip6_sk_dst_lookup_flow->
> sk_dst_check.
> 
> [...]

Here is the summary with links:
  - [v2] udp6: Fix race condition in udp6_sendmsg & connect
    https://git.kernel.org/netdev/net/c/448a5ce1120c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


