Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6161A038
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKDSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:47:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD55985F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667587636; x=1699123636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iAQaOPnybChP2oFrm3ucigSW7EQUArTGZUukMtq3b4Q=;
  b=kqRlKZCWrKFToNP/4QS1GjuiACEMvFRSbGy8nBymV0B0upUvIairwEnG
   LeK3RrNf7mtZnNUjGGWO7D3YtNzcWprBHC1FCh9dvpa6bhTVgXL8KlVs1
   1yB8Y0dRxANN3k2vZsP0IyyYDiNqULAZiH52LFHYzTxh2D3W1vtddTJFB
   +/9Wufbsy45jSw7U20fdO74oXtjpdwLFn15C5zxajuP3+9Y0/itQW1LLi
   q7W9K/ibkxAkAbmtb+mHbHkmmbqiraJiB6icgKtzU2Pypp6ETTBBwhRBH
   F3psXq0gzWCh+c5jkZsKA7mIS1jHQp1wYvIbs3C35+3CVm9EAyJ9eahAW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="336748335"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="336748335"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="586278776"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="586278776"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2022 11:47:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:47:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:47:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 11:47:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 11:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+mxSNO65JJOisA55ygeOzJx769LblNdClOTHMIcUPnNQy5rOEyigMiQvjwLU8AOz/mXq5LhpzfHw14AisN5LvANTueeBLnUiNKSIRx8yeSe8BRls4UE08SWXxaVKg7oBqIXcAPQXKMFMBWGRgXLe28TP80+HeK/YN6f4Poh/hLi6yjwwSgp93tQpM5RDLh1ja3sRL3+fIQ07L5ZHw/QPiKpnrIe4fcaghVgBbSdt+MX7Qtf8iEqPZHBsAHhB2hYNS2KWwCKlPFs1zrvve8hE7ih0aBT+s6cNFD1Sisea3Cn1ejMKNfXKlmQmWpE+qnDkWTVSPlSv4O3mO7jzkclUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAQaOPnybChP2oFrm3ucigSW7EQUArTGZUukMtq3b4Q=;
 b=QHAm5YK2d0CUFDZZfCUgaGDdQW2AZ7t6qIeIs8xSFFYoMiYRD8WcI2EkIebgci/9Wb6vLPx+bMNeousDM/GuJtRL4kDaxlUuAOj5K0m6y3yZ2ELyfbx0JLIXkxlpdVE4ANnNTxXImvP4rM+46migAexTzt3T7hhyz4A9QthyueBinNnNuwMSeOdevtAD3zOyXxJvapD5vO2FUttLUMTn4VBUkpDat5QVjXLT7yVSLsJ28s0yRL0WyYQ3VGhW18Hy1edldKP4lR+2lMyYT76da/YgXRaPA+b/YNYz8uY0G7080tNm3etb2tfUuiuXqFwBNCTBHcVnCu9gtvnI7iwrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5495.namprd11.prod.outlook.com (2603:10b6:208:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 18:47:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f%9]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 18:47:12 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/cpu: Add several Intel server CPU mode numbers
Thread-Topic: [PATCH] x86/cpu: Add several Intel server CPU mode numbers
Thread-Index: AQHY78OGncvdlHtCjkecZ30S7iITZq4vGrgAgAAASIA=
Date:   Fri, 4 Nov 2022 18:47:12 +0000
Message-ID: <SJ1PR11MB60833D78AB52EF94CDCF909AFC3B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221103203310.5058-1-tony.luck@intel.com>
 <1897905e-6e37-a13b-acc7-2ab458aadfe0@intel.com>
