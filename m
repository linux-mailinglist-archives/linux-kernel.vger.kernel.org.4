Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5C6EDB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjDYFkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjDYFka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:40:30 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D79769D;
        Mon, 24 Apr 2023 22:40:29 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1prBPT-001zsP-JI; Tue, 25 Apr 2023 13:40:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 25 Apr 2023 13:40:16 +0800
Date:   Tue, 25 Apr 2023 13:40:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Danny Tsen <dtsen@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
Subject: Re: [PATCH 2/5] Glue code for optmized Chacha20 implementation for
 ppc64le.
Message-ID: <ZEdnwK+dsRz5EqmF@gondor.apana.org.au>
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
 <20230424184726.2091-3-dtsen@linux.ibm.com>
 <ZEdnEjhdP4eoNL/o@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEdnEjhdP4eoNL/o@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:37:22PM +0800, Herbert Xu wrote:
> On Mon, Apr 24, 2023 at 02:47:23PM -0400, Danny Tsen wrote:
> >
> > +static int __init chacha_p10_init(void)
> > +{
> > +	static_branch_enable(&have_p10);
> > +
> > +	return IS_REACHABLE(CONFIG_CRYPTO_SKCIPHER) ?
> > +		crypto_register_skciphers(algs, ARRAY_SIZE(algs)) : 0;
> 
> What is this for? The usual way is to select CRYPTO_SKCIPHER
> rather than have a mysterious failure at run-time.

Nevermind, I see that you also have non-Crypto API code in there.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
