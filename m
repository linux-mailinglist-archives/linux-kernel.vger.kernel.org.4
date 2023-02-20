Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678369CF77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjBTOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBTOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:33:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8D102
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676903599; x=1708439599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rgO3HXrrj9sOOsjBY6lB4UAYggi+5ASJFwsvQzDmCTA=;
  b=XCsoI1OUzjv8LdCAo3vZQTuKX2JJVxXF9Veh2RKAw656Lg4n0gGDE+tl
   tNRwTtFrfvRrV/lKI0HtkvOVd9UMjeNauNE9SL7WQ87hWwwkqLmNFPTy6
   8bJ5axpLBNDrpnZuqrokvXMPCewT9e5mDwZxy8fbUS/ZRR4h3GyzhgH51
   Y0pwh7vJlPfphKUkr6+2ftUeoR4knJShaSLMPrIBEsUmlMGMBmOwwDgVt
   v4RMxEQGF8MU6T4EO/vjLvdAu8rFcvKkPyQ4tVPN4dGXDVeCEMfWxocD5
   O0QlfycY4v3hTmvWvX1GlPDxDp5x7Q+BbdaeKeGoPOR3ioq4gzFAHozoy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312783581"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="312783581"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 06:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="916868813"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="916868813"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2023 06:33:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 06:33:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 06:33:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 06:33:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 06:33:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToKv0pT7eyFwjiDXH01PWmsQRhUuZ8jboUIgiDYxyri9nkLrd8yyGat872D40/RqryV58/myn2HDGUshITfiB+M12XPGyYJA7AxuyxCLodIouHyYiEMHH+fIYFYPiIXXhHKE5h/hfbr8pT8jxQFkg2EEmr0WJcNnsgg/LnIdu7WxcRr5F2aLZ01XO5PsiH+vlQdJwxPUIG0TPlKoyuWciUeSj1aYzS+nTkUtY3fv5mWrMe/4qM6FdnKTSkr1pdQIE2rabUnrvRzuD7lxWLbAHScIDjLAv64Ngo3XNveizJobL9Q4ReGTxiAQ/xg19Mn0hIYeJ8m8oRUkOdX0S8lfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgO3HXrrj9sOOsjBY6lB4UAYggi+5ASJFwsvQzDmCTA=;
 b=lfPP3RrmPSPM/gDFZ8vLAh1qdhlM8oUkuGCuVS7gsQTWoOkJj2Knwbr7pxf1kHEvv46Cel0uKLvfHbIrfafTMJc3kL0paPMuGljkb1HZAUROKnRu18CjVlJ2Yr4/Q7yL/ctn1GW7vT6xsF9QzVc730gfI3MWsHni+hdQetqGRGep6Uhpct/PmTkGYTKQ8piIQGkF7Skjscjal95RSpGk5PzuxOnKweC6flOWNzm5nWI1GxwKEYrSHpZo5p3VtJKPgWEcw/eXIN9YmP7AvHsjBHJlPwFfOLpmZ4GX+n0j1RiY1BEztlGxIMkarpTl+WdPUqCw6n4Kz4RbcSdM1QVLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 14:33:10 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 14:33:10 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Topic: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Index: AQHZRNuCmUZrj67G7kGhK77N+UN9Nq7XrYkAgAA5PoA=
