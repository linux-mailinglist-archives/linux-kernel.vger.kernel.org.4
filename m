Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC03E68EF04
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBHMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:35:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F463BDA6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675859722; x=1707395722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XU53tGsNMuXb/TrL1yoYLWrd1Cug68sDU5BqtxM8s/I=;
  b=Uhqa6aoFu3slXAjYQ1OG2yD+DPgHVsob/TmIzP4p2zWvs+EUytHo1NCJ
   l8H11bwXjlGckKHKqqdsElArtifrBmCTxkuIt64jGf1L6Jc7rpAuWgPaa
   qHU3x4PqJbc+80mGpZCDQ6H4IZnepn3UI5K0UVXuyN5vk0QMeuan3i8It
   C4OPmd3Rn2jt+GiHy3Ku5beBAZ1cAt+eLBFsTV/cSbOMGrwIydYackmwC
   BgGYtNtpFE/27kvsu/Vn/agKTD+MqKS3eWdxNR3qioHDf16CEakME6ohv
   PVHAnrJkgciiN+9asDz16mSz1v1563IoRGp66M3r6A6PYCTWnIosfQta3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309436121"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="309436121"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 04:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617198825"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617198825"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2023 04:35:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 04:35:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 04:35:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 04:35:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 04:35:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWDE5+PdRC9N+KwOCJhSzDTeYqXglmFMB9icHhCfKZ11Ta0hcFINiM/BQzN59XAD26ZpZKgTCiMrL0esIXVmb6L2L7SGIfL2Wfl5Xm3Wkf+AvGnH7dcHHv9BP3E27jegjrkO7wdyQG5IwrlwXfmS+Fwtvv8gQMLM1LQzTCGI33OQMM4vxl6FNqo9c3WsW11E09Fi43mgPW3JDRU4Rffw9k2L/omjXfDPfFOUSFp/lZszq5qPQWlG8JqL89hu6MxrWTuwPgUc03k84rguxqerZ92zqlMGengDQ7zwsfjhFruMyIe4UN0wyRbwmnesBhCvp2OtCy8GsNjL5dm6kjJ9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Oivbn1XIQKuS0SQJanICriEVRksrcbzTWgh1jMwHTg=;
 b=jUWfgVcc3fgdy0vYR5noZ3pFPffbGftf9D0v0jwE3AiOn+bPEc59u+v5MLBqzVhnyb7BXHCytKh2BoVa7/0D81P+aTQSEvdq6IrndMiTyE6OWgtm1ZS3QOY7PRXkoUgiKASddkaE5yAPllSH9VONMM8fQFJFQ3UTYRFatQa3T3tA1ql0ARNHIcfIGO4qW7xvjfSXJhmU+QWKCOJWcRxZkgZ2vzLjKojh3QsKyaD9fU+HpBS4kdOBjUIdXYVUBVEcYPoszJJwOVay7jVN09uQbUYXKLSckPGZGfXzFpLM7HIwir1zXX66+/N+Ah4Q3k/ZyI/H4xAlti7ofy5MVrON/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 12:35:12 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::5db6:f849:ad21:108a]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::5db6:f849:ad21:108a%7]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 12:35:11 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next v2 1/2] drm/i915/mtl: Define GSC Proxy component
 interface
Thread-Topic: [char-misc-next v2 1/2] drm/i915/mtl: Define GSC Proxy component
 interface
Thread-Index: AQHZOY1TxR734JuMiEKEBxuHd52pjK7E/ikAgAAB80A=
Date:   Wed, 8 Feb 2023 12:35:11 +0000
Message-ID: <MN2PR11MB4093B2B800D5B151DE2A0336E5D89@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20230205181132.191064-1-tomas.winkler@intel.com>
 <20230205181132.191064-2-tomas.winkler@intel.com>
 <Y+OVEGNnQXZSxNdG@kroah.com>
