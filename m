Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5173A57E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFVQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:02:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30ABC;
        Thu, 22 Jun 2023 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687449724; x=1718985724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=61ABeWMFGcMYUhsNRbDioCLTm+v9/AbKStq8Vovu2JI=;
  b=Zxm5pLaQQd7atIuKgGOncK8SUzj20CGn50dqSpGb5roAZPDxQIZjTllG
   FhNfo5zRkkWuhz6LNMSBHkyZAQqMozMkYy4mNpzQ+Sv2SdUZLyNHli/uz
   Pdz7dRTiD8D5+X/6rEqSHD7qWQMHRjAzgRu3BYR9gTdYeCAjhWnKR/CBY
   JkUQNg0DQxNJwSTtThreR3aV6l24aqZbba7YiPWWycdoT6jdO7B0WlgNd
   mXFHRhcQL8cwxxvORYWyssE1QotOk5gJ2fO02mJO0sx0CioVInAERX9A6
   r8w5SDca8HZNHI0MpgUK8c1S7YuLn72elTKYh9vtqwK7o1aU/H30Ebe2l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="363081152"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="363081152"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="665115875"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="665115875"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2023 09:02:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 09:01:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 09:01:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 09:01:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 09:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0jAdxeW+Pe+HCcn3y/XPNuz7AK+WNSjE8XH1jGAYSE/mu+cz4knB04aJwD/pFfFWCR+1b8bIqTvUjvcN/rYucO74hSlStECADA/5jRw1r3mpz7t1+2+neNXnKkrbapLav63Z16Txz3T/tfcjv6AgsRtcKDRCwn9Q+X3BIn0A26EUS91EXLmqJNt+WQbodlYPQbaYA3b6IfC6AAmBtBtebLwUGfRFrgznA1E/OaGBWw82Wop8ZE1aC29xODjxft9r8OlWZS4OungzWotBswAVx5qJdX6Fo1OAPcjcENDfg5/DF/nOXpi9vFxz6DI81tJaiek6eg9qJKgnIsqO0ckKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61ABeWMFGcMYUhsNRbDioCLTm+v9/AbKStq8Vovu2JI=;
 b=FF5iqe3wuY8W74NHQYw0M7AO4LZ3cOVAWrstVwLMETXmE3I8qZvZ3177TCpX9Qy673dADcYwPgRhEP/XwI56ZdhFk6E7zspqq4sSaU8AH4tFmsvbEMUNMK1X1Qjxl8lrn+4xvi6O/GcESHrtou2SC2HjjPtrNG+4tSkCTrCT8qYpL7qsyR3YFAhinuMIVQfIvQgcAbws9GD2rH+yYrgNXa+dfVsHbEBV3fe8JAn/USkwBiRWbC2oMFiKEVKSlnka4nSalrASgZpvAEjQ2uyihcub68moLLkgXpnrVNqBSKE47jfY12G2jogVCHMLp9jDlYh4ILOy58jSNg9nmlQ+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:01:53 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 16:01:53 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Topic: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Index: AQHZpGd48oRuL5v3EUiLea9/WFe4Sq+W4hEAgAAZ1OA=
Date:   Thu, 22 Jun 2023 16:01:53 +0000
Message-ID: <SJ1PR11MB60836CD7493B0EAF0F687051FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-8-tony.luck@intel.com>
 <CALPaoCgF04M0Jc-c4VmbKkRSFo677SBGoPHzNCSeQ4S6Bqb60w@mail.gmail.com>
