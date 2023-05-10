Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC66FD633
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjEJF3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjEJF32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:29:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D08CE4C
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683696567; x=1715232567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lNJSi5qdONEYwtOOblFUWa8EPyu268pfQZQNGAsvL4U=;
  b=jQNDuQMfjBIsm9nqZojHczclAArrGSXL0q0ycG5ady2EprjydXw+1zli
   vUIL3RhC3sN5lZHHgjzPdO0Ho8tcI3c1u9bdg2buBqxrdAdjGlruTYFP5
   7Km/rltUXIXFcq4tLVcu0ymKT5gUsI3kqOAdQ6wpAVQSsOIr6kIZwHuS5
   KYKel+gt0SVJaZwfW9c+vgdRgtnQrOLaxRqjG80vk0LxilAC663NQsN+4
   pCSkhshcikuOnBnUNJ3gq+3a5Litnl7lfUK1+jlCwRTyBBQuLU+OxnVr1
   o7nX3RVuBsceegE53jKgWtTQqxYuenVPPiAuzoN4KBuQhJK5ql9ibeseO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="350166613"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="350166613"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 22:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="699161999"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="699161999"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2023 22:28:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 22:28:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 22:28:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 22:28:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 22:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRjTi2AsxxNzaBgzA59w1RV0y/X59aO4Ra5aKxpP5cZPZBboU7iPZf/gQW4umutL2mabzXvgIa2GYGaWebBHz1FNduir27FOK0FNtmj1EzHO4u6Ypuc9A9nquFU6Mv5B2LaOtxAqAaYii0dhJqPXqLd9gyoFGilX4nj6fCFPq9KpyYo3lh88Opxc25zu9GZfceOWx9QD3cG2sa3umUt5GskRKGTGiZD+D2SQV9nX5+Uj/+g079nXV05s0WnjV8XkbZXUNgj9cw94PF/nRf9HxpHtPWHAdSd7KkNxrUpmHcSuVo+mzAMaaJmsd148O2kx+kb/+0t4oO1KdJhK7yWewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNJSi5qdONEYwtOOblFUWa8EPyu268pfQZQNGAsvL4U=;
 b=efqcBkhu1O//Y7CVz7D+MfcP0h7KBCyDeZNn4d2cT5n6gq0/FtskqCJmce+s0pTU2P/6oR/94AW9ypvfzmtQwn8ddxRFSf1pATlv0MdPcg182ArVFUikoMuKmfJBQPikLCqUgPPCh78C2yDki5Yfw64gooEiiwn0zVqVzI5DNRP7JCO5/b1lU4one66t73TQ56hjRJMIJdzA0s3/fbWDu66TdWuxzQmgDgkngIYvN37gg367bs6vg1GF1I8WaIUbHaKE26Xp0Nlf7AmkSdtBSrZ+5+xo6jNA42JnGJdezibiEjSvcXqU9CW2T912zlLhKVdUPz0Gexr53+A2Oca2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by IA0PR11MB7816.namprd11.prod.outlook.com (2603:10b6:208:407::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 05:28:06 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 05:28:05 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Thread-Topic: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Thread-Index: AQHZf+Q5H6HapMWcmkmbbiivYiqfDK9Qg9kAgACiV3CAABaEgIAAOucQgACV1YCAAMwbAA==
Date:   Wed, 10 May 2023 05:28:05 +0000
Message-ID: <IA1PR11MB61715AB7C9D49459C89BA2D089779@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230506062934.69652-1-qiuxu.zhuo@intel.com>
 <10d3a11a-8591-e49d-e010-867a05078ff0@redhat.com>
 <IA1PR11MB617110DB70F92AFC0D40D26089769@IA1PR11MB6171.namprd11.prod.outlook.com>
 <3e580bf2-2c76-739e-7636-4aa03f5628bd@redhat.com>
 <IA1PR11MB6171282A1E2CF22740398F8989769@IA1PR11MB6171.namprd11.prod.outlook.com>
 <43868b82-4f13-ebcc-ea7a-86f11f6096f6@redhat.com>
