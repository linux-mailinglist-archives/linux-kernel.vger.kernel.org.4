Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E96EF9D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbjDZSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjDZSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:11:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD283D7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682532694; x=1714068694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mrU4EjiFweQiTGCFFuOKcWycP7mP8FyEajwEqseZSZI=;
  b=L1q/lDeKQFEBxVtfr3Ob+AEDGm9PVLgPMOWZhKEeB7Vt7BzIaxwwfFI5
   PhMpuV1mRPVEKNQqMfAJzd5wAZnPKSorDLALnIF7atl12ALDovDWKnQTn
   wTIvF2k+cNTaqbWC1/94CRjjVgOU0NGx8a7VAjvUooIWNKPlGn5mCVAXn
   gyzZ5IaRygLSMhm9CKAC/Y7hYXqQ5rZJ3Bwaxcu0nanmAQFmbhiAF/91z
   MxKvzzO5YtGIBbUUgl1S2fbp4wriAeToWwEzeaKwBZjiF7CtPRqp8aj+E
   55qM1ZMTrcaBc5ViZ/2W7cKhHbxvThmpvt+UHHCDwqJ1RpAYoVt1CGnm1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="345952733"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="345952733"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 11:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="694049815"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="694049815"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2023 11:11:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 11:11:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 11:11:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 11:11:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 11:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iigZbnqvb5tVvOG97nJkFxd1VgT0do0glWF7fnV7DBKPRXYnZwku+Wbu4tPSTZlLDQIICf+9FccbzvyU37kCqgiDtc8krT+Sb+TuSgG0ZXVT2sORgEdl/EKNvExFrQXhbvJEoOQ12zy4PJ6i0vKZBQHXrN1pkcf1vk0PwLzIfnTl2Oi5KNrIleJ9ovG4HqVqgGd0+ZvFYBOu1bo7YYPsDGAlzlyVglPAHcolFGE/Vk/4ISBuvp5CgRO2dGIh90WCm7iRj8F9oHPiJEqs/qJdQJzQqxvv1sgxYC8UWtiBRxlKzXvTYUhaSDj/pHx1BZaJztLXtws95ejBSNpAtAUYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pq0oLedJurDKtqVuRDJjuuPU4a0y9pBDtvzFANu6B70=;
 b=NhSLudJq85GAr5oBTukW89lZ4nOtoJKjE0rXJYkyW/h5TUxxWaaNPjGup0EKFKrLXaLZmvF6dShUJH8zvTf14ttYz7rI2DW+zci8At9E4CoHcw49dmrgDaJ0D2oE2iY5KbIt25gINdYqNAOt/131b2rw+vWnFP8Rfmdo+XdMx2JOQETvSUkyNzZvM/b96mv9IjmD6Z/ifZcRTN9RyJIlkkZDhka9k3T5+ixKg4RYlqiv1lWXuuugLVHPQZR82xszMvS+3Y7Nq1ft/uDQerRvN5d12HjWaze8sWwJsgv/HwngyN20TzYXnEMhYyVMcgbYaadxnkVb2VXEQf8z3ujmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by IA1PR11MB7822.namprd11.prod.outlook.com (2603:10b6:208:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 18:11:27 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::377f:416d:7be1:8f9a]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::377f:416d:7be1:8f9a%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 18:11:27 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Adam Borowski <kilobyte@angband.pl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Thread-Topic: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Thread-Index: AQHZderH+wsq6lIxj02Y7iezAU/Pd687czNQgAB5swCAAB4tAIAAHfEAgABrM4CAAVOV8A==
Date:   Wed, 26 Apr 2023 18:11:26 +0000
Message-ID: <MN2PR11MB4093C51F94BC3CDDC1F34968E5659@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20230423135124.55196-1-kilobyte@angband.pl>
 <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
 <20230425115210.GA4151911@angband.pl>
 <2023042502-resolute-divisible-fbff@gregkh>
 <20230425152720.GA4155584@angband.pl>
 <a8840c41-6245-4531-8b23-5c4e594c1ca9@app.fastmail.com>
