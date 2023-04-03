Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7B6D4093
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjDCJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjDCJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:28:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C25010FA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680514087; x=1712050087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m6wlvKdgGoH1K7beoLK+kypZAzw6GX/HZoZpMMG1lG8=;
  b=hEKZ0mtB0DjpcO4n6i4ZxsFrvc4oJfkFRo4reaaHgmHUWsdr+3zxHa5r
   Suv0Nu9cSHZbXSXXpbzehuoxBW27MGqDX5aM8K4OTzsIqwS1dKqxbrXXR
   D79555ogCTmVJLpHzygxRoM10oD7GaJXbqrV2/Qg9VGWbgEUPFsnr9K9p
   JUUQNJUjYRdpqAKCPm8u9CMf+YkYgrQ3hGg1yBoK1dHUSyzE6xjUI6+aV
   7WKwzvWUQCRnQq/nSsAzmBOhXnTKVi75JmZZoZvvTcn2NZaPigB93DbgQ
   EBIhRJOfWOlpZEzcfrFKa8hxpcnPAyOLEo98o11OrAUzUt2joahKoj4gy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="341877906"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="341877906"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 02:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="1015638694"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="1015638694"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2023 02:27:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 02:27:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 02:27:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 02:27:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 02:27:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z40CPlqLrlCEGHaru/IHnxJtirv22vQmKj7/GARD1k0QCADqqvlN2FIzhVTxdzGDgxQW3bewiaQvguAl4WlOqn5TEzzTkrL8cMc0IHTlxTJWf+MRzzWD4UT+5Wsea+hbCUpnPpVxs0duFWpbk9HQb/161LAZoi8f7T23fdeSDETt6XqKmpvF4arN23BR45fyVmuyJT7RXRoJbvo77mcHv5BzdKlbg8GtwWjQCnMjJM7Ke636Ro4TJGLdLLFQ/aD4D06/nC8/fRcQfvn0fP2g0I5/UgwEi0wweaBB3BxFNdcZGAn8W/0GzI6MTaGhv01lhU53qfr+On7MoRPBjBSmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6wlvKdgGoH1K7beoLK+kypZAzw6GX/HZoZpMMG1lG8=;
 b=PJ4XNOY4nY2PKfjzPIhzHv0gY+3zisWDFKoX3GivxiA2FoiJVbK7y5NZ1CUWeZ4EvSphxreH0M6FCIDOXcrIuAx9aei6MaBq1hTVXFwbK8QeGg/MhViN91P+jcuyfZBZ9l8T3Hjn3aWUPIGHPK7gcSq7ILB2mB8zO8XsNJNcE5fIkMhchREcHjGark/OYBiAoJIMDqeOkIaEW5kqGWpTBPDF71lQVS/PLieu6uEN5FHIjMp6+3T8ErpHE7qPUyAzmnWXkLHfFY98aO9kN69cm/8Nr7WsJQf6Q37Tr7PZ5lSav3kqo8VGEcXH277cWYuxXm6CWP4PyHpsz13ykyDRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6265.namprd11.prod.outlook.com (2603:10b6:208:3e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:27:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:27:52 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Topic: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Index: AQHZZGR61ijUNf30fEKIHhN53WCdS68Y3l2AgABPgQCAACZ1gA==
Date:   Mon, 3 Apr 2023 09:27:52 +0000
Message-ID: <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>
References: <20230401063652.23522-1-jgross@suse.com>
         <20230401063652.23522-5-jgross@suse.com>
         <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
         <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
In-Reply-To: <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB6265:EE_
x-ms-office365-filtering-correlation-id: f4edc46d-1fed-494b-3d1b-08db3425b2da
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iAK2c/tQiUNLAk4m/D0NPLMD0NGrv/gavOqDBjsobcUQ2adlzhWkiIJPd8xNJzVvKmOF1fzia+15i13bEnl7aGkyBsGtxF7j8vayFl6eI7DuvIiDNymBmsgw6DEZVmL+1Dntkwccxot1BhXbjbrf0TvAFUn8i4DqehbGp8KQeA2T23Lbyz3Uuw7sGiNR1c8TBvPcQPdS0vjvqAfBXD8xsVh2sTTDVfzzXeuheUFuzU+ALsEw65TMAo3FgyN+wF8/Fu696cxdE88pi9a1N06524iFV3ViLJj8bx1xUT/U0Pwe0iAkzHicmKawRB67N21krfD4Y7SIloZrF8yRi4JJ07ogvcCY/uKWPqNnBbWse8Bti+GbDPCyhwxGbziSTsp1Z2xWfPVbf7S0r0xDwgR7FsqLqVEJGVz4Vv8R4qGHyL6jRfYneNeKV4dbvU23sBz9H58gB70caAOV3urEOvk5CAn7R7CQykH3MY6DhwvFatx6AflFIApBFmsEnujRA2YaKhjdnugp8Da96Fq77NRcNTV2L7MoSJeBVMF8jxAHZEHWOqPu6JPQisfN0dJ9w/sCBauVRUypRXVxS72Jm927lJa8TyKKVEgLaZ+sAP4BCjAGoeUgicaZ1vBvAxaITFb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(86362001)(38070700005)(36756003)(2906002)(2616005)(6486002)(71200400001)(186003)(6512007)(6506007)(26005)(4326008)(91956017)(64756008)(478600001)(76116006)(8676002)(66946007)(66556008)(66476007)(66446008)(122000001)(41300700001)(82960400001)(5660300002)(38100700002)(110136005)(316002)(54906003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGxJZjQxakVlYlpBTUZ2ekUxbzFlYVdRQlR1S28rTTlJM3pycjVOMjdTL1pv?=
 =?utf-8?B?Y0g5MGZBR3Bad1pNclY2LzJkN29tQkFpSlFpV0hGcC9uczhUbDBsK2JpemFz?=
 =?utf-8?B?L1hLQitWRXBheGNTTHRycDA1YytRUm0yVml5SFBQd2RiU1JYOVJyWU1zdlJj?=
 =?utf-8?B?dlhSRDJWalBlZC93SThObUJUc3B4YkU0MWtKVWcwWWVUK3VNNTVBeFdBQ21M?=
 =?utf-8?B?MExmUEs5OEhFNFR3TDY4K3liRzJVRkRZQ1ZDOHVmUUw3M01UVUkzQ2pjbVk3?=
 =?utf-8?B?VGdxV1Z0aVg1UU9jRlROUUFSY0dMWGZUekZvcFk0M2hQTnFvemI1NWxFOUxj?=
 =?utf-8?B?eUhHcHpkNjBqNGZOY3RpT1J1T3hCSmxrVkZKcHgxMDJ2WnVKUjN5RVB1S0NQ?=
 =?utf-8?B?ckRJUTlVbVp3VzRIT0ovTm45NUNjU2tzNGxKUjI4YUJMdmgxT0xzQVpKUVhk?=
 =?utf-8?B?QTQrWFQxK3N3MW8yaEt5aHcvMENlWjhlY1lhYkZyQkMwWE82dDRSMDlQSnE0?=
 =?utf-8?B?QWNBeG52ZWRoMG1pYnZjZHl5clhxVWF0OHZuVTdZdVZETGNtQ2Nic21VdlR4?=
 =?utf-8?B?YVV3UThYZmZQNXcyR1l1OXZSV0N1aDNOVTU2M1J3QzV5dTlSODBINStBbWlJ?=
 =?utf-8?B?VUh3ZkNlNEY3dmVqS3VheThxbjE5bVBROHRZZEZaUllnQzR2WVVhNlZ5Y1BE?=
 =?utf-8?B?Wm5KaHp5eXM3WGM4OWYwb2ZKaVI3Rm9UeEVGZUwxeHo0aE56N2gvNEtUWGVY?=
 =?utf-8?B?dlk4WHJId1VldEpyYmVyelpWZ21JNE5NRVJWaUxCNnFHcGQvUVRaUnMrTmZU?=
 =?utf-8?B?TXJjZktVOURHQjZDOS81VXo1SDdsUTlNdnBUNDgyQU8zVGdqSmowdEdRd0N0?=
 =?utf-8?B?RzZodnRpTENKaGdKUTViS2pDV3RJVURnbDVGSHBLNE5CNVBFanFnZktZOHIr?=
 =?utf-8?B?RU5RYXVXcWJndk1WbWpRWnVJY1JxamxyMlZyYVk1cnhFQkVmYng4ZGRmeUFu?=
 =?utf-8?B?Uk1EWE92WWwwbVhmOVRSOS9OQWVTcVpBbEFhakR2RDZpR3BOaTkyZkZkV3NO?=
 =?utf-8?B?cTZQd3gwdkZoQVJSOWo0bEw2NmpjSDFiUGNBNTdVSVVKRHR2Yi8xdkwrek9j?=
 =?utf-8?B?dEpOcmpKR2Mvajh2ZkljUW1JbFMzdHU5TVErSktUNkl2RDMrdXpHczV3TCtI?=
 =?utf-8?B?cTU0THAzSmpPQmRrNkZUK0NhTG5DaDhlSUFmODFBRmRraW1mV3NyanRNYVJE?=
 =?utf-8?B?UGNTQk9nalltRnJKVmVla0o5elo5QU41MlRvVHI2MzJNbS96Wnlna3g1UmJR?=
 =?utf-8?B?VStrVzJzbktDcGZjOU8wejNyVHlWRzZQaksxVXRBTFRJVHhacW5RVERNOVZu?=
 =?utf-8?B?TGRSdEtMMllYS1VWZWdrRjI1RXhROExMME41bzZGZUhaYWR5WVFFWTBHT3Bz?=
 =?utf-8?B?SmFYMWJBYkk4WHZzYmJLaEpvTmJtWXB2QXRsVmJ3eWxiZGdERWl3Mk9IODZx?=
 =?utf-8?B?RmZXN01USytwM3JCTXZFcFRnQS9Bb2poYUtidHN4V0lLaE9DYmFrdHgvQXZt?=
 =?utf-8?B?V2cxNGpkdFpsUTlDRVFtc3VSWnRkMmQxVmxMdVFxSUlUeDBYSkxGdmtSYk03?=
 =?utf-8?B?MnBxYVVIOGZDNXkxNkJ0K21WMnhZczVseStYNVlVVWJybVA4cUt4OXMyb1Vq?=
 =?utf-8?B?WW1Oc0EvNjVoUkV3WUNzb0gzQ25ESENPTDlUKzMvYlN6YU05b3BLUnJrYVdW?=
 =?utf-8?B?dGdIZjhwVHJNajd4eGJDTzlvL1VMUE9tYkVUWjNrN2kwVmFnRFcvQXBPTjJs?=
 =?utf-8?B?SzJwNTJ2OXpPUkZ0YWgyejhndkU3cXBuUXNqSmd3TmkwMUJFZXpyMHNVbW9Q?=
 =?utf-8?B?QmN5U2JSMG5PNGJncUhGQ2VHS0kzWmEzMklteW1VSGJtTVJubHMzUzg5WW9p?=
 =?utf-8?B?MjdSY3dmSWtXdmZwYmVqeGVTL2l1TGhjWkRkQmpxZEQ2ZDZTWG1xUGtGcnlj?=
 =?utf-8?B?Y0JteTRLSXJnNENncEdaVExldGN4K1Jta1VhOHN0RjJBSlJPZjM4dGZFOUhN?=
 =?utf-8?B?eHNYcmdWaVBjdFhQbWNZaHJTd3lJRVd0bWkrNVlrQXFXL2oveFV1bHhpNnFw?=
 =?utf-8?Q?5BvlGeamd8l9Ye3gXVar9A3GB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25FA2B2187800F4EBF797EFF3A3D651F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4edc46d-1fed-494b-3d1b-08db3425b2da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:27:52.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1vtCWUh+lY8OMEetwNIvr01Dymh5Im7sbHSssLBFYjOdX6zvYjIjAEX6Am8J9kiYsbCTudW6hS1HD/HtQoyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPiAgwqAvKioNCj4gPiA+ICDCoCAqIG10cnJfdHlwZV9sb29rdXAgLSBsb29rIHVwIG1l
bW9yeSB0eXBlIGluIE1UUlINCj4gPiA+ICDCoCAqDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJy
LmMNCj4gPiA+IGluZGV4IDFiZWIzOGY3YTdhMy4uMWMxOWQ2N2RkYWIzIDEwMDY0NA0KPiA+ID4g
LS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiA+ID4gKysrIGIvYXJjaC94
ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiA+ID4gQEAgLTY2Niw2ICs2NjYsMTUgQEAgdm9p
ZCBfX2luaXQgbXRycl9icF9pbml0KHZvaWQpDQo+ID4gPiAgwqAJY29uc3QgY2hhciAqd2h5ID0g
Iihub3QgYXZhaWxhYmxlKSI7DQo+ID4gPiAgwqAJdW5zaWduZWQgaW50IHBoeXNfYWRkcjsNCj4g
PiA+ICAgDQo+ID4gPiArCWlmICghZ2VuZXJpY19tdHJycyAmJiBtdHJyX3N0YXRlLmVuYWJsZWQp
IHsNCj4gPiA+ICsJCS8qIFNvZnR3YXJlIG92ZXJ3cml0ZSBvZiBNVFJSIHN0YXRlLCBvbmx5IGZv
ciBnZW5lcmljIGNhc2UuICovDQo+ID4gCQkJCQkJCSAgICAgIF4NCj4gPiAJCQkJCQkJICAgICAg
IWdlbmVyaWMgY2FzZT8NCj4gDQo+IE5vLiBUaGlzIHRlc3QganVzdCB2ZXJpZmllcyB0aGF0IHRo
ZSAodmlzaWJsZSkgTVRSUiBmZWF0dXJlIGlzIHN3aXRjaGVkIG9mZiwNCj4gYXMgdGhlcmUgYXJl
IG5vIHdheXMgdG8gbW9kaWZ5IGFueSBNVFJSIHJlZ2lzdGVycyBpbiB0aGUgb3ZlcndyaXRlIGNh
c2UuDQo+IA0KPiBJIGNhbiBtYWtlIHRoaXMgbW9yZSBvYnZpb3VzIGluIGEgY29tbWVudC4NCg0K
U2hvdWxkIHRoZSBjb21tZW50IHNheSBzb21ldGhpbmcgbGlrZSAoYmVjYXVzZSBpdCBhcHBsaWVz
IHRvIHRoZSBjb2RlIGluc2lkZSB0aGUNCmNoZWNrKToNCg0KDQoJSWYgd2UgaGF2ZSBhIHN0YXRp
YyAoc3ludGhldGljKSBNVFJSIGFscmVhZHkgZXN0YWJsaXNoZWQgZm9yIHNwZWNpYWzCoA0KCVZN
cywgd2Ugc3RpbGwgbmVlZCB0byBjYWxjdWxhdGUgdGhlIHBoeXNpY2FsIGFkZHJlc3MgYml0cyB1
c2luZw0KZ2VuZXJpY8KgDQoJd2F5LCBiZWNhdXNlIHRoZSBoYXJkd2FyZSB0byBydW4gdGhvc2Ug
c3BlY2lhbCBWTXMgaW5kZWVkIGhhc8KgTVRSUi4NCg0KVGhhdCBleHBsYWlucyB3aHkgJ3RydWUn
IGlzIHBhc3NlZCB0byBtdHJyX2NhbGNfcGh5c2JpdHMoKS4NCg0KPw0KDQo+IA0KPiANCj4gSnVl
cmdlbg0KDQo=