Date:   Mon, 20 Feb 2023 14:33:09 +0000
Message-ID: <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB4773:EE_
x-ms-office365-filtering-correlation-id: 52ab18b0-1b4d-4ffa-ca11-08db134f63c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ak3V2UvfbaHtnWYbxMFNx8bMYJ2bqr76uZd5832rrsZb4JBC7i+Su8yJ6QSCj3lEumRv/ANJ25o6Brv889fqHfu1NkWzNEdL2c+qX7Mc1buwtut7uTZnw5iKUDV+Wm5zDlVMQePeVVubBxCPNnLXa9jTvlXkpGM1aIvKDMQJMN2oY7F3pTuBQ0/gHPba7tBQw2SxAfPvlrind++J7VLs6PuXBNBuDT2NCrkmlCJZssPbDPxpmBYt0SZYYtJBrqZLLYoZqUEyIvav/2UjJGTvFjUlHCi5xQhr+eSsvgZGRTZAq8562GR9pLy36scee1dc8jA96lXh9wPPFziXljkdLD3j4vIoe1ASq5cbvGom7+HLYaiqhZxgMWgitmFbarOUVayTygCobO+EL9K9ktyeHP9y2/AqEmDa9p2EXk/+t/UdMSBLLcY1/OyD9j7Zbll8UWvox+r4YyWQ+COJKkFNBQZQyUtLx6dvhqOrKZsv1MD5heOEtAdXttKY02hpxlPuB3fJvcBZ3IoZhtQinBJS6pjZ1bPQls8rme0ibI/mYQgyxrZiBtirfUBzaNYWv1syMvfqzUGRjmHFCy9b1k5/RRrMm751wbPofNnU2bmos3/Urm6KbVM/gLldXrtMJ1A9r5iDFAX501UPQ0Bq8WfvH+ziOJA8vNEKB1RutQw2kVMPEapGO/XqVD8fQ2ZYT5az/LOv95ZmxVdJvUVh3ReDYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(54906003)(8936002)(82960400001)(478600001)(71200400001)(316002)(6486002)(36756003)(186003)(122000001)(8676002)(66556008)(66476007)(86362001)(6512007)(66946007)(6506007)(66446008)(64756008)(4326008)(83380400001)(91956017)(38100700002)(5660300002)(2906002)(26005)(2616005)(76116006)(6916009)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3VPK2xzaUd5cDQ5SlRScCs4REZCTjRVVURvcGg2c3lqY2N1bTNVOW1tMXky?=
 =?utf-8?B?cEQvOW9Ja3NuV080TGhnMFE2SmgwL1A3UlVSeWRaZXEvMjZFcGs1UWtrVVds?=
 =?utf-8?B?bHZ0akhmbTNQeDFOUXNEN0hKMk15VDhUandVS0ZReGdQbkZyNFhOVUh1M01y?=
 =?utf-8?B?VUFENUoxTVpSb1dkaVpZNXJPaGpNODlyQ2d2Q09SSUdzNG1qc3lWUHFlTk10?=
 =?utf-8?B?S1EyOWJaNml6bTJMVHV5MTFjOTI3VStmREp5anlRamZDZFExaWRleFRGNWsy?=
 =?utf-8?B?Rlo5cytSajdCMXoxQ1hNMzF6NVo3cXI1cldFUlo2U3Q3VmtYVzBOL2drV1J0?=
 =?utf-8?B?UTZibHFEVHRBT3Y1Z1d6UGduZGNDRW5JdDh2dTdmUlU5QXcweDNoMkZhK2NK?=
 =?utf-8?B?V2RkY3pXZDhKSUNtZjdlbldkKzNrVHVxSU0rRFhSMHRzSnBUcU1PY2hLRFAy?=
 =?utf-8?B?TjVpS1oyelpnWDJXNGJzMUUvT2x0TTJaOGQrZnE2cHB1aGNOT1JzRWRoUFlF?=
 =?utf-8?B?YldTSVFDWnhhVUxBWnFQTnN5NkZWQlRIZnUwWThMSk9LVHNLZTdGeXUxd1Bo?=
 =?utf-8?B?Zlphdi9PcVdVWGs2Vkc2SVhGcEpPZUhHK0FxUENqUXl1QlBFeUdlN1pOVDYy?=
 =?utf-8?B?N29tQ1BZSDVKeHVtdUczOXpXMHk1QS82SEpCTDN0dGk3SzViek85akFJOVlI?=
 =?utf-8?B?aVlZazlYOTIzT0dpU2lGTFR1Y1FiMjloTWxMSitWMVFFcUdxL3phNUh3ZkNr?=
 =?utf-8?B?MWlMdE1Md0lncExMcVJXeGpzUnBSSzh5aVZObkNDWlAyV3JnQ0t3T2ZCeDBi?=
 =?utf-8?B?ek1GZUhoNzUzQVNwRlBxRjBLdzZ3TTZ0U1hucXV5KzdGUU92N2F6L0dVd3Vv?=
 =?utf-8?B?ZUFRbXQ1VzB4RUZHVEVrTG9SSjRiYjdlT09TYUVpRFNoZ1E2QzdUaGRqd3pr?=
 =?utf-8?B?alZQMFIzWWZXL1M4amlMSTFoK21xaEtNTmI2N00yRTZiN2NMc1QxcWVYS3FB?=
 =?utf-8?B?QVRIR3cwV1YwakI0QmRvNkFsV2NXVkpvWWxTWXRNUkhTOHFSQkZSWVhpV2Nw?=
 =?utf-8?B?c2s3TUtqNlpxTHh4S1Nva0RaL0NkczZuckRSckJIeHdha2RNL3cvU21NbkFz?=
 =?utf-8?B?VzFqMHV0cW1JS1ExamJ2UklEU3FMMDd0a1lzL0cyY2Z1YjlJM0MrekN3N0pI?=
 =?utf-8?B?a2N2elZ4QUhuV3Z3VTkrdUo4dWJzOVpOUHdxQ3luVDNzZmo5Y2J3aGFsRW1H?=
 =?utf-8?B?eXh0L1c1T3ErQXBwQ1NlSDZReUg3Z2o2a0ZpREZ6NnpNaEovTEc0WkxCdEpC?=
 =?utf-8?B?R2hFK1p3R01GQnlyaEdrYTFZSVhTMlI5dDZLVUZ5RFRGL1pYL05hK1ZUQnNk?=
 =?utf-8?B?RkxUSUFDdnBDN3FHNGNwb3pYOExlbTljZWJuVm5RZCttVWlscDc5STZZMEpn?=
 =?utf-8?B?dWUxYVlSZXNUdFhZbGtjU3diZ1ZaZm5sMU4vL1ZKaWZGRUtjMmZLUFkxaW90?=
 =?utf-8?B?VnNIMnAxdjRaTzBoZnc1dHNxcFBWenV5bGFnOThQRlQ1UnVXYWdLdzBHa0kz?=
 =?utf-8?B?TkFhUUN4UFY3RTJqcGlCYXZxZXZIeFFTNU5FUXI2Si85OWYrTENsN1o5cFQ4?=
 =?utf-8?B?UHZMMWFzVml4cEZlTThYYi9ZTFBlZjBMRnlUMjhIbTVkcVpJTlFJQ01DYVVv?=
 =?utf-8?B?dkNOckVSRksralBFdFNKdXNnUVhVRWtJMWVPNS9rYlU2ZFJtTWl3dzR4YWRV?=
 =?utf-8?B?Z0VGdXM0c2ptM3hDcE5BT2oxajExZkhnZ2ZscTY1ZFRhMXdpaFBMK3dyWHVI?=
 =?utf-8?B?N056T3ErcFBBQTV0Nm9ENDh1bkxBTW56dW5pQTZFQWx2bjdoVWs1WHVFVG9j?=
 =?utf-8?B?b3d5cGwxWnp3d3Z3UmVRNkFzLy9JeWxKeEYrQXVIVU9zTVJCeHo0TW9LdDdT?=
 =?utf-8?B?QVRFQzdrTnF0M1dUT1ZHZnZSSEw1SWhmZ1htYWMvRnFNaDdsamQwc0pGWUdD?=
 =?utf-8?B?QSt0S2tOZVNaTW9mYjNESmhEbmhoVlN2NnJTaE85elJXalRTRGpqS0h1VzdK?=
 =?utf-8?B?emY4VEI4U2JuTEw3WEo0WHRMUDUyeW5lS1FPSEtjSnRFL1RTNVBnTVU5NjhG?=
 =?utf-8?Q?GFmLPYCL5xR7jmBRLwipPrm6N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9055582477BBB842B9820AD10E0B5E5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ab18b0-1b4d-4ffa-ca11-08db134f63c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 14:33:10.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eGrWRbiagnyYBOg6pR10XhX3i1YdVHtj+yafMzs5nOuMAkLavCgUntFzzm6wwiRoyBktcLfjm2HLE/CFWXTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDEyOjA4ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gTW9uLCBGZWIgMjAsIDIwMjMgYXQgMTE6Mjg6NTVBTSArMDgwMCwgWmhhbmcgUnVpIHdy
