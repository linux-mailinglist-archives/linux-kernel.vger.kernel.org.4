Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F4732F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjFPK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbjFPK6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:58:38 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E855786AA;
        Fri, 16 Jun 2023 03:51:47 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA6gR-003lHK-Cz; Fri, 16 Jun 2023 18:28:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 18:27:59 +0800
Date:   Fri, 16 Jun 2023 18:27:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] crypto: Fix af_alg_sendmsg(MSG_SPLICE_PAGES)
 sglist limit
Message-ID: <ZIw5L081E2GjdLrQ@gondor.apana.org.au>
References: <322883.1686863334@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322883.1686863334@warthog.procyon.org.uk>
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

On Thu, Jun 15, 2023 at 10:08:54PM +0100, David Howells wrote:
> When af_alg_sendmsg() calls extract_iter_to_sg(), it passes MAX_SGL_ENTS as
> the maximum number of elements that may be written to, but some of the
> elements may already have been used (as recorded in sgl->cur), so
> extract_iter_to_sg() may end up overrunning the scatterlist.
> 
> Fix this to limit the number of elements to "MAX_SGL_ENTS - sgl->cur".
> 
> Note: It probably makes sense in future to alter the behaviour of
> extract_iter_to_sg() to stop if "sgtable->nents >= sg_max" instead, but
> this is a smaller fix for now.
> 
> The bug causes errors looking something like:
> 
> BUG: KASAN: slab-out-of-bounds in sg_assign_page include/linux/scatterlist.h:109 [inline]
> BUG: KASAN: slab-out-of-bounds in sg_set_page include/linux/scatterlist.h:139 [inline]
> BUG: KASAN: slab-out-of-bounds in extract_bvec_to_sg lib/scatterlist.c:1183 [inline]
> BUG: KASAN: slab-out-of-bounds in extract_iter_to_sg lib/scatterlist.c:1352 [inline]
> BUG: KASAN: slab-out-of-bounds in extract_iter_to_sg+0x17a6/0x1960 lib/scatterlist.c:1339
> 
> Fixes: bf63e250c4b1 ("crypto: af_alg: Support MSG_SPLICE_PAGES")
> Reported-by: syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000b2585a05fdeb8379@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com
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
>  crypto/af_alg.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
