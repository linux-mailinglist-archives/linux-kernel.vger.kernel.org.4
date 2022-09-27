Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3715ED03E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiI0WZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0WZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:25:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0A1B5243;
        Tue, 27 Sep 2022 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664317512; x=1695853512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lHIOMNWNX4g1Yb+xRSGpdPUsyjTmxQdiOhooMPylmmc=;
  b=fOI5srEnVUS5v/xp9WrZmHG2y2WlISDSjVJ5O9XPvgnXKiGBkECJinmJ
   PHxIP9XLTL+sE7Udj7jpeivcHxHwZByroB1+L2BotJUoruRdETDCUJmfu
   p+EThVVdw8+i3QsqRQi6pXcn+6C6iwhnAXdY8vOSFUaQv4aUYVcxpa6fG
   z9uDWcvYJrkNtwR1zGNEV+JJ8PQlIvekD+oov6dTXHvj+o1B048EWpQl9
   SKG90G0roc9C61gCks5kTV8SQnVKIZZigeWp05kjEnSsqjYvcXsmNZk1t
   wJJzM52rb9SpDdq3zh2aNBae7JPfzvpRvtQ5xOWYddPc10/Rb9YcUnhkb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281166557"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="281166557"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="690162330"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="690162330"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2022 15:25:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 15:25:11 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 15:25:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 15:25:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 15:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff9tK87qfo/SzGhUQZT5MHBMhalcCzBPTenQNSkU1PKxQNs1KEVJCtrchwdBAExOLkufPakildb7cEuN5m8ee8Zh66gzCmWhRGEqpNYzcPaqtN4KKplByiMzXyxGSw3wZC/BHa07dsXkctoxIamLLoWxB7MWTK1qndCDsIWWz3B0m7arhhl79jNJYe0oJszJjoWbQGzlOAiqS2Z23wI1InWCm7NSnPBI2L9CpCw0Cn5UoWGyyM/3zBlik2yCW4Bnf5gUD046Q/ZFBRC+Bl0E0QllMwBV/wpmUxr95XOfvEcYaP30UVZv8yK73BFNfAHHW9niK7LTIwemM5z/cdKdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHIOMNWNX4g1Yb+xRSGpdPUsyjTmxQdiOhooMPylmmc=;
 b=Oz2eQTxpGxb2ouWyprmPXgMrAw6O1gHYNuvRkA9YyhZhpTz8XAFmD5AeVeeNiKYkEVKlkb+W6SjZboRg554vcQ7VEMUZ//bfa30oTTI8Hv0uBXKoM3ueieIortfjfOhBZJBdr5urWsitQ+C8kGMPdiECl0JEq46EuePCV+Ct6r3iMU9ib2vnIt+ca4M+1/7nKC2+cSrZwnIPEU1ujEvypKH/7on5y+1yvyjDbeZxoJEBOQSnHM5Y147me9F0llT76M5AobQL6HSTmrHsgqWjCStcJJO9XO5l7ulndcL1ibrus7pERAdFCsjG8NSZFkhSbQgFibaHuLOY6UV9QCOrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL3PR11MB6337.namprd11.prod.outlook.com (2603:10b6:208:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 22:25:07 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 22:25:07 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH v5 06/12] x86/resctrl: Introduce data structure to support
 monitor configuration
Thread-Topic: [PATCH v5 06/12] x86/resctrl: Introduce data structure to
 support monitor configuration
