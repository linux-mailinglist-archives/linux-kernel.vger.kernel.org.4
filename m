Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01F56CA839
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjC0Ou3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjC0OuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:50:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27048468F;
        Mon, 27 Mar 2023 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679928622; x=1711464622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yjF77DZmM3PVnkye1fx88wOVrSBYHC0DSCn5+VjjgkM=;
  b=ksK3jaF2sftBdT0y75H7o2pfnO0fbyFJLCfEDUrzRBbw9zhD7a1DBa72
   syxvdzA8sxx+4gsTfJR8JiMuHyCPSMwfkfbwMvbRf20xQc5te38RC0o8i
   fg903Hqf0Fd00RHNJH4kK6aKX0pT8ECAgxINjHmaM2jVlFkP5nOuLHqCg
   H32sVAqCoBd0aWPdw3yUG4hUm3Vm7XK8DepAaS/xX9J4oCuvdgeUOm8hY
   vLrwzgaqzfU4ea23qi0m790z6jddc8NpgCf/PCesomICPGBoWmsN4aOP3
   mWtp/lYyjIRPKp74FgtO74+SL24vsx2h42UBoz6zc9ptSghCI+7BFvv0E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="405209788"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="405209788"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="772731332"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="772731332"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2023 07:50:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 07:50:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 07:50:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 07:50:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 07:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayKfVLXaSbnEsF3XjJZYPp3d0PLSJzR7MrZa/xP0LmyzQh/s9Uxp/dWGWV2E1TEc0quA/nemrQ3JT0udHVtiUvSx4L+NrujikONkRf/zzfPrS3af1Aw+uxpEcwlXeBCYEi0sTy8wcbxE6GAKOfIpKn0ICc2P/O7/IjaKyZkP2r2vBYe/h/vvtz8UcwSmkYnLnJ1XCcW6wzVppmM0GFcZn9htz+C/HvAyoKv4hQpedL6+zYaOgfbM5OGu7ZyGcj0ByJlS5jDb8E0+7ZCLkNYeWmI03BBrYjWYcXVLwEAHGQbNO8FCye2LWvzIzF8Y6aSWxYOXgY0X3I+5t0hdXkD5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjF77DZmM3PVnkye1fx88wOVrSBYHC0DSCn5+VjjgkM=;
 b=icTjeNAiFjFzia7FFDiEoo+e1xg9k8S7dXGDVV61M9WmbT4KxQwcllSSdZeO03kgjtTdfeqrb20o/atgKefNrzvg8/9+S6yN07h5MvFreEvdjYIQOy7n2dx+nMcLNhp72OW6s8QeWYVzJumiuR4vcs6QO2NIun3RBOegTRfUCODTKm/9t0LO4/rqp9LLEHnyhuz22n/K1PoCQu2SicnZO4b3bppaUrFkRrPMqCgyl3cIH8DtUBQFwEGQHjib65Do7dooZRuaOaSp6eVFi7sRzJQeZKcqWATTIVrVOmni/KA/kdqUDQapuqiaxabs4ow3P31JDC9h7HWAVR3i0Ec2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Mon, 27 Mar
 2023 14:50:13 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 14:50:13 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
Thread-Topic: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
Thread-Index: AQHZXh9xqEpW/nDCyUCGOxFmhxFRx68J6moAgATQMgA=
Date:   Mon, 27 Mar 2023 14:50:13 +0000
Message-ID: <528f7e58507df4b6137856828e371bb8913b8b59.camel@intel.com>
References: <20230324070807.6342-1-rui.zhang@intel.com>
         <20230324070807.6342-2-rui.zhang@intel.com>
         <CAJZ5v0gze1wBEMcuEu4Aa9343rh-3=Bu+pdSYuY3stMd8QGf0A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gze1wBEMcuEu4Aa9343rh-3=Bu+pdSYuY3stMd8QGf0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|IA0PR11MB7378:EE_
