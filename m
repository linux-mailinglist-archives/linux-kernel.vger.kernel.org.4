Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77496F9524
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjEGAKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:10:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E9417FC3
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 17:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683418234; x=1714954234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iojOI4NZBwQi+4OhtsMHfK6Rh+yIuYdPfA6DNkiA9NQ=;
  b=RxDt+u1JfQ2C2RuyCU92yQOBw4de6/PevRjUO/H6YhRLb0QmAM3FDppX
   wJYlm2Xe+nGDVOQl7aiYqLAtx7qUhOY4CliDiLOjCSM5I4AmxRnuh4Nye
   VQnut0mr1wPEwbmWdJqW3NC/VlQyhJLX7kPjiOMGYFw26162YbJ6wze99
   5u9WZyYM3X3oYGjdwmc5ywgl5dXqoMOe6weFT7Bk9jIvHcLk8aEOYDqNV
   efMhjhkPX+X2B5tiV3lg/qOMXD/4NWGF3mJohGVZuGsmKyk394dAQnQa/
   IJwTBcov5E6cND3YOUgnpTXvDD+ihBTYLm4jHvP4s0rlaim/419LPPQPb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="351583068"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="351583068"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 17:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="728597768"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="728597768"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2023 17:10:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 17:10:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 17:10:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 6 May 2023 17:10:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 6 May 2023 17:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWFZkNPJUa1Xlp+8pt+S6d2vr1PzoL5RPPFES4+SKOChZ/mYyDdJfOU7YhCGaXbCSzIaQRokPncXki6b2sEc1QuOo83kNICCm6ekLHf9e3/kGrMefcB0cm0mzpnMz/QJkd207Nf/Hd3ymZ2wPL9fuRFi1oRUBSg2VfCgLPyEcbXCnF1cIMFXGlzh6iBUIwgGg5/MZ+4Q7+5VF2CJd1VT/XbTqhTg6EKZfJ012xSP5ffinNjN0ysjpNR/RDowRAzzZjejsLjbGeTFXO1ZNmwDAZKcOKg795OsjGfBNHPEQNpY8ikRLHMe/hF5774JfSZEkfjiCygwn3W9L7OpEBtAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iojOI4NZBwQi+4OhtsMHfK6Rh+yIuYdPfA6DNkiA9NQ=;
 b=oZhS0LcTRJosxC1tp1mR3AvDwVSJ4v8wJdZKTf7gkGfA+OhI/UQyqPzJUzdv2ORa4ySbVG2+bLHqQAn/sQ4f+xtDUlTUN7l7dhTjgJw/OxYnU17rKgi5mhqNO2LhGk3hnS2JG3TfQ1i01bDT/8b/aZC0l9G08eGEaqCWR1b+VGiQDjm3WCkJ5wbr9chS620R5UBLJuWIfLXU1v0RFh4VTUIqy3wpu+j/a0DPZtPqY8h9rVRPxkQHwhmyo86xfsrUgR8/JtDN0XMwLfFi9ZSpbD0BHEJpnVdTPY9NwHo2IF8hKTtW02h7BMhtwMD0rPPOTo4XTx68GjY9eKHKxDctZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sun, 7 May
 2023 00:10:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6363.029; Sun, 7 May 2023
 00:10:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [GIT PULL] x86/shstk for 6.4
Thread-Topic: [GIT PULL] x86/shstk for 6.4
Thread-Index: AQHZdvLFwdOoBiNv3EeiRW4XzF36M69BDVuAgABnQwCAAAPJgIAMPVyAgABM/wA=
Date:   Sun, 7 May 2023 00:10:29 +0000
Message-ID: <ad5b44e17c1c17ebdc581169fec7e80f7ef2a4d4.camel@intel.com>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
         <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
         <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
         <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
         <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7611:EE_
