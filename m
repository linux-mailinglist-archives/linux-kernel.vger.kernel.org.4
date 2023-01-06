Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDEF660303
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjAFPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjAFPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:19:03 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77825831AE;
        Fri,  6 Jan 2023 07:19:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDoUj-00Eby5-6V; Fri, 06 Jan 2023 23:18:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Jan 2023 23:18:57 +0800
Date:   Fri, 6 Jan 2023 23:18:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Rientjes <rientjes@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>,
        Andy Nguyen <theflow@google.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, John Allen <john.allen@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch] crypto: ccp - Avoid page allocation failure warning for
 SEV_GET_ID2
Message-ID: <Y7g74TNRIBjoJH94@gondor.apana.org.au>
References: <20221214202046.719598-1-pgonda@google.com>
 <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au>
 <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com>
 <Y6wDJd3hfztLoCp1@gondor.apana.org.au>
 <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
 <833b4dd0-7f85-b336-0786-965f3f573f74@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833b4dd0-7f85-b336-0786-965f3f573f74@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 02:18:46PM -0800, David Rientjes wrote:
> For SEV_GET_ID2, the user provided length does not have a specified 
> limitation because the length of the ID may change in the future.  The 
> kernel memory allocation, however, is implicitly limited to 4MB on x86 by 
> the page allocator, otherwise the kzalloc() will fail.
> 
> When this happens, it is best not to spam the kernel log with the warning.  
> Simply fail the allocation and return ENOMEM to the user.
> 
> Fixes: d6112ea0cb34 ("crypto: ccp - introduce SEV_GET_ID2 command")
> Reported-by: Andy Nguyen <theflow@google.com>
> Reported-by: Peter Gonda <pgonda@google.com>
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
