Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC714686267
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBAJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBAJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:07:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C500E6187B;
        Wed,  1 Feb 2023 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675242396; x=1706778396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dd786QJooNdtZT54cvH3ZYyWOKpnXDUwUfyx66nEaEQ=;
  b=PWSfKMlTuaBDq9DMwEu6TBkKr2pyNGZZfAtRL11vzcka/2HODMSNZejG
   /Mx4Q+qWrDUMShH+Xeg0Z+KWwFjCUzDfrW5OM3OmAc4WtmZg9bVhVIJd4
   HaKBezMu+syMsHHJ79/ftHX1boYXXYTubjGIWJ9Db3WOgw6zpNIqT1fOI
   PVwppREOA6TcBIY9usNnx0DaR112czBQzd4+BkFhaBKvE2kd7X4F6ra10
   tb1hWcZoLvE6sn63TwjlnwtKdU3soyk238V7ptGZBfY5ZstxPceWAs00d
   WAnXHQB9RpLoxKtSgT1VmnGkT1+ZhZ+LtCTUNHqmd3AOjutYQ9uQecNDB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="329384537"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="329384537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 01:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="838700863"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="838700863"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2023 01:06:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 01:06:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 01:06:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 01:06:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 01:06:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRmCmMdXJAChi/HRm7fZ+PCUFQxvT1lVkSdmGctvyTFjjQYybU1d7Uj465QvWYjE1AuaGCE1EpfZEntZbt+cmlZXmymz6iob6b+5VMVYavLSogS1vvqLChlg8cpZA0IYgLPj7gcfJ4KtAYBW/7+OVtT/cJ6jOA803yvOa4Z4f6DqeHNitYWY3BxzqSk6Nf15Xx/QmJQt84ffFeYZLV3ZOpiCxUjMxtxKIQOZda4VhkDALsCj2FHmdr2mtPJOePo7YaNvj+Qiia04rpPH+jiOCikLtuT6hEidF3rLQNNjYVKKHfnzruD4Blp5LrXg3EFyk3/7BAML9xqqzbXvY9jR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd786QJooNdtZT54cvH3ZYyWOKpnXDUwUfyx66nEaEQ=;
 b=NS/e2Q+EH1sh1jh3U0OG3ejeX5txRRlnItAlTHNOSTZI2eRSSU5isPAV/vhCpFnzZMTbOJBMyS/fz5SzmmBhJDhLVJyu1wqqmIu+9msR+kZmW/IaDQ/hpoBuP5/JNAwR63/btjEnyR9BZGxgm0NLRhxOa6J6GQNb/TolXIBN0ZXGt3kiBfiQ9eKD5sjInhB/UQsAsvWxm5tn+5T3nQnynwNX/KHhsCnk4buth3/Xswanc/8vPr2g7WliY1iGtR7aU5Ps06Lg3vpbYHgSQn+9Z89TXGQbpKrU6Gsd+2p2klYL63z6C2scrulj66F84Q+JhayieJduzOSFIy3pWDAiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 09:06:28 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%4]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 09:06:28 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 0/8] thermal: intel: intel_pch: Code simplification and
 cleanups
Thread-Topic: [PATCH v1 0/8] thermal: intel: intel_pch: Code simplification
 and cleanups
