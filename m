Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B3656E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiL0TXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0TXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:23:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB2D4C;
        Tue, 27 Dec 2022 11:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 968D9B80E8C;
        Tue, 27 Dec 2022 19:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BFFC433EF;
        Tue, 27 Dec 2022 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672168976;
        bh=JZVucA8oHxLNl9U1Lb781S9ah8U4/JhduG51boVtfvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRBmMG5yRCzun79mh5c6fhtVgNPwQO7Vm3IBaHwZT5Kk49+ecVp4FMvGcHWFQOGTl
         caYQd12doLUszoP0i14aqrgjbsm4oB9lZbVVXKI2V0gHItCEQXTarFBB18u9PXkDNT
         ChmJNuWHnGIAATLRtuCsWVKRO0AYGZ65e5o9pXF78kFEefJZvzzmBZFJCDZsdWdunQ
         RsTpBikc9CcuyPrVCQ1VzgIu4+4PcpTtP8UXqMUn1mLCMTWeCcb2ND46PqOH+zL+/S
         CJudYAfqPXSeoWxfXue9W7mRYUmtaNLvRxl8gcu51WgG0fQoFwMhEAWjy66fg+/ybx
         GeGfRX42jFhzQ==
Date:   Tue, 27 Dec 2022 19:22:38 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: certs: fix FIPS selftest depenency
Message-ID: <Y6tF52G6/bnG+VfJ@kernel.org>
References: <20221215170259.2553400-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215170259.2553400-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 06:02:52PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The selftest code is built into the x509_key_parser module, and depends
> on the pkcs7_message_parser module, which in turn has a dependency on
> the key parser, creating a dependency loop and a resulting link
> failure when the pkcs7 code is a loadable module:
> 
> ld: crypto/asymmetric_keys/selftest.o: in function `fips_signature_selftest':
> crypto/asymmetric_keys/selftest.c:205: undefined reference to `pkcs7_parse_message'
> ld: crypto/asymmetric_keys/selftest.c:209: undefined reference to `pkcs7_supply_detached_data'
> ld: crypto/asymmetric_keys/selftest.c:211: undefined reference to `pkcs7_verify'
> ld: crypto/asymmetric_keys/selftest.c:215: undefined reference to `pkcs7_validate_trust'
> ld: crypto/asymmetric_keys/selftest.c:219: undefined reference to `pkcs7_free_message'
> 
> Avoid this by only allowing the selftest to be enabled when either
> both parts are loadable modules, or both are built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/asymmetric_keys/Kconfig        | 2 +-
>  crypto/asymmetric_keys/pkcs7_verify.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> index 3df3fe4ed95f..1ef3b46d6f6e 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -83,6 +83,6 @@ config FIPS_SIGNATURE_SELFTEST
>  	  for FIPS.
>  	depends on KEYS
>  	depends on ASYMMETRIC_KEY_TYPE
> -	depends on PKCS7_MESSAGE_PARSER
> +	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
>  
>  endif # ASYMMETRIC_KEY_TYPE
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
> index f6321c785714..4fa769c4bcdb 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -485,3 +485,4 @@ int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
>  	pkcs7->data_len = datalen;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pkcs7_supply_detached_data);
> -- 
> 2.35.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
