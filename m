Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED04718BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjEaVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEaVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:25:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33DB3;
        Wed, 31 May 2023 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685568350; x=1717104350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yslbh0erpf82tkRIqq/AXufHyvtHqTIqovogxVyMC9g=;
  b=PAqoRex3hH7mvAZtB3/E+VxKtpO2dZ1W26CNNwijibTnyKmSYSxQ/m8U
   agJbFOyS4QluBvqrQbo00QO4bjWN9LFt9zpZbwY+ag7yokVWeZnGg/n3Y
   qUgGJ6McKn0g0aNwd71bMjQpk9VHRYQWw+G560T3mdq+ZD08gkkIyPDrA
   BYQaHk1N23K+9B8IJ9mk4/HFRE5fgno5TNitHX+uABnDEwiTmiAy1VuTI
   sRTMmIVtIvhEv5XBm7ty9VRPmJWJylghJhZFxf9WK3+PxI2cMvONvNU0p
   y49/N+kOubrIa9c6NeeDiYGeboQuinBlK4aALLiLEuq7HJdSrhU2VRJfU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339964396"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339964396"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 14:25:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="710221054"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="710221054"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 31 May 2023 14:25:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 14:25:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 14:25:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 14:25:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 14:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCQ8qsFwO4DxfxUVZ25XgpE7yjXiAL3gNbx1TlG0olppPZspGef2PZDUirxjb8oiYkgjTTeuF/4BAhaCU+cv/IEigHiVTEjc+GM5eUDD1NXbJ/WT8m2dGGpeFSs3+F4BeEJdLFT9D7FTCyEVvre4ALAbuS99QgO+V6wcckhplAVv5I9hLLlwvR1NNoigIH0q8Et3CUIRGFgTw9tyaWHNRL6rtZCFxNIg28iF/9eOiU9WokgeljUBo/sVhKjJG7I28fNB70UScRIJztBe2WE1phmauTGHpUxXb481acE71FBruSPcC4tCWSCVhnE+mxKL+hrR3dH6hymleyLrXgCU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yslbh0erpf82tkRIqq/AXufHyvtHqTIqovogxVyMC9g=;
 b=N7gsaXDXD1RudLUjiEKcsn2dbxZTiEITJeJ89CfgoibGMwdXDPm8vf8IOv8rj31AaGsRA94OMwjCo9liUj23BsUia3gG9Q+Hd90UqFRUeRAqKouoIFRaniCCty+cxoIk0w2D+GQ0uEZwwuLETla9diNPs6RlsS2GYBD4DyRHhqyUAfMN+GPeQrQrEhuIdFDs7sUcYeOSDuY54Uywv3aGMsoqpEYfX41uDT+QRYuq827QxhNWZK7h5a/gDElZ0Gon+Qr/y012E21XT8A82A2DdBXqquc8+Zn4waD/cNIKYALQHoiNb/rDS9BUerwaHLAnzpb4J3iAGnI0A4ql6S9TPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17)
 by CH3PR11MB7865.namprd11.prod.outlook.com (2603:10b6:610:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 21:25:46 +0000
Received: from SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb]) by SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 21:25:46 +0000
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
Subject: Re: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Thread-Topic: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Thread-Index: AQHZdMfj1+vIA1W97kmyE2uj67BBM69VW4WAgB/H1IA=
Date:   Wed, 31 May 2023 21:25:46 +0000
Message-ID: <1d807ee9ec39317251788b602d129f88bf332b2c.camel@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
         <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
         <20230511170627.00003a49@Huawei.com>
