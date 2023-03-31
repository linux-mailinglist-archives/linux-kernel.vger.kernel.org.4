Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369906D1B38
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjCaJEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjCaJER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:04:17 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820A1FD2A;
        Fri, 31 Mar 2023 02:03:50 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1piAfN-00AjpH-I6; Fri, 31 Mar 2023 17:03:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Mar 2023 17:03:25 +0800
Date:   Fri, 31 Mar 2023 17:03:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harsha Harsha <harsha.harsha@amd.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michals@xilinx.com, saratcha@xilinx.com, git@amd.com,
        Dhaval Shah <dhaval.r.shah@amd.com>
Subject: Re: [PATCH V2 3/4] crypto: xilinx: Add ZynqMP RSA driver
Message-ID: <ZCah3f/Z8nzdHITy@gondor.apana.org.au>
References: <20230321053446.4303-1-harsha.harsha@amd.com>
 <20230321053446.4303-4-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321053446.4303-4-harsha.harsha@amd.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:04:45AM +0530, Harsha Harsha wrote:
>
> +static inline int xilinx_copy_and_save_keypart(u8 **kpbuf, unsigned int *kplen,
> +					       const u8 *buf, size_t sz)
> +{
> +	int nskip;
> +
> +	for (nskip = 0; nskip < sz; nskip++)
> +		if (buf[nskip])
> +			break;
> +
> +	*kplen = sz - nskip;
> +	*kpbuf = kmemdup(buf + nskip, *kplen, GFP_KERNEL);
> +	if (!*kpbuf)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

...

> +static int xilinx_rsa_setkey(struct crypto_akcipher *tfm, const void *key,
> +			     unsigned int keylen, bool private)
> +{
> +	struct xilinx_rsa_tfm_ctx *tctx = akcipher_tfm_ctx(tfm);
> +	struct rsa_key raw_key;
> +	int ret;
> +
> +	if (private)
> +		ret = rsa_parse_priv_key(&raw_key, key, keylen);
> +	else
> +		ret = rsa_parse_pub_key(&raw_key, key, keylen);
> +	if (ret)
> +		goto n_key;
> +
> +	ret = xilinx_copy_and_save_keypart(&tctx->n_buf, &tctx->n_len,
> +					   raw_key.n, raw_key.n_sz);

What happens when you call setkey twice? Wouldn't this leak memory?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