Thread-Index: AQHZNN4k7uIHoJI5tU+cNG//rpyh2K65zzAA
Date:   Wed, 1 Feb 2023 09:06:27 +0000
Message-ID: <e5493acd05ddffd8bf60942bd595421eb236c5d3.camel@intel.com>
References: <1751684.VLH7GnMWUR@kreacher>
In-Reply-To: <1751684.VLH7GnMWUR@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB8098:EE_
x-ms-office365-filtering-correlation-id: 75d2d584-c66a-4b65-447c-08db04339a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0UA7tHmzi5f2edR9rFkXO0aZHNVWs/+0MubODQMpj91YA3a7TIdtYR8FmVFuljgYJnC9elWWk0mp0Zt9bqrvqI+EWDPEMa9AeR9z3Iy504LKU28Fh55POplRkE5fexQlW/T63DIrZ6UuYRAsHOs/Hb89FZxKbeu4p/r0hD3fikuQDZtfr+OD3UKRxYXoWLxUfoXr4DYiwmKoBywOCw6iuy7hx3Xor4pJc4jhF68gHCJ2rDpjhWdeFSQao4yQRG3Z8Z2R4ecEl/rh9s60VhsGH84amgQdKyXxmWZ23/3BCF1BUg5pThATAMqhs5QPNzxmmS821Q56GO1lrCxMVBbU4/wJYAmvcjSaILZUdv91lYfh6y28270tKSF6MV8vplo9qVkzcSzhHM3nYveq+IwkUBYD5hnrVH7BF95QQnQ6VaSHFljbDx5EWIkY2CF5LU216isvcECGKwNg+RJhgw/Dbx7vok+DquLYNEWEcDbA34xLzG7Dkqy1mOmJ2rz/ZesbN+aKauvT8tDOEGvt4EkdNA4gkGpbBF8g/+z/L25/AaVrtSR3j3sPmdNy/8F8ETVX3wAgP3hfCBXA8cabycS8ml99g8I+Haj7Je/mbR73MijXwULNS8hzyFPTZ6VRyG30ku7GSLM6GjT/VYCIpLG3lSgOBEaKzD5uRs6/2K8J/zWtDsOCOkjPeuy2RoASlZlBa5I90r8gugb1sbHAMAfWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(71200400001)(2616005)(54906003)(316002)(110136005)(36756003)(2906002)(38100700002)(82960400001)(122000001)(6506007)(91956017)(66476007)(66556008)(66946007)(76116006)(6486002)(186003)(26005)(6512007)(478600001)(86362001)(41300700001)(38070700005)(8676002)(64756008)(66446008)(4326008)(8936002)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjhCTDl1dUhhNDA2NHVCd3hlNHVWdkF6djUxaDJtSWxPVnYvUXRwUFgxTWlo?=
 =?utf-8?B?UHNvd25hSTVKY0JvVXc5NVU5VE1hNVpxWFk4Myt1WUxLbnYvVXB4NndIQkNQ?=
 =?utf-8?B?K0toUEtLNGROT3NOS0tMS2lWc0hNTmZ6VWNNUG0zVUZHNzJ3R0V4clI3cWJm?=
 =?utf-8?B?NEttTml2UzVsSHNFOStwQmpOU1dwenlsZUlsWjB0OUtjdThQWjJVYkwrUkc4?=
 =?utf-8?B?TDI2U0RqTVRydkZTS3pQcWNsaGRBNGlPbFNMamJmSXNQTGNYcG5XMXBhUXh2?=
 =?utf-8?B?TXAwT21Rd01rK3c5MW8wUlNsN0Jvb29DT3BzVzRUWlFIQkdmcVBJZUl4Y3hp?=
 =?utf-8?B?YmY5aHRNRWU4U29adWZGbkllZGl3a3drb0ZhclNzS21xYmhkeWMwbnc4c0dI?=
 =?utf-8?B?aENUaiswaFl5ZnZENTNyRlpNQlpuT3J2dUtTcitMdkNhZGhjbWNQbUNIcEsv?=
 =?utf-8?B?ZE9XUXV5QVU5ZkpkN0diYXFUOTZ4MXkvQnMxL0RDRUxwTXpwaUx0dGpPa3g3?=
 =?utf-8?B?Vm5haWJxaXdTVGlPYlgrUTFhQlZwR09vWlN6OFFId2lRVDYxZDRVM3dibmlE?=
 =?utf-8?B?N0cvdnVHU2g4R2xDSVhNRVRtZkthYlJMTnVrNEpLVndlbGdUeUJGMXRTVzJz?=
 =?utf-8?B?Vnoxc2w1eVVvRnJmUVBjZkFjVWRISnlRZ0l5SjhIc1d2Z2JJT3c3VjNHUG5J?=
 =?utf-8?B?V1JWQW1Ec003ekNPTjVDaGhzeW5FVW9jZU9wVjB0SkJlMmp2d1JhVnRXL2c5?=
 =?utf-8?B?TzRzNjR3QlFUaDVTU0M1OFhONUVyb3RkZmZGOU8zOTFtdkZMdVBNMWNjM3Bj?=
 =?utf-8?B?RnpIeURrQ1J5d1MxbUQ1MHRCUHZxdEFhWWJ2bUhzMG15ZmM3a0dpNElHejFK?=
 =?utf-8?B?eEo4YjRQUXZMSCt0UENTbjZMV1VZWXhQSEI5VVN4aDJwaG9kTEkvZzFhb3NE?=
 =?utf-8?B?SXRjeUx5cnQ3RzBmdHNBQnZLeW43ZzlvSE5wSWRQVG4vcmovdjR5aGptbU1L?=
 =?utf-8?B?dC9xQlVxQUFReHovcUMxcnl0cUZGOWZ3YUhwQk4vdEFhUVlQRDFNd3JCeFpo?=
 =?utf-8?B?eVZYcmhGTkxKWXc0T250aXhaVFhsaDNqR29vK1pqZ0xST0ZtOHhzWjZXMTBQ?=
 =?utf-8?B?OURPOWo4TmlOaGxMRHVkL0tDNzFuUlZ1T28vR3l4cVgvR1FTNE5pVVFESUJy?=
 =?utf-8?B?VE8zc2NpaFRkQ2lkN1FkUmlSOW0yVDFJaXJhbVl5VVk3bThaMzRrYVdsK21v?=
 =?utf-8?B?NzloNGhGRFZXTnI4MUMrMksxZFEwYlBmdnM4UjZJems3RzR3d09hUkJ1L2pP?=
 =?utf-8?B?eTRCazhvRWg2a0tIUnBZV3BjaVVySmszenRxeWwyRjk4dTFpcDh4anN1d01Q?=
 =?utf-8?B?OHRaZWI1YnFHY2wrTmRFZGliZW1rY1pnV1NGbnZwTVZ0ZkZ1TDFha2ljRENR?=
 =?utf-8?B?OWVHaDV1T21BdzZpS08rYTNCOE44a0FuRWJlb0UrNEUyYVVEZkt5UXFieUdN?=
 =?utf-8?B?MTdBdDBRSkM2ZnpWWEhiOVNuSUpwaTlGMk5oN25qQmd3Z2Fzdk94aG9aWWNO?=
 =?utf-8?B?ZC93SXJFYW0yaHdiTUlFd3BSUmVyYm8yUzUzWEI0KzV3YzBQSHJqWk1reUZp?=
 =?utf-8?B?d3JESFlYdjk3Nkx0aXJoVDcwbXhMLzFpaEhPVjlsNW4xbGIyMjNqcHZrc3BE?=
 =?utf-8?B?T1E2akZhWDNycmVxTUJTbVpTSzVkTEluMXUzWlJYSCtSV1dzR2dkNnh4TTN5?=
 =?utf-8?B?SGh6UGk1VzFCMlVodkxKMWhxbVUydzV3NjV1ZEUrZFVXZm5rc05XZW1MQWJt?=
 =?utf-8?B?ekVyT0NiMkhkZjFGNmczNEs1NGttc3BwZTBZUkRKZnNKQjRXZ2NPNkZrUDEz?=
 =?utf-8?B?eDdJY2g3bHZISDNMdndpYlNucTg1bjhLK0Jmb3ZXb05SS2ovODFadUNkNTVn?=
 =?utf-8?B?MnRudGJZckJwZVdGc3d5ejZQU0lweHpnRXlQYU9HVm1YY21DMTVqOG81VWlT?=
 =?utf-8?B?eWY2ckV5S3l2eUQ2dGN6R3NjdDNrNGVncTVSUjYydll3R08vT25SamgydlJJ?=
 =?utf-8?B?SXdlZExCTG5md1QrTXB1YTB5WkIxeGV0RHZaZFhsYVhUOUVkK2l1OERWclpz?=
 =?utf-8?B?V1gyT2JNZjBQMDNsOHY0WitkTXJHZGlnSDNlQW0vNHIyUXFXa2NoVktxRGpa?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41B384D08542045BE68B6C6D242DB45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2d584-c66a-4b65-447c-08db04339a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 09:06:27.8106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYk7Bs70Q4HLfWc5m279IRX6mCLBqu+1uKraRw1JqW8VTiM1mR0R+9/fwPIDpzSGPhy5SXaJfmdMIkSPpMBQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDE5OjU2ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gSGkgQWxsLA0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgcmVtb3ZlcyBzb21lIHVuZWVk
