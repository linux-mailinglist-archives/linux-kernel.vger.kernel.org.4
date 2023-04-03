Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F46D448B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjDCMgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjDCMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:36:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF583;
        Mon,  3 Apr 2023 05:36:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so116734069edd.5;
        Mon, 03 Apr 2023 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680525393;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI8z72ys9h7213jm8p1zrgDacfSUNl6g9XbEXB4wrlI=;
        b=MQjLEdhjuKT+lGjIRKmxaKu4KuHKHlBGeP2wARXS+CrWlTYiICeROVrOrOCOx1G/ef
         Lt4t89Fj3AS7bdi7Y578v4/h0nspKd44HpbMCfJCdbFzr9jgnGotrVjOl5fJcUuia2qz
         9QqSRtVxtg32GWWjuUVlPBiJCT9M4q8ml6wgkPzffn6sF+Qiu73APmLsP5c7uIS03kib
         qdoeCr8kZwWRsv0kclOj5GcnzA8HboHxI6AIGefOFaKFWSMjK+pbrsvDg2/EhTX9sS6C
         HqCN0BAyCp5rlaIF6+fmjNr5LonAk0d6owaUOfnHUpDEC8ev+wHzkV5ZkPpHFjwsga1X
         4Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525393;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI8z72ys9h7213jm8p1zrgDacfSUNl6g9XbEXB4wrlI=;
        b=3Rj41Ds5YSXFbkLW7nQ0ThZteOA1ysqdlKgKXtODkKB+ISlxQDbQR+5sLNF/g5rpWF
         bP1oJnh2gpRoXSl1cJq1yq4njKQbb2BjABa+H4aUfE5GXTaVW1Wbz80DLcA+7Nmvp5jc
         LL544S0e4a7RMiKP6XQY767ELkMw+AZkf5E6M7HwqLQuwkiRUNAz7bC3uW9mlAI+bi+Y
         NPcKDTG0Sg3BetXS9rb/moZ2GZwpIdukJZ5rgA8jb+i+qhsNJtyrzELSpwVQ5p3s+BLO
         Md37ICrZKr5FaPmcOJ37ApdKJ4XiG+ZQ3uH3tHt6P3UQTXzXzmXMwEyBJgb4/+RjT9+Q
         Tuiw==
X-Gm-Message-State: AAQBX9cExaG4W80+ZCLMzcHxSL7B61O9ce295F0uqmgF3n7a08IIvvx7
        2WQFCH4KdGqSIQo+7qCss5jCh9IjWNw=
X-Google-Smtp-Source: AKy350aNaCdCQMP8OiC6dLC+L3XK5X8QMbP0o414svnCma1txj1E/+7yKLhsCmY5hXu60n5rTyzYbw==
X-Received: by 2002:a17:906:cf89:b0:87b:d3f3:dcf3 with SMTP id um9-20020a170906cf8900b0087bd3f3dcf3mr35421385ejb.35.1680525392919;
        Mon, 03 Apr 2023 05:36:32 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bt23-20020a170906b15700b009477a173744sm4496269ejb.38.2023.04.03.05.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:36:32 -0700 (PDT)
Date:   Mon, 3 Apr 2023 14:36:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     jonathanh@nvidia.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viswanath L <viswanathl@nvidia.com>
Subject: Re: [PATCH v2] soc/tegra: pmc: Support software wake-up for SPE
Message-ID: <ZCrITl9ZSPsawOpm@orome>
References: <20230330170621.258068-1-petlozup@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H4q6Deodu/0Ekunc"
Content-Disposition: inline
In-Reply-To: <20230330170621.258068-1-petlozup@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H4q6Deodu/0Ekunc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 05:06:21PM +0000, Petlozu Pravareshwar wrote:
> The Sensor Processing Engine(SPE) can trigger a software wake-up of
> the device. To support this wake-up for the SPE, set SR_CAPTURE_EN
> bit in WAKE_AOWAKE_CNTRL register associated with the wake-up for
> the SPE. This SR capturing logic is expected to be enabled for wakes
> with short pulse signalling requirements.
>=20
> Signed-off-by: Viswanath L <viswanathl@nvidia.com>
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
> v1->v2:
> * Rebase the change on latest code.
> ---
>  drivers/soc/tegra/pmc.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--H4q6Deodu/0Ekunc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQqyE4ACgkQ3SOs138+
s6E7hg//YszA7cR4dHtbCofh/mlp2CATRSom55hnsqEZUN/LSwswlD24/hIbkrEH
kqoIkwpYoT5Nb+qIMxVa8jQOnTz/0Wfw3kTm2ofGXesuBddcY08fgCM1FPUhNXfM
jAkzpK8C01r5+dA3TQdJNOyO3Cy/AujB308zlM/RsIqOZaArkaQaW0/X/IxFWV5l
lkTewoj0ixETW5s0FRKMn4dYupyLYAc6Emjc5xu6rJ2dLxgujrwaZCVVdlBOqvzC
lvMf+cgNwlJaFlGD/lR93gBE76EJs7vqMLummebvCZ5dfzhyeRtqIoPHswF52al7
we7aT+0VdPcEIwRjCroqeUIiklScACnABYtBjvcknIbLhhvM5WkyQOCtN8DbfqkD
2GG4n33K0xoCo/ugXOXzlONx08UMswM4tZr9DpnQxoDI1m6GS/okfA9ZZX9kwmFs
THe8BmXapxRrA4zfNHDRtJtbokse0ImQzM3mOWFXsk0PRwF10Daxcym4ubynuABD
QvBJHtbDtxZmnyi+z8OlmyEkpO9I9e3JyDM5gmqF0+UFOxJk43oZuyeKJozKXPLv
5rpjtgH00FEtYEIbTXpjGJg7L7hxWCIMReZfrDckB5GCQiQuA1hW02P740S0K+aS
/HnWBYSD125NqdJRz2CMWe2jEJqAEfw+2O4DBbEFNACi3bPPkr4=
=89E5
-----END PGP SIGNATURE-----

--H4q6Deodu/0Ekunc--
