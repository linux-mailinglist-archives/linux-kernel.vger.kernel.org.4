Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6670A088
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjESUYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjESUYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:24:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E7102;
        Fri, 19 May 2023 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684527857; x=1716063857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v4AyMo3X83cYKsUB0TpL4Ozs9mAsymz5q4i/clUvCdw=;
  b=ipUdR510kRQYV5Dxj5e03uEyWbt30B9viPGHVtiE9eyJZDfYZ5m5pUx3
   y7cHAmkuDU7ypliF/cG94X/qAwfXjjniENE+YG/zC1iruy4FDLP+ggkA+
   LFL+n63BM3oCiCtUEqXQsc2lJzd2jZDCIVZLFcdl646ka6wdh2GMnFqvJ
   PUynOtpBO5eE1PHqTfBDHB1d3SL9ZCA4cWYYN+L3TM+PnXWFMHQGHRG3l
   BL7I8b9xtoSc/mVO5o7V9TzyuOes1Dss8JmtIDLyFbCELmTI7ocBhjeCf
   0v58J+x5GPkMfvENtN8vBmOfINScvFdcq1psJYS+toYWFJbu+hNmaEXuk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="337065367"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="337065367"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 13:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="696842336"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="696842336"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2023 13:24:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 13:24:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 13:24:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 13:24:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 13:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVdU6Qi4Q4e6CusiSjQ3EyRzhNZ6XJ7cF+Gn7r5TOPbdM0WCHB2OwPBf38o+svS5vWBHrJUGQWPPSSViJA2/YlLm8EctTM/WTYfDhcLAuIhhZG/2MPF5kl7Jn2bBIUKiA5gWWorMwJgPIaORYAMGw8LSeOPm23M4P227mHFvxk/LfcNkqqPWVmGBRwxE6DV/c1yaLehxmtVzC92HFMCAYH3LISZVNOj0yr5bhuJTR2oO3QCNwHp9+2q46sQypHyRDDFYK5Yj3DyNsYeDsIU+pLksozSAaTIyriU3JHLjyob3uk1/MnmkPuEZ+DrAPgsDjRo/RYQnrA04XRNGooAT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4AyMo3X83cYKsUB0TpL4Ozs9mAsymz5q4i/clUvCdw=;
 b=cHk4EK08FzrZYCRFHIWUVsUtrjwFCKWnCDtm+gAP+RPYFIOT261yXocEIPI1Zy99SCcYX4ASLw+OIUP8IA50lC9GfyKhkVhwdSiSU+ziKMxr67jA6bfJCQOkP9jkH60FYypgTBZ23iNmTdjMEVimF08veFukCRGCZVOYHAq284OOMM0WsRvxo+Tw9epDZE54pog2qe/9h50pWdLmnadYT05yMwvgkGN2Y4qiC0N1lep01M16n5p74ol6LQOkkfSQbrdd9uvfv3Qb5mnFT2hUIQemBV/xgLOsKW9ywbwaD9JCzxbOcWB2ndhqjrNs/3dauzV4o6xTcVZDTjlT0bm6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by MN2PR11MB4600.namprd11.prod.outlook.com (2603:10b6:208:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 20:24:13 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 20:24:13 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Schofield, Alison" <alison.schofield@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Thread-Topic: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Thread-Index: AQHZdMfj1+vIA1W97kmyE2uj67BBM69hEfOAgAEkPAA=
Date:   Fri, 19 May 2023 20:24:13 +0000
Message-ID: <2bf4a3a8f34e71aa2b2be2b88fe22f58004eb699.camel@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
         <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
         <ZGblx0pCpJPvCS7M@aschofie-mobl2>
In-Reply-To: <ZGblx0pCpJPvCS7M@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|MN2PR11MB4600:EE_
x-ms-office365-filtering-correlation-id: bc1db4ac-9caf-4e68-2c49-08db58a7030e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjgKpLS6PGrAR6zD3xT1BxzE/9uVlCsWHahBU7nbesOLgj8xK/k1QM86RVERAkdb3NsUWkiua/bU90WVqiGnEeA7h/HjJ4srA3gUdHXbrdYXhom7ENthA4GRmAn67Go+mLWj9fHv9F4UXuHiFC8vjy5dj1fWiMkZasqZuZccvsm4dBO+vDvELo4j3dO0Hq+ek0hZ5X7GDeufWUeABbFMcZJvrEv8LNfWjaBLxArRLmOlSjmTR/FKfNfKhv9UxsHlDf2uyNANf2rOXImm9opv6MXzJypD1n40mibXmvN8BF+7R8Wdu/mmUhOGSX4p4dVLPuooO/VuRJ4rNcR2kjk+JYDz6G/E9QjL/6G+2SjOIiCl2OLjyXAxEeUEYnmujmfWLqUlkORUk0Ujf3eGQzc/8gfERazIAWQq6DWDbX/hwladKh0V5bIwolA4mqs5Y2u67q6MNMIqOOpPG5mLWikRk6egZBazelXQeJJ46lU7AhhcvZ42DJiYioBkWtxTUMDloNYUQYF8nmRbcmEvDczUCbzVX5xl65M8N83BHcrX660ab/zTVgBfPcGuO66nFESb9h03qvgOK6HeYcHpRrw/Zhy1Cth9nO9F7AQ4A/6zdjwGQuFVR0RCIKRuMWKmidC5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(2906002)(5660300002)(122000001)(38070700005)(38100700002)(36756003)(86362001)(82960400001)(2616005)(91956017)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(6636002)(4326008)(6512007)(26005)(6486002)(37006003)(478600001)(6506007)(54906003)(186003)(71200400001)(6862004)(8936002)(8676002)(316002)(107886003)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmVqTXplbzRLeFpKejhpeUZBNXYrckFQTS9kUkJXMzRrNHQ3dW1CblFGak1G?=
 =?utf-8?B?MnR5RHBhREJXZ1J0TFZialMyMWlkYW1NZ0dnREdtQ0tHa3p3T1F4MUphUCtm?=
 =?utf-8?B?b0xkMkJEcVJaVDcxVExycDlPQ2Q3TEZBMkNTRG9JbEpuK3hmQnViN04xTmVP?=
 =?utf-8?B?bkpNNGdHbHRHMHpPdm00VjBwblIzQ1RwdmkwN3F0YzRKOXo4QmVhQ3YwTi8x?=
 =?utf-8?B?ZDZBV0xWNWt1L2M1c0dNTHNkODJmQU1aaTkrQVZBOEMwR3Q5cnVrbmJCNmJG?=
 =?utf-8?B?TDF0L2pLU1A0UXordVo1Tmtma0FDZm1JS1ZrMFhaMlB2MGJ2MzVENGY2TWxy?=
 =?utf-8?B?WTE2NkFpd1EwVm1JUktucGtCdlpxU2xlRFVSTjBQZVBwQTh3YXNDY2NZR2lB?=
 =?utf-8?B?RCt3L0hpQ2I5cndSaDVQN3NycXdFK0x2b3IrVjJCcE5Hd3VJYTEvMkJYK1Fo?=
 =?utf-8?B?NUhOZGtTVTgyNjBBV2NtejgwLzhDRmhUKzZBVTUvRklaNCt4eG5WNzhzK1pW?=
 =?utf-8?B?RWxMWWFtTXdMZ1FVbWVEV2hvY2VHdUNma2pqSEFWRC9YSTNjVnBwc3JDUnp0?=
 =?utf-8?B?WEprMEYvZ3RkRGFMRVBaMEFad09URS8zd0txSmpreVArYXZoRXBSRmUzZDZs?=
 =?utf-8?B?SG1JN3VycGVuRWJYUFJXQnhPZ081OWphaDJUR2l4Ny9YOHVRYnBZalB4ZHBD?=
 =?utf-8?B?cllJSFlVbUJGMUs4TWNDZ1N3QTRuVi9NTnU3VFFUUHZDM3JmaXJ2Qng2YmtT?=
 =?utf-8?B?UEZUMkgvb0VxYWNrZ05FMll6d3RNY2hqRVhVdFZhMGt4U1lQaXUvWjBMYVQ3?=
 =?utf-8?B?NW4wbHJBOU9kSTVwbUxQMmJVR2dEZnljVnBRZlJ5TG82Z0czNUNvUWdRZU5P?=
 =?utf-8?B?Z3Z4bXM5N2lVeG9rUGtuMVRQLy9IN2graUU5SWZMU1grWWRPU2RGZ0pJc0VY?=
 =?utf-8?B?Mi9NcVpzYkErSVVUZlErcjFCU3dqZkgvNTFpUWZjMExyVWRvU2NkT2dRSkRH?=
 =?utf-8?B?b0l0Q0JzZVVYMWJwTFpZeHR5UENUREJ0akdjREZzL0tSeEt0ZUQ1SkhKYUJk?=
 =?utf-8?B?WXlYSHNSQnB1ZVE1MXluRHpaREowU004Nnk5MDJPemVwOWpad3Z4QS9KZjdQ?=
 =?utf-8?B?Z01DcUhqNHoyVHZyTUlNYlA4OW9UYlNIaU9EeWg0MDZzb2RIdGkvZk1MVUEy?=
 =?utf-8?B?Nm1UYnBPVWxQTUJwMVc2SmxnTWtXVTBJWm5NMWNVemUzamVBMDJIbllOTGxU?=
 =?utf-8?B?Z0pvSDRNM0hHRWRaMTczdXBkZ1B2SWxuemdtSUNsSmZTVHgwaHFoZ3NVRU1M?=
 =?utf-8?B?dVBGbUUrRlpWNDhEaEV0NUxzeGY4U1lCakROWmVJMzk2bkcrWnFvR0N1NVZR?=
 =?utf-8?B?QUE0VXMzWmsveE85a20rRjlLbUd0dEMyR21zSWtKSkZ0WTlhOGFtbVNJcmdn?=
 =?utf-8?B?bFI5RjZadmFQOFdwNFp3U2wrN3UyTEZodnRUK1ZNampwL3J4UmdEbitWODRv?=
 =?utf-8?B?dXVLc3VFTEhQV0Y1cGR4TkhETTA4WFFMRkJYL1M3MnQrOUZydU5zMVlyQjZY?=
 =?utf-8?B?RHZOemxYYUJ6bEFUbDFaMWxlTStsWnUxeWNMaWhldXFXT1B2bzhnd3hDN2Qr?=
 =?utf-8?B?T3NZVWtKTHovV09VR3lUSVErVE9wZDdia3VKY01FdUttRytkYmFJbGQzRVNJ?=
 =?utf-8?B?d2wrclhmeHNkYXJ0M0F5RHRYZU9VbjBxd2pRaFFkYXRYK0U2NlFmNE5sR1E3?=
 =?utf-8?B?UkpYMmJDdElSd3FWUHM5NWt3RVdsSW04Kys1MXVvUmwwMEhQK2E0YU05YW9j?=
 =?utf-8?B?bHhsNmRUWHF6RDFnbHdBT2ZKeWM1U280eVV5eHA1bkJlNkVKT0Y0bGQ3bkJF?=
 =?utf-8?B?a0tORkpuZ2NITzVNdjk0TEc2RzZ3Z2VlN0JRTjYwcUdQK1RLZzZDYzFYTUF0?=
 =?utf-8?B?dzEydC9BUW5yQzFpME9JV1UyTHBGZ2tSN0EwZnhuLzYvdE1IOStCWEE2UGZZ?=
 =?utf-8?B?MkdwTDJQenFJamhYTlFoNVZmZ2daRmNzVEIwYlo0aDdBam5yNWVLNWNaMlpR?=
 =?utf-8?B?UjN1UGhZSGdENEdPYVpxb3dvT2djWkNvK2pwT2hUL0pjNXk3K1p4bUlERERX?=
 =?utf-8?B?S0Uzd0FpY01qenhVK3dSN0ZwZU84a3lLSzUvelpoZkhsSUNLNzJHQ1ZxcVcv?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10AA91962B2F2542840476885D90C74D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1db4ac-9caf-4e68-2c49-08db58a7030e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 20:24:13.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXpT5DEQ2hd5rdQenTBC6UpI42zFGnCZwQ7hVpP2xqQOjQMJWEyBtzzdh1gp2QKBB06pUS/kMgIY2kWvHEGTPbOm6LrLMG5Jpv+/b5S0zp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4600
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTE4IGF0IDE5OjU4IC0wNzAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jeGxtZW0uaCBiL2RyaXZlcnMv
Y3hsL2N4bG1lbS5oDQo+ID4gaW5kZXggOGMzMzAyZmM3NzM4Li4wZWNlZTViNTU4ZjQgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9jeGwvY3hsbWVtLmgNCj4gPiArKysgYi9kcml2ZXJzL2N4bC9j
eGxtZW0uaA0KPiANCj4gc25pcA0KPiANCj4gPiArICogR2V0IEZpcm13YXJlIEluZm8NCj4gPiAr
ICogQ1hMIHJldiAzLjAgc2VjdGlvbiA4LjIuOS4zLjE7IFRhYmxlIDgtNTYNCj4gPiArICovDQo+
ID4gK3N0cnVjdCBjeGxfbWJveF9nZXRfZndfaW5mbyB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgdTgg
bnVtX3Nsb3RzOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHU4IHNsb3RfaW5mbzsNCj4gPiArwqDCoMKg
wqDCoMKgwqB1OCBhY3RpdmF0aW9uX2NhcDsNCj4gPiArwqDCoMKgwqDCoMKgwqB1OCByZXNlcnZl
ZFsxM107DQo+ID4gK8KgwqDCoMKgwqDCoMKgY2hhciBzbG90XzFfcmV2aXNpb25bMHgxMF07DQo+
ID4gK8KgwqDCoMKgwqDCoMKgY2hhciBzbG90XzJfcmV2aXNpb25bMHgxMF07DQo+ID4gK8KgwqDC
oMKgwqDCoMKgY2hhciBzbG90XzNfcmV2aXNpb25bMHgxMF07DQo+ID4gK8KgwqDCoMKgwqDCoMKg
Y2hhciBzbG90XzRfcmV2aXNpb25bMHgxMF07DQo+IA0KPiBUaGUgcHJhY3RpY2UgaGVyZSBpcyB0
byB1c2UgZGVjaW1hbHMgWzE2XQ0KDQpJIGxvb2tlZCBhcm91bmQsIGFuZCBzZWUgY3hsX2lkZW50
aWZ5LCBjeGxfZXZlbnRfbWVtX21vZHVsZSwgYW5kDQpjeGxfZXZlbnRfZHJhbSBhbGwgaGF2ZSBh
IGZldyBoZXggb25lcyB0aHJvd24gaW4gZWFjaC4gU28gSSBsb29rZWQgdG8NCnRoZSBzcGVjIHRv
IHNlZSBpZiB0aGVyZSB3YXMgYW55IGNvbnNpc3RlbmN5IHRoZXJlLCBhbmQgdW5mb3J0dW5hdGVs
eQ0KaXQgaXNuJ3QgZWl0aGVyLiBUaGUgc3BlYyBkb2VzIHNheSAnTGVuZ3RoIGluIGJ5dGVzJyAx
NiBmb3IgdGhlc2UgZncNCnJldmlzaW9uIGZpZWxkcyB0aG91Z2gsIHNvIEkgdGhpbmsgaXQgbWFr
ZXMgc2Vuc2UgY2hhbmdpbmcgdGhlc2UgdG8NCmRlY2ltYWwuLg0KDQo+IA0KPiA+ICt9IF9fcGFj
a2VkOw0KPiA+ICsNCj4gDQo+IHNuaXANCj4gDQo+ID4gKyAqIFRyYW5zZmVyIEZpcm13YXJlIElu
cHV0IFBheWxvYWQNCj4gPiArICogQ1hMIHJldiAzLjAgc2VjdGlvbiA4LjIuOS4zLjI7IFRhYmxl
IDgtNTcNCj4gPiArICovDQo+ID4gK3N0cnVjdCBjeGxfbWJveF90cmFuc2Zlcl9mdyB7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgdTggYWN0aW9uOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHU4IHNsb3Q7DQo+
ID4gK8KgwqDCoMKgwqDCoMKgdTggcmVzZXJ2ZWRbMl07DQo+ID4gK8KgwqDCoMKgwqDCoMKgX19s
ZTMyIG9mZnNldDsNCj4gPiArwqDCoMKgwqDCoMKgwqB1OCByZXNlcnZlZDJbMHg3OF07DQo+IA0K
PiBIZXJlIHRvby4NCg0KLi5ob3dldmVyIGZvciB0aGlzIG9uZSB0aGUgc3BlYyBoYXMgJzc4aCcu
IEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3QgbWF0Y2gNCnRoZSBzcGVjIGluIHRoZXNlIGNhc2VzIHNv
IGFueW9uZSBjcm9zcyByZWZlcmVuY2luZyB0aGUgaGVhZGVyIGFuZCBzcGVjDQppcyBzYXZlZCBm
cm9tIGRvaW5nIGEgYnVuY2ggb2YgbWF0aCBmb3IgdGhlc2UuDQoNCj4gDQo+IFRoYXQncyBhbGwg
Zm9yIG5vdy4NCj4gDQpUaGFua3MgZm9yIHRha2luZyBhIGxvb2shDQo=
