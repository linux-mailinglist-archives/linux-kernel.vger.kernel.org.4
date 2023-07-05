Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA490749065
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGEV54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGEV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:57:54 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919BB9F;
        Wed,  5 Jul 2023 14:57:51 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qHAVM-000b7a-Fj; Thu, 06 Jul 2023 07:57:45 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 06 Jul 2023 05:57:37 +0800
Date:   Thu, 6 Jul 2023 05:57:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, agk@redhat.com,
        snitzer@kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, heinzm@redhat.com, meenakshi.aggarwal@nxp.com,
        horia.geanta@nxp.com, V.Sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net, iuliana.prodan@nxp.com,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: Re: [PATCH 1/3] dm integrity: do not filter algos with
 CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <ZKXnUeueV6ncaJM6@gondor.apana.org.au>
References: <20230705164009.58351-1-giovanni.cabiddu@intel.com>
 <20230705164009.58351-2-giovanni.cabiddu@intel.com>
 <20230705201205.GA866@sol.localdomain>
 <ZKXZUl4VgZkMbOL0@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKXZUl4VgZkMbOL0@gcabiddu-mobl1.ger.corp.intel.com>
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

On Wed, Jul 05, 2023 at 09:57:54PM +0100, Giovanni Cabiddu wrote:
>
> Then we are then back to square one. We need to check how many entries
> are present in the scatterlists encrypted by crypt_journal() before
> adjusting the meaning of !CRYPTO_ALG_ALLOCATES_MEMORY.

Indeed.  I missed the fact that it was preallocating memory with
GFP_KERNEL.

So perhaps the answer is to adjust our API to allow the drivers to
pre-allocate memory.  I'll look into this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
