Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52874678FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjAXFeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAXFeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:34:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D10C104;
        Mon, 23 Jan 2023 21:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674538446; x=1706074446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eu9eSrxnFu9lIsTB56pm6Mo0L49dIaqEufzKpyTrfmw=;
  b=ojuMa6RQDjEPDz+FAgbgF82ppgoTw/CPARH7FZJyeQJD2waGt+q4af9O
   /O/GPvuHBIZolFCZ1HDG9h2XTBdrQqSbxoH8+8Q+vPNVpEoxtRrZH1kYG
   zXpfcXnmn++vwtV3oESotyqV75iws0lGycjqIJyTHTEN2EVKp2Z7npu9g
   WyHoZE7wkAjeF+v4f64St2EbU7RcLV2XXgIWHPmZGVNVKmEELpxRfe+2u
   4Dk+WpE6F8+JH+KyZf56eW5WbWlk5fpfbmyXbBHvtTJKsXcLe500V2MQ5
   vu2ddfYJZLZvYyYJeTp+RS+nu72xPyozXmMz62ohuMuvnDLyAxAzeyN7H
   w==;
X-IronPort-AV: E=Sophos;i="5.97,241,1669100400"; 
   d="scan'208";a="197828585"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2023 22:34:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 22:34:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 22:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIo0OaL2oiUjOg23vcjwlbrI4jltl7ZbYguj2R4MoHxgiN31ofXozwsXTf1hgF1yWjy2ZqGGfPE0WeN4786MuLCqe+pf+AucgrZMzXhhQNfbFDVrM5Jjj+REERBlPI2fS/T3j4rIW0EEQStYjW7Ftqa5DX3zy5mMic8qUbhU3m874Kab8lqLqnwuC26qyPid9qYS2DUhZ/EHjp5Z2KkIbrbsPtpkXfzmg6nwK/oFR1ifaExXrg+kpoaEe1bYJAgQmow8jN3bQm+DHLnQSgDviJT1/8+B5nUbVGIrzpczvnFKIqpMu6DoKbrx4dsal4iIdybCxl5+2+Cop/ST5sV3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bZSbBv7Pgr78xfz7Hp3FRszutpNOEvGXRVQkit1Vbw=;
 b=GR3Oi3fpKD3iaZD8PMKuTmIu7WS/kEz18zoWBiQQIAY4+TQnPc8cXxwgWaMhsdwgF/n6SzBk3MoxlF4BIXl09BW8El7AajSIea9JVpkN0hRLQ0mGNr+7vcq0n+hTBPsMK/H6W+CfO2oIiImRrAhR9Ag9QXE+AikCfGbuumW3Y0Ra+524PXYCIPAtmfma00LPr2wkge/aNfa5TiNq/4wFf2o51Q9Bn/6vMG620dSpprDSszViyEkb9S1U9ixI8M6QWzyYVJloQv4/U8SXTL0n8cpQNB7oYZ2CqdhZY6NNmwhQ5qUlAAbftdBlHNy4teqyudLIcDu9wKlBtgpNK7U7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bZSbBv7Pgr78xfz7Hp3FRszutpNOEvGXRVQkit1Vbw=;
 b=q815DHtlZA54JSPxxbbJpAdCEvf/IqdROEPQ8wDPQVg2gnDj/DbMwdo94WYu7WyeDmFAeuUxDVP3TCpqFdvgMJTAj1C5HwFLuRDD1mbL+Jjy4hoee7EjMWcZ2l6NKkPq+ssWQqIMtFJ0JUj0Pz9F4OMGW87ONT7r+iv5aEpvjJ0=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:34:02 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:34:02 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <festevam@gmail.com>, <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and link
 frequency
Thread-Topic: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and link
 frequency
Thread-Index: AQHZLUnPWr0eVsa9dkWYdFRaw/UsYa6sow+AgABq7FA=
Date:   Tue, 24 Jan 2023 05:34:02 +0000
Message-ID: <PH0PR11MB56119C93EB4A19FEFC03778F81C99@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-6-shravan.chippa@microchip.com>
 <Y88SG5ndXjQ9AjZg@valkosipuli.retiisi.eu>
