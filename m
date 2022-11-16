Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296A62B580
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiKPIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiKPIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:47:57 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0891192A1;
        Wed, 16 Nov 2022 00:47:56 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z26so16866750pff.1;
        Wed, 16 Nov 2022 00:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8bxFFOTwAuVXsEjTKys7ZF36ry2UF1nmF7gmPiaf9o=;
        b=cswWX4fVf+OYUo4g2DPif2BNP9U1p/zKsMBGouJImvNtg9sdnhCAv45pOnRUIpznDB
         fqmSa4dhOanbi4To6od+FvWYGgxL1LJ515+jBvpYzw/+8qpZuYO44qeSkMjH4eS8Dazy
         cU3t7ppwiqr3lZ/rs0SK2cMsp2BAp9wP2W5Xb+4jbVWJHOITSsjJQ6Mve0wl9CaRx1C9
         bHpj/Fy21aVwvj3epbjTALL1CTL8Wec8xvbdKKTp2iVyWX81kmP73JCSI//PJAk+Dr0M
         6fz3Wwnp4tZOw5G0bQ6bSlwyW5HN+iJc/0WwaLKCndak7wSbH6IaJvJkhIw8fjPA8ntp
         +Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8bxFFOTwAuVXsEjTKys7ZF36ry2UF1nmF7gmPiaf9o=;
        b=Qy9/MgIia6itBbn5F/IBhwEO8HQNK0g4npKxs1XqcUOQyj3pnQWhx0Uj5YpSDzpjxC
         j2i9g35EZY2CT2Y43g77IOV5LegqcfKMumml66QyvmSuK4xoUNJ03ujWqC+6+BlS1Wv3
         higu92YWzklt+ORn2woWYn2Q63/izuMFCVXCJMq4XGQP2mnrmORQeG3lybcOxwhVkR49
         KCtMMKDc7ysSVA3xsm6G6/MXvKCQVXMqu9MOiot+jlFEntAJjbNZ8bpw5FLEtg46u1ls
         1hMG2AmvwrWp1k7x3wtuW1Bkvt9ZwltZI2nOwVzSTN267mSoGZ4Aqfnwb1vF8BQC1EBH
         BlzQ==
X-Gm-Message-State: ANoB5pkrizCfVHRUHEpZ5F8lSO4TESM0ZELDdzIDbBQxuLLiEpwVODo6
        FpmcseZyh+z+HXOsdKA9M8Q=
X-Google-Smtp-Source: AA0mqf5KolT+bzCO7+iur+0PeUF6229A02uPI0FAOcLd0+RPSIFBvapn+NMe4maSWGkH6dyQtMU5bQ==
X-Received: by 2002:a63:181e:0:b0:470:f0c:96da with SMTP id y30-20020a63181e000000b004700f0c96damr19053000pgl.544.1668588476021;
        Wed, 16 Nov 2022 00:47:56 -0800 (PST)
Received: from debian.me (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b00185507b5ef8sm11589693plg.50.2022.11.16.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 00:47:55 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9C007103FF6; Wed, 16 Nov 2022 15:47:52 +0700 (WIB)
Date:   Wed, 16 Nov 2022 15:47:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        John Garry <john.garry@huawei.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Chris Healy <cphealy@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amzon.com>
Subject: Re: [PATCH v10 1/2] perf/amlogic: Add support for Amlogic meson G12
 SoC DDR PMU driver
Message-ID: <Y3SjuC6xHn1uz2zX@debian.me>
References: <20221116003133.1049346-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rd8PJiydnsGM+b5x"
Content-Disposition: inline
In-Reply-To: <20221116003133.1049346-1-jiucheng.xu@amlogic.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rd8PJiydnsGM+b5x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 08:31:32AM +0800, Jiucheng Xu wrote:
> This patch adds support Amlogic meson G12 series SoC
> DDR bandwidth PMU driver framework and interfaces.
>=20
> The PMU not only can monitor the total DDR bandwidth,
> but also the bandwidth which is from individual IP module.
>=20

Please write the patch description in imperative mood (no "This patch/commit
does foo" but "Do foo" instead).

What about this description below?

```
Add support for Amlogic Meson G12 Series SOC - DDR bandwidth PMU driver
framework and interfaces. The PMU can not only monitor the total DDR
bandwidth, but also individual IP module bandwidth.
```

> Example usage:
>=20
>  $ perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
>=20
> - or -
>=20
>  $ perf stat -a -e \
>    meson_ddr_bw/total_rw_bytes/,\
>    meson_ddr_bw/chan_1_rw_bytes,arm=3D1/ -I 1000 \
>    sleep 10
>=20
> g12 SoC support 4 channels to monitor DDR bandwidth
> simultaneously. Each channel can monitor up to 4 IP modules
> simultaneously.
>=20
> For Instance, If you want to get the sum of DDR bandwidth
> from CPU, GPU, USB3.0 and VDEC. You can use the following
> command parameters to display.
>=20
>  $ perf stat -a -e \
>    meson_ddr_bw/chan_2_rw_bytes,arm=3D1,gpu=3D1,usb3_0=3D1,nna=3D1/ -I 10=
00 \
>    sleep 10
>=20
> Other events are supported, and advertised via perf list.

The demo example should have been outside the patch description, though
(more appropriate documentation as in patch [2/2]).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rd8PJiydnsGM+b5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3SjsgAKCRD2uYlJVVFO
o+XjAQDRA87SSby3+T5aH+WfpuopGJByRRFMiYzJCseiyFilngEAmlWqahhkpQR8
76Yig+rYcpJSwsnPILG8mXd9eIiXGAM=
=CPHZ
-----END PGP SIGNATURE-----

--rd8PJiydnsGM+b5x--
