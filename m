Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BBE6AE605
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCGQLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCGQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:10:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B394219
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678205420; x=1709741420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u0zYxbFVG/tNnDnxPG+xGPeny4n7HTioxqSwnnjeC+o=;
  b=a+jQTzA2SEAstWKeSqUn795d8RTwt39WU36iYDrNs8/hvkbcaFsG6cBU
   YxAVAogLTwhyIquB4a2kfh4wIqH15k9cNiR2R5zQZsTY8SPloBdSC+LMS
   zhC/T7qXsFj4lSR2a6V/Rjl9Yyw+1k2tZiY1+jSkX9nvdRQkTyraESEC7
   g3N1xWxPmTnykoiNiGfSWSt3fG8FFAXFkwwmrAzwRs0vjowcs0V2wxhA6
   QEPwpDglsaOa312uBnlqBS7NQLc8u42Dcffg8rGGjXhfM/2dZRbLPiORZ
   OTdnnVEM4wHtsAq0PP9D6qbKbpNkOGFH6Y93xpi9BTjJOLwkpYvF+iXSR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324197265"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="324197265"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800436749"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="800436749"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2023 08:10:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:10:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:10:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 08:10:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 08:10:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xoq4x67/wAYfWZCX8WBE7QX72Rl9/9IDW96abgaBbgMJ3nurxHyH5bzcBRCH6T+KE7RupuyXu+nvMAcM29zBWt7m+FHXLqluv3owu2lHV9bzay7R2twuP4vmN+560rhDMjF12fL7IrAcbd1hVWwtPE6AvvWVsGXO9wpdFUzTTvn1CPdw/wsnt9+bY7ot2GjGtsgKUanHzs0r5WuukJABFTjy7Q0qOFIM0coTSZxNFNSbVlTYJIkwceYdLQu7zUXUA1VB8a5obAEOKyolbcH2yvXqHCiqdDqLBqVnQl3m1YkVhoRVGw+8VkoZudaJTCi2J14QO8IvAc4LTRJ060k3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0zYxbFVG/tNnDnxPG+xGPeny4n7HTioxqSwnnjeC+o=;
 b=PYgYM6pqPG7r04CDeCX3gSMECzwfugNFlIvAEt55E5Zic89ej08JLA+EzGo/zI1/icIuJWqe4YxFzYTMqE0xfHlYOMqwee5nbKrrWOZLiZk40hURghLS5MjHKN1Mu/1ekV2x8X0QoS/uawOXd7K1ynfJ0uN8Of0Y8uH+0q8RubW/UmTSoO+YLd1bDlCDaYRNq97nQPcGeIYnc/Uc4VTEYkxFLv4mTD5CtlLazVzsts2fOpO2qj2YBOXx2OZQ1VzlB9TVbnEYXrDAYmQ+U9HJL0u3jJjpOmM7uiPwqURwYQDSusKJPNjbgj8uf3F1ot6waT8t+33BSzr4iP2RYwLLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by BL3PR11MB6314.namprd11.prod.outlook.com (2603:10b6:208:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 7 Mar
 2023 16:10:14 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6134.024; Tue, 7 Mar 2023
 16:10:14 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Topic: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Index: AQHZRNuCmUZrj67G7kGhK77N+UN9Nq7XrYkAgAA5PoCAAIrCgIAAoQeAgBaCUAA=
Date:   Tue, 7 Mar 2023 16:10:14 +0000
Message-ID: <3bc616e8a513d4bfef2fb2d824f7ca8e8815bc77.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
         <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
         <87edqkosty.ffs@tglx>
         <65bb51627b7384190f6aa1c549548a2497a926c3.camel@intel.com>
In-Reply-To: <65bb51627b7384190f6aa1c549548a2497a926c3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|BL3PR11MB6314:EE_
x-ms-office365-filtering-correlation-id: d20830f6-8ec8-45d0-6965-08db1f266f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dxUhQQJgxDyh3u3NrNbsC//72BxIL+2BAbRFYCtbB+PjIIg++iMcLin8tK4J7+incZGvK5hyh3gqFXHTWg7OsW0prIHbu/p58z7YbuULCzsQCHPF9RMsznF3rFGhwnVyhsSavXdGZ7/wITcP+X5uYOB2H4A4d8ANHpvM3E9z26HFJ8B/GdatlirmXKH7AsHjwHq63RCehNUAZh7znecmYzsltY3KTwGtP8CsDQZxJRYpuTwoqnDNGwZ0y5N2HqGt8cD4QjT49mni+p78dh+q63pIEKoyTMeTMDhqvajQnhSAw/qGwluTk3URQDU8+ZqJHM1ZlOpuzpuKK9Xpo3VWJq1VViqRWXlIlIy9j6i6Hsme81drDVZDOG5kncIV0VkxOyd54nHbpZ3kb1IHAEBR6jWEEsdtXEqs1JheT8whmtPn6uyU2mj7yFoqpS5j9WZKKCya+U4Jc2R0D8ADCPA3GIjW1Xo5Zx42DAyw1WoYZfJtHWemDzVwdqaXqCCP/tidsVbhq7pbBYKHaS/l84YCxA3/sPGpxj70EK9prIaaRFZ3tlnhMmpCmt8vbjvBgH6KvfvDfo8+rKUFDBQK3FGcnIwg0vZmPktY/TsXd1WXPK/TAVJS6H2xwveVR389hyYNgylP30d47XhkKEIcOIj7W24ia8rSywp56rd2WVch/E7GARWA8EwIX8woluQrimC9aVBPJZUv7KkV5LowGZJGaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(8936002)(186003)(2616005)(6506007)(41300700001)(6512007)(2906002)(83380400001)(478600001)(6486002)(54906003)(71200400001)(8676002)(110136005)(91956017)(76116006)(5660300002)(4326008)(64756008)(66556008)(316002)(66476007)(66946007)(38070700005)(26005)(122000001)(86362001)(38100700002)(82960400001)(66446008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm1oM0FUUGpuYTcyZVNHRnc0TUcwM2dmcGNkQndSejVNaUVSRXNtR3JjelN4?=
 =?utf-8?B?clFMam9JT2NnWGRuMU9KTVU5QkNHbDFReHZiMENSb3J4dkxXb29BQXNMaWxZ?=
 =?utf-8?B?YUJDVkI0RlNHYkRhdlh2ajVpMWV3dDRjTTlrSXo2Qms0cGRXbWJSY1FWVTB3?=
 =?utf-8?B?djg0RlFVNlJTcTRiMGZqSTdPcElBb2NadjliY3dnNzdNVHRLSGhBb1RHOFZP?=
 =?utf-8?B?TVBxOGYxMXZtbDBRd3dCQ2haeWJoZXhoazdoeXBTdDUwK0VKekxXL0V0R0lY?=
 =?utf-8?B?UkJzRUpxVExDWHBjaFBkV3ZBVkJ3RmdYZkhTYzNlUHoyUlZObUcwQmRENy93?=
 =?utf-8?B?VnRmckpRK3hSVDhkZ2xkMFhERGN2NGRzVGdKalBldUFCV1JieWNQTTdxakhJ?=
 =?utf-8?B?d05XWDRoRDVVY3AzMnBpbU1ScllvVGFNZXMzdjZ6VHl2NmV2eDRyQ0ZBK1Av?=
 =?utf-8?B?aHNxbnJYV0U0NWNNWlZVUkgyZldSSnd0WTluejZqM2lLTXdpR3ZuNmxYRTJt?=
 =?utf-8?B?Tms0a21ua2xNWWlnL1FVcHlseWtyRXJVV0dGcE9Xckh3S3NIcmlxOStyOCts?=
 =?utf-8?B?Zzdlb1p5K3NBY2FORnYxaWVIMW9NZHF1ZDZ1SGkxUmZGK2owSWFZRkRvS0FN?=
 =?utf-8?B?Z0lFdHRjR0xwRlp2T0hhUEJUU0UvbmVrWWZPY0svWmpSRW40VjdYMll0SFFH?=
 =?utf-8?B?Y0hSMTRRUzd0RE1YYWRhMGpzTldXNzJ6TkVtZDlZZ1daL1dPdTc4L3lLdkw1?=
 =?utf-8?B?ZGkwVFRhL0xmSHVUbkFFQ0VNd0l2ZFQ2bjlqYmRyZG5LUnc2bDlDVCtzajJn?=
 =?utf-8?B?bWZTZXEwWEJzUXJ3blVydDFTQUplNzhMUTJDcTNFL1lPSlJ5NktoVFduaU5x?=
 =?utf-8?B?NEZ3NEk1RkJOWXA5Q1lFa1dFMGROVW94eVpZUllsRTdHa2R6OHFXaXB6cDNk?=
 =?utf-8?B?U2tYUXdJNmxIanhLaFNTZjhhRHhHbXNJVHovOElQNzNLNEhscHJlcFNUcXVa?=
 =?utf-8?B?enppSTJISkZqZytpUVZQTWNjNERsSTErbDltd1A3Mnlhdk1Bc3FXZ1l1dERT?=
 =?utf-8?B?MHFnT2d1WWc2ZUc3VzVRaExEVnk2QUg1VzJpZEZhUENNTXRlMVBnUkwwWGQw?=
 =?utf-8?B?ckxBVzZBVnpzSDV5akVuTkt6MzBBWFpza2M4L3lYTVZJSG05UGZ0ZTU2MFpW?=
 =?utf-8?B?WllIN25PZEZjOU00NGtuTHpCamU5UVczZUJxeW9VaWlUa0FvbGRUTGIvWWU4?=
 =?utf-8?B?RHU1QUlRRkx3alNLMHRTQnhIaVdnbkMwZWJIeFA4QUQydnA4S3VvL24rZGpO?=
 =?utf-8?B?MTh6RkVVQmpVMThkQjR0d1JzOFZmUHFoQlMxcUR1L1NXeVRuNE1DeklSc2hj?=
 =?utf-8?B?bUNrc3JITnh1YTBmYkNaYk1XVFpIekJ3b1NIVi9RNGtCbVpKQ3JTQ2hIVWNq?=
 =?utf-8?B?cjBBdzltdDNBUGJ5KzRwdU85TGlqVVNTK2JEQVIrRERkZzMzUzhVZmJ5Sytn?=
 =?utf-8?B?UVpyNG5DWDhXRUtHbGNhZitmU0E5M2dISjBPODdvcisza2U3WEJ2aFVmOVJI?=
 =?utf-8?B?UUlLMGVNZU1vUkRXRVRtdjFzVDlHaXBOUVV6L1Iza0VWelBpVzdBUzQrcGwx?=
 =?utf-8?B?cXlYbm5BZzRId3MrSkJUTEwwaENwSDE3UVFiMkk1aDRXZGNmcEFLUFp6a0ZO?=
 =?utf-8?B?ZFJwZllCOFlvdFN4b1V4b2lWNnJ2MUtSa3pseGFJL08ycmpieXgyKzI0dzJy?=
 =?utf-8?B?UWpEMG10ZEJDUEtDTUJ6eTZPczlwUEZ4NUVVOEZ4S3lTL3V0RVVkQ1ZyUC9K?=
 =?utf-8?B?RVZLWXdQeGZnbkt5aExzZGlDVUw3Q1RjQ3ZKaDhHWXJNZDhrSVRVMHVxSElP?=
 =?utf-8?B?bzZDQWZPSTY4MkNwbE83UUNkKzFPNU45Q1cvYXlKTm5ZSHpXT2ErRUNpakNq?=
 =?utf-8?B?NGlDTzlEL0pEVkZzNUg2N2h3TnNpU2F6SlJ2Um84aDZUdFdVbmJsdHFOV0Vs?=
 =?utf-8?B?SzNHblpCY2loS2NhenlENnFnWDhCNHF1UnBpRDRGcXpsdzhCYm5manhhTjFD?=
 =?utf-8?B?UXVhZndPZlFEL21iM2wvMnBDV3dJV1pGQXN0Rno1SGlMM2t6cThnZVU4dFht?=
 =?utf-8?B?TlZvODhybjZQcWgxNno0WnpIK0RiUTNpVjhPK0UybXk5TUtFOW82WFVibm81?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CCDBC596756F64EBE02CC0D7B47D719@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20830f6-8ec8-45d0-6965-08db1f266f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 16:10:14.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rsQ1RINRyEElvopALhMmgsU8mqIEbtB44YtRKVPZIkKQsKywz54bXkuYz7EoCFopoNm/htNLrtDRQhQN7vKQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6314
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

SGksIGFsbCwNCg0Kc29ycnkgZm9yIHRoZSBsYXRlIGZvbGxvd3VwLg0KDQpPbiBUdWUsIDIwMjMt
MDItMjEgYXQgMTY6MjYgKzA4MDAsIFpoYW5nIFJ1aSB3cm90ZToNCj4gPiA+IEkgdGhvdWdodCBv
ZiBpbXByb3ZpbmcgdGhpcyBieSBwYXJzaW5nIGFsbCB0aGUgdmFsaWQgQVBJQy1JRHMgaW4NCj4g
PiA+IE1BRFQNCj4gPiA+IGR1cmluZyBCU1AgYm9vdHVwLCBhbmQgZ2V0IHN1Y2ggaW5mb3JtYXRp
b24gYnkgZGVjb2RpbmcgdGhlIEFQSUMtDQo+ID4gPiBJRHMNCj4gPiA+IHVzaW5nIHRoZSBBUElD
LUlEIGxheW91dCBpbmZvcm1hdGlvbiByZXRyaWV2ZWQgZnJvbSBCU1AuIEJ1dCB0aGlzDQo+ID4g
PiBpcw0KPiA+ID4gbGlrZWx5IHRvIGJlIGEgZmVydGlsZSBuZXcgc291cmNlIG9mIGJ1Z3MgYXMg
RGF2ZSBjb25jZXJuZWQuDQo+ID4gDQo+ID4gVGhlIEFQSUMtSURzIGFyZSBvbmx5IHVzZWZ1bGwg
aWYgdGhlcmUgaXMgYW4gYXJjaGl0ZWN0ZWQgc2NoZW1lIGhvdw0KPiA+IHRoZXkNCj4gPiBhcmUg
YXNzaWduZWQuIElzIHRoZXJlIHN1Y2ggYSB0aGluZz8NCj4gDQo+IEkgZG9uJ3Qga25vdy4NCj4g
RG8geW91IHRoaW5rIGl0IGhlbHBzIGlmIHRoZSBBUElDLUlEIGxheW91dCBhcmUgZGVmaW5lZCB0
byBiZQ0KPiBpZGVudGljYWwNCj4gYWNyb3NzIGFsbCBDUFVzPw0KPiBJbiB0aGlzIGNhc2UsIEJT
UCBrbm93cyB0aGUgQVBJQy1JRCBsYXlvdXQgb2YgaXRzZWxmIGFuZCB0aGlzIGNhbg0KPiBhcHBs
eQ0KPiB0byB0aGUgb3RoZXIgQVBJQy1JRHMuDQoNClllYWgsIEkgaGF2ZSBjb25maXJtZWQgd2l0
aCBMZW4gdGhhdCB0aGUgQVBJQy1JRCBsYXlvdXRzIGFyZSBpZGVudGljYWwNCmFjcm9zcyBhbGwg
Q1BVcyBvbiBlYWNoIHNpbmdsZSBzeXN0ZW0uDQoNCj4gDQo+ID4gVGhlIFNETSBpcyBub3QgaGVs
cGZ1bCBhdCBhbGwsIGJ1dCBhY2NvcmRpbmcgdG8gdGhlIEFDUEkgc3BlYyB0aGVyZQ0KPiA+IGV4
aXN0czoNCj4gPiANCj4gPiAgIFByb2Nlc3NvciBQcm9wZXJ0aWVzIFRvcG9sb2d5IFRhYmxlIChQ
UFRUKQ0KPiA+IA0KPiA+IFRoYXQgdGFibGUgYWN0dWFsbHkgcHJvdmlkZXMgcHJldHR5IG11Y2gg
d2hhdCB3ZSBhcmUgbG9va2luZyBmb3IsDQo+ID4gYnV0DQo+ID4gdGhhdCB0YWJsZSBpcyBvcHRp
b25hbCBhbmQgdGhlcmUgaXMgYWN0dWFsbHkgY29kZSBmb3IgdGhhdCBpbiB0aGUNCj4gPiBrZXJu
ZWwsIHdoaWNoIGlzIEFSTTY0IHNwZWNpZmljLg0KPiA+IA0KPiA+IFNvIHdoaWxlIHRoaXMgd291
bGQgYmUgdXNlZnVsIGl0J3Mgbm90IHVzYWJsZSBvbiB4ODYgYmVjYXVzZSB0aGF0DQo+ID4gd291
bGQNCj4gPiBtYWtlIHRvbyBtdWNoIHNlbnNlLCByaWdodD8NCj4gDQo+IFRoYW5rcyBmb3IgcG9p
bnRpbmcgdG8gdGhpcy4NCj4gDQo+IEkgZ290IGEgYnJpZWYgdmlldyBvZiBQUFRULiBTbyBmYXIs
IG15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBQUFRUDQo+IHByb3ZpZGVzDQo+IDEuIHRoZSBjcHUg
SGllcmFyY2h5LCBidXQgcGFja2FnZSBsZXZlbCBvbmx5LiBUaGVyZSBtYXkgYmUgbXVsdGlwbGUN
Cj4gbGV2ZWxzIGJ1dCBpdCBkb2VzIG5vdCB0ZWxsIHVzIGlmIGl0IGlzIGEgRGllLCBNb2R1bGUg
b3IgQ29yZS4NCj4gMi4gdGhlIGNhY2hlIEhpZXJhcmNoeQ0KPiANCj4gSSBuZWVkIHRvIGZpbmQg
b25lIHJlYWwgUFBUVCBpbXBsZW1lbnRhdGlvbiB0byBzZWUgaG93IGl0IHdvcmtzLg0KDQpJIGdv
dCBvbmUgUFBUVCBkdW1wIGFuZCBhbHNvIGNoZWNrZWQgdGhlIGtlcm5lbCBwcHR0IHBhcnNpbmcg
Y29kZS4NCkJhc2VkIG9uIGN1cnJlbnQgUFBUVCBkZWZpbml0aW9uLCBpdCBpcyB0cnVlIHRoYXQg
aXQgY2FuIG9ubHkgdGVsbA0KMS4gYSB0aHJlYWQgKGEgUHJvY2Vzc29yIEhpZXJhcmNoeSBOb2Rl
IFN0cnVjdHVyZSB3aXRoICJQcm9jZXNzb3IgaXMgYQ0KVGhyZWFkIiBmbGFnIHNldCkNCjIuIGEg
Q1BVKGNvcmUpIChhIFByb2Nlc3NvciBIaWVyYXJjaHkgTm9kZSBTdHJ1Y3R1cmUgd2l0aCAiUHJv
Y2Vzc29yIGlzDQphIFRocmVhZCIgZmxhZyBjbGVhcmVkKQ0KMy4gYSBwYWNrYWdlIChhIFByb2Nl
c3NvciBIaWVyYXJjaHkgTm9kZSBTdHJ1Y3R1cmUgd2l0aCAiUGh5c2ljYWwNCnBhY2thZ2UiIGZs
YWcgc2V0KQ0KDQpXZSBjYW4gZ2V0IHVzZWZ1bCBpbmZvcm1hdGlvbiBsaWtlIHRvdGFsIHBhY2th
Z2VzLCBudW1iZXIgb2YgY29yZXMgaW4gYQ0KcGFja2FnZSwgbnVtYmVyIG9mIHNtdCBzaWJsaW5n
cyBldGMuIEJ1dCwgc2F5LCBpZiB0aGVyZSBpcyBhbm90aGVyDQpsZXZlbCBiZXR3ZWVuIENvcmUg
YW5kIHBhY2thZ2UsIGl0IGNhbm5vdCB0ZWxsIGlmIGl0IGlzIGENCkRpZS9UaWxlL01vZHVsZS4g
U28gZmFyLCB0aGlzIGRvZXMgbm90IHNob3cgYSBzdHJvbmcgYWR2YW50YWdlIGNvbXBhcmVkDQp3
aXRoIHRoZSBNQURUIHNvbHV0aW9uLCB3aGljaCBkb2Vzbid0IGRlcGVuZCBvbiBuZXcgZmlybXdh
cmUgc3VwcG9ydC4NCg0KdGhhbmtzLA0KcnVpDQo=
