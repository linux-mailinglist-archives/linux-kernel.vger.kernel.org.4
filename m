Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E545565E121
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjADXzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjADXzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:55:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1743BE0C;
        Wed,  4 Jan 2023 15:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672876501; x=1704412501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eTamyWzow694RTX4uj8TBHE7a8T1zfIJGfwVTnQm7yE=;
  b=WaO1CMJsniaXB+sVRNr1+kCnKv25ObiL77Cz95pLZMm6C6XlRo4byFXu
   IIyee312WXxIZ3eZFaEvSGXhCLiLoAYXZ1QJFusqq0Q5FAHRSfT6BIyRF
   Tk95jMMa+BkgDn9PuJ/CZBywhuIKoMyTzSe9L8ntULio0sSP6N5ksRwvr
   Z8sqtDowRKitwiGUiVCTV+xJvPcIVEoCKM8+T8AiRCOIcE5GYfrHV2+GL
   0Iu8QtkanyqD72BR+6K7I/ynnIyoLLHi/6A+DUMgsyUGaucPY3+KCMjta
   TzGMb7jrwXcLEJAeqByaPyPFKp0PqJeTkl84xByVMLRDiLh40882SWNyy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384367532"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="384367532"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779372547"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="779372547"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 15:55:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 15:55:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 15:55:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 15:55:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 15:54:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EATO/95BweUlouOBQdkl//Fc4qbi0IPD6bM5YtDQvs7WkhmO+UFms2NVafYp109tjSSp2iN/WFWzEDJaEH31eRYEn+wURGF3shIQtjwnBx8Rq+UxeGgOPRFUCOCOCO2hcLVpy6aZvUhJZ4Kx6nzsJKSTxx29QRjacm5tl9bFACdlWXUSGUX0PrZ5ms7qT+gwqNqVobcesaNRGXJdOYrp0E3UbtQKZqJPKOOa1GHwTQxbxiCarotMoNviDMdHzfUcBAuGMf2/C7wmNZ2suaUgr+ITAqNcGQJisjlK0tZU2kS9sqxFsLX7amvNfhm3w7U0QJv8T7jRWNZN/Cj+/UbCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTamyWzow694RTX4uj8TBHE7a8T1zfIJGfwVTnQm7yE=;
 b=myXN30s6rr/hQ8Nr1dwu4JhDYFKC2xrOLQJ6/v/ht5vNCPbtPXn9TJl4atburdbpw8QunLkw8rV7zYyr6QE64EyNGwb0eCs07EwVGvV5aMkL4vqKOH8dy+atJXQDCsu+NlONNPOn9Y0SSIE2W48FbigYYQ14qB0Atw6Sqo34xTb1ivA0hRQhq36xUwCQkB+RZUrhY3oJinkTIno5G7UlTadZ9l7J4cS3qGRiwEgonONSYNX8vpyMC9I+/Wlc1bwINYZGKBfflts4hTknKQEWpRZdDUOuUy9zKVf+zGOiruQ+vXj5A9EZ1iC1Xn+oLSh/7MRz707ISwsSdddoUTp0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 23:54:57 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 23:54:57 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Thread-Topic: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Thread-Index: AQHZH7+/qLDsouKKjkeb4gWNzeXER66NxN5AgADIE4CAAFoLcA==
Date:   Wed, 4 Jan 2023 23:54:57 +0000
Message-ID: <IA1PR11MB6097E141C8C207EA527B992D9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu>
 <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <58d53ab6-df0c-9e8c-052a-a8b60c9a8258@amd.com>
