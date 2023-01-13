Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E586696FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbjAMM3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjAMM2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:28:53 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B273E2E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:26:59 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198]) by mx-outbound12-28.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Jan 2023 12:26:57 +0000
Received: by mail-lj1-f198.google.com with SMTP id x32-20020a2ea9a0000000b0027b52e5e56cso5540997ljq.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDFsrgP+UTMw5z9pb449CNH7n7E9Y9IltvGCSddi/5w=;
        b=EO8NxMX88fPbExgxNk6XuqUKwkuFa0Is3uIrvbBK4TxldK6GS1BrF6qmi4QSaOSt35
         Txh5Y6k5QpjRJJdX6CoA3OhdhtsPiab+lNQ3vTkIYpjZKfPpu+HQvKx3uqy/v8RsnKge
         7WZRyv+cUrBJAbl19B0XTfmVjHq4FbdHvfv6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDFsrgP+UTMw5z9pb449CNH7n7E9Y9IltvGCSddi/5w=;
        b=Hs5VbRf+D4/sNWHeaqgZ18FX2HS0Eu7kxDv3tx6Su0QCKC1chQ20kT5uCp9zbPtx4a
         zB5R6mNH3tTdIwtPFJ0lIEO6SeGnyPOAHb+8qbo4dttO7N4JOLmlvkWNb2TVCf3vyATv
         EgQsjln4fdE1KnjxJru1b+3OLB8fpPrE00hKqn49Lm4ZvnTV7EUVvaTZ61teZn15ildb
         vof3rIucctEDQDtT0yC5Os0yK+foWM66D1NHU6BMBCxj75GUQ5Bi99R1Mo6KsQsU9OCI
         7LE1mh1IeX2ruAM+VtETI9RXpzYAZOkVBV7PUlrpabMyS2G2S9k5+3Tvglo3V4OgmgSO
         pkeQ==
X-Gm-Message-State: AFqh2krW9WiBgWgQgQO1W6NYY9sVajZFCU44QBztg2dn+SicWBRJh5Ly
        22ZELipAgC+9MgDWpsj3q0zTujQD4KMj+YPj+Eid5otK5g0jRdSwy4I4EKdO0io432mQl34uJJ0
        M98o8+QDCkHX0Bs3LE6LtPVrWZF3EXImnDr5+/RqtTXoIBT6it5g4acmrAOC3Q1GmsjdmYp06CU
        XZ
X-Received: by 2002:ac2:4e09:0:b0:4b7:2a7:1242 with SMTP id e9-20020ac24e09000000b004b702a71242mr3684400lfr.44.1673612816405;
        Fri, 13 Jan 2023 04:26:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtlhhvz/AEGbD+d5MQLbG9BJLg5Esd0lxrUsJGS0B/TWsuMp7nNxthAKToaDTWJaGkXXprtGb8nhKLAx0f2MxU=
X-Received: by 2002:ac2:4e09:0:b0:4b7:2a7:1242 with SMTP id
 e9-20020ac24e09000000b004b702a71242mr3684399lfr.44.1673612816118; Fri, 13 Jan
 2023 04:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20230110110052.14851-1-sinthu.raja@ti.com> <20230110110052.14851-3-sinthu.raja@ti.com>
 <d109dbf8-ba51-7322-34e7-f688c5a18908@ti.com>
In-Reply-To: <d109dbf8-ba51-7322-34e7-f688c5a18908@ti.com>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Fri, 13 Jan 2023 17:56:44 +0530
Message-ID: <CAEd-yTQ9eEz_Q6ncNP3vc9oerqiXfhrGK7DvsAnm21OZzYUe2w@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 2/3] arm64: dts: ti: Add initial support for
 AM68 SK System on Module
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BESS-ID: 1673612817-303100-5448-10899-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.208.198
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245438 [from 
        cloudscan16-215.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 5:24 PM Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> Hi Sinthu,
>
> On 10/01/23 16:30, Sinthu Raja wrote:
> > From: Sinthu Raja <sinthu.raja@ti.com>
> >
> > AM68 Starter Kit (SK) is a low cost, small form factor board designed
> > for TI=E2=80=99s AM68 SoC. TI=E2=80=99s AM68 SoC comprises of dual core=
 A72, high
> > performance vision accelerators, hardware accelerators, latest C71x
> > DSP, high bandwidth real-time IPs for capture and display. The SoC is
> > power optimized to provide best in class performance for industrial
> > applications.
> >
> >     AM68 SK supports the following interfaces:
> >       * 16 GB LPDDR4 RAM
> >       * x1 Gigabit Ethernet interface
> >       * x1 USB 3.1 Type-C port
> >       * x2 USB 3.1 Type-A ports
> >       * x1 PCIe M.2 M Key
> >       * 512 Mbit OSPI flash
> >       * x2 CSI2 Camera interface (RPi and TI Camera connector)
> >       * 40-pin Raspberry Pi GPIO header
> >
> > SK's System on Module (SoM) contains the SoC and DDR.
> > Therefore, add DT node for the SOC and DDR on the SoM.
> >
> > Schematics: https://www.ti.com/lit/zip/SPRR463
> > TRM: http://www.ti.com/lit/pdf/spruj28
> >
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > ---
> >
> > Changes in V3:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Addressed review comments
> >  - Removed the unused nodes that are disabled by default.
> > OSPI support will be added once the OSPI node is enabled for J721s2/AM6=
8 in main DTSI.
> >
> > Changes in V2:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Address review comments
> >  - drop the empty lines.
> >
> > V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-3-sin=
thu.raja@ti.com/
> > V2: https://lore.kernel.org/lkml/20221107123852.8063-3-sinthu.raja@ti.c=
om/
> >
> >  arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 31 ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/bo=
ot/dts/ti/k3-am68-sk-som.dtsi
> > new file mode 100644
> > index 000000000000..c35f81edee8c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.=
com/
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "k3-j721s2.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +     memory@80000000 {
> > +             device_type =3D "memory";
> > +             /* 16 GB RAM */
> > +             reg =3D <0x00 0x80000000 0x00 0x80000000>,
> > +                   <0x08 0x80000000 0x03 0x80000000>;
> > +     };
> > +
> > +     /* Reserving memory regions still pending */
>
> Is this comment needed?
>
> > +     reserved_memory: reserved-memory {
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +
> > +             secure_ddr: optee@9e800000 {
> > +                     reg =3D <0x00 0x9e800000 0x00 0x01800000>;
> > +                     alignment =3D <0x1000>;
>
> Is alignment needed here?
This is used to mention the address boundary. Removing this will
affect memory allocation. Isn't so?
>
>
> Please see https://lore.kernel.org/lkml/cd5dbbb0-2d9f-8d7d-b051-f8d01d710=
c62@ti.com/
>
> > +                     no-map;
> > +             };
> > +     };
> > +};
>
> --
> Regards,
> Vaishnav



--=20
With Regards
Sinthu Raja