In-Reply-To: <Y+OVEGNnQXZSxNdG@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: 9a342ed3-1235-407f-e22b-08db09d0ebe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQ5qEZT2R23ZYkhqi/nGj+jTPlLZvLOWoAEY4qbNPm9sCRI/OFlGWxqedClVrpzc8UPK8SMbc+3S4ZAUN3EbBj3SquTR6owMr4EAYw9TMW+Q+xF3u1z7StqCet4dE65SgZ69dKx3AYix+VJC1lnzP+Sj9uuq5aVVOiGj+C3CuZx+sACBGLSymmMTGwXs6ZjrAiO4ygr9U5oPkXdBRJU54sktw/lg0f3OTHLwME/3NtxHJ72uMyUFS5d6pLigKzRx55pp6mKcM984NtK9Xri/r5iNQ5sBYK0VWL9mbWQhmmXMOEx/05qx+xSYOnQcNWlvgFdvLOcTzrdrSdaRCeWkSL4ehfwL67ib/RqsnPPDJ+41So1xnMpYIhOf2oGRQklaDOc3pj77tatME+3A8GezKSBGyu4K1heCE7imhYKEt2B3fr2wODXFyVm5mAjwQkbhdFIvz+NwaZdMyb5yqNity+WnvLnRWfeUuAom6ah3qlLU4UrauA3sg/HbX2ZBnfIUzA6rA/Qjkw85rDj0z4yoyYpweTRTNqz32bZsrp1PyafBG2co1t8m4xJ7hBmV+kjLp6dyCaUJYt0HHvLjgxkEo9foznE6U4HpBiEPNSmfxsd8u5PLUOFFR7tMbJtd1ysJ9XH+RGj2ExgG8sxwi2KGxZCz7OGrzh3ov2HYagXWKMi2pWm8/DdPpEeVKALmj4FL0QvCeE9K5svjkJ9YExl0cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199018)(86362001)(38070700005)(5660300002)(122000001)(41300700001)(38100700002)(2906002)(8936002)(82960400001)(52536014)(66446008)(66946007)(76116006)(4326008)(64756008)(66476007)(66556008)(6916009)(8676002)(83380400001)(54906003)(316002)(71200400001)(55016003)(9686003)(6506007)(7696005)(33656002)(26005)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wRk3Xhc0tbifZ1paMqthEIddbjoZ77Tfstsiv6UYc5VQBPVbUJ41wTeFDrfo?=
 =?us-ascii?Q?XhQ7IbuY3fvf0Vo7Z4NslSQHaHpRfalqX0bq67VJPzBLtFPO/jXH3736L2dY?=
 =?us-ascii?Q?5DO2z+l53jetsheR7jMuV13CCvBA+ohwDxuKZ7GfzZNj91jZLNe0+tiaIKKE?=
 =?us-ascii?Q?iCn+kSP7PQa40YcMEcPC2/KQuzE/77DM5O6YouYaB1ck3SyZwNSPAB7zZww8?=
 =?us-ascii?Q?g/CmI06Z4wszuP9tk3gkjv9P/Ntke0hkpF4RZpqipY6BNU0MuyYk/ITEPBT1?=
 =?us-ascii?Q?jVpXfl2oxiNp80Uk20RrMEWHYgmZCi716OQYtx28JER0UFn5AKe5Nxvi0cZC?=
 =?us-ascii?Q?e1eUM5t+FIdT5VDK6prW/7WK9kMAK8Z6tWkMQ6f44w6njcf6yH79K9wCAtQ2?=
 =?us-ascii?Q?LEM0fjSVnqZOaGcCJpt3CvVIk7yYbpeicEZ0tgysCR9D0K7wp9izv9RU/uRK?=
 =?us-ascii?Q?PG4xvYdk3yxRsCd5fNArkfggEuYaT/r8g7On+Zb7w3mpFey9KGgQbOeK9dYw?=
 =?us-ascii?Q?rJuO3FlAr2X822Au1yPwCW1raNeSDdWTcaHwE7IZE0NbsVPe6ZXZ5/jV8zDg?=
 =?us-ascii?Q?S+xme724K6YvCefNWFo39P8Uw8jRpdB/CzjkUMKLtp9w/RLWvTLL4P4JQ8YK?=
 =?us-ascii?Q?zI+UzeBD0Xr1Hh7pbZTIm3DVibaU0L1/GfdA2hU9iUhnwd9kLzUS/s/iuCib?=
 =?us-ascii?Q?mfDoZ9F9XmWcLTezTKZWVh7dyx8g5QuIWvZJUFysx/MuwQ45i0+y7tJDzZs7?=
 =?us-ascii?Q?51hO1bb8sRvu8JyUdf0yD4C+SmunkefIIAnfnzoQg93AWA6MfaMBC8SiTXAM?=
 =?us-ascii?Q?uKOmhbqUbWl1JXvdq0DVAODQN3v9WCFyh1Zok4aRh2b7mePqv//ZAl8XZD/n?=
 =?us-ascii?Q?rAC1K3zU4+UPA/aK3B08W5eSOFrJiQNZyL5wuUerSAC0s2iKN/Vxv0BObo3Y?=
 =?us-ascii?Q?4catIE67nT4ypJB5iy+4O4lnQqU+DPDQ633qwKS+WCoHn39h2GHhUy+UvOxL?=
 =?us-ascii?Q?iOmDUuPQ8cXPKFcHuUV3ukYwDsZ01LedCmRR4wmL2n6N/2URITWQDWqq5hrm?=
 =?us-ascii?Q?NOEQQh/LfbI2kM7TVbcnhxGSxdcIHRdIHGvvgtKJk2W7K25L2Y/5X3NvpClf?=
 =?us-ascii?Q?UNEtmKf9Vughfdx8iSWRwA5eROp7j41aE0rqcNzgkMkPOYYGEB3tgjiegd3G?=
 =?us-ascii?Q?GkPxzjvtDgzkgfyq+qigOn0yoUcg1n3+zMBpxghxUJnSWcr73/2GwdHAXCrh?=
 =?us-ascii?Q?J16xXTBmfTdY0pz9q8IQklm6bjh1dcNF4+USbVr6eFoZZjxsTY9if7F6QIyu?=
 =?us-ascii?Q?C8/wX4qDl8HCK1n8ruWqzHv78UstoEDFHJ7ZrdWAmWfzVmb11MVtlKXAYAUa?=
 =?us-ascii?Q?rOe5F80XjbBslKB3uHIr3c++ig15Sc1oAOlpWclRxQMIjd+pRiA4xijwUUlf?=
 =?us-ascii?Q?eK3r8d2gSPhsbmttDcpBFE3/AQx2YzaCKTVIWmjIws1XqztZuvXC6gf6Vpl5?=
 =?us-ascii?Q?9qwf6wJkQ6/AFwFj4U5c4z6+86tIzS9SBrxGRgnHepQcMKVbg/jLkiChkYvb?=
 =?us-ascii?Q?7Veh/3X98z5vMFIRXlQiUVoG9118UwksZrhSAsCu1QfpTjX9P+l38IVNRDLZ?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a342ed3-1235-407f-e22b-08db09d0ebe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 12:35:11.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODT2M7UjMXJJKiMp2ek6BvP7nyQRw5hJ+wO1L0aS47a2cOWC4tZFXejF8cAFpNdpeY4REIMXj4bXm1h3fRPXQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, Feb 05, 2023 at 08:11:31PM +0200, Tomas Winkler wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > GSC Proxy component is used for communication between the Intel
