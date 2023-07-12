Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707DD74FD78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGLDKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjGLDKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD971BE8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1DE616A1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C858C433C8;
        Wed, 12 Jul 2023 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689131396;
        bh=Os4SCV5ZzvjtqSv6di6M5MCo9Im5sxnwXQeFenpBIjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/tEvxtA2Sfo9Djzp5f/eGjGpZaoyYSZ0Cgf9+dRDayXv7wOqSPv2kPbQ63UOGdY3
         AI/2yI/2VrtISB9G5swwkkH1mcIMLuUF8hOvRoFobJaNFOioGNQ+8KzOJVbcBbk6Zm
         ASbPOo7SnS7s2C3t9Z/NAb7ihcS0AuZuz+ZsHLo2kw3AUraOFi04I6xn8nzkRyw2D6
         yLIW1Y6Lr/0FO4hLHIwCZ0yk9y9e+pFRd4XyX84mMay/0TwMCsOGhVBHyA3yuhWXRd
         pirpb5L8AL9CkF26FcbGsp796/wlNR2vHQiPHwVhkW1cHI1B9gCCRF16stnFMPxNIx
         95bTE+pLBNkoA==
Date:   Tue, 11 Jul 2023 20:09:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     michael.chan@broadcom.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next v2] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
Message-ID: <20230711200955.2d3a4494@kernel.org>
In-Reply-To: <20230711110743.39067-1-imagedong@tencent.com>
References: <20230711110743.39067-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 19:07:43 +0800 menglong8.dong@gmail.com wrote:
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

I think this is way too verbose, people looking at networking code 
are expected to understand kfree_skb vs consume_skb. Your v1 was fine,
I'm going to apply it.
-- 
pw-bot: na
