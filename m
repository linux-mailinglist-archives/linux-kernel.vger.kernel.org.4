Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D96D5D84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjDDKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjDDKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:30:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EE1984;
        Tue,  4 Apr 2023 03:30:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fi11so5073367edb.10;
        Tue, 04 Apr 2023 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680604240;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPQJYuYVqddrLpsUiSF4JuC6g9/L1+GNYqEeCmgaIpw=;
        b=Qf9ZiLsHWa67q5d6OwOb196jz2WhK7YOr7O9+et+VWP9XJTg4eS7ZGmo/pp76jWFPt
         4Kbtvtu5S3zMCsF9eVSA/S/YNXm5ggVhITb/Ngz7+umuz+DRrtYBdfzKTl3UrdN7NzWW
         O6IY8bxFhED+SxeYizHcRY3SwLERm5ZUtQuHN1aGTwiysQ10WcIUcldVRbRtkYiswHlM
         nTETOQuueRAEtt0TgKyZgsrozphoT+IYOtKCMD3aGLrr4m8j5PNzK6Je3J+NQ2mth/Tq
         N2V070Ic0y6tNpVzzPzhp6zx5ZpOQ5fxDFW2cAWXz/Wy2BIlRhwiAXRk4jwemb2Ozkk8
         aGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680604240;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPQJYuYVqddrLpsUiSF4JuC6g9/L1+GNYqEeCmgaIpw=;
        b=zQ1tRoSg6FxaZU0lOFZ4sUyIPj7ePKC1ZozNdO6A4huKHV0anGYR1SeT2sErIF7IF1
         zedL6i/mBHOX5YSQ8JofrQNNffD3R71Fu5+NYs6SrB41jOxyBwWPUMQtO0Q4780ZVK1b
         DPdVdTLpmgkk+fvoOZ1c0Pvdq8g3NyVixZowXB1uFIS2RbhVAIoblgbfckwH2y6qnJN3
         vY5NoFnERDL8Wu6kyBM3sgJnbChwDVfm41BU+xJgLcUetkV7hA/oOlLRN+TAmabBCrY0
         6QK4DqJOBc/iqC27tUrss1JQ3ZblDibK3hTftAtNrKGqSpmYBuF7D9SRJ0MJuHBDc5gz
         dDwg==
X-Gm-Message-State: AAQBX9cI7GJ26xqSwr5MtvdMs2yiAuOP2gmYb5Hpb81lRy6n31PlSyiO
        4ImPwaOKtSWworREaIjlBy4=
X-Google-Smtp-Source: AKy350br99HCbCDIQiZj8fwuuU0BjyJC/AwN7IrayX6NNSgMYELNtziysmKohGWt/IYRz9rEEj8/bQ==
X-Received: by 2002:a17:907:8b87:b0:8e1:12b6:a8fc with SMTP id tb7-20020a1709078b8700b008e112b6a8fcmr1480812ejc.4.1680604240440;
        Tue, 04 Apr 2023 03:30:40 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907207800b0093f822321fesm5737690ejb.137.2023.04.04.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:30:40 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:30:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
Message-ID: <ZCv8TviVD8n4MrnW@orome>
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <f523c155-7d05-2034-27ea-e2e56881c0bb@linaro.org>
 <a7539193-8374-cda6-f535-360a4a8eab22@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kKVfNtJEQjXZPd0A"
Content-Disposition: inline
In-Reply-To: <a7539193-8374-cda6-f535-360a4a8eab22@nvidia.com>
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


--kKVfNtJEQjXZPd0A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 09:58:19AM -0700, Dipen Patel wrote:
> On 3/25/23 4:07 AM, Krzysztof Kozlowski wrote:
> > On 23/03/2023 02:29, Dipen Patel wrote:
> >> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
> >> This is done to help below case.
> >>
> >> Without this property code would look like:
> >> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
> >> 	hte_dev->c =3D gpiochip_find("tegra194-gpio-aon",
> >> 				   tegra_get_gpiochip_from_name);
> >> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-ao=
n"))
> >> 	hte_dev->c =3D gpiochip_find("tegra234-gpio-aon",
> >> 				   tegra_get_gpiochip_from_name);
> >> else
> >> 	return -ENODEV;
> >>
> >> This means for every future addition of the compatible string, if else
> >> condition statements have to be expanded.
> >>
> >> With the property:
> >> gpio_ctrl =3D of_parse_phandle(dev->of_node, "nvidia,gpio-controller",=
 0);
