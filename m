Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02A674E3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGKBqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGKBqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:46:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1116A4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689040000; x=1720576000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pQ1QnyzTeS4LrhP8BVheUfR3VYRXi/hcrdi7Gl+XgOU=;
  b=XZ6O+sOonkcqRoYyO/gwerfHMfruo/ToDRQl1fioTTEGAX7EI9jQh3Rh
   bOMxH1KL3xKjcTEnxqSJUfUdRNQ5lSaX27vFobAzkinxMh7tzUjVbdzee
   JgpOBKn36xW8b+02sJsFitsAGW0sG19rAtxMTfZnZSYqNClfmALYnHs+v
   j7+175G1OCKQANVH6qv9UkbHV+YV8/1a3etfPbRHpsp08/oa3tXGdfY4O
   GZBOkfsiBbcIVpNMpVO0Zdm89tvDeb+6IzxMwe/ia5nZ6Vasa0Ytn/rm+
   Ig2TZEmaraQY1p1kJLAEZILG5qQvVK9moskZ689ewHNQ6Jc2nX0TvIeOX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="367998968"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="367998968"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="811005372"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="811005372"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 18:46:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 18:46:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 18:46:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 18:46:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 18:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoOW/t2IVJdS1T0+QuRieMbdQ57xwmF45hZkuihKHKkLsBa450zcMl8kfLbvXBBedd5RECtmrZRS5qalK2+wlf67oBBVfqld2ZSBuKRFy2OLWJLW3uzAaODU/wONmHzyCyDL+nmKlt8FZ2sX0OZwev/fzXd2qxSkVyzZ3JVSO0zcQDR25raYE5DzkRV7kyhg2sJM5ERRwUOmW4WZ3WK7+cRH2Go5CAVe1MgLOOIKXgxyLzqBJnT6HMVR00wlgSr/19/nYoGNtoIS8L2VkBnpjdL1BbYyBn3FO1Z6XqWfdDmNoxe3ICx6unLJ02h/3RSsL4OK9BeiPA/Z+04+/8JG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ1QnyzTeS4LrhP8BVheUfR3VYRXi/hcrdi7Gl+XgOU=;
 b=mfT2Fl+NeVu45LfqMBRw5zh2B+a2JgEj8cNDL98t3woiGFOrCdguGyG1aUtYsaPdtXP4MdV+kuORzvZP2l77Ro9BlngCXg2V8v/mFgsOmvmNhdbmmxikHAykzfzEguCJcNZ4SikeuHuDBgfEduNj2YJPMDcenUqBFUWCN8FDDtI0tdisuTP0+xXaY35JB5B3y4lfuD07PkJci49kRrTwwX41GcQUo8Nz+VMz42tHaWRj5QbzgVt/KpaEszSy7jWHJTTlmv1OBdMDuXeMEPh3UmqYwUJJf7JWpwJ1y10go9w/aSLtMa3DETM8z3fwjYe7EP63zj9JuAZzQo31SpMnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 01:46:31 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d462:72a2:39da:5ac7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d462:72a2:39da:5ac7%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:46:31 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Michael Shavit" <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 6/6] mm: Deprecate pasid field