In-Reply-To: <a8840c41-6245-4531-8b23-5c4e594c1ca9@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|IA1PR11MB7822:EE_
x-ms-office365-filtering-correlation-id: fa54a071-7da6-4e59-9045-08db4681a700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fm0EpnEzgh8aQbzlo9KLdqkEnArOs/0i/nHTgqeFx7g3p4JXTLzaXIy7zTIaeWqrNEalNmwGWQaH1Rfcnwc8127OpSK8ROtTlSG44BWbJH9PWJjk4hp8xmH5zjoqQzEgSAgK0nXk7J3lxZTcBAoZBswxtQ4H2PnpHB/H9e5UkqljROhnutc8Xg+QUR75ppDYFpzS7NUEl3/g0ZneiMRinNX7HSuJL/1HTmryN+zDfO+e4+84Iz+5BCoL+aKm+I4J4OGRWJkcs1tlZ89unXHtUzP7Me3ThaBI1LYLMYmRjsMuG5099/HMoioVm/8dfWsHlzicxSwiO5ycyWAUOohzKM+RIuV74Wkcz+Emu0AZ2mdU6Y05SRnqhCqqha53FU3e7XcGLjLvdPD/shKi04gg0trV5vtdTMdDNB7E0Ezp7m3df6WPfYuVe/IcTAE/I3chSK2HOMJFDZJ0nYzlLViUafCXkCd981UaPLKc3rZiV4W4eBCdHm/cIfXhF8bvCTkeuPitUnuNU/kEZ87Mrlzi2MXgRVIgPszsV0lZURfEAC37LTJmpF7l8Kzkdofx0vi1Jx71onMYNInS3eQ1c6NvmiRSRYBpYxc8JfADTmX9SpyrFIGdP+Ji6MDm1gYzGm9n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(478600001)(110136005)(54906003)(86362001)(107886003)(186003)(26005)(9686003)(55016003)(6506007)(33656002)(71200400001)(82960400001)(316002)(66446008)(66476007)(64756008)(66556008)(83380400001)(66946007)(4326008)(76116006)(2906002)(41300700001)(8676002)(122000001)(38100700002)(7696005)(38070700005)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nl4wEitsqX3MT1GYnNs9+rTA8atWLQuEvDeONSnSlzzJiPw9cB5ZnKQhExQS?=
 =?us-ascii?Q?2PTmj6jzWQR7xU3rSFU2O7lYPtjDL3/QR8TE60CbbjzX/Kn6MAn4T/ZMPRDW?=
 =?us-ascii?Q?srmWPY0Ikh2EMxIvUdNSnc3d/n85FxUHPRov79CyuzCL/GoEC+wlPle5EyfQ?=
 =?us-ascii?Q?wpgaN1z/mhcQ4hkhlgqDHv6JYwVUC1YM4LDlAoOvWbY5VSG4/SwdTwUkPBH5?=
 =?us-ascii?Q?r3uVEh1bripQC3G8TsNLhDMzaoCLAnAtUnZCx+81yyB3ccCk1sGi3l8S3VU4?=
 =?us-ascii?Q?hqjz1O+E+xmQxbYRlceHW4JuvqzBA2hkZM2RzCsXeurfIsuK7UCegPFSQnFq?=
 =?us-ascii?Q?yYAbhQ8l+O5JgI9Cs1CRIelSkY3hogwSLiqnNsSXNuvpmiIEmf1J/CE6i8Aa?=
 =?us-ascii?Q?p6wpI1Z7lcCMRb+/1HPvy5eFxdJa00C9nO+lYrZzHHgDbqk5Q2IH5lcW2yFT?=
 =?us-ascii?Q?UtLn6uCuU0r44P2cM+OvnBo2+NlKtW5XMMFWGPjKYk14THyhB5UqY1WuAKtc?=
 =?us-ascii?Q?751QTXBtS4aHKDJAD17XigyPgaKjxdD/Xv3rTK8LjhjT2vWv3ouJDsqo+ih+?=
 =?us-ascii?Q?s5X0OUH1g13WyoW+DeDAvBGQL/kP65ss9jPfGVgALNnGt8gCFpCBdoNafSTk?=
 =?us-ascii?Q?9EEpqRL0s+Wy3viI/BRKX2FZ8zg7jHxWu+QHOOiBGBVJJDQaExGqPE5Z5zOW?=
 =?us-ascii?Q?fT3sJg9Fli+MIaO9koO8qvdR3jpTAMf9cF+KRnm6xxZE5kpDKXetEK5AVdY5?=
 =?us-ascii?Q?iuu9RE2mQL/HRxAH9tpDzvOs4z7wJjCsxzK5BZ50vKvPtYsqRM9F0A4AKbF9?=
 =?us-ascii?Q?ILkQQXSMFckPwcrJciNkQryEuK8xyrvzkewed9wCLytJNgQJAyC/7mWtLe9Y?=
 =?us-ascii?Q?kyoz/Hg2EFIV23GyDaxIopQE//78p2pHE9nHPPYqK1vn5Ymu7JhWIJN3RE25?=
 =?us-ascii?Q?3QA/J1+QkIZYME0soSIJ3RVYhGnS97g+84Hv3Zy5MA42KOI+LRmulKtuR/Fq?=
 =?us-ascii?Q?iogUqixWjuZB3wPyFAWWTXolx7ShE/Rdes17+9P3j5zl3V0cTL+oasFoy2gD?=
 =?us-ascii?Q?WMaAWhffsEFGCIaUTTI8hwHgGQWSkU+sHLk3oSYJ6l7T23mlPduVuKjQ+IHp?=
 =?us-ascii?Q?GlZOt8P11ASiBFkhcIswSSMErwuhe8Gpw6yIXIC2svBYMAchIhcX3brILNmY?=
 =?us-ascii?Q?jNVwWx2jxhWR4NF+Ct3dADoPFYmC8QWN9UPCjx07u5f51CavrEUYbUjt6MQd?=
 =?us-ascii?Q?hfwFj8Rw6Phto8mI9f9uK9VByHRxX3Za6ZpaJmc0JRdJcvJiAsHjFOSEapai?=
 =?us-ascii?Q?LHT3XPdfaCRgN8dUMfrp85ZeBbtSJJj1Rf3O/xW4LJSqtQy0Bj5pPEfTtZnu?=
 =?us-ascii?Q?naFPfV1c4a9sWWC6b/lHMurPOVvsatFQWXwvHSbC8ZpvDngIro9FJ3UKJPvT?=
 =?us-ascii?Q?hSXLnX51gNB/BLXQ3dHZdJelB+sQRpRVXfOAQSZjtHgIVZ2CIRXssXb3Z/yW?=
 =?us-ascii?Q?1Na0oFd3JHTOgMP3uKiyFHemHLSjMxaJDPPzeBzfyS6W3MpJsuxPHG3XA7UU?=
 =?us-ascii?Q?bfziAUp3y6nB3KOK3ezeGiAnkbEMedlC6uShW68q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa54a071-7da6-4e59-9045-08db4681a700
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 18:11:26.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ca5TaIpOL/Z1868bc8c6YyhWfxP4FPkcGw6wGv20aKUeYP12CseYIv6NO3f1tV+gTjxN+K1tZIOrQnVCmg+Zmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7822
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Tue, Apr 25, 2023, at 16:27, Adam Borowski wrote:
> > On Tue, Apr 25, 2023 at 03:40:10PM +0200, Greg Kroah-Hartman wrote:
> >> On Tue, Apr 25, 2023 at 01:52:10PM +0200, Adam Borowski wrote:
> >> > On Tue, Apr 25, 2023 at 04:39:23AM +0000, Winkler, Tomas wrote:
> >> > > What is the exact issue you are experiencing, can you add the erro=
r
> message this fixes?
> >> >
> >> > The problem doesn't trigger in mainline
> >>
> >> Then it's nothing we need to worry about in mainline.  If/when other
> >> changes ever happen to need it here in mainline, we will gladly take
> >> the change.
> >>
> >> For obvious reasons, we can't take patches for issues outside of our
> >> codebase.  Nor do you want us to, as that way lies madness and an
> >> unmaintainable mess.
> >
> > The problem in mainline is inconsistency: out of 6 config items, 4
> > repeat the "depends on X86 && PCI" line, the other 2 do not.  There's
> > indeed no immediate functional issue, but I'd argue that a dormant bug =
is
> still a bug.