In-Reply-To: <Y88SG5ndXjQ9AjZg@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SN7PR11MB7137:EE_
x-ms-office365-filtering-correlation-id: d9d1d527-d76a-4798-a4ac-08dafdcc9a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZe7kMO+8ZqHzAnvvPpTxWL5DIWNCH+gEqL87dY4kEE4Y8sHiA9g+ziIHbMXIn1MIogpLXz3Opp8QqS57e/h3El8ZOnLB/miqObP5g6ggt2gADLDQmwDNFFg65tNtejwo5cuEnv0UMna+FZpNLsdsa6Dsbu62u9kDnvD/Cmkk0gEleOaffIWtA7IKsPXkrDZLCm81e7b4RH4YIkGG4nFDOqw7t3graPqAdmecQFenxgCk474HGxy7g/5Bf7T4BNTNS3zDEUeiiFiWEfR3/yDXZecZwhiCjl7owT/XZSWwr766qfL2ubsy87Tz9SkpwnSIW/Jxy0c9003fWoZA5XcvtWE3r0U35ixd43z9JxPTAOz1op+XUMB2drYK/NVSWXaGAUGvvqVfw2NtytjNz5ClN1JpPAt+o2KUyA/I0vqCnawJie4/LCkmDMzbErtae9hzUbbEkMuFYQYWT6zkJXPJBlNz86J3eFfQGxguCW4uruRrhuNzKcXwCr/CCW4jDjLEKJPIc2B54vOS5SGTFcVIsS9ug3bert4b5gYXlZeY90gfkb6B4o5FKroie/KzW5SGqJFWl3hs6jQcrVNDCfOPzI2zxQYsx3AhEpnkfSwV13/MqHzRWuOhXX9ejFH/3cd3qRnpT6/Cdibf4+bQiJCAUDY93mYWMr9fXYjuIQ4QsB4LfD+N/Xf8hM0bxcBUtLj7MTtbIlHWSsJZjI2AdoZbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(41300700001)(86362001)(38070700005)(7416002)(5660300002)(8936002)(52536014)(4326008)(2906002)(15650500001)(38100700002)(83380400001)(122000001)(33656002)(478600001)(71200400001)(7696005)(66946007)(53546011)(6916009)(26005)(9686003)(186003)(6506007)(55016003)(8676002)(316002)(76116006)(64756008)(54906003)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SCdQomGfDtFOGMmuU+AWUYxN4Ip2JCF5Un4IcMKSVIZTwS3OJyOs38bMhUj9?=
 =?us-ascii?Q?MHz1ajog4/UBQtKf1lXJeTcTnv1oRaG0qPH7zvO/5TjF7cFKO2bI0C2Y/GJ4?=
 =?us-ascii?Q?rvsvGRxj5Blfcw38MVYrMB3D9kCoQqlrH/vn/E46w7W9kruu2TNywKv46jXS?=
 =?us-ascii?Q?8lHus01sol2riOwRxPpHSfgioY4ifzInRv0bSusuzp1lutUQXqqZcg9TA/mJ?=
 =?us-ascii?Q?69IVRKLmG5+0o5EW7lw5O9ENd5K6R1QLkiZvmog5uVMInOXduDhjyvAY8esa?=
 =?us-ascii?Q?zYmKhieddPRSh67xdZQBRXiOzsDnDk6zmXijcSo3I/uyP/tsEhoVYRKImWVD?=
 =?us-ascii?Q?JuIBnGM7VlHq0oqsFVWNn4aAspcMKa5JSVk2Wmd7TnI/eRzSP/xxntlJekC0?=
 =?us-ascii?Q?qhBEidBg9n4AzMQMsdTp0f8X2Vn+Or1T8qea5gz3lZ+hPdse95eWS22EKdPs?=
 =?us-ascii?Q?JKwOqhkfAdB6GsvG8vDsPQbRygFOF0+Y2VcnTfkzJze0mHEKwCu5kpyWcSpY?=
 =?us-ascii?Q?Qqt9RDRIFv35Z/zgpVhTS1L+w+Tl/WnXy7G7tjBoF6EjRcWGqew07aW5eYSr?=
 =?us-ascii?Q?b0G7yrqXLIvXNb6l9HLLQKAWR2T/m8dXr0iDHRpcdfb/hI0njl80qWt6CwHf?=
 =?us-ascii?Q?UpujJx8VZjAJ6YzywLh/jaVKl3ugHtNOfmaTkGMvYTsLv3EPVX8UoK4wknME?=
 =?us-ascii?Q?HprLXvGKlxQIkcG0zkAfo3TiXxf1kUK67BgpH99YC12Rs67DZHEViN5ekBj3?=
 =?us-ascii?Q?yR4OWC+YhvbFs2NHR/YiSi+IZb+qgCZ+mj8dtgVOCVBlwRCI1Y8jSjckwvLI?=
 =?us-ascii?Q?bRr2dW7VduBF9ryvXt1u7bahVtCk4YZ2aul2pztbzEDOMAF99Pjqpb4IFYMi?=
 =?us-ascii?Q?Xhm+joOaEs5U+jmIUc4AtYW//nnRsy8pqTN3W/26Ts2E+t0gN5YPVAviO/To?=
 =?us-ascii?Q?hPjA5VwmDNXeso3qKNXEHHlFt2eVdQ1lNE+6Z92to9DV6KxuPAdZ2u7fRQFO?=
 =?us-ascii?Q?oCTxVftaaL8w4Nbf5Ae3OmhmP5rDM9plcjIBEgyv1uri6azJAzr8GbHhEOAI?=
 =?us-ascii?Q?Hz63J4ZyhDc1NDvk4APRNbGso4N1GPL6ZBDULP/sQvTu5hvAzVsSGDy1WsRh?=
 =?us-ascii?Q?8Zc4iFOzDoB4v2N2Djo5y+1i3I+RUYubuNqddG2lMZNwaWbm2GXMbQqpBdqM?=
 =?us-ascii?Q?dtmq/i6PzhTvgLQEJ7K3tKPLC2dORt4oWPZ5VNbYcpjPyA07uljDN/mDvqse?=
 =?us-ascii?Q?d5hW9eolg1oKkwMp4ytg4le1dwvASvfl7/lUrQwRF+b10czkx76BzBwzjbZJ?=
 =?us-ascii?Q?1vqyLXb8yj068dvNkbb+bh+hnD6UAfcNANwDtZ5A/1DMh9iwLXyYSXtpAxUz?=
 =?us-ascii?Q?lHFKnlv55V2Di4FhmpxM+sV/i/r1l7ZXOos7BiShGlwMDE3Q8+M8pIAMK1ey?=
 =?us-ascii?Q?B5iY7Q6Ay9Vn24odVv+292+PfeiXwVOx2sjwxqO2UKGuHuYWEHBbBtg3X2p7?=
 =?us-ascii?Q?fQhM08mgUPTuritir6DT889Zw1G7jReB4kVx8Rtb7woG1KGAUHv5a7j7poRy?=
 =?us-ascii?Q?7PmN4B3E9Krrm/PBJy+R4vGUnCqoepe4fe97HLPcmrN1/QZEAx6/D/tBPphv?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d1d527-d76a-4798-a4ac-08dafdcc9a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 05:34:02.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeJNPR2Oq97jWvIowOX4Z0ELvZDLkrALxJ5D1iStVFwKmVdE3TAY1FYgkTIoBTXkF4diPRAcZVaNfVymX+JbUi79fRntsku8hAwV1Ygvxoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: 24 January 2023 04:33 AM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> kernel@pengutronix.de; linux-imx@nxp.com; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and =