x-ms-office365-filtering-correlation-id: 72226231-381d-44ad-4837-08db2ed29213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6BFpbz4usIE9CFGWBELxQn7IBsuSJe2/76YNE9Osq8vDJEyasidLBtqPEUe3+QnDuz7CdDg9MOrP5Cj4FnyNYgUp6snHkPEorJ6Q3O+rIMaiWHbjcTQoqLHHsh0GPYWqMb69Z4kY8ijXafCQLzaxJTNtLh+b8dPE8W7n/e9dT+RS4BwVl2CUanJAhFn2ifk10OKxhXXQq8aYgDbXen9omij+e1/optIxYqXwA1qSr8MoxNHEhifOqzPXDAuODQYReHhEVlHfaEpInyDPWTpSMKv38+i/GYSAoIbtvhulqwjXupn4UJJVUAChM+f4OaGsWwQ1jzZFK4vcU997g8beOSi/OXcJcQbhQ/BCgcyqVf6vLm9nOr5AEeYMLODQCItc1Ie4C3j3TfKLNrV47BpDfvhwxRqcXua+Y66VGiuqEUH4HZtuY0xZzAda0BJ6j135/BArWoclPu+380Xp74K6V1PsiVnwgylYEGKO4OLUBo+Q5sVGVst/zIaPwhKz71yq5Kgj4cU4OmxbgbVJ1/AIzl+PoS4qPWNezGFNpLEugun4DT5dJ+jgsIjUhLK2ihHrSKwFqWl3n3vVo9o+zhAGVP6XStDAiY/C3qw5r7idSaiq2Kid8NyVb91anw+SnJsB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(38070700005)(86362001)(36756003)(2906002)(478600001)(6486002)(53546011)(2616005)(6512007)(83380400001)(71200400001)(38100700002)(54906003)(6916009)(91956017)(76116006)(4326008)(66946007)(316002)(8676002)(66556008)(66476007)(66446008)(64756008)(5660300002)(82960400001)(122000001)(26005)(6506007)(186003)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnQrNnFINUJkc3h4TVBUV2Z2MXJ2aUJIVlRSRVFVNXE4eUxUdXdhenNBczFk?=
 =?utf-8?B?cG9ldzJFbHIvNmV5QTV6cmdFdnZrdENZYlhKMWVlTmFyeUdlZHpRcE5Tc2R1?=
 =?utf-8?B?eG1zdVFhN0ZYTzFNOFhoUnlmN1hGNHB1dWFMdUNsbjV0NTgzNkY3dzE3dmJl?=
 =?utf-8?B?cEZLOG80MjBTdGhjbDlOK1B0QTdCQ0xZOVhSZHRQOTVJQW5FNTJrSUlqQ1V0?=
 =?utf-8?B?K2pybkxzY2NvNzRHSW5HRmw1NnVmZm5LWTNoRm5lSEVaYVNpaXdrczFFRWdJ?=
 =?utf-8?B?bVU2dXlHbGJ6cWliVHdjU2FXY0dyZUtvMWttaVBjMU82M3pRM0M5U3lWZGZH?=
 =?utf-8?B?MkkyZ1FTTVhYb2ZvL2dJdEh4anQ1YjFMSldKdmJmUUIxeFRBSzgrWitPSndy?=
 =?utf-8?B?cEVXVFhjanByRnFnYlpIRXg3Q0JOK3NpYnJxSG5lMDg4czBMaCt1VWNEU2dT?=
 =?utf-8?B?dnFRdkxIb1h5QnlVR0ljV1NQUDgrY3FlSCtpZjF4ZXJjemFIQW5XaThPZFNE?=
 =?utf-8?B?R0s5Q3ZKWEg5Q3dsVWgzbndUTEx4U1VMTDk0cUpWaDY0WE0wekxnTWxKTXlR?=
 =?utf-8?B?OGxJSUpVNmIwTE05MUVwZWxKdVhKV1VlNjBSL0dxRllKYWlFZ2dWQ0NLRzZn?=
 =?utf-8?B?R3o0TWVRSkZuaG95MFlTem5UcDQ1MmZCVjlNaHhueWVnZjlCaG02UWpSZVB2?=
 =?utf-8?B?bDlLQ1pVUUwzVkoxbWJYRTdyaTdscHVPOUR4QjAzOFMvL1BlcHU5ZnZlTnhP?=
 =?utf-8?B?cDZMcEQ4Ym5TNUJlbTV6ako2TisyQkFJY0F6cGx0L2V6YVNUYlhhZ2FtaTJR?=
 =?utf-8?B?MzZHRFNYaUgzWit3UkNmcm9MRnl4TVFFYXAxV1g3S3ZpYW9TOWx4MGRBSzcr?=
 =?utf-8?B?Z3BTM3dVckh6ZWNvM3FRVlVCZ0J0WGRjaXZJOGtCK0IyeURtYVBTM1ZZbGZH?=
 =?utf-8?B?WkhtNzBtdHJPcm1RbmFQYjh4YjdHelhIbURtQ0dselRmYmhKaVQzbFBYYTZR?=
 =?utf-8?B?dzRtdGVqR016T3c0T08rRUx6V3RhcW9HSGNtMm5VZHFhV0ZTVEExTWIzdzFS?=
 =?utf-8?B?MGtPTHJHVmRESEx3d1J3YU5xN3JBaGsvUDVwWGkwamhvMzNvMGsrUjZWN2Vh?=
 =?utf-8?B?TDl5Q25mM25aYS9kWXYvMEFvK2Jvc2Z1L0pFOUJpQ0dpMXg5ak56QlJSc2Fx?=
 =?utf-8?B?K2FGZE5qd2ZsRm9jaDdXdFVYQzhObDg5VzY0aHlJSWxnVHdWVXh6MXlFc3Bh?=
 =?utf-8?B?QXlHSUlUejdOVDFNZ05pNG5pSVE0K2g1UnJyNUZBYWpYejFMVnd1OHFNblE2?=
 =?utf-8?B?ZUdHZlJrVk5waFhNd1NvK3lyTDFoaXpJOXBWN2Y1eEd1WlUwbng2WmxDaUZ6?=
 =?utf-8?B?ZzJJc2R6SytoM1V2M29xSi8vQVYxd2pwZC9LdHg3R1Y1OTRtVU16ODFTai9z?=
 =?utf-8?B?aThDclJ0RFcrUDFRQnFYNnRqZXk1WklEUHUvZkEvWlpTR21Nb1RXamlqTmpG?=
 =?utf-8?B?WmJkd3RydW8ycnRSTFdqWTBiY2Z2aENoZUNNbkFIWUpGUTV5djkyZFNSWW10?=
 =?utf-8?B?bURqZjJQTVZPMFB3L0k0eU4wM3YzczdvalJoWmt3NjdUelBudy9qZ3BtK2hL?=
 =?utf-8?B?TlA4QzFtZDVjMFFxdXZpUEFjclUzTGhFaXA3M1pQN3lDZnFIcG5jYTd0NEtW?=
 =?utf-8?B?akR3OWFWbmdJZ1lyRUtpR1gzeU5RYXpmeEZGQXVLRFRMR0t2bkMzdm9yZ2Mv?=
 =?utf-8?B?VE9TQXMrUERCZGRZRlBvS3VQbXRkNzFHYUxGNk5LcURxODIvVmRlemFWNDdB?=
 =?utf-8?B?N0FaMm9LRmYwelNlR2orcS9IaFZNaW9EcVcreUdTOTJzcFNUdzBJU2hrK0ky?=
 =?utf-8?B?emZQT2ZqT3h0N2J6dEJyR0RBM3NoaVJRUmVuYjlyV0ZBWHZwU2Ywb3R6QlFs?=
 =?utf-8?B?QzNtTVpYSGVnZFh3L3BjeEphUVNpSWZveVFxQWdTU0trV0ZvM1dQOFJRaTJ3?=
 =?utf-8?B?aUVEaHFzeFJmU2VLdWF0N1czK05yNXg5bGxoRXh0djg0WkdRRUtrT0FEUlBW?=
 =?utf-8?B?MlpzMExpZlc2V3JSbms2RW9QZVdtOGpVZ3hNalJXaFN5a0dzZ0w1K04reXVu?=
 =?utf-8?B?ekhjL3lDQTdMdXBuRWt3bW5iRWtzcGt5d2hkdkxFUDN4Lzg3b3lCbDdEL290?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5E04054CCF5884FB44347F2B3FB14E0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72226231-381d-44ad-4837-08db2ed29213
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 14:50:13.1648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PF6mrXsReKPSzBMq2EU2SmnHv9t8Gk4IqDhBgiJarOIPWDy/eNqclqcDg6wdWroZhjhFW0VYp7gs60s9cheN9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTI0IGF0IDE0OjE5ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgODowOOKAr0FNIFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gV2hlbiB1bnJlZ2lzdGVyaW5nIGEgY29vbGlu
ZyBkZXZpY2UsIGl0IGlzIHBvc3NpYmxlIHRoYXQgdGhlDQo+ID4gY29vbGluZw0KPiA+IGRldmlj
ZSBoYXMgYmVlbiBhY3RpdmF0ZWQuIEFuZCBvbmNlIHRoZSBjb29saW5nIGRldmljZSBpcw0KPiA+
IHVucmVnaXN0ZXJlZCwNCj4gPiBubyBvbmUgd2lsbCBkZWFjdGl2YXRlIGl0IGFueW1vcmUuDQo+
ID4gDQo+ID4gUmVzZXQgY29vbGluZyBzdGF0ZSBkdXJpbmcgY29vbGluZyBkZXZpY2UgdW5yZWdp
c3RyYXRpb24uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IEluIHRoZW9yeSwgdGhpcyBwcm9ibGVtIHRoYXQgdGhp
cyBwYXRjaCBmaXhlcyBjYW4gYmUgdHJpZ2dlcmVkIG9uIGENCj4gPiBwbGF0Zm9ybSB3aXRoIEFD
UEkgQWN0aXZlIGNvb2xpbmcsIGJ5DQo+ID4gMS4gb3ZlcmhlYXQgdGhlIHN5c3RlbSB0byB0cmln
Z2VyIEFDUEkgYWN0aXZlIGNvb2xpbmcNCj4gPiAyLiB1bmxvYWQgQUNQSSBmYW4gZHJpdmVyDQo+
ID4gMy4gY2hlY2sgaWYgdGhlIGZhbiBpcyBzdGlsbCBzcGlubmluZw0KPiA+IEJ1dCBJIGRvbid0
IGhhdmUgc3VjaCBhIHN5c3RlbSBzbyBJIGRpZG4ndCB0cmlnZ2VyIHRoZW4gcHJvYmxlbSBhbmQN
Cj4gPiBJDQo+ID4gb25seSBkaWQgYnVpbGQgJiBib290IHRlc3QuDQo+IA0KPiBTbyBJJ20gbm90
IHN1cmUgaWYgdGhpcyBjaGFuZ2UgaXMgYWN0dWFsbHkgc2FmZS4NCj4gDQo+IEluIHRoZSBleGFt
cGxlIGFib3ZlLCB0aGUgc3lzdGVtIHdpbGwgc3RpbGwgbmVlZCB0aGUgZmFuIHRvIHNwaW4NCj4g
YWZ0ZXINCj4gdGhlIEFDUEkgZmFuIGRyaXZlciBpcyB1bmxvYWRlZCBpbiBvcmRlciB0byBjb29s
IGRvd24sIHdvbid0IGl0Pw0KDQpUaGVuIHdlIGNhbiBhcmd1ZSB0aGF0IHRoZSBBQ1BJIGZhbiBk
cml2ZXIgc2hvdWxkIG5vdCBiZSB1bmxvYWRlZCBpbg0KdGhpcyBjYXNlLg0KDQpBY3R1YWxseSwg
dGhpcyBpcyB0aGUgc2FtZSBzaXR1YXRpb24gYXMgcGF0Y2ggMS81Lg0KUGF0Y2ggMS81IGZpeGVz
IHRoZSBwcm9ibGVtIHRoYXQgY29vbGluZyBzdGF0ZSBub3QgcmVzdG9yZWQgdG8gMCB3aGVuDQp1
bmxvYWRpbmcgdGhlIHRoZXJtYWwgZHJpdmVyLCBhbmQgdGhpcyBmaXhlcyB0aGUgc2FtZSBwcm9i
bGVtIHdoZW4NCnVubG9hZGluZyB0aGUgY29vbGluZyBkZXZpY2UgZHJpdmVyLg0KDQp0aGFua3Ms
DQpydWkNCg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5j
IHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gYi9kcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiBpbmRleCAzMGZmMzkxNTQ1OTguLmZkNTRl
NmMxMGI2MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiBAQCAtMTE5Miw2
ICsxMTkyLDEwIEBAIHZvaWQNCj4gPiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3VucmVnaXN0ZXIo
c3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UNCj4gPiAqY2RldikNCj4gPiAgICAgICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+IA0KPiA+ICsgICAgICAgbXV0ZXhfbG9jaygmY2Rl
di0+bG9jayk7DQo+ID4gKyAgICAgICBjZGV2LT5vcHMtPnNldF9jdXJfc3RhdGUoY2RldiwgMCk7
DQo+ID4gKyAgICAgICBtdXRleF91bmxvY2soJmNkZXYtPmxvY2spOw0KPiA+ICsNCj4gPiAgICAg
ICAgIG11dGV4X3VubG9jaygmdGhlcm1hbF9saXN0X2xvY2spOw0KPiA+IA0KPiA+ICAgICAgICAg
ZGV2aWNlX3VucmVnaXN0ZXIoJmNkZXYtPmRldmljZSk7DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4g
PiANCg==
