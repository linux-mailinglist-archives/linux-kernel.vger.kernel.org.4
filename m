Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EA61A6A6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKEBeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKEBdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:33:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B173419BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667612025; x=1699148025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=THAMYgcFV1a6Fuocyar6l7GYNc3NdUlIna5xGs/B0OA=;
  b=QRe765QDYEzByvMb5h2EtODpi2MaCxI8jRdQXDIcii30YRqla3ZXtniv
   cJjO0ko+5a/o5QOs+9ndCf1bZqQnpxTPEadvD3UPvxId+kZQgR72XEUnr
   M+oea1sika2lr1OgvLPJYt6Uz/g+9l2y3gtk9gk/895SoWn7w8XqXpYZu
   CAClTgNmLZSyjnH3YIgOzy3qHimeZ/0B1ZGyUrXPzXN4o5+vxvAI3fAEy
   kBsdR5pDGz5xOxofIn4BmWXYytCVw56R7XeeazFrtYQCTm3eCaiDD3SBt
   yPma4e3u7O3S67QoVwEZoadvAcNo0zgVhqARPryq1/+kDOLC0fpBdTpMr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311231986"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="311231986"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="629911372"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="629911372"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2022 18:33:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:33:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:33:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 18:33:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 18:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvJ1oDB/xqkhtA0zkM1Ub/UhO1ilxA0pq37Jj7klYF22dPhyqq5hEgvXXl6XvHXHYzwASuiHbKn1kVd4sVD8PlDFhr5JfYDTmIfkwwGUNuxrEcrIJWAn7pFsYNERBYFQruYbVOvCjVALwfVzNicMxw0ZTp7YBR2KvqwQGcuk/jDkC3oXngt/dea/l8GZqnoeJKGiBkgQdMr7cAifUIwrlnCXX18b3sSM6gKqmxS82RK/uq/y9EdtpVp0tqdZSsswJkmr1APDBXnrFg0TSknvlo60e8dZHmGM/o/ORM6vcAoopdgfsGv1qGkDXq+3fJ+C8MP6lem21/Iu2twe8BnV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THAMYgcFV1a6Fuocyar6l7GYNc3NdUlIna5xGs/B0OA=;
 b=miTsQl59FMj0nzutzAAWer6r0Lxhr+jNtw2afv5m47aq8R3gLapE36XMMQ9loUdrhMSR4b29Cqhy/kOJyggAisM4/1SPOA7MGCpuqRJbG6pQ72/GbfNqpPfAIxnFERYTUR8L8qZi6vXyPZ86uzB+scWEoAHux4FzgC3pbHfbgyOVe9fY5cMMzc1qG7kvYmWxJRlUeJmYpXLqZCCKAc88i2MciZ6NZoxXEL7uxx+JCbBFVsA0vm1YQxOe7Kv5I6XCD1GDTVeVNl7EdUy6+Zw6igVyxgK9qKWv6I211ojr9awFw8WC/ZJomVvXrtjl2BFS6yFwot/TncKVA772mVUUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sat, 5 Nov
 2022 01:33:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 01:33:32 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] iommu/vt-d: Allocate pasid table in device probe path
Thread-Topic: [PATCH 1/7] iommu/vt-d: Allocate pasid table in device probe
 path
