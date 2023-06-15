Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C621B731466
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbjFOJs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbjFOJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:48:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB717199D;
        Thu, 15 Jun 2023 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686822501; x=1718358501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aq14XFqY6qdOiLOxncCYLv73xExemdNIGrHCx+D6TSI=;
  b=YL7NG70ACXWezRCc6uUn91bRUGVDpio1qo2ptxNEdWEn5RMhoivVZVn3
   Iea97U037p+EK11k7dIPPtbP0fxgXLSNnaMUxBXHRJ9HQAGqOY0ExSTI5
   5PcEfUopKlTTEkOcoUYJs4luj+0Ct11FMA3A6owuiPhemX5FFyXEbv9Db
   SImhbhoSvj61fLUHwPfK2dVcpYOsJWFqiJScw5H54gQG2dercN0jfFK1Z
   QFzowmf9Jd+A0ZBYEkJ88JJer1Gd/phjBOQUpr4WwBAOEMu3ObVdNhAsQ
   tQ5uzIMC+ybtc8Lt1iLNEFICIMhXDPKYCBqa+TRYJTOXye4o6Q72YUCub
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445234729"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="445234729"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 02:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="959126790"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="959126790"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2023 02:48:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 02:48:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 02:48:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 02:48:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 02:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vomj/A93ta64gZVfVEe7FqHAicPJBjbBDnuDM24cOtxHd8cZ9aXbJsWu91RTPG/UZIoyKdQ6ovNHHbRUkmzxfpVfuf6XuPHnWTdUGh7LxhxfdTB1TZEVOXjQ0j1WOkblvQjtMwSQ/siqbWRXcgOiLWOecKzt5GNnp4tUveDL5vcCnAEg4RCu2ELUxhbLol2PjpZqThOA4gUT7oFt3vnu8l+BcX+T6p2R2+ZfAq+JNHS5Zik0QAdzKjoes1+6kZB4oVpPHObKP9WIKJgMbNyvHoOgwC+T06iE7StfubEO/EQFZKYJ7AhnUGeq3UaqHQRYLkPjW7vwjENRm01In9OJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d43+q970raqoBSAaQflGlzgINTZJMLr68BkPDuc+ygU=;
 b=J65a1oRINYmFGS2M+Qditur4wh3T8yv82k/XKgPU67slJCMxg61/fMaYgw5mFA/XckZr9lmKoWEpsVQhABfG6pAmk6LM1oFwBO2RA6hOGKa4lomgW2cWyH0Cek5xGqClFvY7v8rkR/nQiWkR1s9rwJjRBYtvfE3SI0glemzRJYhwVbkrSl2K3RPgt+T4AWGYMKaSM9jx57N2+k/fSh9iGe956DDX+aIWX6gakxEoIutUEI/Ksu1XAwvCqd727jNug5jTeGXMg2d+dqm3Ck2/pEn8UuO3AMbyLUIyxbXNH9/sCHzpcw8zq8tk/qI4Nk3kzv0JeMQoArJslDihrL1Sbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2779.namprd11.prod.outlook.com (2603:10b6:5:c6::26) by
 DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Thu, 15 Jun 2023 09:48:13 +0000
Received: from DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de]) by DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de%4]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 09:48:13 +0000
From:   "Jadav, Raag" <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: RE: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Thread-Topic: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Thread-Index: AQHZndRGEYk7XkvCzE+g3a/tygkcuq+KfTeAgAEjDpA=
Date:   Thu, 15 Jun 2023 09:48:12 +0000
Message-ID: <DM6PR11MB2779F9C28712D7C25F9FB3768C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-3-raag.jadav@intel.com>
 <ZInpT0dUUVUcKdqv@smile.fi.intel.com>
