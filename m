Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A7F676AFB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 04:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAVDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 22:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVDih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 22:38:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAF29C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674358716; x=1705894716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cc26jzm47wcNmVCKbEq3sI4HIfLQvlChDCew003KUe4=;
  b=IgHm7+Xb/SUxhRltrpCpzPcHhKQFeXS58PPTb4Dyt5IbAkJs7Zagq+uC
   6dn1OObaZxokalz6LuR8DE7BN7Eak5VUV1ZReMzgD+L5uqoS3Taqdox5V
   dTrMmP3dEFE1RFKPHHo/dT7h1SF/t9EGtx2DuUWF3jxLVWb1i++XYwJu9
   +rH+/17uaZ8IaC28wCGg2E8V2OBS57PTH2AaAX+V6uzMGzc1rvwX4+F6L
   +xbDvbZF3/LCAt1Xe+pWv3KzMEzdJjfLb//MJnp27oYR0pVbEWe5RmsQQ
   O5pfwDp4gi2qtnZw38JENq93XrbGqt37AL20V6PN5O168sY7q+kE/gfaN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="353121239"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="353121239"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 19:38:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="785000532"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="785000532"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2023 19:38:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 21 Jan 2023 19:38:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 21 Jan 2023 19:38:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 21 Jan 2023 19:38:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 21 Jan 2023 19:38:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+D3OKWR4zWgMCrjQuEgbPJaOVEDIgO14hLsuiuYlUo4SV2GcMyQyCw3B84OTnh5QBtyjxmvVDR45Jp1/gIDYe1xQZYtyaXt/M+4LBxOImynrnlIlYIdtw7xRR+xI68o0+CmuY2HlqhLcDHyjOCYqLmb86cY86Ed+wqzoj+u3XNA0z3dNVWUjhGglihHbfJIq/tn19+k4N0vtCGO5O3UWAJWaRLNmHk+LzZ1uzMoKedwL7ooNYAuVkbWtoOVQbJwCADZl5cDuVJOhbb3VHcJwW3+rXwWMaEuyei1u1KayZVk19kXsc4K6IjO1eB+AgA/2aEFsNTkuhsLtiQAhsJJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc26jzm47wcNmVCKbEq3sI4HIfLQvlChDCew003KUe4=;
 b=LE5Vvfu8VOjIl3mxQaWh6w9z5AHfAYXpzbWFPatIxjQvyz01sqj6htpk/ZjsFap+8tNzMttha8kXVCkm5GRe81TSg5w/4UugUaA+0SnsjMi7Es5UNv3N2pGDz3RGAd0+zB7IJLu+R+AA9+z5OBxPJxYSHy1E1mV/5FN0FqODu8sI5r8qiy03mgPYOKsFCosYnmG9F2Oq49ZU0994ssWl2X47E4zft9zgdpwvhZowLK5RN/YiLLyqM0OUG1oHGTRsIVJJrUm8EzlpbUUHuAFYGI+3/xbp3W8EAyUFjCArNcbQ7T35DwEKMqVZimEby/65zwhaLsgWQHZ23NX7vLFGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sun, 22 Jan
 2023 03:38:30 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Sun, 22 Jan 2023
 03:38:30 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Topic: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Index: AdksoOwgh+CixkbaRlyKVQgPVVpsjwAVg5YAABeOzAAALxBJsA==
