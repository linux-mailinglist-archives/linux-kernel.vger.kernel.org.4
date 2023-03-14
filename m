Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817EC6B87F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCNCCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNCCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:02:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8729225A;
        Mon, 13 Mar 2023 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678759367; x=1710295367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FhvydaUvuKCXqujXNH78NZKLwD3BUaym82M58Z5/iJk=;
  b=WiivE01wK/sk6cT89VZRPEQH9RJLnMw2r0A+0AIBRkiIPZE2l6SjRmRs
   MYFUbyN6QbNwrM0BJOEkdnrHsu6CPE2d7NgPeamSKV5To2bJT3dhxTVdi
   V2wisaXHO3i5gKk+0u2jt2ed/AVIN87EBTHSwNCJ9F315szphiBveIgQM
   z828J//mTvW7uueP8/b6FYs9fLLDvcM6uG4XgicxRwK0ffqbYrBt0B1qh
   GzDNmtvSgkcC0dVahtEggN9TJPV28ygtaX4jdqYAUCaHCcvZk56fUm6dN
   YTFr+UCQHA2wX/aai23Qa1PFBFWdtTdLRCDQ6pcleQJ9ZVVHJmt8jW7Jl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="402179747"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="402179747"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="678915414"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="678915414"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2023 19:02:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:02:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:02:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 19:02:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 19:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX2DTz2xoO15ZOmDK3OlLF1n77SMuBspapAxptqZ39TWG8meCfUE+I9AO3ubkESHIn1Nhr1AoiQWqjIn2gxbNj3/BL3KKchgqTOSlDLfRz97GXKgn4sgQgilm6ku8x6djLz6YeVwpOtbiMzvFp/witCXvhEgtI5Np1VsQIvOORaPAJ8qlDfnkKBYtahxon/uIGu6G5CG3FQ2lo/tOEtmeieEo9+QI2uCXijdd2mA8Vw3dA8gHCPf+5Ip0Rx517L/lnzbEWgN/9+fU3OkQg6k9vSDP8hPGdodAa0rKDkzZGly5wQAP7PwkAftNYi3ZmXQhUEkztHcXgQOc5GCL2doOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhvydaUvuKCXqujXNH78NZKLwD3BUaym82M58Z5/iJk=;
 b=VY4is+ligeFbQMpErbh62k/DCTs5Z3ylWf+i1SIROFWVq+yT5Ypbh1bUwzxzTPtu6ovctQpNNpPrkzideg+KPg76hsDInFMhxJbdU+f5xlNLGjUKiajnSVdyv4qCkArwwYmzDda2kz1TAVWYb5WZpfWcYxKmnt9n1wN9SehKXQmSoGSDwnZiEZitX7OpdVL/GPNKm/KLQqpUHWxJLzSt+qfZUuIE3pSYpPRdMSJQEs1uSy+j+lsxVs+s8oJXO9YC377q67bUisWuTKNbXO/7pk78NNUtxHEQnxHwTXuH7bw2KdNBCebQfBsjjPWpRdrYX+VT29ix5ocTmvdN3UtfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 14 Mar
 2023 02:02:42 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:02:42 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] thermal: core/ACPI: Fix processor cooling device
 regression
Thread-Topic: [PATCH v2 0/4] thermal: core/ACPI: Fix processor cooling device
 regression
Thread-Index: AQHZVbj8FTvJKZhXvkW+gLYgFo6Pa67463eAgAAU8wCAAIZAAA==
Date:   Tue, 14 Mar 2023 02:02:41 +0000
Message-ID: <aa98c0c6e6154f007de0e42c246c129de0af9854.camel@intel.com>
References: <2692681.mvXUDI8C0e@kreacher>
         <043b2c3e3024ffaeca69046ae546303ff65694ed.camel@intel.com>
         <CAJZ5v0hwe0ctNU2hLwTorp=JQT_Q3cePw0JQLvcrvQaD5jc5Tg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hwe0ctNU2hLwTorp=JQT_Q3cePw0JQLvcrvQaD5jc5Tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB6452:EE_
