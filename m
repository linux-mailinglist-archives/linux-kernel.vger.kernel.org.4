Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A3F6A275E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 06:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBYFaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 00:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYFaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 00:30:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2124964E13;
        Fri, 24 Feb 2023 21:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677303004; x=1708839004;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=ueDP6tNiW1XgOJUyHEnbn+Y8QcvIhzM//ih1oqA2I3I=;
  b=Gf9zpZtlHhTwJOTxUMlogo877lI8SuWl5HYhxm/sn2wDtNlqpjCevcWJ
   /RvJCt6EJqD9CAbfwXPKzSGXMuj5TM8+Fzs/pkhdHOBQcobBF3hF82DNx
   xIVoG1GX47dnEFQbeaTqzBeUvoLCjnfGlOj6UqPuaylfOyRnXPB5Ugq92
   X+8eQ2COWLbf1c971HASfRfNJh5qMaMhA7N0JFYNGcNn64hzciKboQXYF
   sUMst6JflSsMLUa9oO5XOdd9Gk3pzxLoO2ngpDdDTVgxD41cAiXgZ0r9c
   F28XYZGgzRG5DTMkPCn1ijHoUfrIt5XD+y82Z6o+xh8wMMSQALj5aFCcb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="361144432"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="361144432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 21:30:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="673123998"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="673123998"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2023 21:30:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 21:30:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 21:30:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 21:30:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 21:30:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUVU5NeumxlzYnNaGKuiR8Myr0YW74832r1MUQ0vDbZaoHxFS8/RTfEwEF1x/sRJawehWKoUBgWGMT9dMEbDTm8DC2CH0WFjmDeJbMQcsRMIUAzLjmgZxwI5Q1uVvngCin0XWVU0YpwplcCxEthGMZrD6hGBZf7gn6kpcXmLgbZ28psJPFR0xyAypo1Dg+um7Lqnna+D3fy5woPi/Iol1MUnkxFOthnTjoBxY79BAiH3lXFyvVmgn7Y2TZ2JqygsiNtutpm6ESw7hqRCMAkXNJv/Bgloee9Ceal+sWjLlwJyTIfEvLRR4RKUyCyq7mnGEZ9T1ACRM4TkyhcAyCURNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueDP6tNiW1XgOJUyHEnbn+Y8QcvIhzM//ih1oqA2I3I=;
 b=N5ZARe2fgeOvr4epBpzXMjIti/8wzVX5Hu7mBc5huA4l9BjrDalaX15uLWUla0dZ/2dN9fTau8XEjmDU3KAxHmt8piLSkt9bHBld7JI8UVojFOZ2hT9Q6xbaNLsb7BcQr5R3JUcpoQmj9Q7jKhN7aTdcm7zpJVvz50qAWkgOXdPyLWZOT0Bft4mzazPqjJ1JsetmTh7IniY142wumJHztwVvFf6LdSOxajutq9xEALPVtHkE3sfdwwFQsD+qCtUfUO6Mqd6qOUUgHOYeZ09N3TESnOI6owUAD3DJwRPZvfqVYLcZzEqjPsmsfmWVpHlbBipIFyZw28rRp8cZmObsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Sat, 25 Feb
 2023 05:30:00 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%9]) with mapi id 15.20.6134.024; Sat, 25 Feb 2023
 05:30:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Regression] cached max_state breaks ACPI processor cooling device
Thread-Topic: [Regression] cached max_state breaks ACPI processor cooling
 device
