Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0645737500
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjFTTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTTUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35931B6;
        Tue, 20 Jun 2023 12:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B5C60F23;
        Tue, 20 Jun 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C47F9C433C9;
        Tue, 20 Jun 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687288819;
        bh=PeHV3oGT0VbjGSMnLrUz89/gkbBxSRAPqn2lOdDUHlM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cGO05tnQitRpKUN5KECgilvaHe3rjXMd5JZ28O3A/t7meSlu82GpBRwmg8PP/7DSY
         V+uSRyI37k9enStBv/QEXOV99+ZeWYb2Kjd1fIoH6u0UmP+cmDVLdYfoxedbMIu4cD
         fbaZgJ/nP/GL5WWT/wm5QTcynAstW3WLpkk5GQ06lHbGTugQ1/W4vgOwaKj4Qg+sL2
         QP33Y00cnl7r2CvvgiVz6wH4FBQe07d36ZEIbKn8yKO7uKo2dy+Vb9WP4d9lgiV7p2
         VAOma4Xok923xWVAhUZ9zW4UvVbl5bfa4UdKFFMtVrwQom3dkFEuKc8rnrvmpIqUlJ
         qg3ISEdbyVPTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7EC2C395D9;
        Tue, 20 Jun 2023 19:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] crypto: af_alg/hash: Fix recvmsg() after
 sendmsg(MSG_MORE)
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168728881968.9715.9390991093529503679.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 19:20:19 +0000
References: <427646.1686913832@warthog.procyon.org.uk>
In-Reply-To: <427646.1686913832@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, herbert@gondor.apana.org.au,
        syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com,
        syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com,
        syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com,
        syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, willy@infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jun 2023 12:10:32 +0100 you wrote:
> If an AF_ALG socket bound to a hashing algorithm is sent a zero-length
> message with MSG_MORE set and then recvmsg() is called without first
> sending another message without MSG_MORE set to end the operation, an oops
> will occur because the crypto context and result doesn't now get set up in
> advance because hash_sendmsg() now defers that as long as possible in the
> hope that it can use crypto_ahash_digest() - and then because the message
> is zero-length, it the data wrangling loop is skipped.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)
    https://git.kernel.org/netdev/net-next/c/b6d972f68983

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


