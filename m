Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDE6567FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiL0HyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiL0HyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:54:03 -0500
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Dec 2022 23:54:01 PST
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567926561
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:54:01 -0800 (PST)
Received: (qmail 7681 invoked from network); 27 Dec 2022 07:47:15 -0000
Received: from dyn.ipv6.net-htp.de ([2a02:560:5628:3900:ecef:1c71:d0b:2fa4]:49250 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <james.bottomley@hansenpartnership.com>; Tue, 27 Dec 2022 08:47:15 +0100
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     james.bottomley@hansenpartnership.com, yang.yang29@zte.com.cn
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next v2] parisc: use strscpy() to instead of strncpy()
Date:   Tue, 27 Dec 2022 08:47:05 +0100
Message-ID: <2298026.kkTNVCUfUN@daneel.sf-tec.de>
In-Reply-To: <202212261840048448622@zte.com.cn>
References: <202212261840048448622@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2316597.IaFIOm8ydW"; micalg="pgp-sha1"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2316597.IaFIOm8ydW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: james.bottomley@hansenpartnership.com, yang.yang29@zte.com.cn
Date: Tue, 27 Dec 2022 08:47:05 +0100
Message-ID: <2298026.kkTNVCUfUN@daneel.sf-tec.de>
In-Reply-To: <202212261840048448622@zte.com.cn>
References: <202212261840048448622@zte.com.cn>

Am Montag, 26. Dezember 2022, 11:40:04 CET schrieb yang.yang29@zte.com.cn:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
> change for v2
>  - sizeof(in) is better and simplified, thanks for Helge Deller.
> ---
>  drivers/parisc/pdc_stable.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
> index d6af5726ddf3..d3075445260b 100644
> --- a/drivers/parisc/pdc_stable.c
> +++ b/drivers/parisc/pdc_stable.c
> @@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry *entry,
> const char *buf, size_t coun
> 
>  	/* We'll use a local copy of buf */
>  	count = min_t(size_t, count, sizeof(in)-1);
> -	strncpy(in, buf, count);
> -	in[count] = '\0';
> +	strscpy(in, buf, sizeof(in));

What is "count" now needed for? Looks like a write only variable at least in 
these hunks.

Eike
--nextPart2316597.IaFIOm8ydW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCY6qi+QAKCRBcpIk+abn8
TreFAJsGRGXqTM4D8ib9NJdGgqNbpJTmUgCeNNVn9q3szniJshUbN+h2L4zJ5sI=
=oo7x
-----END PGP SIGNATURE-----

--nextPart2316597.IaFIOm8ydW--