link
> frequency
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Shravan,
>=20
> On Sat, Jan 21, 2023 at 09:07:13AM +0530, shravan kumar wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > Update pixel_rate and link frequency for 1920x1080@30 while changing
> > mode.
> >
> > Add dummy ctrl cases for pixel_rate and link frequency to avoid error
> > while changing the modes dynamically.
> >
> > Add support to handle multiple link frequencies.
> >
> > Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > ---
> >  drivers/media/i2c/imx334.c | 41
> > ++++++++++++++++++++++++++++----------
> >  1 file changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> > index 309c706114d2..62b104eaa437 100644
> > --- a/drivers/media/i2c/imx334.c
> > +++ b/drivers/media/i2c/imx334.c
> > @@ -49,7 +49,8 @@
> >  #define IMX334_INCLK_RATE    24000000
> >
> >  /* CSI2 HW configuration */
> > -#define IMX334_LINK_FREQ     891000000
> > +#define IMX334_LINK_FREQ_891M        891000000
> > +#define IMX334_LINK_FREQ_445M        445500000
> >  #define IMX334_NUM_DATA_LANES        4
> >
> >  #define IMX334_REG_MIN               0x00
> > @@ -139,12 +140,14 @@ struct imx334 {
> >       u32 vblank;
> >       const struct imx334_mode *cur_mode;
> >       struct mutex mutex;
> > +     unsigned long menu_skip_mask;
> >       u32 cur_code;
> >       bool streaming;
> >  };
> >
> >  static const s64 link_freq[] =3D {
> > -     IMX334_LINK_FREQ,
> > +     IMX334_LINK_FREQ_891M,
> > +     IMX334_LINK_FREQ_445M,
> >  };
> >
> >  /* Sensor mode registers for 1920x1080@30fps */ @@ -468,7 +471,7 @@
> > static const struct imx334_mode supported_modes[] =3D {
> >               .vblank_min =3D 45,
> >               .vblank_max =3D 132840,
> >               .pclk =3D 297000000,
> > -             .link_freq_idx =3D 0,
> > +             .link_freq_idx =3D 1,
> >               .reg_list =3D {
> >                       .num_of_regs =3D ARRAY_SIZE(mode_1920x1080_regs),
> >                       .regs =3D mode_1920x1080_regs, @@ -598,6 +601,11
> > @@ static int imx334_update_controls(struct imx334 *imx334,
> >       if (ret)
> >               return ret;
> >
> > +     ret =3D __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->pclk,
> > +                                    mode->pclk, 1, mode->pclk);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->hblan=
k,
> >                                      mode->hblank, 1, mode->hblank);
> >       if (ret)
> > @@ -698,6 +706,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
> >               pm_runtime_put(imx334->dev);
> >
> >               break;
> > +     case V4L2_CID_PIXEL_RATE:
> > +     case V4L2_CID_LINK_FREQ:
> >       case V4L2_CID_HBLANK:
> >               ret =3D 0;
> >               break;
> > @@ -1047,7 +1057,7 @@ static int imx334_parse_hw_config(struct imx334
> *imx334)
> >       struct fwnode_handle *ep;
> >       unsigned long rate;
> >       int ret;
> > -     int i;
> > +     int i, j;
>=20
> unsigned int would be nicer.
I will change.
>=20
> >
> >       if (!fwnode)
> >               return -ENXIO;
> > @@ -1097,11 +1107,20 @@ static int imx334_parse_hw_config(struct imx334
> *imx334)
> >               goto done_endpoint_free;
> >       }
> >
> > -     for (i =3D 0; i < bus_cfg.nr_of_link_frequencies; i++)
> > -             if (bus_cfg.link_frequencies[i] =3D=3D IMX334_LINK_FREQ)
> > +     for (i =3D 0; i < bus_cfg.nr_of_link_frequencies; i++) {
> > +             for (j =3D 0; j < ARRAY_SIZE(link_freq); j++) {
> > +                     if (bus_cfg.link_frequencies[i] =3D=3D link_freq[=
j]) {
> > +                             set_bit(j, &imx334->menu_skip_mask);
>=20
> Is there a guarantee that you'll only be using the modes with the listed
> frequencies? I don't see one but I might have missed it.

If I understand it correctly, the question here is, the listed freqeunceis =
and modes are one to one mapped?  Then yes.

Thanks.
shravan
>=20
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (j =3D=3D ARRAY_SIZE(link_freq)) {
> > +                     ret =3D dev_err_probe(imx334->dev, -EINVAL,
> > +                                         "no supported link freq
> > + found\n");
> >                       goto done_endpoint_free;
> > -
> > -     ret =3D -EINVAL;
> > +             }
> > +     }
> >
> >  done_endpoint_free:
> >       v4l2_fwnode_endpoint_free(&bus_cfg);
> > @@ -1232,10 +1251,10 @@ static int imx334_init_controls(struct imx334
> *imx334)
> >       imx334->link_freq_ctrl =3D v4l2_ctrl_new_int_menu(ctrl_hdlr,
> >                                                       &imx334_ctrl_ops,
> >                                                       V4L2_CID_LINK_FRE=
Q,
> > -                                                     ARRAY_SIZE(link_f=
req) -
> > -                                                     1,
> > -                                                     mode->link_freq_i=
dx,
> > +                                                     __fls(imx334->men=
u_skip_mask),
> > +
> > + __ffs(imx334->menu_skip_mask),
> >                                                       link_freq);
> > +
> >       if (imx334->link_freq_ctrl)
> >               imx334->link_freq_ctrl->flags |=3D
> > V4L2_CTRL_FLAG_READ_ONLY;
> >
>=20
> --
> Kind regards,
>=20
> Sakari Ailus
