Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AB708D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjESBq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjESBqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:46:25 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5476E72
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:46:24 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so502823276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684460784; x=1687052784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRnoeSreGadiB9OVFL5oCBNcNTPO+fzcoPwxWhqIGcg=;
        b=m/EKtTwTMCvRUghPbTZ0aLtHJy5wYPNjmfShebx8gh0Ah746OQAyDiF/KhBP9nBO5q
         /TOeepsJT2xGTdCeohn7tT6Am1m2UH65mH27EiAkOnWDaaPXvAFAwbc2BSZoYPXwVDwN
         60ps19MyNd0Snmvlzz7WaOtShYk5Yvvtfe0PI6cY5GGVSaoFE+wlmWfO7wWmpa4a/1Rv
         rLpJDopWLH8dDlg+DWF2BV8LP/we5EcBvYQ7u4BRd3LR9B5uYk3LTJvYb2XA+y1FF5Xg
         SrOcDqxyEZ2Jh/yExanCmbqP7ksD96dvYEVTtN+1AajtZp7mf8t79xaadD6A7S66YEvF
         upSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460784; x=1687052784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRnoeSreGadiB9OVFL5oCBNcNTPO+fzcoPwxWhqIGcg=;
        b=ZM0NHr/WAO9RX274luNV//bV1YQ4psesUt0vflUF1/JgWs/d0fH5P6wya9bGpU11Zl
         7BIyFQ4VkDQAuuHh1y8FOkmBUUb5jzTQGo4/47fZDfD211A4xEgPz6q1TQ1hjCcDXV0+
         Czv3llUTc/ygdyGjRPbpWuwUvt5WCFrPdmc14bmNmRV5DPY8uvxUkn21whBzhPCEK8In
         1/oMNBeoZ6LE7+d8op2qXFU1hbZXdOAj7CyYKrCUiHbOM5kG5+hWrPQo3lmHq6cO34bk
         R1TG0l5Cvrz+GQ+8+FO/DwSvSPP8AQAz5n7aMJS3go3KQl71oGGADQDK4kS5qQs9JPg+
         F2Hg==
X-Gm-Message-State: AC+VfDxbjZUnebXEfX1nxHKt68/dqEt8+laj4Z/m/2lRP5MO9qyQA8Qp
        1INzWUhdWugqyu/DbPW1cBia3w==
X-Google-Smtp-Source: ACHHUZ5esT/785s6QhSuTQVf2a5lnrzyIuiXiyyvpytcpb/6xWEtPZjGg8NzuB3lqxsqrT87kZ4kdw==
X-Received: by 2002:a25:b123:0:b0:ba7:46b3:5c91 with SMTP id g35-20020a25b123000000b00ba746b35c91mr270954ybj.2.1684460783920;
        Thu, 18 May 2023 18:46:23 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id w33-20020a25ac21000000b00b9b1d09ed18sm728200ybi.33.2023.05.18.18.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:46:23 -0700 (PDT)
Date:   Thu, 18 May 2023 21:46:21 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Vladislav Efanov <VEfanov@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rene Herman <rene.herman@keyaccess.nl>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] isa: Remove unnecessary checks
Message-ID: <ZGbU7YQgzGelwiGy@fedora>
References: <20230517125025.434005-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4EKlEO7L5rYoZBuz"
Content-Disposition: inline
In-Reply-To: <20230517125025.434005-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4EKlEO7L5rYoZBuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 03:50:25PM +0300, Vladislav Efanov wrote:
> The isa_dev->dev.platform_data is initialized with incoming
> parameter isa_driver. After it isa_dev->dev.platform_data is
> checked for NULL, but incoming parameter isa_driver is not
> NULL since it is dereferenced many times before this check.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: a5117ba7da37 ("[PATCH] Driver model: add ISA bus")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>

I don't think the Fixes line is needed because this is removing a
superfluous check rather than fixing a bug. Regardless, here's my Ack
for Greg as the patch itself makes sense.

Acked-by: William Breathitt Gray <william.gray@linaro.org>

> ---
>  drivers/base/isa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/base/isa.c b/drivers/base/isa.c
> index 55e3ee2da98f..675ad3139224 100644
> --- a/drivers/base/isa.c
> +++ b/drivers/base/isa.c
> @@ -149,11 +149,8 @@ int isa_register_driver(struct isa_driver *isa_drive=
r, unsigned int ndev)
>  			break;
>  		}
> =20
> -		if (isa_dev->dev.platform_data) {
> -			isa_dev->next =3D isa_driver->devices;
> -			isa_driver->devices =3D &isa_dev->dev;
> -		} else
> -			device_unregister(&isa_dev->dev);
> +		isa_dev->next =3D isa_driver->devices;
> +		isa_driver->devices =3D &isa_dev->dev;
>  	}
> =20
>  	if (!error && !isa_driver->devices)
> --=20
> 2.34.1
>=20

--4EKlEO7L5rYoZBuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZGbU7QAKCRC1SFbKvhIj
Ky5IAQCiRVaj1Srg0+u3ajag42dujk+UQQsqAb8BYYJven/kHgEA7+pycPHYjXw5
xwWzhVadqLfbQJpdO29ogoYxQUtbnQ4=
=kz4u
-----END PGP SIGNATURE-----

--4EKlEO7L5rYoZBuz--