In-Reply-To: <CALPaoCgF04M0Jc-c4VmbKkRSFo677SBGoPHzNCSeQ4S6Bqb60w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB4939:EE_
x-ms-office365-filtering-correlation-id: f13b6249-f0a9-427f-193b-08db7339ff4d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTq7PABYe6+uekYIGY2sCM3Xz4XmrKUhYrD21Z7sanb88Dr+hjzw4xQAz/PQr7cDVqvL1cbjUSX6NINpMGWKviCn+W9+gR8bm46JlL4ZQCWJQVLUoSnh/Th/RH7bLEJTHj4fJoS0dUumMuNPC0rz1cUkiBrkbqoWNWx6eVm4i1Qo016yyfhZhPXN6DtWVST36pjjiTMOnPUhurZKTZta9Ni6EtWr/AB5XNqX3bX+grNTV0l6Eh7FWUnqJ1UA8muL+Km+FtLjwPRIFdaHqD9hH/ilM2lXi0gBjyu9ReKoyraIEaz4m/19e7P8MoCOlminscNNq56Nyc7eIm91cgUpfJ8DF7fwCDlVDqE5YgAo0AWnVBLC5G0Lx/5FjDmpdIotAzmYIEqA8qaFzTlJrEOrAkYjVgWpDmke3jKJixrAR4nRov6hjnogUOm/XpNkUW87uyJlO1jOJPELzcH3HIAaC61CP/Zs8YK/FNqmanNGNb0hIoUl1EAOQ/6SrNforWofAbGA73Jksh2AOMGMbvgowVU7z2ZKnLpiTWAY3/M/f0Nft94le8Fgw8fji/h6IcJ3Fh5Kih7fsEIaTyApQaxyrS6pALlIqKvl61b6zwtbYfKu0db/XMukhXjUHomU2GRM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(7696005)(83380400001)(55016003)(9686003)(186003)(26005)(6506007)(6916009)(316002)(71200400001)(4326008)(66946007)(38100700002)(66556008)(76116006)(66476007)(64756008)(66446008)(41300700001)(4744005)(2906002)(122000001)(8676002)(7416002)(8936002)(86362001)(82960400001)(5660300002)(52536014)(38070700005)(54906003)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkc2QzhVbDF4ait5dFkzZlRFY0lJZ1Y4U0t4QktpR3NlZUJQUTNGZUxaTThJ?=
 =?utf-8?B?MWEwRW5WSnZmQjJnWjdIckg4cW41eUNtcUMwcUUyalFreFk1TlMrL0VxMW5Z?=
 =?utf-8?B?MEFQamZRSVV5ZnVSZ0VOd1orLzZtV3lhbXFscWJGc0pEd3dBNkd5azh4K1lQ?=
 =?utf-8?B?VU0wUDM4OGRNY3ovTkFuaWZLU00wanZ2ZERCVXVHeGVWUFdMdURMY01LR0NK?=
 =?utf-8?B?emtTZ3VXSmZTeWFOOU1EMUJGcjhubml2dGVXcXc3L1NzTjVOOXM5Y2V6eDk5?=
 =?utf-8?B?UFdlenM2VWxETTI0SjJpVWc0R2s0Q01KWWtreUgyNWZWVndYQ05KM285cEdT?=
 =?utf-8?B?WFV1VnBVZmZyYThUbGZvdWdzNmVvUlExM0RmaGdkeFlhbXFLU2pDM2ljWGpU?=
 =?utf-8?B?YVhLTGV4RlpqczFSc2dHbkNvQlhwNHVRUVNrUFFYd0g5SktGaEhwQzk0SHRC?=
 =?utf-8?B?dGJuUXNLc05LVjNicVAya0JkaTRkQk5WWVZScVV3WHNPSEpxejhHb1NaSk1U?=
 =?utf-8?B?REY1cmJXVUZGV2t4RHd6ZTBuRndzQ2g0bUh0YVYzUkxRcnh2NDRkQk5vRUxh?=
 =?utf-8?B?d2huWjVkVzk0SXNNYTQ4ZDJiM2FwZVdUbnFuQ1hPV1RPUGlvM2s4SDEwRkxN?=
 =?utf-8?B?eG94dkUvVklaYStzRk80TEljNlVXUG9Jc0lYai9NM2JRUTMzOWdZYW12Q283?=
 =?utf-8?B?RGNsWjZJTGJldVdqVGRaQy9nbTFmSGdNb0tNcjhYU01Wbkpmc3VyZjEzdVVt?=
 =?utf-8?B?ZUtCV1VNcjZmQWNuaitTUERLeTNGNnJhaVNSNEthOS9JOTlBMEF5M3JVaWtw?=
 =?utf-8?B?Q1hJVTVOV1BKUGxYWSt5TWR1N1JrTFR6QVpIc1BKaUs5NG9uRnRIL24yc3hj?=
 =?utf-8?B?YndOWlRWZ1Q5ejZEaTNic25ldS9WdXNHdXFlcVdKblkrM0JFOW9JdU1UVU91?=
 =?utf-8?B?TTl4TnNNM0dNbEFGa2tENHBEZWVabjNqYjFNcGVyR2FSWDhrd0RCaENKQzFn?=
 =?utf-8?B?Und6MWVrUlFDK0E5N2RTSVV2NUVwbC8xQko0Ukh5MVh5eUNUK2xpbXdnblBT?=
 =?utf-8?B?SDhGanlLOVQycHZNTDRHS0pJZDZudTZneUpFMHR5QlA3OTU5bmxXSjRQRjdM?=
 =?utf-8?B?M0R1RTNhWERnWUFEYmNMYVBHYTdxRmlOL0NRNkR4QkJQUU5VRnRWZ0RPOG1j?=
 =?utf-8?B?K09naXR3V0Z2SnpTSW0wUlcycDJVbGFPZUI0elZsU2FhajdCcmhERzMvN2Nr?=
 =?utf-8?B?MUplTDBJMUo1OHhrd3lYK3ZIUThoZzcvYzFvNXVxdm9Vam8rcVRTM2lJY1ds?=
 =?utf-8?B?YUpxZmdoSXpvMUduZStja0ZTejYxR3BKV0ZQZ3d3VEVXM3NsU3BGeWRWaHJs?=
 =?utf-8?B?WVN3TXFpajhwM1pkL2FnOHMyMlFWcmQ3K1hCZkVlUHBubUNIQWNnS1FGL1ZO?=
 =?utf-8?B?OVRQaVpHR3ZzOFdPNWMzWk5vbDREQnhUYTdYT2N2ZERjSzdBbk90VUkralR0?=
 =?utf-8?B?dVhuVXYyeDdFdlZ5aWR4OU1Sa3Njd0ZEUklxcEVEUCtkMTJEYy92VEVadHU3?=
 =?utf-8?B?NnpURzc1UFVSOVpCZlhxUW5UU1ZIWmdxSDg0dEVvTEttQjBZdTdUd3lSWTNG?=
 =?utf-8?B?Z2JZenFpRmpOeHJsNExyVHdYek41MzZ0WHZPRElxS3ZhbTBjVGk0aHlTSFZU?=
 =?utf-8?B?NENYSnRsdWl6WjBTazY3cmRBbHFXeUhSQW5OMmJlZUsyRnVFUldwUXNKakJR?=
 =?utf-8?B?SzljcUdZeXp2MCs5RjlKMUl2bndtTExneFR6TVNIQzU0K08rZVVmRW1lMjAz?=
 =?utf-8?B?QTR1UmV3TkFFV0RwVVRGT1NWT2FvL1kwZms1MUZsMTJIeE5yZzFpcGcvMkNw?=
 =?utf-8?B?WENNdEZyZ0djR0Ruanc5SUlQY3B1U01zNlVpbnJGZ0VWRzVpZEdDbHpXbXJN?=
 =?utf-8?B?Q1AzT3cvSmNSTjVRM2p4MVpCSStTSWt0V3JXRjdJWitwdlZQTnozbGc5NUc4?=
 =?utf-8?B?SXlWRUFqQ20zSnU3TEEvdnQrbjdnaUx2M3ZnUUtDc3htOG5jYlBuTFNHUzVU?=
 =?utf-8?B?ZEhtYlUycUhwUHRuVGpVMG1uU2kxRThoeEZ6dldqWStKbUZGRThxa0cvMkxE?=
 =?utf-8?Q?eLoQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13b6249-f0a9-427f-193b-08db7339ff4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 16:01:53.6621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P73vcjMZeBY8+Oa4IY07g5ELIMN2WSdtWQQ2mmhYJhiYdQhSqxmNkA4adgPPXUza9o7S6CMFv0Ih/Hjgi3yQkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBVbmZvcnR1bmF0ZWx5IEknbSBub3QgZ2V0dGluZyBhcyBnb29kIG9mIHJlc3VsdHMgd2l0aCB0