> > graphics driver and MEI driver.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> > V2: This patch was missing in the first series.
> >
> >  MAINTAINERS                                |  1 +
> >  include/drm/i915_component.h               |  3 +-
> >  include/drm/i915_gsc_proxy_mei_interface.h | 36
> > ++++++++++++++++++++++
> >  3 files changed, 39 insertions(+), 1 deletion(-)  create mode 100644
> > include/drm/i915_gsc_proxy_mei_interface.h
>=20
>=20
> Why do you add .h files in include/drm/ yet only use them in drivers/mei/=
 ?
>=20
> Shouldn't they just live in the mei subdir?  Especially given that you al=
so want
> to maintain them through the mei subsystem as per this change:

Rigth, will drop, this part.=20

>=20
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > c81bbb771678..2c432b4d8506 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10570,6 +10570,7 @@ S:	Supported
> >  F:	Documentation/driver-api/mei/*
> >  F:	drivers/misc/mei/
> >  F:	drivers/watchdog/mei_wdt.c
> > +F:	include/drm/i915_gsc_proxy_mei_interface.h
> >  F:	include/linux/mei_aux.h
> >  F:	include/linux/mei_cl_bus.h
> >  F:	include/uapi/linux/mei.h
>=20
> And I would need some i915 maintainer acks before I could take this in my
> tree.

Okay

>=20
> thanks,
>=20
> greg k-h
