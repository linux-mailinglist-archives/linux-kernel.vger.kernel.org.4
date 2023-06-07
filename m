Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD269727059
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjFGVMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjFGVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:12:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6E10F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686172339; x=1717708339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pkvMQ02dHbU/fvT7ecKLJ4kr/icYIW91hyx7l9U3XOU=;
  b=RSVHb+zzzqMLGgn1eK2bHSTw+LXDLVtBHA0iZHLBUyRGvwjRkwIQTY43
   huN8vUs2/+jrRKdyqOHZJKBuR02UPvHiR+yHvy9vB1GALOXh0UGEeEC4g
   TtboPH0f6GUPyD5TFKOfHRJeQYjtFsCeGLCX95fjX6gxS2fU4NiraicLZ
   e95UH9qGPP/qYKjOBkWsfTpMuzxHUhMMYsPOHzuk5/TB0Ukuz1piMx/9J
   dOXZfylIIguOsTySbrNuIlYt8vkNXGqwAjwjeeeLtw6YVifzoo8i2r+tu
   wgzUcIfzmQMQ4tqbe5455kgvUaFbZUM8mt1D9NfYIebSbe0d5blRPq4F3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360442304"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="360442304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 14:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774787381"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="774787381"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 14:12:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 14:12:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 14:12:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 14:12:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 14:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b26w0THIYAg9Ew+TZyfapESwqKDu3OEM6Chssp0sS69p3atWny66saLryUMndvpZDyEL8iq8emcssBJFzBt5lZx1aJWc9sxChcAX2Vp3e6HswXmvARL5x+y0hJbVX59lNU4fWNSRHjvMvIX1OWny15rBFty/4bI1EYptccy3DyeAa1BIEbw0a6WGY41F/3RSxPV52l/JE1B21VwqhvZjCC9CvOmDtYAAIgiN3QJ027uQkMEvkBOvDjSXl1ixbFw0eh/6qL7J7NWsaTyZ6q39cZ79/sf6bKM5RN2KivWTNF33493VFmiFIbQ/kbi9WXJGXAzM8Ghyaf8ii6xB08/6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkvMQ02dHbU/fvT7ecKLJ4kr/icYIW91hyx7l9U3XOU=;
 b=X1VsE8Po33PU+dpgKc0zmKuwnIzwWCwy/Uf8GPTDocLR8N4x6lGl21rUUPk0f4LeXdc4pfwtWfYd7NUxreg0uwxmH0jXR35masqEwkhxox31XydB1TXCbMhitiZTS1s+0bCXWeP7wCN3wIBTEr13n0jyLilsivYzO7eOnuaZQJyEujYXlEpcYcrsCrgukwI+uPq33uqhGWojyt7XFPFlbjHL24uKaeFRn9Puw/IW5DgM/UEQR9dFGQZCuc7QgbispDZJPXVO9j+91L+vh5ubMejF08R0LI5hR+3l3PCH2y58sh1gsFW7Sp14nnq5q94hEACFknKQR95ksUKUm/OSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB6013.namprd11.prod.outlook.com (2603:10b6:8:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 21:12:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 21:12:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "janusz.krzysztofik@linux.intel.com" 
        <janusz.krzysztofik@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] x86/mm: Fix PAT bit missing from page protection
 modify mask
Thread-Topic: [PATCH v2] x86/mm: Fix PAT bit missing from page protection
 modify mask
Thread-Index: AQHZmYS6GTi4WqcQaEiK5O6PEyZEPg==
Date:   Wed, 7 Jun 2023 21:12:13 +0000
Message-ID: <ad762335fd209fd8c1555401bc03e196eb53caef.camel@intel.com>
References: <20230607152308.125787-2-janusz.krzysztofik@linux.intel.com>
         <a20344fd-8130-013e-e773-acae81aad55a@intel.com>
         <38324471.J2Yia2DhmK@jkrzyszt-mobl2.ger.corp.intel.com>