In-Reply-To: <1897905e-6e37-a13b-acc7-2ab458aadfe0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5495:EE_
x-ms-office365-filtering-correlation-id: 54426cac-b0c6-44f6-2396-08dabe94fc6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+ynHY5J7sw6s4PyyHGGcJayIjdT09YyQ8HCuRWfLSSF1x2mO4N4TubGLREit9+8tsL9hWEcOZSBX9qoN23yhvJnRzSFVEw9tURScZI0lPZNg9CeKHGYE8ep69703kwP9zgXa2wosFSNBsKPc/Blzl2bNY87eFJWmbl4yjvTUeFaEuU0blxLfXOSiJOxaG+gMUPnBEuxDf5O1jWkFZ3C5zQxcnHqtusJMelhVn9GzV+d/eTVNhWOMf9N5RAhy8uELkSnsF+RTbUcTmi+d8tYgmM8mQBb7kNO3eMXsGwnrkEiRrLIGkGpwHujjeVEdafhl5Tkbz7k04VMeNu+relFaVm0rBM2Vb/qzHDX0tvnohNuNBDsqOD8jbDglfC+GSp1UE4uK7pSlHdHyHthpJHIg5mNkn7MnuethV9tDF0ebriioP8RZf+666HfzyDYvyUb+FgkjDAJEwS/H5t5iShIuSwda9/IhVRjTeIvzcyEsqfYbNgEYn1tk16CvVq7M1IKiWZIRlK5KTqf4Z7P+7VBgXO+wcr4CUsovliWld+zyHaGDcOZSpJRrP4Nr+7fvjfBQUR0kntCj06uAqhqKrPtLGVzziw2XnhYlovJHu6tXka4wLEShPlsQC4ex1mGLs/NqMH/ZcZx4EH6mbtVk+CPr18+RRE2SgAFVQV7JKu7cMgly0Bq0QbGPNFIJVfOQ4p/XctYRHx9dU4GthmTYmbFdsNgQ7BDFEotjjgQP9OTKWte+/NKFCjxQfm1O2wdLL6t3YnK/hHu4FHY3kjeRGv2IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(6506007)(7696005)(9686003)(66446008)(66899015)(41300700001)(66476007)(82960400001)(66946007)(38100700002)(66556008)(478600001)(122000001)(76116006)(26005)(64756008)(54906003)(4326008)(8676002)(2906002)(33656002)(186003)(55016003)(316002)(86362001)(52536014)(71200400001)(38070700005)(4744005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDhmWTJGbkJrMEJsNUw3czNpc3Yvd0hxUVdGbzJOOHBEWjRHb1gxZDRCUE8y?=
 =?utf-8?B?dnFWbmFqeHBmM283QnRmd1lDYjZiYVpXTG4zTzQ2RWZJS0FSditCbXVQM1Nj?=
 =?utf-8?B?NWd0TFRON01naW5ZaU5mQ1RFQXJ6S2oyVnJCYUduZ3d0WldQZzhHeVdHY20w?=
 =?utf-8?B?T1hwK2xFTE9keElFMkc0KzRBaXlUdFpiNHMvVXc1U3BkVlROa1YwQTRJbjZj?=
 =?utf-8?B?bkt6bFJKNDFSTHVzUXRFa1p5QWJDa2NEVFRUVXBmVllKeWpPdkJUN21OR0ty?=
 =?utf-8?B?QTZYa0RUMVBMZ3MyWi9xMlgxaytxUTdnMjFjV080REpRcWttWWhXWmxzWm9U?=
 =?utf-8?B?Vm1WV1IrMmVBb1dPd1UvWldZa3RDTS82OXgwaGxrQ09meVVHVk15UXhDaTht?=
 =?utf-8?B?QW44S1BWNEtSNmdvV3I0a0c2Mk5xazJHdXNLT01MbGNIbVpSbnA3emttaE0w?=
 =?utf-8?B?Zi8rWHNma0k1M0dYZ2hWV25pUTl0SXp2R0FpV2Q1ak9XdmFiaFZYU2lwZ0dU?=
 =?utf-8?B?S1NmN3hwa0dsTWpzaTc0dkVCRGl6NGZ4VkI3bjk0YmhpVG1oYkl2alFUbmkv?=
 =?utf-8?B?YWFCdzA2cWdycUtzU1FwZGdvM1NkSUI2VjBXaDJadXFCeUJEOWpjdG1hSndp?=
 =?utf-8?B?cFRucmN0WWdweUU5UTUvbG5pQUFuNzlJOTFxakM5Q2VrM0xZemd5ZVJBVWhl?=
 =?utf-8?B?RFVzL1RoTkdHNWJJTGV4U3lGL3hoWUJ4WlhnazhRdCtFUERzT1d6TEl2U0VY?=
 =?utf-8?B?eUQ2RGdJSjA5QnAzY2xjZWtoMFlmd2JQVU9CSENSOXNCczNHQUxJd3NBb1B6?=
 =?utf-8?B?ZEtxLzZ1MStobUtpS242L2NyR3JBUTFjTEFudFFHKzJHbjlWTm9nU29leWh2?=
 =?utf-8?B?cVl0NEtzbWtkY0cvSVFjNTYrcU1wRlBhSVVvUTFNaGRJQVhPSEpYSUxER3JM?=
 =?utf-8?B?cGdRT2pCTWkwSzV3NERxUGdoODduVDg3SHYxRmFwVHowbC9tUXZUVmcxekVk?=
 =?utf-8?B?OVhxdkRYUkorMEJYU05HbmF4eHdaTlkrRVNoN2ZSTU1OWEQybyt5cWw5cTFM?=
 =?utf-8?B?L3A5V3hzQTg1OWZXSGlpMnJPN0NXQTM2VWFGRmZDWW05UnloWnIwT1czcjRQ?=
 =?utf-8?B?Q25aNnNuVms0dUFIT1RURHhKSWxrTVp5VlVHenV2QThld3Y0RTVQTG9CUWNx?=
 =?utf-8?B?ZU5GLytwYzhvZUJpb3FkamhmaGx3YkpJV3pkcFdSTGVaL1FtTkJvZWVrTG9V?=
 =?utf-8?B?ZDB3eUlQTW9ORFQ0N1huZ1g5NktNUTdLWFp0VkFPWEk3RXBLUmtIaGVJWUVF?=
 =?utf-8?B?NEZWVkorRlk5L2krR1N6VHJFdnQyQlRodC96QlFvUnUrREEwUkQ1N2duUmpw?=
 =?utf-8?B?VUFFdGJYMStFamt3SUhxVjBvb25OY1NOVi9YN0RWc0V3cXdxRzZvN05sNWs1?=
 =?utf-8?B?dHY5V1dBb3d1YWtGZU9ycDlnTkNRNm1VaUIxbGNrME03VWpwVFJrRVNXQlZV?=
 =?utf-8?B?L2p2Rk9HUm9NQW4rd1V1UkJtS01XSGlCR1VhZ0h1d00zbXZWRndKK2ZBT2Ir?=
 =?utf-8?B?UTd2Rk1McytyY1lEMDAyVE05TEloMmhySTk3QnQxNFFidjREN2QvOUNMemsz?=
 =?utf-8?B?MmRBVVUwdStGUytndERHbnZlZ3k1bzZwUGo3NXVKSXpBMFo1OGFTWEdkM0xD?=
 =?utf-8?B?dVYwaUViQXhxaXFVbGFURWN6MWlpWUtDSXFGNEtVQ1c4ZlRVN2JOSDJpdzI3?=
 =?utf-8?B?aWhzc01LVDFTUGVvTnBFYUxqYUlrU0FTUVhPODh3M044WHVJeVZnNEJtS2Qx?=
 =?utf-8?B?Kzg5aURjVTErTm5BTmxHbDQ2bGt3dlFtMXBoSjd5SG5TTnpNak9IOXRGYWsz?=
 =?utf-8?B?MER4S284VUsyZWx0SXloL2Z5MUNEK0M0UEI2TmJpckN0c1lNWmkyeU1kODBr?=
 =?utf-8?B?VDIxMWt5QzNocy9RdE5oNXNPNStvTDRwNFgyYW1VdkJuWmFzeUEva2wwZHEz?=
 =?utf-8?B?dllacUo3c1Q5TEZlZ2xJSnRqR2ZxVmJTcnhoMzdqV0tUYnhsUlkvV2YrYStH?=
 =?utf-8?B?RUNBZWs5L2NpMERKWmM2Y0tYYWNBVmYwNUw3Q1VnUi9XUjNLQVBod3o4T1Zx?=
 =?utf-8?Q?/5t4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54426cac-b0c6-44f6-2396-08dabe94fc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 18:47:12.5457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1Rx5FAmG4zwPQwRDlV+m+Vj91nqVQHblsR8mcrYyXQ1PIi/HqAJPAD1Pj1r3csR6NdYui2n05d1u7UuJ9vr0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5495
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gICNkZWZpbmUgSU5URUxfRkFNNl9TQVBQSElSRVJBUElEU19YCTB4OEYJLyogR29sZGVuIENv
dmUgKi8NCj4+ICANCj4+ICsjZGVmaW5lIElOVEVMX0ZBTTZfRU1FUkFMRFJBUElEU19YCTB4Q0YN
Cj4NCj4gV2VyZSB0aGUgY29yZSBuYW1lcyAobGlrZSBHb2xkZW4gQ292ZSkgbGVmdCBvdXQgaW50
ZW50aW9uYWxseT8gIE5vdCBhDQo+IGJpZyBkZWFsIGVpdGhlciB3YXksIGJ1dCBpdCdzIHNvbWV0
aW1lcyBuaWNlIHRvIHNlZSBmb3IgdGhpbmdzIGxpa2UgdGhlDQo+IGh5YnJpZCBwYXJ0cyB3aGF0
IGl0IG1pZ2h0IGJlICJyZWxhdGVkIiB0by4NCg0KWWVzLiBJbnRlbnRpb25hbGx5IGxlZnQgb3V0
IGZvciBub3cuDQoNCkkgdHJ5IG5vdCB0byBnZXQgYWhlYWQgb2Ygd2hhdCBJbnRlbCBoYXMgcHVi
bGljbHkgYW5ub3VuY2VkIGZvciBmdXR1cmUNCnByb2R1Y3RzLiBTbyBkZXRhaWxzIGxpa2UgdGhh
dCBoYXZlIHRvIHdhaXQuDQoNCj4gRWl0aGVyIHdheToNCj4NCj4gQWNrZWQtYnk6IERhdmUgSGFu
c2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQoNClRoYW5rcw0KDQotVG9ueQ0K