In-Reply-To: <20230511170627.00003a49@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7109:EE_|CH3PR11MB7865:EE_
x-ms-office365-filtering-correlation-id: 2b2e9b69-3753-48d7-a01c-08db621d9923
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuC6XPiB34z4PdvSTcrEIFX3YyyWY5xYJgnycMdXEyYaHfjZvhDbrx1eLO4gX3WbClnA2KAqYsC1OeA7GZIfJQMy8vJW5HpgoCMWVEbkr3YFUVgjV80el9gdDATuT+/tj94xNZM9EqzMf5TVuqq/aNNVpzqdivMYe0vOPzfKlWzmzbXZSgAaRTOgnd2B9YgCjS1eIDyQ64sSlK8bd5108ins59RNnSeIPpKBwkuWpgHnIkOGrJMMXyIssMrKU0uAp6FBcLUASmLze7uJGKagiqi17Ci+qUFa5w+9iPsDTTR5oHJY2drr34N7L8giujplOO3T4PYmF+ScQkKlwj9dAlkspeOWnxrgs5ZlFMaGdRZdVKfINU3VaMqjFJ0u9Ja/ecpuG/fGhMR3uOYAoTt35/IQWMAr08SruG4cZBzE0HCMzjhMgwrYEaUbO6kabI1JVg4xeZuXg4Pb74xbQStmq6gVbCUZl8rbx/JZiGqPViuSDNEha/ZFhYXBZcu0B2DwQnp5dnOVbBOezRxozpv930/NHaeuEZMaIXA4m4ugU9RqF2ON4GGHO3koHfQvdJH9q9HuQb29yYrUnhaiXR5ak50nGHYFDckozjZNYcMhPk9gu+DV69AxRhWUUuTE/QJS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(83380400001)(2906002)(2616005)(186003)(38070700005)(36756003)(82960400001)(122000001)(38100700002)(8676002)(8936002)(66476007)(478600001)(76116006)(66556008)(5660300002)(66946007)(6916009)(91956017)(4326008)(86362001)(64756008)(66446008)(41300700001)(6486002)(6506007)(316002)(6512007)(26005)(71200400001)(15650500001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2p2R2ZJczR4Y3hUOXdwV2lkRm1BUGx0b1hHai9nVG0za1VySi82K2FHc2gy?=
 =?utf-8?B?R0xmcGtXN1VwVkRvZWpldjIzTlBsWk5VY3ZoTHo1SGoxdkY0Z1l0LzJablFQ?=
 =?utf-8?B?NmN5aGFsbWhaTklRbVdIM0VJcE5xWkZhbWt5TkdRWjhJbVRJWjRmVlQyWEVq?=
 =?utf-8?B?VVhJVko2UDhpMDMybnBVOWNhNTIra2JxbGJ5bVlmT21MK3V0SjJTc1BlN0hG?=
 =?utf-8?B?U3h1RHc1SDl4dzZreFVyaEUzeGlsTmo5c1B1aDFaT1k2MVN1dzQyMXRMdDRY?=
 =?utf-8?B?bk9kdDdVYk5OVXZadXVxNnNCd3ZOTHUzVlU5NzVuUWg3RnRuWVBTR1p5SnV2?=
 =?utf-8?B?T0FycE5GRis5ckNldmQxdFF5V1VoM2p3ZnFYYWk1SjJVOTBlR0J1R1c2cnd1?=
 =?utf-8?B?NWJ1N3FHdHZzQ2lmRHBJQXBlbkhKSzA1ZmkxUCtUR2hXRXI0Zjl3TmE0bHgw?=
 =?utf-8?B?TGxZQXBSZ094V2FwVXJKUGxRL3lBVTJ3S3ZOUm4yZEdON2dHbHVqajVnckhP?=
 =?utf-8?B?cUozdnA5LzVSNFRXY2pqRDNEN2hTVlBQdVRKREEveDAvaDk3REpoRG9YMHh5?=
 =?utf-8?B?L2NIQ2JUcUpHbVFRYWd6NG11RWpMVnhLaVpxcGNucGl0UGpBZUR3Q0YrdEwz?=
 =?utf-8?B?ZHlvWkgvWDZXZFYvZ2Qxa0ZUOExEOEtTc0dLWHl2ZFFpUWlCS0ZJMWYvYUpu?=
 =?utf-8?B?eXhGM0p0T2pLK2xSbkw1VHc3K2o4R1YvSzlXczk0a1E5am53dWw4T2hpT2p3?=
 =?utf-8?B?WTQveWIra2xXYmNlY0tLbHFLTEFYc1ArTXhYa2JNWG84TDMyYjd1YXM0WkRY?=
 =?utf-8?B?ekN3c1Y3Y3l2d3ZQMkN4RTB3U1pjRWQrbUpsbE9LRkR1YVZ4ZHRodTYxOWlN?=
 =?utf-8?B?MHB4MjQ1ZXVhUEFtK3FJQ0FSZlYwc3U2TlpPMkRuVEFmdWdVTkN6Q1FidUhM?=
 =?utf-8?B?cDAyeEhTWjJ5RGxhUHBrSUpCTnUzYUVVaExmZVJrWXczQW84dGVYcnMrd3Bi?=
 =?utf-8?B?QktmMWZKUHpOV1Z3V3FGdzBxM0EwZmNFdEhkV3FTSDJjZ2hiRkNkRzFUbTZu?=
 =?utf-8?B?Mk04c2xiR0JQZHpteHVxeFdwWENQRXFBWW1JZjNKMHJYYVFCRGZ3eEV3dlRy?=
 =?utf-8?B?V0pqdzR3cVNjV3VPenVCNmF0bUo3TXhEWXdwSXFXWDRQU3JieXlpL3g0Vi9J?=
 =?utf-8?B?RDVncWc2RGNiMzk2S2dIalRGUXVybUJTZm1RUGtrYzJRY0RtSnZGWFRxMjJl?=
 =?utf-8?B?SWJNcm96aHFjaVFEZ0tsdlBWSVVsd0NvcmRaVWdxTU9BOVBYUmJtOTViYkE1?=
 =?utf-8?B?Um5VTlNTaDYxbXlZcXdwOTZ6cEVUQkw1b292MVFGRFlBdHY3enViN2xjaXht?=
 =?utf-8?B?eGp3UGZhMC9EYlpwUGtsMkVxNmt1THV4ajlRMGl1bzRzNWphc3BUNXo2VmNM?=
 =?utf-8?B?N1JrTGM4YWFocEZ0OU1pN2U2S08wN1JVQnE1aDAydUNra1NHdUZnUDl6NEFi?=
 =?utf-8?B?dUlXRk5tRlFFRGdQUnByQXlOS01ibkQzaU83SXEvZGc3aVZTK2dhOHQ2SkND?=
 =?utf-8?B?K2szeGN1MWwxRmUwOGlLdHV5bERESy83aEpqeExEbTZJZWVCVmgybjFqUURz?=
 =?utf-8?B?ZDVnUDBHQWQ1TzRRUTExVFIxc0NvOWlBajBBaWgyVEtMQmJTQUkreUI3Vndk?=
 =?utf-8?B?V2EzV2JCNHQrRS9QR1NYZXRkS2pTTU9Xdk11UFBmMGNYRU5UeGNodnBKbzRl?=
 =?utf-8?B?UXlSU05ObnRub2RUek9hZkF5NXFqTlFyZTk3Yi9DUkZMc3dmMXZvV1NzTDBS?=
 =?utf-8?B?VCtHTUw0cnJTWWR2OU1pS0VDQUpXbzJRUnVrMEU5S0p5ZVpXV2h1Mm1ML01p?=
 =?utf-8?B?NUZxMkt5cVNMU3VqeldZbm52MW5TYjJtdGpyU3pUMHlNYko0WGR3bk4vLzhV?=
 =?utf-8?B?NVVRWXB1UjJlVldsQytmNzUyRmJ0Wm14MHVNeDgzZ0xUZU8yVDQ4T1NnOERX?=
 =?utf-8?B?TG5yMDBPc00vUzNpaUVrak82eHdZQUJrUVFBSnNoZ1BEbDRaSHRaTHkxd2My?=
 =?utf-8?B?MXJhVVV4Wjdqc1c3cW0vT2tuZTdWMUVUQm1VVmZKY2VtdHRlcVNhUG1ieEJK?=
 =?utf-8?B?a0Q3TmtMczhuVzZaV284dXEreDczZ2lZeStkSnkzUUtva2hCRUJ4MFRRNDJT?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B40F5A4376D7A4B88F2FDD2C2898E32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2e9b69-3753-48d7-a01c-08db621d9923
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 21:25:46.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTyId9zpDACqxStUthw5yk3vpaKhj7yYxftHGX/TdmHdPX1lDsKyFPhtMFVdBoywkackabnCiILZ+A3NPKDzXHF9jGzFp7JqN5Qrlwyf4xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7865
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTExIGF0IDE3OjA2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDIxIEFwciAyMDIzIDIxOjA5OjI3IC0wNjAwDQo+IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIHN5c2ZzIGJhc2Vk
IGZpcm13YXJlIGxvYWRlciBtZWNoYW5pc20gd2FzIGNyZWF0ZWQgdG8gZWFzaWx5IGFsbG93DQo+
ID4gdXNlcnNwYWNlIHRvIHVwbG9hZCBmaXJtd2FyZSBpbWFnZXMgdG8gRlBHQSBjYXJkcy4gVGhp
cyBhbHNvIGhhcHBlbnMgdG8NCj4gPiBiZSBwcmV0dHkgc3VpdGFibGUgdG8gY3JlYXRlIGEgdXNl
ci1pbml0aWF0ZWQgYnV0IGtlcm5lbC1jb250cm9sbGVkDQo+ID4gZmlybXdhcmUgdXBkYXRlIG1l
Y2hhbmlzbSBmb3IgQ1hMIGRldmljZXMsIHVzaW5nIHRoZSBDWEwgc3BlY2lmaWVkDQo+ID4gbWFp
bGJveCBjb21tYW5kcy4NCj4gPiANCj4gPiBTaW5jZSBmaXJtd2FyZSB1cGRhdGUgY29tbWFuZHMg
Y2FuIGJlIGxvbmctcnVubmluZywgYW5kIGNhbiBiZSBwcm9jZXNzZWQNCj4gPiBpbiB0aGUgYmFj
a2dyb3VuZCBieSB0aGUgZW5kcG9pbnQgZGV2aWNlLCBpdCBpcyBkZXNpcmFibGUgdG8gaGF2ZSB0
aGUNCj4gPiBhYmlsaXR5IHRvIGNodW5rIHRoZSBmaXJtd2FyZSB0cmFuc2ZlciBkb3duIHRvIHNt
YWxsZXIgcGllY2VzLCBzbyB0aGF0DQo+ID4gb25lIG9wZXJhdGlvbiBkb2VzIG5vdCBtb25vcG9s
aXplIHRoZSBtYWlsYm94LCBsb2NraW5nIG91dCBhbnkgb3RoZXINCj4gPiBsb25nIHJ1bm5pbmcg
YmFja2dyb3VuZCBjb21tYW5kcyBlbnRpcmVseSAtIGUuZy4gc2VjdXJpdHkgY29tbWFuZHMgbGlr
ZQ0KPiA+ICdzYW5pdGl6ZScgb3IgcG9pc29uIHNjYW5uaW5nIG9wZXJhdGlvbnMuDQo+ID4gDQo+
ID4gVGhlIGZpcm13YXJlIGxvYWRlciBtZWNoYW5pc20gYWxsb3dzIGEgbmF0dXJhbCB3YXkgdG8g
cGVyZm9ybSB0aGlzDQo+ID4gY2h1bmtpbmcsIGFzIGFmdGVyIGVhY2ggbWFpbGJveCBjb21tYW5k
LCB0aGF0IGlzIHJlc3RyaWN0ZWQgdG8gdGhlDQo+ID4gbWF4aW11bSBtYWlsYm94IHBheWxvYWQg
c2l6ZSwgdGhlIGN4bCBtZW1kZXYgZHJpdmVyIHJlbGlucXVpc2hlcyBjb250cm9sDQo+ID4gYmFj
ayB0byB0aGUgZndfbG9hZGVyIHN5c3RlbSBhbmQgYXdhaXRzIHRoZSBuZXh0IGNodW5rIG9mIGRh
dGEgdG8NCj4gPiB0cmFuc2Zlci4gVGhpcyBvcGVucyBvcHBvcnR1bml0aWVzIGZvciBvdGhlciBi
YWNrZ3JvdW5kIGNvbW1hbmRzIHRvDQo+ID4gYWNjZXNzIHRoZSBtYWlsYm94IGFuZCBzZW5kIHRo
ZWlyIG93biBzbGljZXMgb2YgYmFja2dyb3VuZCBjb21tYW5kcy4NCj4gPiANCj4gPiBBZGQgdGhl
IG5lY2Vzc2FyeSBoZWxwZXJzIGFuZCBzdGF0ZSB0cmFja2luZyB0byBiZSBhYmxlIHRvIHBlcmZv
cm0gdGhlDQo+ID4gJ0dldCBGVyBJbmZvJywgJ1RyYW5zZmVyIEZXJywgYW5kICdBY3RpdmF0ZSBG
VycgbWFpbGJveCBjb21tYW5kcyBhcw0KPiA+IGRlc2NyaWJlZCBpbiB0aGUgQ1hMIHNwZWMuIFdp
cmUgdGhlc2UgdXAgdG8gdGhlIGZpcm13YXJlIGxvYWRlcg0KPiA+IGNhbGxiYWNrcywgYW5kIHJl
Z2lzdGVyIHdpdGggdGhhdCBzeXN0ZW0gdG8gY3JlYXRlIHRoZSBtZW1YL2Zpcm13YXJlLw0KPiA+
IHN5c2ZzIEFCSS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbT4NCj4gSGkgVmlzaGFsLA0KPiANCj4gVmFyaW91cyBjb21tZW50
cyBpbmxpbmUuDQo+IA0KSGkgSm9uYXRoYW4gLSBhbGwgb2YgdGhlIGNvbW1lbnRzIHdlcmUgZmlu
ZSwgSSd2ZSBhZGRyZXNzZWQgdGhlbSBmb3INCnYyLiBUaGFua3MgZm9yIHJldmlld2luZyB0aGVz
ZSENCg0KVmlzaGFsDQo=
