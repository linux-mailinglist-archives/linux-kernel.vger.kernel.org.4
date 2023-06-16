Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155D37338AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFPTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345612AbjFPTA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702543AA5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 075CF625A9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 562B2C433C8;
        Fri, 16 Jun 2023 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686942020;
        bh=teSmhnbNd2Y9ynIPY9m7ASM6Pzg+6PiTm476HdBc/ew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QUTV15MwnSbaI8/Ep78V2gld/Jg4fT+7pwWtLWQgjPXLU4/Vatv/6fgWGqq//bTYB
         IQUKf1bO5FWTjCoL4Hbf4UIc3hCSDD4h1Q8rHmjrVGNmQWnYr+bV09HrLfwW4ZtRwA
         i2oOABSvmS44htOFSY/tU2QlVQyL56YcZUHC6HXgQoaeeleGN1mw/8wM13uRVvLFyv
         3LQeTxGGARC5o1hPL8AHu4vdzv7OovVV9pP1kNRjItTyJXUmgsB29HIrRE40t/mTm4
         TnnsNvPN2fANQ6IgKRFU5RIYI4GLsBLDvS5DiEFcOkAyB9Ltc7pTpqsmpPxQjWWJPL
         yvASbxJkJZ+AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33376E21EEA;
        Fri, 16 Jun 2023 19:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip, ip6: Fix splice to raw and ping sockets
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168694202020.4240.5219219028692952674.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Jun 2023 19:00:20 +0000
References: <1410156.1686729856@warthog.procyon.org.uk>
In-Reply-To: <1410156.1686729856@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, willy@infradead.org,
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jun 2023 09:04:16 +0100 you wrote:
> Splicing to SOCK_RAW sockets may set MSG_SPLICE_PAGES, but in such a case,
> __ip_append_data() will call skb_splice_from_iter() to access the 'from'
> data, assuming it to point to a msghdr struct with an iter, instead of
> using the provided getfrag function to access it.
> 
> In the case of raw_sendmsg(), however, this is not the case and 'from' will
> point to a raw_frag_vec struct and raw_getfrag() will be the frag-getting
> function.  A similar issue may occur with rawv6_sendmsg().
> 
> [...]

Here is the summary with links:
  - [net-next] ip, ip6: Fix splice to raw and ping sockets
    https://git.kernel.org/netdev/net-next/c/5a6f6873606e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


