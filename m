Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7F6F14F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbjD1KFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjD1KFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:05:45 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685D10B;
        Fri, 28 Apr 2023 03:05:43 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1psKyw-003E2t-5P; Fri, 28 Apr 2023 18:05:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Apr 2023 18:05:39 +0800
Date:   Fri, 28 Apr 2023 18:05:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Olivier Bacon <olivierb89@gmail.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olivier Bacon <obacon@genetec.com>,
        Sylvain Ouellet <souellet@genetec.com>
Subject: Re: [PATCH] crypto: engine - fix crypto_queue backlog handling
Message-ID: <ZEuac5MjDVWidTBX@gondor.apana.org.au>
References: <20230420150035.19369-1-obacon@genetec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420150035.19369-1-obacon@genetec.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:00:35AM -0400, Olivier Bacon wrote:
> CRYPTO_TFM_REQ_MAY_BACKLOG tells the crypto driver that it should
> internally backlog requests until the crypto hw's queue becomes
> full. At that point, crypto_engine backlogs the request and returns
> -EBUSY. Calling driver such as dm-crypt then waits until the
> complete() function is called with a status of -EINPROGRESS before
> sending a new request.
> 
> The problem lies in the call to complete() with a value of -EINPROGRESS
> that is made when a backlog item is present on the queue. The call is
> done before the successful execution of the crypto request. In the case
> that do_one_request() returns < 0 and the retry support is available,
> the request is put back in the queue. This leads upper drivers to send
> a new request even if the queue is still full.
> 
> The problem can be reproduced by doing a large dd into a crypto
> dm-crypt device. This is pretty easy to see when using
> Freescale CAAM crypto driver and SWIOTLB dma. Since the actual amount
> of requests that can be hold in the queue is unlimited we get IOs error
> and dma allocation.
> 
> The fix is to call complete with a value of -EINPROGRESS only if
> the request is not enqueued back in crypto_queue. This is done
> by calling complete() later in the code. In order to delay the decision,
> crypto_queue is modified to correctly set the backlog pointer
> when a request is enqueued back.
> 
> Fixes: 6a89f492f8e5 ("crypto: engine - support for parallel requests based on retry mechanism")
> Co-developed-by: Sylvain Ouellet <souellet@genetec.com>
> Signed-off-by: Sylvain Ouellet <souellet@genetec.com>
> Signed-off-by: Olivier Bacon <obacon@genetec.com>
> ---
>  crypto/algapi.c        | 3 +++
>  crypto/crypto_engine.c | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