b3RlOg0KPiANCj4gPiBRdWVzdGlvbnMgb24gaG93IHRvIGZpeCBjcHVpbmZvX3g4Ni54ODZfbWF4
X2NvcmVzDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+IA0KPiA+IEZpeGluZyB4ODZfbWF4X2NvcmVzIGlzIG1vcmUgY29tcGxleC4gQ3Vy
cmVudCBrZXJuZWwgdXNlcyBiZWxvdw0KPiA+IGxvZ2ljIHRvDQo+ID4gZ2V0IHg4Nl9tYXhfY29y
ZXMNCj4gPiAJeDg2X21heF9jb3JlcyA9IGNwdXNfaW5fYV9wYWNrYWdlIC8gc21wX251bV9zaWJs
aW5ncw0KPiA+IEJ1dA0KPiA+IDEuIFRoZXJlIGlzIGEga25vd24gYnVnIGluIENQVUlELjFGIGhh
bmRsaW5nIGNvZGUuIFRodXMNCj4gPiBjcHVzX2luX2FfcGFja2FnZQ0KPiA+ICAgIGNhbiBiZSBi
b2d1cy4gVG8gZml4IGl0LCBJIHdpbGwgYWRkIENQVUlELjFGIE1vZHVsZSBsZXZlbA0KPiA+IHN1
cHBvcnQuDQo+ID4gMi4geDg2X21heF9jb3JlcyBpcyBzZXQgYW5kIHVzZWQgaW4gYW4gaW5jb25z
aXN0ZW50IHdheSBpbiBjdXJyZW50DQo+ID4ga2VybmVsLg0KPiA+ICAgIEluIHNob3J0LCBzbXBf
bnVtX3NpYmxpbmdzL3g4Nl9tYXhfY29yZXMNCj4gPiAgICAyLjEgcmVwcmVzZW50cyB0aGUgbnVt
YmVyIG9mIG1heGltdW0gKmFkZHJlc3NhYmxlKiB0aHJlYWRzL2NvcmVzDQo+ID4gaW4gYQ0KPiA+
ICAgICAgICBjb3JlL3BhY2thZ2Ugd2hlbiByZXRyaWV2ZWQgdmlhIENQVUlEIDEgYW5kIDQgb24g
b2xkDQo+ID4gcGxhdGZvcm1zLg0KPiA+ICAgICAgICBDUFVJRC4xIEVCWCAyMzoxNiAiTWF4aW11
bSBudW1iZXIgb2YgYWRkcmVzc2FibGUgSURzIGZvcg0KPiA+IGxvZ2ljYWwNCj4gPiAgICAgICAg
cHJvY2Vzc29ycyBpbiB0aGlzIHBoeXNpY2FsIHBhY2thZ2UiLg0KPiA+ICAgICAgICBDUFVJRC40
IEVBWCAzMToyNiAiTWF4aW11bSBudW1iZXIgb2YgYWRkcmVzc2FibGUgSURzIGZvcg0KPiA+IHBy
b2Nlc3Nvcg0KPiA+ICAgICAgICBjb3JlcyBpbiB0aGUgcGh5c2ljYWwgcGFja2FnZSIuDQo+ID4g
ICAgMi4yIHJlcHJlc2VudHMgdGhlIG51bWJlciBvZiBtYXhpbXVtICpwb3NzaWJsZSogdGhyZWFk
cy9jb3JlcyBpbg0KPiA+IGENCj4gPiAgICAgICAgY29yZS9wYWNrYWdlLCB3aGVuIHJldHJpZXZl
ZCB2aWEgQ1BVSUQuQi8xRiBvbiBub24tSHlicmlkDQo+ID4gcGxhdGZvcm1zLg0KPiA+ICAgICAg
ICBDUFVJRC5CLzFGIEVCWCAxNTowICJOdW1iZXIgb2YgbG9naWNhbCBwcm9jZXNzb3JzIGF0IHRo
aXMNCj4gPiBsZXZlbCB0eXBlLg0KPiA+ICAgICAgICBUaGUgbnVtYmVyIHJlZmxlY3RzIGNvbmZp
Z3VyYXRpb24gYXMgc2hpcHBlZCBieSBJbnRlbCIuDQo+ID4gICAgICAgIEZvciBleGFtcGxlLCBp
biBjYWxjX2xsY19zaXplX3Blcl9jb3JlKCkNCj4gPiAgICAgICAgICAgZG9fZGl2KGxsY19zaXpl
LCBjLT54ODZfbWF4X2NvcmVzKTsNCj4gPiAgICAgICAgeDg2X21heF9jb3JlcyBpcyB1c2VkIGFz
IHRoZSBtYXggKnBvc3NpYmxlKiBjb3JlcyBpbiBhDQo+ID4gcGFja2FnZS4NCj4gPiAgICAyLjMg
aXMgdXNlZCBpbiBhIGNvbmZsaWN0IHdheSBvbiBvdGhlciB2ZW5kb3JzIGxpa2UgQU1EIGJ5DQo+
ID4gY2hlY2tpbmcgdGhlDQo+ID4gICAgICAgIGNvZGUuIEkgbmVlZCBoZWxwIG9uIGNvbmZpcm1p
bmcgdGhlIHByb3BlciBiZWhhdmlvciBmb3IgQU1ELg0KPiA+ICAgICAgICBGb3IgZXhhbXBsZSwg
aW4gYW1kX2dldF90b3BvbG9neSgpLA0KPiA+ICAgICAgICAgICBjLT54ODZfY29yZWlkX2JpdHMg
PSBnZXRfY291bnRfb3JkZXIoYy0+eDg2X21heF9jb3Jlcyk7DQo+ID4gICAgICAgIHg4Nl9tYXhf
Y29yZXMgaXMgdXNlZCBhcyB0aGUgbWF4ICphZGRyZXNzYWJsZSogY29yZXMgaW4gYQ0KPiA+IHBh
Y2thZ2UuDQo+ID4gICAgICAgIGluIGdldF9uYmNfZm9yX25vZGUoKSwNCj4gPiAgICAgICAgICAg
Y29yZXNfcGVyX25vZGUgPSAoYy0+eDg2X21heF9jb3JlcyAqIHNtcF9udW1fc2libGluZ3MpIC8N
Cj4gPiBhbWRfZ2V0X25vZGVzX3Blcl9zb2NrZXQoKTsNCj4gPiAgICAgICAgeDg2X21heF9jb3Jl
cyBpcyB1c2VkIGFzIHRoZSBtYXggKnBvc3NpYmxlKiBjb3JlcyBpbiBhDQo+ID4gcGFja2FnZS4N
Cj4gPiAzLiB1c2luZw0KPiA+ICAgICAgIHg4Nl9tYXhfY29yZXMgPSBjcHVzX2luX2FfcGFja2Fn
ZSAvIHNtcF9udW1fc2libGluZ3MNCj4gPiAgICB0byBnZXQgdGhlIG51bWJlciBvZiBtYXhpbXVt
ICpwb3NzaWJsZSogY29yZXMgaW4gYSBwYWNrYWdlDQo+ID4gZHVyaW5nIGJvb3QNCj4gPiAgICBj
cHUgYnJpbmd1cCBpcyBub3QgYXBwbGljYWJsZSBvbiBwbGF0Zm9ybXMgd2l0aCBhc3ltbWV0cmlj
DQo+ID4gY29yZXMuDQo+ID4gICAgQmVjYXVzZSwgZm9yIGEgZ2l2ZW4gbnVtYmVyIG9mIHRocmVh
ZHMsIHdlIGRvbid0IGtub3cgaG93IG1hbnkNCj4gPiBvZiB0aGUNCj4gPiAgICB0aHJlYWRzIGFy
ZSB0aGUgbWFzdGVyIHRocmVhZCBvciB0aGUgb25seSB0aHJlYWQgb2YgYSBjb3JlLCBhbmQNCj4g
PiBob3cNCj4gPiAgICBtYW55IG9mIHRoZW0gYXJlIFNNVCBzaWJsaW5ncy4NCj4gPiAgICBGb3Ig
ZXhhbXBsZSwgb24gYSBwbGF0Zm9ybSB3aXRoIDYgUGNvcmUgYW5kIDggRWNvcmUsIHRoZXJlIGFy
ZQ0KPiA+IDIwDQo+ID4gICAgdGhyZWFkcy4gQnV0IHNldHRpbmcgeDg2X21heF9jb3JlcyB0byAx
MCBpcyBhcHBhcmVudGx5IHdyb25nLg0KPiA+IA0KPiA+IEdpdmVuIHRoZSBhYm92ZSBzaXR1YXRp
b24sIEkgaGF2ZSBiZWxvdyBxdWVzdGlvbiBhbmQgYW55IGlucHV0IGlzDQo+ID4gcmVhbGx5DQo+
ID4gYXBwcmVjaWF0ZWQuDQo+ID4gDQo+ID4gSXMgdGhpcyBpbmNvbnNpc3RlbmN5IGEgcHJvYmxl
bSBvciBub3Q/DQo+IA0KPiBJSVJDIHg4Nl9tYXhfY29yZXMgaW4gc3BlY2lmaWMgaXMgb25seSBl
dmVyIHVzZWQgaW4gYXJjaCBzcGVjaWZpYw0KPiBjb2RlLA0KPiB0aGUgcG11IHVuY29yZSBkcml2
ZXJzIGFuZCB0aGluZ3MgbGlrZSB0aGF0IChncmVwIHNob3dzIE1DRSkuDQoNCkRvIHlvdSBtZWFu
IHRoYXQsIGFzIGxvbmcgYXMgdGhlIHVzYWdlIG9mIHg4Nl9tYXhfY29yZXMgbWF0Y2hlcyBpdHMN
CmRlZmluaXRpb24gZm9yIGEgZ2l2ZW4gdmVuZG9yL2dlbmVyYXRpb24sIHRoZSBkZWZpbml0aW9u
IG9mDQp4ODZfbWF4X2NvcmVzIGNhbiBiZSBpbmNvbnNpc3RlbnQ/DQoNCkkgd2FzIHRoaW5raW5n
IGhvdyB0byBtYWtlIGl0IGNvbnNpc3RlbnQuDQpGb3IgSW50ZWwgcGxhdGZvcm0sIGRlZmluaW5n
IHg4Nl9tYXhfY29yZXMgdG8gbWF4LSphZGRyZXNzYWJsZSotY29yZXMtDQppbi1hLXBhY2thZ2Ug
aXMgbm90IGEgcHJvYmxlbSBpbiBtb3N0IGNhc2VzLCBleGNlcHQgdGhlIG9uZSBiZWxvdw0KCWNh
bGNfbGxjX3NpemVfcGVyX2NvcmUoKSBpbg0KCQlhcmNoL3g4Ni9rZXJuZWwvY3B1L21pY3JvY29k
ZS9pbnRlbC5jDQp3aGljaCBuZWVkcyB0aGUgbnVtYmVyIG9mICpwb3NzaWJsZSogY29yZXMgdG8g
Z2V0IHBlciBjb3JlIExMQyBzaXplLg0KQnV0IEkgdGhpbmsgd2UgcHJvYmFibHkgY2FuIGltcHJv
dmUgdGhpcyBieSByZXBsYWNpbmcgeDg2X21heF9jb3Jlcw0Kd2l0aCBib290X2NwdV9kYXRhLmJv
b3RlZF9jb3Jlcz8gQmVjYXVzZSBkb2luZyBtaWNyb2NvZGUgdXBkYXRlDQpyZXF1aXJlcyBhbGwg
dGhlIGNvcmVzIHRvIGJlIG9ubGluZS4NCg0KSSBkb24ndCBrbm93IHRoZSBhbnN3ZXIgZm9yIG90
aGVyIFg4NiB2ZW5kb3JzLg0KDQo+IA0KPiBBbHNvLCBwZXJoYXBzIHlvdSB3YW50IHRvIGxvb2sg
YXQgY2FsY3VsYXRlX21heF9sb2dpY2FsX3BhY2thZ2VzKCkuDQo+IFRoYXQNCj4gaGFzIGEgY29t
bWVudCBhYm91dCB0aGVyZSBub3QgYmVpbmcgaGV0ZXJvZ2VuZW91cyBzeXN0ZW1zIDovDQoNCnll
YWgsIEkgbm90aWNlZCB0aGlzIHByZXZpb3VzbHkuDQoNCiAgICAgICAgbmNwdXMgPSBjcHVfZGF0
YSgwKS5ib290ZWRfY29yZXMgKiB0b3BvbG9neV9tYXhfc210X3RocmVhZHMoKTsNCiAgICAgICAg
X19tYXhfbG9naWNhbF9wYWNrYWdlcyA9IERJVl9ST1VORF9VUCh0b3RhbF9jcHVzLCBuY3B1cyk7
DQoNClRoZSBESVZfUk9VTkRfVVAoKSBtYWtlcyBpdCB0byB3b3JrIG9uIHN5c3RlbXMgd2l0aCBj
dXJyZW50IGFzeW1tZXRyaWMNCmNvcmUgc3lzdGVtcy4gQnV0DQoxLiBpZiBhIGNvcmUgY2FuIHN1
cHBvcnQgbW9yZSB0aGFuIDIgSFQgc2libGluZ3MsIHRoaXMgY2FuIGJyZWFrIGlmDQp0aGVyZSBh
cmUgbXVsdGkgc3ltbWV0cmljIHBhY2thZ2VzLg0KMi4gaWYgdGhlIHN5c3RlbSBoYXMgYXN5bW1l
dHJpYyBwYWNrYWdlcywgdGhpcyBjYW4gYnJlYWsuDQpTbyBmYXIgd2UgZG9uJ3QgaGF2ZSBzdWNo
IHBsYXRmb3Jtcy4NCjMuIGl0IGNhbiBhbHNvIGJlIGJyb2tlbiB3aGVuIHVzaW5nIGJvb3Qgb3B0
aW9uICdtYXhjcHVzJyBhcyBib290ZWRfY29yDQplcyBjaGFuZ2VzLg0KDQpCdXQgaXJvbmljYWxs
eSwgd2UgZG9uJ3QgaGF2ZSBhIGJldHRlciB3YXkgdG8gZ2V0IF9fbWF4X2xvZ2ljYWxfcGFja2Fn
ZQ0Kcy4NCg0KDQo+IEFueXdheSwgdGhlIHJlYXNvbiBJIHdlbnQgYW5kIGhhZCBhIGxvb2sgdGhl
cmUsIGlzIGJlY2F1c2UgSSByZW1lbWJlcg0KPiBUaG9tYXMgYW5kIG1lIHNwZW5kIGVudGlyZWx5
IHRvbyBtdWNoIHRpbWUgdG8gdHJ5IGFuZCBmaWd1cmUgb3V0DQo+IG1lYW5zDQo+IHRvIHNpemUg
YW4gYXJyYXkgZm9yIG51bWJlciBvZiBwYWNha2dlcyBhdCBib290IHRpbWUgYW5kIGdldHRpbmcg
aXQNCj4gd3JvbmcgdG9vIG1hbnkgdGltZXMgdG8gcmVjb3VudC4NCj4gDQo+IElmIG9ubHkgdGhl
cmUgd2FzIGEgc2FuZSB3YXkgdG8gdGVsbCB0aGVzZSB0aGluZ3Mgd2l0aG91dCBhY3R1YWxseQ0K
PiBicmluZ2luZyBldmVyeXRoaW5nIG9ubGluZSBmaXJzdCA6LSgNCg0KSSB0aG91Z2h0IG9mIGlt
cHJvdmluZyB0aGlzIGJ5IHBhcnNpbmcgYWxsIHRoZSB2YWxpZCBBUElDLUlEcyBpbiBNQURUDQpk
dXJpbmcgQlNQIGJvb3R1cCwgYW5kIGdldCBzdWNoIGluZm9ybWF0aW9uIGJ5IGRlY29kaW5nIHRo
ZSBBUElDLUlEcw0KdXNpbmcgdGhlIEFQSUMtSUQgbGF5b3V0IGluZm9ybWF0aW9uIHJldHJpZXZl
ZCBmcm9tIEJTUC4gQnV0IHRoaXMgaXMNCmxpa2VseSB0byBiZSBhIGZlcnRpbGUgbmV3IHNvdXJj
ZSBvZiBidWdzIGFzIERhdmUgY29uY2VybmVkLg0KDQp0aGFua3MsDQpydWkNCg==
