Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49E467DA40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjA0AKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjA0AKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:10:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F64B763;
        Thu, 26 Jan 2023 16:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674778230; x=1706314230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=31kO+mfmbT4VFSBtAgUFja93JQKD3qIIj1c/xFD1c5Q=;
  b=pKAtWrK3/fSqsoaftte7Elg+v8CsgX4nviki83YJfo3X9oAPAIKOKU0B
   VsZqXQ4ENx9PAJD35jEFYvvlZlW4WIJyLP1TNV+70P513+xKYNkmW7MfD
   WeBZZWpe2qIxZHrgRewF/cIGR2n3MBgf55mzSk3LpMCwKy8hCswFxef2a
   E2h756WaCnUcw4JIB0R0dusXmHgV1zNR2d4zsGjdNQlFwwqQ6pTW6H5nF
   AWlZUH+t0E5jZe3qzMWSps4/r+q1/p0rPg3dgaXh+EdEo5dkgEzI+Ys/9
   3MpIlI9WbvUmvikeYwbILrqH8/J8TT3hWpNWTyP5BmuKYu4oaFuZKYztK
   w==;
X-IronPort-AV: E=Sophos;i="5.97,249,1669100400"; 
   d="scan'208";a="134226497"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2023 17:10:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 17:10:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 17:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBxhsou0Ms1XROdWx81WlkQmUVdrpx+Bv9w4/Wvtei/PjImv/xfWOBAuq8FR3/odRAVFDfUs0dtsb1H51X8C/B+uF3yKonA6Hv/QviYq7+TxFscBV54HsfJuv6rizyrM+HrT/gs4wHo8jH3Z1ZQ0Xij7/72+E0+j/htP11+aRAv622Ahdn/ce4rBogl8OTDeo/s/MasFsnfSpAs8ME8eWQjkXMURXYqGcZcVPZ6y61aCTekB5UUMRWN1qL4QBm6fKXa/ZxymjfSh1EUbCO3bejECAlslQAYjI2T9NIB7keYhe5k7wmnT2fBNT89s0Ojt9xeMCK2/Xwjg2+bwObpZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiWpeR5g2oksBdBfndf8vzlrdBdkfeMtNVgr4q4m2mc=;
 b=UrV0nHxLsD7k8p+3xe2NFS2nHcUNuBC2Z3iILgMkYx34WNLfsCT0xjXIvBjDTlL/OmX1AHtONRKSf8YyqmZOB2XEjHX7BBv6kKVt/wRxaZzfhb73izjFEZ3mbI556zV4yfpLvBntnsRu4Fz4iAimwOEknbJuCMFFaXA/pt41jdZS76p+Ffnqr2Jjgmi0j+ldwMZlohBMoj0uOvpynM+u/P9X30O0vDIuy9HvuDKrFquBNwzDosCebENYehGS/wyLBnA/aJCG4PuGkSRH+GfJL/rstYRxEUfWST+I4NkBpeLnCRoP8R/P2qvfdJBbMoBUnajmnsZlkSX7de/lJuvZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiWpeR5g2oksBdBfndf8vzlrdBdkfeMtNVgr4q4m2mc=;
 b=hLCeKvCKonc540xqOCMIUmIXwcUdRNZvgbRAb1K4yc29PUcUx+uyE39+yL1aAx188DCVjcJSGNfNsNusQUnG9VY0g2e+hKLw0XfR0hAUCn1ZHZzbk+X8k3EfbLI6/zW+IMvcaUIlkoq6bh1ulQaKHoMAd1poMp/EpG5iNqQ6CHs=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Fri, 27 Jan
 2023 00:10:22 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 00:10:22 +0000
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
Thread-Index: AQHZLUnPWr0eVsa9dkWYdFRaw/UsYa6sow+AgABq7FCAAdoPAIACfu1w
Date:   Fri, 27 Jan 2023 00:10:22 +0000
Message-ID: <PH0PR11MB5611880BB2141A73B2D67D7181CC9@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-6-shravan.chippa@microchip.com>
 <Y88SG5ndXjQ9AjZg@valkosipuli.retiisi.eu>
 <PH0PR11MB56119C93EB4A19FEFC03778F81C99@PH0PR11MB5611.namprd11.prod.outlook.com>
 <Y9D5eG8PP/qYPk40@valkosipuli.retiisi.eu>
