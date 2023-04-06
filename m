Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC34E6D987E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbjDFNpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbjDFNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:45:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DAF6EAF;
        Thu,  6 Apr 2023 06:45:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j22so1531884ejv.1;
        Thu, 06 Apr 2023 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680788720;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWxbTxHDU4JcHcqIFGeE5B91rGmVuRWUbY39VK5Io2I=;
        b=I3wPE9fF6ZQvwNt9wFEazeEQhvhd95Td/wzX9oOkgczXc6Zpic0WpzlmuS4PFXYHVc
         Nm2QIvafX0Y4osc6+a4d4+QaMX/iff5y7K8vEtHOmxHtreEQRHzV7y8LzdSkXETnpotL
         LoubqQZoUdju3N9i1moKCGrj9wAgCRW6yapdFIqrPjuBM6aMN1ipgzeXmdP80uY9ApqQ
         tx0amO7DIch7vlJFu30H1Cb08QlBZYiQbC36b3zg9/xQgV12ASiUdmgJD4jnw9RLaCVL
         r6sqlHloP3eo4hlIfcxVSqLfsg+AS1wbTccpxOksyePCinaiCKZaRPTUvwA5/NZ/I5uO
         27CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788720;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWxbTxHDU4JcHcqIFGeE5B91rGmVuRWUbY39VK5Io2I=;
        b=AV0oQJ4/9a7rT1pVw7/7OUDKnKcQWZDsFtZy1U14RpiXR962E1XUUofdvi5LnLy8ik
         m5XeQNE4OKJWBNSN0Kf7k3IGR52IJTAZNd+03/E/6mbd6NzQGkWRJjJXhPg/DL5YQSU+
         nIKefT4vou3N0YHgtkR4mTQVBeUtPumsFg6T1KuRG42bFSsw2lVecZxWfzfBek0JwiAD
         EoA4IiVKtEH7aOzsMSiSF6wrDXoGuOprZ0H+NLfxrwZ2M0z0+wegWdtC3PAsSXIHUS5U
         xC5VgiisrdVcA+E8VqEYeykHoMvzJJWM3nUI21WflpXnIb9iCEMc4p86uJaLvaXMMTYO
         xxIQ==
X-Gm-Message-State: AAQBX9cFGArNj5kt9phXUKUEBXdBdYWHrbjan2UyX1L08W1/xM1G87NM
        YFMkP7HgmTTdDcMYBb6oX7sz1QhOf+s=
X-Google-Smtp-Source: AKy350Zj176tWLpdtEztAu2yD1vTtRpDl6FObu/nSiFFfdgiZ43AZGdmoNkStWa8HKEzgAHBcdayGg==
X-Received: by 2002:a17:906:9441:b0:92b:7e6a:bca0 with SMTP id z1-20020a170906944100b0092b7e6abca0mr7077798ejx.14.1680788720378;
        Thu, 06 Apr 2023 06:45:20 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906a20d00b008d044ede804sm826535ejy.163.2023.04.06.06.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:45:19 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:45:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] pwm: rcar: drop of_match_ptr for ID table
Message-ID: <ZC7M7rpyEQaI4YJJ@orome>
References: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qzk1RDxBtReFCSbK"
Content-Disposition: inline
In-Reply-To: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
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


--qzk1RDxBtReFCSbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2023 at 02:51:19PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
>=20
>   drivers/pwm/pwm-rcar.c:252:34: error: =E2=80=98rcar_pwm_of_table=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Changes since v1:
> 1. Extend commit msg.
> ---
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied both patches with an updated commit message clarifying the
exact configuration as pointed out by Uwe.

Thanks,
Thierry

--qzk1RDxBtReFCSbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQuzO4ACgkQ3SOs138+
s6Hudw//cWhnAimBrk1LA2VSwkIOTdBerLAIkizxv+nAArOFPffpfRnvvgECr6CF
W3g9chFQMrZbwrzsni42K8ru2dtugvNutPnefJqJgMB0qIviPcSLCxBgcwj6eZjM
ABf0gqnGeaIBMWn+fh9fjViV37QS3x7vSN8lecIY3fqcs5GHp3chptFSG7f+QPMJ
IwFPM+kxiSqBsyUd2Hg1HsCFv2pHilg4ZSHhN5NdyOM9VAELHgCTinSFrvSPbtQJ
xAWqMIVeQf1m2s1La6Xuj/KwTJ0gtD9NlpPpe4nkickMr08+TAJmcGWSlTiQ56Di
lBGS1FJ7XKwBt5Ksfo44//WgXI09C4rqV+2AGS6A0cdhWNZpANhk0zpt7TshcI0T
mYywBxlzx1x2r150DmADbas6bVmaU1mqoATNQhJwE1t7Uo8s0BSXOqFAu/98Tos7
L/3GLKF/7NuwgTE0C8mj3bgRsR7/o+KlXkUM1dvVEM6cBtsUgkX7AgSVAj2gWVbQ
rE+uiosENCxe756ODJLnqHgmw2hsIn5tGN4ebxl0kp+RCTzDVcfQjtmMbO1zJCVT
W+wFrGT7VLM2uaZ5q1M2uHmWKGzGRgxWGBhAXBll9UoMBa5UPV6lSNLSnwLxLgTn
nxZJ1TmDJfGUW1oTgvoarFDfUvAaaGu4O3KFnynPo0iybuembO0=
=TBNW
-----END PGP SIGNATURE-----

--qzk1RDxBtReFCSbK--
