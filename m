Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817A68CBCB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBGBPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBGBPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:15:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4F9752;
        Mon,  6 Feb 2023 17:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675732517; x=1707268517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x7Zr8cAtF0F/gPptJf92pnK5iCZrDdlm7D1+lMlXLH0=;
  b=jg9t+Crz1iE7wOkLktfxnNtuKowZDjGLYBTdvkWGgDvNbpo8LPcub8m1
   yaIAPU4yNUcq0wfSzUgbLxMZdcEB2usSEJdkqSb681WvZsaFfqCqaxTt0
   izAYAj9ixttKB+5gJYmFru/Ew4Xorgq0kTnXX3vM9bvIkRJLIHGXxXDnM
   rcClf+LUBQJAJe8pQ4AfErXRzTNbPKphRUakHhLiVpvxu9mHDwH8En85t
   aErXCO0DOoxQPgT8RFL++Zao9JzGTPG7kpWj3gJgyBj3xW1D+8ef2xBDx
   W+559/QeLWP8PaxDCFqd1WOftz5Py7QXwyKizgV6/7aR5RvtJAB5F9m+M
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317384336"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="317384336"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 17:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="809333621"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="809333621"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 06 Feb 2023 17:14:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 17:14:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 17:14:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 17:14:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 17:14:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enOUTQBKx0/kCLkXc9W2mZ92XMFc4rn+k/A8l0Hao9ACiwF7/zt3gzw10oxRaR9rhY2E0+F/PR9QkaqAxgTeJdkU2H27gNQBfNVNjIsqeTDQ7aXIdHwx0/wOJcZOuL05PawQn/M/uGpajAje5ZpsWxMdJB+tSS8hl15vSsXKWWj/HPHT6SZKlduDC8zRZL/g6+MGY9iZnCSr2SSzc8MHnTAq1HqcPrwILYp6a6iGWX/KdA5xOAIkrTvlFOXvmuBnf09IZYhEK0hSOU+kSrRy/ou6JGud1YCUThv09E2UvlPZaDBkstwCMBYPpULcAtn3Z62wwAQad9HNwuD0GXLF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7Zr8cAtF0F/gPptJf92pnK5iCZrDdlm7D1+lMlXLH0=;
 b=CH93U8VK6p+DznvYrTatHC92o0tAjsIgdqPUgZUrVzERxpPZ6P1aRyYenJk3TDeG/O49nT2lhPEYHMqZKHSM2tTYeNyPXXx/nu1Z+z2XVaP9tiy2t3Q8HkwhYWyzUpX4d5hqs+mAImcV5kWu2U0Xms1T3uRLS+zfLqZJ5s3WKZfNLbCH+gLDi2CnWNkKO9TtR46xafQp4dhRWsK71VNhv5BhS/eiq9aRB1mGFgU6Jg2Eoid+tD/vOFr5TByJNz/Kz6hlhGI086lzdpzdkU7FKm+hE+LDng/xTWBZYifV4wi+5uIzhiWQa8TmXos/2SrC3ye8RS4PBvGfmHPYFO2wIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB7184.namprd11.prod.outlook.com (2603:10b6:8:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 01:14:00 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Tue, 7 Feb 2023
 01:14:00 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Topic: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Index: AQHZOD9ejAi0bsndXU+9RwTFzHNkO67BPBpQgADxxACAAAE9AIAAf3aw
Date:   Tue, 7 Feb 2023 01:14:00 +0000
Message-ID: <PH0PR11MB5880E2B1C4A0A4DFA46C3B7FDADB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230204022051.2737724-1-joel@joelfernandes.org>
 <PH0PR11MB58800C6FD1C0DDF8EC67DB5DDADA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAEXW_YRwe781s1faLQcRBvL5pBWv9WmRuhcP=PmqHUJcm9Rphg@mail.gmail.com>
 <CAEXW_YSY5nYL4LUoAX1Z8kUXtE-GW3Zor__cDWsdPL3OqEe4bA@mail.gmail.com>
In-Reply-To: <CAEXW_YSY5nYL4LUoAX1Z8kUXtE-GW3Zor__cDWsdPL3OqEe4bA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB7184:EE_
x-ms-office365-filtering-correlation-id: a1dd7cf8-db64-4b74-761a-08db08a8984d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NRQycPjVAxq3qK0M+exk9NoYTZJ+Nv3izP50fnhCDzcW4TU5c7GgsaGdcfpTiwGE1FTjOzcNCylwm7g6qC3zCCt7It0xoYYPxPZCQSvzM7EHTYtwUYqEEH4ZmD6CaUgcNOxwnh4t0Y+9MWLoLzY53mW5J/Im3D73B2hnbKOaiBOuSE8HxLn0I6EkAExlMR2ztJXGk6OqXX/viUAyLXQlPTqixO/ZsNR2gTWMZQoqEzCJbhnfidO1Bt1DWi2mcjCKGgoOkmtVsT9AN3X4Cq8shqmcm4KpfDq3t8YkfTzQpANOkXewpTly/Xzs2yhdR70+uKsJkNrpnA5wiAAN4I5BA2VUunA/z7vlFQWXI04z3ee1FTc4/d7LEj36aNZnzKu+2h8vGV1/XXPxm6BSOWtaJtIsmT22KlnOoE6SrPonh/Ih+RbwcJsN/iaF3est/rG960JE6Z/J9q+O+0zfvZ0jWv9qicbmc/fYKc60mzqMT/NPN/Q0j4akVhMVgreiF3JPDfKpeeL2x012ZVCOc76RJnM3KQ/ys7oCyFIzi7OJTYt6Dmu2OARL9dBVBbGXoh19HS8ZCa1JgrG8F+0pWrMe+uEAorVpxFfdwkZm5dtUH65Fa0WKK+CGwtnqDDR0TU3zSeL7Mn2QYgtGQNBhW7ePqLRuVsOgf3rmrFwLPTRzz2GBQnWmuvamMxAW7b7I6XRkT7FGFlB6MBBnrlhTdRgqausQLj/FqTEUpLQM00EE8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(33656002)(86362001)(38100700002)(38070700005)(54906003)(2906002)(82960400001)(122000001)(41300700001)(55016003)(7696005)(71200400001)(966005)(316002)(478600001)(52536014)(7416002)(8936002)(64756008)(76116006)(8676002)(4326008)(66476007)(66556008)(66446008)(66946007)(5660300002)(83380400001)(6916009)(6506007)(9686003)(26005)(186003)(53546011)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTVzNzUzdjNKb3Y1NmxYM0Rzei9xNUdFZ2tFK2tnSklXMjlSZHFqM1hkQ0Y5?=
 =?utf-8?B?M2RQZ1BTdXBPRmFqbHFsZ1g3Zy95QVYxdnc0RzJDS2MxSkhpUy9tY1E2NDVm?=
 =?utf-8?B?V1hOSEk4VW56cGNvaXJCVGR3WDFDQW1ZVHAwNVNuZnlWUG42UVZ0RjZhRzl3?=
 =?utf-8?B?dWkxMTVOUzNXNEpPWWw5TVNqOFJWY2k4TW5pQU1NTGFzdmR2UzZ5N0lTYTBP?=
 =?utf-8?B?bFdCNzgwdXp6dGFyQjZaNVBIdlk3WW8yazF1VlFHaDV1Z2pRRENuWmIxNlBW?=
 =?utf-8?B?YzBvNFhWZm5XL3VRdGVhdjIrVW15eXdWMXRYdzZmdldzNTdCNE1WeTBzQXhI?=
 =?utf-8?B?MTlaL3k1VFVLS2hKVml4S0w5S0NrQllLN2dzTFJ1MWg1dzdaK0pQK0pMZGJK?=
 =?utf-8?B?QWFMdlh1Z3NMUFVXRFR0NGtka0NSOHpkNml0ZWc3SFBEWERsQ2ZqTDFZZ0Z6?=
 =?utf-8?B?eG9PMkVHRU55azByTmR4SDNZOEs4Q3VyWWlWRGhaOWRCMkZVaTAramw3eHg3?=
 =?utf-8?B?WVQxV0IvRkNGaEdudkZ4QVFiSENuMVdyc3liVGxYM2lyTnB3T0dqd1ZXdFJh?=
 =?utf-8?B?dE0raXBIdUxTTTdFSVFFOEREOHJtQ1Nlby9lMmxHOUNZRWdUSG16cWE4SE9P?=
 =?utf-8?B?WVBEOWx0TFFZNVBZZU9KN1VQa0xsTmFHTmFOV0lhMDgzZkszWjZjV0FWMCt0?=
 =?utf-8?B?NjhxUDNYZC9LRnVPcEh0RE1mdUM0dkNQSkZFUHpYeHBKRlVLWm5FLytaNnhi?=
 =?utf-8?B?RXR0UkdQTlcrR1ZjZ2RxejBFUk9ld0EwaUIrVnJEUVU3MWtiaURhVGc3QXNF?=
 =?utf-8?B?MzczQTRIMzhWYmtsdHVFc1g0U3E4NVJQYXVsN01PTjdZUHE3M05ESGU5bk94?=
 =?utf-8?B?MGg0VG9pekcxRHRiL2d0Wm1OUnRFV1NNYytFcWlsMlRmRklyZ2d1REpLa2xj?=
 =?utf-8?B?N2kvcTFqemUyTDBYanptUjU4YzlFVHZMWDdOWG9aMmZkbTFIenk0WXQ3WUo3?=
 =?utf-8?B?Z0xWQXhPdzh6cjEwTjVOdGp1RU84RTZGNHlVc3VYa05lY3VGM0VBSytldVdF?=
 =?utf-8?B?YTIrSUFVS3U1Y0dreVRRWXhSODJhNldoa0s5V0srbm5zTENYQUVMcEpjOUpa?=
 =?utf-8?B?S3RoSGhaZUx6SG5IQzdTZ2ZEa3ltYkdIOWVvbmNveks4Ung0WHlRdFloakZQ?=
 =?utf-8?B?ODNEcGVoNTAwcWxvYTVJMTNGM29rR3J2d1I2MTFRU212YkpGa2J4VFlsc1p2?=
 =?utf-8?B?bWl0OUxyTERnbEFvaVc1YWozM3oyenQrVkh0MHZIYkp3clE3UmoyUGUyNWJ2?=
 =?utf-8?B?bW91NjQ0T2d5VFVnTzlHMExSek5WejZuS0loUVZ2UWYyUjJ1TlIwU3d2VjZj?=
 =?utf-8?B?bFlrRW0zZ0xtTmoxWmI0UDB5OWdOK0F0dUtrNVdzbDZoc21YSlB3MDlOYUxY?=
 =?utf-8?B?SmFWdFRqVXNUT1RNNGZnN3RPam5SeURGK2RVOVVtTi80NkpBSjFEZVM1NXFi?=
 =?utf-8?B?L0hORjFEK0pmc1B2ZEtQY2xYbUNqS28yaVBDckt5SFhRcG5Va2dHVk1QTXZq?=
 =?utf-8?B?elltWlpuUkNnbE5GQ2JzWXhCNGF5WGwyYlhwWnBPTjlnZzZBenVTNnBKZ0Nm?=
 =?utf-8?B?RjR0T1NVaUxEeWcwOEFTRmszNzNyU2tjanJSL21RaTdVZW96aFNSSVord0JV?=
 =?utf-8?B?ZjlJQVVPaEJ1K00rQk95Ly9Zazd4c1R1bjZsZDIrSm1Vb3BoMjFFSHJsVDN0?=
 =?utf-8?B?bU9MdzVCd2xCV2JoNGFWR2VhYXBBaStTOGlYKzJIR3V2WE9XZTFiUG9sVXg4?=
 =?utf-8?B?Q0FCVnI5UGQrT0FlM3VIVGVIWCt1YkpTRGYxaWFFTFRsM2UrWU9FY1RMRlVZ?=
 =?utf-8?B?QW1RT3Z4TkkxZk9SeWJUSHlVUkdtZ3hlaklNN0xIaUVMdnlYUno5dnk1QWNH?=
 =?utf-8?B?V2xLVzZwTzRLclBva2RMNm4vd2JTS21rNmY0U3VWdlpJYzBSTUVMb1l5bExO?=
 =?utf-8?B?ZERhYk5TUjIveUUxVTFId0Fnd05HRWJOZ241dmxvZWFmUDNSWGlsNTJjOVdr?=
 =?utf-8?B?N0s3dmlFQURwSVFoUkdsNHBseTBYTmRzcmlibnU4aWxmcHM1bUMzUDEwSlRQ?=
 =?utf-8?Q?6Hv1x6q61g+NAsa3FTvVzl2Fz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dd7cf8-db64-4b74-761a-08db08a8984d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 01:14:00.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKLJ2Zb959ooKDNIJIzAx2H51BCpLDeQbpACkp8R4JE0xD7sMN9U5hYEfg9kKQZzdcZVHIpFjosAbBhR+Vb2Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgNiwgMjAyMyBhdCAxMjoxOSBQTSBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2Vs
ZmVybmFuZGVzLm9yZz4gd3JvdGU6DQo+DQo+IE9uIFN1biwgRmViIDUsIDIwMjMgYXQgMTA6MDkg
UE0gWmhhbmcsIFFpYW5nMSA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4g
Pg0KPiA+ID5SZWNlbnQgZGlzY3Vzc2lvbiB0cmlnZ2VyZWQgZHVlIHRvIGEgcGF0Y2ggbGlua2Vk
IGJlbG93LCBmcm9tIFFpYW5nLA0KPiA+ID5zaGVkIGxpZ2h0IG9uIHRoZSBuZWVkIHRvIGFjY2Vs
ZXJhdGUgZnJvbSBRUyByZXBvcnRpbmcgcGF0aHMuDQo+ID4gPg0KPiA+ID5VcGRhdGUgdGhlIGNv
bW1lbnRzIHRvIGNhcHR1cmUgdGhpcyBwaWVjZSBvZiBrbm93bGVkZ2UuDQo+ID4gPg0KPiA+ID5M
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAxMTgwNzMwMTQuMjAyMDc0My0x
LXFpYW5nMS56aGFuZ0BpbnRlbC5jb20vDQo+ID4gPkNjOiBRaWFuZyBaaGFuZyA8UWlhbmcxLnpo
YW5nQGludGVsLmNvbT4NCj4gPiA+Q2M6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtl
cm5lbC5vcmc+DQo+ID4gPlNpZ25lZC1vZmYtYnk6IEpvZWwgRmVybmFuZGVzIChHb29nbGUpIDxq
b2VsQGpvZWxmZXJuYW5kZXMub3JnPg0KPiA+ID4NCj4gPiA+LS0tDQo+ID4gPiBrZXJuZWwvcmN1
L3RyZWUuYyB8IDEzICsrKysrKysrKysrKy0NCj4gPiA+IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID5kaWZmIC0tZ2l0IGEva2VybmVs
L3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPiA+ID5pbmRleCA5M2ViMDNmOGVkOTku
LjcxM2ViNmNhNjkwMiAxMDA2NDQNCj4gPiA+LS0tIGEva2VybmVsL3JjdS90cmVlLmMNCj4gPiA+
KysrIGIva2VybmVsL3JjdS90cmVlLmMNCj4gPiA+QEAgLTE5ODMsNyArMTk4MywxMiBAQCByY3Vf
cmVwb3J0X3FzX3JkcChzdHJ1Y3QgcmN1X2RhdGEgKnJkcCkNCj4gPiA+ICAgICAgIH0gZWxzZSB7
DQo+ID4gPiAgICAgICAgICAgICAgIC8qDQo+ID4gPiAgICAgICAgICAgICAgICAqIFRoaXMgR1Ag
Y2FuJ3QgZW5kIHVudGlsIGNwdSBjaGVja3MgaW4sIHNvIGFsbCBvZiBvdXINCj4gPiA+LSAgICAg
ICAgICAgICAgICogY2FsbGJhY2tzIGNhbiBiZSBwcm9jZXNzZWQgZHVyaW5nIHRoZSBuZXh0IEdQ
Lg0KPiA+ID4rICAgICAgICAgICAgICAgKiBjYWxsYmFja3MgY2FuIGJlIHByb2Nlc3NlZCBkdXJp
bmcgdGhlIG5leHQgR1AuIERvDQo+ID4gPisgICAgICAgICAgICAgICAqIHRoZSBhY2NlbGVyYXRp
b24gZnJvbSBoZXJlIG90aGVyd2lzZSB0aGVyZSBtYXkgYmUgZXh0cmENCj4gPiA+KyAgICAgICAg
ICAgICAgICogZ3JhY2UgcGVyaW9kIGRlbGF5cywgYXMgYW55IGFjY2VsZXJhdGlvbnMgZnJvbSBy
Y3VfY29yZSgpDQo+ID4NCj4gPg0KPiA+IERvZXMgdGhlIGV4dHJhIGdyYWNlIHBlcmlvZCBkZWxh
eXMgbWVhbnMgdGhhdCBpZiBub3QgYWNjZWxlcmF0ZSBjYWxsYmFjaywNCj4gPiB0aGUgZ3JhY2Ug
cGVyaW9kIHdpbGwgdGFrZSBtb3JlIHRpbWUgdG8gZW5kID8gb3IgcmVmZXJzIHRvIGEgZGVsYXkg
aW4gdGhlDQo+ID4gc3RhcnQgdGltZSBvZiBhIG5ldyBncmFjZSBwZXJpb2Q/DQo+DQo+IFllcywg
c28gSU1PIGl0IGlzIGxpa2UgdGhpcyBpZiB3ZSBkb24ndCBhY2NlbGVyYXRlOg0KPiAxLiBTdGFy
dCBHUCAxDQo+IDIuIENQVTEgcXVldWVzIGNhbGxiYWNrIEMxIChub3QgYWNjZWxlcmF0ZWQgeWV0
KQ0KPiAzLiBDUFUxIHJlcG9ydHMgUVMgZm9yIEdQMSAobm90IGFjY2VsZXJhdGluZyBhbnl0aGlu
ZykuDQo+IDQuIEdQMSBlbmRzDQo+IDUuIENQVTEncyBub3RlX2dwX2NoYW5nZXMoKSBpcyBjYWxs
ZWQsIGFjY2VsZXJhdGUgaGFwcGVucywgbm93IHRoZSBDQg0KPiB3aWxsIGV4ZWN1dGUgYWZ0ZXIg
R1AzIChvciBhbHRlcm5hdGVseSwgcmN1X2NvcmUoKSBvbiBDUFUxIGRvZXMNCj4gYWNjZWxlcmF0
ZSkuDQo+IDYuIEdQMiBlbmRzLg0KPiA3LiBHUDMgc3RhcnRzLg0KPiA4LiBHUDMgZW5kcy4NCj4g
OS4gQ0IgaXMgaW52b2tlZA0KPg0KPiBJbnN0ZWFkLCB3aGF0IHdlIHdpbGwgZ2V0IHRoZSBmb2xs
b3dpbmcgdGhhbmtzIHRvIHRoZSBhY2NlbGVyYXRpb24gaGVyZSBpczoNCj4gMS4gU3RhcnQgR1Ag
MQ0KPiAyLiBDUFUxIHF1ZXVlcyBjYWxsYmFjayBDMSAobm90IGFjY2VsZXJhdGVkIHlldCkNCj4g
My4gQ1BVMSByZXBvcnRzIFFTIGZvciBHUDEgYW5kIGFjY2VsZXJhdGlvbiBoYXBwZW5zIGFzIGRv
bmUgYnkgdGhlDQo+IGNvZGUgdGhpcyBwYXRjaCBhZGRzIGNvbW1lbnRzIGZvci4NCj4gNC4gR1Ax
IGVuZHMNCj4gNS4gQ1BVMSdzIG5vdGVfZ3BfY2hhbmdlcygpIGlzIGNhbGxlZA0KPiA2LiBHUDIg
ZW5kcy4NCj4gNy4gQ0IgaXMgaW52b2tlZA0KPg0KPlNvcnJ5IEkgbWlzc2VkIHNvbWUgc3RlcHMs
IGhlcmUgaXMgdGhlIHVwZGF0ZToNCj4xLiBTdGFydCBHUCAxDQo+Mi4gQ1BVMSBxdWV1ZXMgY2Fs
bGJhY2sgQzEgKG5vdCBhY2NlbGVyYXRlZCB5ZXQpDQo+My4gQ1BVMSByZXBvcnRzIFFTIGZvciBH
UDEgKG5vdCBhY2NlbGVyYXRpbmcgYW55dGhpbmcpLg0KPjQuIEdQMSBlbmRzDQo+NS4gR1AyIHN0
YXJ0cyBmb3Igc29tZSBvdGhlciByZWFzb24gZnJvbSBzb21lIG90aGVyIENQVS4NCj42LiBDUFUx
J3Mgbm90ZV9ncF9jaGFuZ2VzKCkgaXMgY2FsbGVkLCBhY2NlbGVyYXRpb24gaGFwcGVucywgbm93
IHRoZSBDQg0KPndpbGwgZXhlY3V0ZSBhZnRlciBHUDMuDQo+Ny4gR1AyIGVuZHMuDQo+OC4gR1Az
IHN0YXJ0cy4NCj45LiBHUDMgZW5kcy4NCj4xMC4gQ0IgaXMgaW52b2tlZA0KPg0KPkluc3RlYWQs
IHdoYXQgd2Ugd2lsbCBnZXQgdGhlIGZvbGxvd2luZyB0aGFua3MgdG8gdGhlIGFjY2VsZXJhdGlv
biBoZXJlIGlzOg0KPjEuIFN0YXJ0IEdQIDENCj4yLiBDUFUxIHF1ZXVlcyBjYWxsYmFjayBDMSAo
bm90IGFjY2VsZXJhdGVkIHlldCkNCj4zLiBDUFUxIHJlcG9ydHMgUVMgZm9yIEdQMSBhbmQgYWNj
ZWxlcmF0aW9uIGhhcHBlbnMgYXMgZG9uZSBieSB0aGUNCj5jb2RlIHRoaXMgcGF0Y2ggYWRkcyBj
b21tZW50cyBmb3IuDQo+NC4gR1AxIGVuZHMNCj41LiBHUDIgc3RhcnRzDQo+Ni4gR1AyIGVuZHMu
DQo+Ny4gQ0IgaXMgaW52b2tlZA0KPg0KPkRvZXMgdGhhdCBtYWtlIHNlbnNlIG9yIGlzIHRoZXJl
IGEgc3VidGxldHkgSSBtaXNzZWQ/DQoNCg0KDQpUaGFua3MgZm9yIGRldGFpbGVkIGRlc2NyaXB0
aW9uLCB0aGF0IGlzIHRvIHNheSwgdGhlIGdyYWNlIHBlcmlvZCBkZWxheXMgbWVhbnMgdGhhdA0K
aWYgdGhlcmUgaXMgbm8gYWNjZWxlcmF0aW9uLCAgdGhlIGludm9jYXRpb24gb2YgY2FsbGJhY2sg
bWF5IGJlIGRlbGF5ZWQgYnkgb25lIG9yDQptb3JlIGdyYWNlIHBlcmlvZHMuDQoNCkNhbiB5b3Ug
cmUtZGVzY3JpYmUgdGhlIG1lYW5pbmcgb2YgICJncmFjZSBwZXJpb2QgZGVsYXlzICJpbiB0aGUg
Y29tbWVudHM/DQoNClRoYW5rcw0KWnFpYW5nDQoNCg0KDQo+DQo+VGhhbmtzLA0KPg0KPiAtIEpv
ZWwNCg==