The MEI protocol (CONFIG_INTEL_MEI) is not PCI or X86 dependent.=20
INTEL_MEI_GSC is PCI dependent but not X86. (Hope I correct also on impleme=
ntation side)
They HW layers are currently X86 dependent.=20

> >
> > So we can fix the cosmetic (currently) issue on its own, or as part of
> > the large patchset -- the latter having a side effect of stuffing your
> > mailboxes more than needed (neither Greg, Arnd, nor Tomas are involved
> in other bits).
> >
> > But do the selects really require so much duplication?  Perhaps I'm
> > trying to fix the underlying issue wrong?
>=20
> I think something along these lines would do (untested):
>=20
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> d21486d69df2..8e5d79cff80b 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
> -config INTEL_MEI
> +menuconfig INTEL_MEI
>         tristate "Intel Management Engine Interface"
>         depends on X86 && PCI
>         help
> @@ -13,8 +13,6 @@ config INTEL_MEI
>=20
>  config INTEL_MEI_ME
>         tristate "ME Enabled Intel Chipsets"
> -       select INTEL_MEI
> -       depends on X86 && PCI
>         help
>           MEI support for ME Enabled Intel chipsets.
>=20
> @@ -38,8 +36,6 @@ config INTEL_MEI_ME
>=20
>  config INTEL_MEI_TXE
>         tristate "Intel Trusted Execution Environment with ME Interface"
> -       select INTEL_MEI
> -       depends on X86 && PCI
>         help
>           MEI Support for Trusted Execution Environment device on Intel S=
oCs
>=20
> @@ -48,9 +44,7 @@ config INTEL_MEI_TXE
>=20
>  config INTEL_MEI_GSC
>         tristate "Intel MEI GSC embedded device"
> -       depends on INTEL_MEI
>         depends on INTEL_MEI_ME
> -       depends on X86 && PCI
>         depends on DRM_I915
>         help
>           Intel auxiliary driver for GSC devices embedded in Intel graphi=
cs devices.
> @@ -63,3 +57,4 @@ config INTEL_MEI_GSC
>  source "drivers/misc/mei/hdcp/Kconfig"
>  source "drivers/misc/mei/pxp/Kconfig"
>=20
> +endmenu
