Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274CD6CBD29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC1LLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjC1LK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:10:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02F8A62;
        Tue, 28 Mar 2023 04:10:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i5so48236197eda.0;
        Tue, 28 Mar 2023 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680001780;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uibwFF2TVvqiHQK5fdq7Y5W42YgDAbkfIpArXeup5wU=;
        b=GvosVofuIrNwAdPotbsCdwsUbkzugW8o8T4mpk/gBOlMSMfQ1N+O5zBy4vpji2VKd6
         YGQerXOIhGkQO3kcHKf7Kb238ycUOOq/dQWuAQza7nIsvXqw6raSNWVgTOFkABjg7Mbr
         PhJCo5ymWBHVIv2GgFjwQjIjbgyV5jmxHU6zP7PN2GgiOwKqjbh7mmmU1wIdgxGa1jcg
         nKqwUbwzSBqMD+uZMsfO7NAZ4H1a8dYChG8Z7SLR4N2ii9kY1qpq/diqg0KPvaWQrH2p
         qWsyQi1RxRZCHwK+sQ5+CZttAjj5cn6Gwd0+eDKVXMFOKb4qur3DphoXuxCV8pCttdcB
         Ry5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680001780;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uibwFF2TVvqiHQK5fdq7Y5W42YgDAbkfIpArXeup5wU=;
        b=MYwN774+r1Dr7xuJVGNvS9a+LFq9qCw4Ix/5A7hBcceonN/kGUby4AyGbmE75JrqUB
         rJLVYLYQ7Cp21qs02LVF0YXF7CQZx0En1sJ5wXveSrI1M/kVigS4gINYJtEHkBmnuCQe
         0WxXkeLn3/cauePAJR1b52HObIZ0MnLYWYSeTRG9uTU+4WouGwR7REWWL9hBGOW0S9jH
         NZ/aGFKIi/oHba+x0iylK14Ah+yufBy8w7UUgZClop3IbTEa01xfMMHDUVeHLLkrPxKR
         hjo/fSKWt0m+BYrf+JSvO+KZugSMkXAeX8YKtLnaswz6enA1ZVp4WUFeNnB6vYCV5Hir
         +pAg==
X-Gm-Message-State: AAQBX9fsHNM06+k7K0+Sy2BQ+/bjJ4DAInyhBe3upn1TFhQC3s/IPD/d
        tedBvqHDKvVFAzWIkkiuEUE=
X-Google-Smtp-Source: AKy350YoKtupGYJy02TQY9KyZjq77AewZQXmmmqeAPBbMAQ5AZCvoRndWAXn6zZu9khw6NtD7NiuIA==
X-Received: by 2002:a17:906:3701:b0:886:221b:44e5 with SMTP id d1-20020a170906370100b00886221b44e5mr14200567ejc.62.1680001779643;
        Tue, 28 Mar 2023 04:09:39 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hy14-20020a1709068a6e00b009351546fb54sm11566185ejc.28.2023.03.28.04.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:09:39 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:09:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Drop unneeded quotes
Message-ID: <ZCLK8TN8dp8LJsQI@orome>
References: <20230327170146.4104556-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="25Alk08cwWa0SAB7"
Content-Disposition: inline
In-Reply-To: <20230327170146.4104556-1-robh@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25Alk08cwWa0SAB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 12:01:45PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml        | 2 +-
>  Documentation/devicetree/bindings/timer/cdns,ttc.yaml         | 2 +-
>  .../devicetree/bindings/timer/intel,ixp4xx-timer.yaml         | 4 ++--
>  .../devicetree/bindings/timer/nvidia,tegra-timer.yaml         | 4 ++--
>  .../devicetree/bindings/timer/nvidia,tegra186-timer.yaml      | 4 ++--
>  Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml   | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--25Alk08cwWa0SAB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQiyvEACgkQ3SOs138+
s6HWXxAAl7iEzTN8cHtB4Rscf4jSFuHl8zMQdSYdB1cBcWeCmCbFhKCNvzIsWotb
HU79w3Uko7gZfFNr44eYYTf4YsZI8aIXlAGzE9zPVATGTAUcnw6GfNY5siUVW+SD
xENVkMf6K7vBTrp/Sl1IIPVDL+yfLvNIQCqADS/Xbv/E8AIl5vG6aKxCR3omKTQr
enV+opxIbbADUhAQGKPerTF71+xdKFruRjYycmolPXX0QKfXRPv3oamD79zlmoxw
mtVCr5E47EpVlRg7dc92HPzZwnqIyY+haNf/HmxaV9sQ4fOGBN7ZWVafav0bOuF0
bsatDC6WLgMhjbg0AvxoCTpSzQT+ziB14moHGfJWKqNzzqOkGRJtjaZZyVGr3DXr
lpsdgX3E+aiJExbESc8pT4EMs4cyBhn7W8yaBVILgMQ7B9twGe6UR+hChqqMKx3q
s2TBOUWq+WnaZcZwBuyZKdgTKos5crlffbJaAh28uI2WTJ/GzPpvZZ/2rNyweXHb
ypSQNHmHW8aU2YTFbKineicLjoMwyE0jXhvD6/Nog95qr8YQdxf7z3XYuF9Abqfm
j0LUnLOcw5hYvhPN/93ZwR+KT9KhgpQTr94K5yoY1nNnAr++bqgWGILeEBsCEN5w
kNTtR4j+ykgmKmTval7FiiWN6NevZKlWlDJadZVUNSKfm0hZ2sA=
=Fy2B
-----END PGP SIGNATURE-----

--25Alk08cwWa0SAB7--
