Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D257263AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjFGPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjFGPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:04:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBE619BA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686150282; x=1717686282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ifRFXdNUpOrjGaXLYUlH0hluyidmBgUNFNoOIdg8CIE=;
  b=aZkQLKfkhKP4Kd9MGZPOHrRCL5gHML9NcLcZkZdfInHhpecBkekZVENF
   rIfXk8k7UFiQHubMKC0K8FClVu3ThAeiCvXHOVrP/6erRMub09ipFTcMs
   ZMS5vuFuZmg38/dFFi0eumoJSkvGsS0IiD5DOwOdWQDg4CHfPSHTBztU3
   t5TDd7cOtURYysI9eqGzsft90rMNRlJN7NEDygCNCR1Eqc/o/QL1b15pR
   oO3kugakIt+8zxHLmGXzBcpNa0bVVhpTBd4Fl3XNqfYsjnZCazPL1AxuJ
   hVJLSZaEh7SBizg4jXpo19fpoQB7KLjncmsmSUD2zJ8XD3BShxS+xDdSs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346625438"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="346625438"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956312345"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="956312345"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2023 08:02:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 08:02:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 08:02:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 08:02:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 08:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0mHYgkXYLAwnVU/0UvbURLlnyjSNcV0F4zewWNPtXy1q0HaNaHgqqLt1UMH0Ma/kHF0KdA+HXbzw0Vi0EOxuO+uYMmjXj2ikyJXUgGbd96kg4i46KARkMDEpacKb8tYE0tzTDRpumx071zhRAKBwBvDcfi8AIXU5CuKIe4CYgus999GlBlCH63s8mQORwld0jpaXdgcMmbD4AfIcm2w+gm9BRjGwplggA4xBPHDdXQTICm8bBVXtMuRj/1GQHe6AP9Rnjtc97Fl30qpgYwbKsqjOjRTi4Tf0PZnBulBnDTY+m+ykKbo6U+7NGQt7LhKAzEcQvrYKDDCwum+5FySzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifRFXdNUpOrjGaXLYUlH0hluyidmBgUNFNoOIdg8CIE=;
 b=VnNzmMcsaIzRCWYYCyMmLJG+8p+jpkLmyNKuMGZz2GVIzR3SgGkSCfqgZoAU24H5+M+d2C8C0EkusskUWR6NX4Xo2wFrhTTzfyuU8YD9PBeNP323EMKJjyjwuNv4NZcJF7dalM8uYHKRVsZhKlY3TRo6P9AhoUnP/x0KlJV1JeoE1V4wHQ2YO3we9KUL6CfQ9XlS5Ix6uPaV6QAHE6ByjVBekEk6BmmSmTGWKiuHYJQZIzPrNM5nLugSSRE1DW2/uaKfB/bmIiyhaw9rFO9sociy03o73WhC8Cvlx99Ptt6n+ipvzpnhQZx8l3I8NhX10AqTccCbGoFIbG+mLtgHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 15:02:33 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 15:02:33 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>,
        Dennis Zhou <dennis@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v2] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Topic: [PATCH v2] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Index: AQHZmUurECJuEzqoAE2zotVyE9hBN69/acvg
Date:   Wed, 7 Jun 2023 15:02:32 +0000
Message-ID: <SN7PR11MB7590D5959AF7179137A314FEE153A@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <20230606125404.95256-1-yu.ma@intel.com>
 <20230607145009.58899-1-yu.ma@intel.com>
