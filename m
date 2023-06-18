Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A3734668
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFRNk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFRNkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC341AA;
        Sun, 18 Jun 2023 06:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1103F60EB6;
        Sun, 18 Jun 2023 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C2ACC433C0;
        Sun, 18 Jun 2023 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687095620;
        bh=2hyS4/RHBEnq0Wqtzj+t+ZmWg2QArDPOi5kjDcBRwjI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PBdrQGUWCbc+i8g8r+LwJR4dHvKuWrufjdfmh9rmFqU+yoajtRWZ6SgOXFsQkDyZC
         N7zUbTcTQ1g0fv9wJPYmN7WUU5bCXk/J/eOZk0Vk0uy1cdG+mLls7Qk9gsUPeu7Sw5
         4rXH9jVmwDTzp76QSO0YvypNc1eyLHcb04B5eU2CYKEbGwzPppOQ05tGlgiipkMn3z
         ZEMItnKOmA/s6XSGTtBY3yF22OSDYfoxKEyaJgAKSiFpYRWYj8GBA09HwZF/6XTyVY
         kxnfkA6AT8OmIWXJYFORmqPA1YVXI6P3FpQa7dqj3ZbaeSY6x3pXzZJKPaAjN/Hi8h
         45me6EH2lYBgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4487EC395C7;
        Sun, 18 Jun 2023 13:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] crypto: Fix af_alg_sendmsg(MSG_SPLICE_PAGES) sglist
 limit
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168709562027.22941.17137534932175260669.git-patchwork-notify@kernel.org>
Date:   Sun, 18 Jun 2023 13:40:20 +0000
References: <322883.1686863334@warthog.procyon.org.uk>
In-Reply-To: <322883.1686863334@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        axboe@kernel.dk, willy@infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Jun 2023 22:08:54 +0100 you wrote:
> When af_alg_sendmsg() calls extract_iter_to_sg(), it passes MAX_SGL_ENTS as
> the maximum number of elements that may be written to, but some of the
> elements may already have been used (as recorded in sgl->cur), so
> extract_iter_to_sg() may end up overrunning the scatterlist.
> 
> Fix this to limit the number of elements to "MAX_SGL_ENTS - sgl->cur".
> 
> [...]

Here is the summary with links:
  - [net-next] crypto: Fix af_alg_sendmsg(MSG_SPLICE_PAGES) sglist limit
    https://git.kernel.org/netdev/net-next/c/4380499218c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


