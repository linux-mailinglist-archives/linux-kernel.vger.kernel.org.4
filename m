Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7FA63EF88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiLALdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiLALdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:33:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F2D2E1;
        Thu,  1 Dec 2022 03:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669894417; x=1701430417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BGJX4G1SOAz02AQOQ4vzQlT6NCP3BqUUW6zN9dtN5kM=;
  b=eqIvZcn9+0Z7F4bfwHbIJ9N3XrnuhrwvQ3CdSR+nn+DWtrx8IqXBseEO
   ehadbMKVgg50Cv0ArriKrsRBJq8wDTJIcZkw1QEeppAwxOc3zuYKcHGIm
   SfIZob9KRdVa2xZ9flvaw1njT2Wi3bUpputw5DQ+rINIWbQwurmKQs8jw
   /PScPXtKxdN1KE68mdp0QeuRdPq/YsQZcqp5EIDg7u6kloFazx4qltiA0
   LBgnrM74LD64hgWwPYhiWDmGywlBdwu4ELOIrLBsDY92aU9815idlNcUp
   Q1dSWa/VwDFyGg+c+EdR8diINBeuVPiiTgUUAnsZ8OJ9l0hxXiTDkvfMC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313291445"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="313291445"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 03:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769203207"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="769203207"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2022 03:33:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 03:33:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 03:33:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 03:33:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 03:33:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU4ogi9utDsxDbzr9ctwdrbCVT6+/Xu9U/X3u7CJRXVVKnA9H+u6pHyG6Dkk73fYawSn6Eki+sZ+3o0kXxzNgUEBFIeoiK7cDhkGxhLft01GSa69N+nPYDHHhmOCTIeOaHSTZ2ps/08SFLrlJcdszLMkPpU8nCBTYCYMSxxv3z87JvVteAJu8OcfdM5JfrFwhWYqclJpViGAR4yuD8Aee7H6LyjbByUfv9FQk+QFGQ06so7XCzee0LDpg4vtPabjP3llckAc91qiyjArgrFDgTNiNu9DSQp8O8S5rSWWhAAoy/ikwjRrDx/YHY4uoF6g2ZdIROZq6Voa1BzT8J9FKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGJX4G1SOAz02AQOQ4vzQlT6NCP3BqUUW6zN9dtN5kM=;
 b=bveI1zabHB/wEMIqxIEmuKgb8HvDCbuVoW2tyVEMassmZGPKUOIPMGg9eFHqX0yuFQpSIK9kGKwviRBwEfp24fFcazuQ+6AOWli4ppFKCowz7SWBxcX+ZskOUMNgNqsFXn5bAHgZdlxSsrj1sn7zT9QH7XN+YIMX2UUDMXnrKbGY/MuwX5KE2ep057SO+BoRTFkv571RjvDvyr8LXI/nBKGSIgl/gi3OLLjTCLAolWB7v3OOoGL3+fOL2K0tU5nMxL5494K9SJHzsEQpkaqFIaDH2VsGRdLA6nGIKWKE3KCCMUrRuyrkBPNec9VEKT9CEXAEn8h31witSdkb4WKnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 1 Dec 2022 11:33:34 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5546:ea97:1beb:cb5f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5546:ea97:1beb:cb5f%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 11:33:34 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "chiluk@ubuntu.com" <chiluk@ubuntu.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtyZWdyZXNzaW9uXSBCdWfCoDIxNjc1MyAtIDZlIDYgZ2h6IGJhbmRz?=
 =?utf-8?Q?_are_disabled_since_5.16_on_intel_ax211?=
Thread-Topic: =?utf-8?B?W3JlZ3Jlc3Npb25dIEJ1Z8KgMjE2NzUzIC0gNmUgNiBnaHogYmFuZHMgYXJl?=
 =?utf-8?Q?_disabled_since_5.16_on_intel_ax211?=