x-ms-office365-filtering-correlation-id: 3675e471-30b3-4711-f4f1-08db4e8f7750
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRVzTgqrUIw0ealOmgfo1zQS4dNwfYaZQhq1qbzmr5CcyfvJIk/NCx0Er48CbgHQWlMYbMczGSppDo8e78i0E7SmZK8s4wJG7GtA4TcpIQGpkXtcvW8jgFM92pk8Exlbd4Y3Tsn3ZFXmUPcSzOoi/Ne5L5K8IRduTYYeEKZB4UqkGmo4HPZpnYs7taF5JPu080G1H7wCvdNdDJbAui/s+5aJuTbErmP/Am4Trc+q2KlmWdPQFeIdPVCLsM724z2xBiHACWwOCGdqAFEyzsj69jJceC8YwS3QIhXEgfDUFWl65e7ePr1DahSaKRqCB5D/n9hKZ0X445H6W2q7PIXhCeOGfk8E57tphFGpYGBWWaPKyT+V1jU5t5rmODTsrTTXcbKJd5iN5RhjiCcBcfe3knncUml0r9bbXKKyKxiuislPWrR0Msr0idKygkY+iSruViqBBER6TmATQ1X36nljgcx8bFgbba+F66rjFGnP+Uppn/ZJ7pekRn/PUzeLrgaxUbkLRUC7z9D+SsbnJa4bCKOA0M2mtuP3sAQrU+rvGda8Ts/YZ1HqfWcWmsYqIBx92E2+3bZlu9hI+w8ifrZLApCIgj3/uKDqO2zf9otPFZRyJLerjPDBYJokbzxaclTM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(86362001)(38070700005)(41300700001)(478600001)(91956017)(76116006)(66946007)(64756008)(4326008)(6636002)(66446008)(66556008)(66476007)(122000001)(54906003)(110136005)(36756003)(2616005)(83380400001)(316002)(2906002)(6486002)(82960400001)(38100700002)(71200400001)(186003)(8676002)(8936002)(6512007)(26005)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm0xOTVvSHRjTGwvSlQ3VFhLSmpjc0RtYllUZkxxMUtxdXg3RTNVR2JTRlFI?=
 =?utf-8?B?Z3ZVYWhFdDIyVzhRR3Naa1IzOUlaaG9OTzdWbXR2S1RmcHZqc092TkJGd0hE?=
 =?utf-8?B?cS9sRExnWmFPTjFKYVJHbGFXN240MWFFYjZ5dTJKSTcrYkFKMk81WFdIVVR2?=
 =?utf-8?B?anN1TEh5OCtaZGVydTJMRmhzejlTRWtYcm5va3d3QVRjUTRLUzUvOTlDMXp4?=
 =?utf-8?B?R1pSY1VWZnAwWGE3NjJTRVQ4UzVScUhDS25EdjRDcnZFV204eXhWWEk5eFEy?=
 =?utf-8?B?dU1ORnZzd2gvRUxoaU54UTAzUDNqZkZqQkViWUZvV1FKcTlzaDNoRFRBUmNj?=
 =?utf-8?B?Y1lFYm5JMG9YMmFqTkhLRjZWU3JGbmdyd1llem5vaSsvcUFZdzQyeWRuNHF1?=
 =?utf-8?B?VFNsUHMrWnlUS1lQK1lqVUJJKzR3RXZvamdYYkNFbXhYbzhzTWJRc3d3OTVF?=
 =?utf-8?B?aWo1cWJzSkZ1UXBzMHIxMURmR2ZBbzFBK1pWRi9kWjZlOENmRkdNb0szK1N2?=
 =?utf-8?B?VE5OU1RJSkFFTURudzFtVzRDcmtXRHFJN3BkeDYyTmNSZ010OWRGODNFL0dH?=
 =?utf-8?B?YkVvVk81Tm4zLzk1Wjk5QitPaHhiV2hwNTZNcDJ5bi9pK2R0YzljcXUwQUMw?=
 =?utf-8?B?YVZyUE90ZXc5U2ZxU0drSTg2KzgrU094ZGlTbnFIeXhaVUhRajRPYUo5UGE5?=
 =?utf-8?B?WnI0akVmZjFwWlJzUWpEN010WW4vK1ZnWlFMWWkwbGVZTUlsdWpLNkVUZUpK?=
 =?utf-8?B?L3RHVGphdzVGdmFWNnlpZUJYUmpZM05SU0RmTTBlZU1RRXU5bHhiTEFBY2E4?=
 =?utf-8?B?cU9uVUZqa3UvWHhvQUJhL0FvOGdSYW5CekJkYXdvSFZyR2lTcGUvbUxFOVd0?=
 =?utf-8?B?YUJmU1o0M3EvcWdBTXRhbThCVzZSTDBoaUV2Vnh6UUZ5bWtGV3lwTi90RnhT?=
 =?utf-8?B?TUU4bVowUExpSVA5NjJVUi82WDFEOExWODJjdlJSbWhiOTZxT1czR1JSc1Zj?=
 =?utf-8?B?eGd1SEFITXFBSWlaR1BzR1pKZ1lnSHJoanM5dVo4UVdpWGJrbzAwMVdYMHZW?=
 =?utf-8?B?WGxMeElBZmZJbGJub1JYbzFhRk83RlZUSnZVWkhvOEpLVGxUL2JaUTFNZkJE?=
 =?utf-8?B?bmN4RGZEbjdUaEtxUjBrMFIzZDJnTmNNUjA5M1AxQzROYkVkeHVwUzJGZHdZ?=
 =?utf-8?B?T2poZHNSNEpkQ2NsenBhMk4zMGhTMjhuU3M1WTRxdENCY1hjT21Za0FPOWg0?=
 =?utf-8?B?SWxkb2l4REhYRkp4SnhjOHRnSm9Hc3BBb2J2dUhSZkZ0aTR4NzdYc2pCRlk3?=
 =?utf-8?B?cnQxVS9xU1B3c0lzdERESTFDdmVZS09GZWEwR3UwMUpmR0JXSFFVRUFnSTVR?=
 =?utf-8?B?blpwNnZLdmp3STRnRnk4cENhYThuRnluY0hHY2VoeXV3L0hVNDVKYTg5anFm?=
 =?utf-8?B?TzM0aVNqR1hPSTRrWW5MaE5EMXJkV0RJN2x2ZUg2R2QvQStWdEFjRVh1Mzhl?=
 =?utf-8?B?MktzQ2gybTJDVWh1bldhWVhnOGFCZm9CUHk3cHI3VGVERDg2SU93cE01QVl6?=
 =?utf-8?B?VXFBWmtYaUNVL0VHOCt1K1B2M25nS2dGM0xJWklUUy9aOVRJVS9pMWtMZTl1?=
 =?utf-8?B?aUt2ZVNFZXdldituNmVsRitaYllFVk5vNEtEbnRtSTNQRWY1eTE5YXMvaHdj?=
 =?utf-8?B?eUtZTThqZUUvZXkxZEcrZzVOMDlVNWhNZ1picVFFSDg1M1ByU0JFYnJPQWRV?=
 =?utf-8?B?ci8yVVh5NjRoTEkvVnRuQkRtYmpPejVjdGFraWpaWnpuenhvbDhia29mS3hj?=
 =?utf-8?B?K3E4WGU5Mzd1K2Z1RUZsN2gzUjJZSGljbiswRjk5K1RkMVVEWFlnWXY2QUEz?=
 =?utf-8?B?TitteERCR1BtdHhTRlFveVFRQUdLRmhUMUVJb0t0bFBzMVpnczd1Nmg2ejgx?=
 =?utf-8?B?Tm9oYnlpRjBMOEhIYlhabkJHcWxONXVLRzYyYWpnKy80dzJCZTBJQ2s2ak1I?=
 =?utf-8?B?am1BeUIrdk1iKzBtR2hzK0xiSWU4TTNLc0JLQW1DRlNBUWtZcHhKb1NqbjVH?=
 =?utf-8?B?L3ZRWkg4Um9QbzIycXhhNlcrcklkamE2dXRmbTBZRTNvVjM5a29uM3gzQStT?=
 =?utf-8?B?K0d0UmR4WjV2SjhLRXV6UDVYK3R6ZGo3RXJGam1WRUxqM3RCYS9PRG1PRGE0?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A2CB24DCBEEC3459201066D8CA6590F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3675e471-30b3-4711-f4f1-08db4e8f7750
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 00:10:29.1856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjYWTwxFIwECplYlbaBI0TGRYXIt8MVUuJWHuwa30W2Wdc/o4B1K34QdeuMCrd+GLw6mbBdOfHYfG+lzCHFBB/rhT8jhSohojBRfpa+pYjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA1LTA2IGF0IDEyOjM0IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gPiA+ID4gRW5kIHJlc3VsdDogYWxsIHRob3NlIGFyY2hpdGVjdHVyZXMgdGhhdCBkbyAqbm90
KiB3YW50IHRoZSB2bWENCj4gPiA+ID4gYXJndW1lbnQgZG9uJ3QgbmVlZCB0byBkbyBhbnkgZXh0
cmEgd29yaywgYW5kIHRoZXkganVzdA0KPiA+ID4gPiBpbXBsZW1lbnQgPiA+IHRoZQ0KPiA+ID4g
PiBvbGQgdmVyc2lvbiwgYW5kIHRoZSBvbmx5IHRoaW5nIHRoYXQgaGFwcGVuZWQgd2FzIHRoYXQg
aXQgd2FzID4NCj4gPiA+ID4gPiA+IHJlbmFtZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBCZWNhdXNl
IEkgcmVhbGx5IGRvbid0IHdhbnQgdG8gcHVsbCB0aGlzIHNlcmllcyBhcy1pcywgd2hlbiBJDQo+
ID4gPiA+IGZvdW5kDQo+ID4gPiA+IHdoYXQgbG9va3MgbGlrZSBhICJ0aGlzIGJyb2tlIGFuIGFy
Y2hpdGVjdHVyZSB0aGF0IERPRVMgTk9UDQo+ID4gPiA+IEVWRU4gPiA+ID4gQ0FSRSINCj4gPiA+
ID4gYnVnIGluIHRoZSBzZXJpZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBBbmQgeWVzLCBteSBiYWQg
Zm9yIG5vdCBnZXR0aW5nIHRvIHRoaXMgZWFybGllciB0byBub3RpY2UgdGhpcy4NCj4gPiA+ID4g
DQo+ID4gPiA+IE9yIGFsdGVybmF0aXZlbHkgLSB5b3VyIGJhZCBmb3Igbm90IGdvaW5nIHRocm91
Z2ggdGhpcyB3aXRoIGENCj4gPiA+ID4gZmluZQ0KPiA+ID4gPiBjb21iIGxpa2UgSSBzdGFydGVk
IGRvaW5nLg0KDQpPb2YsIHllcyB0aGF0IGRlZmluaXRlbHkgbG9va3MgbGlrZSBhIGJ1Zy4gWWVz
LCB0aGUgaWZkZWYgc29sdXRpb24NCndvdWxkIGJlIGEgbGVzcyBlcnJvciBwcm9uZSB3YXkgdG8g
cHVsbCBvZmYgdGhlIGFkZGl0aW9uIG9mIHRoZSBWTUEuIA0KDQpJIHRoaW5rIEkgZGlkIHRyeSBz
b21ldGhpbmcgbGlrZSB5b3VyIHN1Z2dlc3Rpb24gZHVyaW5nIGRldmVsb3BtZW50LiBNeQ0KKG1h
eWJlIG1pc2d1aWRlZCkgY29uY2VybiB3YXMgdGhhdCBwdGVfbWt3cml0ZV9rZXJuZWwoKSBtaWdo
dCBub3QgbWFrZQ0Kc2VtYW50aWMgc2Vuc2UgZm9yIGFsbCBhcmNoaXRlY3R1cmVzIHNpbmNlIG5v
dCBhbGwgYXJjaGl0ZWN0dXJlcyB3ZXJlDQp1c2luZyBwdGVfbWt3cml0ZSgpIG9uIGtlcm5lbCBt
ZW1vcnkuIExpa2UgSSBrbm93IGEgbG90IG9mDQphcmNoaXRlY3R1cmVzIGRvbid0IGRvIHJlYWQt
b25seSBtZW1vcnkgaW4gdGhlIGtlcm5lbCBldmVuIHRob3VnaCB0aGV5DQpkbyBpdCBpbiB1c2Vy
c3BhY2UuDQoNCkkgYWxzbyB0aGluayBpdCB3b3VsZCBzdGlsbCBiZSBsZWF2aW5nIHRoaW5ncyBp
biBhIHNsaWdodGx5IHdvcnNlIHBsYWNlDQp0aGFuIHdlIHN0YXJ0ZWQgYnkgaGF2aW5nIHRoZSBh
Y3R1YWwgZ3V0cyBvZiB0aGUgcHRlX21rd3JpdGUoKSdzIGhhcmRlcg0KdG8gZ3JlcCBmb3IuDQoN
CkknbSBzdXJwcmlzZWQgdGhpcyB3YXMgbWlzc2VkIGluIGF1dG9tYXRlZCB0ZXN0aW5nLCBzaW5j
ZSB0aGUNCmNvbnNlcXVlbmNlIG9mIGJyZWFraW5nIHRoZXNlIHNob3VsZCBoYXZlIGJlZW4gcHJl
dHR5IGltbWVkaWF0ZWx5DQpvYnZpb3VzLiBCZXR3ZWVuIHRoYXQgYW5kIGFsbCB0aGUgdGltZXMg
bXlzZWxmIGFuZCBvdGhlcnMgbG9va2VkIGF0IGl0DQphbmQgc3RpbGwgZmFpbGVkLCBtYXliZSB0
aGUgbGVzcyBlcnJvciBwcm9uZSBzb2x1dGlvbiBpcyBiZXR0ZXIuDQo=