In-Reply-To: <20230607145009.58899-1-yu.ma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|CH3PR11MB8186:EE_
x-ms-office365-filtering-correlation-id: 554e2c95-10be-43d9-5b83-08db676838c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtMVtmzd7JuoxOBSd8Keic1M9VidJg4FHKVoy0kx01YeD/wh50dlQgVtpLKyxEnN1Z7703Yqn03RfZSpRs/v7nXwDidMAL/SNbkIFcqDcUe/jD+YSkfvEx0Acx7A/C2e7HhKCbsHe/46hDAhRn0UHz5ZikmqA23FL6EkD3iVff4F8MH4vByGw9xS06G1diTqyQ7EM5xFOCI56deRi3K9qIuvUBQO23OXCh2uUsOJHud24LFDXWErOFy+boypxSqVGSxn1PH6ffS6AfqUI6CtE4gGgj4cFzYC1ZAMf/sVt1TfIcci2iAIbZUUrXjlLsJv+Fig2viKF+raU1g+kHEt7Bwy30GhygiC56XDBP17Ndtebu0ZKdxITQBEyxlEaWNje9eCzwoNcgbz7hKGs2VsSRxd6OLSayvUcPsdBBxHpXWRDXoq9IfAbrq9OAtxvBoBSYwi1ptw57TcMIyqHXvqcVUoAeN+n7plYyLNmjlbpQ3I2/+dvKjeYIQxGlKHGMSo2ZlT7WBuyyb5l0XX/o790Z/7CR0ttwfRTRsl4cSIKsD6U3LYR2BzixW5/9sYWTzN1PhcaRx3udE06DPA77tWF4syPdKZ8OIpWlIrhXLRLfCh90Co+PfJGYzssq+agb5X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(478600001)(5660300002)(52536014)(38070700005)(110136005)(54906003)(8936002)(8676002)(71200400001)(316002)(4326008)(66476007)(122000001)(64756008)(76116006)(66446008)(66556008)(66946007)(41300700001)(38100700002)(2906002)(82960400001)(55016003)(33656002)(6506007)(9686003)(86362001)(186003)(83380400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bStlWVg1bUYwOGVjNWlkVTR0ZkhxM01OTThzT1BYTWtodnRJRjdLZWY5RjZ3?=
 =?utf-8?B?QmlOYVk1eUtqdzZmN3krUm1wSThQNWt1UUNiRkdDK25xNStaRzZoZEhRRHZG?=
 =?utf-8?B?djgxelNHK0JUSHF1cGlMNU1JMm5UalVwL3cyUFM2SEpKR1dPV1NOTGIwbi9C?=
 =?utf-8?B?UjkyT291YUpyTHI4OXgrb1hPRzZUYzJNZUVrYnhGZWlramZCREs1M2hPWW93?=
 =?utf-8?B?ejBOd3ZRTnlTODBBRG5OcjNLRFlPVHRFdHNhRmxHUFN5WHBTeGNiSkkvL0pU?=
 =?utf-8?B?b2Q4Rm1qVUs4cXFuKzBnZXdHUmJVbm92eVhFUzRoc3VQY2R4bUxDUWFrUWVl?=
 =?utf-8?B?c1BCc1NkTjFveHljS2pqQUJ2OEZoWHU4MzU3aU9qNGhVdW5nSkdRWkVickxk?=
 =?utf-8?B?TXhaNlhpc3RDY1VNRHFWZyszWU1uR01oVUVWcS9rUUZZanE1aUFDWXpReXFz?=
 =?utf-8?B?aTlHRVlaQUpGQVJiQUpkV2YyZ2d4ZEs4SkRrSjduTmI2L2NSL3ZGMStPd3Ra?=
 =?utf-8?B?b0liSkk5UFpDdTZzbE1VVTZTaU52RSsrVkFBaDNtcUNjN09EdU10cVo3MzNu?=
 =?utf-8?B?WGs1QW5sblR3b3VsM0pQSDJNUlJJKzVsVnkrdHNYd2VkTDVlVGJpalNCOUxI?=
 =?utf-8?B?L2FWM2pZRUhqMXdDVXZLSExTUnd5a21hRUZmVVppZzNoRUpIUHE3bVcrUnp0?=
 =?utf-8?B?cG5ZZ0dWMlZVV09jYmdUYU93NEE3Wkc1dDFEN1dHVlkxcHJ2anZNbU5NbjBl?=
 =?utf-8?B?Y2g2MFhLVzNodE8zTm90TXE4Mi9FVHdxOVVONXd1amgydDYvQXk1SzduYzBv?=
 =?utf-8?B?b1NXT0RiVmRUYmtPKzdEUmozN1J1NGVERkJMRDRYMjRlTVVoMldUaGFmeHEy?=
 =?utf-8?B?NTZublNURm4rUUhhVUw3dHltdkYrNXZFbkZza3pTQitWVzlzNjBwYVZWZ3Zw?=
 =?utf-8?B?bkpiUlJIemVHWENCQjc5bWZKc1htdWJnMGxFVlFnNjRKK010eDJqY0lnUHl3?=
 =?utf-8?B?YVhTc1hBRkdmWURibGNaanh6YW83VlliMFFpb2FPUFNSbFhhVzlTMTliRW1l?=
 =?utf-8?B?Sk8wYnUvd3MwYUd4Uk9wVnczcGh0Q2tuU3F6NktHMjBWNkNpekhjVWVRTWRY?=
 =?utf-8?B?MmtWckJDMVoxNXcrNHIzdFlNY0F6NDNseTJjb0FtQnBGaEdNUFNsdGZaRzdX?=
 =?utf-8?B?ODBuUHBOamkxcGJyWWRYb1RrMHRSUDBQYThBYjNJdUJ3UlI4VkdCcGJZSVI3?=
 =?utf-8?B?aC9hUTh6K21EZFo3bnljcGd1c1BNYVlyTUxBc1AzY1Rid04rYnovdkZTSDFB?=
 =?utf-8?B?ZDVsK09UQUwxTlFRejJHNTZVQ2h0TW04MWwrMDdxSzBuS1pYa01aYng4L2sw?=
 =?utf-8?B?SzhTWXVscG5laU1QMkR6S3lwS1R3NklzMDFad3pxeUQzalBxbXM1d001emdk?=
 =?utf-8?B?b1U3UXBNWmdXL05TSloyNE03SU5jTmNRcU1GYUt6OFdPRFRuOFdsbWZQMTFJ?=
 =?utf-8?B?elVEOGRLNHdzYWF5aTBKN09pYiswTHZmYWZKTnUyK1NGb21YL0diTVZ6RGlN?=
 =?utf-8?B?RGtKb2FHV0JoUGN5UWpuNFNIcHNzciszZXlxMVYzSE9BSzE1ei9MV044UEcy?=
 =?utf-8?B?UWxPUFhnWnlmYmVZcmgxazFQZVlBZlozZGRqMW9SOWpqMXpOeGJXc3hJZmpj?=
 =?utf-8?B?ak5MM29oalBNa05lUHJTcWMwSlVNejVkV3NlU0VyelBySFVLcy9QZEJwT3py?=
 =?utf-8?B?d2NaVjZXV2JjQURtNUVSUXZseGNVc1NxYUVqaTdwTzF3UHd4NmE5MXRlL3l1?=
 =?utf-8?B?Tk93eWF5bWZ2bGcwKzBicUZ3Y3RkWmZNNGJjR3oxcitTcXdieHJ2T0lRa3BI?=
 =?utf-8?B?eG56SGN4ZVBVZ2NUOXRZRFgwREg3S3Q5TmUraUFFQjkzYk1tdHRYYjUyY2Nq?=
 =?utf-8?B?STFmTHY4aktiNmtJSlZ1MDk2UEYrT3dTS0pRanBZSWNObHUwV21NT0pEZ0xi?=
 =?utf-8?B?NHVQVzBMR0IwODFwZlJ1MCs0MkxiOWdTbkV1NVZRdkxwOFBxWjdEL2c2RkJq?=
 =?utf-8?B?THlyNS9obm5XZTJNVGFnc2JydmZzbmw3d0I2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554e2c95-10be-43d9-5b83-08db676838c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 15:02:32.9646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvF7aAgb4yzpRqihZkP3MLIX+GB8NjvIbHUs1SRX/eCzBfkiXtx045qDDSyuY3XV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIExpYW0gYW5kIERlbm5pcyBmb3IgcmV2aWV3LCB0aGlzIGlzIHVwZGF0ZWQgcGF0Y2gg
d2l0aCBjb21tZW50IGFyb3VuZDoNCg0KPiBXaGVuIHJ1bm5pbmcgVW5peEJlbmNoL0V4ZWNsIHRo
cm91Z2hwdXQgY2FzZSwgZmFsc2Ugc2hhcmluZyBpcyBvYnNlcnZlZA0KPiBkdWUgdG8gZnJlcXVl
bnQgcmVhZCBvbiBiYXNlX2FkZHIgYW5kIHdyaXRlIG9uIGZyZWVfYnl0ZXMsIGNodW5rX21kLg0K
PiANCj4gVW5peEJlbmNoL0V4ZWNsIHJlcHJlc2VudHMgYSBjbGFzcyBvZiB3b3JrbG9hZCB3aGVy
ZSBiYXNoIHNjcmlwdHMgYXJlDQo+IHNwYXduZWQgZnJlcXVlbnRseSB0byBkbyBzb21lIHNob3J0
IGpvYnMuIEl0IHdpbGwgZG8gc3lzdGVtIGNhbGwgb24gZXhlY2wNCj4gZnJlcXVlbnRseSwgYW5k
IGV4ZWNsIHdpbGwgY2FsbCBtbV9pbml0IHRvIGluaXRpYWxpemUgbW1fc3RydWN0IG9mIHRoZSBw
cm9jZXNzLg0KPiBtbV9pbml0IHdpbGwgY2FsbCBfX3BlcmNwdV9jb3VudGVyX2luaXQgZm9yIHBl
cmNwdV9jb3VudGVycyBpbml0aWFsaXphdGlvbi4NCj4gVGhlbiBwY3B1X2FsbG9jIGlzIGNhbGxl
ZCB0byByZWFkIHRoZSBiYXNlX2FkZHIgb2YgcGNwdV9jaHVuayBmb3IgbWVtb3J5DQo+IGFsbG9j
YXRpb24uIEluc2lkZSBwY3B1X2FsbG9jLCBpdCB3aWxsIGNhbGwgcGNwdV9hbGxvY19hcmVhICB0
byBhbGxvY2F0ZSBtZW1vcnkNCj4gZnJvbSBhIHNwZWNpZmllZCBjaHVuay4NCj4gVGhpcyBmdW5j
dGlvbiB3aWxsIHVwZGF0ZSAiZnJlZV9ieXRlcyIgYW5kICJjaHVua19tZCIgdG8gcmVjb3JkIHRo
ZSByZXN0DQo+IGZyZWUgYnl0ZXMgYW5kIG90aGVyIG1ldGEgZGF0YSBmb3IgdGhpcyBjaHVuay4g
Q29ycmVzcG9uZGluZ2x5LA0KPiBwY3B1X2ZyZWVfYXJlYSB3aWxsIGFsc28gdXBkYXRlIHRoZXNl
IDIgbWVtYmVycyB3aGVuIGZyZWUgbWVtb3J5Lg0KPiBDYWxsIHRyYWNlIGZyb20gcGVyZiBpcyBh
cyBiZWxvdzoNCj4gKyAgIDU3LjE1JSAgMC4wMSUgIGV4ZWNsICAgW2tlcm5lbC5rYWxsc3ltc10g
W2tdIF9fcGVyY3B1X2NvdW50ZXJfaW5pdA0KPiArICAgNTcuMTMlICAwLjkxJSAgZXhlY2wgICBb
a2VybmVsLmthbGxzeW1zXSBba10gcGNwdV9hbGxvYw0KPiAtICAgNTUuMjclIDU0LjUxJSAgZXhl
Y2wgICBba2VybmVsLmthbGxzeW1zXSBba10gb3NxX2xvY2sNCj4gICAgLSA1My41NCUgMHg2NTQy
Nzg2OTZlNTUyZjM0DQo+ICAgICAgICAgbWFpbg0KPiAgICAgICAgIF9fZXhlY3ZlDQo+ICAgICAg
ICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lDQo+ICAgICAgICAgZG9fc3lzY2FsbF82
NA0KPiAgICAgICAgIF9feDY0X3N5c19leGVjdmUNCj4gICAgICAgICBkb19leGVjdmVhdF9jb21t
b24uaXNyYS40Nw0KPiAgICAgICAgIGFsbG9jX2Jwcm0NCj4gICAgICAgICBtbV9pbml0DQo+ICAg
ICAgICAgX19wZXJjcHVfY291bnRlcl9pbml0DQo+ICAgICAgICAgcGNwdV9hbGxvYw0KPiAgICAg
ICAtIF9fbXV0ZXhfbG9jay5pc3JhLjE3DQo+IA0KPiBJbiBjdXJyZW50IHBjcHVfY2h1bmsgbGF5
b3V0LCDigJhiYXNlX2FkZHLigJkgaXMgaW4gdGhlIHNhbWUgY2FjaGUgbGluZSB3aXRoDQo+IOKA
mGZyZWVfYnl0ZXPigJkgYW5kIOKAmGNodW5rX21k4oCZLCBhbmQg4oCYYmFzZV9hZGRy4oCZIGlz
IGF0IHRoZSBsYXN0IDggYnl0ZXMuIFRoaXMNCj4gcGF0Y2ggbW92ZXMg4oCYYm91bmRfbWFw4oCZ
IHVwIHRvIOKAmGJhc2VfYWRkcuKAmSwgdG8gbGV0IOKAmGJhc2VfYWRkcuKAmSBsb2NhdGUgaW4g
YQ0KPiBuZXcgY2FjaGVsaW5lLg0KPiANCj4gV2l0aCB0aGlzIGNoYW5nZSwgb24gSW50ZWwgU2Fw
cGhpcmUgUmFwaWRzIDExMkMvMjI0VCBwbGF0Zm9ybSwgYmFzZWQgb24NCj4gdjYuNC1yYzQsIHRo
ZSAxNjAgcGFyYWxsZWwgc2NvcmUgaW1wcm92ZXMgYnkgMjQlLg0KPiANCj4gUmV2aWV3ZWQtYnk6
IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
WXUgTWEgPHl1Lm1hQGludGVsLmNvbT4NCj4gLS0tDQo+ICBtbS9wZXJjcHUtaW50ZXJuYWwuaCB8
IDggKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9wZXJjcHUtaW50ZXJuYWwuaCBiL21tL3BlcmNw
dS1pbnRlcm5hbC5oIGluZGV4DQo+IGY5ODQ3YzEzMTk5OC4uZWNjN2JlMWVjODc2IDEwMDY0NA0K
PiAtLS0gYS9tbS9wZXJjcHUtaW50ZXJuYWwuaA0KPiArKysgYi9tbS9wZXJjcHUtaW50ZXJuYWwu
aA0KPiBAQCAtNDEsMTAgKzQxLDE2IEBAIHN0cnVjdCBwY3B1X2NodW5rIHsNCj4gIAlzdHJ1Y3Qg
bGlzdF9oZWFkCWxpc3Q7CQkvKiBsaW5rZWQgdG8gcGNwdV9zbG90IGxpc3RzICovDQo+ICAJaW50
CQkJZnJlZV9ieXRlczsJLyogZnJlZSBieXRlcyBpbiB0aGUgY2h1bmsgKi8NCj4gIAlzdHJ1Y3Qg
cGNwdV9ibG9ja19tZAljaHVua19tZDsNCj4gKwl1bnNpZ25lZCBsb25nCQkqYm91bmRfbWFwOwkv
KiBib3VuZGFyeSBtYXAgKi8NCj4gKw0KPiArCS8qDQo+ICsJICogVG8gcmVkdWNlIGZhbHNlIHNo
YXJpbmcsIGN1cnJlbnQgbGF5b3V0IGlzIG9wdGltaXplZCB0byBtYWtlIHN1cmUNCj4gKwkgKiBi
YXNlX2FkZHIgbG9jYXRlIGluIHRoZSBkaWZmZXJlbnQgY2FjaGVsaW5lIHdpdGggZnJlZV9ieXRl
cyBhbmQNCj4gKwkgKiBjaHVua19tZC4NCj4gKwkgKi8NCj4gIAl2b2lkCQkJKmJhc2VfYWRkcjsJ
LyogYmFzZSBhZGRyZXNzIG9mIHRoaXMgY2h1bmsNCj4gKi8NCj4gDQo+ICAJdW5zaWduZWQgbG9u
ZwkJKmFsbG9jX21hcDsJLyogYWxsb2NhdGlvbiBtYXAgKi8NCj4gLQl1bnNpZ25lZCBsb25nCQkq
Ym91bmRfbWFwOwkvKiBib3VuZGFyeSBtYXAgKi8NCj4gIAlzdHJ1Y3QgcGNwdV9ibG9ja19tZAkq
bWRfYmxvY2tzOwkvKiBtZXRhZGF0YSBibG9ja3MgKi8NCj4gDQo+ICAJdm9pZAkJCSpkYXRhOwkJ
LyogY2h1bmsgZGF0YSAqLw0KPiAtLQ0KPiAyLjM5LjMNCg0K
