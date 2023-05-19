Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C337093C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjESJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjESJiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:38:50 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E135F210D;
        Fri, 19 May 2023 02:37:34 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pzwWa-00ApJo-MZ; Fri, 19 May 2023 17:35:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 May 2023 17:35:48 +0800
Date:   Fri, 19 May 2023 17:35:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dmitry Safonov <dima@arista.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] crypto: shash - Allow cloning on algorithms with no
 init_tfm
Message-ID: <ZGdC9MDomBGRpccP@gondor.apana.org.au>
References: <ZGcyuyjJwZhdYS/G@gondor.apana.org.au>
 <E1pzvTZ-00AnMQ-5M@formenos.hmeau.com>
 <CAMj1kXGwS03zUBTGb7jmk1-6r+=a-HH+A-S9ZFTYRyJSzN0Xcg@mail.gmail.com>
 <ZGc7hCaDrnEFG8Lr@gondor.apana.org.au>
 <CAMj1kXEkz1QvkXWc8dCGhU_MPf+1M3P2+rAiLciuixnKCmRESg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEkz1QvkXWc8dCGhU_MPf+1M3P2+rAiLciuixnKCmRESg@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 11:31:30AM +0200, Ard Biesheuvel wrote:
>
> OK. So IIUC, cloning a keyless hash just shares the TFM and bumps the
> refcount, but here we must actually allocate a new TFM referring to
> the same algo, and this new TFM needs its key to be set before use, as
> it doesn't inherit it from the clonee, right? And this works in the
> same way as cloning an instance of the generic HMAC template, as this
> will just clone the inner shash too, and will also leave the key
> unset.

Yes that's pretty much it.  Cloning a tfm is basically exactly
the same as allocating a tfm, except that instead of going through
the init_tfm code-path it executes clone_tfm instead (thus allowing
any internal data structures to either be shared or allocated with
GFP_ATOMIC).

The key will be unset just like a freshly allocated tfm.

> If so,
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
