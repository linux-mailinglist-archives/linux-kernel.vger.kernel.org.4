Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD36AE723
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCGQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCGQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:46:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B5302B7;
        Tue,  7 Mar 2023 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678207425; x=1709743425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HU0rfOfIwqbi+COaB7gJMM6GSx65yAVfUrWsy3CZK8M=;
  b=Je5GYTqA3l9GtwXyMRWDrNsDgZQI81FIWDXg7JMT6JpCN+fxSJjPw/2m
   9OGdjeD95230VL1J5rii6bYiT/iCPIP3F/03hRwVGDRlK91F9/khDz/j8
   uGP28ir/0PG+3V6MvyS1DQqkThlKudmSc41HRnp9VAS16Sy0c/GQTEhxv
   wr3dQinAAbbdyau+FZsUPjuZpF9+fgQze8rYlQ3mSTbIiRCknJFNW+nqY
   iqttisLWC/RJP01E6AWOSdL2gTAu1CmaiXNdpT/37Mh5HKLVlF8ygjowh
   VzSWJijyu0evJRqNbCe4utJBwgoo976iE2N0GrUJAWbE0YP+iZFAa/AXj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324208421"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="324208421"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="654037397"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="654037397"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2023 08:43:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:43:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:43:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 08:43:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 08:43:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJqaf5nGNHFq9r69H4AzwIEY+6LfOIJPj8Pv8/mGVL/NrOqOb/1nzdvw2Rj1azlCNPkYGeaCNtMX23sltD+7lXMPM9nv+IKpR37GsK1ukS3qj817az9LdjHgME1+6cpEFGKu050uIMZfaJStBbVi4Gbsr9JTC/kdANI26FWfhFXidmHUCLeOWaRzv0MyXqUHe02kAuxK99dTr4oAUFdY9+Wu9xroQhK7malNRpuXhmqXiX+G6QCef+C8Jskq8UyJ1M6Dy6PIy/dQ5/HJiXM2rJBk4ndG9zK7Elc9gFF54iB4J9zdlo+KdbU9BIDlXgmJ4z3kMOe+MtiOLp7I5P5Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU0rfOfIwqbi+COaB7gJMM6GSx65yAVfUrWsy3CZK8M=;
 b=jfiz4FqtJjyn3ZYaLgMHsm4d/kjHjoUZ0xpQ6sxG73FlIJrxyd6pMYOFcchvXLbQ1/B6t9bF8r1HRrfvGflqWvWEBh+Tn9KmioLUpUiyOFyiI07HR5BsVTKTGImiUZesHriPfFySXrUbdweTCe0FQM/5AhMy5lqkVkkjlwqC21CSyeL/ySdLdSd08zXZDahSM/7erx/+AEPi09btFX0g9zKFqNrQBMWNWh5AGmRGCIUEEhXcdMHv4QECb1hYMvWqV2WdsYcKUPvTa6GzAetkuSf79Z2L38ylYdMH65RIM+vykuCY6qh6FfjrpiR3eRYWNUgxFg4FH/TXbdpHgv99qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 16:43:39 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6134.024; Tue, 7 Mar 2023
 16:43:39 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
