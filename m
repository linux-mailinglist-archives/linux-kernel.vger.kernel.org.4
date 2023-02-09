Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84836690F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBIRjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:39:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2AD53D;
        Thu,  9 Feb 2023 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675964381; x=1707500381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6DFfMMTxubNAow/xSgfxPKyyH0TwZW6oEmrTuMYa9L0=;
  b=YHqoeL/k2J02UqzFRAg0c5Lzqs1AGy5kbfhiMbDKVNBxMqaEoY4FzHSj
   sANODWx+EEZyHeL6FkGxa5ggbOaNOuYYaL/Pz0jt8KG1uB8UrePxb/U5u
   xl+2rLoQi99Eh4IQUAy6vYhjQ10yol4XfZt/Cp4s0s4ooW670o7kJH1bL
   pBbymcSnJaIe5jm3TrmRDjguBgq2M3OpvFFECl2N0xOR6lpqILO0Isa7N
   37EAYCP7Y5MpvzGD14Ujc0DsLK+oVyTjhadLJidrbNuIX/sBiUArDQKfa
   Bzhx6d7OAYR4CjhQrazW24YAx9h4eznRzL/VOdudTEm++FJYRyAa4Jf7x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328821763"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="328821763"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="736439347"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="736439347"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 09 Feb 2023 09:39:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 09:39:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 09:39:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 09:39:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 09:39:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmpecRe2vC2fU/r5eBuNizMJtWVfCJU309QQH2F8LWzPxw1j3izsCod8/d31C+uoYzhYl5796LmvZNc0+2olgC+LqZdWcNNwJale+kOJDkBBIxhT1WwEYIJZC4XT2ZEp89WLyQAcjDq/zrQUhIURHUD4OjCs4ozd8dAZlsArltLXhLm5v+5I5V844FnpGGREomJS1cLoTuv3pgO/zLz0NCPwy6/8dHswZB8mLIlX6EFqCu9FnXd6+LrsGLm3d7SLppYOwCBBQ1VISm6Q2OkhFcmwaYl786vqk+BaJA3uPDR7mZ8mDLquQeWSF4RpRJazVS2eInI8Ex8zWku3RFfOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DFfMMTxubNAow/xSgfxPKyyH0TwZW6oEmrTuMYa9L0=;
 b=OQl+3ShqEasK1sPvaXBrYkt+klKLmoQ9SJodkQKl+sExTD/4Dk/BOpVtF9JyD91DPEy30voKc5UmSOgeDd/xCxmkNBJP9ctkHIiCxpI7l0rvM/THdT8iLzVTWFqvZGr+PLzf8JKtPgiblVT3g15Fa1QTuil77TyxYKaKhr0a5oc7ckbfHcflA+ojmdODtAGmMfj64+6jlrdL/XIP+osES9rxWridNaqLcBT9YldQHSKCz6EQTbQ6Ap3I4132hDiAKMGvulKsYf7gwObvl5njYuNeDhqOVrAn1jjNXkVrwS6XGHtsXpFgnEfqK6RDZGkvoQP7lLw5UERG4Yj/84HteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 17:39:33 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::fbab:ba2:a07f:55cb]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::fbab:ba2:a07f:55cb%9]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 17:39:32 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rajat.khandelwal@linux.intel.com" <rajat.khandelwal@linux.intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Topic: [PATCH v4] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Index: AQHZOMACjUyTtgCxq0yRuAevSO2Q8K6/KcYAgAd6NYCAAEVzgA==
Date:   Thu, 9 Feb 2023 17:39:32 +0000
Message-ID: <a6f9e8101daf7a036e89e583d78b6bb7507c0c2c.camel@intel.com>
References: <20230205174418.1927876-1-rajat.khandelwal@linux.intel.com>
         <75308e1b2e0406118b1012e271c622b2f02c119e.camel@intel.com>
         <8afe0502-2e2a-a89b-dbe0-bf74aef98290@linux.intel.com>
