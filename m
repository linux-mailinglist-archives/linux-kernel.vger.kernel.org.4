Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B5732F49
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244894AbjFPK6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbjFPK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:58:21 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A2B59F9;
        Fri, 16 Jun 2023 03:51:35 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA6vL-003mQV-Ij; Fri, 16 Jun 2023 18:43:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 18:43:23 +0800
Date:   Fri, 16 Jun 2023 18:43:23 +0800
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
Message-ID: <ZIw8y2w+A+t5u+IJ@gondor.apana.org.au>
References: <ZIw4+Go7ZIth+CsY@gondor.apana.org.au>
 <1679829.1686785273@warthog.procyon.org.uk>
 <426353.1686911878@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426353.1686911878@warthog.procyon.org.uk>
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

On Fri, Jun 16, 2023 at 11:37:58AM +0100, David Howells wrote:
> Can you have a look at:
> 
> 	https://lore.kernel.org/r/415439.1686877276@warthog.procyon.org.uk/
> 
> I'm proposing that as an alternative to this patch.

It'd be easier to comment on it if you sent it by email.

Anyway, why did you remove the condition on hash_free_result?
We free the result if it's not needed, not to clear the previous
hash.  So by doing it uncondtionally you will simply end up
freeing and reallocating the result for no good reason.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
