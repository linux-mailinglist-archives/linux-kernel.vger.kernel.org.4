Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7374B6C11D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjCTMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCTMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:25:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD9B6EAC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679315106; x=1710851106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9gwLbaXHG63eJje7eTp7N+qruN2Lix13Re3Ef4ltqRk=;
  b=WsY1aO9Q2P8RW4XGXqhvyOI/pnEzaum5CjwxUmzQpj8EkGhMm9gIBoHu
   6u0fz5lhi741N01XoCsnuE6/O8HmxOtojZeP91VSZ7dMmiPNvAPT0zvNe
   v1OG4Qy+XYXuuSsmooOETfPIv/JAhmpD4OYhy1jzHlWlpMUirPpbt22+L
   UQYllW2giWLg8vSagcLEbiil5isGTMJ47ZymikO6cSWWA5CjLkFoWzOd8
   /qUO43bGBp8gbqNgoF8fgpXOWNRZTu4poW7bQL8+2Vm/FneftoE3wmk+y
   KWsOArH9d5nW4cWZUs11N2icxslxWxsu2y7u9UdQQJUNE2MWw4WwoRa0D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="322487805"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="322487805"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 05:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="658324341"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="658324341"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2023 05:25:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 05:25:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 05:25:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 05:25:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 05:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQbIlmiUoeo7zdN/Rtw4Mlhv+b1nMKoLqzCwdPrb3DIWiOUaRI/FSmCq8/bcbm3OYoQSDLKBpP6YRNaUZWrY8aIE7KyByNH9JVniocMphzIMBbnhgcrtP8qei+VitCt21lfTyQfEw4Zwb03jxRDla5ELjgWc32W3OKwvP0tHtC7k7gFwokGKU2lNzGcHmJG5F/qBxmzIvf4ZNgFktrF2yDaDa/EgEwy+uxMpRJbBquhk0hi+UJRfEoiXfMHNWpv+LfdN7nyZl0E0j3TVPxHn+mBMsbml7pBv5VXlYLFxOJAt7B5rdA/3m+e8/VzU83YjXtKan/ifMhSXfu8pe3ZjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gwLbaXHG63eJje7eTp7N+qruN2Lix13Re3Ef4ltqRk=;
 b=KnAxJt9HgBRR4nwVVBzT8mgiV0FGushyk8mPpeWR6CJJjW5xfHCZ7fkluI791MPIgIMvnSHewf2+P3XtS37AGYUZ4Nv4Ac6j0T37DwFRm8dW5YqKSJ2gUld+HWsDkV1QZ/dVFTterN085Ae/TKjWLQXsgud32wuYm7/A0FfsgUCaB6yRbK6NwWID7tQ2ui63kUnB62dHRVal/i5PRgPuv4w0eaJrxDO0z0uiUchcflEzfoXjZzHzpW5oZQ4ffPp3EqW2yMXCNSfiJ7KweToQCABFErSyAjggEdVKHJsxrK3TjCR4QK642fzDfwhOz/hfLgxpLx3CFIhxsR9XUO6ewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 12:25:01 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:25:01 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
Thread-Topic: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
Thread-Index: AQHZUEoW0WGn0EBjHUiA3Y4BEzr7Ya8DrWMA
Date:   Mon, 20 Mar 2023 12:25:01 +0000
Message-ID: <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>
References: <20230306163425.8324-1-jgross@suse.com>
         <20230306163425.8324-8-jgross@suse.com>
