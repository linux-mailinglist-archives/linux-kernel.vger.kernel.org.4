Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD6708B53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjERWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjERWLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:11:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B8E7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684447863; x=1715983863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tC9Rhf5WjgJXrL6B5TqfqZe8zxM4pPUesZytp1HWBds=;
  b=nqA9ILgNkOSYnA3zZlKUyvA71NtIRblUaj1XtnScEzHnxm6d4+/neutf
   u6CwqNzfPwBaWjnMgYE4TexMTB+1URfqjN6LQb6QN0KNcJiHMY3DNgnAM
   1XXFRfEc7E3xfwzfV9Mba91umzU7BtaQWYnICEYvzHC8kn2/y3WFL2SyK
   MsCz62rQ6IPgz3EvzrXZTceRlwTVMwxdURiCFfZxGvn/is24m0dpDIcYQ
   aYmBJ8cvdOpVh0zNi7IkVeZqUuQvZSCThXhjVD1BXQHqewfgfrt5KoXyH
   8pqzipLskpD/G9NiQNDFf0LDOXfW8NKi7NKDFfPeTN8JrImCe7YzVoI5D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349724402"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="349724402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 15:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="733057673"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="733057673"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 18 May 2023 15:11:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 15:11:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 15:11:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 15:11:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 15:11:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiFqOS5I6XthwiI23haJmzNukjTrRQbN4qFq5esL2+gGI97EtfP0fb1u5HoiZWmnl6JgVqaum+aKw3+jbmvwSF5Meol14E+jtedmANc8QrwLWxpEQt2R4rENFLTjwvrPVe437sVgfMuJb/KjyQfEQFZhWZ5FLaM+5+WnAcxineT5msT+soKarrtg+rkkP5GBQ8Uu/U5jDpygjTugrfk/UAoUG8h4xbeoeord0JFXaqQgVmH+OW3Bxu7D0rYd85mDLkfUpUaLI/teJGbuXNL3XRGBqIjtmKau3xyHT71gVr31S12STAtBKg5WxCt0027wrgzidwP5cabayVSZhwVztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC9Rhf5WjgJXrL6B5TqfqZe8zxM4pPUesZytp1HWBds=;
 b=CfGEs71II88k190E29Ndf9AenyQ9PfeU4iJ4IYXrLwMggmJpOXImbFB+XRP1YH8JfwCvO0NrUvCbS07R/oRazXwCGfbcQ7bgBVdZavwDR6P/B9V68wF5kGdP4rANJ4X8+YScQSwp5zHLWxcxpFbPbCyjGJrW3cCUozFB1I5676b5H1B6DymYUac83X/LF3F56AM6PfdezVWAtEUlghkd+bSPb2/qBUbvDVyzkzhWA4HAbc6+DJy2Ivsg6f78wW1GxPNPl27+zZ0VDbHKEXuMPFSHLoxM78wBHt6ldaudzcGkZ7wuEy7F+g9x4VJ1XEC3FFK9Mkm4u5owiSo8eVz1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB8286.namprd11.prod.outlook.com (2603:10b6:510:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 22:10:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Thu, 18 May 2023
 22:10:55 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "chu, jane" <jane.chu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alexander Potapenko <glider@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] mm, hwpoison: When copy-on-write hits poison, take
 page offline
Thread-Topic: [PATCH v4 2/2] mm, hwpoison: When copy-on-write hits poison,
 take page offline
Thread-Index: AQHY7WThgEScdQdixEmT/TX48zilO69hyoYAgAAE4lA=
Date:   Thu, 18 May 2023 22:10:54 +0000
Message-ID: <SJ1PR11MB608356FDC4AA3C5591384C5DFC7F9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221021200120.175753-1-tony.luck@intel.com>
 <20221031201029.102123-1-tony.luck@intel.com>
 <20221031201029.102123-3-tony.luck@intel.com>
 <71cdf8cc-a640-ec06-fca5-ed4d948c4880@oracle.com>
