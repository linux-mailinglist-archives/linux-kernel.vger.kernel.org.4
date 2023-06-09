Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F40728EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjFIDk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjFIDk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A01185
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64336536E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52A2BC4339B;
        Fri,  9 Jun 2023 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686282024;
        bh=w11E+BzqlydikRfXTEIIQBAdVc8hakr3dPgbmMH3HgU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KW0A4Punlrc6eVPf6AUMtRz8QhFWzew4U8M+yZJSIU7p3DPmKmjm8BerQoH6viZfh
         LHHkxH/p9f1drczq5VZDpZEvMAiHfhlukr5ddpUQkbvR40V6eZjb2jADuiIovFOiif
         nYf5rhTCfIJ2jfdYMaCIIMp8Ua8r7yzdbXt2DHLMHgvbIws1OG0peuW1t/TN5lljqg
         GEKY/3mXeq91CaXpT5RloBfe3fBTcca0b0E8WkiexhUTGikvpqV77/fyTqn3nq/Scb
         cmnXbHujF7QhSftptLoWXgsvSFSEjqifS5FQxiHzuaeQV5sMEelXTJEl20OZHugqcq
         cVuYxbn+HnZXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3540CE29F37;
        Fri,  9 Jun 2023 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 00/14] splice, net: Rewrite splice-to-socket,
 fix SPLICE_F_MORE and handle MSG_SPLICE_PAGES in AF_TLS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168628202421.7487.4215663670045533118.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 03:40:24 +0000
References: <20230607181920.2294972-1-dhowells@redhat.com>
In-Reply-To: <20230607181920.2294972-1-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, torvalds@linux-foundation.org,
        chuck.lever@oracle.com, borisp@nvidia.com,
        john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        willy@infradead.org, axboe@kernel.dk, linux-mm@kvack.org,
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jun 2023 19:19:06 +0100 you wrote:
> Here are patches to do the following:
> 
>  (1) Block MSG_SENDPAGE_* flags from leaking into ->sendmsg() from
>      userspace, whilst allowing splice_to_socket() to pass them in.
> 
>  (2) Allow MSG_SPLICE_PAGES to be passed into tls_*_sendmsg().  Until
>      support is added, it will be ignored and a splice-driven sendmsg()
>      will be treated like a normal sendmsg().  TCP, UDP, AF_UNIX and
>      Chelsio-TLS already handle the flag in net-next.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,01/14] net: Block MSG_SENDPAGE_* from being passed to sendmsg() by userspace
    https://git.kernel.org/netdev/net-next/c/4fe38acdac8a
  - [net-next,v6,02/14] tls: Allow MSG_SPLICE_PAGES but treat it as normal sendmsg
    https://git.kernel.org/netdev/net-next/c/81840b3b91aa
  - [net-next,v6,03/14] splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()
    https://git.kernel.org/netdev/net-next/c/2dc334f1a63a
  - [net-next,v6,04/14] splice, net: Add a splice_eof op to file-ops and socket-ops
    https://git.kernel.org/netdev/net-next/c/2bfc66850952
  - [net-next,v6,05/14] tls/sw: Use splice_eof() to flush
    https://git.kernel.org/netdev/net-next/c/df720d288dbb
  - [net-next,v6,06/14] tls/device: Use splice_eof() to flush
    https://git.kernel.org/netdev/net-next/c/d4c1e80b0d1b
  - [net-next,v6,07/14] ipv4, ipv6: Use splice_eof() to flush
    https://git.kernel.org/netdev/net-next/c/1d7e4538a546
  - [net-next,v6,08/14] chelsio/chtls: Use splice_eof() to flush
    https://git.kernel.org/netdev/net-next/c/c289a1601abd
  - [net-next,v6,09/14] kcm: Use splice_eof() to flush
    https://git.kernel.org/netdev/net-next/c/951ace995138
  - [net-next,v6,10/14] splice, net: Fix SPLICE_F_MORE signalling in splice_direct_to_actor()
    https://git.kernel.org/netdev/net-next/c/219d92056ba3
  - [net-next,v6,11/14] tls/sw: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/fe1e81d4f73b
  - [net-next,v6,12/14] tls/sw: Convert tls_sw_sendpage() to use MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/45e5be844ab6
  - [net-next,v6,13/14] tls/device: Support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/24763c9c0980
  - [net-next,v6,14/14] tls/device: Convert tls_device_sendpage() to use MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/3dc8976c7ad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


