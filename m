Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD506598A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiL3NXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiL3NXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:23:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119071B1D2;
        Fri, 30 Dec 2022 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672406586; x=1703942586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w7Y4d8Jb6tqZE+1V8RJbJRVW+KkWS2XMn5vEPqWWzIc=;
  b=QylzGPcWKvm0eV9UHipHVjhmS0Wfh/NIHA5HvVOIE/7BuZIn+J8zHFiM
   HlWdOXHtvqGKmZhZf4AvM7TmqMAvUb+srI4CIBXI7vBITTI5tpixGaNMg
   hfL4vwL9dIXkPVLdscLGI2iEmPk5ceQd8Am0bJO7fZE/DR3bgUGPwyNuG
   gbMEsWnYw32DpyMN5gjkpKVTTNJ757oNe6yZL5d6FS8PyiAa5Iq9T+4M5
   CymnTFLlE0Zk6pN9GuWlaBS2u9jreuZuhyPTW2DMESii/JXLkGdRevvtU
   MFQf4RIbrYBzZ/KMc+581nEXPwfkgNeeV04u5GQAxlPhqvldoDjjfw+1R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="319925504"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="319925504"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 05:23:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="761243931"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="761243931"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 30 Dec 2022 05:23:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 05:23:04 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 05:23:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 30 Dec 2022 05:23:03 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 30 Dec 2022 05:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqD3+epcIPW7nzvVoc3TF82ytBxamkmiAqSTJdknUfhZ6Ma1zoijxFf+8TWB0Doda4RKH6JQhpOD1lp6+OeuZzhVGZXiDgayC5b/seDmYlzg7SNiuEFyOu2mREbC3zA0eCAo1xJ4/yDrtgWkME7Og7p9C1CO4uRACJgmX1099g9yiTpQoxTc6l9JiQTUngJuMfFpwTlmCqCaCh1SBHnVxsvzhLMVeuXaEkQi24mgSEsnM8de0nr81SUffYrviq4fIWVHO5pDC73UygCCGkARJeRw8xKL+j3EVVyvtTz4AeSFvqxkNIBTNYclI+4zHCRxZEqrhL37UgzMHKGxYeeYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7Y4d8Jb6tqZE+1V8RJbJRVW+KkWS2XMn5vEPqWWzIc=;
 b=fCEgv2bZqNby4GkhA1vd+JzKCvdaF7K9FrLKeSPb6cvylmda0Ot53mUAIeVtq3D8rSqAVKaMMOAo1iNPsSSPH7+okSjjUB2cSSaIp2UHHHHufxF5gqmfBhMhJWexrb0Tb9q+2zLF+k9MkcIn5clSkt+dWhtM/XLMUsO74+n1AKe8pQBa9VXrIO/GsC+44Ph5IMGqp9N8CeHSYVCns2521LOzZRclBWWGMUB9jHwq4Uv3/EkPocCiGb+weZghUXngCep33gnJmeI4e32yNpJtBRdEMmYPo67U/8QhfieDx37ArmXOtnWlmLORqX1kcS9NfOsGJWciASn04Z+6QOnvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 13:23:01 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 13:23:01 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Brown, Len" <len.brown@intel.com>,
        "kvijayab@amd.com" <kvijayab@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bpetkov@amd.com" <bpetkov@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>
Subject: Re: [PATCH] x86/acpi/boot: Do not register processors that cannot be
 onlined for x2apic
Thread-Topic: [PATCH] x86/acpi/boot: Do not register processors that cannot be
 onlined for x2apic