In-Reply-To: <71cdf8cc-a640-ec06-fca5-ed4d948c4880@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB8286:EE_
x-ms-office365-filtering-correlation-id: 2abf337e-0e79-4832-2f38-08db57ecc014
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zz9xM22NxjmEPmb5fJbt8ZWsphpUE+DNT0zFZQIvEt6RlojKh2lGNw6OEN/OuUsxuLLnJq/hDlJUwOsRUcmpOaBQVL1oRqks/Jg553kdBYMGvqlQGVXu6uXaiXfZd5gesgu8ir8MX063yy7hNGe4Mm07ySOkvPozDCX8Oie6ETp4cqd6sES1ZXzk4MU4dyOM85ALnh36Nw87DG6CDIfyl9yxmDEmmsJ8eBXfRL1rI0MKBYLGc7dMVjhWBa6sG7ucuxEg1sF5unwLcz8F4zuPrhztQwwROvkyvXOzGYXFuY4wej4TlZ3KE7e5DZhhzcVW1baU60k8bOf/9c1s1+dbNtvEB07MddaWfH/RF1zmWxMDOIGC5Swt6HnzMA6x7xm3j2mCqO6qvHZ7JRSSXvH2ofr/4yUMZ2/nBObnYB1WW2K8D2PsX64E6oTvKKNCPf7SOVL36KwcDHD/a4qvIDfw/UM78Yx0hGtwPdigquABAaoHQ+XXc7LUPdLgsFhwF4LCibZPzC+iz1/JZC/eWcEnAj9eJ9GUtKT0uy8KoYw7ZwSFyMj44cHEpRHHY8RAb5IMV/wP+4dkSeKvp4XV0UA8HalwEqS3e4JCesqh2hkwghwRq5NQfaup3fgfoDYYTOdp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(6506007)(26005)(9686003)(53546011)(83380400001)(38100700002)(33656002)(122000001)(86362001)(38070700005)(82960400001)(186003)(55016003)(54906003)(7416002)(110136005)(478600001)(2906002)(8676002)(4326008)(8936002)(316002)(41300700001)(52536014)(5660300002)(66476007)(66556008)(66446008)(76116006)(66946007)(64756008)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3p3ZC9TMDkxRkNXNG1pdWxOd3FEeWNWWXhVbkZVMUhISXpERHFtVmdkaXY2?=
 =?utf-8?B?RjBjV2UrQWErWVVYN2ZwUjUyenc4dDgvQUpDTzlPZnIwVEtNWEhuV1NaRGRq?=
 =?utf-8?B?b05vamR2dDREaDdJQjJGSS9CRXR5Uk1HNXBJRWJBbXYwYXpKalFDcjl5Vy9K?=
 =?utf-8?B?MVRIcm04b3NyeldUZnlEQ1RZSmpQMVRpeVo1RnZBQVhick40RjhPSElCeVdH?=
 =?utf-8?B?VWtMN2k0N2wrWDhZSjljekxWWWxHK2dGUjg3OGxmQzhWalRvY0RpRGMvb0w1?=
 =?utf-8?B?N2hTUUJHK3ZiWU5FVHRub2NYMGV1bzBoSUJnUG00M0JtZ3hYcFJud2psNnBK?=
 =?utf-8?B?N0RibmFvNkUwcXJDa285Q3VkckRNWTBJWVFFL3lXMDBUT0FpcXlRNUJic1VB?=
 =?utf-8?B?cFR0dlhPeDFBMTg4T0NoVXZsR3R1cDlJeHcwYy9oZjNpUHIvckplcC9LTGpD?=
 =?utf-8?B?K09rbWRqbjhPMTA0WHRoMm9JVGwxcWk2Wk9IQU5EUklzNUJ3SFNkek5hUzZM?=
 =?utf-8?B?RDhTRFBNSVI4bDZGcGVkb3I4OXFOKzM0TndzTmhQVDExQkp0eDQraFRLTkFE?=
 =?utf-8?B?ZTBDU2F5U3k4WVd6YXhzL1R0emNDMnFDL0FaQjErU2l4cjVIRTMrTVk4cHNB?=
 =?utf-8?B?SEpHQTYra0g0aG5zQ2lqUGRqZzl6d2JlRGpFVGJ5ajBzNnl4bmkzTFJUcUVq?=
 =?utf-8?B?WHBDNlYreThJVHRjbnZ0TU1vU010aHhsbTliSjNzcTdjMm1meFM0VXFOS3RM?=
 =?utf-8?B?cXB0YzRhKzVZSUtnL2s1VENCK2FoazgwZjFVU21LSFNaUnRodnFST1JqNElR?=
 =?utf-8?B?VU4wOVVWRis1SEFkVFVvL2s3R2drT3E3M0NRVTJnZFhZK0NNZXlTRE53UU9p?=
 =?utf-8?B?VGgzN1QxUEhDb1JvMHFxUFcrbTNFM1I3c25rQU81aXRWblpQMlNxdU9STlJF?=
 =?utf-8?B?SVQyRGJSOXU4QjY5c2Y0MHFscUJ6UWQyanJ6NlVNano2Z1ZYcUsrS1Erb0kw?=
 =?utf-8?B?YktqQm1vbUJFQXp2dVkrL2lyQ1RQWW9LSjFxS3hiQzNwM0lnZ0xpSzVHZGpX?=
 =?utf-8?B?WHljczFLUFR5MlhzUkJiUjY0NmpGSkZqTEJUUDJIeUo4c05pYVR6ZTBhQ0xq?=
 =?utf-8?B?ZmJ1a0tCV0VjQVIvRTlZSm1iRFVQWmUwN2ZjVXFaOFlpUi90UlJwRCttQ21F?=
 =?utf-8?B?ZS9CNUpsUitCbjFWc0thRVVXK0w5SlllOTZiVGlSbkhSd01SaXUyQ3c0K2FN?=
 =?utf-8?B?eVJaUyszRDRXS2ZzR1ZzOTRTNnh6L3BDUTBlUzRHUXZGRGswc09PdDJqaE9J?=
 =?utf-8?B?M0s1MVFEbFpuN2FNQWVxUHBTYzVBaVFzRjNDZVNzaG40OEJsQU5rdmV4K3l4?=
 =?utf-8?B?NTFXTU9PaDNWcXNkYSs3bGRsbElxOFZTQTlVK1RRN0dFN29MWWJpTTY1NHps?=
 =?utf-8?B?QTBtaTNKUUVmS3ltWk1rWjErREwzOU9ML3FOSWF6ZXA1N3JrUUV6bGhRdlZC?=
 =?utf-8?B?NVlNODRvazNIY2UrUWpVQXg0M214b1RUQXhvTEJQV1RxeEx6dld5ZkQwUGVa?=
 =?utf-8?B?VExpREtmM0dIRDRiQnhqMlpHcm12S0Z5ek81UkY3QjE3VW1vNkhNcTIxNlRh?=
 =?utf-8?B?RWtBS0s0Y1RqeHpTc0NoU2IzR0xIT2Y4WjJWNTYwdDJhU1FDN2ZXc2VmSStQ?=
 =?utf-8?B?QTFPVnV0VHQ1U2NraVQ5S2xyMXdqMDcraWprbkpzYUx5Y1hxenVWdC9DM1V1?=
 =?utf-8?B?NG5mL0hmYStCNDhwcUFTSHArSm1JM1l6MS85aGs5MWpWMHRUSEhmVlY4OTdZ?=
 =?utf-8?B?WUZFMHJNbyttdjJDbjJ0TEVYVzczbk53U2hZbUF2c01jT01iUHlZbHgyWk9q?=
 =?utf-8?B?ZlFrblpDQXluKzlKbUFDQm5WaVNPU1FKWWtNanYwM1pBdkdwdEdPRjlvY2RS?=
 =?utf-8?B?THhnaWF6c2JZQUJocS9Zc2hRM1ZucStjbFNHNWhKWllrVzMwdXloL1VYa3Jw?=
 =?utf-8?B?SXd3Ujd1WXJ0VUx1ZmQ4N1RMcEtBSzhYYmF3VVdidzdBRThwallxNUF4b1hQ?=
 =?utf-8?B?RE4zNHFyaU1oNkJxc04wUEFuSUpNcHpYR0FtdVRCSm1CMnN4RFNMdVBibW5Q?=
 =?utf-8?Q?N3oo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf337e-0e79-4832-2f38-08db57ecc014
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 22:10:54.9309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8pcpRAlz2xN+WUJ/LlSP+OOa87kw1pO9OpFisxl5G41bN7dcPQxc0HmTKn1fQb/mx0u/GvmlrM5wO7L+g8k2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8286
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

