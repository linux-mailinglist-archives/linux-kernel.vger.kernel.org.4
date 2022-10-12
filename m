Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DCD5FCAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJLSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJLSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:38:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9941B6F544
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665599927; x=1697135927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+U0DCemtPalFsRl5XXaVvICTER61I2EGxNedzM2y0vU=;
  b=PukZ0DN08XYX8+Ho0OM2QSIjtXfBa3yJvZ3o0CG70h/F8yUBZXPVE9oO
   5aNDEnM89GXxiqpHrk/U/+HEfNFQt0gDjOuXd2Pkevlc5jY0TZvuxSwFt
   gdBNVkiKj9MNMixdmce4/TxKljIiw61T9gIC2yfGrrE5gB+YbrycmGbbY
   Ehtyhi1+httnhJJhdL1mlA0fZ221BVOFuLvSyb4IF73zFCViXn4XlrKXo
   0S0MvO97ny+EpkN9gKS2UJ2JDqSbXXexT6P3DS2deXaJ0NS5fDyTvYeXH
   dy2l9TTMXW8Q3l8cATIo6RXUxuCPqHA0MtJ3BmDdTOmjuZnpVGwjsbe57
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="303617336"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="303617336"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 11:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="752230918"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="752230918"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2022 11:38:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 11:38:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 11:38:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 11:38:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 11:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxvGH1i0Pvtb6DvVtgR9KHd7wE/xQVOBndcaVFW+6f0WvRxEWMq1CtNwJ7HbEUW6nq9FVVJLYG06BU0gBogDz7o/OqER1+R4bSoPEl0GB7cZYzsdae5H76Tkoj/Q9j/bErN1h3Utc6aPeONR0P7jPVCT+tVpyEeewq3xNC9fRCTJEZwVhW41mXJvkDNQpcVN+IpvelZT5z6PO7uNCXpRtUSDKr5ifpVVFFgd6MDVpEzr92TZPX/2QrfWb5O8iOiyDxpEQiaAGHG0yrNhigGoH4m3h3GesclUmG2fZC6eQ8NNUKdmKsMxH6gNsfWtjWUP6FopFvBH7a/4qCIjk6+KbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U0DCemtPalFsRl5XXaVvICTER61I2EGxNedzM2y0vU=;
 b=ZO4cYr5kn1P6K9yETBFAgbBCQwuWbEMeto1KfWe0UPA99k2jtjUQxojlseZDz5NBzZOReSG43D6epny00N+jS8N7PEun2oEm/kgnROh574gho+4jg18r6P4ljqmGJRo1zatsyO8f/nEgak+DuNxwZni0iW9RHVVNajz8kW8CKKy6CHyYdvpTVYAq2Q+1iBc9cTjE+DRDhVTnQrp58jzHZ2TMuMeX2PFq2sF6ysfbRxjjoOmvDm6hODs3e1E8tT4uZZ0jjO9TZULyXe4mx0LukXvvoXu5483XMBhMf3sLBKtGUakZKcTZtIOemXsaM6hdYEDoP1ltYCLNoKoOHkZG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 18:38:43 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 18:38:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "songliubraving@meta.com" <songliubraving@meta.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Topic: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Index: AQHY2qcSuA+QF3WN10KzhnOoNUAfaa4H9+yAgAAKP4CAABD5AIABU8+AgABHQ4CAAJX7gIAA2jUA
Date:   Wed, 12 Oct 2022 18:38:42 +0000
Message-ID: <6fb1ef25df1caa7206572f24a70da0c2f2714135.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-5-song@kernel.org>
         <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
         <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
         <3842f1e7cfdde4f848e164872f62c0c1da654fec.camel@intel.com>
         <2B66E2E7-7D32-418C-9DFD-1E17180300B4@fb.com>
         <99201f0c3509e1ea3d08a462beaaea9d60382cff.camel@intel.com>
         <0D4668C5-28C1-4846-9698-C5C05BC23F0B@fb.com>
