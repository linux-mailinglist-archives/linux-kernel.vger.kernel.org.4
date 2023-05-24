Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97DC70F3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjEXKSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjEXKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:18:12 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C010DB;
        Wed, 24 May 2023 03:17:26 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q1lXr-00Cl6E-Rk; Wed, 24 May 2023 18:16:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 May 2023 18:16:39 +0800
Date:   Wed, 24 May 2023 18:16:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/crypto: fix build warnings when DEBUG_FS is not
 enabled
Message-ID: <ZG3kB4Mlmlc4I0Ck@gondor.apana.org.au>
References: <20230519223334.11992-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519223334.11992-1-rdunlap@infradead.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 03:33:34PM -0700, Randy Dunlap wrote:
> Fix build warnings when DEBUG_FS is not enabled by using an empty
> do-while loop instead of a value:
> 
> In file included from ../drivers/crypto/nx/nx.c:27:
> ../drivers/crypto/nx/nx.c: In function 'nx_register_algs':
> ../drivers/crypto/nx/nx.h:173:33: warning: statement with no effect [-Wunused-value]
>   173 | #define NX_DEBUGFS_INIT(drv)    (0)
> ../drivers/crypto/nx/nx.c:573:9: note: in expansion of macro 'NX_DEBUGFS_INIT'
>   573 |         NX_DEBUGFS_INIT(&nx_driver);
> ../drivers/crypto/nx/nx.c: In function 'nx_remove':
> ../drivers/crypto/nx/nx.h:174:33: warning: statement with no effect [-Wunused-value]
>   174 | #define NX_DEBUGFS_FINI(drv)    (0)
> ../drivers/crypto/nx/nx.c:793:17: note: in expansion of macro 'NX_DEBUGFS_FINI'
>   793 |                 NX_DEBUGFS_FINI(&nx_driver);
> 
> Also, there is no need to build nx_debugfs.o when DEBUG_FS is not
> enabled, so change the Makefile to accommodate that.
> 
> Fixes: ae0222b7289d ("powerpc/crypto: nx driver code supporting nx encryption")
> Fixes: aef7b31c8833 ("powerpc/crypto: Build files for the nx device driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Breno Leitão <leitao@debian.org>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/crypto/nx/Makefile |    2 +-
>  drivers/crypto/nx/nx.h     |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