x-ms-office365-filtering-correlation-id: f20d4719-93de-423f-c095-08db243031eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xnPBACXFKjBUAocblGBS4xK/acKhrQw0abHxfqQg8/BfgAk4gMksCeswkkIhZikUlRFAhGDSoBtfbjM4DS3j/F/8whYAeRl1MECHIAOAEtdqcjiWvsQlLvLQjIhxwG/5B6Zp0mD5+raUSDu9RxNtWX66LhWbbKbLjCsOXJY/rk/i8b7+SH/mii0XMo8lirZ01tcInkdxqoo1LIf4p3Qoo0fjFSWiwpa5Ha8QmxGtMGtCg6iOvQVaHa2FCDiAuraLmAWQdSQF+rwrM16JdVGpFWpvq5WyY5Yt27ACrzL+YyywbfVJPGJb9RfiKe09ZGx8ad5J3/7yqtk0bZ9odNUdVcLZiPfqzv6t0DrE2K8AMky/IzSfw1CXNmJDOj+EEEMyw4CdpoPQ0iYlwa+OAcZRGl29u5QSmevZ6nK7L1fM85q7o6MQ8Wma9YFgXHa3VbEhT7murJ2wrkT95nfP2Foi0WrdJ3P8U5hQfBR/dZ8d1+jfC7a3tc+PC1VV5yS0KfUDlv9cgsuqFO6Ip9o7BESOWQTG3QpRx0C/Po45ieZQAk+XTJBZqgVq1KbFVbZkViId8J6Ful1HBOkTbGDVgOGAQ8FoYlY3mxwyPk9zFTUxhmPgCjQK3PPus54g6S34MkRqRLMM5+o8aZWDMZeKWOA5HSw5yU+bf9UvZk8OmLd6FM4Z4w2dZcdcMcsVEHW9Shn0xRpQ0N14FfMFvbg11c5VxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(2616005)(2906002)(186003)(38100700002)(122000001)(82960400001)(26005)(6512007)(41300700001)(38070700005)(6506007)(53546011)(83380400001)(5660300002)(478600001)(316002)(8936002)(64756008)(54906003)(36756003)(66476007)(6486002)(91956017)(86362001)(8676002)(6916009)(66946007)(66556008)(66446008)(76116006)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi9KckFoT0hhQTRLaVZBVzhnN2R5WkExOVlwdTZlVDRtbDFGdElMS294WHBh?=
 =?utf-8?B?eGZTeDhzU3dadHdJMy9xNkJ5Z1Jad054aU1xa2NnWFdrbEw0a3JadUhhVVQ0?=
 =?utf-8?B?NzQwUEtQNFhFN0VIZitVSVU2c2IzNWhVRTJ5Vy9tUkR2UTdERnBNRUtsV04r?=
 =?utf-8?B?TzU2VkYxeDhMTEl5R0RQcUEyU0hkcnFTQ1pQT1FQUGNCYXpIU3gyNnFWbEpL?=
 =?utf-8?B?M2JJM2RkYTVqZlNTMEYyTC9EcWF1VXNsUm9xNGZuVGp6Yis1V0RKYUs4cnEy?=
 =?utf-8?B?aHJndXV0aDhsdDl0dkFBTlpuSmZGakVwZWxwUi93TEFIaEFmR2lZYVZJbWh2?=
 =?utf-8?B?Sm1pbERFTlJEaWtybE11UmVQWmZEU0tYallkMU96czI2dlZEVkpaZFE3ZG5P?=
 =?utf-8?B?SnRCT1VwYTkyMDE3UjBhQVdaSVoydDVLTjJUU1hzMXJRSXljS052Z3ZYVzEv?=
 =?utf-8?B?c2pqV3lsZ2tsSzNYWFI4K3lRcFNDOURrZGJOaHlsWlQ4cjNBbldtUDBidmFq?=
 =?utf-8?B?eTlYRml5SU13dW8raDdoRWRpQU1iNmdCbkp0blVoZWtpNVFxcGdrbDhZT0xF?=
 =?utf-8?B?WGptS09iRFVJQ0d3dk1kYXJ3dDk3WGhHSnZVeEU0eEkvUnliRzVmaVE0V1F0?=
 =?utf-8?B?TU4rOTVDTUlpK01tZFEreC9MdHFpbjZJeWVUUVByejIzOGh5dUVvV294MGJE?=
 =?utf-8?B?eTdLMUNPMXlSd1BmR3AxSWZ4QmlITFJvakpLQUhuUTJ6Qmo1YzY0Q05ycm50?=
 =?utf-8?B?UlozZ3Z5Nm5IZkJ4Tk5hcHdqdDdkUm9IRVpRZ29tejQ5bEJXWlZ3R1JaMWZH?=
 =?utf-8?B?R0xGd3hUd3hKRzI2T1cyaUN4amgxTDV3Vkg4QVRoM3lwOTJxeUlqUkxqbnNx?=
 =?utf-8?B?UmxVT090TFNzSkdVRjcvUy9oaXVGSTFsSEtOKzhLTGlVTytJOFoxRFh0NDBS?=
 =?utf-8?B?bEEvVTY4dEgwMlZlc1prRjNET2NTbEJERG1mVXZQK0NCeU0wcDI5dkREYWRs?=
 =?utf-8?B?MWdoNnJBblNhMkdQbkVqUEpoMHFvNkVUc0xUa0s4QkpySGc0YVpNaDRHU3Zr?=
 =?utf-8?B?UURaOURlWWMweWY3RXZSS2UzSDRtZ2owbDJLTnlCOHdrT1N2bW1BTnVCdGcw?=
 =?utf-8?B?Uit4cTR1RXBlWWFGZkJvZnlUTFViT3B1cUF1S215dStia2RpUEFCelR4SVA3?=
 =?utf-8?B?bXppVXhWWmMvYTVFemRnNTcvUFdSWi9KV0ZBK0dnSk5DZlhTM0twWnRoa3RJ?=
 =?utf-8?B?VldVKzB2UnVVeXZMZmMyRER2bXJjUmhCMGhsUHFUTzhZWnlNNkZUNVNGQmVy?=
 =?utf-8?B?UUlTT2JWOWExclBzV1k1UUM5OWw3SHcramFTL0pUYXRmRzB4b05nbXpDWDRC?=
 =?utf-8?B?UjducHVJK1BJUEcrbktxc3dvV3VJZnFBVlZsVkpYeFdSOElicVUvRGliZHZq?=
 =?utf-8?B?ZkpydTV4djhPbkZDNWlabERTMUh2Nlk0cWdFMUM3NlU4NTNXaXJOSlpZTEF4?=
 =?utf-8?B?MmUyd0ZJdmZqSzJEWmZmVUVYZWI4WHFKMUFtRnlld0NPcmlENS9xcFJ1VmJM?=
 =?utf-8?B?RkVjL3ViMzdWRmdKR2hoMmRHRkZITXgvbE53aG1EUFpGZGE5KzV6ZDlCSll0?=
 =?utf-8?B?dUhhdnU4VTNKMU5wOEFmcGxUbTZmY1NYTXg3MUhzcThiUVdQY2E5RUpzR1Jp?=
 =?utf-8?B?RGFydWRtMXpvUmRwRWhBcnYyTVhYYlFRQzR4ZjlkUEFiMVhDMVcvNlZTbCtu?=
 =?utf-8?B?cUpLOWRkay9kVjZJaEFsVjBOS2xuZEVmRWZvdVpxYnhTUmNOQnFRRTIwb3h3?=
 =?utf-8?B?NHpPOS9xWmRzZkkxNlA0L2l6UmlNTVhncWNxSGFYdFdYY3ZkVTN4cktTNTUz?=
 =?utf-8?B?R2NQNlFHcE9mR0J2MFZMQUROVWJ4VzA3K2gzMXcybDFnRVdDNzdveXpXYlVa?=
 =?utf-8?B?WmpJNnZwZWZoMVdxMEwzaUk0OUNnNGEvanI1K0lHcDl3WHQzMTFCMnJmdEcr?=
 =?utf-8?B?MmpJU2o2WlBZOXFsOWN4L05MUFNMMjVyOHFEUGQ0ajlWcmdSSE1nc1UrUW5R?=
 =?utf-8?B?dURPakg4MXdDbEhVV2RjQkdqc2ZkbDdPYTdCdFF3WWFhV0hyRXQ3UkdMVXkw?=
 =?utf-8?Q?YQhJkIJA1T7+BEOl362xKnI2P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C59FAA76A02EB240BD3B5D9A2E5E8693@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d4719-93de-423f-c095-08db243031eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:02:41.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kl1yM2dyXXOVOca7EAOOJJOYhuaYC+4W6mBdRS1iEkh12MHw4wTskA0rLx2ihofaeKMb624ML8CcJqT+fTpz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE5OjAyICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBNYXIgMTMsIDIwMjMgYXQgNTo0N+KAr1BNIFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IEhpLCBSYWZhZWwsDQo+ID4gDQo+ID4gVGhl
