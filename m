Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8734C72A160
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFIRiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFIRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172830E4;
        Fri,  9 Jun 2023 10:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E4665A69;
        Fri,  9 Jun 2023 17:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E869CC433D2;
        Fri,  9 Jun 2023 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686332291;
        bh=icNiG/63HCTnQQ5c7BPDl+cCQASiXnUyqyp2rJM4Z+M=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QQAxK5mux0Cu/S+yYYc9+esD1cUQI12juAHSMPfsDDV4kq76xpRT6V8Rnak9r/aAN
         rM95uz0eT5Di99BELMhORwpctdUPcgSZ8vxVG1FDk6gQ1/4FWddnv3yuVpBNLghQOS
         8WXNqrnwfyjVPLXJE5+M20YwFmecXdNbYzNeLgcZocjJSe9zxXlRo+vZuT173xSk8V
         jmGyLeOGEgy5Nv6jrW+Duy9D+tGRiyoBTwBdC/xHcS3tSI1/BeiMXEWNtvh/+dOpzp
         y3pdd80GkO6weVLcku+iEcmvXGY92Efao9TkCysF/sly30U0pdYwB9o2r1//6OYG+V
         RSv5B8c8zGJUg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 20:38:07 +0300
Message-Id: <CT8AWM6PDMMX.RAF5C6RS1P95@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tianjia Zhang" <tianjia.zhang@linux.alibaba.com>,
        "David Howells" <dhowells@redhat.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sign-file: simplify main function implementation
X-Mailer: aerc 0.14.0
References: <20230525084343.56824-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20230525084343.56824-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 25, 2023 at 11:43 AM EEST, Tianjia Zhang wrote:
> use_signed_attrs is an unnecessary variable, deleting this variable
> can simplify the code.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  scripts/sign-file.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 94267cf72197..377d586762f9 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -224,7 +224,6 @@ int main(int argc, char **argv)
>  	bool raw_sig =3D false;
>  	unsigned char buf[4096];
>  	unsigned long module_size, sig_size;
> -	unsigned int use_signed_attrs;
>  	const EVP_MD *digest_algo;
>  	EVP_PKEY *private_key;
>  #ifndef USE_PKCS7
> @@ -242,12 +241,6 @@ int main(int argc, char **argv)
> =20
>  	key_pass =3D getenv("KBUILD_SIGN_PIN");
> =20
> -#ifndef USE_PKCS7
> -	use_signed_attrs =3D CMS_NOATTR;
> -#else
> -	use_signed_attrs =3D PKCS7_NOATTR;
> -#endif
> -
>  	do {
>  		opt =3D getopt(argc, argv, "sdpk");
>  		switch (opt) {
> @@ -340,8 +333,7 @@ int main(int argc, char **argv)
> =20
>  		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
>  				     CMS_NOCERTS | CMS_BINARY |
> -				     CMS_NOSMIMECAP | use_keyid |
> -				     use_signed_attrs),
> +				     CMS_NOSMIMECAP | CMS_NOATTR | use_keyid),
>  		    "CMS_add1_signer");
>  		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
>  		    "CMS_final");
> @@ -349,7 +341,7 @@ int main(int argc, char **argv)
>  #else
>  		pkcs7 =3D PKCS7_sign(x509, private_key, NULL, bm,
>  				   PKCS7_NOCERTS | PKCS7_BINARY |
> -				   PKCS7_DETACHED | use_signed_attrs);
> +				   PKCS7_DETACHED | PKCS7_NOATTR);
>  		ERR(!pkcs7, "PKCS7_sign");
>  #endif
> =20
> --=20
> 2.24.3 (Apple Git-128)

I'm sorry but I don't see how this makes our lives better.

If, however, this was part of a larger patch, it might make sense, if
there was a real functional change concerning the same code blocks.

BR, Jarkko
