Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C9621633
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiKHOYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiKHOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:23:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211E5B86D;
        Tue,  8 Nov 2022 06:23:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f27so39048163eje.1;
        Tue, 08 Nov 2022 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZnCIJm+9B9Ff3S7OWyd9EMrH+oJEijKOQtTrhJPK+s=;
        b=agAlO/bMjNZS419ehoNlmwo2Y3uNQo3ftrHa5OJ/v85dpmTW2ZHHGQiC/d2IInAH6Q
         bXsfqUjpx6U4PYhKzxvNAGWYqVfyxrpZmgeCp4vXJXchbebK4Z8r9eRU2Lbyh7zP+9zB
         OPgKlTmoMsW0FhFtUQX9eFr+L8Wutp/3Z6x4bOXxO41O/02ThSKw04jJZ9HxbXDgiiaw
         f9LCjvKZ+1HEX5fU9JcsPdqZ1ue6P3KqOfqU4UEb9hhiXtw98Z5puryOztK7QlP/ievA
         NQY3vq9hsbYWxf1oNyy4TwscGpGG4mOTgSH5IJnZxRGOHdRKEkValcr9dgsbQBJoH7SC
         3dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZnCIJm+9B9Ff3S7OWyd9EMrH+oJEijKOQtTrhJPK+s=;
        b=PO0T+aTsbCjYQ+a2Jg/iK2nES9Kr5IUp7mEhLYRZpyUwC6K4RibzJJqzlgdBkRHqHA
         nAzX9+GJ9Q4CNC4U9VaeMu5PtqVmc50p1KxqRO/pkc56SXabQ26NnUel3nrqR8EuZMDI
         VNQwGPEG/oCeU/9/vSy/HaBGmFN2hjhlWXGC371koCgIScatFze71pmWlXX5JYG+J3YN
         JkH3FWFrWl44WgMjsK4nCDM02cvd4ot6lmlqqfYD1NeJnwY4jMCrzJEy7MvJTdzdKROd
         RaJXkwB9nXAeP+WJhf2U3N9TLeA6IFOom0fATQKJvA1f1WmKQH7F7oH9u4KluFyGM+bA
         pSrQ==
X-Gm-Message-State: ACrzQf02z6gC8rI7aXJaG/mhwXHN0Y/QKsWma7ssSG6bGGV7+G2gjPaV
        GQRAp220zXNtlWvigrq+rMA=
X-Google-Smtp-Source: AMsMyM7a+rXh6egmJgCV4yYsRFUfXuNmozOuHYPfp6VM6AmrwLU5W5iyiq4aYfT7oDW/qdMpn2to/A==
X-Received: by 2002:a17:907:a46:b0:782:1c1c:8141 with SMTP id be6-20020a1709070a4600b007821c1c8141mr54460080ejc.549.1667917380673;
        Tue, 08 Nov 2022 06:23:00 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090676cf00b007ad94422cf6sm4635674ejn.198.2022.11.08.06.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:22:59 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:22:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tegra: Fix spelling mistake "fliter" -> "filter"
Message-ID: <Y2pmQdxMIHl+vgIj@orome>
References: <20221108111340.115387-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pDY6F3p4Kn966Zak"
Content-Disposition: inline
In-Reply-To: <20221108111340.115387-1-colin.i.king@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pDY6F3p4Kn966Zak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 11:13:40AM +0000, Colin Ian King wrote:
> There is a spelling mistake in struct member fliter_structure.
> Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  sound/soc/tegra/tegra210_mbdrc.c | 4 ++--
>  sound/soc/tegra/tegra210_mbdrc.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

I sometimes wonder how these come to be since it's an obvious typo yet
people manage to make them at least twice. Auto-completion I suspect
might play a role. Anyway, good catch:

Acked-by: Thierry Reding <treding@nvidia.com>

--pDY6F3p4Kn966Zak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNqZj8ACgkQ3SOs138+
s6FbTw/+L/QE+HdaK/OuuLEzlBM6VWk+gYNy4BeBG5uOqysNd6MzrfjIEG9WS5lE
SKcmYwhnYhBHcXtfvuDM31AwDkfEFSr+p35hzIRnGbUa/MZLxj3ufZad17adgfng
xgjH0L7b3zYsX3+z29syehbF524PKApyURWbnQZNnKfLTmC1vagfOvcEvu5Zq7kz
B4rFKeDjiSkJGcf5JtDh0D1/oFCTkzOgoC03N59AFWt42lHpGHNenZMQghMnvlrw
t4mF03BhREWdSzB2LWpywH237eqtaG1+Ro2gEik9UR32bEO8V4Yb1occYpwilAxm
wKO1uVryVoSgh5DLmzcifM5sWh1IS4QrORdGBXXnC4p5CDuS85Or0NQaou+t/TEa
2Iqyovc8k7+S2CkQXjX7rGROqaG64El59mGDP38IhOuNp3nMcxXLkftOEXxJaxkl
VSdzPmXysgm4hbPvXd6pdmAI6DOmAVYjy7ZgEt6xjVaHwGbjf96vAqPwA/tZtk2h
SFTpCQfgqPt6CRQh/aEC4pdJun9RUUkAWw8GSAz+dX5OBkEG2tRKFTOBDVTxoKM9
0zdxlQfn960VhHeF7Uus6PIgE9rliiN9uPWIHc95UlMkfC8Kqzj2ymAGxbfA90sJ
BheR4Zp0zo0CNTY3baq03zxEYC5/I1hufNFmUy3HhARuRKF/IIs=
=bwz6
-----END PGP SIGNATURE-----

--pDY6F3p4Kn966Zak--
