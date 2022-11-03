Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB54617BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKCLuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKCLuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:50:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722731261B;
        Thu,  3 Nov 2022 04:50:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so4401279ejb.13;
        Thu, 03 Nov 2022 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keJ5l0jb4yVbNlSnZAlwlDsuTe9ejUBhSqY4hGrZAt0=;
        b=PQ4YP2wRUJxZdyyz6zZSZj+OjTKLdQbjnJkxjyIB0AC5p9wCBSenX4q6mmPCPucfLz
         gDMwV3i1aFqKEh5YPlxigWY1bvKvPlUXkwPnhWHjwjjye79ZdICdVxB4Zftj9DJEytlN
         q771MkVQ5MXnmIadjxvf8TbGbFXv8VQhRZ8edPRJDeMOyNH8tg6R2p1oCo9eABQy6QoU
         GuOc+ZylXDYkX5N9L2qZ4YrABRwVE2lPD5u2XqB6c6dFDVgqLx6hIV5K3nyY6D5+4D+e
         8VUcEhsp7ptRiQ4ShGElO1mjJ8Pk6zCV0A+EtDhi/6TUIGuafFpfUciZ1WTb7yraBE/2
         s2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keJ5l0jb4yVbNlSnZAlwlDsuTe9ejUBhSqY4hGrZAt0=;
        b=YJEo8tCrwnjUBgzVnKKLTnrEd5t27/6G1186HPE8erzDfve4wMqZB2yKu5x+roNlTA
         qeZBGnzZXDGypLy4MHL16iWmq9yUvd0NhG6n6U8pDvqEHaH4GEvUgtNNFsNZgVhJOQfn
         OjW5CJ5eMApB68MicKnjncPvOyh11NCnEFmNQv/1rW7rUOA9D7zvSGxKFwij16oZV3+l
         U13E3L0/Ypj7nvY7vnMoe2sl4TKS0o7FXHZp9iyG4auHD6XCE8dgNHVgnZu74FV4a1Ci
         B7hXvzuJYoakBNABSiF3zpcuCAb+1KoLducaLe14lULj+1p7Z5fO9k54Wf63DmZ0fJ5k
         6uMQ==
X-Gm-Message-State: ACrzQf2MR0Uzu9yA1smcc8KjSuHytRN0lMx1XcYCS8JBni54ols91701
        GdnIa8c3YtaVTxqSr0yQqi0=
X-Google-Smtp-Source: AMsMyM4Q2CWz7BX9ZdLC6MF66A9EF7pbiXpl8t0scbNUjX7cAVd2Z79MgxCmVq5bwXHVpkFCAbco8Q==
X-Received: by 2002:a17:906:7119:b0:7ad:fc15:24be with SMTP id x25-20020a170906711900b007adfc1524bemr9395473ejj.199.1667476248950;
        Thu, 03 Nov 2022 04:50:48 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b0078d4e39d87esm378334ejh.225.2022.11.03.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:50:47 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:50:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v5 2/3] arm64: tegra: Add PWM controllers on Tegra234
Message-ID: <Y2OrFj8sLbzaFCgE@orome>
References: <20220919141455.31084-1-spatra@nvidia.com>
 <20220919141455.31084-2-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Aw3zPKjSVKby1eZq"
Content-Disposition: inline
In-Reply-To: <20220919141455.31084-2-spatra@nvidia.com>
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


--Aw3zPKjSVKby1eZq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2022 at 07:44:54PM +0530, Sandipan Patra wrote:
> Tegra234 has eight single-channel PWM controllers, one of them in the
> AON block.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> V4->V5: Update compatable with Tegra234 and fallback
>=20
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 88 +++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 2 deletions(-)

I've merged this with Jon's changes that also added these.

Thanks,
Thierry

--Aw3zPKjSVKby1eZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNjqxYACgkQ3SOs138+
s6GV1xAAgnvX4bDU3E6GnC3hIepbicVjUN+ipYXeyeC2gAbc1KwfHoa4hoQkBo5f
Lma1kyaPrh0gBNblea7DuwQNNqnHsWg5UY+FRLsWDifSCs3f488FXKQKOCbDgVDB
zJR/zGIiLKuwS0Evmvsno9n4r8bBJ6qlmpGPtTcqsUkCG2jYvqEifePnCllk2Xcu
jgHaqgSS2u1iZ40UFouOYj1XKjXcmAO0n9+OH3aYxdY9CU2KlSpJExtBFkHpDZGY
XNoDyr/h+Y2Thp3lNmpIjS1U50drOU2CeY+KBPOUBj66sqbVWLPffwDXH1l6xsak
po0WiyfLIuEo98qzyIt7L4haAGMKt9HnuRa47Jo3XkJq8ULoITDQKvmW1FteH0xx
sm2J5SFJ9bglLbv55GZtgbwROl9GM2K6Z4v3KWBVzVtGljhPZiPpjLjqUrrGapii
LdKqqFwjf6SjRuKJsX5MSjRLiPcvPttcCNEqnpAANKcC4RI73mPl31DF0YkTmz8W
oawg3pc8OJzz9sDc2ZSuc18zkzNpfmdmya6V5dqh62a23sP+CIwbn4lbeYmwGElW
28u8gJa5EO6TEVxvBwcAKGdICRYg9AVwpoSbwqiSkZ0/btQ6sINkf3ojT13CDKkC
hJCrD+TrqVtBJnKJjrbjjtAXdJZzj33tQVnyVty2QO2GUNay1wU=
=/9V0
-----END PGP SIGNATURE-----

--Aw3zPKjSVKby1eZq--