Thread-Index: AQHZGrIOEsouZPeEsEijOV0csXnhja6GbkeA
Date:   Fri, 30 Dec 2022 13:23:01 +0000
Message-ID: <0e299876606352ca868d7b71991c66a1c1d361cb.camel@intel.com>
References: <20221228114558.3504-1-kvijayab@amd.com>
In-Reply-To: <20221228114558.3504-1-kvijayab@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB6624:EE_
x-ms-office365-filtering-correlation-id: 26046e7a-d78e-45b3-659d-08daea68f993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37iuCkPpsdAOdyHosOJQ0xJaRVm2nrQGfTPpNJB6ra8cDIDa8ZmuDr2ivjrR10nJRVjNtsKrf3iMBzseiI9fuSGMXE7tz8E50C65QdgNUyjDws0qRQ3CXdIMZy9bC2tW+CreFb1oC6M7depkP0wLHLCmTTOdYD2bhmADacBt37lWL91g/pdSMbxscZj3+tevakWGVfk3utQcIcVW05XWKSEhxnYltVBJ8XQ3ZoJIwzj/qNxdnWGy7PdPNyITy977MiO46+ghL/Vi1fMxjXxRnJ2FKUsj4Hbf0KT0J0ib8S2TX7gamA3SObD8tk8T6o10zaGUBSKiBAs3rJ0OEHrK7/f9xlEuBop5WWfAVpybA3+I1AwHBSkFWdxe6uPcgWzueGcksm/CIrs4fGU+Iyf+Mto0FPs5omq8YuBCDxECcYpkfa09Tnzr8UWnBgaY3jeyl2JhWSsIb6jskwz6CPY0e4jMoSsAQhNQTubJRFCzg92r0Hu5uhoo+OTnvSZyw/Z88zh0H/Y+YsO8sF8OnsnIYZ9XSuQOlrtcN9suzIeozMuXDyB3OPArU9JXzj5EOfuBURMzSfp2SDYdGx8M/DgPI6ay6BuUTALOtsVDWbbWvk6LLgIwiNufN+fPCnYVH91WASA4wXfn6RpXvYz5lFdxaq+12Jzfp1zsKH/DjHX95hXt4YPSug1GFFk0MUruWvvT1Uhqz691DSsbhhQPLdVRYiEE0ye7uU0FOZell33qNdwnxovKaApxrZdY/XY6bLpFSJMe61EeZgkAo0KyrqbIlKFtXnUSce/e3HXHA9HV8VA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(66946007)(76116006)(91956017)(64756008)(66556008)(8676002)(66446008)(66476007)(86362001)(4326008)(2906002)(4001150100001)(5660300002)(8936002)(7416002)(83380400001)(6486002)(478600001)(966005)(2616005)(6512007)(26005)(186003)(110136005)(82960400001)(316002)(921005)(54906003)(6506007)(38070700005)(38100700002)(71200400001)(41300700001)(122000001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGJUdmYvVW83SlVJU0VsWVAvZm1HbjVGekpiZjFxZ3Focy9kakZnb1lzL3pq?=
 =?utf-8?B?N2lQTEY2T1ZUaGs3b1JXZS9nNXhPczd1YU9xQWZpME1hWlBod1BrTlpVcWZI?=
 =?utf-8?B?M2ZOWkt1M01zbTNITlhTaG5ydU1Bb3pEWUdoKzV0K0tVUnlyQ3RRaythdGJq?=
 =?utf-8?B?ZXZBdXVhanozckt5VUg2WU13T3BzVGtKUDB0SUsxd2p2Kzl1L2ZzVi90WUlZ?=
 =?utf-8?B?SkorVnQ0NmtkRDFwZ1NOK2pIb0sxdndHeHJySGJUblNhSmdKUUgzRFZWUm1V?=
 =?utf-8?B?SVB3Y0dsanhLTWlVSmswa1c2NytDZ0I1V2kzSFlRbTVVTCt2eUcwR0hkNXZq?=
 =?utf-8?B?NzFYUUdFQ2tta1Mwa09aZXpwazdRMEEwR1RmR2FSNXVwangrdHBrREE4RWRs?=
 =?utf-8?B?eTRiMzB6cUZKall2OFJvemUxTml1NE02OElkaGZ1RkJZR1cwcS9CSnRHMDUv?=
 =?utf-8?B?N3hHU1psVGxaZm5OVDhIcHZLZHp4QXo3UWNkM1IycFROblVmaHZkZTIrdHpY?=
 =?utf-8?B?c2JYNnBJV0pBcFMyOG9NS1cxcnJKdlBqYnF1d0RSeC84M3lUTkRURmZtR1lZ?=
 =?utf-8?B?U1VIcU1MSS9yTlB2UEVvVjY5bElyTXMvNVZtTEFQUWhsN21TOHZ3ZGNYeWVF?=
 =?utf-8?B?bVNvemVaL0wxalRBYmR4NzZqOUhjdng5YjNFRHdxcW5ZMW9ONzZaaVlMazl0?=
 =?utf-8?B?T3JvTFNnQ2FnZUJ4UEhxWE1xRTVDUGM0UHpaMWo4YnhFVFQyN1Iwa2FYUGwr?=
 =?utf-8?B?SmdEcjhFUkYwYkRsWjhVMUZ4dnZrSFVKbHJ6Wk9xeTVuUEtrRjB5ZnZMV09x?=
 =?utf-8?B?WWlHZjlYVVU4ZDFqdzFGV09TQnhjV0FKM3dXZ1UrYjJKazJiUkMvUTR5RHpL?=
 =?utf-8?B?UmpHSEEyM0VyR2pPb1ptTlJ2Yk8zWWNEeVg1Nk85cDdKL0pBaEw3YUNlVHZi?=
 =?utf-8?B?QVlZckZtTGNMa1J1bjZZbVZteWR2TUpOUXpKaXUzR1E5VDZQU0VYSzYzVHdZ?=
 =?utf-8?B?MnZ1N3JLWUtSNStaR2U5UnBWTmhZaCtQanNDTi9VWXVmZ0hWcHVwb3VOd2NF?=
 =?utf-8?B?Zm1wenpIaGVpNU5uRFhLQnZLa09LQ1RYVHM0SndMSWY1MHpDTngvdEtvLzVp?=
 =?utf-8?B?UjhPR294V1lVSjZOL1pub2d0NUN4QVY1ZDQ4dE5HQVJ6bmdCVG9EVWo2ZS81?=
 =?utf-8?B?cFhRMjVBbHY3ZzNlcEtsNnJpRy9oenB4NnNpN2VaQ083WkJBZ1hWbEU1V1Y5?=
 =?utf-8?B?aXZIOGJZbnNzZDFweWlIdFpMbFdnWGJNUE54cjBFaE5EeVJIaVUwd2RqVFBG?=
 =?utf-8?B?SmVoUnVNVGNxWlJEdVdTMXRkYXFjWjFOMEJWMW1vVkNrOXFDQ1FNM3ZYK09I?=
 =?utf-8?B?YjVEY3lJbnVDL2RpMkQ2Y2dHQ3VxL2loeVFMaXNXeWNldHFpbm9SU296bzd0?=
 =?utf-8?B?UlNrT1FaUFZFUW9LZFAyNW8zVjE5bGVtSTVweDEzeGtSVlF5L0g0ait5NWtu?=
 =?utf-8?B?aWRCdzRoR1V1MWNoNUJUR1E2aDRVMlAvcUNyOHIrcTM1ZDV4SFF6M1RIRlZ0?=
 =?utf-8?B?b1lsUHNhMmFnVHFUTlBpc0NhVjlRbDU0YzFqUlVFeFJPbGcrSS9OaDYvYXJx?=
 =?utf-8?B?emFRNytzTmIvNUxpOUNEVHV4RG02Vjg0NUQ0YUp5WTRmTkRKU2dsMFQxTElC?=
 =?utf-8?B?SHNRUWVhL3dYYmhNR0E2WHBFcmR1NVAvNDMrYUJPbU9lZSsrV2xzQktuVHNV?=
 =?utf-8?B?bnUyRVk0elA4RjJqQzM5VHZqTng5Z2Y2UGdwVkx5NE1xMXNwdVRna3Q5Q1U0?=
 =?utf-8?B?T1FuWnJscU41anpkYWJRbVlKdjdnZGl1U1RsWkkrUllrQ0daT2FMZ3Ztd0tU?=
 =?utf-8?B?KzZONE50QkJmQ2VqYkNWWUd0aDlSZGlTMDNmZzFhVjYvcmc0SFBXbVhlNEdu?=
 =?utf-8?B?QWt4VE03NXNKUGQ3MVc3VTB5aHZsSWlHYzFQaEVVaVlmQWcxdUp0NDBWR2p2?=
 =?utf-8?B?dFU2OHBZdTdKL0hjNDMzZnFhSWhHaUNhQnFVTlVheGlKZ01HMG9QLzRHSStl?=
 =?utf-8?B?VFVKU1hEOVN0SUthTG5NTlU4ZzF3cFYzQWJJcXA5OEZ2K0VlNHVFeUJrM0dN?=
 =?utf-8?B?bHNvOXVTY1hEKzNldUxoYlUzbmhnOVpHdkhTTWVHUStlWExNek52SE1VOE9a?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <710BA9B4250A1E4F9D8BB4450B70A2FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26046e7a-d78e-45b3-659d-08daea68f993
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 13:23:01.0562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AF650afnOnJgsy9O7GJTl2zYrmi0a/1T28+q/ZNuA8p+GUUPIUxf40JWU/SWTjTUsGmX3gO3WNS+JTC+QmSRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEtpc2hvbiwNCg0KT24gV2VkLCAyMDIyLTEyLTI4IGF0IDExOjQ1ICswMDAwLCBLaXNob24g
VmlqYXkgQWJyYWhhbSBJIHdyb3RlOg0KPiBTZWN0aW9uIDUuMi4xMi4xMiBQcm9jZXNzb3IgTG9j
YWwgeDJBUElDIFN0cnVjdHVyZSBpbiB0aGUgQUNQSSB2Ni4zDQo+IHNwZWMgbWFuZGF0ZXMgdGhh
dCBib3RoICJlbmFibGVkIiBhbmQgIm9ubGluZSBjYXBhYmxlIiBMb2NhbCBBUElDDQo+IEZsYWdz
DQo+IHNob3VsZCBiZSB1c2VkIHRvIGRldGVybWluZSBpZiB0aGUgcHJvY2Vzc29yIGlzIHVzYWJs
ZSBvciBub3QuDQoNCkFDUEkgc3BlYyA2LjQgaXMgcmVsZWFzZWQsIHNvIGJldHRlciB0byByZWZl
ciB0byB0aGUgbGF0ZXN0IEFDUEkgc3BlYywNCnNheSwNCmh0dHBzOi8vdWVmaS5vcmcvaHRtbHNw
ZWNzL0FDUElfU3BlY182XzRfaHRtbC8wNV9BQ1BJX1NvZnR3YXJlX1Byb2dyYW1taW5nX01vZGVs
L0FDUElfU29mdHdhcmVfUHJvZ3JhbW1pbmdfTW9kZWwuaHRtbCNwcm9jZXNzb3ItbG9jYWwteDJh
cGljLXN0cnVjdHVyZQ0Kb3INCmh0dHBzOi8vdWVmaS5vcmcvaHRtbHNwZWNzL0FDUElfU3BlY182
XzRfaHRtbC8wNV9BQ1BJX1NvZnR3YXJlX1Byb2dyYW1taW5nX01vZGVsL0FDUElfU29mdHdhcmVf
UHJvZ3JhbW1pbmdfTW9kZWwuaHRtbCNsb2NhbC1hcGljLWZsYWdzDQoNCj4gSG93ZXZlciwgTGlu
dXggZG9lc24ndCB1c2UgdGhlICJvbmxpbmUgY2FwYWJsZSIgZmxhZyBmb3IgeDJBUElDIHRvDQo+
IGRldGVybWluZSBpZiB0aGUgcHJvY2Vzc29yIGlzIHVzYWJsZS4gQXMgYSByZXN1bHQsIGNwdV9w
b3NzaWJsZV9tYXNrDQo+IGhhcyBpbmNvcnJlY3QgdmFsdWUgYW5kIHJlc3VsdHMgaW4gbW9yZSBt
ZW1vcnkgZ2V0dGluZyBhbGxvY2F0ZWQgZm9yDQo+IHBlcl9jcHUgdmFyaWFibGVzIHRoYW4gaXQg
aXMgZ29pbmcgdG8gYmUgdXNlZC4NCg0KVGhhbmtzIGZvciBjYXRjaGluZyB0aGlzLiBJIGhhZCB0
aGUgc2FtZSBxdWVzdGlvbiB3aGVuIEkgd2FzIHJlYWRpbmcNCnRoaXMgcGllY2Ugb2YgY29kZSBy
ZWNlbnRseS4NCg0KPiBNYWtlIHN1cmUgTGludXggcGFyc2VzIGJvdGggImVuYWJsZWQiIGFuZCAi
b25saW5lIGNhcGFibGUiIGZsYWdzIGZvcg0KPiB4MkFQSUMgdG8gY29ycmVjdGx5IGRldGVybWlu
ZSBpZiB0aGUgcHJvY2Vzc29yIGlzIHVzYWJsZS4NCg0KQSBkdW1iIHF1ZXN0aW9uLCB0aGUgTG9j
YWwgU0FQSUMgc3RydWN0dXJlIGFsc28gdXNlcyB0aGUgTG9jYWwgQVBJQw0KZmxhZ3MsIGFuZCBz
aG91bGQgd2UgYWRkIHRoZSBzYW1lIGNoZWNrIGluIGFjcGlfcGFyc2Vfc2FwaWMoKT8NCg0KPiBG
aXhlczogNzIzN2QzZGU3OGZmICgieDg2LCBBQ1BJOiBhZGQgc3VwcG9ydCBmb3IgeDJhcGljIEFD
UEkNCj4gZXh0ZW5zaW9ucyIpDQoNCkknbSBub3Qgc3VyZSBpZiB0aGlzICJGaXhlcyIgdGFnIGlz
IGFjY3VyYXRlIG9yIG5vdC4NCg0KQ2hlY2tpbmcgZm9yIHRoZSBMb2NhbCBBUElDIGZsYWdzIHdh
cyBqdXN0IGFkZGVkIGxhc3QgeWVhciwgYnkgY29tbWl0DQphYTA2ZTIwZjFiZTYgKCJ4ODYvQUNQ
STogRG9uJ3QgYWRkIENQVXMgdGhhdCBhcmUgbm90IG9ubGluZSBjYXBhYmxlIiksDQphbmQgdGhl
IHZhcmlhYmxlICdhY3BpX3N1cHBvcnRfb25saW5lX2NhcGFibGUnIHVzZWQgaW4gdGhpcyBwYXRj
aCBpcw0KYWxzbyBpbnRyb2R1Y2VkIGJ5IHRoYXQgY29tbWl0LiBTbywgdG8gbWUsIHRoaXMgcGF0
Y2ggZml4ZXMgYSBnYXAgaW4gYWENCjA2ZTIwZjFiZTYsIHJhdGhlciB0aGFuIHRoZSBvcmlnaW5h
bCB4MmFwaWMgc3VwcG9ydCBjb21taXQuDQoNCnRoYW5rcywNCnJ1aQ0KDQo+IFJldmlld2VkLWJ5
OiBCb3Jpc2xhdiBQZXRrb3YgKEFNRCkgPGJwQGFsaWVuOC5kZT4NCj4gU2lnbmVkLW9mZi1ieTog
S2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a3ZpamF5YWJAYW1kLmNvbT4NCj4gLS0tDQo+ICBhcmNo
L3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgfCAxOSArKysrKysrKysrKysrKysrLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMNCj4gYi9hcmNoL3g4Ni9rZXJuZWwv
YWNwaS9ib290LmMNCj4gaW5kZXggOTA3Y2M5OGIxOTM4Li41MThiZGE1MDA2OGMgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvYWNwaS9ib290LmMNCj4gQEAgLTE4OCw2ICsxODgsMTcgQEAgc3RhdGljIGludCBhY3BpX3Jl
Z2lzdGVyX2xhcGljKGludCBpZCwgdTMyDQo+IGFjcGlpZCwgdTggZW5hYmxlZCkNCj4gIAlyZXR1
cm4gY3B1Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgYm9vbCBfX2luaXQgYWNwaV9pc19wcm9jZXNz
b3JfdXNhYmxlKHUzMiBsYXBpY19mbGFncykNCj4gK3sNCj4gKwlpZiAobGFwaWNfZmxhZ3MgJiBB
Q1BJX01BRFRfRU5BQkxFRCkNCj4gKwkJcmV0dXJuIHRydWU7DQo+ICsNCj4gKwlpZiAoYWNwaV9z
dXBwb3J0X29ubGluZV9jYXBhYmxlICYmIChsYXBpY19mbGFncyAmDQo+IEFDUElfTUFEVF9PTkxJ
TkVfQ0FQQUJMRSkpDQo+ICsJCXJldHVybiB0cnVlOw0KPiArDQo+ICsJcmV0dXJuIGZhbHNlOw0K
PiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IF9faW5pdA0KPiAgYWNwaV9wYXJzZV94MmFwaWModW5p
b24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsIGNvbnN0DQo+IHVuc2lnbmVkIGxvbmcg
ZW5kKQ0KPiAgew0KPiBAQCAtMjEyLDYgKzIyMywxMCBAQCBhY3BpX3BhcnNlX3gyYXBpYyh1bmlv
biBhY3BpX3N1YnRhYmxlX2hlYWRlcnMNCj4gKmhlYWRlciwgY29uc3QgdW5zaWduZWQgbG9uZyBl
bmQpDQo+ICAJaWYgKGFwaWNfaWQgPT0gMHhmZmZmZmZmZikNCj4gIAkJcmV0dXJuIDA7DQo+ICAN
Cj4gKwkvKiBkb24ndCByZWdpc3RlciBwcm9jZXNzb3JzIHRoYXQgY2Fubm90IGJlIG9ubGluZWQg
Ki8NCj4gKwlpZiAoIWFjcGlfaXNfcHJvY2Vzc29yX3VzYWJsZShwcm9jZXNzb3ItPmxhcGljX2Zs
YWdzKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gIAkvKg0KPiAgCSAqIFdlIG5lZWQgdG8gcmVn
aXN0ZXIgZGlzYWJsZWQgQ1BVIGFzIHdlbGwgdG8gcGVybWl0DQo+ICAJICogY291bnRpbmcgZGlz
YWJsZWQgQ1BVcy4gVGhpcyBhbGxvd3MgdXMgdG8gc2l6ZQ0KPiBAQCAtMjUwLDkgKzI2NSw3IEBA
IGFjcGlfcGFyc2VfbGFwaWModW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICoNCj4gaGVhZGVy
LCBjb25zdCB1bnNpZ25lZCBsb25nIGVuZCkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gIAkvKiBk
b24ndCByZWdpc3RlciBwcm9jZXNzb3JzIHRoYXQgY2FuIG5vdCBiZSBvbmxpbmVkICovDQo+IC0J
aWYgKGFjcGlfc3VwcG9ydF9vbmxpbmVfY2FwYWJsZSAmJg0KPiAtCSAgICAhKHByb2Nlc3Nvci0+
bGFwaWNfZmxhZ3MgJiBBQ1BJX01BRFRfRU5BQkxFRCkgJiYNCj4gLQkgICAgIShwcm9jZXNzb3It
PmxhcGljX2ZsYWdzICYgQUNQSV9NQURUX09OTElORV9DQVBBQkxFKSkNCj4gKwlpZiAoIWFjcGlf
aXNfcHJvY2Vzc29yX3VzYWJsZShwcm9jZXNzb3ItPmxhcGljX2ZsYWdzKSkNCj4gIAkJcmV0dXJu
IDA7DQo+ICANCj4gIAkvKg0K
