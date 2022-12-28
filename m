Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3290E657601
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiL1Lqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiL1Lqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:46:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EF1FCE2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672228000; x=1703764000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JidHW66rnT6hG2o4e1yAoENVy49FEwcy+da33s1NCYw=;
  b=hEObksZ6TlLstgxzMDy2rvbqiINylUL9/aDCCHUVP0TS5q1ZTccd/X5e
   JqLN6jkNU6oxrkbCfP/JzznIjy8Ds2gdm6T2Uf5t/JuBX9Ky2Sr/C185Z
   P7qTQSkeFtzg222+WpVwIMhsnh6+FN9gDBljB2toxD0H7dopMAwx24xc3
   ZTKtrM0GXyQ/GE9IVmJFeEdvA6rZ0O1gxWEdHfZujRfy9wdF2K0y6elJ9
   aeIDgt2ERd6hU6l51CvI/JLytzYAw2zK8Jjna0vaTwTK9fOtA+u2pGH+x
   SwoRujFwttyCUDRDkoJD2A7kliO72eKQ7kDByNdZuXpZ1AkrP/bzjY3+l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="301219240"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="301219240"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 03:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="760635271"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="760635271"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2022 03:46:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 03:46:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 03:46:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 03:46:38 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 28 Dec 2022 03:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgylkLgmR4yz+taVEqGR9haIJNDs+PW05ypLSVdkFVmexutUYw9Nxe4OJdzYkXL4R8Yl+l4RqCnhciwBPMvpX68bD6+a4qRl68fpuztEApL7WczXxbDAi9Upjau0bID3Lu1JPvEuS3XcWCByLCWLbrjAQFdAOyT2MkBs9f4N274PqGYeXt/xbKHitif1PYtW622MIBjzsQu0gZFZLd7TdrUxozTFDuk5YOoo2cn8U6hdBj3yMeMdMF1crIrE6jP0Dq2KN72+Xj1N0smGV9eZPlznrAyjWJ4uaH2FuQcuVnTV7NeASfonBhD5Hky5qfQsEz7KnX5BArVVPiP+80PL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSHUjwblMGAjHURyo8aUlYrdpRX5o/y/NCW7wBz4HlI=;
 b=OuXvkmibbz1J/OkjCJ0PQ+y9v53CMlJIi6Ukn5BQSViLoR8//RK5iDOKX8RCJ1CpAvNJZmpurV8cM9BlEwJR8GHJchfs2dFFiL9thkqMea1qIEXCLGj/vjUyEFzveLmmihJALNaScc3hDgdtlyiE8s0eCWxk6UEdpQEdi7S3rOg4VRTt25jj7Uh/NpRBrkKtTdwWLmV9TNK/tTXkevEXgsvHsu+Za41NcUa70AZcBrl59Nz6i9BkD/WfkjetIGjF5u0Y3gPENxfgPtblffXUsECOAjjtX/EsUqQYwRVtrMok0wfv7wbsOVSWWItcvxJJte1V541NQ+yHm/qWOemT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Wed, 28 Dec
 2022 11:46:36 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158%2]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 11:46:36 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
CC:     "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Thread-Topic: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Thread-Index: AQHZFlEYy41no8BHb0OgaolMrZvbla57EG6AgAUZmkA=
Date:   Wed, 28 Dec 2022 11:46:36 +0000
Message-ID: <CY5PR11MB6366515D2A965EEDEC77AF63EDF29@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20221222220214.3688774-1-tomas.winkler@intel.com>
 <Y6VV5d/V4MKDz2Te@kroah.com>