Thread-Index: AQHZSNo0olfs8HoYakCXdglc2MjI0g==
Date:   Sat, 25 Feb 2023 05:29:59 +0000
Message-ID: <53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|LV2PR11MB6048:EE_
x-ms-office365-filtering-correlation-id: 4a46fa57-948c-4292-476e-08db16f15692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9EzEViiSeZE9J0xIaOrtvmOebU9Lo04iKOek3M/ulAbCSGckis1SuFfJDGUWQqfRnkQjEoTcZ8YkraUYwdlvBXiNShdF2wuPKkLTHBn7Zygo3I4mYJIWXVbEfQGRvQsxuEHLGMkzDcU1Z4Ne2FSZosLmhskrCx0nLyb5qvOsU2WBFw4Z7og9tpxd2h+OSpXG3V5+b3yKTDGO7rpo+7l6DmkkjqLCe+c7Pm50uVKuW5GAfYOlX46BIssbno7VY/fN3T/DaeWERhFkOxj5I+4Pp3gu0XwZUdGko5KumBLmAfWt77fEy8/mSWZOD9WVmyyBXcwL0atXFBk/1IBQAmgTy3BlrwrItrnUtaaE/oryBzEaEotVINCm6QWvCMSnXI1UR8WulBnD9eAXAOeWOHBYZMINMfTbV//22EjYELqjxGFaY/v3YytgnDGjtMUbHe3QuNSb5GTYs7b9uuP0V8x4wogQi4kT2I29ExhlqEJqHXWsdsInx/NgkviJmGtNYcyn0AOrsqr5fE9Irru2rnauiLOJaKV0Udh3v34aDAZaeu3WATScryJZYdYM5HqN4cAxQSipvZOIiKs3hi2ndt1rtQlHIqwW8rfFWVKvwt8y5zvz250r4rYJBirOBM85nt5u3ZSAMvNyZ5NgOeS2kspxCnkgmCOh7XwbqPrRifyGGeW8X+pCoGmjgFYOWuLStzVe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199018)(26005)(186003)(71200400001)(6512007)(6506007)(478600001)(2616005)(91956017)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(6486002)(966005)(54906003)(110136005)(38100700002)(122000001)(38070700005)(86362001)(82960400001)(83380400001)(2906002)(36756003)(5660300002)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlU3eThOOFFZTml4Zk5nRk4rcE5yeEpjNitDYXpqSVBYam95SzNQeDErc0Ns?=
 =?utf-8?B?cnllYnJ0Q2k5RkFMRlFRZWhDZkhZbEVEeW85dmE3a29QUVhjd29OMmc5WTNW?=
 =?utf-8?B?QkFZSjVQcm5YTkxKcjFmT1ZWbnRtdTZ0eXluNHZFbS82WFZ6dW5yT3BKVnFr?=
 =?utf-8?B?L3NwUDJVSmZ6Z1YwZ3FIZHArQlRpVUg1MThnb0Y5QUNDaU1jWDVRYkVPL2dB?=
 =?utf-8?B?N05CYm1WRXFjQktIdmxvNzdHOWZUMlFqdnZoVm11U2Q1bVBrYzZiREpNZGdG?=
 =?utf-8?B?andkZFg0Vlh3bXFFcUJaL1hIcURyc3VYVkYzRDdVLzRZSDZjZHloTElxMWZC?=
 =?utf-8?B?ekpiNElYL1FaWTRpb1VEd2ZmRmZEcUl1RVlwTm1oSmxQb04ySngxQTkvMm5P?=
 =?utf-8?B?UWI5bDJhdjdwTVpWY0VEa0RiQVFGSFdxWXBnanU1eGhROXJGVHJVV25aOUxK?=
 =?utf-8?B?a1d2VHFjU2pDZDR5N252K216U043WnJCNzZuaDIvaU1LV0NieFErMGFPbjBC?=
 =?utf-8?B?aEExOG0rejUxODlQNjRsOVMwRDZTV1o4VFBoSE9IbkpIV2JQOXlnYXlTbVFN?=
 =?utf-8?B?YzFPbjd1bzR3MUJ6a3VFWnQxNFlwaTY2SGx0VU5XN1Z1QWh3SU95c2ViTjU0?=
 =?utf-8?B?K0ZxUG5EeUROSi80dW5SRGRWdGtjOXJFMnJTQlFyRUFXd0Ixdzc2Y2ZUVC9T?=
 =?utf-8?B?T21ycVVOMW81NTUvZ0xZWGUzY2liKzFaZUNvN3ZRZ0o3Q095SkZHTmpiRWdx?=
 =?utf-8?B?SWVleTNMdk5sdHlYZWlzUWdSa2FSeXprU016bDlNN3dUNVFpUmNsWHVqWXZa?=
 =?utf-8?B?Q3V1Wm5GSlhabGNoOEN0dnpoZnIxTGdjTG5LMU01dVhKc3kzNUVJMTlvaE83?=
 =?utf-8?B?cWdwTzdhN0VlS2dGUzJqbC9pbXh0V1daRnNGVlcrS0N4bUhIc2dPYm13a3Fj?=
 =?utf-8?B?Q3lueSs4Ykh1akNiNlZpK3JvMFdqejRiLzRLZnRMTTdZTHgrWEVzVVBubWp0?=
 =?utf-8?B?a2M3Z0w2bHgvTnBzWkFQbTVHd2VYYXZsWlI0WWxFUkpWRmtXMFhKSWllQnNi?=
 =?utf-8?B?a1Y5WWF3UFRSdTdueEdsTkFiYU9va0gzNXkwMEhDMmN4STloZkdnM1AxSVZt?=
 =?utf-8?B?blN2OGhQRmp1VjYxRjdldXY2V3pOeFUwVytNSnl1SmZNaUFvV0crdko3Mi84?=
 =?utf-8?B?QU9pMHdJUzJzL3pMOC9DU3AvQWNZeFpyTWY5Z1hUK3pCcUwzUjA1Ylh5RHQ0?=
 =?utf-8?B?TWdsQTI1dG10ak5tdytXTUZBMktITkxVTjJtZ1lIYmtMTTZyc2lIWFg0Qzdr?=
 =?utf-8?B?bG1hRlYrR2s5M1dJUVY3TWJScDB2blNGejJuWWhnb1kzazYwWmt0VmQvK28v?=
 =?utf-8?B?NjVWV0NiSTAvYWxKMmtXYXdWUjd0WjF1NEVGc3FOd1hUUzlNeDJtQ1I5dTV2?=
 =?utf-8?B?YXo1Wmd5Q3A2RW1SSEF6R3B3eWx2TENQNzRuVXlEdCt5UjNtQWF4MWEySzBT?=
 =?utf-8?B?TExFYXkyRGE2QmZRTkp1dFRuMXgwd1BlOWtVNkpPWm9TQ016Q2hMYWtBQUhv?=
 =?utf-8?B?TytPLzZUYmM3alUvT3M5N3krdEo1M2VJL3lFeGh6TzJKY0xsTkxWNnpLWXND?=
 =?utf-8?B?Y3d5cnArNEdjMmg0V0w2SzVwRytxdGtaRFMzdXErN2VmenVzZEU0b1VDYm0y?=
 =?utf-8?B?YUg2Q0Z3V1NhV1lmaXM2aFFMd1pyVUkvaFJOYkJjV21Xb2gwVmgyT29DdnhM?=
 =?utf-8?B?dTVpYWpzTUIwNXJTTzhIejFldVV2aTlWSXdzbExiNkQrUUZ1VnVJalFKdldp?=
 =?utf-8?B?TmNvYXhFLzA0ZjE3SWR6SWozZ2dYVDJ6RmozKzBxM284RVpLaEQvODJIQjIr?=
 =?utf-8?B?WnRqSGpLWmh3QUZldnB1eklTRnoySEFvUlVjMHQvWGRuVU43ZHJOSHg0anU2?=
 =?utf-8?B?SGErVmhMdDdxV3RNZXpuNHU2MndyQXo5ZmJma3RBUWx6eXpTOVd6c0NmZ0Zy?=
 =?utf-8?B?U0FUM1dKK0VnSHRUWGhFYyt1LzdCaDZFQlFtb0JCOGJ0ZjR3SlZBb1JUNlZY?=
 =?utf-8?B?RisrR3I5citrRUxUME5PNmlTc3FjN3I1Z2dpQTJrRVpRRW1ldEVTckZGengv?=
 =?utf-8?B?V1ZnM254RzlrWTNIZzF4MmRMcnFNaDRGdlpRSHBIaG1GczJaT245S0p5ME15?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF4708BB3A7EC94C9D895BF9A9A7C5B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a46fa57-948c-4292-476e-08db16f15692
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2023 05:29:59.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g53zjdzPHGzmkipt7DalqszPJFbulJO2fx/QNVVHHKH07rbPquoLFbi4g4vMZc5LoXblXxDtt0/kgAlOi8MWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
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