Thread-Topic: [PATCH v1 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
Thread-Index: AQHZTgXCADX3q3nR90eQLtuRLGZfaq7vi+GA
Date:   Tue, 7 Mar 2023 16:43:38 +0000
Message-ID: <f8c87ea7a1fd8f763ff4ccf3c43706ae43f81ede.camel@intel.com>
References: <2148907.irdbgypaU6@kreacher> <1936685.PYKUYFuaPT@kreacher>
In-Reply-To: <1936685.PYKUYFuaPT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SJ0PR11MB7704:EE_
x-ms-office365-filtering-correlation-id: cb0bf465-d59f-4615-c8bf-08db1f2b1a4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Qo10ZuftGvx5uWJ8/m8MwKw5WlK7BDi1ntGKWfG5JXNyyyop76NCdtPPZzqyuENGbUnyeaqw4legAExH3UVWWCaraEr7HHn4wURAvuEqpJD9qx+eL0pEMkzgskiAWIBwlVb4NJWcdGJ2RsTf4R932DDXWSienpCR2EFtUmFPbronENJePMlExfXAEvrC7jvkvhx2Dyy/rYCZETNUQrvAT0KZ2U0B4GoJssJen88YEgmuAPBoo/IMbNtecZrz8cw9HqN3HSwFv4XeTbx6X7UgnjD+shPjqowNpeTiH5mycb9cF5E/r99ARnjMFuXPujpVMaQ5tkR+bstgFuvMcK9slwupR2S/oMU9FH7noidhQmLgbDM+7A9v7WJe+brB2iijdhR4Ugk0s9DOJXiMBT828DbhQenPwti/LQZpdU05ZKvMduBdHEv7NecmpvgVaQb7aTK7kTXaOQB/QLvY05o6FaKIxk7jF+I/uTnSAhL5djXDE1HVWtkfwAhgbPVQ0VuaqfHPd01pP9EMF1+B+x101ao79f874XbnDh4o8VHtcnyYKLvnBCd3ziC/9p+/qP/Q87p+eO9Vl8dnApW2bFIYtnUiGdpPh1D3bnNb9rVjmCqHmVUuliGGQZNjqlgz5uso3OKnVyAc5chhNSEuUQZHlxXpDSg51lE+Zu+pdeHsMoQ80bqrusU6nt4DsJPhDpHK51Jict6bwiiKTcpJxX5Yz3YpjBs6c3OOqSGvSHkylQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(15650500001)(5660300002)(2906002)(8936002)(84970400001)(41300700001)(64756008)(66446008)(8676002)(66946007)(76116006)(83380400001)(66556008)(91956017)(54906003)(316002)(110136005)(478600001)(71200400001)(6486002)(966005)(66476007)(4326008)(6506007)(2616005)(86362001)(186003)(6512007)(122000001)(38100700002)(26005)(36756003)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJaZXFxeXdlbGxFN01MMSs4M0RkMEp0MC9jVGJReUl1Q2VYMEJnUXRkNDZp?=
 =?utf-8?B?LzN3aEswZ1dzdG1lRDU1aU80ZDZnYWxtblcrU3YwNzFTNzlJVm1DaDJtbXVP?=
 =?utf-8?B?MUhwZ3F6OHJBUGJlWXlyTzQycmdEL1Y2c0t0Q3JjME9wZEo0eW14SFhjY0M0?=
 =?utf-8?B?U0dDc21sUjVmOXpHSW9HamdzN25ad09seVBxek8yVkpIZGgyZmM2WU1KOG1l?=
 =?utf-8?B?RFpEcTBldTRhc1NYYkR4WG5qZmlpdThVTW1KYUovYXB4LzNkSDJaYTlrakY2?=
 =?utf-8?B?Yk9Gb2tzdkJwWkswZTV4MHY1V2RuVkNvVUVQZURPb1FmZUw4Q1UwVlRNY3Zj?=
 =?utf-8?B?ZGVKbmlaWE9jQmVUeWZIem1YUkR1ZjJFOUYrUVA0OXlORGVlUkx3RUVRMSs0?=
 =?utf-8?B?eXpxbjJSeFlRUVpmSFBYd1lNdTlwSWtNaHY1a0tEbHdNczlCVTRtcG5nK29x?=
 =?utf-8?B?V1MzSDFQKy9QRW9FaFZPLzVEWXhxd1Vad0tLN2VJQmF6bnh5ZjduUVluRk5i?=
 =?utf-8?B?Q2M4cXBaMjk4b3BabUtMTG51SHZtUXByZ2JMSkxCdVlrSEdmTDJsQWh5K0xN?=
 =?utf-8?B?eUs4T29Va0ZUVVF1Zlg5Z281ek1mWFVVQ3dMOEI2U1JDSjNwTkI4ODdYcktk?=
 =?utf-8?B?dENVR2Q3WjM3NnNMbC9helJ3UVQ1UmhJS214OGlpRHpEOVRjYUNQNTYyeEJJ?=
 =?utf-8?B?TDFDM3U0b05PWkhhUFBtL3VNTnhRNGdEQWYrUUxpWU0xMERnZngrMXQxT3gx?=
 =?utf-8?B?V3ZaTXNzVkZHTE1wSXFrcXVDOFVGU0Jhek53MDlZSDJjU3hpVU9KcWZuVk1j?=
 =?utf-8?B?dFdPYjBaZ3drblY3bi93WkNkdklnY2N4UWJzd0Y4UDhRb2s4QzBlVjdHUkhL?=
 =?utf-8?B?YkhGTjg4d0tGQWp1aFRhSjNhMytodE9EbGtxY2FHaG5mbkxuUU5qR2RDbmtu?=
 =?utf-8?B?RnROL0dwSVg5UXVIbDJ0SHhHclRURGpSZ0hwNk1JdC9CMXRYYWt5b05nS0Jj?=
 =?utf-8?B?dFk5S3dRNWN1NW1kZ3g5TXMrN0dyNVBXc3VaVmh3ZXFsZkE2ZkJHdVU4Q2Mw?=
 =?utf-8?B?ZjBQdVNtc0s5WnRYZ01TTWVJc1RUb2g4MjlXcDFFMldaK2hqaFAzTEtVWnRG?=
 =?utf-8?B?ZzVBd1FiZ1pkMkdrWWVBa3Y3SnJCTW56UGJRaElUOGw3azBHQWYrd2R6UjMr?=
 =?utf-8?B?d1h0YXFELytTdzdkM0J4VTJGMzlLaGt4QTZmRTZoYjg1bVFKZllZeWF0NzBC?=
 =?utf-8?B?bUFlMzdSY2gyV1FwZmczSDNBcWZHaWwzcGd5MFBRendHalI4T2hpVm0rNkor?=
 =?utf-8?B?QkRUaEttdTBhWHlDS3BNeWw5R0plWUt4bWFnUGUzQlROeUhLSjFUdmhMTFBv?=
 =?utf-8?B?RnRKVnhDWE1Dck1Zalh3MDBqc21MK3EvWnFVWTB2QmsvdlpoZkZpMTc0ZkJp?=
 =?utf-8?B?dG1jcEEzVm03VTJTN0VuZFRzSUxMUGVDSDg1cU1iVGFZN21scEdySE1KazVH?=
 =?utf-8?B?d0FaSjgwbU95dksrYlF0aHF3ODV1K0Q5Qk0zaDBHcFpYWU5XaWx4TFFER2Ix?=
 =?utf-8?B?UFl1bEFjWHJ5NzkrRTlWd0VuQXZZSlpBb2lvSkVKdnVoNmRjZDUzNWhtREps?=
 =?utf-8?B?a1piOEZSY24xSk9zcGl6VTVxU2gycjhtaVRYVDIwb0pXRWM5TERsODFNR0Rp?=
 =?utf-8?B?L2NHY0txRW5qVDkyZ0Zvbjk5bXNHNStYODJjaW5XbHZaS2t0OWF0ZnpiVzFP?=
 =?utf-8?B?VVlDaVp0dlBsTHRDd2l5ZWVacVRYTkZuZlBldXF4T1VCaU9xZXNrVXREUjg3?=
 =?utf-8?B?REUzRGlLWEtZM25JVG4vNlQxb1Y5NzNGNTY3cHlRMUhoa3BOVURXREcwdzBw?=
 =?utf-8?B?eGVsa0Y4eE91Vi9jak5mRGw0M0VpaWZubHVneHlhOFByd1ZoRFozRGg1c290?=
 =?utf-8?B?SmQrSUs2dWlaRktxcHJwV3pqcHd2cUdyNXY1c2ZMdnBkektGK0syVmhjK3py?=
 =?utf-8?B?SFNFamJyTmw3cDl2MkJXVjd1OXhqZ1BEV0ZJclBHaHdqMXBySGZWQlE3dlY5?=
 =?utf-8?B?bFM2SzZGM0JaQ0RLd1hsNTFOeDBtUGU5bm9sTjFFd2VsMEc4bENkd1UrVVFy?=
 =?utf-8?B?UFJYUy8zZ2pTeFBIOVFCUTkxQ3NsWFM4eHFhT3ZKcmlpYkZzcE85WGZGN2hh?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6116316942EA684D93B9DB3E71A74709@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0bf465-d59f-4615-c8bf-08db1f2b1a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 16:43:38.8104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWHZtNx/mc6VmUECnjbUXAXh5E6V5xg2aRn4yaezGE4tqbVDZnMXf7LDiSVLkWa0mVJyy7cJLcr/QgQjv7fSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
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

T24gRnJpLCAyMDIzLTAzLTAzIGF0IDIwOjIzICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gV2hlbiBhIGNwdWZyZXEgcG9saWN5IGFwcGVhcnMgb3IgZ29lcyBhd2F5LCB0aGUg
Q1BVIGNvb2xpbmcgZGV2aWNlcw0KPiBmb3INCj4gdGhlIENQVXMgY292ZXJlZCBieSB0aGF0IHBv
bGljeSBuZWVkIHRvIGJlIHVwZGF0ZWQgc28gdGhhdCB0aGUgbmV3DQo+IHByb2Nlc3Nvcl9nZXRf
bWF4X3N0YXRlKCkgdmFsdWUgaXMgc3RvcmVkIGFzIG1heF9zdGF0ZSBhbmQgdGhlDQo+IHN0YXRp
c3RpY3MgaW4gc3lzZnMgYXJlIHJlYXJyYW5nZWQgZm9yIGVhY2ggb2YgdGhlbS4NCj4gDQo+IERv
IHRoYXQgYWNjb3JkaW5nbHkgaW4gYWNwaV90aGVybWFsX2NwdWZyZXFfaW5pdCgpIGFuZA0KPiBh
Y3BpX3RoZXJtYWxfY3B1ZnJlcV9leGl0KCkuDQo+IA0KPiBGaXhlczogYTM2NTEwNWM2ODVjKCJ0
aGVybWFsOiBzeXNmczogUmV1c2UgY2Rldi0+bWF4X3N0YXRlIikNCj4gUmVwb3J0ZWQtYnk6IFdh
bmcsIFF1YW54aWFuIDxxdWFueGlhbi53YW5nQGludGVsLmNvbT4NCj4gTGluazogDQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtLzUzZWMxZjA2ZjYxYzk4NDEwMDg2ODkyNmYyODI2
NDdlNTdlY2ZiMmQuY2FtZWxAaW50ZWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4g
V3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9h
Y3BpL3Byb2Nlc3Nvcl90aGVybWFsLmMgfCAgIDE2ICsrKysrKysrKysrKystLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gSW5kZXg6
IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jDQo+ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl90aGVybWFsLmMNCj4g
KysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jDQo+IEBAIC0xNDAs
OSArMTQwLDE0IEBAIHZvaWQgYWNwaV90aGVybWFsX2NwdWZyZXFfaW5pdChzdHJ1Y3QgY3ANCj4g
IAkJcmV0ID0gZnJlcV9xb3NfYWRkX3JlcXVlc3QoJnBvbGljeS0+Y29uc3RyYWludHMsDQo+ICAJ
CQkJCSAgICZwci0+dGhlcm1hbF9yZXEsDQo+ICAJCQkJCSAgIEZSRVFfUU9TX01BWCwgSU5UX01B
WCk7DQo+IC0JCWlmIChyZXQgPCAwKQ0KPiArCQlpZiAocmV0IDwgMCkgew0KPiAgCQkJcHJfZXJy
KCJGYWlsZWQgdG8gYWRkIGZyZXEgY29uc3RyYWludCBmb3IgQ1BVJWQNCj4gKCVkKVxuIiwNCj4g
IAkJCSAgICAgICBjcHUsIHJldCk7DQo+ICsJCQljb250aW51ZTsNCj4gKwkJfQ0KPiArDQo+ICsJ
CWlmICghSVNfRVJSKHByLT5jZGV2KSkNCj4gKwkJCXRoZXJtYWxfY29vbGluZ19kZXZpY2VfdXBk
YXRlKHByLT5jZGV2KTsNCg0KQWx0aG91Z2ggdGhlcm1hbF9jb29saW5nX2RldmljZV91cGRhdGUo
KSBoYW5kbGVzICJwci0+Y2RldiA9PSBOVUxMIg0KY2FzZSwgSSB0aGluayBpdCBpcyBiZXR0ZXIg
dG8gdXNlICFJU19FUlJfT1JfTlVMTCgpIGhlcmUuDQoNCnRoYW5rcywNCnJ1aQ0KDQo+ICAJfQ0K
PiAgfQ0KPiAgDQo+IEBAIC0xNTMsOCArMTU4LDEzIEBAIHZvaWQgYWNwaV90aGVybWFsX2NwdWZy
ZXFfZXhpdChzdHJ1Y3QgY3ANCj4gIAlmb3JfZWFjaF9jcHUoY3B1LCBwb2xpY3ktPnJlbGF0ZWRf
Y3B1cykgew0KPiAgCQlzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByID0gcGVyX2NwdShwcm9jZXNz
b3JzLCBjcHUpOw0KPiAgDQo+IC0JCWlmIChwcikNCj4gLQkJCWZyZXFfcW9zX3JlbW92ZV9yZXF1
ZXN0KCZwci0+dGhlcm1hbF9yZXEpOw0KPiArCQlpZiAoIXByKQ0KPiArCQkJY29udGludWU7DQo+
ICsNCj4gKwkJZnJlcV9xb3NfcmVtb3ZlX3JlcXVlc3QoJnByLT50aGVybWFsX3JlcSk7DQo+ICsN
Cj4gKwkJaWYgKCFJU19FUlIocHItPmNkZXYpKQ0KPiArCQkJdGhlcm1hbF9jb29saW5nX2Rldmlj
ZV91cGRhdGUocHItPmNkZXYpOw0KPiAgCX0NCj4gIH0NCj4gICNlbHNlCQkJCS8qICEgQ09ORklH
X0NQVV9GUkVRICovDQo+IA0KPiANCj4gDQo=