In-Reply-To: <8afe0502-2e2a-a89b-dbe0-bf74aef98290@linux.intel.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|PH0PR11MB5191:EE_
x-ms-office365-filtering-correlation-id: 8b7e37bf-8e40-46f2-2095-08db0ac49aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MpfxkbnTsgYC+xKiqVRdICdk3JFjzYGX1UpTWZauRgq4ag+uyI0+AP+HDzNeL+EffNZ0HoCFP5QVzfUR768D1dCCBOWgT3I1riwcQtJW0HzFq5pyAjpoL1/OoLqY4AV72NXmgQYlt/2/DONiWLdAYw3pw08QTySNIptr8tvcVi9VxyxBRYo1Cpptz5OfAyJO7cDDFA/CgFjbeJWO2hQ/842Xx2Yg9o5dy4QQGTNzInI+lQUeY5mwUtkFInYp7NxVBz28+xM4ph4mrmYJQuOHGFHsXFN0NDSbSc9CCab45hjlivJ63pJ1KRsRi/1Mheu9AVi6tV38Vb1Jagi6gxVYf8Dng+b14krlyP7MSgeBreMZXE89amgp6Pgd0jZ/aZpX0e4LrMt6aHxEVPb/KjJNIqcFirQvSpX51Fmqqmk8zO3dx0ST2uvIsnZMRPspmIeqpasUU7kHFPQGMR+ccofUoONZOD+4njwvY1yQmmBwyT2TVDY+C+bI0PbVzFLlFaeIQBnhF3TS+mHD+085ImpYv3r1GKhaZbUujEiTnxAF3ORvIDqFTenyL7s+BLEo38eGaesc9v+PPm8FsZsTlXOceLvZaWkfx2wF7ZSGIxbJawtzO9CMl4e+F6XY8dCxxvdHmJtM5ffBgoGC0C4W6g6Dhd3KWbvlH8NC/7ZfWFDCsPOye8ypmqvG4F1PG0FutiIIFq2EOG2A8S3oy92HcK+Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199018)(6512007)(3450700001)(186003)(38070700005)(6506007)(53546011)(2906002)(26005)(36756003)(5660300002)(478600001)(6486002)(8936002)(82960400001)(41300700001)(2616005)(71200400001)(64756008)(66899018)(66446008)(8676002)(66946007)(4326008)(76116006)(91956017)(66476007)(83380400001)(122000001)(66556008)(86362001)(110136005)(54906003)(38100700002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1g0blFSN0FxR2ZrYjdJNjdxZ0RiaElvWURxRGQ4WlFwVDN6bVJnZnNES2hz?=
 =?utf-8?B?bGxONUpnZXlQMXhKNGlqb0xDUkREb01TaHBqNVV6NTcxY0huSWo4SGVJVWlt?=
 =?utf-8?B?WXh3Vkl5NUt3VmZkMklQVzNjMDg4djRyV0I1ZTExMkdzK3ZqbHRrQkdYc1lx?=
 =?utf-8?B?eWhRU3E1NkFLcmE4T21kNGpXRXNSWUlXclZ5OW1PeVZZeWhnWmM3MGN5TkR2?=
 =?utf-8?B?cTNVQ2FoN3pGYmZPYlo3NDgxc0poYVhWbkJ0NE9MV1AxdXlKSHp6YjJEUG1L?=
 =?utf-8?B?NlI3NDV0NjJXRm5WaElxT0JNNXpTTjNydStUdW1CZ0lXZmNRL2FjV3hVR3Zh?=
 =?utf-8?B?cHVWUzJYcHJVS25qdWJOcGZCejVJUkxjYUV1bWhhKzk2bUVjMUkxdXF4N09s?=
 =?utf-8?B?c3dZR3VPNUM3MzY5OVRaY0pCTUJvaGhLc2NvUjlUdVdTb05BT2I4SHBIMnor?=
 =?utf-8?B?SjJYTDgzWWVCTVFUZVlPZXFOQ25aWjBENFlvdEZYUU9hNkwxSEFVUFoyQXhC?=
 =?utf-8?B?b1ZNcVlweDNrRWNUUU1HOURubGRDQ2hUM0xrbHQ5TUYvZWFuZXF4TnYrNGxx?=
 =?utf-8?B?NXdOODdrQUpoSzN4RWZoYWZ5T1pUSVNiU3kyNzlxZ3VJTm9PMGxSU0NUZEF3?=
 =?utf-8?B?b2JqaS9oTUZvMllUN0dWdkM0cWxYc2JoUjNIZWpmMS9Tc3ZvTEl4NXExb3h2?=
 =?utf-8?B?ckxScWJPNU9TSWl1R3dIUFM2WlE5QUZRendsZ3NmSjlib2xYbW15OXgvaHUy?=
 =?utf-8?B?dzUvUjFOT0tyRTJWc3hBWTlRelBadDFiZmk5VlQyM0lxbCtNMlM2SG1UNnBO?=
 =?utf-8?B?eU81OGxubFF6NzE4S21pU1BhS3ZCTkpocStobUhkdS9qK3RqbzV3KzQ3b2Fu?=
 =?utf-8?B?VTBEczJENS9yQUxhZldpS0EzYzd4b2F4L0lJb2hQY0JFMkdITERYVS9XSXZ1?=
 =?utf-8?B?Qml4VEF2MFEzTUZoTEgyMC9XUk5MQTlkcE0rTmpoL3daVzNtd0pwc0U1c2Y3?=
 =?utf-8?B?UDFlQUlIWDNFS3kxMEk3K0tjSDFBZzVMOVFMb0dvT3cvanB2V3FmbTRjU3hh?=
 =?utf-8?B?VGtlSGxRNVFyL0M3Sm95RHB1dVNqZklEUDJqUFJwK1E5ZWFpLzRERjlvTHhp?=
 =?utf-8?B?MWszdmNtcWVXRkovVTlYWm84NmhFM01KdzNXQkVDdW8vN3NFVFMrVWpOb3ZI?=
 =?utf-8?B?YmlxbTZxVGtrTWd2c0xmNFdpNTlqQjl5b2JlZElLcXgyaklWMHc4YmlWbUlP?=
 =?utf-8?B?OU1IS1JqQlBoR21DbTA1Mm9DWXFacVRIT1M4NmtGclhMMm9JRGcyaFJwM1ds?=
 =?utf-8?B?MUpyVGdqTytmTkZKcnRlRUk5S043bzBybFZlYkZyeXMwa1dLenhpY1oreDIx?=
 =?utf-8?B?R1J6QVQvdVovZm5xNGxwRlMxYUlwSkZZVWc5VEU1V015THRMSVZKeU95R0hG?=
 =?utf-8?B?QllYUVhtRThCOHlMYWplck4ycVBZY1VLanBoSWd2ODFDVXViejl6R1hvNTh5?=
 =?utf-8?B?dTdROTZXcWhhL0lLbUpwYzA1K0lUanNqN1dMb25ibXFIQ0QzMldvOXQ2blRw?=
 =?utf-8?B?STFvQ0NEV0pmcHVqL1AvL3NEaFgrVFI0dHRZK21ibHBreHkvejZhR1ExL1R2?=
 =?utf-8?B?N21MS3FTamdzZ3REOVNwK0t3Q0dZU25DeEdCU0J6MWNxcDRzSi9pbHk1RmxS?=
 =?utf-8?B?VmxiLy82MUZXZ3FpV3lFdEFGUGRFRXlDa011VXZVam9IbE10NVVFbVRUR2lw?=
 =?utf-8?B?M0pDSGx0VlhKV3VTeWJxUHVXR0dPTGJZc1lzSThCQmVYZUx2ZW5WRW9KSTNU?=
 =?utf-8?B?S0s2c1R4dGl1T3Nsb2x2bUZYUldQb0dEeEphS3BVT1BRa3BjdEtXNHJ5QWNs?=
 =?utf-8?B?N0gwaVU1RjhhT1JIUlMvVHFlaUtwQ3NnYlphVGlMVXpLUEdrdTBNNitGZ25x?=
 =?utf-8?B?NHF5Q21RYjNkcmdZanphL2dVOWZxdFBqWmIyWi84T2tudm9qanM3OGJaMFJk?=
 =?utf-8?B?QkJQMVdlNWFqYmxhSkNCZFhhN05oME92L1N1OUFTTU02a3ZTcmxsRUI2anpM?=
 =?utf-8?B?MjA0WnE1dThqdUh0L1krN29SU2JTV21ua2NWSFd1TFUwaVVKc3Buam9XdC9L?=
 =?utf-8?B?MlVKdUN6TUQzUFArZVQvQk9OVi9WUnFtTWU5U2hia2xyMWtOYjVUY1RxYmE1?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27E38FB678B69C40BF1FF8CD90701E24@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7e37bf-8e40-46f2-2095-08db0ac49aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 17:39:32.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksyH+rrAnll1mgd26ICj/t8IQx0lN3XvBGrhhrtaw+28V3r2uFDQ7tQqrZu9Y4/VGr3gOg/aYigcIBi+Ac/xjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFqYXQsDQoNCk9uIFRodSwgMjAyMy0wMi0wOSBhdCAxOTowMCArMDUzMCwgUmFqYXQgS2hh
bmRlbHdhbCB3cm90ZToNCj4gSGkgRGF2aWQsDQo+IFBsZWFzZSBmaW5kIHRoZSBjb21tZW50cyBp
bmxpbmUuDQo+IA0KPiBPbiAyLzUvMjAyMyAxMjo0OSBBTSwgQm94LCBEYXZpZCBFIHdyb3RlOg0K
PiA+IEhpIFJhamF0LA0KPiA+IA0KPiA+IE9uIFN1biwgMjAyMy0wMi0wNSBhdCAyMzoxNCArMDUz
MCwgUmFqYXQgS2hhbmRlbHdhbCB3cm90ZToNCj4gPiA+IEN1cnJlbnRseSwgJ2x0cl9pZ25vcmUn
IHN5c2ZzIGF0dHJpYnV0ZSwgd2hlbiByZWFkLCByZXR1cm5zIG5vdGhpbmcsIGV2ZW4NCj4gPiA+
IGlmIHRoZXJlIGFyZSBjb21wb25lbnRzIHdob3NlIExUUiB2YWx1ZXMgaGF2ZSBiZWVuIGlnbm9y
ZWQuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgZmVhdHVyZSB0byBwcmludCBv
dXQgc3VjaCBjb21wb25lbnRzLCBpZiB0aGV5IGV4aXN0Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBSYWphdCBLaGFuZGVsd2FsIDxyYWphdC5raGFuZGVsd2FsQGxpbnV4LmludGVsLmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiB2NDogTXV0ZXggdW5sb2NrIGR1cmluZyBlcnJv
ciBjb25kaXRpb25zDQo+ID4gPiANCj4gPiA+IHYzOiBJbmNvcnBvcmF0ZWQgYSBtdXRleCBsb2Nr
IGZvciBhY2Nlc3NpbmcgJ2x0cl9pZ25vcmVfbGlzdCcNCj4gPiA+IA0KPiA+ID4gdjI6IGttYWxs
b2MgLT4gZGV2bV9rbWFsbG9jDQo+ID4gPiANCj4gPiA+IMKgwqBkcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbC9wbWMvY29yZS5jIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ID4g
PiDCoMKgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuaCB8wqAgMiArLQ0KPiA+
ID4gwqDCoDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0p
DQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9w
bWMvY29yZS5jDQo+ID4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMN
Cj4gPiA+IGluZGV4IDNhMTVkMzJkNzY0NC4uZjlkNGIyODY1YjAzIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJp
dmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuYw0KPiA+ID4gQEAgLTUzLDYgKzUzLDE3
IEBAIGNvbnN0IHN0cnVjdCBwbWNfYml0X21hcCBtc3JfbWFwW10gPSB7DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqB7fQ0KPiA+ID4gwqDCoH07DQo+ID4gPiDCoCANCj4gPiA+ICsvKiBNdXR1YWwg
ZXhjbHVzaW9uIHRvIGFjY2VzcyB0aGUgbGlzdCBvZiBMVFItaWdub3JlZCBjb21wb25lbnRzICov
DQo+ID4gPiArc3RhdGljIERFRklORV9NVVRFWChsdHJfZW50cnlfbXV0ZXgpOw0KPiA+ID4gKw0K
PiA+ID4gK3N0cnVjdCBsdHJfZW50cnkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgdTMyIGNvbXBf
aW5kZXg7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBjb25zdCBjaGFyICpjb21wX25hbWU7DQo+ID4g
PiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9oZWFkIG5vZGU7DQo+ID4gPiArfTsNCj4gPiA+
ICsNCj4gPiA+ICtzdGF0aWMgTElTVF9IRUFEKGx0cl9pZ25vcmVfbGlzdCk7DQo+ID4gPiArDQo+
ID4gPiDCoMKgc3RhdGljIGlubGluZSB1MzIgcG1jX2NvcmVfcmVnX3JlYWQoc3RydWN0IHBtY19k
ZXYgKnBtY2RldiwgaW50DQo+ID4gPiByZWdfb2Zmc2V0KQ0KPiA+ID4gwqDCoHsNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiByZWFkbChwbWNkZXYtPnJlZ2Jhc2UgKyByZWdfb2Zmc2V0
KTsNCj4gPiA+IEBAIC00MzUsMjcgKzQ0NiwxOCBAQCBzdGF0aWMgaW50IHBtY19jb3JlX3BsbF9z
aG93KHN0cnVjdCBzZXFfZmlsZSAqcywNCj4gPiA+IHZvaWQNCj4gPiA+ICp1bnVzZWQpDQo+ID4g
PiDCoMKgfQ0KPiA+ID4gwqDCoERFRklORV9TSE9XX0FUVFJJQlVURShwbWNfY29yZV9wbGwpOw0K
PiA+ID4gwqAgDQo+ID4gPiAtaW50IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShzdHJ1Y3QgcG1j
X2RldiAqcG1jZGV2LCB1MzIgdmFsdWUpDQo+ID4gPiArdm9pZCBwbWNfY29yZV9zZW5kX2x0cl9p
Z25vcmUoc3RydWN0IHBtY19kZXYgKnBtY2RldiwgdTMyIHZhbHVlKQ0KPiA+ID4gwqDCoHsNCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBwbWNfcmVnX21hcCAqbWFwID0gcG1j
ZGV2LT5tYXA7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqB1MzIgcmVnOw0KPiA+ID4gLcKgwqDC
oMKgwqDCoMKgaW50IGVyciA9IDA7DQo+ID4gPiDCoCANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oG11dGV4X2xvY2soJnBtY2Rldi0+bG9jayk7DQo+ID4gPiDCoCANCj4gPiA+IC3CoMKgwqDCoMKg
wqDCoGlmICh2YWx1ZSA+IG1hcC0+bHRyX2lnbm9yZV9tYXgpIHsNCj4gPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAtRUlOVkFMOw0KPiA+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3VubG9jazsNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoH0N
Cj4gPiA+IC0NCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IHBtY19jb3JlX3JlZ19yZWFk
KHBtY2RldiwgbWFwLT5sdHJfaWdub3JlX29mZnNldCk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqByZWcgfD0gQklUKHZhbHVlKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoHBtY19jb3JlX3Jl
Z193cml0ZShwbWNkZXYsIG1hcC0+bHRyX2lnbm9yZV9vZmZzZXQsIHJlZyk7DQo+ID4gPiDCoCAN
Cj4gPiA+IC1vdXRfdW5sb2NrOg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2Nr
KCZwbWNkZXYtPmxvY2spOw0KPiA+ID4gLQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIGVy
cjsNCj4gPiA+IMKgwqB9DQo+ID4gPiDCoCANCj4gPiA+IMKgwqBzdGF0aWMgc3NpemVfdCBwbWNf
Y29yZV9sdHJfaWdub3JlX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLA0KPiA+ID4gQEAgLTQ2NCw2
ICs0NjYsOCBAQCBzdGF0aWMgc3NpemVfdCBwbWNfY29yZV9sdHJfaWdub3JlX3dyaXRlKHN0cnVj
dCBmaWxlDQo+ID4gPiAqZmlsZSwNCj4gPiA+IMKgwqB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3Qgc2VxX2ZpbGUgKnMgPSBmaWxlLT5wcml2YXRlX2RhdGE7DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgcG1jX2RldiAqcG1jZGV2ID0gcy0+cHJpdmF0ZTsNCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBwbWNfcmVnX21hcCAqbWFwID0gcG1jZGV2LT5tYXA7
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbHRyX2VudHJ5ICplbnRyeTsNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoHUzMiBidWZfc2l6ZSwgdmFsdWU7DQo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqBpbnQgZXJyOw0KPiA+ID4gwqAgDQo+ID4gPiBAQCAtNDczLDEzICs0NzcsNDYgQEAgc3Rh
dGljIHNzaXplX3QgcG1jX2NvcmVfbHRyX2lnbm9yZV93cml0ZShzdHJ1Y3QgZmlsZQ0KPiA+ID4g
KmZpbGUsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQ0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBlcnI7DQo+ID4gPiDCoCANCj4gPiA+IC3C
oMKgwqDCoMKgwqDCoGVyciA9IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShwbWNkZXYsIHZhbHVl
KTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmICh2YWx1ZSA+IG1hcC0+bHRyX2lnbm9yZV9tYXgp
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7DQo+
ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZsdHJfZW50cnlfbXV0ZXgp
Ow0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShlbnRy
eSwgJmx0cl9pZ25vcmVfbGlzdCwgbm9kZSkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmIChlbnRyeS0+Y29tcF9pbmRleCA9PSB2YWx1ZSkgew0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAtRUVYSVNUOw0K
PiA+IERvIHdlIG5lZWQgdG8gcmV0dXJuIGFuIGVycm9yIGhlcmU/IFdlIGRvbid0IG9mZmVyIGEg
d2F5IHRvIHVuZG8gdGhlIGlnbm9yZQ0KPiA+IGFuZA0KPiA+IHJld3JpdGluZyBpdCBkb2Vzbid0
IGh1cnQgYW55dGhpbmcuIEknbSBva2F5IHdpdGggaWdub3JpbmcgdGhpcy4NCj4gDQo+IFN1cmVs
eSwgaXQgd29uJ3QgaHVydCB0byBqdXN0IHdyaXRlIHRoZSB2YWx1ZSBhZ2Fpbi4gSXQgZG9lcyBw
cm92aWRlIGEgc2Vuc2UNCj4gb2Ygbm90aW9uDQo+IHRvIHRoZSB1c2VyIHRoYXQgInRoaXMgY29t
cG9uZW50IHdhcyBhbHJlYWR5IHNldCIgKHNvbWV0aGluZyBsaWtlIHRoYXQpLg0KPiBOb3QgdGhh
dCBiaWcgYSBkZWFsLCBidXQgSSB3b3VsZCBsaWtlIHRvIGtlZXAgaXQgdGhhdCB3YXksIGlmIHRo
YXQncyBva2F5PyA6KQ0KDQpPa2F5LiBJdCBpcyBhIG5ldyBlcnJvciBiZWluZyByZXR1cm5lZCBm
b3Igc29tZXRoaW5nIHRoYXQgdXNlZCB0byBiZSBhbGxvd2VkLg0KUGxlYXNlIGFkZCBpdCB0byB0
aGUgY29tbWl0IG1lc3NhZ2UuDQoNCj4gDQo+ID4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3VubG9jazsNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiArwqDCoMKgwqDCoMKgwqB9DQo+ID4g
PiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBlbnRyeSA9IGRldm1fa21hbGxvYygmcG1jZGV2LT5w
ZGV2LT5kZXYsIHNpemVvZigqZW50cnkpLA0KPiA+ID4gR0ZQX0tFUk5FTCk7DQo+ID4gPiArwqDC
oMKgwqDCoMKgwqBpZiAoIWVudHJ5KSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZXJyID0gLUVOT01FTTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBnb3RvIG91dF91bmxvY2s7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiArDQo+ID4g
PiArwqDCoMKgwqDCoMKgwqBlbnRyeS0+Y29tcF9uYW1lID0gbWFwLT5sdHJfc2hvd19zdHNbdmFs
dWVdLm5hbWU7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBlbnRyeS0+Y29tcF9pbmRleCA9IHZhbHVl
Ow0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgbGlzdF9hZGRfdGFpbCgmZW50cnktPm5vZGUsICZsdHJf
aWdub3JlX2xpc3QpOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgcG1jX2NvcmVfc2Vu
ZF9sdHJfaWdub3JlKHBtY2RldiwgdmFsdWUpOw0KPiA+ID4gKw0KPiA+ID4gK291dF91bmxvY2s6
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmx0cl9lbnRyeV9tdXRleCk7DQo+
ID4gWW91IGNhbiBhbGxvY2F0ZSB5b3VyIGVudHJ5IGFuZCBkbyB0aGUgYXNzaWdubWVudCBiZWZv
cmUgeW91IHRha2UgdGhlIGxpc3QNCj4gPiBsb2NrLg0KPiA+IElmIHRoZSBhbGxvY2F0aW9uIGZh
aWxzLCByZXR1cm4gaW1tZWRpYXRlbHkgd2l0aG91dCBhIGdvdG8uDQo+ID4gDQo+ID4gWW91IGNh
biBhbHNvIG1vdmUgcG1jX2NvcmVfc2VuZF9sdHJfaWdub3JlKCkgYWZ0ZXIgdGhlIHVubG9jay4N
Cj4gDQo+IE9rLCBzbyBJIGFsbG9jYXRlIGl0IG9ubHkgYWZ0ZXIgSSBzZWUgdGhhdCB0aGUgbGlz
dCBkb2Vzbid0IGFscmVhZHkgaGFzIHRoZQ0KPiB2YWx1ZS4NCj4gVGhhdCBpcyB3aHkgSSB0YWtl
IHRoZSBsb2NrIGFuZCBwcm9jZWVkLg0KDQpBaCwgSSBtaXNzZWQgdGhhdC4NCg0KPiBwbWNfY29y
ZV9zZW5kX2x0cl9pZ25vcmUoKSBjYW4gYmUgbW92ZWQgYWZ0ZXIgdGhlIHVubG9jay4NCg0KWWVz
Lg0KDQpEYXZpZA0KDQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBjb21tZW50cyBmb3Ig
djUuDQo+IA0KPiBUaGFua3MNCj4gUmFqYXQNCj4gDQo+ID4gDQo+ID4gRGF2aWQNCj4gPiANCj4g
PiA+IMKgIA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVyciA9PSAwID8gY291bnQg
OiBlcnI7DQo+ID4gPiDCoMKgfQ0KPiA+ID4gwqAgDQo+ID4gPiDCoMKgc3RhdGljIGludCBwbWNf
Y29yZV9sdHJfaWdub3JlX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+
ID4gPiDCoMKgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGx0cl9lbnRyeSAqZW50cnk7
DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZsdHJfZW50cnlfbXV0
ZXgpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShlbnRyeSwgJmx0
cl9pZ25vcmVfbGlzdCwgbm9kZSkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHNlcV9wcmludGYocywgIiVzXG4iLCBlbnRyeS0+Y29tcF9uYW1lKTsNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoH0NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmbHRyX2VudHJ5
X211dGV4KTsNCj4gPiA+ICsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiA+
ID4gwqDCoH0NCj4gPiA+IMKgIA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L2ludGVsL3BtYy9jb3JlLmgNCj4gPiA+IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwv
cG1jL2NvcmUuaA0KPiA+ID4gaW5kZXggODEwMjA0ZDc1OGFiLi5kYTM1YjBmY2JlNmUgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oDQo+ID4g
PiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oDQo+ID4gPiBAQCAt
Mzk2LDcgKzM5Niw3IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgcG1jX3JlZ19tYXAgYWRsX3JlZ19t
YXA7DQo+ID4gPiDCoMKgZXh0ZXJuIGNvbnN0IHN0cnVjdCBwbWNfcmVnX21hcCBtdGxfcmVnX21h
cDsNCj4gPiA+IMKgIA0KPiA+ID4gwqDCoGV4dGVybiB2b2lkIHBtY19jb3JlX2dldF90Z2xfbHBt
X3JlcXMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldik7DQo+ID4gPiAtZXh0ZXJuIGludCBw
bWNfY29yZV9zZW5kX2x0cl9pZ25vcmUoc3RydWN0IHBtY19kZXYgKnBtY2RldiwgdTMyIHZhbHVl
KTsNCj4gPiA+ICtleHRlcm4gdm9pZCBwbWNfY29yZV9zZW5kX2x0cl9pZ25vcmUoc3RydWN0IHBt
Y19kZXYgKnBtY2RldiwgdTMyIHZhbHVlKTsNCj4gPiA+IMKgIA0KPiA+ID4gwqDCoHZvaWQgc3B0
X2NvcmVfaW5pdChzdHJ1Y3QgcG1jX2RldiAqcG1jZGV2KTsNCj4gPiA+IMKgwqB2b2lkIGNucF9j
b3JlX2luaXQoc3RydWN0IHBtY19kZXYgKnBtY2Rldik7DQo+ID4gPiAtLSANCj4gPiA+IDIuMzQu
MQ0KPiA+ID4gDQoNCg==