SmFuZSwNCg0KWW91IHNob3VsZCBkbyBzb21lIGFuYWx5c2lzIGFuZCB0ZXN0aW5nIHRvIG1ha2Ug
c3VyZSB0aGF0IGFwcGx5aW5nIGp1c3QgdGhpcyBwYXRjaCB0byA1LjE1Lnkgd29ya3MuIFRoZXJl
IGhhcyBiZWVuIGEgYnVuY2ggb2YgcmVjb3ZlcnkgY2hhbmdlcyBhbmQgSSdtIG5vdCBzdXJlIGlm
IHRoaXMgZGVwZW5kcyBvbiBvdGhlciBjaGFuZ2VzLg0KDQotVG9ueQ0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuZSBDaHUgPGphbmUuY2h1QG9yYWNsZS5jb20+IA0KU2Vu
dDogVGh1cnNkYXksIE1heSAxOCwgMjAyMyAyOjUwIFBNDQpUbzogTHVjaywgVG9ueSA8dG9ueS5s
dWNrQGludGVsLmNvbT47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+
OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KQ2M6IEFs
ZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPjsgTmFveWEgSG9yaWd1Y2hpIDxu
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbT47IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29t
PjsgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+OyBTaHVhaSBYdWUgPHh1ZXNo
dWFpQGxpbnV4LmFsaWJhYmEuY29tPjsgV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb20+OyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8yXSBtbSwgaHdwb2lzb246IFdoZW4gY29weS1v
bi13cml0ZSBoaXRzIHBvaXNvbiwgdGFrZSBwYWdlIG9mZmxpbmUNCg0KSGksIFRvbnksIEdyZWcs
DQoNCkRvZXMgaXQgbWFrZSBzZW5zZSB0byBpbmNsdWRlIHRoaXMgcGF0Y2ggc2VyaWVzIGluIHRo
ZQ0KNS4xNS55IExUUyBrZXJuZWw/ICBJIGp1c3QgY2hlY2tlZDogaXQncyBub3QgaW4gNS4xNS4x
MTIuDQoNClRoYW5rcyENCi1qYW5lDQoNCg0KT24gMTAvMzEvMjAyMiAxOjEwIFBNLCBUb255IEx1
Y2sgd3JvdGU6DQo+IENhbm5vdCBjYWxsIG1lbW9yeV9mYWlsdXJlKCkgZGlyZWN0bHkgZnJvbSB0
aGUgZmF1bHQgaGFuZGxlciBiZWNhdXNlDQo+IG1tYXBfbG9jayAoYW5kIG90aGVycykgYXJlIGhl
bGQuDQo+IA0KPiBJdCBpcyBpbXBvcnRhbnQsIGJ1dCBub3QgdXJnZW50LCB0byBtYXJrIHRoZSBz
b3VyY2UgcGFnZSBhcyBoL3cgcG9pc29uZWQNCj4gYW5kIHVubWFwIGl0IGZyb20gb3RoZXIgdGFz
a3MuDQo+IA0KPiBVc2UgbWVtb3J5X2ZhaWx1cmVfcXVldWUoKSB0byByZXF1ZXN0IGEgY2FsbCB0
byBtZW1vcnlfZmFpbHVyZSgpIGZvciB0aGUNCj4gcGFnZSB3aXRoIHRoZSBlcnJvci4NCj4gDQo+
IEFsc28gcHJvdmlkZSBhIHN0dWIgdmVyc2lvbiBmb3IgQ09ORklHX01FTU9SWV9GQUlMVVJFPW4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4g
VGVzdGVkLWJ5OiBTaHVhaSBYdWUgPHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IE1lc3NhZ2UtSWQ6
IDwyMDIyMTAyMTIwMDEyMC4xNzU3NTMtMy10b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1
ZGUvbGludXgvbW0uaCB8IDUgKysrKy0NCj4gICBtbS9tZW1vcnkuYyAgICAgICAgfCA0ICsrKy0N
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgN
Cj4gaW5kZXggOGJiY2NjYmM1NTY1Li4wM2NlZDY1OWViNTggMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvbW0uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gQEAgLTMyNjgsNyAr
MzI2OCw2IEBAIGVudW0gbWZfZmxhZ3Mgew0KPiAgIGludCBtZl9kYXhfa2lsbF9wcm9jcyhzdHJ1
Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBpbmRleCwNCj4gICAJCSAgICAgIHVu
c2lnbmVkIGxvbmcgY291bnQsIGludCBtZl9mbGFncyk7DQo+ICAgZXh0ZXJuIGludCBtZW1vcnlf
ZmFpbHVyZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsNCj4gLWV4dGVybiB2b2lkIG1l
bW9yeV9mYWlsdXJlX3F1ZXVlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpOw0KPiAgIGV4
dGVybiB2b2lkIG1lbW9yeV9mYWlsdXJlX3F1ZXVlX2tpY2soaW50IGNwdSk7DQo+ICAgZXh0ZXJu
IGludCB1bnBvaXNvbl9tZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pOw0KPiAgIGV4dGVybiBpbnQg
c3lzY3RsX21lbW9yeV9mYWlsdXJlX2Vhcmx5X2tpbGw7DQo+IEBAIC0zMjc3LDggKzMyNzYsMTIg
QEAgZXh0ZXJuIHZvaWQgc2hha2VfcGFnZShzdHJ1Y3QgcGFnZSAqcCk7DQo+ICAgZXh0ZXJuIGF0
b21pY19sb25nX3QgbnVtX3BvaXNvbmVkX3BhZ2VzIF9fcmVhZF9tb3N0bHk7DQo+ICAgZXh0ZXJu
IGludCBzb2Z0X29mZmxpbmVfcGFnZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsNCj4g
ICAjaWZkZWYgQ09ORklHX01FTU9SWV9GQUlMVVJFDQo+ICtleHRlcm4gdm9pZCBtZW1vcnlfZmFp
bHVyZV9xdWV1ZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsNCj4gICBleHRlcm4gaW50
IF9fZ2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lzb24odW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFn
cyk7DQo+ICAgI2Vsc2UNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBtZW1vcnlfZmFpbHVyZV9xdWV1
ZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiArew0KPiArfQ0KPiAgIHN0YXRpYyBp
bmxpbmUgaW50IF9fZ2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lzb24odW5zaWduZWQgbG9uZyBwZm4s
IGludCBmbGFncykNCj4gICB7DQo+ICAgCXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVt
b3J5LmMgYi9tbS9tZW1vcnkuYw0KPiBpbmRleCBiNjA1NmVlZjJmNzIuLmVhZTI0MjM1MTcyNiAx
MDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LmMNCj4gKysrIGIvbW0vbWVtb3J5LmMNCj4gQEAgLTI4
NjYsOCArMjg2NiwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBfX3dwX3BhZ2VfY29weV91c2VyKHN0
cnVjdCBwYWdlICpkc3QsIHN0cnVjdCBwYWdlICpzcmMsDQo+ICAgCXVuc2lnbmVkIGxvbmcgYWRk
ciA9IHZtZi0+YWRkcmVzczsNCj4gICANCj4gICAJaWYgKGxpa2VseShzcmMpKSB7DQo+IC0JCWlm
IChjb3B5X21jX3VzZXJfaGlnaHBhZ2UoZHN0LCBzcmMsIGFkZHIsIHZtYSkpDQo+ICsJCWlmIChj
b3B5X21jX3VzZXJfaGlnaHBhZ2UoZHN0LCBzcmMsIGFkZHIsIHZtYSkpIHsNCj4gKwkJCW1lbW9y
eV9mYWlsdXJlX3F1ZXVlKHBhZ2VfdG9fcGZuKHNyYyksIDApOw0KPiAgIAkJCXJldHVybiAtRUhX
UE9JU09OOw0KPiArCQl9DQo+ICAgCQlyZXR1cm4gMDsNCj4gICAJfQ0KPiAgIA0K
