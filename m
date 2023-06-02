Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE37208B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjFBSBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjFBSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:01:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22931123;
        Fri,  2 Jun 2023 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685728905; x=1717264905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DSt8JiRzhM282qyXPuIpVKV5gSOOd5JF+bSeVdfLnvQ=;
  b=WM5Rz7o4qm27oboP/twOb1uGiu86mWNHsV0zgdjTDcC0+Q4MFQJ956EM
   75pe+nrfSWV/ZM1zNYBXUKBT3xlrOZ94rN/qkukz3TsFP0Gy4GdZ22CPN
   ZyZQbRxe1/KHDbCCIIinC2L1NI/APNHm/nE+bHlfM/DmpCm59EZ2+vkCp
   iWdwzb940Mbjqz+0C+2rK4ztle49y+Nm93x/qpdVd5kIq8A6iqJDhD9Nr
   wAkxqZrRTFcxtjE/Z/6LaiQdi+u1h5aRbJ9WAEfKB/t6ddUr1y0gTwUzS
   R38wut+em33KOrrCgniWPcnFHUglI79klhALPt+BIGFiQuP3ROmhUVFgw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="419463295"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="419463295"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852237357"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="852237357"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2023 11:01:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 11:01:43 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 11:01:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 11:01:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 11:01:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCI57aHJSiCDB/vXA/F7XN+6OodUdaocX0k3UqWX2QOFqfoYK7qztmpDs7mZ+yOHqqLDKPG8ETjGmAiLAW1YMkJrWUx/5EJ2fTY3eX1ZP4O4A8KL+gfqGYx6TRmGgxEb27qmfBM+SpI5wNvtG8hAwxsO+58GcWZknBLyj4qUyAWwfPqrMlRXKUucquqDnxQPc4d+JPVzOkQ5IqfMiGiydTNwv6DdvQkaB8WMz6xhEjBsk4fT0vzeLuFRKIAS/ktWKNTdXzzGb45PDfJYbIAXVunN/Gpksq0nqzPb5ejKZ5H5mISs9LfsnBVIBqxLxuFW5hPa8ZjNd4S4+Dt1G6lB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSt8JiRzhM282qyXPuIpVKV5gSOOd5JF+bSeVdfLnvQ=;
 b=dH4uAv2iNZ2qHGrzsfQEj5BBO/EFkUbTtL+FCdq/tnH6kO558IpVz7quo2VnUbBg0xlzeV2nVH836EiWebPiy/pJwJGajhQfq3x8x5Z50Ul2jOUExy9Xc8oreQPj/xKUFn6yo6QKE7n3SQK4/XUXN8AEW9yJhmAWD6TMOaL6mN9dXK9wT5sHAhIiTC4H6EL68sHsuY1MLclTDllR6Auk2Ff0NRAIzYt3lFSpQ8mqp6kytJ96jNHJmZFl8QRYLiKOJ9yEjaif8e5yetvtnB489d1Ve75PFbyC4NXEfacoWFxBxIxv1yhrNez4nkI2hFJ2A1fh/TPHoE7soRCEKn7Jtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 18:01:40 +0000