In-Reply-To: <ZInpT0dUUVUcKdqv@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2779:EE_|DS0PR11MB7409:EE_
x-ms-office365-filtering-correlation-id: 39164cd2-194f-4cc1-c9af-08db6d85a29c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lXlzKb6z8evX6qdMJSAtZUYWJw6uk/5gV+YTmCGxjj4Eeyjb663SqHXsgWAMKdiru0vcNFX9mMyI4gCfcRBTwvgRVWMrTCKCiEYsuCzyptZ2uqFc8kGu9km5mqtS/6ZBB+2yUgeMTas2QWy5o7Cnn9AwMZqkIYUA+OpWkkIUHTVlOl2M5XXAQLMzyjc/366SReN/Cc02fPqHLp48lJu8mPyC8CCcYBI+U6N+5zr9grQrcNbbqpUrnySzVk0gT3lTuBrLeXA2DBQRpLFDsBjk96/QwzZ1ybvFw3esPV1ja7hw/zn8EVAxsQM1z4/yKWslAZuAlGJzOvjQ0iJfCQtncrTwr8wbli6OFixKw9PgiLJf2WhpzxLVA0iX7PrbgivIHb2owhmrUOoTlwp2z8rG1sNKSATdcaRwZzX0gmQCwfAcK2GZPMYFyZJtTcE2Yj4YISR6uIt1nGn0beB7vxrjXwRsThKFS5QBnMG4RnN0PQkysy0qZWUp1G9TfY1RF0LajXjrQraSWyY+Yi252XeQoixEMEIWTWGkeDA5IiAP/Y+jvUhOiKK+t8ue9yIVbzIcUGpPCj0CNZm6/W6HRxKm+WhX+O0SPnDfmavh79BjwZKx5O6Av2hM1cS/a9gqpXOY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(38070700005)(33656002)(86362001)(66556008)(66476007)(64756008)(66446008)(478600001)(4326008)(76116006)(66946007)(6916009)(54906003)(316002)(7696005)(55016003)(8676002)(5660300002)(52536014)(8936002)(41300700001)(122000001)(82960400001)(38100700002)(2906002)(186003)(26005)(71200400001)(9686003)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xqBnOMEnaexh4Qv8cdYbQZxDOIKIXYGMwTvMWqyD/cQzHZAqrl+emn7p4nqd?=
 =?us-ascii?Q?6YMmdvEtEdUSnIWsHrPbCcK5tTgtpFfbPUb/BCH2GYAtdw4AbUs/lJFwXtzu?=
 =?us-ascii?Q?GUMkfO52BQttmPRENloQA8GLmKyWxqXLCIttQbEK5P2Dxc0u8ygO2fYTuf5h?=
 =?us-ascii?Q?iJFHySpPp6+DsBnvOH5w8ihz+fuMpxkukm8HgO6x3Ih1OvytWpSphFtRDulF?=
 =?us-ascii?Q?9LGFmPM9MIhQLEw6NA6iz3aMDD/oQgB3+Jfy6uFFrqDwtiD7RChCkXMDqdLw?=
 =?us-ascii?Q?eJMqWhTMcuDYKdjYKtykDjspNzfzt632sNuO8fxE0PkbP7FPUMAiKKO8gKv3?=
 =?us-ascii?Q?Eo4UhZA+1cXC+qwsBHjR9sVTpE5lGdHH1E7BNMTUuSMNWNH0vS5XJfW1ScAT?=
 =?us-ascii?Q?9QmX8Cs+2QmkIOGye9fe931+02NhlhjdAgZQzODWxTis90J1R8f6L7aJaNXb?=
 =?us-ascii?Q?1Vbcv62eUVXNJDAuIacNaMMOAVLfFIpZczOKcANU9mGYIE3N8QApha8FWHHR?=
 =?us-ascii?Q?lbduC3mEc+HrJtKyKqCz/5xpTLm4ojt/4F8U63WcL8sQtrrVeYgCaZ/vZnfW?=
 =?us-ascii?Q?p5ZXdmkEZF0iOwfP3sBkD53A0aRNx+MJoYaoi2et5XPvM0pbpTy60zXUyB4m?=
 =?us-ascii?Q?33bM0W4IIx53vGDsKGRSYH4zEPNt26+3o/oFNZxBj3ybe365dE2tjnXkqhw4?=
 =?us-ascii?Q?uwkwayJIw6LocqPq+3/0fn0xbPaOjTSJtebD8CssR7aJ6Pw3KqldiQx42H8R?=
 =?us-ascii?Q?yXRQD4FuaJxg+uhXAQtdTJUgft27qYlr3HAY/fg1giq2Gh19XsHugaxCURsn?=
 =?us-ascii?Q?4XG/a+dP5UhNjX9nam6RrnwWQlxbQdRpfks7oVB1tI+L921/NHT2PTPntfE6?=
 =?us-ascii?Q?31lS8VQ7I55VVZtR4VPKgOHsZGegNOFD+q2tWYh/nEVShJ+huLROp5OxD7uR?=
 =?us-ascii?Q?hYK6ygmHl4P1RNI3mArmRuB4q/R3WinjLCLHqNXkdtGU3AhIAKWnRmRE0hk6?=
 =?us-ascii?Q?zzbfYfY10C2c8QfoLyAxwAPPrRzaRfnfLheQ/pKZwnkr8W+Lw4T0BJBvhWRw?=
 =?us-ascii?Q?DmoucsSsH/tBVahRnH0Q0mB/G3uLRcBEEzYc52hNCLdE8PKdEBmiGZJm3LJX?=
 =?us-ascii?Q?TARric/nTuV09Ry0rlr42gDcf9vz2lTzFu1bnKxyDIzLlW7pt9Xzz8axh6vm?=
 =?us-ascii?Q?7AUVVPTtGn+qMCXg7YPJLXHgzAZ33UwLVQVbqGX/HXNCtAdrCYOgD+4hp6Nn?=
 =?us-ascii?Q?XIIEVc3e5e8/sfSIEg8+8au+ue6Gp5zRdGudTeQqN5Z+EV7vtNSxeWQZKq6/?=
 =?us-ascii?Q?sneXBl6doF/YkAYzF50YtNo8ZXGdrK3BH02sBAbbaL6ZxtW9ByEHlblf9HES?=
 =?us-ascii?Q?9psBa1U+oSI7Frmb8UiBhWiQayjlORsvTxwkL7GtqHIb0aOjZf84HBJ9U0VU?=
 =?us-ascii?Q?JY8GT8K6ZUNol4DfUGHjK/fEEQ+3AOP6hy5Dfc/peOspxpTROYO0hFeA+12t?=
 =?us-ascii?Q?/ofZKXgcqH1IScz+jguX9VAP6zuiraPkejOAPLacnCHSsBR5uvqAQG0zFGIa?=
 =?us-ascii?Q?H4fP2qpreaSkT7ffD40=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39164cd2-194f-4cc1-c9af-08db6d85a29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 09:48:12.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5of06UQcqmlVTeNl5tYrBctxbzwA0RzKE4DjLyPn3ExQEGGrw5IhAFBa3duSeqvUF9CTHpG0BzgwOIOww69bFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jun 13, 2023 at 02:20:53PM +0530, Raag Jadav wrote:
> > Utilize a temporary variable for common shift operation in
> > ->irq_set_type() hook and improve readability.
> > While at it, simplify if-else-if chain and save a few bytes.
> >
> > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-16 (-16)
> > Function                                     old     new   delta
> > intel_gpio_irq_type                          317     301     -16
> > Total: Before=3D10469, After=3D10453, chg -0.15%
>=20
> ...
>=20
> >  	value =3D readl(reg);
> > -
> >  	value &=3D ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> >
> >  	if ((type & IRQ_TYPE_EDGE_BOTH) =3D=3D IRQ_TYPE_EDGE_BOTH) {
> > -		value |=3D PADCFG0_RXEVCFG_EDGE_BOTH <<
> PADCFG0_RXEVCFG_SHIFT;
> > +		rxevcfg =3D PADCFG0_RXEVCFG_EDGE_BOTH;
> >  	} else if (type & IRQ_TYPE_EDGE_FALLING) {
> > -		value |=3D PADCFG0_RXEVCFG_EDGE <<
> PADCFG0_RXEVCFG_SHIFT;
> > -		value |=3D PADCFG0_RXINV;
> > +		rxevcfg =3D PADCFG0_RXEVCFG_EDGE;
> >  	} else if (type & IRQ_TYPE_EDGE_RISING) {
> > -		value |=3D PADCFG0_RXEVCFG_EDGE <<
> PADCFG0_RXEVCFG_SHIFT;
> > +		rxevcfg =3D PADCFG0_RXEVCFG_EDGE;
> >  	} else if (type & IRQ_TYPE_LEVEL_MASK) {
> > -		if (type & IRQ_TYPE_LEVEL_LOW)
> > -			value |=3D PADCFG0_RXINV;
> > +		rxevcfg =3D PADCFG0_RXEVCFG_LEVEL;
> >  	} else {
> > -		value |=3D PADCFG0_RXEVCFG_DISABLED <<
> PADCFG0_RXEVCFG_SHIFT;
> > +		rxevcfg =3D PADCFG0_RXEVCFG_DISABLED;
> >  	}
> >
> > +	if (type =3D=3D IRQ_TYPE_EDGE_FALLING || type =3D=3D
> IRQ_TYPE_LEVEL_LOW)
> > +		value |=3D PADCFG0_RXINV;
> > +
> > +	value |=3D rxevcfg << PADCFG0_RXEVCFG_SHIFT;
> >  	writel(value, reg);
>=20
> Looking at this I realized that entire temporary variable assignments can=
 be
> done outside of spin lock. You probably would need another one for keepin=
g
> rxinv value.

Something like this?

        u32 value, rxevcfg;
        u32 rxinv =3D 0;

        if ((type & IRQ_TYPE_EDGE_BOTH) =3D=3D IRQ_TYPE_EDGE_BOTH) {
                rxevcfg =3D PADCFG0_RXEVCFG_EDGE_BOTH;
        } else if (type & IRQ_TYPE_EDGE_FALLING) {
                rxevcfg =3D PADCFG0_RXEVCFG_EDGE;
        } else if (type & IRQ_TYPE_EDGE_RISING) {
                rxevcfg =3D PADCFG0_RXEVCFG_EDGE;
        } else if (type & IRQ_TYPE_LEVEL_MASK) {
                rxevcfg =3D PADCFG0_RXEVCFG_LEVEL;
        } else {
                rxevcfg =3D PADCFG0_RXEVCFG_DISABLED;
        }

        if (type =3D=3D IRQ_TYPE_EDGE_FALLING || type =3D=3D IRQ_TYPE_LEVEL=
_LOW)
                rxinv =3D PADCFG0_RXINV;

        raw_spin_lock_irqsave(&pctrl->lock, flags);

        intel_gpio_set_gpio_mode(reg);

        value =3D readl(reg);

        value &=3D ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
        value |=3D rxinv;
        value |=3D rxevcfg << PADCFG0_RXEVCFG_SHIFT;

        writel(value, reg);

> Will it give us any memory reduction in comparison to the current code?

add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
Function                                     old     new   delta
intel_gpio_irq_type                          317     321      +4
Total: Before=3D10469, After=3D10473, chg +0.04%

Unfortunately gcc doesn't seem to consider this as best of the sequence,
and I'm not entirely sure why.

