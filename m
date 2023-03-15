Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C16BB5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjCOOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjCOOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:18:02 -0400
X-Greylist: delayed 1386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 07:17:55 PDT
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A254E39B92
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:17:55 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71]) by mx-outbound18-193.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 15 Mar 2023 14:17:53 +0000
Received: by mail-ed1-f71.google.com with SMTP id i42-20020a0564020f2a00b004fd23c238beso11117455eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678889873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtDnCZh4EzHEMb/EfbyOFogrbL5+iaRwEv2S7+7Vv5I=;
        b=PdiRPHOsY6zJm58ccIUXvdpDpg4QQw+wCCdabdb0zmPyhXiISbICgQ99b1aBfpLogr
         OCYWQ8aQWh61UDNf4L1I9VMrOuVjFHAaCCNKOUtXFCsHas3kPvse43694qYUjdQXP0Ci
         i3cX4EqZkmb0VgBhcry2Kk9FYuNOhA518dqOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtDnCZh4EzHEMb/EfbyOFogrbL5+iaRwEv2S7+7Vv5I=;
        b=NV0NOGwOhRx/tyyRWVoiF4mIKW+13wYQ4oqiV2rqHeLIbRE719INrQ6H1A84arS5Uz
         G5n170TSNhEHIVfK+/Xu7Jgxd+5m2ixW2DJ1x1qnOA7Q6MsXbL6JVLMhk8VKjLm14HfS
         hKYvETlFaijE7H3nkKKPgK6NaFgjdFEWGg0/IBMtAqFqp4AXKLJNB305c7fSYPvOrU2a
         5f0XSTMdBX6xGhOjraIoygVsjstoCbcIpHbUcsvXAVzeCRR4CXBF1C06LsOJdB2pq+fH
         Vh4GPCF4plo4nGjm4uKkRW0iliT9e2vnS5lB6QV6CWRUCqsgRAPolDDokv9dgUxf/vRg
         tJhw==
X-Gm-Message-State: AO0yUKVOKcRVTKcS2NLDKvNb3chRWYDpxNbSuRyJBdHeK87FZNFq++GU
        NmvLmfvK5Xz/vdCEW+z5ZCAC0wPItvd9uNGrpCOLJ3V5kSbti07a/Z64PJgZ5Z4/8Bxe/7NBIwT
        JrJgGERDOkjLdLCSRu/5qHaiY9/eWb8etFIM4MBZ6QIOADLpSu9Iz+o8BvaBRY5XE6IUJyGdifS
        CQ
X-Received: by 2002:ac2:5977:0:b0:4db:1ceb:dc38 with SMTP id h23-20020ac25977000000b004db1cebdc38mr1980289lfp.9.1678888487049;
        Wed, 15 Mar 2023 06:54:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set9IH8D280aEoocF/A7gXgQbTaixQ+IuO2Hq+LIITinB2Z3WM1lPZzlJQ8Oi5IzqiFLxAnBOBmi1Wg80q1n6vN4=
X-Received: by 2002:ac2:5977:0:b0:4db:1ceb:dc38 with SMTP id
 h23-20020ac25977000000b004db1cebdc38mr1980279lfp.9.1678888486724; Wed, 15 Mar
 2023 06:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230315120934.16954-1-sinthu.raja@ti.com> <20230315134656.bt3mczw73h3z2j57@privacy>
In-Reply-To: <20230315134656.bt3mczw73h3z2j57@privacy>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Wed, 15 Mar 2023 19:24:33 +0530
Message-ID: <CAEd-yTQV2k=-W3LXYgq-4jrLCtR_ncij8UAPWWfd4xsJzGU2tg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Update IO EXP GPIO
 lines for Rev E2
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BESS-ID: 1678889873-304801-5459-24085-1
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.208.71
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmFpZAVgZQMDnZyCIl0cAgyS
        LJyDjNwszU3DjZ0tTMKNEi2Sw5ydhIqTYWAGBiANRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246814 [from 
        cloudscan23-152.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 7:17=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:
>
> On 17:39-20230315, Sinthu Raja wrote:
> > From: Sinthu Raja <sinthu.raja@ti.com>
> >
> > Rev E2 of the AM68 SK baseboard has updated the GPIO IO expander pins
> > functionality. To match the Rev E2 schematics, update existing IO expan=
der
> > GPIO line names and the corresponding node which uses the expansion(exp=
1)
> > node.
> >
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > ---
> >
> > Schematics Ref: https://www.ti.com/lit/zip/sprr463
>
> Looking at https://www.ti.com/tool/SK-AM68 looks like E1 never hit
> production, is that correct?
Yes, E1 didn't hit production.
>
> Does this need a "Fixes" tag?
It is a migration from E1 to E2 so I assume that a Fixes tag is not require=
d.

Regards
Sinthu Raja
>
> >
> >  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/ar=
m64/boot/dts/ti/k3-am68-sk-base-board.dts
> > index 2091cd2431fb..27a43a8ecffd 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> > @@ -60,7 +60,7 @@ vdd_mmc1: regulator-sd {
> >               regulator-boot-on;
> >               enable-active-high;
> >               vin-supply =3D <&vsys_3v3>;
> > -             gpio =3D <&exp1 10 GPIO_ACTIVE_HIGH>;
> > +             gpio =3D <&exp1 8 GPIO_ACTIVE_HIGH>;
> >       };
> >
> >       vdd_sd_dv: regulator-tlv71033 {
> > @@ -264,12 +264,10 @@ exp1: gpio@21 {
> >               reg =3D <0x21>;
> >               gpio-controller;
> >               #gpio-cells =3D <2>;
> > -             gpio-line-names =3D "CSI_VIO_SEL", "CSI_SEL_FPC_EXPn", "H=
DMI_PDn",
> > -                                     "HDMI_LS_OE", "DP0_3V3 _EN", "BOA=
RDID_EEPROM_WP",
> > -                                     "CAN_STB", " ", "GPIO_uSD_PWR_EN"=
, "eDP_ENABLE",
> > -                                     "IO_EXP_PCIe1_M.2_RTSz", "IO_EXP_=
MCU_RGMII_RSTz",
> > -                                     "IO_EXP_CSI2_EXP_RSTz", " ", "CSI=
0_B_GPIO1",
> > -                                     "CSI1_B_GPIO1";
> > +             gpio-line-names =3D " ", " ", " ", " ", " ",
> > +                               "BOARDID_EEPROM_WP", "CAN_STB", " ",
> > +                               "GPIO_uSD_PWR_EN", " ", "IO_EXP_PCIe1_M=
.2_RTSz",
> > +                               "IO_EXP_MCU_RGMII_RST#", " ", " ", " ",=
 " ";
> >       };
> >  };
> >
> > --
> > 2.36.1
> >
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D



--=20
With Regards
Sinthu Raja