SGksIEFsbCwNCg0KU3RhcnRpbmcgZnJvbSBjb21taXQgYzQwOGIzZDFkOWJiKCJ0aGVybWFsOiBW
YWxpZGF0ZSBuZXcgc3RhdGUgaW4NCmN1cl9zdGF0ZV9zdG9yZSgpIikgYW5kIGNvbW1pdCBhMzY1
MTA1YzY4NWMoInRoZXJtYWw6IHN5c2ZzOiBSZXVzZQ0KY2Rldi0+bWF4X3N0YXRlIiksIHRoZSBj
ZGV2LT5nZXRfbWF4X3N0YXRlKCkgaXMgZXZhbHVhdGVkIG9ubHkgb25jZQ0KZHVyaW5nIGNvb2xp
bmcgZGV2aWNlIHJlZ2lzdHJhdGlvbi4NCg0KVGhpcyBpcyBkb25lIHRvIGZpeCB0aGUgYmVsb3cg
U21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQoJZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
c3lzZnMuYzo2NTYgdGhlcm1hbF9jb29saW5nX2RldmljZV9zdGF0c191cGRhdGUoKQ0KCXdhcm46
IHBvdGVudGlhbCBpbnRlZ2VyIG92ZXJmbG93IGZyb20gdXNlciAnc3RhdHMtPnN0YXRlICoNCnN0
YXRzLT5tYXhfc3RhdGVzICsgbmV3X3N0YXRlJw0KcmVwb3J0ZWQgaGVyZSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvWTBsdFJKUmpPN0FrYXd2RUBraWxpLy4NCg0KQnV0IHRoaXMgYWN0dWFs
bHkgYnJlYWtzIGNvb2xpbmcgZGV2aWNlcyB3aGljaCBjb3VsZCBoYXZlIGR5bmFtaWMgbWF4DQpj
b29saW5nIHN0YXRlLCBsaWtlIEFDUEkgcHJvY2Vzc29yIGNvb2xpbmcgZGV2aWNlLg0KDQphY3Bp
X3Byb2Nlc3Nvcl9kcml2ZXJfaW5pdA0KCWRyaXZlcl9yZWdpc3RlcigmYWNwaV9wcm9jZXNzb3Jf
ZHJpdmVyKTsNCgkJYWNwaV9wcm9jZXNzb3Jfc3RhcnQNCgkJCWFjcGlfcHJvY2Vzc29yX3RoZXJt
YWxfaW5pdA0KCQkJCXRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXINCgkJCQkJcHJvY2Vz
c29yX2dldF9tYXhfc3RhdGUNCglhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgPSB0cnVlDQpU
aGUgZHJpdmVyIGRvZXNuJ3QgY291bnQgY3B1ZnJlcSBhcyBjb29saW5nIHN0YXRlIHVudGlsDQph
Y3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgaXMgc2V0IGxhdGVyLg0KDQpBcyBhIHJlc3VsdCwg
d2l0aG91dCB0aGUgY29tbWl0cyBhYm92ZSwNCi9zeXMvY2xhc3MvdGhlcm1hbC9jb29saW5nX2Rl
dmljZTEwL2N1cl9zdGF0ZTowDQovc3lzL2NsYXNzL3RoZXJtYWwvY29vbGluZ19kZXZpY2UxMC9t
YXhfc3RhdGU6Mw0KL3N5cy9jbGFzcy90aGVybWFsL2Nvb2xpbmdfZGV2aWNlMTAvdHlwZTpQcm9j
ZXNzb3INCmFmdGVyIHRoZSBjb21taXRzIGFib3ZlLCANCi9zeXMvY2xhc3MvdGhlcm1hbC9jb29s
aW5nX2RldmljZTEwL2N1cl9zdGF0ZTowDQovc3lzL2NsYXNzL3RoZXJtYWwvY29vbGluZ19kZXZp
Y2UxMC9tYXhfc3RhdGU6MA0KL3N5cy9jbGFzcy90aGVybWFsL2Nvb2xpbmdfZGV2aWNlMTAvdHlw
ZTpQcm9jZXNzb3INCg0KSW4gb3JkZXIgdG8gZml4IHRoaXMsIHRoZXJlIGFyZSBzb21ldGhpbmcg
d29ydGggY2xhcmlmaWNhdGlvbiBJTU8uDQoxLiBzaG91bGQgd2Ugc3VwcG9ydCBkeW5hbWljIG1h
eF9zdGF0ZSBvciBub3Q/DQogICBBQ1BJIHByb2Nlc3NvciBjb29saW5nIHN0YXRlIGlzIGEgY29t
YmluYXRpb24gb2YgcHJvY2Vzc29yIHAtc3RhdGVzDQogICBhbmQgdC1zdGF0ZXMuDQogICB0LXN0
YXRlcyBhcmUgc3RhdGljLCBidXQgcC1zdGF0ZXMgY2FuIHZhcnkgZGVwZW5kcyBvbiBwcm9jZXNz
b3IgDQogICBmcmVxdWVuY3kgZHJpdmVyIGxvYWRlZCBvciBub3QuDQogICBJJ20gbm90IHN1cmUg
aWYgdGhlcmUgaXMgYW55IG90aGVyIHVzZXIgbGlrZSB0aGlzLCBidXQgc3RpbGwgdGhpcw0KICAg
aXMgYSB2YWxpZCB1c2UgY2FzZSBvZiBkeW5hbWljIG1heF9zdGF0ZS4NCjIuIGhvdyB0byBoYW5k
bGUgZHluYW1pYyBtYXhfc3RhdGUgZm9yIGNvb2xpbmcgZGV2aWNlIHN0YXRpc3RpY3MgaW4NCiAg
IHN5c2ZzPw0KICAgSU1PLCB3aGVuIG1heF9zdGF0ZSBjaGFuZ2VzLCB0aGUgZGVmaW5pdGlvbiBv
ZiBwcmV2aW91cyBjb29saW5nDQogICBkZXZpY2UgaXMgY2hhbmdlZCBhcyB3ZWxsLCB0aHVzIHdl
IHNob3VsZCBhYmFuZG9uIHRoZSBwcmV2aW91cw0KICAgc3RhdGlzdGljcyBhbmQgcmVzdGFydCBj
b3VudGluZy4NCjMuIGFueXRoaW5nIGVsc2UgbmVlZHMgdG8gYmUgaGFuZGxlZCB3aGVuIG1heF9z
dGF0ZSBjaGFuZ2VzPw0KICAgU2F5LCBhcyB0aGUgZGVmaW5pdGlvbiBvZiBlYWNoIGNvb2xpbmcg
c3RhdGUgaXMgY2hhbmdlZCB3aGVuDQogICBtYXhfc3RhdGUgY2hhbmdlcywgc2hvdWxkIHdlIGlu
dmFsaWRhdGUgYW5kIHJlLXVwZGF0ZSB0aGUNCiAgIHRoZXJtYWwgaW5zdGFuY2VzIG9mIHRoaXMg
Y2RldiBpbiBlYWNoIHRoZXJtYWwgem9uZSBkZXZpY2U/DQo0LiBob3cgdG8gZGV0ZWN0L2hhbmRs
ZSBtYXggY29vbGluZyBzdGF0ZXMgY2hhbmdlcz8NCiAgIFNob3VsZCB3ZSBkbyB0aGlzIGFzIGJl
Zm9yZSwgd2hpY2ggaW52b2tlcyAuZ2V0X21heF9zdGF0ZSgpDQogICBldmVyeXdoZXJlIGFuZCBk
byB1cGRhdGVzIHdoZW4gbmVjZXNzYXJ5ICwgb3INCiAgIGEuIGNhY2hlIG1heF9zdGF0ZSBsaWtl
IHdlIGRvIHRvZGF5DQogICBiLiBpbnRyb2R1Y2UgYSBuZXcgQVBJIGZvciBtYXhfc3RhdGUgY2hh
bmdlDQogICBjLiBpbnZva2UgdGhlIG5ldyBBUEkgaW4gdGhlIGNvb2xpbmcgZGV2aWNlIGRyaXZl
ciBleHBsaWNpdGx5IHdoZW4NCiAgICAgIG1heF9zdGF0ZSBjaGFuZ2VzDQogICBkLiB1cGRhdGUg
Y2FjaGVkIG1heF9zdGF0ZSB2YWx1ZSwgc3RhdGlzdGljcyBzeXNmcyBhbmQNCiAgICAgIHRoZXJt
YWxfaW5zdGFuY2VzIGluIHRoZSBBUEkNCiAgIGUuIHJlbW92ZSAuZ2V0X21heF9zdGF0ZSgpIGNh
bGxiYWNrIGFzIHdlIHJlZ2lzdGVyIGFuZCB1cGRhdGUgdGhlDQogICAgICBtYXhfc3RhdGUgd2l0
aCBhIGZpeGVkIHZhbHVlIGVhY2ggdGltZS4NCg0KdGhhbmtzLA0KcnVpDQoNCg0KDQo=