In-Reply-To: <20230306163425.8324-8-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: ceb12585-c3a8-4118-a448-08db293e2083
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hPN/MVTBB+ZnMAa0wR8fMUHLy5TEWY6FlSjGTcPfhFipnw8qNtCD9BlYTwRfbS+VcGwGLGKNArk/AKQsTIbJCg/HpTpR1mv/qtWnG01pDQhps7/tk+iIeWtdTlOmDw6Goqw2fOTGpYT7bDCgk8ZKc7Y1Yp8KSLNLQbgNUW1m8c4Z3gtexc2jpqqUbn6iaGk7w1w+fwt636MyTYYqbHkk3OoS4KGQMS1CoppQvK5sUhpPloi2K4zGdxcWNwRY0d0AaJRH0ScnqCtIRLCws6UUQHzRo7tHsDHSMJhaGfRZsVDeCWGE4RwL1UB7PKbv6upU0EYJoy65BmSjdm3hvNHUSbR33L0JOi3Otlr66wNuLPQjiM9fSQ3IfXeBU+tIk1jo0MZhmvBxg9Md3iJstk/7KQ8yeoatYEvKD+ShHZYGt91y3T9dFX8fcE/CJihfCf5lGY/6ZfEKvQYtzbkGFneTMz1AZaiK6aYAUOv0fL6Fe7xAuWsj+Wya8pf6h+4s0UmnJ/E2Vkn1iyrl1zlA38sG9bwIG4NUXU8214wEGLhnu8JGyuSKaW2iFz/ZsCkOBNdtvjErRq2zCGjsvxwBIjK56WkytY2YFbv1J4on8dfIfxNiszy5w0PRIix4hjQ+6UiWKbhFFDEBeirO22KboYYAm0aGJ8v8N1RgfbT2xIrMBCXz1XkKVP4azu8LlnEvIQGeqS0CNcgGXkUUZukQ+P4tzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(66556008)(2616005)(26005)(110136005)(6506007)(6512007)(6486002)(4326008)(8676002)(64756008)(316002)(83380400001)(71200400001)(66446008)(54906003)(66476007)(478600001)(66946007)(91956017)(186003)(8936002)(5660300002)(82960400001)(122000001)(2906002)(41300700001)(76116006)(38070700005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmNqZ2FtZFROQm14WVNBUU5lWTN0MjhLeTNoeGNhMUlZRnF2L0FMeFdwNUR3?=
 =?utf-8?B?d1dDd0R0U1lBL25hLzhoWjFxa0kvUlB4VVd5N01mRnhqWnQzbDR4QldheE16?=
 =?utf-8?B?d1NEZytkZTZTNTRBWXQwVkRJdkRENFoyRDlUcVRNOUhJaENJZU5CNmJlSzNm?=
 =?utf-8?B?YUozUGhWZVRsOVlsOVhEZzRNMzF5bkN1Wk9DVUNhemRTUUQwVm5sRHg3dUlO?=
 =?utf-8?B?SW5BeW5GRG1aSVVCNStQdERxYzRTelpVUWloaVJROUU0dkd6Q1NIQVVOT0lN?=
 =?utf-8?B?TFhvZTErWVdQaWdjYm8yNWJYZVg2d2ptakhnVHdndGNiZUl6VTNWVEp6NmNK?=
 =?utf-8?B?OC90Uk0vcHRFSnJnOGYxRXJKSDVGVXZjYnJzOG1ENjFQNTk2M0dwdW03TkIw?=
 =?utf-8?B?TkFYa3FXbHpsWEYxczJQSm8xV1A2V1cyUWxXTDVEMmZIeDJFcnFPZVlueFhy?=
 =?utf-8?B?c3VXVENJMmt1U0lhWVJSdlBocnVaUG5KQ1Qyc0FRekpLL01Yd3Y2TG51UTU0?=
 =?utf-8?B?U1JIQU9XOTB0d0dpMUpUQjlobUNkczN0djlVWHdkMmdkS0Y5Y0c5OWlVSjA1?=
 =?utf-8?B?ZVBWMVUrRk80VlMrditwVHZJS3lySy83R0hzdm5WbHJCTGRldkNYLzVFaTZW?=
 =?utf-8?B?OHBEVEVNbmsweVNZNjdNM2I1c2k3aXhtNWJDdDY5dDJpNkFEemVEVDJrTVNV?=
 =?utf-8?B?dnlta0g3Y1FhOENYeVlVT2dPeDlaaVh6TjE2dFhuWkVLRzNiNGJmY2t4WXRF?=
 =?utf-8?B?UjJzMWt4K2FJTXFjQjFrcjhRWnVUWnlVRkJydHI5Zm9TOHRlTUduaFhDQUhN?=
 =?utf-8?B?N0toVk9TeTV5UURHU3hDT3pBODNhVkJwb2UwYk9DZjFqVEg3WllNMXFiWUlD?=
 =?utf-8?B?V2l6WWVzQ0FWTDdoU3BoZVdsaW5iQnRDTWdabVQzWlVHb04xWXFkT2IzYmVp?=
 =?utf-8?B?M2RnZUI0bXlNb2djQjJaM1o2MGUvSnE4VXJLN090MEk5Y3U2VG1pa0tHUkl1?=
 =?utf-8?B?aEsxNkZneUlpZHZwTjBHcUZkaVJKZjNyUUNZaUF2NlBBZm54L2E0ZDVXcG9F?=
 =?utf-8?B?QVlpUm9OZW5KMEVTL3p5Q29wT0hLTmpRMFlyblVYVC9ISjE3WjdiZGVVaWg5?=
 =?utf-8?B?bWYzTitxUkNXeTNTNHpKZWMxcldVUzF1T1R0ZWhINXpwUFZTbjlkdDhWMklh?=
 =?utf-8?B?Y2xOc1RhdTY3NmJzQnErRUQrZ2JMMEd6Wml6L1pMYlVpNFNVdjJoRjNXZ21t?=
 =?utf-8?B?VksrMUp6blhnaFBmMCtFZndCbnYyM1RsZnJBWXN0YStlNUhLU016RVFqWitG?=
 =?utf-8?B?OEFmcTRxckZjVnZ4Q21QSGFhVUp3YUR5dVh4SjJZU2I5NWMxRGZvMjN5UWJE?=
 =?utf-8?B?bVBMdU5abUFzbEU1ZmVhZ2pIRTAvRDZmeHZxRTI1ZUpabys2Rk1RMlljdkIz?=
 =?utf-8?B?WkNHTTdxMWZqaVoybDRQdWd0MkZtTFN4aWg5ekgwUUFNMlJ5OGVva0U2S1ky?=
 =?utf-8?B?a3o1N0ZxTEhLSndWcDllck5weDJoVTR3azhEbU1PUmwxM3dNby8wQkVWSjVJ?=
 =?utf-8?B?Vm4rMldSWGx4S0xkZmZOVGVjQ1ZqM3FwaGZyNEFlNExvd2dCM3dlaFVndDQw?=
 =?utf-8?B?M0ZiSnZydjg4UmY0RzMzclhOdlo2ck43L1E5NHR3SStiMFlRajRydW9NQkNY?=
 =?utf-8?B?bUdtdTREOHFudVdxV3oxV2lXVFVJclZpektSMGZndEcyTXdHc1pnVVlWS3g0?=
 =?utf-8?B?RVdWUlhSeHdBRmNRQVd1ZlJLY0NYQkZQRzlNNGJqc3JtblA4YmJyRUxIWkVi?=
 =?utf-8?B?VFBMZUJRaldOTUF5VVpqK2JsaXVWanQwMXVCRnFLaWJ6VGFpVkpHdTcvWmtG?=
 =?utf-8?B?ZWlmK0hCVHhVRzhxcjRySGlUWDRTS2YwRVk3eDd1dEw5blRHRHBMMmFlUTc5?=
 =?utf-8?B?MUJXd3M1dzZwY3QzMkkrSngxbWxsQWlvYVFtanNlR2tBZU05ZjNSMGhtRFNl?=
 =?utf-8?B?ektrT0EzdjdjQmVWL2Y3cHMwNEJEVnJlWWdEaXg4bTVPRGhIQW5DR0lwT3Y5?=
 =?utf-8?B?bEE0VGtobTJYTTJzSXUrRFFHcGNsNFR1Z1poYWFDbHgycjZaVVVkaVNIQWdx?=
 =?utf-8?B?Ukk2TW9qOWM0T2I4WW9jWjdnM0lmaGJpcVNwRStWVlhSVzZZbzVvTWxTZlZm?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A1976861DFD334FB818166841E6306C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb12585-c3a8-4118-a448-08db293e2083
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 12:25:01.3266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbulUzD9Ouazn19BsWQ3wssiX13AsopcURPBW4T0Bi/BCbgcDg42VVGPq5gR6rzDDOgvfpgrfc2COwDMpJ0JXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTA2IGF0IDE3OjM0ICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiBUaGUgbXRycl92YWx1ZVtdIGFycmF5IGlzIGEgc3RhdGljIHZhcmlhYmxlLCB3aGljaCBpcyB1
c2VkIG9ubHkgaW4gYQ0KPiBmZXcgY29uZmlndXJhdGlvbnMuIENvbnN1bWluZyA2a0IgaXMgcmlk
aWN1bG91cyBmb3IgdGhpcyBjYXNlLA0KPiBlc3BlY2lhbGx5IGFzIHRoZSBhcnJheSBkb2Vzbid0
IG5lZWQgdG8gYmUgdGhhdCBsYXJnZSBhbmQgaXQgY2FuIGVhc2lseQ0KPiBiZSBhbGxvY2F0ZWQg
ZHluYW1pY2FsbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NA
c3VzZS5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyB8IDMg
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4gaW5kZXggMGM4Mzk5MDUwMWY1Li41MGNkMjI4
N2I2ZTEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4g
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiBAQCAtNTgxLDcgKzU4MSw3
IEBAIHN0cnVjdCBtdHJyX3ZhbHVlIHsNCj4gIAl1bnNpZ25lZCBsb25nCWxzaXplOw0KPiAgfTsN
Cj4gIA0KPiAtc3RhdGljIHN0cnVjdCBtdHJyX3ZhbHVlIG10cnJfdmFsdWVbTVRSUl9NQVhfVkFS
X1JBTkdFU107DQo+ICtzdGF0aWMgc3RydWN0IG10cnJfdmFsdWUgKm10cnJfdmFsdWU7DQo+ICAN
Cj4gIHN0YXRpYyBpbnQgbXRycl9zYXZlKHZvaWQpDQo+ICB7DQo+IEBAIC03NTAsNiArNzUwLDcg
QEAgc3RhdGljIGludCBfX2luaXQgbXRycl9pbml0X2ZpbmlhbGl6ZSh2b2lkKQ0KPiAgCSAqIFRC
RDogaXMgdGhlcmUgYW55IHN5c3RlbSB3aXRoIHN1Y2ggQ1BVIHdoaWNoIHN1cHBvcnRzDQo+ICAJ
ICogc3VzcGVuZC9yZXN1bWU/IElmIG5vLCB3ZSBzaG91bGQgcmVtb3ZlIHRoZSBjb2RlLg0KPiAg
CSAqLw0KPiArCW10cnJfdmFsdWUgPSBrY2FsbG9jKG51bV92YXJfcmFuZ2VzLCBzaXplb2YoKm10
cnJfdmFsdWUpLCBHRlBfS0VSTkVMKTsNCg0KVGhlb3JldGljYWxseSBkeW5hbWljIGFsbG9jYXRp
b24gY2FuIGZhaWwsIGFsdGhvdWdoIGl0IHNob3VsZCBub3QgaGFwcGVuIGFzIHRoaXMNCmhhcHBl
bnMgZHVyaW5nIGtlcm5lbCBib290IGFuZCB0aGUgc2l6ZSBpcyBzbWFsbC4gIE1heWJlIGEgV0FS
TigpPw0KDQo+ICAJcmVnaXN0ZXJfc3lzY29yZV9vcHMoJm10cnJfc3lzY29yZV9vcHMpOw0KPiAg
DQo+ICAJcmV0dXJuIDA7DQoNCg==