> >> ....
> >> hte_dev->c =3D gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_nod=
e);
> >>
> >> This simplifies the code significantly. The introdunction of this
> >> property/binding does not break existing Tegra194 provider driver.
> >>
> >> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> >> ---
> >>  .../timestamp/nvidia,tegra194-hte.yaml        | 31 +++++++++++++++++--
> >>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra1=
94-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-h=
te.yaml
> >> index eafc33e9ae2e..841273a3d8ae 100644
> >> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.=
yaml
> >> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.=
yaml
> >> @@ -51,6 +51,12 @@ properties:
> >>        LIC instance has 11 slices and Tegra234 LIC has 17 slices.
> >>      enum: [3, 11, 17]
> >> =20
> >> +  nvidia,gpio-controller:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description:
> >> +      The phandle to AON gpio controller instance. This is required t=
o handle
> >> +      namespace conversion between GPIO and GTE.
> >> +
> >>    '#timestamp-cells':
> >>      description:
> >>        This represents number of line id arguments as specified by the
> >> @@ -65,22 +71,43 @@ required:
> >>    - interrupts
> >>    - "#timestamp-cells"
> >> =20
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - nvidia,tegra234-gte-aon
> >> +    then:
> >> +      required:
> >> +        - nvidia,gpio-controller
> >> +
> >>  additionalProperties: false
> >> =20
> >>  examples:
> >>    - |
> >>      tegra_hte_aon: timestamp@c1e0000 {
> >>                compatible =3D "nvidia,tegra194-gte-aon";
> >> -              reg =3D <0xc1e0000 0x10000>;
> >> +              reg =3D <0x0 0xc1e0000 0x0 0x10000>;
> >=20
> > This is not really explained in commit msg... are you sure you tested i=
t?
> I have to revert this part back in next patch as when I upgraded dtsschem=
a it gave me errors.

We need the 0x0 in the DTS files because we have #address-cells =3D <2>
and #size-tells =3D <2>. For the examples, those default to just 1 cell,
so this can't be an exact copy of what we have in the DTS files.

Please make sure to always validate the bindings and examples.

Thierry

--kKVfNtJEQjXZPd0A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQr/E4ACgkQ3SOs138+
s6F7gQ/8CahJlsl2ie2xWVwhWMmBeCbLyErqS+oUnJBDhaLFTHrhUBNeDB0htb3x
ZAUc3dZf+3ohXsFztk9DfVoH/3PTAxFftgN05tZHBCLXaBBoE/0uVQBVw2Q6VS7C
q6XkykkbDFUBOzL6sJLZE3ucFdPTjG5HFmMF+UJF8NfmBLUWJrZ60kK8h3MQrjYR
suT5Gr0EyOHy9nbtjDS3U05WW6Oyp4ppBTFWYuYbRIHgiZybCabVROR8NuCqqO5/
17kaQheYOsyCfHwmQhNx/yH6qn/byXK0eKI8N05S9f7iBqyvgDO69LF5SVR7wZtD
6i8DaiGS80EZtslyzEIcggM2WBklv0TO6tyRJWdsBjCoN+sFnRbTMOu/XFYvpqh5
Fjk+Qedb/KaGYdzD+HjREyKCz8rjRJxBj+NyjiUCo/hIlXm3kBH+XihmLsY/3ZNs
AjXxR25TIAq+yw42/gDfdx6/PzXwZtNmYq1ogpftsffj0rUTsv1v0Z5ScCWnKU15
sIqSTXUmGBRmHErHyxV/AcgwAqljPuBVKdidyM+8IceZGD6bd56iv/Ywc28cfhNO
cruSLxYVhvMJbMk2xX9ma8PWGAaOIkT+CTfQWC7YLMVMA8oMjPa74JQHKUlsrDb+
GlAEoulplmcv1mbesr5bkm4rMpB6tjsoTElagX7RVgOOS2CALEI=
=TMqU
-----END PGP SIGNATURE-----

--kKVfNtJEQjXZPd0A--