Thread-Topic: [RFC PATCH 6/6] mm: Deprecate pasid field
Thread-Index: AQHZsHNWRdteQF9at0qpA2PShEUTna+zRy4AgACKFCA=
Date:   Tue, 11 Jul 2023 01:46:31 +0000
Message-ID: <MW5PR11MB58819206EDFCB40E101CBBAE8931A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-7-tina.zhang@intel.com> <ZKw/6O4QmJMIRRP9@ziepe.ca>
In-Reply-To: <ZKw/6O4QmJMIRRP9@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|CH3PR11MB8706:EE_
x-ms-office365-filtering-correlation-id: ae64c913-f068-434b-b13c-08db81b0a689
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtFhdzElYxTqcAu7/s9ufNY7K+D8TT5RyWzYbNXnCLT16IuhiObGXLo+dTaxidRDfRMiS2dzf9WL2otQhZ3YFn+pZwlg+X1uSgUGmigxWiXpDTDU1aUXfTqI42emUZRfOv3rVvo9N1w8HUZHaILtGAYnxQXvoBAAQ6yexeOC07foojB1VqRabQ9k/7EhfSfblzHRnMNySCsN/lvEzgqNvxqZ2DYCBoE2jLj2y8mHpz4fK7ns6Y9W02WjPBFzEJ2JfkbbjBfHgRbMBg/84MnRd5p9XBYnatS9fHTf1XozH+dPus/8PaIE1dafb5bbn8lcAPQdqDwNR+yQCkx6UDttx8+lj6ZZTbayc5Pl2HPgM8Qu6tb2Bz1PnKZqEF5uxNEcOj3t4V7qpqrXuYZQA2zlpaX2P7/pttUB4CMeANIwdRmObUFd+ppKwLdCw8or8wgbUn2u3Ib+Vdaj5ayq6xAgP9sqjq7K4JJvBDDC3XyVZDJUpiO3EzjihymPGmv0r/+1HvxIKhyMTWTZIJ9FIlD0YywA28PQd7SwoVz25mN+79PvgCdVqFcByi/Vjsktoqxa8dnFOvoCxCoeDcrSsVkFhjTyj38OL9/wmkKClCZEgmT8rHKqSHh92uTiW9Vvj2gD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(86362001)(5660300002)(52536014)(8936002)(8676002)(38070700005)(41300700001)(38100700002)(4744005)(316002)(2906002)(64756008)(66446008)(66476007)(76116006)(6916009)(4326008)(66946007)(66556008)(82960400001)(122000001)(54906003)(83380400001)(33656002)(71200400001)(7696005)(478600001)(26005)(186003)(6506007)(53546011)(9686003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1puNzUybm14SlFRYmd4NTYrMURCdXY1a2tTYno0U3U1R1JqVlZvMTQ3M1pV?=
 =?utf-8?B?NlNoOEx5RDVXUHpuVDdsU21XZ3ZEWHpNVTlNWm1CUU83SUdJOE01QU1ER1lv?=
 =?utf-8?B?SFZsQ1ljaUhXbFh6Z3RmVTdvbWdCSUNmRHpHRmxCY3FZWVFBR1JpaXNEdElm?=
 =?utf-8?B?cnhlL3lmK0MxWVRUcjJkVXd6akNURURyNHNRMzlvVWtIbUxqbEZWZll4d0gy?=
 =?utf-8?B?ZGJLcjB4MFhxWDlZTkcvRTc2dUZrazNTUFhONmczeUJiOEJabm91am1DUVlN?=
 =?utf-8?B?dlFwQU5JNHZMOFJ4bXVCZE9RZ0xuMTVTck9wbzF4TTZQSTlyclZ0OHhjYUhK?=
 =?utf-8?B?VWhjQmZLazR1TjJCOHprRjQwVHBwWXJpOVpXeGt0Zko1UU9EYlU1Lyt0Vjdv?=
 =?utf-8?B?VGJBUDNyb1RBVk5JLzVMZzFpSDRhSThUV2thK2JqQXc5WGRNdXo2SW1rb05Q?=
 =?utf-8?B?bnV6d282aytWTmp4UWZxNi8wdlltY3JEZHIzMWxrdjc2TXNIcUdTNVRFaHpD?=
 =?utf-8?B?NWN6L1I1ZTFBU1FDcG1SNXJRMXF3UDJyUENKajI0VW1XTEExK2o1WVJ3N1Q3?=
 =?utf-8?B?RkNDWDE4Z09IdktUd3hyUTlJU1Jvc0JiRHhUWWdlUzR3LzNVOW54em9Sai9Q?=
 =?utf-8?B?aHRUWFVvaHN5cUx1dlZyU1gxMFBvcVo0N0s2NHltdmkxaWppOXFGTU9JcTVq?=
 =?utf-8?B?dmpNNmFKSi8yN2ozL3plUXJFTFBQVC9wZHhEaTBIUEpkK2FMKzk0ZGZzMWpu?=
 =?utf-8?B?Y0MzYkZYcTNQazROR2JQdUtNRFlBZVk2V3l2WXIyVU91MGZlWVdiNnVwcldO?=
 =?utf-8?B?endzczFmc0N1eWhGVzR3K1J0dTFtNGU1L0F2OHdjbHJTeEN5VkNvRWkyM3ow?=
 =?utf-8?B?YVZwY1dOUzU1Q3FGL3FERUJvSGVraFFkZTRGOUEreUV1bVRzSkl6bEhKZktD?=
 =?utf-8?B?OEVFVGtTV29tU25xb1liZysxelgwUWs0ZkZkdmtHWm5hUFh4a0R3bTBTcWwy?=
 =?utf-8?B?Rm8vZnVQTXZ5c1gvU2VmcUVuWXpTOWdPcWFJSWY2TjFXZG9VbkI1S1kwR2Rr?=
 =?utf-8?B?T1FlVGxZUEczTW9RSVFTVXZHMTlkN291S0pjK3hWZU4waklIeDJtM1pobzdy?=
 =?utf-8?B?eTBWWXNiSUZzcjhONkRLSHFVYWtoN1RwMXdzZFZpT1NKVnlic0ppZ0c4dncy?=
 =?utf-8?B?cmZobUhoZHhSOFlmN3ZBTnl2OVN3MjdYVTJEMmdVS3FFVzNuTzF5NCs1NlpS?=
 =?utf-8?B?SlRqVnJZaTVWWlBQak1QTHpybHQ2Qy9tMlE2STgyVXlCdlpseFR4bUJsRUdL?=
 =?utf-8?B?Y1V1dStIeTl5RkZDb0J3WWF0UG5RcitYWC84c2pISms2N3AxY3BZOHM2T3l3?=
 =?utf-8?B?NjB6eUpYQit4cGpFOHFUN1JHa1pmbndsUUFhVFAwNnBUdWlBczR4T1JEUTQw?=
 =?utf-8?B?bm1CRXBhLzNhM0xZTEdxUndNNGI3LzJLZ3JOU1RJbmphWEY5bWhUY1BBMVRT?=
 =?utf-8?B?cVBTOFF4M3V5cjQrRnlaWm80RnZTUXdtUkQ1blhXb1EzWlF4RHdyNVRpR0ZH?=
 =?utf-8?B?SGUvL0VSa3RTVUs2RHphcEJKWjRNaHFQYWJSSWNmTWdKWDlJSTRyVEZPQndh?=
 =?utf-8?B?bVRncnFhU1hVUmFKYmFwYmZsRlhHK0FYWC9lMGhNM0w2VjdwZ293YkZIcjZH?=
 =?utf-8?B?eWQ5NEczbHdTSW4wVDZQTWJ5NElIeDdjSjFxcERsVWxLLytXc29QZmZmeTJy?=
 =?utf-8?B?ZjUxSnRrWGx6K29jRGVkaFZPQzR1NnFWSnAwSzdjUzZWY2RoSVF2TnY5SUpG?=
 =?utf-8?B?MlJXQVhlT29vaHhjT2taS210bzhWVzRKd0laLy9KT29TU1UyazVkR20wWGNP?=
 =?utf-8?B?YXEyK25SWVd5dWowdmJwbWdOSDhCdncreXJxakY5YkRHb1pZbUF6ZmFUdHl0?=
 =?utf-8?B?cEtXUlZPT0ZyTkdnMGFHeThpSlNkeGdJcTB1eXlST0dwV0c1ZitmanpYak1w?=
 =?utf-8?B?U0w5Rk5uRDBBcFh6V0VIWmN4bmFrSmVXdlQ1RmpwSHdnV1lQdFd2UVdwYmNH?=
 =?utf-8?B?aGRMdGlIZkdGejEweEpuQWg0K2VuSjhMRlZWdko0d2x2SEhMMEVydFF4Q3d4?=
 =?utf-8?Q?Ov/33TzOhDNTKihq+3XJh2uty?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae64c913-f068-434b-b13c-08db81b0a689
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 01:46:31.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzUyJLW7QaNyMjjJlRgpV6vMnszcxipkKH9HSADvzALOedghBVui5CwynCn8t+d1zRG3O+57aUsq31DOnEFV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTEsIDIwMjMgMToyOSBBTQ0K
PiBUbzogWmhhbmcsIFRpbmEgPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiBDYzogVGlhbiwgS2V2
aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+
OyBXaWxsDQo+IERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT47IE1pY2hhZWwNCj4gU2hhdml0IDxtc2hhdml0QGdvb2dsZS5jb20+OyBp
b21tdUBsaXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDYvNl0gbW06IERlcHJlY2F0ZSBwYXNpZCBmaWVsZA0K
PiANCj4gT24gRnJpLCBKdWwgMDcsIDIwMjMgYXQgMDk6MzQ6NDFBTSArMDgwMCwgVGluYSBaaGFu
ZyB3cm90ZToNCj4gPiBEcm9wIHRoZSBwYXNpZCBmaWVsZCwgYXMgYWxsIHRoZSBpbmZvcm1hdGlv
biBuZWVkZWQgZm9yIHN2YSBkb21haW4NCj4gPiBtYW5hZ2VtZW50IGhhcyBiZWVuIG1vdmVkIHRv
IHRoZSBuZXdseSBhZGRlZCBpb21tdV9tbSBmaWVsZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRpbmEgWmhhbmcgPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS9pbml0
LW1tLmMgfCAxIC0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IFNo
b3VsZG4ndCB0aGlzIHJlbW92ZSB0aGUgZmllbGQgZnJvbSB0aGUgbW11X3N0cnVjdCBhcyB3ZWxs
Pz8NCk9vcHMhIFlvdSdyZSByaWdodCDwn5iKDQoNClRoYW5rcywNCi1UaW5hDQo+IA0KPiBKYXNv
bg0KDQo=