In-Reply-To: <0D4668C5-28C1-4846-9698-C5C05BC23F0B@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN9PR11MB5370:EE_
x-ms-office365-filtering-correlation-id: 6b606a5f-3f95-46a3-936a-08daac80fd0f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRvp4v+BbcLARwuqlCq1XXUemB6Qfo+orCxp6vsprMFVIOOi7sJVUnOFFC63ndWHYi7XPKMOLnVzeWxdG3o6cJ/Gkk37J6PqQFxmMaER9TyoybVORfeYf7PBOVy41vglfFAugrtwM3n2Y+9J1eAKGHyb4v1CGyRt8UGWA0UgSwYnv2x/aBIyLCabRUdv8G10OUa90e272LB3ch71lsINGyJDBkITx7d0eF0KxR+6+2T0Hxk2kKXSiqVJDfYe1DbmVC2j1w70i6k8UaDcq5MuYel0j/do64emabQu70G6/MoRxUH/wmHVICEAn0AZKCN5uPZa2i4XrpkRJEUX/J8peord9ZS787+G0Xl/dH5+obV2a/b+4LDWuMIlvARlZM75N2Q65AhG9r50g2b+Yawr/ue2YRJGXKgW5KFUd5JAVOOIi9w85XYSQwXYMPc8N10Gon+9y6kBf/XTEh6mLjvMj6fv22/Np01wo7sHaRK7xDieNJH0X6PxNgOMHUKYX2wxrGQZiYcYKHVp4xwSeohuPlpYoYI/rqraI7FrE1ZAaOiNWaYL/LKYQvOIaPIlhY619QaemADD3OFmRv8HVNG3+UbvzGcQTSABhpNgR3AAShRkdTB935UZsTW3TZXDWraSArnsfZdqGFXURm9cf/04kvBIyD9p16bvCvMvsLUlIX81O5HaH7ngzWtuXIVf1y5QR7HBTEW47JJaYLkcy8veSkQza858Uiye0dfRBWCx0P6/kBCSmYnpKktE8Wa4LbjUjFYXAnqHdj/VPl9rnxuggL1No42B0KHVziWbiXcjcD5+NY3qQfIdE4fu4hDkm8nN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(41300700001)(36756003)(76116006)(2616005)(26005)(91956017)(6506007)(71200400001)(6486002)(66946007)(122000001)(66556008)(66476007)(66446008)(64756008)(478600001)(8676002)(4326008)(38100700002)(86362001)(6512007)(82960400001)(38070700005)(186003)(83380400001)(8936002)(5660300002)(7416002)(6916009)(316002)(54906003)(2906002)(4001150100001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2dJYkt2U1dIa2tQN0grUVlONjZzL1E1MnNZLzdpQUxoaHllMHg4NHBJR0ZT?=
 =?utf-8?B?dEVoQ0VrdXVnUzNzaWh1S0VDanRGR0h1NFRMcmF1VExTREdXSDNjZEJmVFlR?=
 =?utf-8?B?d2RMOHV2bGh3TXVPM2hlb3Q0QnFOUjdKTWdwYVMzbENRR1VrdnpRMXdiR3F5?=
 =?utf-8?B?UHFZMitVRHZDUDhobnI3UnhMZ2p0WUkzMWVPcitGWGVacWh2UlExb2xTRGJz?=
 =?utf-8?B?dEcxbEFPUDZmSFhSQnpuNEJ3Uzl0VmxHRVN2K2kwb09TZC9nb3phczhPSnVM?=
 =?utf-8?B?SjlVR3FiYTVHYWRYUS9tUHJRN0xPWFJYQ1NESGFkTmkrWFJRQy84cDRjbFZx?=
 =?utf-8?B?Q0hEM3NLOFJwcUo2QXRqKzlxVE5rS3ltKzIrQTRIcTlNNy9STnBGTHpWQWFE?=
 =?utf-8?B?NTBVWUkxZ3Y1Sy9wYTBod1pndkM1RmRXbUxMOVBqTk9KZU8xaGtQYTNnKzVi?=
 =?utf-8?B?R0ZVdnhKemsxRktMYmRLbkV0eVRFclMvTElCODhobnJRemd5YXAzRURuYk5F?=
 =?utf-8?B?dXRMWGNGOFlQbEYrOWhqMjVoQmZLSDJPSlpNL2YraGRtY3dwZ2V6QjNrTFhD?=
 =?utf-8?B?Y2VJNmdzUXg4U1Z1ajhUb0JOUE1mSTYrVWR0b1FEd043aHdya2IvRUJtT1Vl?=
 =?utf-8?B?dy9XMktaakF4c1I2Nmd0QjlwTFpPYVBnNEdQUkc2TkllUmJPN3pWM3dnWTFE?=
 =?utf-8?B?cDVpejBuczNub0FneVpnVVdCejVxWWdtRkhUOWNzbkpHK1dJU2hIVmQxaUpW?=
 =?utf-8?B?TGRQbmpGMVNJRVdZYnhGdVdJOGwyTmVHOG5KZUlibUNNYnRvOFBEMWt2WTNp?=
 =?utf-8?B?VlFwMkRtQ1lPcmQ2ellhaGtGSGlyTzBKQTlLUDhmNER4QlNpRTMrSHluSWhP?=
 =?utf-8?B?NHlmVXA3NTZHdFlZaWFWL1NISGJHczhvYTkzZWt3VUo2b0tSaTZVVUtvWG9t?=
 =?utf-8?B?bmVCclRQZjhSS2NKRFVId0hONnBVTzFYQXRLbkJqUElXZDJmS1JqV1JCVjhj?=
 =?utf-8?B?R25uTXVUQ3NJN1dLLy9QSVFkNlRNRnlSRi9uSHpYeHBYS2oyOEg2VU9Yd01Q?=
 =?utf-8?B?T1ZCVWZWUVVkWDJxamg3Wld0bHkwc0xqTGlGR3hPZ2FYWnNwVUNZY3lpMW1P?=
 =?utf-8?B?bktnNXFmTmhnQ3RlL1FWTE5YTjIwNzkzWjVLWUJXZ09TTmJXQlhMaHFPMG0v?=
 =?utf-8?B?dHNaU1owWHdodDc0UVJHSFJSTDVvb3prUElhWUJuMmhuaURjK2FuQXQ3M3Vq?=
 =?utf-8?B?UXY2Ti9zbzUrVjZ2WnFmdkxsWVZZWXFwZnU2aStRMExYOFJKSGlFMzREdndW?=
 =?utf-8?B?cm54WldRR0YxQmJPYjBNUm9WR1BaeTQ0bDJabmoyNlppcTNhZnZWU1cvVGIr?=
 =?utf-8?B?ZXdpazc5MFVKWDQxc0JSV01JZXpreXEweWt3M0NxWUszUVV3a1JkVFBCbWtS?=
 =?utf-8?B?RlNzZWZVUDduN3NJS0M2bVR4bjhEQXdmeCthUDVmSEtCVXovVGFNaVhiSEFQ?=
 =?utf-8?B?V2hZdzU5K1NFeHE1VnU1d3MxTHFzTE42YjdsSjc0Y2plUHhTVW1VOG9tRGNF?=
 =?utf-8?B?Z2xmRkVzZHk5MkM3WCtFQnFnYVVLTEhjbXljQjd6R2RzZGJ0dkNqK0VvZmNV?=
 =?utf-8?B?M1pDWnc5ZnVkMUg1aFc1WURMY21IZnRSUFVseFUrMGQ3bTcyaXpZcG1GQVhv?=
 =?utf-8?B?d0hrOUFzRkZ0YU9od0RNcVhHMUwxbFM4ZnQ1TlVGaFl1YlhidGlHM3pkY3Jy?=
 =?utf-8?B?dGpKdzcvSFF1WEUvaUlVcWFLczYrNkZFYUpGQ3ZVaEN2WWdqcXJVVEVZaUxw?=
 =?utf-8?B?TnJDbmdBcUhqSVE3Z2RoY2VqTW1JcWFML0ZhL3ljU2hIVWRneDZrU3c0TGJT?=
 =?utf-8?B?TEJyZUtZbDNycDdXSUhqR3Q2TjhIaDFzenVyUG1IMlhEaGhEK0tQVWE1VW5X?=
 =?utf-8?B?djhGNmV6dkhTWG9FVjA0akE5L3B0cWxXbXJYYnAwU3NzSGtXL3JQYlJ3NUs2?=
 =?utf-8?B?RCtVbDhXTkZCaWhtbmRSdTJrb3VFQ2JDNXJ0WGFnWXFPKzV6bXl4cjljMlBQ?=
 =?utf-8?B?Z3BFLzk1K2liTUhGQmR4WGFVLytTOFVzc0N2Njhtb1Q1eGs2R0NOam8zeGhK?=
 =?utf-8?B?N042M1FnQi8wVjAveGVodXRRM1dMVWc4ankwN2hFM3J4U2Z5ejlMS2ZmVnJQ?=
 =?utf-8?Q?gfdiBxbnk4fXSiU0hBEb//0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C4D2945A101E240BD79E9C826121592@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b606a5f-3f95-46a3-936a-08daac80fd0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 18:38:42.7325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HJrXqnBU6hrXHAiZ8Mmc7mIJlR4Bv1+MfCPW4hsRx/cuUmfvjtjYCAg53JXAjREEUkaN0GFnYJ10vKnUpMgaAurfMQ3E+8U381IQ+Jr0dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5370
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTEyIGF0IDA1OjM3ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gPiBU
aGVuIHlvdSBoYXZlIGNvZGUgdGhhdCBvcGVyYXRlcyBvbiBtb2R1bGUgdGV4dCBsaWtlOg0KPiA+
IGlmIChpc192bWFsbG9jX29yX21vZHVsZV9hZGRyKGFkZHIpKQ0KPiA+ICAgICAgICBwZm4gPSB2
bWFsbG9jX3RvX3BmbihhZGRyKTsNCj4gPiANCj4gPiBJdCBsb29rcyBsaWtlIGl0IHdvdWxkIHdv
cmsgKG9uIHg4NiBhdCBsZWFzdCkuIFNob3VsZCBpdCBiZQ0KPiA+IGV4cGVjdGVkDQo+ID4gdG8/
DQo+ID4gDQo+ID4gRXNwZWNpYWxseSBhZnRlciB0aGlzIHBhdGNoLCB3aGVyZSB0aGVyZSBpcyBt
ZW1vcnkgdGhhdCBpc24ndCBldmVuDQo+ID4gdHJhY2tlZCBieSB0aGUgb3JpZ2luYWwgdm1hcF9h
cmVhIHRyZWVzLCBpdCBpcyBwcmV0dHkgbXVjaCBhDQo+ID4gc2VwYXJhdGUNCj4gPiBhbGxvY2F0
b3IuIFNvIEkgdGhpbmsgaXQgbWlnaHQgYmUgbmljZSB0byBzcGVsbCBvdXQgd2hpY2ggb3RoZXIN
Cj4gPiB2bWFsbG9jDQo+ID4gQVBJcyB3b3JrIHdpdGggdGhlc2UgbmV3IGZ1bmN0aW9ucyBzaW5j
ZSB0aGV5IGFyZSBuYW1lZCAidm1hbGxvYyIuDQo+ID4gTWF5YmUganVzdCBzYXkgbm9uZSBvZiB0
aGVtIGRvLg0KPiANCj4gSSBndWVzcyBpdCBpcyBmYWlyIHRvIGNhbGwgdGhpcyBhIHNlcGFyYXRl
IGFsbG9jYXRvci4gTWF5YmUgDQo+IHZtYWxsb2NfZXhlYyBpcyBub3QgdGhlIHJpZ2h0IG5hbWU/
IEkgZG8gdGhpbmsgdGhpcyBpcyB0aGUgYmVzdCANCj4gd2F5IHRvIGJ1aWxkIGFuIGFsbG9jYXRv
ciB3aXRoIHZtYXAgdHJlZSBsb2dpYy4gDQoNClllYSwgSSBkb24ndCBrbm93IGFib3V0IHRoZSBu
YW1lLiBJIHRoaW5rIHNvbWVvbmUgZWxzZSBzdWdnZXN0ZWQgaXQNCnNwZWNpZmljYWxseSwgcmln
aHQ/DQoNCkkgaGFkIGNhbGxlZCBtaW5lIHBlcm1fYWxsb2MoKSBzbyBpdCBjb3VsZCBhbHNvIGhh
bmRsZSByZWFkLW9ubHkgYW5kDQpvdGhlciBwZXJtaXNzaW9ucy4gSWYgeW91IGtlZXAgdm1hbGxv
Y19leGVjKCkgaXQgbmVlZHMgc29tZSBiaWcNCmNvbW1lbnRzIGFib3V0IHdoaWNoIEFQSXMgY2Fu
IHdvcmsgd2l0aCBpdCwgYW5kIGFuIGF1ZGl0IG9mIHRoZQ0KZXhpc3RpbmcgY29kZSB0aGF0IHdv
cmtzIG9uIG1vZHVsZSBhbmQgSklUIHRleHQuDQoNCj4gDQo+ID4gDQo+ID4gDQo+ID4gU2VwYXJh
dGUgZnJvbSB0aGF0LCBJIGd1ZXNzIHlvdSBhcmUgcGxhbm5pbmcgdG8gbWFrZSB0aGlzIGxpbWl0
ZWQNCj4gPiB0bw0KPiA+IGNlcnRhaW4gYXJjaGl0ZWN0dXJlcz8gSXQgbWlnaHQgYmUgYmV0dGVy
IHRvIHB1dCBsb2dpYyB3aXRoDQo+ID4gYXNzdW1wdGlvbnMNCj4gPiBhYm91dCB4ODYgYm9vdCB0
aW1lIHBhZ2UgdGFibGUgZGV0YWlscyBpbnNpZGUgYXJjaC94ODYgc29tZXdoZXJlLg0KPiANCj4g
WWVzLCB0aGUgYXJjaGl0ZWN0dXJlIG5lZWQgc29tZSB0ZXh0X3Bva2UgbWVjaGFuaXNtIHRvIHVz
ZSB0aGlzLiANCg0KSXQgYWxzbyBkZXBlbmRzIG9uIHRoZSBzcGFjZSBiZXR3ZWVuIF9ldGV4dCBh
bmQgdGhlIFBNRCBhbGlnbmVkIF9ldGV4dA0KdG8gYmUgcHJlc2VudCBhbmQgbm90IGdldCB1c2Vk
IGJ5IGFueXRoaW5nIGVsc2UuIEZvciBvdGhlcg0KYXJjaGl0ZWN0dXJlcywgdGhlcmUgbWlnaHQg
YmUgcm9kYXRhIHRoZXJlIG9yIG90aGVyIHRoaW5ncy4NCg0KPiBPbiBCUEYgc2lkZSwgeDg2XzY0
IGNhbGxzIHRoaXMgZGlyZWN0bHkgZnJvbSBhcmNoIGNvZGUgKGppdCBlbmdpbmUpLCANCj4gc28g
aXQgaXMgbW9zdGx5IGNvdmVyZWQuIEZvciBtb2R1bGVzLCB3ZSBuZWVkIHRvIGhhbmRsZSB0aGlz
IGJldHRlci4gDQoNClRoYXQgb2xkIFJGQyBoYXMgc29tZSBpZGVhcyBhcm91bmQgdGhpcy4gSSBr
aW5kIG9mIGxpa2UgeW91cg0KaW5jcmVtZW50YWwgYXBwcm9hY2ggdGhvdWdoLiBUbyBtZSBpdCBz
ZWVtcyB0byBiZSBtb3ZpbmcgaW4gdGhlIHJpZ2h0DQpkaXJlY3Rpb24uDQo=