ZWQgY29kZSBhbmQgZGF0YSBzdHJ1Y3R1cmVzIGZyb20NCj4gdGhlDQo+IGludGVsX3BjaF90aGVy
bWFsIGRyaXZlciwgcmVhcnJhbmdlcyBpdCBhbmQgZG9lcyBzb21lIGFzc29ydGVkIG1pbm9yDQo+
IGNsZWFudXBzDQo+IChubyBjaGFuZ2UgaW4gYmVoYXZpb3Igc2hvdWxkIHJlc3VsdCBmcm9tIGl0
KS4NCj4gDQo+IFBsZWFzZSByZWZlciB0byB0aGUgaW5kaXZpZHVhbCBwYXRjaCBjaGFuZ2Vsb2dz
IGZvciBkZXRhaWxzLg0KPiANCj4gVGhhbmtzIQ0KPiANClRlc3RlZCBvbiBvbmUgS0JMLVIgcGxh
dGZvcm0sIGV2ZXJ5dGhpbmcgd29ya3MgZmluZS4NCg0KVGVzdGVkLWJ5OiBaaGFuZyBSdWkgPHJ1
aS56aGFuZ0BpbnRlbC5jb20+DQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50
ZWwuY29tPg0KDQp0aGFua3MsDQpydWkNCg==