Date:   Sun, 22 Jan 2023 03:38:30 +0000
Message-ID: <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
In-Reply-To: <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH7PR11MB5817:EE_
x-ms-office365-filtering-correlation-id: 7f1ef9df-b90f-4b66-098c-08dafc2a2171
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHD+AMEyA+2k7wAk59UeAlhVj4Nz9IYS4HY7FK9LK1oW/Q7X0P3usSOUXZDet3bY2OpbHh/YW+OfplaL6jVzTdNifGYlg/tTWChoh5xmgm3MU/jI7bTVWbmaoQvlZADZj7wrHaYW4gDuNVg/ja4xqG04BxgfdXvxUKkKNMB4SJzoMuq7M74n5j3S+8wavWAhLlSYDfH8mqPhBmt+/TAGf5EfiLqiDh4wHx/TCiZHm7i0NBE+aGcXiFz3FgNn6IgdAp9bwc2ADd3JImMb2n3qEVtK+v9vHjkWpC3jqmBGsuZn6LO/+Z2ikmCsFhJlrg+g2B81DAWTh+HQB2QfVm8uXe61N4pLSA9L4/YXrl5ec3Hy2/J6GVR0pKsyFYB1W28iQM5W+L19IPPoWwj1J4cWG7si9AQh2gTi0oqnfjL3jLWt3tXLk86+Z9MZ5Iqy9aSchynV4Yh6E/g4cBAn1J7ziwUH9yUUbnP+TSx/03mjxAXQgm3Bdg2zpJ0hhZTnnIPAujvkWjIfWOFcm/lZZIoBhEzC99+03B76wVMyDM4TTK3tDyNSiS2mqyKmBD/iIln2BE4yZ2kURp6Vcspz3JImaPROFuyA4ZUF59fabG6uKKM6Lea0MXOwxMpJTHiIAEBBzKZTbmK5GaW/azGxW5beVJbWfKjWnJTgjCKNc+JSRhigpZGunTRty/fWICbw6R0clJL/2Rx/kFLwF9LHKCQh7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(38070700005)(86362001)(55016003)(66556008)(66476007)(64756008)(8676002)(66446008)(4326008)(76116006)(66946007)(5660300002)(2906002)(8936002)(38100700002)(122000001)(82960400001)(33656002)(316002)(71200400001)(478600001)(7696005)(110136005)(54906003)(52536014)(41300700001)(9686003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1J1RGxXUFcwU2tlVlEzTGJ3L3hJRTg0dXhwSHVoMEgwSzBXT1VHYTFJQXJy?=
 =?utf-8?B?bW5XN3BIK0F3Y21ydVg1SkxRZXZQTmNlNXJRUi9DQk9uVlRrZWduYmtnYUVy?=
 =?utf-8?B?MHdtZnEzcXBTcW5jZGNUaUUwbm9YdUliZE9NOU1YM0JtVFNoNjB5RmVoRzVO?=
 =?utf-8?B?MWw3REdjUyt6ZlRyM3d5UzdoOHMxRCtENnBZSVpTNytKQUtVcnp5ckJOcnU5?=
 =?utf-8?B?WG1vS1FzYjF3TThhRjRSYkFBTVBnRDkrczU5c1YyaFJ3bnZSSVJOckhZdWd6?=
 =?utf-8?B?WlNRZjlHNDhBMVUyQmlsd1R2VElPeXdNd0d0bmVScVNFRVVpaDNyOTJROW5y?=
 =?utf-8?B?TWNUVnRWekxISDR1dnNGcXpSVU0vRDZKRWZ3MTZKWkdMMEdJY1UrOXY1Y2hx?=
 =?utf-8?B?Tm9SUFkwQnFRZnprMk0xNFdKWkNSZkIxWHk0M0l5WmlncjdKT3hNcXc1M0xm?=
 =?utf-8?B?eFc0Skk1a0gyVWhiQ3VNUE51Smg1bXp4OVlIa1NTMXRrRzZDVlVNeE9mMllR?=
 =?utf-8?B?TFVGRnZ0dFpaQ3pEK0oxSStieW9EMWN4SGxreGlGUStOcmMyVmZ2L0hRTUp6?=
 =?utf-8?B?M3cwd2FSODN1enNGMllIZlNONUdjVWZDbjR4WngzR3R4YnYzNGt2bi9JUVZG?=
 =?utf-8?B?SDRpQkVDeVlPV3JVUlQyb25weUh2VFg1VWM5VC9WdzJFelhzSEpGZ0Q4MnRF?=
 =?utf-8?B?NDQwTzQ4cHhONzdGa2ZuYXJOQjRTTTV6bDBaTzVwdlRKMzBJUHpBT1h1b3hU?=
 =?utf-8?B?cWNhbGZER1FuZXB4QWljU1ptSmRKV0U3WGRlbUxTSm96QlBjRVVvcGtsSVB1?=
 =?utf-8?B?dzIxTS9XVnArUDlHdEJYSjMxZjZhZ3Yxam51VjB4eGdwZjBzZnlkcjNNNnlT?=
 =?utf-8?B?VWd2anhrSW5vZU1zTFI0SGFUKzA0WUlvTTNyendmalJBenlqYmtYQi9CSlRp?=
 =?utf-8?B?LzRzWVV0RElFUlFUcDl1a1Ixc0I4K0J5Y25CY3FvRk5UcHY1VWFoOHk4Mnc0?=
 =?utf-8?B?STM2NXE3YW1vR3ovUEJ1bktvQVpmWldvWW9xampXUDBUb2dQZG43MFRXL0dR?=
 =?utf-8?B?eXZvK1BkSFRpbUdyUzQ3TWsyQ1ZEL1NMM002OWp3ZlFYY2lGZ2tRZWZWN3Jl?=
 =?utf-8?B?dnVBT3pCK1NWcVBNb3pqdi9Ka04xcW5oYWVlRk5kRlUxODVzMC9neVNhUFpp?=
 =?utf-8?B?UkJRS25oNUtWcko3Y29iSmUyYk9ZalVpU2JWeWZ1dVRSNHRMcXBWT1pFZm11?=
 =?utf-8?B?alVtdHBkbVpqNlI0ZTR4SExxRUhuT2V1dk5YdzdycDRodFBmL2ZTMHRoWCtT?=
 =?utf-8?B?RmZtU1lGaDd1SHB6TUJSNTEvMHk2ZFVLMlkzMElhWE1od2F1N1BxOGlGNHAw?=
 =?utf-8?B?TmJaSnJ3ZFg3UGl3K25PSGNRa0RnQzIzMHkzaE1DczdYNXBqYjdVZkkxa0VW?=
 =?utf-8?B?MGVFYlBkSHV3SktOTHpaZjJjeXVkZ21OeTVNSHlETkp0a09CbU5qT1Z4aHJY?=
 =?utf-8?B?d2Q0aEIxdFVsSkRaN3AzWkp2NGhYWnJkaG5hTm9sUGJUZzhMOElDS3lZWjgv?=
 =?utf-8?B?YmRnL1RDVW9tMDY4cVpEbS9LWktsbHUyVVh1MzV3RlRCTzNDaFpFdGgyb2s3?=
 =?utf-8?B?ZXhBZ3MwRWtSMjRGYXhsdEZnY1QxOWZkdzZ3Z0RMc2NvU0hCNVNzdTBLbEF0?=
 =?utf-8?B?d0RLekltQWdJbzcwR3F4ZGEzK2Q5aU1XMFplOGpzWVcvay80NUNId3pUcU4y?=
 =?utf-8?B?UWRtdmVTa0NUeFhzb2REcWxoT0wya0tiTVIrangzakJRdmFBSUFwYTZRMm1l?=
 =?utf-8?B?VU80alVzTzFaanZSMHQyT2xYWk11R0JDTkVaZE44TGtNQU54dzZDUzlvNDZP?=
 =?utf-8?B?Vjhhd3h1MWVoVnNOb09KVkFhUXR3alVQWVpDekVvK2xSc1p0NFBUajh1VFNQ?=
 =?utf-8?B?RDFWdVVtdWEySFc0bXkvUG9FRzdOTXZza0NPWVRaTVFsRjF6d01iZHNzQzUz?=
 =?utf-8?B?UUNZUks4Z0ZtYU9oYVpibU9EcUhHQWJDaUtRN0JtYy8xUGRSYUN0RmhkUTVD?=
 =?utf-8?B?ZjFud0tzSjU5MXFOWWRTdmZLTUJQazBPeVd0ZHpzRHVCRDYxT3JsM3BNaG9m?=
 =?utf-8?Q?qpC8jJIdWWUdMB6J2alzNxsX1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1ef9df-b90f-4b66-098c-08dafc2a2171
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2023 03:38:30.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFNJN/ryUP2FBrmkQRWd+/6gYfBeuFRdouCkm0gKOUE1ZoH1XhiqRUl1AMhF/2BqZQ+eMjHxm/uIsfDy9LeNfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBUaGUgeDg2IHN5c3JldF9yaXAgdGVzdCBoYXMgdGhlIGZvbGxvd2luZyBhc3NlcnRpb246
DQo+ID4+DQo+ID4+ICAgICAgICAgLyogUjExIGFuZCBFRkxBR1Mgc2hvdWxkIGFscmVhZHkgbWF0
Y2guICovDQo+ID4+ICAgICAgICAgYXNzZXJ0KGN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX0VG
TF0gPT0NCj4gPj4gICAgICAgICAgICAgICAgY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfUjEx
XSk7DQo+ID4+DQo+ID4+IFRoaXMgaXMgYmVpbmcgdGVzdGVkIHRvIGF2b2lkIGtlcm5lbCBzdGF0
ZSBsZWFrIGR1ZSB0byBzeXNyZXQgdnMNCj4gPj4gaXJldCwgYnV0IHRoYXQgb24gRlJFRCByMTEg
aXMgKmFsd2F5cyogcHJlc2VydmVkLCBhbmQgdGhlIHRlc3QganVzdCBmYWlscy4NCj4gPg0KPiA+
TGV0J3MgZmlndXJlIG91dCB0aGUgcmVhc29uIHRoYXQgRlJFRCBhY3RzIGRpZmZlcmVudGx5LCBm
aXJzdC4gIFJpZ2h0DQo+ID5ub3csIHRoZSBTRE0gc2F5czoNCj4gPg0KPiA+CVNZU0NBTEwgYWxz
byBzYXZlcyBSRkxBR1MgaW50byBSMTENCj4gPg0KPiA+c28gdGhhdCBiZWhhdmlvciBvZiBTWVND
QUxMIF9sb29rc18gYXJjaGl0ZWN0dXJhbCB0byBtZS4gIFdhcyB0aGlzDQo+ID5jaGFuZ2UgaW4g
U1lTQ0FMTCBiZWhhdmlvciB3aXRoIEZSRUQgaW50ZW50aW9uYWw/DQo+ID4NCj4gPklmIG5vdCBp
bnRlbnRpb25hbCwgaXQgbWlnaHQgYmUgc29tZXRoaW5nIHRoYXQgY2FuIHN0aWxsIGJlIGZpeGVk
LiAgSWYNCj4gPml0IGlzIGludGVudGlvbmFsIGFuZCBpcyBnb2luZyB0byBiZSB3aXRoIHVzIGZv
ciBhIHdoaWxlIHdlIGhhdmUgYSBmZXcNCj4gPm9wdGlvbnMuICBJZiB1c2Vyc3BhY2UgaXMgX3Jl
YWxseV8gZGVwZW5kaW5nIG9uIHRoaXMgYmVoYXZpb3IsIHdlIGNvdWxkDQo+ID5qdXN0IGNsb2Ji
ZXIgcjExIG91cnNlbHZlcyBpbiB0aGUgRlJFRCBlbnRyeSBwYXRoLiAgSWYgbm90LCB3ZSBjYW4N
Cj4gPnJlbW92ZSB0aGUgYXNzZXJ0aW9uIGluIHRoZSBzZWxmdGVzdC4NCj4gDQo+IFdlIGNhbid0
IGNsb2JiZXIgaXQgaW4gdGhlIEZSRUQgZW50cnkgcGF0aCwgc2luY2UgaXQgaXMgY29tbW9uIGZv
ciBhbGwgZXZlbnRzLCBidXQgd2UNCj4gY291bGQgZG8gaXQgaW4gdGhlIHN5c2NhbGwgZGlzcGF0
Y2guDQoNClllcywgYWRkaW5nICJyZWdzLT5yMTEgPSByZWdzLT5mbGFncyIgaW4gdGhlIFNZU0NB
TEwgZGlzcGF0Y2ggZG9lcyBtYWtlDQp0aGUgdGVzdCBwYXNzLg0KDQo+IA0KPiBIb3dldmVyLCBp
dCBkb2Vzbid0IHNlZW0gdG8gbWFrZSBzZW5zZSB0byBkbyBzbyB0byBtZS4gVGhlIGN1cnJlbnQg
YmVoYXZpb3IgaXMNCj4gbXVjaCBtb3JlIG9mIGFuIGFydGlmYWN0IHRoYW4gZGVzaXJlZCBiZWhh
dmlvci4NCg0KV2Uga2luZCBvZiBoYXZlIGFuIGFncmVlbWVudCB0aGF0ICVyMTEgPSAlZmxhZ3Mg
YWZ0ZXIgcmV0dXJuaW5nIGZyb20gdGhlIGtlcm5lbC4NCg0KQW5kIHRoZSBxdWVzdGlvbiBpcywg
aXMgaXQgd2hhdCB3ZSB3YW50Pw0K