IG9ubHkgY29uY2VybiB0byBtZSBpcyB0aGF0LCBpbiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3Vw
ZGF0ZSgpLA0KPiA+IHdlDQo+ID4gc2hvdWxkIGhhbmRsZSB0aGUgY2FzZXMgdGhhdCB0aGUgY29v
bGluZyBkZXZpY2UgaXMgY3VycmVudCB1c2VkIGJ5DQo+ID4gb25lL21vcmUgdGhlcm1hbCB6b25l
LiBzYXksIHNvbWV0aGluZyBsaWtlDQo+ID4gDQo+ID4gbGlzdF9mb3JfZWFjaF9lbnRyeShwb3Ms
ICZjZGV2LT50aGVybWFsX2luc3RhbmNlcywgY2Rldl9ub2RlKSB7DQo+ID4gICAgICAgICAvKiBl
LmcuIHdoYXQgdG8gZG8gaWYgdHoxIHNldCBpdCB0byBzdGF0ZSAxIHByZXZpb3VzbHkgKi8NCj4g
PiB9DQo+ID4gSSBoYXZlIG5vdCBnb3QgYSBjbGVhciBpZGVhIHdoYXQgd2Ugc2hvdWxkIGRvIGhl
cmUuDQo+IA0KPiBGb3IgZWFjaCBpbnN0YW5jZSwgc2V0IHVwcGVyIHRvIG1heF9zdGF0ZSBpZiBh
Ym92ZSBpdCBhbmQgc2V0IHRhcmdldA0KPiB0byB1cHBlciBpZiBhYm92ZSBpdCBJJ2Qgc2F5Lg0K
PiANCg0KU2F5LCBiZWZvcmUgdXBkYXRlLA0KbWF4X3N0YXRlOiAzDQp0YXJnZXQ6IDENCnVwcGVy
IGlzIHNldCB0byAzIGJlY2F1c2UgdXBwZXIgPT0gVEhFUk1BTF9OT19MSU1JVCBkdXJpbmcgYmlu
ZGluZw0KDQp0aGVuLCBhZnRlciB1cGRhdGUNCm1heF9zdGF0ZTogNw0KdGFyZ2V0OiA/DQp1cHBl
cjogPw0KDQpNYXliZSB3ZSBzaG91bGQgZG8gdW5iaW5kIGFuZCByZWJpbmQsIGFuZCB0aGVuIHNl
dCB0YXJnZXQNCnRvIFRIRVJNQUxfTk9fVEFSR0VUPyBpdCBpcyByZWFsbHkgdGhlIGdvdmVybm9y
IHRoYXQgc2hvdWxkIHNldCB0aGUNCnRhcmdldC4NCg0KPiBJIGd1ZXNzIG90aGVyd2lzZSB0aGVy
ZSBtYXkgYmUgc29tZSBjb25mdXNpb24gaW4gcHJpbmNpcGxlIGFuZCBJIGhhdmUNCj4gbWlzc2Vk
IHRoYXQgcGllY2UsIHNvIHRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0IQ0KPiANCj4gPiBCdXQg
Z2l2ZW4gdGhhdCBJIGhhdmUgY29uZmlybWVkIHRoYXQgdGhpcyBwYXRjaCBzZXJpZXMgZml4ZXMg
dGhlDQo+ID4gb3JpZ2luYWwgcHJvYmxlbSwgYW5kIHRoZSBBQ1BJIHBhc3NpdmUgY29vbGluZyBp
cyB1bmxpa2VseSB0byBiZQ0KPiA+IHRyaWdnZXJlZCBiZWZvcmUgQ1BVRlJFUV9DUkVBVEVfUE9M
SUNZIG5vdGlmaWNhdGlvbiwgcHJvYmFibHkgd2UNCj4gPiBjYW4NCj4gPiBhZGRyZXNzIHRoYXQg
cHJvYmxlbSBsYXRlci4NCj4gPiANCj4gPiBUZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwu
Y29tPg0KPiANCj4gDQpJIHJlY2FsbGVkIHRoYXQgcGF0Y2h3b3JrIHVzZWQgdG8gY2F0Y2ggdGhl
c2UgdGFncyBoZXJlIGFuZCBhcHBseSB0aGVtDQp0byBldmVyeSBwYXRjaGVzIGluIHRoZSBzZXJp
ZXMsIHNvIHRoZSB0YWdzIGFyZSBhcHBlbmRlZCBhdXRvbWF0aWNhbGx5DQp3aGVuIGFwcGx5aW5n
IHRoZSBwYXRjaGVzLiBCdXQgaXQgYXBwYXJlbnRseSBkb2VzIG5vdCB3b3JrIG5vdy4NCg0KTGV0
IG1lIHJlcGx5IHRvIHRoZSBwYXRjaGVzIG9uZSBieSBvbmUuDQoNCnRoYW5rcywNCnJ1aQ0K