In-Reply-To: <Y9D5eG8PP/qYPk40@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|MW4PR11MB6982:EE_
x-ms-office365-filtering-correlation-id: 6cc7e770-e123-4ed6-8dac-08dafffae207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWPUeAMyhsDUoyR6BXWRb9n26SipbFlcJUYY44eqFw+wSMSmL7pP0l+QD7UxF5MjWlXYvrzDuNrUQOtyUHPAKQrrPPk/fZJ2kaDKGsOlbIUgAVeF4SJn8o37UbZx8ZXB4MPvjescSt0mDLW7WwUDYMyO09DKRCEUjssUi7Wvvie3/UKITZYK+PtqDy2TCpCHEAdJgNSBbC8GWUHtC6iMH0drJPSwgzRdrPMQp9IX9cj9JhwhHLsfQbYpoJE35rEw69apOqfbfUw4gnwdYIFF9I8mcBI1UK5llaSumux4P1xw4ubIXilpOdFR4FrXfI+ZECbvyLTId9+9arvLPKhqOacVkD9XU9n1E9ZkEUlysfbtd3oea2RO3YfKXJAuKOSKbNzQiWbSBPS0FMwDmbgEBHRMNpc20s0+QuSAC4tvqEGuTsOdif4QwVYWCSt/SnstvyXIgMJpRpnvhAAv6cp5nAFl6y0xE+KGlBubKYoQ2VbtOIyTQQoSe8cr40cFc++P992W6sp55a7ZGdIHbEp5nL+RUd9YjbZR7qAQXfpBRTBWwAj7Lf96v7ArTNObG25kJvd+TX2b6bfydHTvNeJ+HgmHH+1chEAO/Pb5A01wP8sjwS2xpWHrbkQVbTv2ErXReaAJaeW1N4I0dw0F6HfH3PLi4BUtdlhULCH7aSz29EKjlKE1k/IPAG8qp/F1nvq+SKDwvmW+Ezos/0vwuntapA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(33656002)(38070700005)(15650500001)(2906002)(86362001)(38100700002)(8936002)(4326008)(83380400001)(122000001)(52536014)(66476007)(41300700001)(5660300002)(478600001)(316002)(7416002)(71200400001)(7696005)(9686003)(186003)(8676002)(26005)(6506007)(55016003)(6916009)(76116006)(66446008)(53546011)(64756008)(54906003)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXV1g0Z41hTEV9VhbrzM+/1JqD12pF7P89sA31KJIIPb6AyLurmzv/CSaVb4?=
 =?us-ascii?Q?IXQXIxsUr75yRVaQsgZIGp4um7fQXrXBtfjGI4Ur9VYEFA/fWb/8WjBwFF5L?=
 =?us-ascii?Q?HwOcuyRZwF5z09XOL9Rb5GZDFxZTtlA4q9UzuCT3z6ATMwBJARaMnQKZYKpU?=
 =?us-ascii?Q?02MefORLcr320H6FgJV1gg9tiCr0wLpPrR95yWjcVPVkTMfFUTblhefAG5Fj?=
 =?us-ascii?Q?2Rwk0mpnJDZIWaGS+6I26ur8rmqeRUupwVm3NJEN2L0iohk+tlFNPK/khCfU?=
 =?us-ascii?Q?sFVI0Y9AQQkATXKjE/mE0s+I9pt/12rV0IxIg/pB5PiWz7yhUeIHS38Pxdgt?=
 =?us-ascii?Q?7VzM4tze/ERLRMDzExcCZuNAflqDh5E/wvxyrAplN6EyyJbuNC705jutbc9r?=
 =?us-ascii?Q?LFoqbaOUWU7oSTudknlq/42OQGQ3cEjLGlQVjJTc+HbMxqH4Jlr6sG+vvlm/?=
 =?us-ascii?Q?hlKDPBngMrcv4zqmeR3uw0KkbMWaPd0AyeaCY6bdRUMeIIFTVmv9gDsQx6PN?=
 =?us-ascii?Q?Uq7S/lRBiddtcLJ+5xLQ4mvjWkE2PlCDSQ63pJXXxQmvKKhfQE5SB4RnRWgz?=
 =?us-ascii?Q?tx5YWr796fnoOcpkmLHMcZ1z1gBKlLkvjAi1XrbjaDTERcf+BQWV84bwluP9?=
 =?us-ascii?Q?waNFYHH3Mz+O5G45Wg1OnhXoaW0hVgDSe+O8REPaIClx8AAERDlSGogfpNsT?=
 =?us-ascii?Q?hkimwEksiWQn9ZhBlwZZz0cc7/HE9anNebzd14wIRjbZNTRGIBrYO84gXRVv?=
 =?us-ascii?Q?VCEHeB+T60a3MZi5y4VTPq5zV/AzR1KaUTQsTN75h7l8GniEY6jUh7oFppcp?=
 =?us-ascii?Q?cIJ8DHZc90Bl09rXAgjOi13kwcAoYX+TRDitMPCDwAjIjeTchA6XqzV2u3RB?=
 =?us-ascii?Q?/nxsI7lnXocOweN+P298HRKII99+ZWpesYoCXvKBZZdDwQkn9IWgHwNyvSXw?=
 =?us-ascii?Q?pFshE5a31ywjYEERDVX4M3x30CNSZZZJXl4R0sBIekyxYy7hyo+verpBTODp?=
 =?us-ascii?Q?5HTFXCdUTMGXJ8UmJ0Yc5sZ18o4D4qBTn+UiGrgmP67g83KG+jDad9wfaL/y?=
 =?us-ascii?Q?tavMCPJ1FXra39R5Op96fOYY8ZPSDo10Db9KnGuMQu7pc65/S6C1VVqXK+fk?=
 =?us-ascii?Q?UqfrX8tbMOiFvWbUUKOxLBQVURNHWbm/2f8RrzeZS0j1j+6/T69l1DV5DLWc?=
 =?us-ascii?Q?8WUgjWiEfOxFu7K6EhYw0JExJ4bpbmmX6TDvUbV0RcczGxr8NQB+dphwi7qq?=
 =?us-ascii?Q?97zGWvvom3wf/TWz4S2h8XWoazsS1omuCcnqQ0qnJ9Go5LQJn1atLh7vroNr?=
 =?us-ascii?Q?QDJV4k/A97AJGGkdrkVi1d/YwD3tGwqtoyPGb4bZYNm8wblChkpw/BUgymBX?=
 =?us-ascii?Q?WD6xmvPZtqfGLP72UvGQJn+hR1SOyd5VbqhgUelmadAhYMTcp+MyfPsd6Fm1?=
 =?us-ascii?Q?GZ+dMgGYBrB2kXWVUWYYYjsiUxKbUORF5n8EUYustRchLi3RjZc7fx3AdC/u?=
 =?us-ascii?Q?m63RC3KJuz1MaFbOblGVeKTpkWjWPRsFomosfVcIEds2M+F2rX5p5Y72u9By?=
 =?us-ascii?Q?XsNXwRg95RmIlQoKXlh2kOS+1dVPbcS3FFhJhYOnhA/MC4NMWiSjaeoL2zaO?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc7e770-e123-4ed6-8dac-08dafffae207
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 00:10:22.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xs7HwUZQXmhGAK3xSOX4E84IKmZiVhS7sPu4z1IzLLNxclWm152SEOv630IFuA/t147WfFRrFZVps4I2dadoJ5xpn51UTk3tiw5lZN9rb5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6982
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
> Sent: 25 January 2023 03:12 PM
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
> On Tue, Jan 24, 2023 at 05:34:02AM +0000, Shravan.Chippa@microchip.com
> wrote:
> > Hi Sakari,
> >
> > > -----Original Message-----
> > > From: Sakari Ailus <sakari.ailus@iki.fi>
> > > Sent: 24 January 2023 04:33 AM
> > > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > kernel@pengutronix.de; linux-imx@nxp.com;
> > > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-arm- kernel@lists.infradead.org
> > > Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel
> > > and link frequency
> > >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >
> > > Hi Shravan,
> > >
> > > On Sat, Jan 21, 2023 at 09:07:13AM +0530, shravan kumar wrote:
> > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > >
> > > > Update pixel_rate and link frequency for 1920x1080@30 while
> > > > changing mode.
> > > >
> > > > Add dummy ctrl cases for pixel_rate and link frequency to avoid
> > > > error while changing the modes dynamically.
> > > >
> > > > Add support to handle multiple link frequencies.
> > > >
> > > > Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > > ---
> > > >  drivers/media/i2c/imx334.c | 41
> > > > ++++++++++++++++++++++++++++----------
> > > >  1 file changed, 30 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/imx334.c
> > > > b/drivers/media/i2c/imx334.c index 309c706114d2..62b104eaa437
> > > > 100644
> > > > --- a/drivers/media/i2c/imx334.c
> > > > +++ b/drivers/media/i2c/imx334.c
> > > > @@ -49,7 +49,8 @@
> > > >  #define IMX334_INCLK_RATE    24000000
> > > >
> > > >  /* CSI2 HW configuration */
> > > > -#define IMX334_LINK_FREQ     891000000
> > > > +#define IMX334_LINK_FREQ_891M        891000000
> > > > +#define IMX334_LINK_FREQ_445M        445500000
> > > >  #define IMX334_NUM_DATA_LANES        4
> > > >
> > > >  #define IMX334_REG_MIN               0x00
> > > > @@ -139,12 +140,14 @@ struct imx334 {
> > > >       u32 vblank;
> > > >       const struct imx334_mode *cur_mode;
> > > >       struct mutex mutex;
> > > > +     unsigned long menu_skip_mask;
> > > >       u32 cur_code;
> > > >       bool streaming;
> > > >  };
> > > >
> > > >  static const s64 link_freq[] =3D {
> > > > -     IMX334_LINK_FREQ,
> > > > +     IMX334_LINK_FREQ_891M,
> > > > +     IMX334_LINK_FREQ_445M,
> > > >  };
> > > >
> > > >  /* Sensor mode registers for 1920x1080@30fps */ @@ -468,7 +471,7
> > > > @@ static const struct imx334_mode supported_modes[] =3D {
> > > >               .vblank_min =3D 45,
> > > >               .vblank_max =3D 132840,
> > > >               .pclk =3D 297000000,
> > > > -             .link_freq_idx =3D 0,
> > > > +             .link_freq_idx =3D 1,
> > > >               .reg_list =3D {
> > > >                       .num_of_regs =3D ARRAY_SIZE(mode_1920x1080_re=
gs),
> > > >                       .regs =3D mode_1920x1080_regs, @@ -598,6
> > > > +601,11 @@ static int imx334_update_controls(struct imx334 *imx334,
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > +     ret =3D __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->pcl=
k,
> > > > +                                    mode->pclk, 1, mode->pclk);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > >       ret =3D __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->h=
blank,
> > > >                                      mode->hblank, 1, mode->hblank)=
;
> > > >       if (ret)
> > > > @@ -698,6 +706,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ct=
rl)
> > > >               pm_runtime_put(imx334->dev);
> > > >
> > > >               break;
> > > > +     case V4L2_CID_PIXEL_RATE:
> > > > +     case V4L2_CID_LINK_FREQ:
> > > >       case V4L2_CID_HBLANK:
> > > >               ret =3D 0;
> > > >               break;
> > > > @@ -1047,7 +1057,7 @@ static int imx334_parse_hw_config(struct
> > > > imx334
> > > *imx334)
> > > >       struct fwnode_handle *ep;
> > > >       unsigned long rate;
> > > >       int ret;
> > > > -     int i;
> > > > +     int i, j;
> > >
> > > unsigned int would be nicer.
> > I will change.
> > >
> > > >
> > > >       if (!fwnode)
> > > >               return -ENXIO;
> > > > @@ -1097,11 +1107,20 @@ static int imx334_parse_hw_config(struct
> > > > imx334
> > > *imx334)
> > > >               goto done_endpoint_free;
> > > >       }
> > > >
> > > > -     for (i =3D 0; i < bus_cfg.nr_of_link_frequencies; i++)
> > > > -             if (bus_cfg.link_frequencies[i] =3D=3D IMX334_LINK_FR=
EQ)
> > > > +     for (i =3D 0; i < bus_cfg.nr_of_link_frequencies; i++) {
> > > > +             for (j =3D 0; j < ARRAY_SIZE(link_freq); j++) {
> > > > +                     if (bus_cfg.link_frequencies[i] =3D=3D link_f=
req[j]) {
> > > > +                             set_bit(j, &imx334->menu_skip_mask);
> > >
> > > Is there a guarantee that you'll only be using the modes with the
> > > listed frequencies? I don't see one but I might have missed it.
> >
> > If I understand it correctly, the question here is, the listed
> > freqeunceis and modes are one to one mapped? Then yes.
>=20
> I don't see this being checked in imx334_set_pad_format(), for instance.
>=20
> If a frequency isn't in DT, the driver isn't supposed to be using it eith=
er.

Yes, there is no check.

But, if a frequency is not in DT, the driver will not add in menu items.
So, the function imx334_set_pad_format() -> imx334_update_controls() fails,=
 if we set the frequencies which are not there in the DT or menu items.


Thanks,
Shravan

>=20
> >
> > Thanks.
> > shravan
> > >
> > > > +                             break;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +             if (j =3D=3D ARRAY_SIZE(link_freq)) {
> > > > +                     ret =3D dev_err_probe(imx334->dev, -EINVAL,
> > > > +                                         "no supported link freq
> > > > + found\n");
> > > >                       goto done_endpoint_free;
> > > > -
> > > > -     ret =3D -EINVAL;
> > > > +             }
> > > > +     }
> > > >
> > > >  done_endpoint_free:
> > > >       v4l2_fwnode_endpoint_free(&bus_cfg);
> > > > @@ -1232,10 +1251,10 @@ static int imx334_init_controls(struct
> > > > imx334
> > > *imx334)
> > > >       imx334->link_freq_ctrl =3D v4l2_ctrl_new_int_menu(ctrl_hdlr,
> > > >                                                       &imx334_ctrl_=
ops,
> > > >                                                       V4L2_CID_LINK=
_FREQ,
> > > > -                                                     ARRAY_SIZE(li=
nk_freq) -
> > > > -                                                     1,
> > > > -                                                     mode->link_fr=
eq_idx,
> > > > +
> > > > + __fls(imx334->menu_skip_mask),
> > > > +
> > > > + __ffs(imx334->menu_skip_mask),
> > > >                                                       link_freq);
> > > > +
> > > >       if (imx334->link_freq_ctrl)
> > > >               imx334->link_freq_ctrl->flags |=3D
> > > > V4L2_CTRL_FLAG_READ_ONLY;
>=20
> --
> Kind regards,
>=20
> Sakari Ailus
