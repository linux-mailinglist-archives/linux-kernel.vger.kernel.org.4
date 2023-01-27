Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28F367F0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjA0VsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjA0VsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:48:08 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02CD3608B;
        Fri, 27 Jan 2023 13:48:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR2OI5nB/Y/Ni8EZkNJmZbk+f5Vfqtex1Gp6MtQa186x91dhritHffynG7Gx4zu5nSzYEzlyn5Gu7SL+qvtwAAJwRQ/y6iPv6iqOekhSzIMqcDjuqM+FuisR2Zzmk2h0FcfyQ3WDdj8NAaZsuDd9WgPsO2pIwu8xEr7/AUdANxt7L//lIfXKAQeMUsdhCaX38YBA7PY20jWFB5EeD3rZHFoVj0QACzDu32MAG9Qf4TSEiiIi9vvcELEabl18VyUW+y+F7JDdEnGdIMLNwFja0WrDL/UL3+Ib+OEW2xq3tCY9842rlRjrCHdnL432RnkOW7oAJOXljOoXLTvbw1GH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ3Hn8kpRiF31OvBGg8qmVjLU3Wd54PgS26i/+EcaWM=;
 b=AI0WPaVuK6Lhazm0sMIVRdImAuwlchcgVYXvoJbQfb3U9zd4VGmMpT0WlSqiS1+03GP8G56NAnaKZqvDuJzPaALmvuFBFFKMEj9eF+FPaNZxBjknWmS+4jS8Pduj6t+zOzrm8eel214ThddmX+21PmNIXL+Xm9h3XHMqyoq9ET0IhESqLEaTqTwCFIdCj8SVyjtbgj0dXhwWHwm6HVUCdLGbIXm9ooerXzvRwuQhluxz78kyR6G2GThXHf0PpnjC6BrswGS2vykkBxAhpSDWQJaQ1eLbu8oNDjn0pbeX/aOoc0YVD4OxuNeRwg5o9fBUGV2G4Nmg9F8jW3Yrz0x+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ3Hn8kpRiF31OvBGg8qmVjLU3Wd54PgS26i/+EcaWM=;
 b=H+9mB3RFPj1xW4C/hqJZUbPfHmg5hP20v5zHnti9WlUQyfvuOky6lF8SNKVcI6RLyojJmL48ksEDXMU1Yvu2PWBQjKpG0f/rgCzp6zNPRAjZfbeEoZZhQ8PTxGJmpAgCWr3pRHqKxQ5srPHPQiyj1597rKvKJ/75Buyuu7fFRow=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8289.jpnprd01.prod.outlook.com (2603:1096:604:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 21:48:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6043.025; Fri, 27 Jan 2023
 21:48:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
Thread-Topic: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
Thread-Index: AQHZMnZx18nss4OApUidU5RRdrsm4a6ylwAggAAkXoCAAAxvoA==
Date:   Fri, 27 Jan 2023 21:48:04 +0000
Message-ID: <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com>
In-Reply-To: <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8289:EE_
x-ms-office365-filtering-correlation-id: 3c23b9ab-f585-4418-08b4-08db00b02b27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n0EIiBIzf830UiZstx/SnsodwRhNQIUfl/Dm7gkEIKqEFrd9xyFIPsEN+FH5b85K+KLwH4g0eMpUW3mVDbI6QDfjjRzkkz8qfrMD6XN7/uz1yEUcGtKkEBXZyldL3CGTmMcPZaIA8tOI5lz9xh1jR4oXMlVBGguog24xT8r+T+xTBacuzWIoj49TE/k9tEhqpqmVyWmOuRCcIzonxZZfDq2zdporp4S76VvKiFXfQSMQHBd/N8ZC/EabTz8YXpAt6Qorv3T2eBeYV59kjai16pjqFe52mOEX29acdibq0Jp7CEp522umA7jo8vYh9CS0h25VhzR09HxQ4wtuOF6TATDhYubOzFKKroNv8Cfg9eH+TdhPP5dMfJY32zpIOT8b/+HJxJuMEh6HXCWNfxsC0UmTJn8lz+wX0WnLsAqlLA0hNtVb/wgRxXifjA2LyWaLkDVBtRc5nWahA8tmhUe1q1ruDFPZQqFyl0xcEx5bcA7ycQqmgSuElTYdVMIpRXLh31ilaY5K/DsHRU8cIAWB/zW9ENtiRTwayIlUzrZUPUOP5abeW1/Zv+xV7QAIuJS4MmGNZHNrgaN2kf3cjYlqMFue55/HkiQBVkJE1SwNmVXlypSFF0VWCYpOiG/w55UuaZR23IZLLySg1pMWzL7Mw6AT/ike66qIMGjt6QcmaktgbZxNtp+oOc7VCbbECC04QxmjNPHiv6coC0bzbp3b5OXKNknfDmGUgwsyYZ6B8tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(7696005)(33656002)(8676002)(86362001)(71200400001)(38100700002)(55016003)(6506007)(54906003)(107886003)(316002)(52536014)(478600001)(5660300002)(53546011)(66446008)(66946007)(2906002)(76116006)(4326008)(966005)(66476007)(66556008)(6916009)(41300700001)(9686003)(64756008)(38070700005)(186003)(122000001)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOoQyjZ4ryGmWSUFb17tqz5EbMZARhIDwcf/jHsvOpQEIP9TJ0kSnd0+6kVQ?=
 =?us-ascii?Q?qZkU72DZPmX5nSjKVQbHvcNKqy9KFCh/d0lX+jZ+YiyECJFmDdrH/NmhDbpn?=
 =?us-ascii?Q?G6SEG1qYXVrNPFZWmlvk0HRQ00y4kH/E84f+MZDs2OVweBifPA5raO88+lhV?=
 =?us-ascii?Q?Xl2FeYY8xmGBcyIeIE2Gc8ZYEXJTMrORSJ+8ZCx0osxmTeBqNyO965JDnBLq?=
 =?us-ascii?Q?P5Jy4HjRCqrx2uCGk2vMlag7N8QbF158pJwsfNNNmpPkewoPn0CkWCi+d2zS?=
 =?us-ascii?Q?D0AhLI6ILHl1C/Wr/9u16Qmoz6s69csOKkqQzjOubP4PNd/VUylJYpi8WVkl?=
 =?us-ascii?Q?4CkmpCEMCeLu7BvdTW1LOo1Sq+IK3pwyFOiI7VVillwkQpG0/lq64ytcthIh?=
 =?us-ascii?Q?zGt6kvHaByz9JHpOW1gKZKMHZjcPYYDT1C33Z90faeObujOWaDzkw2noUk+b?=
 =?us-ascii?Q?uQzs9sxY/iaDTmJLLB0xQMatN6IRepS9jZAsKe9UJJN8zVjvQY7Lj877Za+/?=
 =?us-ascii?Q?UUF2r11oFLaXCEpIMvkMatF+7crAYFsXFxx4v1qIO5lU0z5wDoxIh3TZCPJj?=
 =?us-ascii?Q?X42/lV2sN0S1y2sTpIuQ9hPd0NS5bjPuS8qrY5u2wLucz7zEnwRgiRqOPhEW?=
 =?us-ascii?Q?VPMEyM8RIuBzMVgLTabTnQs+7Hbw88FHX4p8Sd6Jm5WVMgAVAD5Xr4yGZIXs?=
 =?us-ascii?Q?wawri5j4hr3LHsr3o1YKti5Y+LNE2ywLIIONA2uS570vcVUGuqkJPLveq5pJ?=
 =?us-ascii?Q?c3mSrtiJwNKgsDNEhNHu7bJDzHppyuYWY0PJ9x4c+7Vog+aoMOJaHuaEQyIp?=
 =?us-ascii?Q?5W/fCYfIINSD8VTKPIF1NDXcmhAis/661xnUSXkWUgwxoIkKWMObSWqf0sTJ?=
 =?us-ascii?Q?r7ukiHrPYJCdInUwyQuui6SRuE/a+PSDR5sV8qdHAVXcDhsKVf2cFU5ulKt0?=
 =?us-ascii?Q?28sinm2uXHgxn0gPgb18BGH9BJrY8zaTQu0TzVbf1ccdNWgW85PkRwXtYCzt?=
 =?us-ascii?Q?ihSypvsifyUTyzBTZqJpa6d6Kqyb/sIBB7QepN/bUZ86p3qPtcHfQSrBGVl5?=
 =?us-ascii?Q?WivrnVdaCnVzd6bHVhhBXCgLO9j7HAlXPfOK933+JHFbkCO0j3jC0Kf+W57a?=
 =?us-ascii?Q?XweHJV0Q25u38bC6c2i3cbti933qLtCg08BvD9tWeU9NqdnoLmJawprmkXht?=
 =?us-ascii?Q?XTeeoMuewzO4dGCbO8kzXFzqMi4grycCEpsDDKRhsv007NiW6UHr7J+PsY+P?=
 =?us-ascii?Q?DIbnGjMuMcEwNnfD/9LWZyTBjsKpcbyyKvg7To0MN4yxQP67vNaq9O4VVUoM?=
 =?us-ascii?Q?zk2r+Gb2db8aqeesFtsgRbw5QDW3G7eoYOycDbGiBT+rQyBn1vt/oqaLuuZF?=
 =?us-ascii?Q?rZ7jj2YH1Pt7gLIoHkMzwbNF/aSUhqArpUKNsOUp7W0E7LlMF0gbd+F3t73s?=
 =?us-ascii?Q?qkL7E906dEDON6F4EkvbRkGYNXz7N2V+8tXfDZbnFLcTgCBFOiFFK0Ai4Sna?=
 =?us-ascii?Q?h8a5jnwTby7w1A4VgvUOhKn6A9R3BXMCjMiXhQnSfvZL+VdGc+CZHRWl9tLp?=
 =?us-ascii?Q?cyVbt7yaFpUe7mZC+azVyQxBkTxcSeVXf6seNUQRBlLkUjaW47X8LPRI8sl5?=
 =?us-ascii?Q?Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c23b9ab-f585-4418-08b4-08db00b02b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 21:48:04.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObyZu7KEbUbAKHVS9QF8pWS1Py7TiSDVoFIqjznQQOrp04acRkm1xpa/boqrO/zZraoOST5ZwCiv7ppaOshRs3SUHehn25pKxpB6sBKY5Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8289
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,


> Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU n=
ode
>=20
> Hi Biju,
>=20
> Thank you for the review.
>=20
> On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wro=
te:
> >
> > Hi Prabhakar,
> >
> > Thanks for the patch.
> >
> > > Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU
> > > node
> > >
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Enable the performance monitor unit for the Cortex-A55 cores on the
> > > RZ/G2L
> > > (r9a07g044) SoC.
> > >
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > index 80b2332798d9..ff9bdc03a3ed 100644
> > > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > @@ -161,6 +161,11 @@ opp-50000000 {
> > >               };
> > >       };
> > >
> > > +     pmu_a55 {
> > > +             compatible =3D "arm,cortex-a55-pmu";
> > > +             interrupts-extended =3D <&gic GIC_PPI 7
> > > + IRQ_TYPE_LEVEL_HIGH>;
> >
> > Just a question, Is it tested?
> Yes this was tested with perf test
>=20
> > timer node[1] defines irq type as LOW, here it is high.
> You are right looking at the RZG2L_InterruptMapping_rev01.xlsx this shoul=
d
> be LOW. (I followed the SPI IRQS where all the LEVEL interrupts are HIGH)
>=20
> > Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)=
 as
> it has 2 cores??
> >
> No this is not required for example here [0] where it has 6 cores.

I may be wrong, That is the only example[1], where the A55 PMU per cpu inte=
rrupts and number of a55 cores in the DT=20
are not matching.

[1]
https://elixir.bootlin.com/linux/latest/B/ident/arm%2Ccortex-a55-pmu

Cheers,
Biju


