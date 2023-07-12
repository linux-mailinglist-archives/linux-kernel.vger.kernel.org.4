Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3C74FDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGLDae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGLDa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1510A10C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86C22616CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD4FCC43395;
        Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689132623;
        bh=J+ZFL0ZRv0nFgtlQnK7I2paSKhB8TC4oBGTUZbhnst4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=efNy3nQ/RlHoa5XJx7HjGS5af+OkimFH8dz/4E0AzeD4f4vOIOfnxD0CWowVWndP1
         UEq1gJ4bqJ/KCEAMJtgAS4SAt9TEIxZYJfwUTFqmIMMc0JOTWJiyKi9b+rYq2TBl+x
         wwcuoJg97KYK+yooVyApAJSOFqo/w0Jw7scY1Q3w73ZLwWxGrE9XKlef4E5zT7Q0eQ
         9OJAP14U0cC5HQ5kK1xlNMIVWGj278o7+fI7L9qC82wrvaUWpapfFBi3EcIg5XV2wg
         +nzagpl06+/sLU24nMqvNVCJeMLh9EmIs8FK++EMQaQVRg1dOreF8o8dJpbZ+9Atuv
         Be3KNi9mFoxpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE0B8E29F44;
        Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168913262370.27250.6393079802068929185.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 03:30:23 +0000
References: <20230711110743.39067-1-imagedong@tencent.com>
In-Reply-To: <20230711110743.39067-1-imagedong@tencent.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     michael.chan@broadcom.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        imagedong@tencent.com, leonro@nvidia.com
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

On Tue, 11 Jul 2023 19:07:43 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In bnxt_tx_int(), the skb in the tx ring buffer will be freed after the
> transmission completes with dev_kfree_skb_any(), which will produce
> the noise on the tracepoint "skb:kfree_skb":
> 
> $ perf script record -e skb:kfree_skb -a
> $ perf script
>   swapper     0 [014] 12814.337522: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [003] 12814.338318: skb:kfree_skb: skbaddr=0xffff888108380600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.375258: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.451960: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [008] 12814.562166: skb:kfree_skb: skbaddr=0xffff888112664600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.732517: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.800608: skb:kfree_skb: skbaddr=0xffff88810025d100 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.861501: skb:kfree_skb: skbaddr=0xffff888108295a00 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12815.377038: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12815.395530: skb:kfree_skb: skbaddr=0xffff88818f145ee0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
    https://git.kernel.org/netdev/net-next/c/47b7acfb016b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


