Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3573DC23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFZKVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjFZKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:21:04 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B741E48;
        Mon, 26 Jun 2023 03:21:01 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qDjKv-007JRA-2D; Mon, 26 Jun 2023 18:20:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 26 Jun 2023 18:20:45 +0800
Date:   Mon, 26 Jun 2023 18:20:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <ZJlmfR8KfZjl1ktW@gondor.apana.org.au>
References: <20230626123946.6de22527@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626123946.6de22527@canb.auug.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:39:46PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the crypto tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ld: warning: discarding dynamic section .glink
> ld: warning: discarding dynamic section .plt
> ld: linkage table error against `sm2_compute_z_digest'
> ld: stubs don't match calculated size
> ld: can not build stubs: bad value
> ld: crypto/asymmetric_keys/x509_public_key.o: in function `x509_get_sig_params':
> x509_public_key.c:(.text+0x474): undefined reference to `sm2_compute_z_digest'
> 
> Possibly caused by commit
> 
>   e5221fa6a355 ("KEYS: asymmetric: Move sm2 code into x509_public_key")
> 
> This looks like it may be a compiler bug?  Maybe the deep ternary
> expressions may be contributing to that? (cc'ing the ppc guys in case
> they have any ideas.)
> 
> I have reverted that commit (and the following one) for today.

Thanks Stephen.  I've just pushed out a fix for this.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