In-Reply-To: <Y6VV5d/V4MKDz2Te@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|CH3PR11MB7843:EE_
x-ms-office365-filtering-correlation-id: 1bf572bb-85be-4800-86f6-08dae8c92ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5b8QEurrLg7bQVvgEPt5HLgdHHYVTVN/3UHj/cIhpKpTdVQTRqq7IBfsU1CaXekYRUFpNR47x3X+2eMO998TsDgNS13naLDgTTSUlPOrEySQ+GKOIwgFNV1DUgZDsEKwIoOBlJT6lBxm/sr0FiN3Q3oYHjkP731ZaIQXXvRnWlLfnRRxdcS0h/e+E8ci3iHFWmO5LX7AKLmncAxajcMN+uzEaR82GseCnEKRRkWEJrj0Wb/iRyNCqqX8aS/L4cHLfpBHtU5lgvoqTREzwvSDrMI5Kq0lq3Ji4wkSbxVsxzmZ/mmKAdDoh8mwl1MuWZXvq2V9TeUBojAE7b/ovcraoiP+6/QAkOlKwvzzaKcd3bOTy9a9ZTqCDAlddTLmaEPUhr740zV52SXd+MfMcuOhsvplBOdJbvVrZ1byeUBc4CKOSEZSlmKru58mtuQiFBXvaOU+Hzi5lSLYdrAhpwM/ak08EIyf7vU3x+VAozUvvbPIEcn2mH5VpEJNVE10SDXwke29xS1sFr+v9zjczxVoLhMf75xICxu2fwnXijc1by98L6FyvN6LbNH016JPypfH9dzB7FDwFeUHRDtFXXOdd27Nu4+JIZ20aEaXlaXW62cKNKNGFHOUn+PBDtDQMenzpZbst1reMg2wmCBP9JP6wwZWSwsrxsQvroEWvqVCwPSDCt7fVyx6RrwTphUJYOgCu3cKwB7iw6A7Qp3wqA+Bsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(52536014)(7696005)(6506007)(71200400001)(66446008)(9686003)(186003)(26005)(478600001)(38070700005)(2906002)(6636002)(110136005)(54906003)(64756008)(66556008)(66946007)(86362001)(8676002)(66476007)(4326008)(316002)(82960400001)(38100700002)(76116006)(8936002)(5660300002)(55016003)(41300700001)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?10YU7+yw3Gp3Nj3lu4ZqNkKxnfoXp8R7s+3HhrcOsMZQ/GV9LG/hvz0Jjt+A?=
 =?us-ascii?Q?eoKsnbEp6RSeR/S3bAUgi4KQqThsEyMwpqR9XRNx24SpvGbvN6HDTgruqEbp?=
 =?us-ascii?Q?441Hg99LhBtJhT/sXkiHRKaEuW35NDHo654gDkmaK7KureASzQa0LMkn21BX?=
 =?us-ascii?Q?W9IOidLwDlW+SvRmz31iLvBu84XXOJSbvwKG8wWIUhOLDkM7xdXppeOyoWsK?=
 =?us-ascii?Q?X+1C/++qqrw4Bc0SvntJs1SylTGXm/3lu4tmfxzPaklg0wfw0cP4NGialdny?=
 =?us-ascii?Q?jFzObs61cPP+R/vySr30ggQc2Ykq4sbncGLR+6iN1HdYtvsfOGbC8sNHuh5z?=
 =?us-ascii?Q?C2oIpd79vrkySlAYz62KbBB4rdLteldVNZxhETBGugQTrRe7V4rWviST2jDV?=
 =?us-ascii?Q?9LLxDT25u9YLSXUwg9pn7N4MjuC6dR/SpWL0Mzn+knqDqbTFuKrHcNB+a0Fk?=
 =?us-ascii?Q?0cgB1iz6GvO7JpeNne4BKZwa5Mz5mKlnqiNV5szOVz27w6H7DVhbrglzGJzy?=
 =?us-ascii?Q?sVBMtUoO7iFY3VCrp34nz/HAwBRUkW4ebZ7IM6aGMgzbAx7EVYkK60U9F0PX?=
 =?us-ascii?Q?M/YTwQY++8d/XmbxUvNFfj7vTcEMKxoGGHzNunxxWCkXobJvBZ+6suwYkN5k?=
 =?us-ascii?Q?olKjIiwbPBKiqPB8tQzG9QV2AEqXvmODVTZZz8XiLtACd185oaq4DWeR6ZeJ?=
 =?us-ascii?Q?R47ph6jRd8hsW/gpGatpxpu6P7DLAfRNTaDIR5odLCCEuvu07GSQ1E5IBtBS?=
 =?us-ascii?Q?tM6pKC5yKdo4ou/VjHpkV6Lh2JSOiT0za8+q8r4dI11cD8adNhi7/jgeATKW?=
 =?us-ascii?Q?wVNqf42bOPZGwMYDEVVxVyPM3hdgmXm5GFZYb2S6XMTf0q/M2MSucqnWrVlL?=
 =?us-ascii?Q?Cg45eVZQKktc4atsxsv209suEbO8dIVuaBvUpd7WbNKhVQlhMNx5LBO7Gg/5?=
 =?us-ascii?Q?hCz9wTsWM+dIWdW3DH5mI9ngpt7ZGVtYS7EVZ0kgbDEJY/hMNzaairEs5IxE?=
 =?us-ascii?Q?h8fnPKlxl52ZcR5DthRrEWpHg0IEKIPeYT5O3DT0kSHKUjEvxclrWKqm8bPt?=
 =?us-ascii?Q?NwBNrbmgTMRSUKjc8wXEdonr7QCD9nsH7Y06yFygbr7OU6GcQe8q9L8B3iJc?=
 =?us-ascii?Q?XZrXVHOqKomW1mCcHhZtbpfxMn5rHWoufI3dbzbNlP0ye25AkmItleWhM16y?=
 =?us-ascii?Q?jkD5LuD6puecYUsFZBZWZtMA9OrS/aYhHLMSZ6rWEt+KZhcyM2ijypZnTKFo?=
 =?us-ascii?Q?MMckRB8Mu/QIhDHuV7cJre2cNLk54mHP3zC7LFR1wvfiLMeCJrraNhF6f43i?=
 =?us-ascii?Q?FeDB+oczTZaVxkDzqzprvH81uAaYLJBpF1UZUViK0GN0x91i4K2fVIplB4Uo?=
 =?us-ascii?Q?zK0Wkk348/0khYMAQFXRQxvApNDFBUvjEFLPyrn1YyjxfA0AjqXHd5o+QCP4?=
 =?us-ascii?Q?WfqhwVarlMmc5LcexAMuqeGUGiUIER+fAp9VH1bhm+oogmYiHAQL2zIwY0nR?=
 =?us-ascii?Q?gRDoyzM4sfRbljEgMuZr0KqBg5If2wgxYF3sxtxpNHJktk32ZqMrpN4gflxF?=
 =?us-ascii?Q?d/smhUNCazmw0QSr3To6tXudMBm0yTa81zF8JwzyQYRR6glwP4tTk5XqPBb5?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf572bb-85be-4800-86f6-08dae8c92ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 11:46:36.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eLs0ONwO6lQwTcNYqDwFAB9VRPL5csrDBDmSoXG4zeIoOGtACm8mzaV3i52f/F+bVmHoU8ZLOAykJafmjieXfXwEgCLVTtkyMvjEeN0bP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Why a whole new subdirectory for a tiny 200 line file?