Thread-Index: AQHZBW3Y4tDtN+8h6UGgIKzpmYEhcq5Y5p8A
Date:   Thu, 1 Dec 2022 11:33:34 +0000
Message-ID: <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
In-Reply-To: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3207:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: 612f9f11-c7dd-44f7-142e-08dad38fe164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fMX/k23C4T+r6HFkUj2jDdCycj+Ad3c3tCam23+YKpWSuB3abIifDm/O6jI6/+bVEfmJFtn1XRgZc66FqhWFdfJQHveC5Q7if9dex9oCOPXw5oxps0YwrT08PZ+BHtkYIjorKxjG+MMSqBsIirkREvVX+GN16P4J2qo2w6gWj3g67D//ACSlKd5Bo5uZpOWVuHGDFnKmUoSSZuQD1JX5omBYoW/F50xKHbr2lPM99zzplrNzbfLSVrkNk1KOpbrlRHOkCF1T8Tn4L+hcA/GkzCLVEdCwfnF2gXU1OyJExtjjTKkMO5EFrkcpuuXt4b9gSm5Jsyh4qim+8bKQKYLUE1OSroadTzY3K3Hf/W8RGlB37gtHay9u0mRzX34Ss5XxdvrxMUtp29EYzfqV3Sho4ob1DHpQjPSyWemPkYFR+ftV2vd5JsshbixMZJBbMtFFj/BQRZpVDUuHrT4ylM//wOy67eMoXTiA8k9AyFhxr1lmrXPDQhI9MkgAuIl8fqdJr1PGCZNblAr54pYRw3VosIPu53wVhcHZnTcTT3l7j1kn8bbw44ZAAIdqu3nRFoSjyCoheeCEcIPsQpPDf43NEVuZMxOZWbXMsqHYKCxASoPNYngaqIvV0F0VUhloaQmnFefQLoA24xhV+MI67aC8ywMflCyA+1Nk+UxwDIdxleFAg/7dQgz4q4G8Ae3IYujRaEJIaUZ5JWw3jVOEo+7IfFLbIFgtl/ToQxq9wmHAS0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(66476007)(66446008)(66556008)(4326008)(64756008)(110136005)(41300700001)(5660300002)(66946007)(76116006)(316002)(8936002)(36756003)(2616005)(966005)(6486002)(6506007)(186003)(26005)(6512007)(71200400001)(478600001)(91956017)(6636002)(54906003)(38070700005)(83380400001)(38100700002)(122000001)(86362001)(82960400001)(2906002)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWF2b3h3OG5Ba2ZJZFlvRDR4R1QxeVdlU0QvSmRLSkIraU9KbE9HT1dVdUVD?=
 =?utf-8?B?Z1hKa1ptbWRyT1d4dmZkZ0Z5VFVTWjJBZTdCT0cybWR3OGtJZkhpaFFsUFRp?=
 =?utf-8?B?Z0kzcUFnZzBxVVN2b3ZMQkdtOFRtaTMxc2NmazRDNSs0ZUtLOVhZWG1pZzJ0?=
 =?utf-8?B?ODlWODZpL2NCZ0RlNmlxaXVGNEtUTnJhTFhxLzcwa0N5NEh2REMxVFZod0dV?=
 =?utf-8?B?WWd6TWlTNXhyR3E1alhIcjc4QUJqT09ETlZCMUVad3BhWk0ybkRJdjdDS2Fv?=
 =?utf-8?B?YTNXUEhUWks4STFySk5sSzh2Mm41c3lkUGdvaXA2U1Zocm0rNllyYzF3Nm1H?=
 =?utf-8?B?SE9hbC8raVh2Mm5VdlF4UDBrREFsMXBFYVNyR0lobUNVOWdDWE9SWFZ0a1hZ?=
 =?utf-8?B?eUlSaWpNcWJmMC8yU3ArL0FaZDhsMGxhVmllUSttclVpM3RNdlpoQU5BKytE?=
 =?utf-8?B?N292SG9NY1NOMDIyYUVvUXNpY0IvK3Bka0pndjQwaFdJeXgzdXZPOUJVbmhX?=
 =?utf-8?B?ZGE2ejBnMnpHWE5qZ3VWSjB4bDhOdHFRVDc1SldvOGF3QmI4MjQ5NjdQVFNT?=
 =?utf-8?B?RGtEZWZQeGNBSGhtbUxEckYyWE9sVFVoY1ZoYmttNkZDdWo4dXFhN3BiMVZ5?=
 =?utf-8?B?a2pBS2JtaTU0S2NJc3dwd1RKcFU4dHlwbW9yRklWdDkwcVphNjRJSndBY3Nx?=
 =?utf-8?B?QzljbjAxaWk3UlUxSE9CYmhKV0lHM3ZHY3hQRUlFbWlabmNHRzJDUXJVYWRq?=
 =?utf-8?B?MHdsd3lScVA5NG5vN0s0Q1cyQ01yeG1FUGszS05vOU9MUlJZb3RuWHBRVzRL?=
 =?utf-8?B?Sm1JbzVxMmJiQnVLeDdJRTU3MEJpRC9Ja1VFNUFET1dIK3hQU01DYThIeXZ2?=
 =?utf-8?B?ekVJdHlDSDUycllEK29JN0tvYnhvTnVNOURlM25UVk1BdTZqV0ZTTXFlWCsw?=
 =?utf-8?B?ZmlVSFRYZENpWDRlbk02NEpoQ3dsNHJqczc3QkZLL2ZSTWZYWFJmaU9DM0dk?=
 =?utf-8?B?Q0FPOEQyb2ZsL1BNZytEUDJCMFRWQ01TZXVrYnV0Z3p5bUNYT3FMWVhzT3Jr?=
 =?utf-8?B?S2xreXhKelY5MzZBT0pVbmsrSjRFUVRnUUdnQWJDbmloR3N2WUZoRnJUcFFv?=
 =?utf-8?B?TkZEZFI2UnlqaXJMRGh4UGFKc1ZQdkN6U1pVUCs0eGd2Z2g3blFaaUhmejhF?=
 =?utf-8?B?U0F2ZzdOZjNSOXJGeFUxUkhxSmMvbzEwOTBuK0lMYXdQeHhsK0NFUnZCMEtl?=
 =?utf-8?B?bWg0Y2w1RFQzeE9FTkhTWCsrTk1hYUdOWURESzlIOG5sMElnRElvblc5UWR4?=
 =?utf-8?B?cU9tclRDNTh4dDdFQVU1cjlCaXh0QnM4WnZvVU5ucFBHdTRuWGpjWmg1RG1s?=
 =?utf-8?B?WDg2Nm9BTkF6S0xXNEZhQkdGUVJyKzNEUVYwVE9ZL25mdVBROHV6ZEdPOW5i?=
 =?utf-8?B?RGpiTzRYSXcrYUVKdjBiQWRNQ0tpNW51WkN5eG5kVlpEWEt0eU1rL0dDT0g0?=
 =?utf-8?B?VTRLZ243Y2c0cG9wVmdHUUR5dEFaR3A4a21ib0JOaUhQY0tuL0JLZkFVRVZY?=
 =?utf-8?B?QmNZNDlwZ2pPRVRNemRhczljMW5UdlJIRW05SkN2aC9sOWljWW1IYnpBeWw4?=
 =?utf-8?B?eitFbkV6SGF0Vk53Nko1ZE9QV01qbW12UTBLSWpjb1pFNXNFT2lzS3U3VzNU?=
 =?utf-8?B?bDhkTWQxc0ZMa2JCWDVOWHJkeTV6YWgrTHBuVUFHLzM3QXBKYlhmUFk2QmJY?=
 =?utf-8?B?WnE3MFd2Q01SQ3RrVGlieDlKbitSL3A2R2l1cG1DZWp5TnFHQWlxWUcxQ0pD?=
 =?utf-8?B?Qm5BeU1UVGErL0dQMWRYUDU5ak00MnJPNnlPWGJ2OU5PNjBzS0hCbmVjMXFU?=
 =?utf-8?B?RThBVmt0NWxGbDRtTlJNZkNIQjRJaUZVNitSdi95NHpwVlNkaGVZRUZ3QWN3?=
 =?utf-8?B?eW1LUEZ6S3UvNGlXOXc2SUdwNzN4L2l2ckU3TmxGeEFJci8zNEVIcG5GSUNG?=
 =?utf-8?B?ZmZFSFFUbUtaM3FXWFNWRS84M3ZlSVhqWUpQRms0MUd6cFZyWEhxNU1FYzds?=
 =?utf-8?B?MUxhOGM3eVhDWmcrV3Uxa3VNUTVTd1EvTFVuWitKOWt1Y2lUTmZSbHpJYldp?=
 =?utf-8?B?alh0aTVJZ1dLOVhVRGZtaEtrMFJPbFJXWWdobmV6Y3JjRzFjQnRiRXJOd1VB?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DE32209E3DEA04AAA1C181F49A55A69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612f9f11-c7dd-44f7-142e-08dad38fe164
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 11:33:34.1094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: On4y6S8Grz/AcNmquTV7ji/MmvedX7xBSiH1Pbg1YjxO2A/l99Ze2AC/X18A+6PbolK/oLZOSMCEfemAjK7+3dObAqxUr0hYVZfMCaR4a9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTAxIGF0IDExOjE0ICswMTAwLCBUaG9yc3RlbiBMZWVtaHVpcyB3cm90
ZToNCj4gSGksIHRoaXMgaXMgeW91ciBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2VyLg0K
PiANCj4gTHVjYSwgSSBub3RpY2VkIGEgcmVncmVzc2lvbiByZXBvcnQgaW4gYnVnemlsbGEgd2hl
cmUgSSdkIGxpa2UgeW91cg0KPiBhZHZpY2Ugb24uIFRvIHF1b3RlIGh0dHBzOi8vYnVnemlsbGEu
a2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE2NzUzDQoNCkhpIFRob3JzdGVuIHdlYXJpbmct
dGhlLXJlZ3Jlc3Npb24taGF0LCDwn5mCDQoNCkknbSBub3QgdGhlIG1haW50YWluZXIgb2YgaXds
d2lmaSBhbnltb3JlLCBzbyBJJ20gYWRkaW5nIHRoZSBuZXcNCm1haW50YWluZXIgaGVyZSwgR3Jl
Z29yeSBHcmVlbm1hbi4NCg0KR3JlZ29yeSwgY2FuIHlvdSB0YWtlIGEgbG9vaz8NCg0KDQo+ID4g
SXQgbG9va3MgbGlrZSB0aGUgc2VsZi1tYW5hZ2VkIHJlZ3VsYXRvcnkgaW5mb3JtYXRpb24gaXMg
Y2F1c2luZyB0aGUgNmdoeiBiYW5kIHRvIGJlIGRpc2FibGVkIG9uIG15IEFYMjExIChpbiB0aGUg
VVMpLiAgDQo+ID4gaXcgcmVnIGdldCBzaG93cyBubyA2Z2h6IGJhbmRzIChvdXRwdXQgYXQgdGhl
IGJvdHRvbSkuDQo+ID4gDQo+ID4gJCBzdWRvIGl3IHBoeTAgY2hhbm5lbCANCj4gPiAuLi4NCj4g
PiBCYW5kIDQ6DQo+ID4gCSogNTk1NSBNSHogWzFdIChkaXNhYmxlZCkNCj4gPiAJKiA1OTc1IE1I
eiBbNV0gKGRpc2FibGVkKQ0KPiA+IAkqIDU5OTUgTUh6IFs5XSAoZGlzYWJsZWQpDQo+ID4gICAg
ICAgICAuLi4uKGNvbnRpbnVlcyB3aXRoIGFsbCBkaXNhYmxlZCANCj4gPiAgICAgICAgICogNzEx
NSBNSHogWzIzM10gKGRpc2FibGVkKQ0KPiA+IC4uLg0KPiA+IA0KPiA+IEkgd2FzIGFibGUgdG8g
bmFycm93IHRoaXMgZG93biB0byBoYXZpbmcgYmVlbiBpbnRyb2R1Y2VkIGR1cmluZyB0aGUgNS4x
NiBkZXZlbG9wbWVudCB3aW5kb3csIGFzIDUuMTUuNzkgbGludXgtc3RhYmxlIGtlcm5lbCB3b3Jr
cyBhbmQgdGhlIDUuMTYuMTIgZG9lcyANCj4gPiBub3QgKGVhcmxpZXIgYnVpbGRzIG9mIDUuMTYg
a2VybmVsIGZhaWwgdG8gYm9vdCBvbiBteSBtYWNoaW5lIGZvciBzb21lIHJlYXNvbikuIA0KPiA+
IA0KPiA+IEkgZm91bmQgaHR0cHM6Ly9jb21tdW5pdHkuZnJhbWUud29yay90L2tlcm5lbC01LTE2
LTZnaHotZGlzYWJsZWQtYXgyMTAvMTU2NzUvNQ0KPiA+IGFuZCB0aGV5IGltcGx5IHRoYXQgdGhp
cyByZWdyZXNzaW9uIHdhcyBpbnRyb2R1Y2VkIGJ5IA0KPiA+IDY5OGIxNjZlZDM0NjRlMTYwNGEw
ZTZhM2UyM2NjMWI1MjlhNWFkYzENCj4gPiBJIGhhdmVuJ3QgaW5kZXBlbmRlbnRseSB2ZXJpZmll
ZCB0aGlzIGNvbW1pdCBhcyB0aGUgZGVmaW5pdGl2ZSBpc3N1ZS4NCj4gDQo+IFlvdSBhdXRob3Jl
ZCA2OThiMTY2ZWQzNDYgKCJpd2x3aWZpOiBtdm06IHJlYWQgNkUgZW5hYmxlbWVudCBmbGFncyBm
cm9tDQo+IERTTSBhbmQgcGFzcyB0byBGVyIpLiBBcyBpdCBpcyBhIHJlZ3Jlc3Npb25zIGlzIGlk
ZWFsbHkgc2hvdWxkIGJlIGRlYWx0DQo+IHdpdGguIEJ1dCB0aGlzIGFyZWEgaW4gdHJpY2t5IGR1
ZSB0byB0aGUgbGVnYWwgaW1wbGljYXRpb25zLiBIZW5jZSBJDQo+IHdvbmRlcjogaXMgdGhlcmUg
YW55dGhpbmcgd2UgY2FuIGRvIGFib3V0IHRoaXMsIG9yIGlzIHRoaXMgc2ltcGx5IGEgY2FzZQ0K
PiB3aGVyZSB3ZSBoYXZlIHRvIGJpdGUgdGhlIGJ1bGxldCBhbmQgbGl2ZSB3aXRoIHRoaXMgcmVn
cmVzc2lvbj8NCj4gDQo+IENpYW8sIFRob3JzdGVuICh3ZWFyaW5nIGhpcyAndGhlIExpbnV4IGtl
cm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlcicgaGF0KQ0KPiANCj4gUC5TLjogQXMgdGhlIExpbnV4
IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlciBJIGRlYWwgd2l0aCBhIGxvdCBvZg0KPiByZXBv
cnRzIGFuZCBzb21ldGltZXMgbWlzcyBzb21ldGhpbmcgaW1wb3J0YW50IHdoZW4gd3JpdGluZyBt
YWlscyBsaWtlDQo+IHRoaXMuIElmIHRoYXQncyB0aGUgY2FzZSBoZXJlLCBkb24ndCBoZXNpdGF0
ZSB0byB0ZWxsIG1lIGluIGEgcHVibGljDQo+IHJlcGx5LCBpdCdzIGluIGV2ZXJ5b25lJ3MgaW50
ZXJlc3QgdG8gc2V0IHRoZSBwdWJsaWMgcmVjb3JkIHN0cmFpZ2h0Lg0K
