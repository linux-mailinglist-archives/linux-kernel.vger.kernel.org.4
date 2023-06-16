Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B44732EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbjFPKeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbjFPKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:33:14 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1888059C1;
        Fri, 16 Jun 2023 03:28:19 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA6fY-003lEH-TO; Fri, 16 Jun 2023 18:27:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 18:27:04 +0800
Date:   Fri, 16 Jun 2023 18:27:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com,
        syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com,
        syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com,
        syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] crypto: af_alg/hash: Fix recvmsg() after
 sendmsg(MSG_MORE)
Message-ID: <ZIw4+Go7ZIth+CsY@gondor.apana.org.au>
References: <1679829.1686785273@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679829.1686785273@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:27:53AM +0100, David Howells wrote:
>     
> If an AF_ALG socket bound to a hashing algorithm is sent a zero-length
> message with MSG_MORE set and then recvmsg() is called without first
> sending another message without MSG_MORE set to end the operation, an oops
> will occur because the crypto context and result doesn't now get set up in
> advance because hash_sendmsg() now defers that as long as possible in the
> hope that it can use crypto_ahash_digest() - and then because the message
> is zero-length, it the data wrangling loop is skipped.
> 
> Fix this by always making a pass of the loop, even in the case that no data
> is provided to the sendmsg().
> 
> Fix also extract_iter_to_sg() to handle a zero-length iterator by returning
> 0 immediately.
> 
> Whilst we're at it, remove the code to create a kvmalloc'd scatterlist if
> we get more than ALG_MAX_PAGES - this shouldn't happen.
> 
> Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
> Reported-by: syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000b928f705fdeb873a@google.com/
> Reported-by: syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000c047db05fdeb8790@google.com/
> Reported-by: syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000bcca3205fdeb87fb@google.com/
> Reported-by: syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000b55d8805fdeb8385@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com
> Tested-by: syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com
> Tested-by: syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com
> Tested-by: syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-crypto@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  crypto/algif_hash.c |   21 +++++----------------
>  lib/scatterlist.c   |    2 +-
>  2 files changed, 6 insertions(+), 17 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