Thread-Index: AQHY0q92KMXuSbTfxk6j/vBAJIZkaa3zzxBg
Date:   Tue, 27 Sep 2022 22:25:07 +0000
Message-ID: <IA1PR11MB6097ACA784844B2815AD5A529B559@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431037370.373387.14792678048042598706.stgit@bmoger-ubuntu>
In-Reply-To: <166431037370.373387.14792678048042598706.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|BL3PR11MB6337:EE_
x-ms-office365-filtering-correlation-id: e2dba138-c3cd-468a-f9a0-08daa0d7220b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qT1FRL6wAvv/2+x7ZuIP0Eiek/qBCfwaVQdndbslbT07M5aUbn70xul32osdTKvhwGN5+S8DGMHmdPftaPJCjNWF/zBfUjFYTwGoal9NRjfRAnVA1l9VNEma3DvXzY5Dxl2Ievv5MqhVQC9/dhq3fGeJxQLl28nrVFEApJ3BQ1EIRh+sOmioLEOdB/4mFDsNThvk6JlOxeG++7969Ys3sSRdYfGdaqsjasuIs/qYh5bWZdA36g/tW+6/qP39DAYnNezEGJuExRekyX5yol8i0f4eDYitWwEt5WMxBqDBtilkLhFWbHrZ7iZWUTOJaCiKXTKmf0bj0V9Ow/H7mcK61uy2PrOryyBDo5K0myDU5Ig4U/aOP1DGfk0JVn+Eey6YQfzGD1YGvdYi7owqspX4UOZ4tfTr1JY4RIFn+2d/qiYnwzcBOoeGNdJjP6guMiUgE0mlNlWGdtiE9KX8lPHldEzZKm0f9TRmy6fR+0GIYz/ZfSM7JSvD9UEthFWjmeM4T/cptmblIT4xwPl0goYgRrffFdYkU7vI2/whjMOARN6RjZSqyfnx9cBftxEm4CedIC/KHItdXxN1ya6l4wWXGUxrZiSGbB2uwNqmJvXJ/i68XSVEPcN4eFB4AtMmk30KrU518FDYt+nS7MNr0+yDr/R4gfI1fZepY/s3M7vbK1n3z1F5xXOL4fllAYX7qDAgR82jKcJUGrwGSJIKievS95WpAhRLWEon53l5f0msXm/Tzif3aWxczEWbu4NW0a/7fjvmNuyx9OcSRIbIWUf0YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(83380400001)(55016003)(76116006)(110136005)(86362001)(38100700002)(52536014)(33656002)(9686003)(82960400001)(66476007)(38070700005)(66556008)(2906002)(64756008)(66446008)(8936002)(66946007)(5660300002)(7416002)(4326008)(8676002)(6506007)(122000001)(316002)(7696005)(26005)(41300700001)(54906003)(186003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVFBc1VMR2srUUF1alBPY3FZS1dadkdGbUZiYzlhMW9zQ3VoSnFROGZ4SUxU?=
 =?utf-8?B?Q3VwdHJlUkNLeUQzTGlVdksxbkdZOEdUcGcrWGRIVlQxTHN3RFdDRXVoWnZo?=
 =?utf-8?B?L21RcDJ5SzZKaXoyS2tzY25aT2J3c3ZSU2syUit3ZERSYkE2QVF0eGNFTXMw?=
 =?utf-8?B?QnEvalRiTnd5TjZ0TC9KdmxYbldsUVJBT3hGalhUazF3U1Zhc0FjQm1ob1Q5?=
 =?utf-8?B?SGg1eTF2YldOYmpxaE1JamxSU1UrZ000cWx4YXQ2L05wNHNPN0RFMjBrcDBY?=
 =?utf-8?B?QmdHNTU3Q0h1OUkxOFBPSUlaSHFoOWZKYlZMRUJLWVdGN1FGeUxkVjgwc3Ra?=
 =?utf-8?B?VStTODZpdW95VTNtc1RUZTN1OE1rQ3R6NzNKbHk2UkFsUTBzZm9NT25haFhs?=
 =?utf-8?B?NHk4TFlhSTZQUDJQdmtONjB0NXVIYnRpUzd1N0x1MmRHVW5PcnM1OEF1VFVZ?=
 =?utf-8?B?ZHJPd0VlWFUydFlwQ08rY1BWeWN0UzhrdzJRcGtYTVFvSWpnR3krL29Ob09U?=
 =?utf-8?B?STcraWQ0dkZTVmpadnNsUUhMcG9HaVNZOThXMGRsN25MZ29mSnladUd4RzF0?=
 =?utf-8?B?ZUNUK0RVZnVlRVI4Y283QTJTS21mWXEwVUNuSHBXdFlsZUNTQzdNM0ZaZXpj?=
 =?utf-8?B?UnhRaUNjNGJVRmFKTzA1ZEZIZTNleTc1K1Y5TXNCT21MenlERWh1OUplYkl0?=
 =?utf-8?B?ekpNYmdhb2VKL0pXbENENzlmV3l2dERVcFBLVDlpbFlLRHRCNkd6WUE2ZjN3?=
 =?utf-8?B?WEpuNHlZbDNVVFV6RE5USy9GNkU3Ymp3Q0lFeWJVK1l3TElOazVFZ0t6MU5I?=
 =?utf-8?B?U2Z4VS9sUzROQk52NC9Rd1RCVnhXZmtaVE5TZi9Dc08zNlNidWJrc0J3c0tW?=
 =?utf-8?B?MXRDRGt4ZkNrajA5TUMwS3YxTlZmODl5LzdlSXJVYmpCOHBtenRUM3lKN1pp?=
 =?utf-8?B?ZzZML3JmV1ExMGhvOHF0RGxhZ1BjbmIrWmRYZFN6b3M5dkZvZW9GV1RFbDFr?=
 =?utf-8?B?c1JwSWFnMVMwY2VWSnc5WFJBTHVBSWJSSGNDbHdGanRJU2pHd3NBZ0xvaDhT?=
 =?utf-8?B?MWdvZmc4VjZZT3dXbGY3SkpOOTk5ZUdrQTZocVlNb3lvcEJqTXY0dkwxV0ZP?=
 =?utf-8?B?TVlFZjRtaERCZHJsL21LdWczQTlmMEFwVGZ0U3B4RWtneEhkUXBiSVIxNkFj?=
 =?utf-8?B?bDJBZmVjVjBCYVFqRE0zSzYwKzhoNG5wcFlZLzBxOEZDNDhQd0JETTIrM1hZ?=
 =?utf-8?B?YkVrZ09DSFdzdkVmcUN4SVFlMU1aVmxuYnFqWGZBWEUxay9oamY2UW9HVGdt?=
 =?utf-8?B?L1RzUDZtdCt5YWVzeGoxVjViVWFDcVJTeU5rRWZaK21xZWhkRjhQSXkzeU9u?=
 =?utf-8?B?dlpBVnhkRWNSYlV4VXpqeEJvQjZtcXQ1UVpGZWZIeXFURzNmNlN3Zi9LMDJa?=
 =?utf-8?B?S0lQVmlCUGY1VXhSMktSOStnZytVUDU0cTlUM010ang4WjZIL3A0eWtOY2Vv?=
 =?utf-8?B?OENPa2ltNXVHTS9NMkNKY00rR0Q3WnZxRWlGYVd4R3hURUVyU1hYbC8vWnJ5?=
 =?utf-8?B?RGlaUlhpMEN1ZWkxak9QY2pPUEpQa0NaWWJLZ1RRc0t3aW5YeHhKUmk0WXNJ?=
 =?utf-8?B?VVF1TlZacVRBWFl3Y1I0UjVkTStmTHNBU1VhdDJiZlhFdmtLbmFURS9odkZm?=
 =?utf-8?B?bGhMQXFVVUtjZEtBbE1UeEJZUW11SW5UQW0yZFRxYWdMQ0R5cXFSYkVjcjRJ?=
 =?utf-8?B?TjlpRlRYVUt5Z2pGVmRsTkp0SmZ5ZVNSQ3RKZEdLcGZaZURicXFDQU1BekFl?=
 =?utf-8?B?U3BYenNISERacUwwOVJMWERGV2l6RXNzeC9YN2ZmbVpudUpJQ1k5NHVXTita?=
 =?utf-8?B?eHZxamt4RTZUZnI2VjVsdU5lcWc2N25QdnNsR3FxVkVMTHVBVFh2WGdWWVli?=
 =?utf-8?B?TmQ4MWFKVDNQL0dvZ1haQ3lPNmoydVJYenFTaVgxaENSZDZsMlA1T3VJUTlB?=
 =?utf-8?B?dXAzd2NUTWo1Qk1tSGc4d251NW01UHp6bkh4cFBWaHVFUWFKdndIdTNsdXZG?=
 =?utf-8?B?bXJ5dkE4RXoxSDdhSXUwTTlUb0JkWWthcEdtdlZla3phdndaVXowckRIU1dD?=
 =?utf-8?Q?RB7RS31MNXyTvzIWMfZZrl9RS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dba138-c3cd-468a-f9a0-08daa0d7220b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 22:25:07.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBe/BZ58IikcguiMeAUxzRA63LiGjgVKAzoSyI8W9n6dJpQ6Ql0jyvV7IaDHze9tZHsfoIoKDTuKDAbhQqP32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gQWRkIGNvdXBsZSBvZiBmaWVsZHMgaW4gbW9uX2V2dCB0byBzdXBwb3J0
IEJhbmR3aWR0aCBNb25pdG9yaW5nIEV2ZW50DQo+IENvbmZpZ3VyYXRpbyAoQk1FQykgYW5kIGFs
c28gdXBkYXRlIHRoZSAibW9uX2ZlYXR1cmVzIi4NCg0Kcy9Db25maWd1cmF0aW8vIENvbmZpZ3Vy
YXRpb24vDQoNCj4gDQo+IFRoZSBzeXNmcyBmaWxlICJtb25fZmVhdHVyZXMiIHdpbGwgZGlzcGxh
eSB0aGUgbW9uaXRvciBjb25maWd1cmF0aW9uIGlmIHN1cHBvcnRlZC4NCj4gDQo+IEJlZm9yZSB0
aGUgY2hhbmdlLg0KPiAJJGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbW9uX2ZlYXR1
cmVzDQo+IAlsbGNfb2NjdXBhbmN5DQo+IAltYm1fdG90YWxfYnl0ZXMNCj4gCW1ibV9sb2NhbF9i
eXRlcw0KPiANCj4gQWZ0ZXIgdGhlIGNoYW5nZSBpZiBCTUVDIGlzIHN1cHBvcnRlZC4NCj4gCSRj
YXQgL3N5cy9mcy9yZXNjdHJsL2luZm8vTDNfTU9OL21vbl9mZWF0dXJlcw0KPiAJbGxjX29jY3Vw
YW5jeQ0KPiAJbWJtX3RvdGFsX2J5dGVzDQo+IAltYm1fdG90YWxfY29uZmlnDQo+IAltYm1fbG9j
YWxfYnl0ZXMNCj4gCW1ibV9sb2NhbF9jb25maWcNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJhYnUg
TW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1
L3Jlc2N0cmwvY29yZS5jICAgICB8ICAgIDMgKystDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvaW50ZXJuYWwuaCB8ICAgIDYgKysrKystDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvbW9uaXRvci5jICB8ICAgIDkgKysrKysrKystDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1
L3Jlc2N0cmwvcmR0Z3JvdXAuYyB8ICAgIDUgKysrKy0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2NvcmUuYw0KPiBpbmRleCA1NmM5NjYwNzI1OWMuLjUxM2U2YTAwZjU4ZSAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYw0KPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+IEBAIC04NDksNiArODQ5LDcgQEAgc3RhdGlj
IF9faW5pdCBib29sIGdldF9yZHRfYWxsb2NfcmVzb3VyY2VzKHZvaWQpICBzdGF0aWMNCj4gX19p
bml0IGJvb2wgZ2V0X3JkdF9tb25fcmVzb3VyY2VzKHZvaWQpICB7DQo+ICAJc3RydWN0IHJkdF9y
ZXNvdXJjZSAqciA9DQo+ICZyZHRfcmVzb3VyY2VzX2FsbFtSRFRfUkVTT1VSQ0VfTDNdLnJfcmVz
Y3RybDsNCj4gKwlib29sIG1vbl9jb25maWd1cmFibGUgPSByZHRfY3B1X2hhcyhYODZfRkVBVFVS
RV9CTUVDKTsNCj4gDQo+ICAJaWYgKHJkdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NRTV9PQ0NVUF9M
TEMpKQ0KPiAgCQlyZHRfbW9uX2ZlYXR1cmVzIHw9ICgxIDw8IFFPU19MM19PQ0NVUF9FVkVOVF9J
RCk7IEBAIC0NCj4gODYwLDcgKzg2MSw3IEBAIHN0YXRpYyBfX2luaXQgYm9vbCBnZXRfcmR0X21v
bl9yZXNvdXJjZXModm9pZCkNCj4gIAlpZiAoIXJkdF9tb25fZmVhdHVyZXMpDQo+ICAJCXJldHVy
biBmYWxzZTsNCj4gDQo+IC0JcmV0dXJuICFyZHRfZ2V0X21vbl9sM19jb25maWcocik7DQo+ICsJ
cmV0dXJuICFyZHRfZ2V0X21vbl9sM19jb25maWcociwgbW9uX2NvbmZpZ3VyYWJsZSk7DQo+ICB9
DQo+IA0KPiAgc3RhdGljIF9faW5pdCB2b2lkIF9fY2hlY2tfcXVpcmtzX2ludGVsKHZvaWQpIGRp
ZmYgLS1naXQNCj4gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwuaA0KPiBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9pbnRlcm5hbC5oDQo+IGluZGV4IGMwNDlhMjc0
MzgzYy4uNGQwM2Y0NDNiMzUzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvaW50ZXJuYWwuaA0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50
ZXJuYWwuaA0KPiBAQCAtNzIsMTEgKzcyLDE1IEBAIERFQ0xBUkVfU1RBVElDX0tFWV9GQUxTRShy
ZHRfbW9uX2VuYWJsZV9rZXkpOw0KPiAgICogc3RydWN0IG1vbl9ldnQgLSBFbnRyeSBpbiB0aGUg
ZXZlbnQgbGlzdCBvZiBhIHJlc291cmNlDQo+ICAgKiBAZXZ0aWQ6CQlldmVudCBpZA0KPiAgICog
QG5hbWU6CQluYW1lIG9mIHRoZSBldmVudA0KPiArICogQGNvbmZpZ3VyYWJsZToJdHJ1ZSBpZiB0
aGUgZXZlbnQgaXMgY29uZmlndXJhYmxlDQo+ICsgKiBAY29uZmlnX25hbWU6CXN5c2ZzIGZpbGUg
bmFtZSBvZiB0aGUgZXZlbnQgaWYgY29uZmlndXJhYmxlDQo+ICAgKiBAbGlzdDoJCWVudHJ5IGlu
ICZyZHRfcmVzb3VyY2UtPmV2dF9saXN0DQo+ICAgKi8NCj4gIHN0cnVjdCBtb25fZXZ0IHsNCj4g
IAl1MzIJCQlldnRpZDsNCj4gIAljaGFyCQkJKm5hbWU7DQo+ICsJYm9vbAkJCWNvbmZpZ3VyYWJs
ZTsNCj4gKwljaGFyCQkJKmNvbmZpZ19uYW1lOw0KDQpTZWVtcyBjb25maWdfbmFtZSBpcyBvbmx5
IHVzZWQgdG8gYmUgc2hvd24gaW4gbW9uX2ZlYXR1cmVzLiBJcyBpdCBuZWNlc3NhcnkgdG8gaGF2
ZSB0aGUgZmllbGQ/DQoNCj4gIAlzdHJ1Y3QgbGlzdF9oZWFkCWxpc3Q7DQo+ICB9Ow0KPiANCj4g
QEAgLTUyOSw3ICs1MzMsNyBAQCBpbnQgY2xvc2lkc19zdXBwb3J0ZWQodm9pZCk7ICB2b2lkIGNs
b3NpZF9mcmVlKGludCBjbG9zaWQpOw0KPiBpbnQgYWxsb2Nfcm1pZCh2b2lkKTsgIHZvaWQgZnJl
ZV9ybWlkKHUzMiBybWlkKTsgLWludA0KPiByZHRfZ2V0X21vbl9sM19jb25maWcoc3RydWN0IHJk
dF9yZXNvdXJjZSAqcik7DQo+ICtpbnQgcmR0X2dldF9tb25fbDNfY29uZmlnKHN0cnVjdCByZHRf
cmVzb3VyY2UgKnIsIGJvb2wgY29uZmlndXJhYmxlKTsNCj4gIHZvaWQgbW9uX2V2ZW50X2NvdW50
KHZvaWQgKmluZm8pOw0KPiAgaW50IHJkdGdyb3VwX21vbmRhdGFfc2hvdyhzdHJ1Y3Qgc2VxX2Zp
bGUgKm0sIHZvaWQgKmFyZyk7ICB2b2lkDQo+IHJtZGlyX21vbmRhdGFfc3ViZGlyX2FsbHJkdGdy
cChzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCBkaWZmIC0tZ2l0DQo+IGEvYXJjaC94ODYva2VybmVs
L2NwdS9yZXNjdHJsL21vbml0b3IuYw0KPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9t
b25pdG9yLmMNCj4gaW5kZXggZWFmMjVhMjM0ZmY1Li5kYzk3YWE3YTNiM2QgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4gKysrIGIvYXJjaC94
ODYva2VybmVsL2NwdS9yZXNjdHJsL21vbml0b3IuYw0KPiBAQCAtNjU2LDExICs2NTYsMTMgQEAg
c3RhdGljIHN0cnVjdCBtb25fZXZ0IGxsY19vY2N1cGFuY3lfZXZlbnQgPSB7ICBzdGF0aWMNCj4g
c3RydWN0IG1vbl9ldnQgbWJtX3RvdGFsX2V2ZW50ID0gew0KPiAgCS5uYW1lCQk9ICJtYm1fdG90
YWxfYnl0ZXMiLA0KPiAgCS5ldnRpZAkJPSBRT1NfTDNfTUJNX1RPVEFMX0VWRU5UX0lELA0KPiAr
CS5jb25maWdfbmFtZQk9ICJtYm1fdG90YWxfY29uZmlnIiwNCj4gIH07DQoNClN0cnVjdCBtb25f
ZXZ0IG1ibV90b3RhbF9jb25maWdfZXZlbnQgPSB7DQoJLm5hbWUgPSAibWJtX3RvdGFsX2NvbmZp
ZyIsDQoNCj4gDQo+ICBzdGF0aWMgc3RydWN0IG1vbl9ldnQgbWJtX2xvY2FsX2V2ZW50ID0gew0K
PiAgCS5uYW1lCQk9ICJtYm1fbG9jYWxfYnl0ZXMiLA0KPiAgCS5ldnRpZAkJPSBRT1NfTDNfTUJN
X0xPQ0FMX0VWRU5UX0lELA0KPiArCS5jb25maWdfbmFtZQk9ICJtYm1fbG9jYWxfY29uZmlnIiwN
Cj4gIH07DQo+IA0KPiAgLyoNCj4gQEAgLTY4Miw3ICs2ODQsNyBAQCBzdGF0aWMgdm9pZCBsM19t
b25fZXZ0X2luaXQoc3RydWN0IHJkdF9yZXNvdXJjZSAqcikNCj4gIAkJbGlzdF9hZGRfdGFpbCgm
bWJtX2xvY2FsX2V2ZW50Lmxpc3QsICZyLT5ldnRfbGlzdCk7ICB9DQo+IA0KPiAtaW50IHJkdF9n
ZXRfbW9uX2wzX2NvbmZpZyhzdHJ1Y3QgcmR0X3Jlc291cmNlICpyKQ0KPiAraW50IHJkdF9nZXRf
bW9uX2wzX2NvbmZpZyhzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCBib29sIGNvbmZpZ3VyYWJsZSkN
Cj4gIHsNCj4gIAl1bnNpZ25lZCBpbnQgbWJtX29mZnNldCA9DQo+IGJvb3RfY3B1X2RhdGEueDg2
X2NhY2hlX21ibV93aWR0aF9vZmZzZXQ7DQo+ICAJc3RydWN0IHJkdF9od19yZXNvdXJjZSAqaHdf
cmVzID0gcmVzY3RybF90b19hcmNoX3JlcyhyKTsgQEAgLTcxNCw2DQo+ICs3MTYsMTEgQEAgaW50
IHJkdF9nZXRfbW9uX2wzX2NvbmZpZyhzdHJ1Y3QgcmR0X3Jlc291cmNlICpyKQ0KPiAgCWlmIChy
ZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiArCWlmIChjb25maWd1cmFibGUpIHsNCj4gKwkJ
bWJtX3RvdGFsX2V2ZW50LmNvbmZpZ3VyYWJsZSA9IHRydWU7DQo+ICsJCW1ibV9sb2NhbF9ldmVu
dC5jb25maWd1cmFibGUgPSB0cnVlOw0KPiArCX0NCj4gKw0KPiAgCWwzX21vbl9ldnRfaW5pdChy
KTsNCj4gDQo+ICAJci0+bW9uX2NhcGFibGUgPSB0cnVlOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1
L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiBpbmRleCAwNGI1MTliY2E1MGQuLjgzNGE1NWQ3OGUzZiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4g
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gQEAgLTEwMDEs
OCArMTAwMSwxMSBAQCBzdGF0aWMgaW50IHJkdF9tb25fZmVhdHVyZXNfc2hvdyhzdHJ1Y3QNCj4g
a2VybmZzX29wZW5fZmlsZSAqb2YsDQo+ICAJc3RydWN0IHJkdF9yZXNvdXJjZSAqciA9IG9mLT5r
bi0+cGFyZW50LT5wcml2Ow0KPiAgCXN0cnVjdCBtb25fZXZ0ICptZXZ0Ow0KPiANCj4gLQlsaXN0
X2Zvcl9lYWNoX2VudHJ5KG1ldnQsICZyLT5ldnRfbGlzdCwgbGlzdCkNCj4gKwlsaXN0X2Zvcl9l
YWNoX2VudHJ5KG1ldnQsICZyLT5ldnRfbGlzdCwgbGlzdCkgew0KPiAgCQlzZXFfcHJpbnRmKHNl
cSwgIiVzXG4iLCBtZXZ0LT5uYW1lKTsNCj4gKwkJaWYgKG1ldnQtPmNvbmZpZ3VyYWJsZSkNCj4g
KwkJCXNlcV9wcmludGYoc2VxLCAiJXNcbiIsIG1ldnQtPmNvbmZpZ19uYW1lKTsNCg0KSWYgImNv
bmZpZ19uYW1lIiBpcyBub3QgZGVmaW5lZCwgaXQgY291bGQgYmU6DQoJCUlmIChtZXZ0LT5jb25m
aWd1cmFibGUpDQoJCQlTZXFfcHJpbnRmKHNlcSwgIiVzX2NvbmZpZ1xuIiwgbWV2dC0+bmFtZSk7
DQoNClRoYW5rcy4NCg0KLUZlbmdodWENCg==
