Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9396273CD5E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjFXXA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BFB1710
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 16:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 488BE60AED
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1619C433C0;
        Sat, 24 Jun 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687647624;
        bh=dQD/jtNrCKh03xlBcCxO0XWHtNNaS94uKUl2d/V7rHo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rKnfuy6lzK3STWwFO3ufs2WqQjTkxCVFiw2bfiqW7EuvO+SBbtH1WerXaeoSeVZb9
         0PfVd6B1oTlTg4M7PrAzSW/TGTdKqeOv3xvo8iVf9szUwrw3O3IAAICYL0BnlKK8/S
         M0Q7V7f1s7VSPJwmCqeQrymnZ5JsEj0JO3k26fz7/Px91vDE6vstbNi3ZsRfk9Io1a
         6k7Pc83uouWFzrn74zPAr4D5TCn01SWz0TKgrU56ZkebYVWU/eQi3tTctjIlYrLCut
         821+HY4UzDLhMSYOeGvXAQBCZBrCjBbBNyM/gSH45KL0jR4sHetCRlrojOJlS0P2Wr
         H3RzZCkDuYZTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 787B7C43157;
        Sat, 24 Jun 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/16] splice,
 net: Switch over users of sendpage() and remove it
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168764762447.8907.9031841274323827119.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jun 2023 23:00:24 +0000
References: <20230623225513.2732256-1-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, alexander.duyck@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, willy@infradead.org, axboe@kernel.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jun 2023 23:54:57 +0100 you wrote:
> Here's the final set of patches towards the removal of sendpage.  All the
> drivers that use sendpage() get switched over to using sendmsg() with
> MSG_SPLICE_PAGES.
> 
> The following changes are made:
> 
>  (1) Make the protocol drivers behave according to MSG_MORE, not
>      MSG_SENDPAGE_NOTLAST.  The latter is restricted to turning on MSG_MORE
>      in the sendpage() wrappers.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/16] tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage
    https://git.kernel.org/netdev/net-next/c/f8dd95b29d7e
  - [net-next,v5,02/16] net: Use sendmsg(MSG_SPLICE_PAGES) not sendpage in skb_send_sock()
    https://git.kernel.org/netdev/net-next/c/c729ed6f5be5
  - [net-next,v5,03/16] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
    https://git.kernel.org/netdev/net-next/c/40a8c17aa770
  - [net-next,v5,04/16] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
    https://git.kernel.org/netdev/net-next/c/fa094ccae1e7
  - [net-next,v5,05/16] rds: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
    https://git.kernel.org/netdev/net-next/c/572efade27c5
  - [net-next,v5,06/16] dlm: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
    https://git.kernel.org/netdev/net-next/c/a1a5e8752786
  - [net-next,v5,07/16] nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
    https://git.kernel.org/netdev/net-next/c/7769887817c3
  - [net-next,v5,08/16] nvmet-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
    https://git.kernel.org/netdev/net-next/c/c336a79983c7
  - [net-next,v5,09/16] smc: Drop smc_sendpage() in favour of smc_sendmsg() + MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/2f8bc2bbb0fa
  - [net-next,v5,10/16] drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
    https://git.kernel.org/netdev/net-next/c/eeac7405c735
  - [net-next,v5,11/16] scsi: iscsi_tcp: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
    https://git.kernel.org/netdev/net-next/c/fa8df3435727
  - [net-next,v5,12/16] scsi: target: iscsi: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
    https://git.kernel.org/netdev/net-next/c/d2fe21077d6d
  - [net-next,v5,13/16] ocfs2: Fix use of slab data with sendpage
    https://git.kernel.org/netdev/net-next/c/86d7bd6e66e9
  - [net-next,v5,14/16] ocfs2: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
    https://git.kernel.org/netdev/net-next/c/e52828cc0109
  - [net-next,v5,15/16] sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)
    https://git.kernel.org/netdev/net-next/c/dc97391e6610
  - [net-next,v5,16/16] net: Kill MSG_SENDPAGE_NOTLAST
    https://git.kernel.org/netdev/net-next/c/b848b26c6672

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