In-Reply-To: <38324471.J2Yia2DhmK@jkrzyszt-mobl2.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB6013:EE_
x-ms-office365-filtering-correlation-id: d8b470d0-816e-4217-4d8c-08db679bdd73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3F/EOxb9zXSSS58BgabjKRuQ1BFKMYrg+ci03IlvdBuUdOXmgZKYXSxPUqeexwAijorY9Y45jg20BTyyW7MIkdRN8oybsBaohlMc4j8hGwvaMpvSwh7rMudcFZ25qu4198oJRSA8bEFF0F0Laxu347qLwCv1OUxy2Sk0tJqrMTisLSyx8B3WkUGlVbGUAKS9QAHnTl4GPK/2cvGCFzxacVs8EirEXltrKhyW7KC6FZOfjbbsjBrDuq4LzIo61JSLq1kJiftew84PRQvUW3Jg8ZpAU534p27PpzlqgywwN6uMsUsmDJAQ/st0Jnnanp3rHDPlMCE9NUfzleel9nW8KBzC9OfK12x+Nt6tqsmV43OY1T9DEAT4mzJ6KxjWDdb0TNsXhSij+jhpf+bv/fECU13jSyTXDazwLz3gCFSWFv3J5NRKeWVY/+SUkLlXLyMSPs83iQsNdkBW334vEaNoWd+XkQg56Ht/h6J6hVEN4lEHkwfH+SS6pGlzEt9aL6hvgBO3QjjWTDyFAOTfkY1ZWH2YxonFlmvyLa0c5sFaORlvYOKoJT/Q9u1xVdE5NnJwchtDo+qNn2Y/DtCzsyzY79M7RMbJZsflQE/VKYXdtD77k31p3maCf4AgBJ8OO5t6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6512007)(53546011)(38100700002)(6506007)(2616005)(41300700001)(6486002)(26005)(186003)(83380400001)(71200400001)(478600001)(110136005)(54906003)(64756008)(66476007)(91956017)(122000001)(66446008)(4326008)(82960400001)(76116006)(316002)(66946007)(8676002)(7416002)(66556008)(8936002)(5660300002)(38070700005)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0N5MXh1c0YrY0pnWUxESURrS1BGUnF3Q1Rqa0p6TTRtZllkZnpYa2xOOVZm?=
 =?utf-8?B?dVhzUG9HWkdHQnNXWTd3R2ZUMHhKSGd2QVRocjhVMVRCa2FKWFVZekRRYUgy?=
 =?utf-8?B?RnpyMnFtd0ZLS0dEU2UwZ1RKcUFlbVorZExnUS91SlFUL3ZBRGgrQ3FGY3BQ?=
 =?utf-8?B?OGhLdS9iRzJiaTkvOWlhbU9ES2tGQ3Axa2d4VXdNODlGWmRlS2ZnbkhwV2hz?=
 =?utf-8?B?RmE5NDRTMVhMYUVaMm5mVFBueENNUGxNak1wRVdwN2lOaC9KYjE4OFVJWmsw?=
 =?utf-8?B?dEY1UXRPSVFIRFFubWlCQnhId1ZOQkIyejlGZUVBM0xiZU5jOFJLd0ZxeSs2?=
 =?utf-8?B?T0pSdGhzZzRZbHV2ZXIwNWhJZEJBQUR3U1lQZFZCTVVIUjRJRVRWNzkvSUZN?=
 =?utf-8?B?UXFKa1N0TVR4bjh1U0xucWxqZlc2LzZ6M0o4REhCY0pHUm82WWxvZWpHcXBo?=
 =?utf-8?B?cktMNXo1YnZmRTNabEMxbGpoT2xQL3d2d0JUNmJZQ2NBd0ZKM2RlcmNjcGJB?=
 =?utf-8?B?N3UwRmxYRE9rZzFyell5STZUZ3daaUdlUW5nM2drOXZZTVFKNnZkalp6NmJz?=
 =?utf-8?B?YmgxQXMxNmxZQzEvWUlzSkpua0pYUDJlYUVqb21rL3VjZ284L2FBSDNnYXl4?=
 =?utf-8?B?RFZSWnpjL0JKeE1HdzM0RmFkcUIvZnNkeTBZazZqenJVdmVRbzZwRG1UTitn?=
 =?utf-8?B?T0VzMUIrTTBFQ2lEaml6SEhvd1ZPV1pmbGk3eHR2TUh3YmNFSjJlSGxISUla?=
 =?utf-8?B?NklkeWRKclBmOHBSbmh4djRjb0t4cWYwVXl2UDcrbm9SWVdmNzVBU3U0Sy9X?=
 =?utf-8?B?TURCWXF4K05SUWtuS2o1LzJHUHRZOHA4ZUxpQmliZW5Da1NrNWkvWGFDVk8r?=
 =?utf-8?B?Rm5JUjZIR3RSaTRRSzlzZDBPNjRWK1B3OXZ5MkczOUdYVFZYZkQyZm11L2RP?=
 =?utf-8?B?Ukx3OFZpYXlnT1JDSVZvQlJFQW90U1h6QnArYzRwaS9wNFdDYUJxNk5pa1Rh?=
 =?utf-8?B?WVIyUnUzNi9sMllRVHNFKzdteDNqcVdzdTBMNHFxWkE4ZG01NVVURnRFblFM?=
 =?utf-8?B?bDl0NDBYZktXWFpJd3pMTU9pM0o5ZjdwbUN4bXhabFVJYmlmenNNd0liSHVD?=
 =?utf-8?B?bU5kRExkRmc5bUlCaUFQaUVsNGlsQ1N6enErbGJIckpyMUtIbkxzcjFTd3dB?=
 =?utf-8?B?c1lNWktzMFFFa1dXRUdxdnRWV0VMN2FnQ3ZzZGFndk9jM0FyYlVoTm9ES2hP?=
 =?utf-8?B?cGV1cUhzdWZSSVcvbS9mT1N4Wmw4aDJBOGJGZmw5cUNYRkg4UjFNNkJKb21y?=
 =?utf-8?B?bUtEcU1OK1M3Yjd3YThkYUFkdksvc2FLN0JVYm54Rkh1a2txT0FqZi8rV0Vl?=
 =?utf-8?B?c0x5dXZNcSt5ZGFtYWJCdVc2M3NpbFRYOVlHZW9OTlBURi80ZlIvK0c3blpI?=
 =?utf-8?B?aHFEQlloNTlNcit2UGhLSi96RDRzVk1NalRTRE1OVlJZUlM0eENFVWVtZC9B?=
 =?utf-8?B?REJaM2xZTVdSdnk0TlJva2VQclh2ayszeFdVODhUaFpBQ2o2NEJrTExHdzdk?=
 =?utf-8?B?RndnZ1Y4M1lYZ0FZWmYrcWg1ZzZORVlxZGN0L1hiQndLT0N5K2g4Q1NXSkdS?=
 =?utf-8?B?alBMeENQdW9JZ3MybUNDOVM1RTMzbU05TEhIeVM1RVVoQ1lwdit5b2RzWTVM?=
 =?utf-8?B?ZE9PbWZvbGFIY2dVaW8xVmxnNXhDTjZJRUtFTU91NXd5Y1RVYXZ0RkdFWWZJ?=
 =?utf-8?B?VlZacEhWMmpoSHduUTlKLzlyUzNDekEwZDhzakY3dU1tdFg3VFpBWmNvckFz?=
 =?utf-8?B?blFxUCtYaEx4WFFVL0E3TXFjaVZJeVNBdnN3MThoVnNqaVYrNnpYeUNGaGlq?=
 =?utf-8?B?ZCtQU09KaUJ5cDZsbVE3Mld5eDVLQWozS1lMSXUydmFVM3lXY3FCV2E0UG8x?=
 =?utf-8?B?N1pzdlIrWXE4ZFB1UXI5NEhJUThCc1dTMDZxeEo0b3NyMlowWnhmK0xYM3hR?=
 =?utf-8?B?QVRGc3QzTE45MlJDTitlRndWTnkyeDkvK1JmUzQ2S0phdFlLS2l3OERQckxP?=
 =?utf-8?B?eU81SXo4T0pTd2lONk9tZDlZbUpzMW05OFVXWWY2VmdVbWZ2cE1vRks1a3J2?=
 =?utf-8?B?YnhIVHVuUTBWUUU0MEM2NTRpbTBvb0hKSUJWclZjbm5WS0x3T2o0em1KbDZl?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A181C98A2045E74BA86C8A52478F3E34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b470d0-816e-4217-4d8c-08db679bdd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 21:12:13.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cx9b8567L2BUP+j7cbXAQ0WskU6YdIYh4XhDCH4vU7ewyutCDcp2mar7YkSHx9bb44UAqsX+ByfIBGpgREKGp/wYjFfeZK0ZwTRz0xjXNl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6013
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTA3IGF0IDE5OjExICswMjAwLCBKYW51c3ogS3J6eXN6dG9maWsgd3Jv
dGU6DQo+IE9uIFdlZG5lc2RheSwgNyBKdW5lIDIwMjMgMTc6MzE6MjQgQ0VTVCBEYXZlIEhhbnNl
biB3cm90ZToNCj4gPiBPbiA2LzcvMjMgMDg6MjMsIEphbnVzeiBLcnp5c3p0b2ZpayB3cm90ZToN
Cj4gPiA+IA0KPiA+ID4gRXh0ZW5kIGJpdG1hc2sgdXNlZCBieSBwZ3Byb3RfbW9kaWZ5KCkgZm9y
IHNlbGVjdGluZyBiaXRzIHRvIGJlDQo+ID4gPiBwcmVzZXJ2ZWQNCj4gPiA+IHdpdGggX1BBR0Vf
UEFUIGJpdC7CoCBIb3dldmVyLCBzaW5jZSB0aGF0IGJpdCBjYW4gYmUgcmV1c2VkIGFzDQo+ID4g
PiBfUEFHRV9QU0UsDQo+ID4gPiBhbmQgdGhlIF9QQUdFX0NIR19NQVNLIHN5bWJvbCwgcHJpbWFy
bHkgdXNlZCBieSBwdGVfbW9kaWZ5KCksIGlzDQo+ID4gPiBsaWtlbHkNCj4gPiA+IGludGVudGlv
bmFsbHkgZGVmaW5lZCB3aXRoIHRoYXQgYml0IG5vdCBzZXQsIGtlZXAgdGhhdCBzeW1ib2wNCj4g
PiA+IHVuY2hhbmdlZC4NCj4gPiANCj4gPiBJJ20gcmVhbGx5IGhhdmluZyBhIGhhcmQgdGltZSBw
YXJzaW5nIHdoYXQgdGhhdCBsYXN0IHNlbnRlbmNlIGlzDQo+ID4gc2F5aW5nLg0KPiA+IA0KPiA+
IENvdWxkIHlvdSB0cnkgYWdhaW4sIHBsZWFzZT8NCj4gDQo+IE9LLCBidXQgdGhlbiBJIG5lZWQg
dG8gZ2V0IG15IGRvdWJ0cyBhZGRyZXNzZWQgYnkgc29tZW9uZSBmaXJzdCwNCj4gb3RoZXJ3aXNl
IEknbSANCj4gbm90IGFibGUgdG8gcHJvdmlkZSBhIGJldHRlciBqdXN0aWZpY2F0aW9uIGZyb20g
bXkgaGVhcnQuDQo+IA0KPiBUaGUgaXNzdWUgbmVlZHMgdG8gYmUgZml4ZWQgYnkgaW5jbHVkaW5n
IF9QQUdFX1BBVCBiaXQgaW50byBhIGJpdG1hc2sNCj4gdXNlZCANCj4gYnkgcGdwcm90X21vZGlm
eSgpIGZvciBzZWxlY3RpbmcgYml0cyB0byBiZSBwcmVzZXJ2ZWQuwqAgV2UgY2FuIGVpdGhlcg0K
PiBkbyANCj4gdGhhdCBpbnRlcm5hbGx5IHRvIHBncHJvdF9tb2RpZnkoKSAobXkgaW5pdGlhbCBw
cm9wb3NhbCwgd2hpY2ggbXkNCj4gcG9vcmx5IA0KPiB3b3JkZWQgcGFyYWdyYXBoIHdhcyBzdGls
bCB0cnlpbmcgdG8gZGVzY3JpYmUgYW5kIGp1c3RpZnkpLCBvciBieQ0KPiBtYWtpbmcgDQo+IF9Q
QUdFX1BBVCBhIHBhcnQgb2YgX1BBR0VfQ0hHX01BU0ssIGFzIHN1Z2dlc3RlZCBieSBCb3Jpc2xh
diBhbmQNCj4gcmVmbGVjdGVkIGluIA0KPiBteSB2MiBjaGFuZ2Vsb2cuwqAgQnV0IGZvciB0aGUg
bGF0dGVyLCBJIHRoaW5rIHdlIG5lZWQgdG8gbWFrZSBzdXJlDQo+IHRoYXQgd2UgDQo+IGRvbid0
IGJyZWFrIG90aGVyIHVzZXJzIG9mIF9QQUdFX0NIR19NQVNLLsKgIE1heWJlIEJvcmlzbGF2IGNh
bg0KPiBjb25maXJtIHRoYXQncyANCj4gdGhlIGNhc2UuDQo+IA0KPiBTaW5jZSBfUEFHRV9QQVQg
aXMgdGhlIHNhbWUgYXMgX1BBR0VfUFNFLCBfSFBBR0VfQ0hHX01BU0sgLS0gYSBodWdlDQo+IHBt
ZHMnIA0KPiBjb3VudGVycGFydCBvZiBfUEFHRV9DSEdfTUFTSywgaW50cm9kdWNlZCBieSBjb21t
aXQgYzQ4OWYxMjU3YjhjDQo+ICgidGhwOiBhZGQgDQo+IHBtZF9tb2RpZnkiKSwgZGVmaW5lZCBh
cyAoX1BBR0VfQ0hHX01BU0sgfCBfUEFHRV9QU0UpIC0tIHdpbGwgbm8NCj4gbG9uZ2VyIGRpZmZl
ciANCj4gZnJvbSBfUEFHRV9DSEdfTUFTSyBhcyBzb29uIGFzIHdlIGFkZCBfUEFHRV9QQVQgYml0
IHRvIHRoZSBsYXR0ZXIuwqANCj4gSWYgc3VjaCANCj4gbW9kaWZpY2F0aW9uIG9mIF9QQUdFX0NI
R19NQVNLIHdhcyBpcnJlbGV2YW50IHRvIGl0cyB1c2VycyB0aGVuIG9uZQ0KPiBtYXkgYXNrIA0K
PiB3aHkgYSBuZXcgc3ltYm9sIHdhcyBpbnRyb2R1Y2VkIGluc3RlYWQgb2YgcmV1c2luZyB0aGUg
ZXhpc3Rpbmcgb25lDQo+IHdpdGggdGhhdCANCj4gb3RoZXJ3aXNlIGlycmVsZXZhbnQgYml0IChf
UEFHRV9QU0UgaW4gdGhhdCBjYXNlKSBhZGRlZC7CoCBJJ3ZlDQo+IGluaXRpYWxseSANCj4gYXNz
dW1lZCB0aGF0IGtlZXBpbmcgX1BBR0VfQ0hHX01BU0sgd2l0aG91dCBfUEFHRV9QU0UgKHZlbCBf
UEFHRV9QQVQpDQo+IGluY2x1ZGVkIA0KPiBpbnRvIGl0IHdhcyBpbnRlbnRpb25hbCBmb3Igc29t
ZSByZWFzb24uwqAgTWF5YmUgSm9oYW5uZXMgV2VpbmVyLCB0aGUNCj4gYXV0aG9yIG9mIA0KPiB0
aGF0IHBhdGNoIChhZGRpbmcgaGltIHRvIENjOiksIGNvdWxkIHNoZWQgbW9yZSBsaWdodCBvbiB0
aGF0Lg0KDQpTbyBzaW5jZSBfUEFHRV9QU0UgaXMgYWN0dWFsbHkgdGhlIHNhbWUgdmFsdWUgYXMg
X1BBR0VfUEFULCB5b3UgZG9uJ3QNCmFjdHVhbGx5IG5lZWQgdG8gaGF2ZSBfUEFHRV9QU0UgaW4g
X0hQQUdFX0NIR19NQVNLIGluIG9yZGVyIHRvIGdldA0KZnVuY3Rpb25hbCBjb3JyZWN0bmVzcy4g
SXMgdGhhdCByaWdodD8NCg0KSSB0aGluayBpdCBpcyBzdGlsbCBhIGxpdHRsZSBoaWRkZW4gKGV2
ZW4gYmVmb3JlIHRoaXMpIGFuZCBJIHdvbmRlcg0KYWJvdXQgc2VwYXJhdGluZyBvdXQgdGhlIGNv
bW1vbiBiaXRzIGludG8sIGxpa2UsIF9DT01NT05fUEFHRV9DSEdfTUFTSw0Kb3Igc29tZXRoaW5n
LiBUaGVuIHNldHRpbmcgc3BlY2lmaWMgUEFHRSBhbmQgSFBBR0UgYml0cyAobGlrZQ0KX1BBR0Vf
UEFULCBfUEFHRV9QU0UgYW5kIF9QQUdFX1BBVF9MQVJHRSkgaW4gdGhlaXIgc3BlY2lmaWMgZGVm
aW5lLg0KV291bGQgaXQgYmUgbW9yZSByZWFkYWJsZSB0aGF0IHdheT8NCg0KDQo=