>=20
All drivers for devices on mei bus have private subdirectory.
This one just modelled on the existing examples.
If you say that this is not a good thing - can put it in the main mei direc=
tory.

> > +static int mei_gsc_proxy_component_match(struct device *dev, int
> subcomponent, void *data)
> > +{
> > +	struct device *base =3D data;
> > +
> > +	if (!dev || !dev->driver ||
> > +	    strcmp(dev->driver->name, "i915") ||
>=20
> I thought I had objected to this "let's poke around in a driver name for
> a magic value" logic in the past.  How do you know this is always going
> to work?

All components that serve Intel graphics integrated into PCH should check
in their match that calling device is graphic card sitting on the same PCH.
The code below checks that i915 pci device and mei pci device (grandparent =
of our device on mei bus)
are children of the same parent, but there is no way to know if caller
is, indeed, graphic device. Easiest way is to check well-known device river=
 name.
All i915 components doing this comparison.
This is a simplified scheme of relations between devices here:
           /--- MEI PCI --- MEI --- GSC_PROXY
PCH ---
           \--- GRAPHIC PCI --- I915
>=20
> > +	    subcomponent !=3D I915_COMPONENT_GSC_PROXY)
> > +		return 0;
> > +
> > +	base =3D base->parent;
> > +	if (!base) /* mei device */
> > +		return 0;
>=20
> How can a device not have a parent?

This one should be proxy device on mei bus, so parent should be there alway=
s, can drop this check.

>=20
> > +
> > +	base =3D base->parent; /* pci device */
>=20
> You don't know this is a pci device :(

This is more, like, note to explain on what level in above scheme we are no=
w.
It should be mei pci device for match to succeed.

>=20
> If it is, then pass in a REAL pci device structure please.
>=20
> > +
> > +	dev =3D dev->parent;
> > +	return (base && dev && dev =3D=3D base);
>=20
> I do not understand this statement at all, what are you doing here?
>=20
> confused,

Hope that scheme above explains the relations between devices.
>=20
> greg k-h


--=20
Thanks,
Sasha