In-Reply-To: <58d53ab6-df0c-9e8c-052a-a8b60c9a8258@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|DS0PR11MB7192:EE_
x-ms-office365-filtering-correlation-id: 9ade6389-ffe4-4f25-5cf0-08daeeaf1558
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KX4A6RecENgzLpSDfFWuIIYUU8BCWyGtuLO2RtV0FDPsp4CFcdvZrqkBx7SL6UL0JXuSSyN7/bCDpl1SPb0wGhqkfWFUosqjTWY/NCkHSQFGjPTu4t8C/X9UtNh5jv8QqfwDNuUG/Gej6R8F7ibTEzvECpmZv8U6TVcAyQF+bnhACZRMXQNqOZjl4GOFhZBl2r3Be10XP2ZazgG2JqMm+stR9rTd2Aq0liKLBUgxUNaY7YNXz6AABqI0edDnXOnXeDOCTHOpBhSoK1j9q/+IvrCRBdSqmmVW6ey7E0Pc4LMVKrUnuLG1UNvWQoVXtMB5k8ddYU53UiqGo87KDV5jMOJ+1ek4+s8KcL5jD3R0HYiuUzeBOZ/upZrGMaA9ZVcwU7xxumSWeE5+qqFI9F2gDVA3b6Z+kTHwKwVdwSv/Q5JBtuYmt7Iq+Po6UHuJBls9WxXfKu448QBcdyGCk77so1Yh4wT7B1AK0TO0vLHrI6LcFAlEp3Wa50p2YxQr6PRu+cQU8SEcxl0Tots99BpBsSscBr8B+7Gb6jS3A/knJNge+q3jLxlxFrqtfpi8gSRhMQrEzAkDxK+tGonMmRJd82i7zYnSr4Yi3qDpPQdKNvl1op36oXn4vEtCwMZruPcQFT8uSP7UUYchwssA3NsRktc9rz0Aj+e+5H2a/sgOM0Is7/X6cT3COZWvXdsETkLmU2J1yKMnoMhBwnnvfI+QFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(52536014)(5660300002)(76116006)(7416002)(66556008)(316002)(41300700001)(2906002)(6636002)(54906003)(4326008)(66446008)(64756008)(8676002)(66476007)(66946007)(8936002)(478600001)(6506007)(7696005)(186003)(33656002)(26005)(71200400001)(110136005)(86362001)(9686003)(83380400001)(55016003)(82960400001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVJFK29XdzhKR2FOS25uOUMvM1l5ZmxEeDZGblFvZFFSWVdHSENoSFJqTkhx?=
 =?utf-8?B?K2Q2U01zdDZEUEhqd1dDK214MkZwcDd1ZWloMnpnak83U2JTSldkUWJ4SWx3?=
 =?utf-8?B?K0NvZmhYRkdiMjVjK1VyZGlhL1JoQVhEQ3Y1dzByUHY0ZFFrbVY2Z3BiMlFt?=
 =?utf-8?B?NHpNTTh4UGkvMGcwZE1nMWVuRTRTUjRPUlIrc3cwdzNkbmpQdTdyQWtlSVd2?=
 =?utf-8?B?WllvQlh5MksvRFZaQ3RDazBMMlR1cllnZldEQXlpUnNCTlE1QjUydlFKNFdQ?=
 =?utf-8?B?bGpWZjcrbXdKZlRjb3pubUpvekg1OWhyYUFSN3NMeVZ5MC9tVlNlL1U1YXZZ?=
 =?utf-8?B?dVpXWnloWm9sdmRFcWNTWmUwVE9SYXlkcjZ0N2JIcjRNa3V3VEw0eGlJWjNs?=
 =?utf-8?B?QnNuZGdlaEVkcUYyTmpReVArQXN0M2NGYjFidVljdEJPN3pVSWYxZktpWUVo?=
 =?utf-8?B?N3RYdTB6d1lRbkoyNzNwZjJGWjJvSGxZcXFPdFFlb2VUeGE1KzdYKytuRUlG?=
 =?utf-8?B?bUJHS1l1SVhGcVBaNVU2OHArSFpTS1ZkTHdBUDROeXRpZm5WVG1MQjZpOUU4?=
 =?utf-8?B?MituRFRoZmhKbUVvaXdQUnRUOGtMNSszVldhdTNMUHpsdldyUHlWQ0JLRThH?=
 =?utf-8?B?eDBIbFprY2Via1ViaGVyeENib05ENVp5cktOdHZnUTVmSDFoZHF1eEM2VHQ0?=
 =?utf-8?B?MVp0ZC9Yc3ZNU0ZtZVVkYmhSR3NwOGFiYnBNRmJKV05EVlN3WEdKOWR2ZUI2?=
 =?utf-8?B?dzBaeE5tN1cwRXVNSXJWa2xNdk5YdDJxcktYd29uQ3VUMmRsdEdYNGhpajBm?=
 =?utf-8?B?REJqSys5a1JHbFJGOEFLUktxMnNWbVFkMmpFT0ZlY2h4c2J4Vkc5dGtwUXFU?=
 =?utf-8?B?cVBoWWVIa09wV3BJVkxtWW9ZSHZMM0dRc2tPc1AyTUZkeUo5OXJhWmZNUlVx?=
 =?utf-8?B?YnlwVXBIenEyT0JOZ01VQ3pzR04rcnloUmpJU1BndzNEYUh4T1pTRDRGNUk0?=
 =?utf-8?B?aGE0eXY0WUdPd2NLME14Z08xY1NHQlBtN2dVQWhtU2RoSm9PWWZrazVsWmlU?=
 =?utf-8?B?YkZSNldERUh5UWU3YVo0Vmd1QVJSR0tuK0Vpb1krS3MvYXNKa0pua2Nhc2cy?=
 =?utf-8?B?NFFFVXN6UEh1KzRIYjI0UFpheUdmSGNwTkJid0h4emgyd1BhOUF6V3RRUkhz?=
 =?utf-8?B?YWpyT2JBbDRIc1AvVWpveEQxUm42RFNxdjZ1Z1ZOaW1XZXZGTkJrOUYwZm01?=
 =?utf-8?B?TERmS2JMTFdOWGlEMGRtcDU1TjZIZDhicFN6b1BPYkdORElWYjZVeW0yWjR2?=
 =?utf-8?B?c1lUaXQzRkxmZFE0VnVjeVpFbGhIcWZLR2QvUVlxcW84b1NTOHhpa2VSUHRn?=
 =?utf-8?B?RTdjbFFSWkNjWWxzSUtxem8xdmljSDc5aFB4aHpoRm5oMFphMTNMUjNMcTZh?=
 =?utf-8?B?SkpscExtMm9semdFS1V2SW92ZXBtV3BpL3Uvb2Nrdy9LQnp3SStiT3lzelE5?=
 =?utf-8?B?N1NKQzZOOHB5NHNSWm5QczdxdVJ5bE15SXFqN3BOOCsxK2pOdm9QeUJiNDdn?=
 =?utf-8?B?Nnd2ZXdZNmJyUjNHQVJWVVR0V2lZbDRUTm1TbmNuSVJRb3gyMEZRT1dnb09W?=
 =?utf-8?B?Z291UVdQNndCN3NkSFZzZEI0bDJnTlArNzg1UWtLdlRnNjRic2xEZVQ4UjBH?=
 =?utf-8?B?dFlhRUlYVjZGSGlkMjBvdFZxN2lrbnl4Vk4zaUIxcysyaWhaUEQ0aWVIZUlR?=
 =?utf-8?B?NjRwZWxPRThCMHZSajBuV00rMFl6UDlZQk1DTml2MUtOWGVFSmg3S0svQm00?=
 =?utf-8?B?R3BjT2xvUzVnWEhDYzBlcUF3TVo4S01FRldUdE4xeUtZeFRyNUdtTUhYYkRW?=
 =?utf-8?B?Q0VWdnRZQ1dIOXEvb3lFTHByZUV6Q0sreC8wRjNjYVN0YmhxWW9TVkV3WGRi?=
 =?utf-8?B?QWF6NnRhV1FhbW9zSVl3ckxtNnhUUTYxcWJ2cmlSaEZ0MDlJQUNhVWduT2k0?=
 =?utf-8?B?elI1Yk83d1Z0K0xXbVNBTXNLRGVEbnIxR3A2UGMyeEttTEhmRHBmZ2dZZG5K?=
 =?utf-8?B?MGVwTW5KbXp1QUs2NFpHT1RxcGVVS0xOMk9qNENjb09QaXNucVhkNU9Na2Jz?=
 =?utf-8?Q?P60Xd7ZTy0Tqkt1Q//NO7oD4B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ade6389-ffe4-4f25-5cf0-08daeeaf1558
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 23:54:57.0990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0oC/cbSKhXg9MmJJl+aq33fkHwezomLsU50d+htVak3K6OkgNc74OTtK27RoYwyjlivk4ad4Vg5II0GIMhcoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gPj4gV2hlbiBhIHVzZXIgY3JlYXRlcyBhIGNvbnRyb2wgb3IgbW9uaXRv
ciBncm91cCwgdGhlIENMT1NJRCBvciBSTUlEDQo+ID4+IGFyZSBub3QgdmlzaWJsZSB0byB0aGUg
dXNlci4gVGhlc2UgYXJlIGFyY2hpdGVjdHVyYWxseSBkZWZpbmVkIGVudGl0aWVzLg0KPiA+PiBU
aGVyZSBpcyBubyBoYXJtIGluIGRpc3BsYXlpbmcgdGhlc2UgaW4gcmVzY3RybCBncm91cHMuIFNv
bWV0aW1lcyBpdA0KPiA+PiBjYW4gaGVscCB0byBkZWJ1ZyB0aGUgaXNzdWVzLg0KPiA+IEFsdGhv
dWdoICJubyBoYXJtIiB0byBzaG93IHRoZW0sIGl0J3Mgbm90IHVzZWZ1bCBmb3IgZ2VuZXJpYyB1
c2VyDQo+ID4gZWl0aGVyIGFuZCBtYXkgY2F1c2UgY29uZnVzaW9uIHNvbWV0aW1lcy4gQ0xPU0lE
IGFuZCBSTUlEIGFyZSBzdXBwb3NlZA0KPiA+IHRvIGJlIGludmlzaWJsZSB0byBnZW5lcmljIHVz
ZXJzLg0KPiA+DQo+ID4gTWF5YmUgaW50cm9kdWNlIGEgbmV3IHJlc2N0cmwgbW91bnQgb3B0aW9u
IGNhbGxlZCAiZGVidWciIGFuZCBzaG93IHRoZQ0KPiA+IGZpbGVzIGFuZCBtYXliZSBvdGhlciBm
dXR1cmUgZGVidWcgaW5mbyBvbmx5IGluIGRlYnVnIG1vZGU/DQo+IA0KPiBBY3R1YWxseSwgdGVz
dCB0ZWFtIGZlZWxzIHZlcnkgc3Ryb25nbHkgYWJvdXQgdGhpcy4gV2hlbmV2ZXIgdGhlcmUgaXMg
c29tZSBpc3N1ZSwNCj4gZmlyc3QgcXVlc3Rpb24gaXMgd2hhdCBpcyB0aGUgcm1pZCBvciBjbG9z
aWQgYXJlIHlvdSBydW5uaW5nIG9uPyBXZSBub3JtYWxseSBkb24ndA0KPiBoYXZlIGFuIGFuc3dl
ciBmb3IgdGhhdC4NCj4gDQo+IEluIG15IG9waW5pb24sIGFkZGluZyBkZWJ1ZyBtb2RlIGp1c3Qg
Zm9yIHRoZXNlIHR3byBmaWVsZHMgc2VlbXMgd2F5IG92ZXJraWxsLg0KDQpZZXMsIHRoZXkgYXJl
IHVzZWZ1bCBmb3IgInRlc3QgdGVhbSIgKHF1b3RlZCBmcm9tIHlvdXIgc3RhdGVtZW50KSBhbmQg
ZGV2ZWxvcGVycy4NCk5vdCBmb3IgZW5kIHVzZXJzLg0KDQpBIGRlYnVnIG1vZGUgaXMgdXNlZnVs
IG5vdCBqdXN0IGZvciB0aGVzZSB0d28gZmlsZXMuIEknbSB3b3JraW5nIG9uIGFub3RoZXIgcmVz
Y3RybA0KcHJvamVjdCB3aGVyZSBtdWNoIG1vcmUgY29tcGxleCBoYXJkd2FyZSBpbmZvIG5lZWRz
IHRvIGJlIGR1bXBlZCBmb3IgZGVidWcgcHVycG9zZQ0Kb25seS4gSXQncyBvYnZpb3VzIG5vdCB0
byBzaG93IGl0IGluIGdlbmVyaWMgdXNlLiBJdCdzIG1vcmUgb2J2aW91cyB0byBqdXN0IHNob3cg
dGhlIGluZm8gZmlsZSBpbg0KZGVidWcgbW9kZSBpbiBteSBjYXNlLg0KDQpJIHRoaW5rIHRoZXNl
IENMT1NJRCBhbmQgUk1JRCBmaWxlcyBhbmQgZnV0dXJlIGRlYnVnIGZpbGVzIGJlbG9uZyB0byBh
IG5ldyBkZWJ1ZyBtb2RlLg0KSXQgd291bGQgYmUgYmV0dGVyIHRvIGludHJvZHVjZSB0aGUgZGVi
dWcgbW9kZSBub3cgcmF0aGVyIHRoYW4gbGF0ZXIgc28gdGhhdCBpdCBjYW4gYmUgZXh0ZW5kZWQN
CmVhc2lseSBpbiB0aGUgZnV0dXJlLg0KDQpNYXliZSB3ZSBjYW4gZW5hYmxlIGRlYnVnIG1vZGUg
aW4gYSBzZXBhcmF0ZSBkZWJ1ZyBtb2RlIHBhdGNoOg0KMS4gQWRkIFJGVFlQRV9ERUJVRyBhcyBh
IG5ldyBmaWxlIHR5cGUuIEZpbGVzIHdpdGggdGhpcyBmbGFnIGFyZSBmb3IgZGVidWcgcHVycG9z
ZSBhbmQgb25seSBiZSB2aXNpYmxlIGluXA0KICAgIGRlYnVnIG1vZGUuDQoyLiBBZGQgUkZUWVBF
X0lOVklTSUJMRSBhcyBhIG5ldyBmaWxlIHR5cGUuIEZpbGVzIHdpdGggdGhpcyBmbGFnIHdpbGwg
YmUgaW52aXNpYmxlL25vdCBiZSBhZGRlZCBpbiByZXNjdHJsIGZzLg0KMy4gQWRkIG1vdW50IHBh
cmFtZXRlciAiZGVidWciIHNvIHRoYXQgY3R4LT5kZWJ1Zz10cnVlIGlmIG1vdW50IC1vIGRlYnVn
IGlzIGdpdmVuLg0KNC4gSWYgY3R4LT5kZWJ1ZyBpcyB0cnVlLCBpbiByZHRfZW5hYmxlX2N0eCgp
LCBnbyB0aHJvdWdoIFJGVFlQRV9ERUJVRyBmaWxlcyBpbiByZXNfY29tbW9uX2ZpbGVzW10gYW5k
IG1hcmsNCiAgICBmZmxhZ3Mgd2l0aCBSRlRZUEVfSU5WSVNJQkxFLg0KNS4gSW4gcmR0Z3JvdXBf
YWRkX2ZpbGUoKSwgaWYgKHJmdC0+ZmZsYWdzICYgUkZUWVBFX0lOVklTSUJMRSkgcmV0dXJuLiBT
byB0aGUgZGVidWcgZmlsZXMgd2lsbCBiZSB2aXNpYmxlIG9ubHkNCiAgICBpbiBkZWJ1ZyBtb2Rl
Lg0KDQpXaXRoIHRoZSBkZWJ1ZyBtb2RlIHBhdGNoIGluIHBsYWNlLCBpdCdzIHNpbXBsZSB0byBl
eHRlbmQgdG8gYW55IGRlYnVnIGZpbGVzOg0KSW4geW91ciBjYXNlLCB1cGRhdGUgdGhpcyBwYXRj
aCBieSBqdXN0IGFkZGluZyBSRlRZUEVfREVCVUcgaW4gZmZsYWdzLiBUaGVuIHRoZSBkZWJ1ZyBt
b2RlIHdpbGwgd29yaw0KZm9yIHRoaXMgcGF0Y2ggYXV0b21hdGljYWxseS4NCkluIG15IGNhc2Ug
b3IgYW55IGZ1dHVyZSBkZWJ1ZyBmaWxlcywgd2UganVzdCBzaW1wbHkgYWRkIFJGVFlQRV9ERUJV
RyBpbiBmZmxhZ3MgYW5kIHRoZSBkZWJ1ZyBtb2RlIHdpbGwNCndvcmsgYXV0b21hdGljYWxseS4N
Cg0KRG9lcyBpdCBtYWtlIHNlbnNlPw0KDQpUaGFua3MuDQoNCi1GZW5naHVhDQo=
