Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B4625F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiKKQCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiKKQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:02:21 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E848760;
        Fri, 11 Nov 2022 08:02:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bj12so13426584ejb.13;
        Fri, 11 Nov 2022 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tGIRLfxoAILWi/6ryjLTwkDXu9Pm1eaKIZFSWqym/M=;
        b=XIvKyDSLoDVLFd8ux0DUgm+AXjQtcAq4Ty4ZRYkmxYnSrwgctpSItOLp43i1D8TOQC
         V5I4Iy1lTv/Gz465tmrk1iTkkevi6XrH1/ozsARqN4Fhz+38qG80m2whE4MtAIA+rvbd
         Rmh2LGR0XifAuX7OWa95e6yzmjjacgh5VcCApLTVqMoGhl0O6M3E8BwJJlge/bUM4bFa
         ldt29HMMbtfz80MIqvFWyQ2FBRKVL3INo9nw+dkMGpA6W5e7VT3TRGWAN4a/+opu9OKP
         DfCw590ddeE52iAhcU3WzDIsj448Xx2HHTXZj/wOxR07jN/hzEqGslKArvWaHpqY+b7i
         8fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tGIRLfxoAILWi/6ryjLTwkDXu9Pm1eaKIZFSWqym/M=;
        b=DpjzsIIWsVvpX0t9knwh857pEYkH7nQlHuhptW+2xILVwvSkRPIRjxIIF5CnuebPaS
         zjpNt+PTuZ6WR6OEjgNTLUYmFcziWzTh0a+/3QSwRMVUuqR8rgjX1KzMm834PfkjCJ0E
         GlHAx+mnK/pEANoTQJo/maAvGAl43ChqPnq3CT7eujJosC48/tc/T0vGiOHk+Rffp4cb
         xEVs27/GSBtlK1QdiIVW1gGp273JuZ7u9PG4W+rSpzpsF3Lh9uc6eDjPtdY4J1YB+iXz
         HlVW+8LtznetSNT73SY/q3R1OzZ9RD5ELHzMgoWobyKMhKnjqRz9DMS/4xKO5RODkDhG
         4Egg==
X-Gm-Message-State: ANoB5plp9qe4Ird2dX/mQ3QTF48A5T1GRrzEoTrsJxEANWPZo/ycAF2M
        gLlYiMJJG8Iism0CJY/ADXk=
X-Google-Smtp-Source: AA0mqf4KSb4BDmX14/WhzvbNRQ5ALv2iVBg34t8A2HAlXC1UHqo5WZrn+HWZI/QaPO4PDeAC+w1p6g==
X-Received: by 2002:a17:906:e0d4:b0:7ad:d1ab:2431 with SMTP id gl20-20020a170906e0d400b007add1ab2431mr2258412ejb.213.1668182539314;
        Fri, 11 Nov 2022 08:02:19 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906300300b0079800b8173asm989635ejz.158.2022.11.11.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:02:18 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:02:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 3/7] gpio: tegra186: Add Tegra234 hte support
Message-ID: <Y25yCAzDBMtZtave@orome>
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-4-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ea7abbhrcCN1PRGS"
Content-Disposition: inline
In-Reply-To: <20221103174523.29592-4-dipenp@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ea7abbhrcCN1PRGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 10:45:19AM -0700, Dipen Patel wrote:
> To enable timestamp support for the Tegra234, has_gte variable needs
> to be set true.
>=20
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--ea7abbhrcCN1PRGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNucggACgkQ3SOs138+
s6F2UxAAsaR46zSPAHB9mgaKOGM6kXjc5h/Zt/0lXTYAUqSv73d7hKlnhJAj3Nbx
mn9hagAjFqd2nRrNbAOnGxCptFYxaQLXA3KdBRm1mrY2xMGkT8CZDXquz4t1KQne
oGnurLbJ7NOwEqVUDnFw9h6Kmw7l8FOEQt7UsepkSBIOIlF6Irf8mfhIdCcmjh7u
TDlKS6g3/jewfZ21fPctK0wcTJkoVa1wIR0yCKp9uTwv7cEahxOJGt65KYFfl8k5
259QMgctJb1y1UQApygwlRJFzAkzyXHlVqt2qEeQSOy2Ty95guzY9+VfwqSEjamr
daLVN03ztczJVc8s/VrB/2AQb9gImOAVdd5SSubfp2LUB7QLR7F2bpqJTVEHwf+j
fgniJGERCV6u7p+V3b3W3qBBbhPbhDDUyK2v6gIKh7RYQZqEQk4O0to4QxNZFRK6
1ZVQQTylguw62fuibAleqDR5QYfvzgHiQUm3Z4h3BxAoTGsD40cPjNGMy1VPb4KL
HH/5SxL43irWjDdyyvxcMH/KqXik08mGblMUCMnyHeaftUya9T+31mdcVRN0ASnn
rRcLzPpRaRRY2IH8f6uqHBZkrprhEWUww0C61Je2Tfzi6rVU2LuBVJdU/N+t/B+8
/AJ4oCq0xXoe8d6gecKSjeK048QYMvYpQRHZmERR4nILE9bz04A=
=Z3ui
-----END PGP SIGNATURE-----

--ea7abbhrcCN1PRGS--
