Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D843C6BA641
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjCOEeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCOEdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:33:55 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5AE46142;
        Tue, 14 Mar 2023 21:33:45 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pcI0Q-004UX3-62; Wed, 15 Mar 2023 11:40:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 15 Mar 2023 11:40:50 +0800
Date:   Wed, 15 Mar 2023 11:40:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam/jr - fix algorithms exit/cleanup
Message-ID: <ZBE+QhPBxG7VhBry@gondor.apana.org.au>
References: <20230314180733.4167836-1-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314180733.4167836-1-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:37:33PM +0530, meenakshi.aggarwal@nxp.com wrote:
> From: Horia GeantA <horia.geanta@nxp.com>
> 
> Current implementations is not being able to gracefully unregister
> crypto algorithms from crypto API while there are users / allocated
> tfms (cra_refcnt > 1).
> 
> When unloading the caam_jr module, the .remove callback for the last JR
> device exits with -EBUSY and doesn't perform the clean-up
> (crypto algorithms unregistering etc.).
> 
> One side effect of this is leading to an oops, which occurs due to a
> corruption in the linked list of "misc devices"
> (drivers/char/misc.c - misc_list)
> 
> Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/jr.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)

Sorry, I don't think this is the right way to go.

We need to disassociate the registration of the Crypto algorithms
(soft) from the presence of the hardware (hard).

Sure, you can certainly refuse to register any algorithms until
the first piece of hardware shows up.  But once you are registered,
you must not unregister yourself from the Crypto API until the module
actually goes away (when built-in that means never).

The complexity then goes into making sure that your driver fails
gracefully when the device goes away in the *middle* of a crypto
computation.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
