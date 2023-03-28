Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C623E6CBD28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjC1LLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1LLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:11:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2337EF4;
        Tue, 28 Mar 2023 04:10:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so47945651edb.11;
        Tue, 28 Mar 2023 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680001805;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqEGA/PVlkpD6lMY00yK5KcTXjBdf4WVKzOjNGzT69A=;
        b=Za4nhhU2n/LaXF+t2YotkPnu+NyY8Xip/3kJfVYjPQ6RG4+i4shkEmFmGgHWmDTzEx
         JhdHO6GFhn5D0ti+JffqejPR36acF+DQVYxktw6ToJ3i78B2kpL5ZTNbKNDRbZ5nAjJ8
         I8PxhpcRNwMg14/oST/fqb1F4vPISKpqHYkLATff1IbovfgUYhOuSsdpFER5dkzde680
         HdZp7jn7e3g2MPW0Vj+IgyEpb2tZ0zewmEMyThvTsnvu5KwjrcvDeyq0aMzxtPZObGuj
         Z8RCar5UipiGvJv3vvwejSeG+7A8dAaZf4152Fh9OxmhAoTF3TuB13UvhB8Q2V+94Nd1
         DC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680001805;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqEGA/PVlkpD6lMY00yK5KcTXjBdf4WVKzOjNGzT69A=;
        b=w3NBvXqHaGYFDsC1uhQQwMtnLbgYtgNo1aWkERZ+lP32xN4GqVGUUkmzp3UWKdOmPx
         M292FOmCwsHmhI/Hv5PiLDDA27iH4YIgQUVyIijYYXtnai7D2rV4rdQYYO6v8ebnsKcs
         IQuM7tGpp7wP6R8O3pXpXv1YFrWqczDNvmDUzPB5IHn5eBXrCXHgsJCsO9N/3PiE8Rm5
         JTuo3MCRmAUbrBNDucOgGPnTTFof4kB5SFfZVqmmlMYOjxlqa2fe/XFAOA6vldNIUrRm
         8jQTew237l0uVOsWwh/zdUndnZ32fh3Z0NYv+4PCxoSyRIGP/xbouRCHYVjPEw7V2zP4
         0Riw==
X-Gm-Message-State: AAQBX9fVph079BSskTCVS9QfczlddX2piSyMtZryptAnX24nE6+MH/pV
        AW6rlmWwqcI3332GZFr6ZWk2qYA0lWU=
X-Google-Smtp-Source: AKy350by/WzznotcNdLCPk32xB8jkKa8s/NjWqnewG7g9DrMII4tbqIPzccEI/2QF5hpFmK6v3WZ0w==
X-Received: by 2002:a17:907:8687:b0:933:499e:62a7 with SMTP id qa7-20020a170907868700b00933499e62a7mr19219394ejc.49.1680001804719;
        Tue, 28 Mar 2023 04:10:04 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090673cb00b0093dbb008281sm6298104ejl.130.2023.03.28.04.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:10:04 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:10:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reserved-memory: Drop unneeded quotes
Message-ID: <ZCLLCgf2vu/onaVx@orome>
References: <20230327170122.4103518-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0C9V4Pcm7Atj+UGF"
Content-Disposition: inline
In-Reply-To: <20230327170122.4103518-1-robh@kernel.org>
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


--0C9V4Pcm7Atj+UGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 12:01:22PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/reserved-memory/google,open-dice.yaml          | 2 +-
>  .../bindings/reserved-memory/nvidia,tegra210-emc-table.yaml | 2 +-
>  .../devicetree/bindings/reserved-memory/phram.yaml          | 4 ++--
>  .../devicetree/bindings/reserved-memory/qcom,cmd-db.yaml    | 6 +++---
>  .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml | 6 +++---
>  .../devicetree/bindings/reserved-memory/ramoops.yaml        | 6 +++---
>  .../bindings/reserved-memory/shared-dma-pool.yaml           | 2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--0C9V4Pcm7Atj+UGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQiywoACgkQ3SOs138+
s6FoRQ//Rag4t1FA8erganl5Xcov2bvBsR5Uxs5luGhpYFMaUCnACe7myjUD07c6
piccCNYu55wFjdilmlLfmv0pXsDRqI9bcMgsa40cHWyaDdwUIzUR4ypO4z/Eft0Y
PRsu1rc5U+aYZgvw2GC1oGTfv3XJA9vXGyK0Z0DilS8D1aIX5NOaX7k7cxZQcRFY
0jQHMpbtMOA91GSWTI4X3LhvlXv63h9aZx3gM9UahxQ4cZPGh5hopfgOYZlfnA6B
3jzf/Ay0H8O1e7sBcirauCocL196bV34KitD99pu49xXL06iOZXhsrWr8kfpSG0p
tfkjbe/imGsipAk8BmnPnAy85qDczQyFmmRbbC7IdQYFZQUhgceElmkzcfERBv2X
OE5aYuLJ2FdYCVsMHfeqSs3piKtTpL7HLXtL634oewp8XhMCAqnQiRHodX9Gz/AO
cg47I+KOKkB0dsBUcVHhaGngFHzq3GYTOno+eWyWgaK5dcOLMqYLc1VUfEhD2tKu
TI+pOMGDQMuSL2TTjfgHNX05eeV3F1bq+OU8DJRCg9KrBb0KiDRo3+qZSl49qRwy
UourEgxjK3rVFdsW93nwgHC4nuljmbq8rS5qZLFsHcgcjWRsLWA10hweD/H1byJR
sayBQ1HlBXWNoLw5xVIntpo1t6GXF2Cu1KrAqgSEGkOOkeiN6vE=
=Czzs
-----END PGP SIGNATURE-----

--0C9V4Pcm7Atj+UGF--
