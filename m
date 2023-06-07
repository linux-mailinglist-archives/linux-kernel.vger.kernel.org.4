Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31D72673E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjFGR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjFGR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B81FE9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33EBE641ED
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05812C433D2;
        Wed,  7 Jun 2023 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158761;
        bh=0MBhuEUX2bktmVFKRPGnv8oU9W5tm0XrwIeAW9OBqu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NYJztc6K5jZaEpT5qmYChibBOYzwSAkpmz4luHH2EERw0PJbUy4NdUK7sOHmMohEv
         L4Y7jZiccYhyhFR5ioEP01GXWEyxpDJ73Gab/BxVRJhCWxnFAvzE29QxtsB3IuT1xn
         qTcuRgtm/jMMrfC+i53EtgpTUIBBrnLMh+sI0NfGT4IFKTnbOOgHyY6BB+ny035F9E
         av80Tcccr/PaZaKHCB3HTiybgCAWkD4ePOn5L4H0tXwCaTFgXNFkqzK4UldjZtsxwy
         rbwwSEegzCShGku9llVhj8mpPI6xq3GpFvw8RP/8sQpd1zt7NT2VqVpvzleaooJKow
         euaKcvwu3sxTw==
Date:   Wed, 7 Jun 2023 10:26:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 14/14] tls/device: Convert
 tls_device_sendpage() to use MSG_SPLICE_PAGES
Message-ID: <20230607102600.07d16cf0@kernel.org>
In-Reply-To: <20230607140559.2263470-15-dhowells@redhat.com>
References: <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-15-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Jun 2023 15:05:59 +0100 David Howells wrote:
> Convert tls_device_sendpage() to use sendmsg() with MSG_SPLICE_PAGES rather
> than directly splicing in the pages itself.  With that, the tls_iter_offset
> union is no longer necessary and can be replaced with an iov_iter pointer
> and the zc_page argument to tls_push_data() can also be removed.
> 
> This allows ->sendpage() to be replaced by something that can handle
> multiple multipage folios in a single transaction.

Acked-by: Jakub Kicinski <kuba@kernel.org>