aGUgbmV3IHNlcmllcy4NCj4gVGhlIG1haW4gZGlmZmVyZW5jZSBzZWVtcyB0byBiZSB1cGRhdGlu
ZyB0aGUgMHhjYTAgTVNSIGluc3RlYWQgb2YNCj4gYXBwbHlpbmcgdGhlIG9mZnNldCB0byBQUVJf
QVNTT0MuDQoNCkkgdGhpbmsgSSBtYXkgaGF2ZSByZXZlcnNlZCB0aGUgYWN0aW9ucyB0byB1cGRh
dGUgdGhlIE1TUiBpbiBvbmUgb2YNCm15IHJlZmFjdG9yL3JlYmFzZS4gVGhlIGNvbW1lbnQgaGVy
ZSBpcyBjb3JyZWN0LCBidXQgdGhhdCdzIG5vdA0Kd2hhdCB0aGUgY29kZSBpcyBkb2luZyA6LSgN
Cg0KQ2FuIHlvdSBzd2FwIHRoZSBib2RpZXMgb2YgdGhlc2UgdHdvIGZ1bmN0aW9ucyBhbmQgcmV0
ZXN0Pw0KDQorLyoNCisgKiBUaGlzIE1TUiBwcm92aWRlcyBmb3IgY29uZmlndXJhdGlvbiBvZiBS
TUlEcyBvbiBTdWItTlVNQSBDbHVzdGVyDQorICogc3lzdGVtcy4NCisgKiBCaXQwID0gMSAoZGVm
YXVsdCkgRm9yIGxlZ2FjeSBjb25maWd1cmF0aW9uDQorICogQml0MCA9IDAgUk1JRHMgYXJlIGRp
dmlkZWQgZXZlbmx5IGJldHdlZW4gU05DIG5vZGVzLg0KKyAqLw0KKyNkZWZpbmUgTVNSX1JNSURf
U05DX0NPTkZJRyAgIDB4Q0EwDQorDQorc3RhdGljIHZvaWQgc25jX2FkZF9wa2codm9pZCkNCit7
DQorICAgICAgIHU2NCAgICAgbXNydmFsOw0KKw0KKyAgICAgICByZG1zcmwoTVNSX1JNSURfU05D
X0NPTkZJRywgbXNydmFsKTsNCisgICAgICAgbXNydmFsIHw9IEJJVF9VTEwoMCk7DQorICAgICAg
IHdybXNybChNU1JfUk1JRF9TTkNfQ09ORklHLCBtc3J2YWwpOw0KK30NCisNCitzdGF0aWMgdm9p
ZCBzbmNfcmVtb3ZlX3BrZyh2b2lkKQ0KK3sNCisgICAgICAgdTY0ICAgICBtc3J2YWw7DQorDQor
ICAgICAgIHJkbXNybChNU1JfUk1JRF9TTkNfQ09ORklHLCBtc3J2YWwpOw0KKyAgICAgICBtc3J2
YWwgJj0gfkJJVF9VTEwoMCk7DQorICAgICAgIHdybXNybChNU1JfUk1JRF9TTkNfQ09ORklHLCBt
c3J2YWwpOw0KK30NCg0KLVRvbnkNCg==