Received: from SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb]) by SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 18:01:39 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
Thread-Topic: [PATCH 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
Thread-Index: AQHZdMfgUNW1V/zfakG1muI2iugnma9VXtIAgCKwKQA=
Date:   Fri, 2 Jun 2023 18:01:39 +0000
Message-ID: <1dd1ca81905f865f69ac2fbfbc778e7fb76c8ee3.camel@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
         <20230421-vv-fw_update-v1-4-22468747d72f@intel.com>
         <20230511171816.0000303f@Huawei.com>
In-Reply-To: <20230511171816.0000303f@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7109:EE_|PH7PR11MB5984:EE_
x-ms-office365-filtering-correlation-id: 5ee6fde3-6a74-4f6d-fa26-08db63936a3a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YmtFRL4GhmwJuaZ9MRSttXW3YbJq49RBTRcOSE1qGltkl2oFLMR100jATOjWur96jLcY+j61FiGZVMkFZ1vvgp104b41yts4/Rfqknwuoe45fgWPvOqHaLAsdnkK0xyF/DLal8A72u8La6FpNkcyi4xS4tBU4N3qLRWla9Ve+1byRQAT/Z2ixwvegHszNxWk7v9JKf67IWf3s6GTrjDgxxwaO5w581YHanG9D71OJeo2RH3ZnfN27qte/8O6vb2ShihZjwOqSszy7UpW6ml/nBbcAJ6idk9SyRF2UwiNSi29mr3GcvyHw+y/HVJAkMSdfdor7osNYFDPUz71ODF//KWUYydE6tZxzdyseCbJlaMjIKfoOsTtM/raZKaUJMIIQ0cKkAGUV0S+HHfU2INKJUjiXGFx2MLbtyNtmd0M3asbjH+k9ueMG6LB3m6O/4w551GXn6IDircgGCzlF0Q7qPrq59s4rGEk2EgWn8FWn9wvbsemVXqRk8avgDDojzKpX8LB3xPV4Umtjgm/BE38/hoWG2QRg1qoEWPwRTT/fk8I0V6maVZPgrOzYfNjjb+m4/vsPx4JS5YfWZ0XlShV80SXMyibd9ao+Bzo3lOXqbiMMNVz4cNElZOZ1ILG0DgC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(86362001)(316002)(71200400001)(76116006)(36756003)(66556008)(5660300002)(66946007)(64756008)(91956017)(6916009)(38070700005)(4326008)(82960400001)(8936002)(8676002)(122000001)(41300700001)(66446008)(6486002)(38100700002)(66476007)(26005)(6506007)(186003)(4744005)(2616005)(6512007)(54906003)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJWTEM2NEpwSmJ4OE5HcEhTMnRiekI3TFRxZGtMYnZSRG1DMTNnQmI1dXBB?=
 =?utf-8?B?bmw0MzlzKzljZE54QjExbmlIcUgwdUptSzkrRnFUc1BDUTEyQ1U5OVF4VHBm?=
 =?utf-8?B?NWd3U2NDNEV5V0RDVzRoVENNOStsM2pEdHhLZldLUEVXRmNndWRFcWNvWjJ0?=
 =?utf-8?B?SmJjUVhFSWlWVDVBVFJLVUZ4VzFNU25TU2V6TzMzeE9KakxuVGg2WHQ3eFla?=
 =?utf-8?B?UHVnMjFEV1p0QzUzUmhTc1ozaXpZTGFoTnBtTVBpR3VoUHRacjlNZWtpR2Nn?=
 =?utf-8?B?OUpIYWl0eE1NdzJ2dVRUcjVNNmFseEZQcTY3K1ZBajhwR0NmWCtoUy8rM2ph?=
 =?utf-8?B?Z0pUTUFwV0R6bjc0QVlRRUhrdFBzajN0cXlHTG00TjdlRXYvV3FKeWpnRHUr?=
 =?utf-8?B?cVY5blZETXpkZ056NmRzVUszRWNmc0xRUjlnakFCZWttV3Y3Rjg0dGRMSUdl?=
 =?utf-8?B?MEJ5K2VER2JmWFhodzRycyt4cTQvaThrQmRpa3hjNmgzYkg0L2NNV2lqU1Bs?=
 =?utf-8?B?YWtKQTYxaVUrMnpzTjdCUjV0dXk4RVA3MFM2V3NKazBTQkJBNW5FVUU0OUJ2?=
 =?utf-8?B?SnlSUllHb1hDV2gzYi9ZbW90aHl0TDQzR1o2c0tjZEhJSEZZQm9ISWl6L2c4?=
 =?utf-8?B?Z2Q2QzNiMFE5ZXlMMmhkZGd6WTdkU0JqT09TWTdaL1JuMWtES3ZqU3pWZ1hE?=
 =?utf-8?B?QTYwdktPUFhOR1d6RUVTVnVYNFMzTHVnYUhiM3JoUVQ5bTk1ajZkN2I0TGFG?=
 =?utf-8?B?TkR0dmZxUERaM2p3eEdXcUc3SkxxY25YRk9yS2ljVUVmVzJkSzRGUFhYOXht?=
 =?utf-8?B?UktLc3JxRXRmNTRmenozRGZoRUl1UG02ZWEzdFBZR1JNdDIreE51NFh3cFA1?=
 =?utf-8?B?NFFSVmZ2bTN4K0RPWjJCRzF4ZnIxMzBGWUxqdXFIKzVVTk9UNEJCWDc2T1Bm?=
 =?utf-8?B?WUZUTU1EcWRrYkZCRXpaVGtldWNmUzU5QzdKZ3dBSUh2a1dFV2VzdTltMjNK?=
 =?utf-8?B?b0pYS0p3SDlVbEYvZGcrRHA0NlNibElVT1VJZkdzUlVROGhPNHdqVE1GaWZ0?=
 =?utf-8?B?dERPV3FpdkU2U05KRmdoNk5xTVlZeU1wS3V2WXMrY29Pam4vcG9zOFRjM29V?=
 =?utf-8?B?YldpWjhRREcyeENYdUcvSkt4NWdIVWdoMVZWWWg3NEZ5MDlWQXZYQ2xxNzQ5?=
 =?utf-8?B?cDBsMW9BSndIQWk5TjNhWTk3eWlhcmkvOFZkdXBWVG5nQTRqcGZrekt4VDg5?=
 =?utf-8?B?WXpDbWdIMGFta3ZNaUhjM1Rjak52b3pNZ2hsWHhmV0xuL0wreGk0QmFRYldo?=
 =?utf-8?B?MkdlYitYd2tKcjVtQXZuOXBSc2FqRmxyT05nOTJySzVSNThKd2h5YkdodDVN?=
 =?utf-8?B?dm54ZnR1MWNINzBmSDhmK0lsTUJXdHVuakpadmdMUnpqWVJkL053a1I3OEIw?=
 =?utf-8?B?OG91dC8rcnNXa2dKamtkWW55NlU1a3pGNTRETEMwSGdCeFB4ZG5IWE5lZU5m?=
 =?utf-8?B?VnBVVU9IdVdlWlBuWi9uSEt5bU8wK0JIbDJRMzNSakZyNkJGM3g5VkJPZk0w?=
 =?utf-8?B?b0NDOE9sNnFzNjJaMEx4aFdpMGVySFVYNGRUTEkxZlN1ZDJ0UWVMMDd6ZkVR?=
 =?utf-8?B?a3RmUU4vNUZ2ci9OdjRjRWtCaklvTmlQMEt6T1QyWDg5TkdIeU1Zdm1wT1NK?=
 =?utf-8?B?aFdCbERnSWFpU2VrMitxeUtoTisvMEF5ZzZkZFViTHNhcDV6Z0ZCSXMvSVFy?=
 =?utf-8?B?YmZFdzVRQlBNWWJIRFFaNzl3TVBlNk5kVzFhYjUzTWs4VWtscmduQ2pnTFh2?=
 =?utf-8?B?OXFCTmJSNWExRUZhbE02VkhuemwwT08zUE1qdFYyazVuRGhGYm52VEZ4SXdO?=
 =?utf-8?B?RTljY25CTDNQcmZJRlBKUXdYdVVGbkh0Nk1TTFNNSmFJNzAwWVRQLzJmMjIw?=
 =?utf-8?B?NWJqYUVDL2ViWFFSZkh1RlVXOHE0T3VkUkhvMTZjTk94a3d3QnZpZTZmSnYv?=
 =?utf-8?B?d2dwSnk5czN3Z0ErcDZncEtTMHFOZEdBdUozcUZvY1pPZ2VtdithR3dRQzJE?=
 =?utf-8?B?UHZsTmMrRjRFN2ZhemJ6QVp5WXhJKzY3WjlFaG51QVBUelRwL1VvOGJhSlI3?=
 =?utf-8?B?a2JUTDJOdXM0eWU3bGZqaWZMMzdydG9CZDRJY0kzNlJSYVZkK1lWcGxLeVN4?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC8C782AEAAFED439D820C8842F501D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee6fde3-6a74-4f6d-fa26-08db63936a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 18:01:39.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8u9I/eAB94vyyWHzbz1lWR6VZ/fweq+sWhmTHTgkWVdLE0/LMUxvXmwGNh7UtCrKweQ0rlYl3VTFum0lvDI1utg0QP07GUYPGACJ5GzHl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTExIGF0IDE3OjE4ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiANCj4gLi4uDQoNCkFkZHJlc3NlZCBldmVyeXRoaW5nIGVsc2UgZm9yIHYyDQoNCj4gDQo+
ID4gK3N0YXRpYyBpbnQgZG9fc2hhMjU2KHU4ICpkYXRhLCB1bnNpZ25lZCBpbnQgbGVuZ3RoLCB1
OCAqaGFzaCkNCj4gDQo+IENhbid0IHVzZSB0aGUgb25lIGluIGluY2x1ZGUvY3J5cHRvL3NoYTIu
aD/CoCBEb24ndCB0aGluayBhbnlvbmUgcmVhbGx5DQo+IGNhcmVzIGFib3V0IGV4dHJlbWUgcGVy
Zm9ybWFuY2UgaGVyZS4NCj4gDQo+IA0KQWggbmljZSwgSSBoYWRuJ3Qgc2VlbiB0aGF0IGJlZm9y
ZS4gSSB3YXMgc2xpZ2h0bHkgY29uY2VybmVkIGJ5IHRoZQ0KY29tbWVudCB0aGVyZSBzYXlpbmcg
dGhpcyBpcyByZWFsbHkgb25seSBmb3Iga2V4ZWMsIGFuZCB0aGUgb3RoZXINCmludGVyZmFjZXMg
d2VyZSBtb3JlIGRvY3VtZW50L3ByZXZhbGVudC4gQnV0IHVzaW5nIHRoZSBpbnRlcmZhY2VzIGlu
DQppbmNsdWRlL2NyeXB0by9zaGEyLmggbWFkZSB0aGUgY29kZSBhIHdob2xlIGxvdCBlYXNpZXIg
dG8gZm9sbG93IC8NCm1haW50YWluLCBzbyBJJ3ZlIGdvbmUgZm9yd2FyZCB3aXRoIGl0LiBXZSBj
YW4gYWx3YXlzIHN3aXRjaCBiYWNrIGxhdGVyDQppZiBuZWVkIGJlLg0KDQo=
