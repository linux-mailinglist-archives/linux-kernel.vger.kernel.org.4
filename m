Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A8691735
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjBJDjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBJDjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:39:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01ECD50A;
        Thu,  9 Feb 2023 19:39:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55A70B819FF;
        Fri, 10 Feb 2023 03:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE552C433A0;
        Fri, 10 Feb 2023 03:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676000372;
        bh=xj47ybbF7LI1Wrz6w6+Q/zE1oBtiQ7WkVJ8gYj3Z8yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulPIXuoGBO891EXyVOKqbaLIDplW7SI8JhbdWl6lbINdlqR24Xa0JieSlZfQULpJl
         LaBTjJ/fp1nDH0k33nEp8grRay2z1Q3mSd6P1HYxGCvHPW5+LVt9Qwm5iRV2X/lcVj
         c+KnyPAF3wP5PL0aBu83IsuVS04KxANBqJXS8VGed++cBqTu1odY0P7Ss1GrPAFtD1
         7LYUMbjh/J6wthNqNLHGTmszJMNh9dNCTTCPcB1OSvZ3H45M9+nosuDKiQ3U/J0WyI
         +4tF5Zyd2jwVV24KR14KttgXAkhLr1qZr9E0EdBkftiChbzjwyTSBASCk0Jgm18V/w
         wQ6O9gOyKpqWg==
Date:   Fri, 10 Feb 2023 05:39:29 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 1/6] KEYS: Create static version of
 public_key_verify_signature
Message-ID: <Y+W8VQnCw2RlwFnH@kernel.org>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-2-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207025958.974056-2-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:59:53PM -0500, Eric Snowberg wrote:
> The kernel test robot reports undefined reference to
> public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
> not defined. Create a static version in this case and return -EINVAL.
> 
> Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
> Reported-by: kernel test robot <lkp@intel.com>

What is this reported-by is good for?

> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/crypto/public_key.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 68f7aa2a7e55..6d61695e1cde 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
>  extern int verify_signature(const struct key *,
>  			    const struct public_key_signature *);
>  
> +#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
>  int public_key_verify_signature(const struct public_key *pkey,
>  				const struct public_key_signature *sig);
> +#else
> +static inline
> +int public_key_verify_signature(const struct public_key *pkey,
> +				const struct public_key_signature *sig)
> +{
> +	return -EINVAL;
> +}
> +#endif
>  
>  #endif /* _LINUX_PUBLIC_KEY_H */
> -- 
> 2.27.0
> 

BR, Jarkko