In-Reply-To: <43868b82-4f13-ebcc-ea7a-86f11f6096f6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|IA0PR11MB7816:EE_
x-ms-office365-filtering-correlation-id: 241d3187-b5ca-43fe-a9ba-08db51175526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9hUNCkqJ8gKVVrAnPA+zu/+Zosplsc2VaH3inxfXGee/cm3MZULN4RcQsK+Q+5MGt4U61691g0rSN/yGf2Q0tBk+HxxWNig+wAjwtRT2I0cEbLN6LxDMW2Mv+HijLmIuW7d0QaW9tyuOOyQzfqX4iGFPPczwiSOiGdtlRJBMjQMSsKKIb0MOzY/SUNnIw+Lf4qWvUchKPo234qfK6h0ogTVBo5CzHWMerxuZSgqAH8xk7mdKpcM+nTt4a4seDm9uDtmjX0wdyE0ZnfiuoTO+4gDu24TDVKVyFedRjrulFG6wIEuhyLPXehIY8rj7mDrdWa+aYdPja/wqVNKVzbnEGk9NCIC/y+Xw70OCF3Imwl6yyTnwompLZ/VJPKTU9a1Dj1CE13dLe3If9qFTl1SEbmRGBd3IMyMK2xgIh9Qf0A8rCSfQv9i+fWw/3QkUyQzWg/QKHD+IW12bhqzSMk1XK0OR2Qj36rVQbvT2uoq+UPQs138oxQom2EAIq7F5rPNNJxN9FQqGmJW+KKbDEvYibINuBZDQxUzo+wWpYjvNTvM+D61aJM+DEXWGCVnNNuidAxGO7aQVpopuG0iNNO5q3ogTsOPLtkVGK7A7yXQKM813Ao0SIPdsyKpY0h5YY/X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(6506007)(9686003)(26005)(83380400001)(55016003)(33656002)(38100700002)(122000001)(86362001)(38070700005)(186003)(82960400001)(7696005)(76116006)(110136005)(54906003)(316002)(8676002)(8936002)(41300700001)(71200400001)(478600001)(52536014)(4326008)(5660300002)(66476007)(66446008)(66556008)(66946007)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHN4dGtNNU9LN2h0Q0FobHF2YUwxT3dHSHllSjhxQy93VDBNVnNYSFVvVHlR?=
 =?utf-8?B?QUpKOUFaU2prUk91U2MvQjI4TkRzSDU4QklDZXY2eDBNMFlCY0hxQ20wbzV4?=
 =?utf-8?B?ZjJsUDdaSXh0aG9JSGdOb0lxYzBReDNha3ZMelFGQzJPVW5qTEZ3UEdrVitN?=
 =?utf-8?B?T09Ibko1NXNJc0IyVFVzdXNMZEoxOFcxS0VYQm5oRnlGNWkybms3ajZuS0ph?=
 =?utf-8?B?ZnUvUU1CKy9vNDlWZ3MxK0kwYXJrczd2UHlmR2xhVHRKc1N5bmN4cHhUQXVE?=
 =?utf-8?B?eVc2Yk9oTmJOQVFPZTZEN1Z3Vk5LdlZaQlBkZzVGVDBuaVZ3WnRYNDhONW8v?=
 =?utf-8?B?UnAvVlppV1V3YVNRamNDOUgrQ0xWeUVpSkV0SWJOUmh2QWw2R2J0blA5QzlV?=
 =?utf-8?B?ZkxwQ1NuSG1OOXpRNVBDRXg4blBLaWZBZjYrSDFRY0QzK2ZqdmtMOGZKbmtX?=
 =?utf-8?B?bXozdmJwREUrY3pLcHUwV0xQNnJmZjNCdVFud3BseEZld09oUDZZSGtIc00x?=
 =?utf-8?B?cHpkd0tMRlZZblFpQktaU3ZBQ2NqOWVqZXlnN2luVXV2aWM5OHM0Nm9vMlRJ?=
 =?utf-8?B?dzlRZEE3NmpaOXFzWjZoNU5VZ2UxYlViSUFiSDVGalltdnluTnFjM2Z2SGJY?=
 =?utf-8?B?SkZUL0VNT1VETHFpR243QVFkYm1iOGUyaTFlV2hwUGYwRVVWVjM4R3hpTDVS?=
 =?utf-8?B?cUJsWW5mT3Q3b1dxVzUyMlpBZnNRQlI2bTFkVmJ1c1ZnVjVBVWx2QnErckQ1?=
 =?utf-8?B?S3dxRFpjclpaWGdUaGc1dTk1cHlWenpERXZHMG9za0piMk9WL1hFa21pRHFL?=
 =?utf-8?B?ODBTT1pIRUFaWHpMaTdON1pMb1BPdzUrM2xyNmNjekI1ODhBbTNpRWdVZW1V?=
 =?utf-8?B?NVlPUG9KZzFFdTl1RURqeW9UTkx1TkxsT01ReWJIMTlrdnFxYThZRnV5K2JV?=
 =?utf-8?B?Y0toQkFHWjJ6dnJOYTdNbUY0bjFvR3dwVnFzcklPSVdvRnZGa2UwemlsbkVk?=
 =?utf-8?B?Q3Z4YURvcmc1UXhYOG5vRE55Y1o1YWdpdktoS1NtOTRNWGFURzFock9jRlRw?=
 =?utf-8?B?ZmMyVDF5Z00wM1J0QlJtVXNGUkx5aVIvRkpmcnlPZS9PR3c4UExSaXp0TGtK?=
 =?utf-8?B?emFUMEVrUmVDVVNGVUtmNFdScFBNKzhlZnpvUnpxTkJEMUp4WDYrNlMrY0R3?=
 =?utf-8?B?dE01WFRrT1VubnlVREhpUmYxZmJ1RlRjTjhPMTlsU0FtZlVVSFV1aWRhNHJa?=
 =?utf-8?B?VHQyMGlIeEVURmIvdGJzVm5PSEVXT1UvYUVKYUQ3bXNQUk11THRnWXJmZzBL?=
 =?utf-8?B?U3hld0RTV3hhdFZud3gzeXF0MURtaHdBY2NkQXFMWFVDbXNnWElETVFMSFNF?=
 =?utf-8?B?dHJlS0hlb05KaHVIVDlRaHVUOXdSK1l6WmQ5eDQ4Rmg2ajAraWIyQlBUdnRS?=
 =?utf-8?B?eVBPMWpmNXhwN3RYOTZ1a3M5M0VQUG9La2VwcGVlcFphU0h0VUFubUZDMERE?=
 =?utf-8?B?QmY1OTE2dmlnZ0tqQk8yMWFwVmllYmlHZEUzU1BQTnBURVpubm5jTlJpRkhx?=
 =?utf-8?B?TzkwUHVtbit2WEQ4cGk3RFZ5aDRPaytVOFlPVWx4RXNKenU5dUFqVU1RR29Y?=
 =?utf-8?B?UmNnMllBemxxdkFLWkpjdDFvcjYySnFmK3dhQUlabFE2ZnRndCtQSDhHdzdq?=
 =?utf-8?B?MlJzcWxaRHlMb3pPRDM2bmJCZlFpY2dIdkF5UXFFazVsZDdoeDdhUjRkcnVt?=
 =?utf-8?B?cjBpelJ2OWNHNGpFSUhOeWw5RFdZUjZwYUtQTzlqQVFnY1hsNFk5RDVQTDBN?=
 =?utf-8?B?cHpJbnBpSUdVei9Wck54bWZIZ1lBZXg2Uy9YTi80Z0E1KzVyUEZFaDJLNWZj?=
 =?utf-8?B?MGZaMzBJTS9HZDk4eSt6SXNIS1JxQTB2cWo1L0FFSmY5WW1uQXJpc3k2eDNF?=
 =?utf-8?B?bUx4eUhXRWdOUVprUmgwdXNLaXk2RjR3cmkzUDB5Qlg0bWdvMDhlTTBHdXFT?=
 =?utf-8?B?NUxtUVA0bnhjOVVlMHk3OXJ6aFg5d3hIOWREbkxVQWxTQUExSC9zekNFdklV?=
 =?utf-8?B?Y1BsUGRaRFJTVmRDNFl1eWpQQ3N5Qm02VzgySGRrdVY2aHRWSzNsMHlTWXUx?=
 =?utf-8?Q?a7ZTAaeBSz+J9/mFwitTi2Vj2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241d3187-b5ca-43fe-a9ba-08db51175526
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 05:28:05.7472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Myf9MbNRu4z0d50CltbK/jm43l1EAmOMZ0k/kB+j+lycfO7AfRLPViEpNpjfnagn1E+l3QEEx9kza6fBwz1A8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0KPiAuLi4NCj4gPg0KPiA+
IE9LLCBzbywgeW91IGFyZSBmcm9tIHRoZSBwb2ludCBvZiB2aWV3IG9mIHRoZSBDUFUgKHRoZSBs
b2NrIHdvcmQgdmFsdWUNCj4gPiBpdCByZWFkIGxhc3QgdGltZSkgZG9pbmcgc3RhdGUgdHJhbnNp
dGlvbiBpbiB0aGUgdW5jb250ZW5kZWQgc2NlbmFyaW86DQo+ID4NCj4gPiAgICAgICBbMV06ICBP
bGQgbG9jayB3b3JkIHZhbHVlICh0aGlzIENQVSByZWFkIGl0IGxhc3QgdGltZSkgLS0tPiBOZXcN
Cj4gPiBsb2NrIHdvcmQgdmFsdWUNCj4gPg0KPiA+IEknbSBmcm9tIHRoZSBwb2ludCBvZiB2aWV3
IG9mIHRoZSBjdXJyZW50IGxvY2sgd29yZCBwb3NzaWJsZSB2YWx1ZQ0KPiA+IHRoYXQgaXRzIHN0
YXRlIGlzIHRyYW5zaXRlZCB0byB0aGUgbmV3IGxvY2sgd29yZCBwb3NzaWJsZSB2YWx1ZSAoSQ0K
PiA+IGRvbid0IHRoaW5rIEknbSB0aGUgb25seSBvbmUgZnJvbSB0aGlzIHBvaW50IG9mIHZpZXcg
d2hlbiByZWFkaW5nIHRoZQ0KPiBxc3BpbmxvY2sgY29kZSA7LSkuDQo+ID4NCj4gPiAgICAgICBb
Ml06IEN1cnJlbnQgbG9jayB3b3JkIHBvc3NpYmxlIHZhbHVlIC0tLT4gTmV3IGxvY2sgd29yZA0K
PiA+IHBvc3NpYmxlIHZhbHVlDQo+ID4NCj4gPiBJJ20gZmluZSB0byBrZWVwIHRoZSB2aWV3IG9m
IFsxXSBpbiB0aGUgY3VycmVudCBjb2RlIGFuZCBnZXQgWzJdIGFzIHRoZQ0KPiBiYWNrdXAuDQo+
ID4gSSdsbCBzZW5kIG91dCBhIHYyIHdpdGgganVzdCB0d28gbWlub3IgY29tbWVudHMnIGZpeGVz
Lg0KPiANCj4gVGhlIHB1cnBvc2Ugb2YgdGhvc2UgdHJhbnNpdGlvbiBmbG93IGNoYXJ0cyBpcyB0
byBoZWxwIHVuZGVyc3RhbmQgd2hhdCB0aGUNCj4gY29kZSBpcyBkb2luZy4gU28gdGhleSBzaG91
bGQgcmVmbGVjdCB0aGUgcnVubmluZyBDUFUgcG9pbnQgb2Ygdmlldy4NCj4gSWYgeW91IHdhbnQg
dG8gc2hvdyB3aGF0IGFsbCB0aGUgcG9zc2libGUgdmFsdWVzIGNhbiBiZSwgeW91IGhhdmUgdG8g
ZXhwbGljaXRseQ0KPiBzdGF0ZSB0aGF0IHRvIGF2b2lkIHRoZSBjb25mdXNpb24uDQoNClllcywg
ZnJvbSB0aGUgdW5jb250ZW5kZWQgY2FzZSB2aWV3IGNhbiBoZWxwIHJlYWRlcnMgdW5kZXJzdGFu
ZCB0aGUgcXNwaW5sb2NrIGNvZGUuDQpBZnRlciB0aGF0LCByZWFkZXJzIGZpbmQgdGhhdCB0aGUg
cXNwaW5sb2NrIGNvZGUgYWxzbyB3b3JrcyBmb3IgY29udGVuZGVkIGNhc2VzLiANCg0KVGhhbmsg
eW91IGZvciB0aGUgY2xhcmlmaWNhdGlvbiBvZiB0aGUgcHVycG9zZSBvZiB0aG9zZSBzdGF0ZSB0
cmFuc2l0aW9uIGNvbW1lbnRzLg0KDQotUWl1eHUNCg0KPiBUaGFua3MsDQo+IExvbmdtYW4NCg0K
