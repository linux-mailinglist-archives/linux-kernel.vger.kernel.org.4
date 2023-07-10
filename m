Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FE74D739
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGJNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:16:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0807BB;
        Mon, 10 Jul 2023 06:16:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso6483467e87.1;
        Mon, 10 Jul 2023 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688995007; x=1691587007;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5GqN4zHZ7sVr+Rkj7hPCd7AvnhbMJXPabgQ821enKM=;
        b=njaB++BxIGfwGEEMVUfuIFlHWz1wfSeDZVMHke/vyiuksHuKdk7fCcsSpaUUT1X1B/
         cWO5qLeTbs9V1iTLva+Ws5hPDM+gMvhW9W1sHM+wsAYlReP1lulufjt6UG0n1YTOaHpQ
         YqKpuBaFqPBJxujHl6Nz6TryTL8y0neD1ZpwxU+6bG8sP0AmXg1uPIur59HGwr0bBHk+
         bleqr5Qg+ibaONi76hsqcW+H3z85+kCD9gBPAjt/lRUGom323XAJkhWmveYIaLbfcAFw
         1J35co/Eaocba/ighLTd2upuo47p360NuuFB6XgnJ5ZKNV3SdUyaNhVcl7JlxbEqrcXn
         WpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995007; x=1691587007;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5GqN4zHZ7sVr+Rkj7hPCd7AvnhbMJXPabgQ821enKM=;
        b=VPoVYm/XDX+uWf//pSSzUza61HnrxIR06cZlaF4S1iaARsjqxqIiXIqwqWOo2cv0n8
         TmYMVnlVWsQ0Rq5KwwVtAsNy0C6cp3IbehYUMdH7gJ/t7L3tkatnmPaARPfJ09epGcu9
         WpNlrbo+vkSnMg3svF+Rj/hPuHgitltd3/QIeRvIDFLOeHoifkG1EmJvwQ40Nrwm/KvF
         SLw/+XEhMll5BCY2RyiuGxLgsjpq9Y9E5yoelpi1hrZ9ojGGOw9w9OQZquMyuIccNIv6
         9guPs9Pbu98rclrp/xP9hU7wmQNPwbg8Bg+pLiu3LvkWPi/+MDCXGbAgnD8H90y2gB4h
         2yeQ==
X-Gm-Message-State: ABy/qLYMEI6TNLvVrNouJRDAG/gJXgNZaoZ+kDdsqEU+mhhGGZkXunL7
        +jHDdaaBuAV3bbnPuslrs6w=
X-Google-Smtp-Source: APBJJlEeGGiO7Snf+Fnq7YXLff7DVQ4xFrb7LcjYermR5SHIXwl5FrKuGpSZCDOxkuqT50xsVK+bSw==
X-Received: by 2002:a05:6512:551:b0:4fb:7559:aea3 with SMTP id h17-20020a056512055100b004fb7559aea3mr9507796lfl.39.1688995006649;
        Mon, 10 Jul 2023 06:16:46 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090617d400b009829d2e892csm6241461eje.15.2023.07.10.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:16:46 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:16:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/21] thermal/drivers/tegra: convert to use
 devm_request*_irq_probe()
Message-ID: <ZKwEvJR5tYVsC0HM@orome>
References: <20230710095926.15614-1-frank.li@vivo.com>
 <20230710095926.15614-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="th+TRJ0H9nCr/rwD"
Content-Disposition: inline
In-Reply-To: <20230710095926.15614-5-frank.li@vivo.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--th+TRJ0H9nCr/rwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 05:59:09PM +0800, Yangtao Li wrote:
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
>=20
> And tglx point out that:
>=20
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>=20
>      519 messages total (there are probably more)
>=20
>      352 unique messages
>=20
>      323 unique messages after lower casing
>=20
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
>=20
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
>=20
>      The most useful one of all is: "could request wakeup irq: %d"
>=20
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
>=20
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
>=20
> So convert to use devm_request*_irq_probe() API, which ensure that all
> error handling branches print error information.
>=20
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.

Do we really need to keep repeating this same commit message for each
and everyone of these commits? It's already in the cover letter and
presumably on the patch that introduces the new helper, so surely we can
come up with a denser version for individual subsystem patches.

Other than that this looks good:

Acked-by: Thierry Reding <treding@nvidia.com>

--th+TRJ0H9nCr/rwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSsBLwACgkQ3SOs138+
s6HXABAAjvoOmTWpBG/OvtzxxCxThQCLPbvGV4rC/l0dEuQqqJWc5/4l8BuJHZEx
RM28LGiMupozR9yL6SNErs/r3OkjeVM2mv+La5HtO/ukcjQlrjHA/VPhA+q5BF5t
D3SUxtywPNwtHGUutEt5QCR/2reZks32DIZQx6hG+DAz1sIUd2JNtgDR/CAci3J0
w6x/vevGYXqYlftphXfGG0pL8bncYz2v6dzJIjY5f4GGiBREJs38MaHjaSqNT+uv
uxUNLL97FwGmSprBgDk2/gWMPiZQXH1kIB8/jx+lWXyX6PVS9f49emBC0grSPdUK
gIeW4dVwQkiSfg+TJDiHNNfrC71jeUuAluQr83C3JBRq6AnBXd/YvsFL9JYAfn2q
iAGvFECNjDDvAMogcgLJw2LIbYhNrT9RjRQGHAymoYSMA3KqhItFrAp3BQrnlOT2
opV3E9ZGPYn6QtL/lVgdTY8if2JuOLXOGwP7okvYmzXzMuX2AkVHJk58FK6MbytC
5PfjvzQ373Yy8+q+dfGYw7fF9n8jiTCOB7oUNIihJpPSo2twCA6g9dmB9sPewf6x
t12R76CLTzp/lwCTKMi7VPg9cW0EygXXgYs35+03Hon3xjM+GgKqH79BE29672b0
v62y68umxB+crKZZ5T1YPsMQmL1fAUYTl+LSweiXUYlsHEbiEHQ=
=i8B+
-----END PGP SIGNATURE-----

--th+TRJ0H9nCr/rwD--
