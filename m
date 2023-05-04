Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D96F685F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjEDJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEDJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:35:49 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849B844AD;
        Thu,  4 May 2023 02:35:45 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1puVNC-0057KI-BQ; Thu, 04 May 2023 17:35:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 May 2023 17:35:39 +0800
Date:   Thu, 4 May 2023 17:35:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hash - Add default handlers for digest, export,
 import
Message-ID: <ZFN8a0z6qQUW6Zbg@gondor.apana.org.au>
References: <20230504093255.350365-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504093255.350365-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 05:32:55PM +0800, David Yang wrote:
> The document of struct ahash_alg explicitly states that @finup,
> combination of @update and @final, is optional, while said nothing about
> @digest, which is combination of @init and @finup (@update and @final).
> 
> This gives a illusion that @digest might be optional. However
> crypto_ahash_init_tfm() strangely does expect a non-NULL @digest,
> otherwise it'll result in NULL pointer dereference.
> 
> Add default handlers for digest, export, import according to the behavior
> in the document, and mark them optional.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  crypto/ahash.c        | 28 +++++++++++++++++++++++++---
>  include/crypto/hash.h | 12 ++++++------
>  2 files changed, 31 insertions(+), 9 deletions(-)

Nack.  There is a default for finup because finup was added later.
Every driver should implement all of the methods.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