Thread-Index: AQHY70mafo0sf+eGQk2VRBjKoctuoK4uBUSggAGCr4CAAAaRsA==
Date:   Sat, 5 Nov 2022 01:33:32 +0000
Message-ID: <BN9PR11MB5276E7FCC95748AFC30161628C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52765902DF41858EF445E5BC8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cf157186-1ee1-0981-5425-d9cd186df57f@linux.intel.com>
In-Reply-To: <cf157186-1ee1-0981-5425-d9cd186df57f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6776:EE_
x-ms-office365-filtering-correlation-id: 785dcf80-b2ce-4986-5279-08dabecdbfc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tiPH4BU4F2KjBgbpZLaC9reB1+lF2T2NSq6PjBZYcs3Z+eCjDhIuHUbkBnJT8av4DizFJQN9CuEaBsZTHLX4e/Wt0BfUfFSUX1iLaCnPb9khdktERYrVxtjR45pZG9HWbBNhr2g8LZ+nZ7oJf/6/Rr9vWY2OgSqnyqNHuPfrLX7r+PnkYyCNNtyNW039m6+V+5iNs+oGuxZLaUuIOvwpLVQaB0IMpvvJiTMUxXxi5CFGJClx8KIASV9eAB2EopI3u9ReXaNSORd2Sb9Ob7qTQyW0e35rJvM3mjI4kKdSSjqg5xDf2eZayvitHrMTrqReridOjTJFQA/ZsSdip9Ax8MS/IaYdIxAvbdCHaGmJ2kP5okgNwzcpkxYxXfIJhFMxjbEQLBL+kPHMt/ncUmuvQYDVBmypXcP0fAudMUC9DE1GcR/ekJFtYQirTaBlC59atyUrWnzI3Vm7Fe8hBGBGu4+sBf8Cs6SbzC/Dm6+FDQykWFOzabMUWljY2IMhH9kjJyAmXzdaZ2jQ00o+H6HmMLRc6XHW9pWkvHPiDGKkwWskcacTruBmr58tRB4w690DpCEqVCQ4XlRr+jr3KbO0MkR7QcjqRJ6HuKKF6PKyfm1wOhVP7ab+klyeYaEL2AARnLumhTmhq4pctexJr2rjJngfC+k989e+aE/aaPVDihsMw6CqsckwWfyvOIXkmQBihrChVSo+vFuzNA8rXQtrjd0ynUbLHhI4RMWsqPQkGVV9tVKRcT3vaGCKhFLLHDHknQXJmqcrbzxQWlXjhrJodg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(54906003)(316002)(2906002)(52536014)(110136005)(4744005)(9686003)(66476007)(66556008)(76116006)(53546011)(8936002)(66446008)(64756008)(6506007)(4326008)(8676002)(66946007)(7696005)(478600001)(5660300002)(55016003)(26005)(82960400001)(38100700002)(71200400001)(41300700001)(33656002)(86362001)(186003)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVFLbWlDYldCQm5VdnAyaWdQM3RZYTNDaHlva25VWHlFT0hoMlR3VC9ndnVn?=
 =?utf-8?B?TjRoRzRWbjU1Wm5SUXdoUFgzMWpQNlFjcGp1dk80cjFmOW4rNWVVRnNUMFlp?=
 =?utf-8?B?bE8vTW5ZdXpTTFE2Yyt2VVBCSmU1aHVuaVA4d3QvRzNEMkhYQjd4cm1Sc1E0?=
 =?utf-8?B?Ni9NTWNjZE54R3RHemllZDMxU3c5UDVuQlNUbGRndG83bVRPbk9IeitiMUZ1?=
 =?utf-8?B?eXRza0NaS3duNkZuOXk1RzN1c3J6T3lZaEozc3EzTWJ5VVhpSTB5R21mZnB2?=
 =?utf-8?B?WXpwUDNvcTR4UEtxNkVHOHMwSDZoZUMzVWoyRlBPdk1Ya2ViWVJUdS9mSWxh?=
 =?utf-8?B?MUdybklrckN2VU8yM2cwVjk5S3VWMW5vcVJaYTZqWFkzVEd0ZWI5RGREdU80?=
 =?utf-8?B?M2ROdGFwVGFzalpiWG4rWUFkNThZWWwrc1d2K1BDa3ZSSFpWaUhJMVl1L242?=
 =?utf-8?B?d2V1SnZiM2lob1FXZ0o4R0NVNHlkUU53eDlPZnJ2MjArYnJKMFh1cWJSZ1cr?=
 =?utf-8?B?OUNhdFdBc01BTlk0Rm00TTQ2ZlY1Y1YzQzdRTm16Rk1GUTUxM2JsQ2Mwd3Ni?=
 =?utf-8?B?Q1cxRmZObVBQSld4OVRNN1VQbkpBTGpmWDgxY2JRNGdSWEZwTE9OaDJBaEZa?=
 =?utf-8?B?ZUx2NERQQmNtdEorQnZiSzNzeWRoM001NFBMRWFpWWVXUmZLU2dQMUsvV0ly?=
 =?utf-8?B?RGJSblQ3bEpha3Nqa0EwNjY2R0hqZzZWQjRIbVc3NnB6cjY2U3hnekE4OWZ3?=
 =?utf-8?B?dWJoMEtzVTNQTjhiR1BvY2h1NkQybERpM21KMGt5Ny9tTng2eExUWmNsTE1E?=
 =?utf-8?B?alBoQkkxSjlkelA4UldtZnNJc3YxenVqM3dHVXZYMWdEZGRkRXpDcXdBLzhP?=
 =?utf-8?B?UmRnYlNESG5hd0pOL3dLWDBaMlplYWZ4N0YzQStGTk5WYUtocDVDU1VIL05a?=
 =?utf-8?B?TWZJeDFqdExpelNKbjdHcnRXWHB6OUZWMkMwM0xkOFVDMW5IcWR5TGZidm95?=
 =?utf-8?B?Q2FnTDZRVVlVVHlDcko2N2RyOUs4OWorbWNhRHlpYW5qTVFmZmVsRUxOTFdv?=
 =?utf-8?B?UEYvRlk5WitlOHIzc0wzM2YyM2NaeVNOZHhPdTBVQlV0T0ZEUlRvOTdQZjBj?=
 =?utf-8?B?SU1XdktySWdYY3cxS0huUHhiVERJWmtlQ2p6RUZYNTRRVDlreTh0ekVJT0sz?=
 =?utf-8?B?R3dRekhobTRFTS9JblpDVU5NZndLbXNOcEcvSjdPYmVFNnYrRWR2ZXk3YnF3?=
 =?utf-8?B?aHlKUVByWlgwai9mY3Z3S0xpR0ZRZkkwUUkzRzI5d1R0eS91bmt6alYvUFJp?=
 =?utf-8?B?d1pCN2N6MGlSOXZBMGVGRG5MVzVwVWttRnAxdHVnKzBQWm1adDMrZmpqVDRm?=
 =?utf-8?B?eU1yZkZzeEUvbWlOUE80a1haR0ZGbnUzT21nUys0RzlRN0hRdWFhaGpqeEtY?=
 =?utf-8?B?amx0Qm5ZMzBUQlBUeGQzOEVOVGU1TkhEejlkT1orTjV3YXYrMU1wanBKZ0l3?=
 =?utf-8?B?NExTMnhPdGhCQWU5dHpBeWU5cENxaXpJaHZCbDFqa2lLSEhVZkdoUGszUzEx?=
 =?utf-8?B?WWc1K1pRV0tnYWthSVRUaDdvTmxlZXZFaHp6T0o0aXljcVVyeHIzREpUSEd0?=
 =?utf-8?B?YkZjOXZlTEYrcVpoNDcrK09pbEVYYnhvR3pEcTJDMm00M0lrb0VkWTdHazBr?=
 =?utf-8?B?OXMxYXM4cmxTRmpEelJabWFzYVkySlkxd0tuNmgxdkt3UHN5aFd1QWh5NVRq?=
 =?utf-8?B?RkZkcnYzRzQyQ1pyNTA3dDIxYkxBVVFsU0FDK0x3aWdjZG1YVFFwbWxITVJ2?=
 =?utf-8?B?ekZWemhnVThkT2RmN2dBVHlTU2Y2Q3h6UDVlTXFacTJnREt3SXp0VDZDMTdR?=
 =?utf-8?B?L3lZZURiYkZZN0RJblM4Qm1YR05xWlZDdy9mNXdvZGsvMVlHbWJSdHViVWsy?=
 =?utf-8?B?UTdzNzFlVzJnTlpsMFg5OEZFbHpFMXVtSkM4aGplVUNIaG8zSVlETlJpdHAv?=
 =?utf-8?B?K3d1ODF6bkpITXdOU3U5d0xjZG51M3VnUzBaZnB5ekljZEVCYTBBSWgxUUhr?=
 =?utf-8?B?alFObUhiRi9kYlQ0K0RwOVN4RWlPdUJqMjhidDErbE5LODNlRTcvREdRL3FB?=
 =?utf-8?Q?9qTz9sm2zru4FRpNVYk3wH3k1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785dcf80-b2ce-4986-5279-08dabecdbfc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 01:33:32.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpFz6t+S8xuTHDBB5CSI82fk5jwp7gV8WJ0sVomFudXLPzTcnZ6Qy1x047lEK3xgR4j5R7f4/H7MAVrhk6IU2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgTm92ZW1iZXIgNSwgMjAyMiA5OjEwIEFNDQo+IA0KPiBPbiAyMDIyLzExLzQgMTA6MDYs
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMywgMjAyMiAxOjUzIFBN
DQo+ID4+DQo+ID4+IEBAIC00NTEzLDYgKzQ1MDYsMTYgQEAgc3RhdGljIHN0cnVjdCBpb21tdV9k
ZXZpY2UNCj4gPj4gKmludGVsX2lvbW11X3Byb2JlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ID4+DQo+ID4+ICAgCWRldl9pb21tdV9wcml2X3NldChkZXYsIGluZm8pOw0KPiA+Pg0KPiA+
PiArCWlmIChzbV9zdXBwb3J0ZWQoaW9tbXUpICYmICFkZXZfaXNfcmVhbF9kbWFfc3ViZGV2aWNl
KGRldikpIHsNCj4gPj4gKwkJcmV0ID0gaW50ZWxfcGFzaWRfYWxsb2NfdGFibGUoZGV2KTsNCj4g
Pj4gKwkJaWYgKHJldCkgew0KPiA+PiArCQkJZGV2X2VycihkZXYsICJQQVNJRCB0YWJsZSBhbGxv
Y2F0aW9uIGZhaWxlZFxuIik7DQo+ID4+ICsJCQlkZXZfaW9tbXVfcHJpdl9zZXQoZGV2LCBOVUxM
KTsNCj4gPj4gKwkJCWtmcmVlKGluZm8pOw0KPiA+PiArCQkJcmV0dXJuIEVSUl9QVFIocmV0KTsN
Cj4gPj4gKwkJfQ0KPiA+PiArCX0NCj4gPj4gKw0KPiA+DQo+ID4gbW92ZSB0aGUgYWRkZWQgbGlu
ZXMgYmVmb3JlIGRldl9pb21tdV9wcml2X3NldCgpDQo+IA0KPiBpbnRlbF9wYXNpZF9hbGxvY190
YWJsZSgpIG5lZWRzIHRvIHJlZmVyZW5jZSBpbmZvIGFuZCBzdG9yZSB0aGUgcGFzaWQNCj4gdGFi
bGUgaW50byBpdC4NCj4gDQoNClllcywgSSBvdmVybG9va2VkIGl0Lg0KDQpSZXZpZXdlZC1ieTog
S2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo=
