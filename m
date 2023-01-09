Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814EC663374
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjAIVur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjAIVuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:50:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505AF35907;
        Mon,  9 Jan 2023 13:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673301043; x=1704837043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9PhOxSCN2AtMoP1S9g1RSc7elRjchV93wz0Tsp5354E=;
  b=G4TCx+Q94wNck+uBNxF/2uSJwiMQ5W3IlIKeUbwCs6TmHR2I9k/eO/yj
   i+twKQQ/gTILQ7+A6NpKcBNz9PLTjyW76q+xdxoHgsmUeD8YdEN5lTReU
   spTmmUieiX3KbFqy+ByuNo/R/UST8utpzF5h7q+L8TIwQzYJ/LV1UgiHm
   AEtyTyFWh3KjGpvdfoWFkdSFHQ6K3lUOhKXJgowA/qy5viUdHOgXRs2W4
   RN9/qQFhXQzEtCW2GvEWUtqzQEJLpjrk/oWPzsIjisTzNNVb85rOJ5r7y
   oXu5dVSARHKDcNsTRC6i8PMPpDIgWuhDzCKNfveg1w6irq9bM6IZZL9fX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="320688807"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="320688807"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725312625"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="725312625"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2023 13:50:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 13:50:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 13:50:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 13:50:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 13:50:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpMmZfvhJkdoEgBsn6Tj6LmJ3gXXqMg6U5PEZZoK8gXa1LOU2eqf0qYuR9m6LyrVBSYRWApdS5SIVTrhVsTFOvE0FbmC3dtuMbJeAHpA23uiRLqx5SCJ69yk9p0oe5ba+abWNztcu80GS8izYHYqjYCzy1HwHSlE35xfxdPVywJZOxJoF+O2osq/nYQ1WK8WpFT7i2KNpZNYHYkqIgh7oXwO7vIy6V8b/Ghn72hqJCK+YNZHs3e6tgBZw/f8qY6Gfgk/NUmU6TjkiDKTX1PHEGDH8hbA0bY2IfESaRFXmu/lK1xR7vAoCKjGxEuzGLS238zUIz/9Rn89kwwNyiWTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PhOxSCN2AtMoP1S9g1RSc7elRjchV93wz0Tsp5354E=;
 b=H7y5cPvsgS2R5MS9XZYuvGuh63ihU64XKoQO7DYxU7WSFkparhM8ia9zIVtkV42QEDV60ZBJ5Oj1xK2OVjcxcEKVmMmLfvo90Qd85m87qaIG1c1rZrfQBBNEqFXmWsA2CG1+scZNL2iQmeFd0SBrE9n1UPmxMKxbZpxOhFYtTMgOLlU9vjbVj3QJA9miEfnmaMnwasSDGhB3c5TUWA5EYJX807ceShu0Qkh/DE3V8HZev7z/odtW1wkNj9evbsUq6n+RLRVSkqMV//vpIcgmCnQyKBg3EWKuMDIJOeCF5+lDH7Kz0VmqS0KU8Sb4nsM7jKHZMe+63e/LIsx+a8oVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 21:50:20 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 21:50:20 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Moger, Babu" <babu.moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Topic: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring
 Event Configuration feature flag
Thread-Index: AQHZJEmnmzyHArDZ4kO1HDjadoxLzq6WcBKAgAAOO4CAABXYAIAAAeGAgAAHOoCAAAGGIA==
Date:   Mon, 9 Jan 2023 21:50:20 +0000
Message-ID: <SJ1PR11MB60839FFE6A7769A1E15818DDFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com> <Y7xjxUj+KnOEJssZ@zn.tnic>
 <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com> <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y7yJq2lV262EPCQT@zn.tnic>
In-Reply-To: <Y7yJq2lV262EPCQT@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB6194:EE_
x-ms-office365-filtering-correlation-id: baef9931-421d-4311-9c2d-08daf28b80ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJoJpWjIZZFeY6Bkz+Y9pCQfBYIB48Js2BcvTRzhbijSF4TL1LuHYAApeGpxZ6AfiItT/2rw50ca0XFX1Dgn0kW1KrHk/HSAirg7EEEzZjNRAYfQzJIsouq9wItoiARhgQiFZssI2/EUkKMGwXpTnHX3lJro2+HjmcnvnY8a/amBwK5iqkfDV1T+WEYtAlffenB5yflR9iC0YbojXNMqpvNta5awQmOY0TSfH862EkMB0xc5AHmMMrt+wMf8PWjpzw0wqDDPPngsuW3M7caTaisLtdQb0v1lZhMpGdiQZygIEz2r3RJeI+vj36qhBTTbjBxpiFCtfAMwZtYsBA01dqR7BTWcPIDpj2i1knuyH2gz8BDdYQ+uNCZpumpERxsCUzhuoH/qPF+yNRjVZRiPksU3lXSQoLWBRmyJ5b+9j64FmaBLVmmy9gSXk0GUpx5uiWf/dyXXqXGDsWLvG+YaCWVMXn+C8WFB7Zh/+iDo05kJAPz/84y6jlEmVFE7wbwwgUpPUl2yOhGWpfDfQnecVJGI8TSDwsRaZRVA4G5imDdUIMPoSh2HF6ZiKE/hj62rp6KHfRuhsvwhV7Pa2rOoz45RqRsjXRIeqo2gnRM+9Ok+ES2OYaO9Ccf6hj83pqBpWFIKCVaYkKwjggviIRQoL+iE+3cpYXcRBYx9rtpMLDKBs7zMqF1xXFZdSXuZdikvooIHjZYVUF/JKqn+KOcLBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(2906002)(54906003)(9686003)(55016003)(66446008)(64756008)(66476007)(66556008)(7406005)(7416002)(33656002)(5660300002)(66946007)(7696005)(52536014)(122000001)(26005)(186003)(8936002)(4744005)(6506007)(478600001)(82960400001)(76116006)(38100700002)(8676002)(41300700001)(38070700005)(86362001)(4326008)(6916009)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUxXNmRVNGhkN2FZbFIxZlZ4Y1BZUFBCMmdGZHRSUUJaTUhGSE5hbEhsUHdm?=
 =?utf-8?B?amg0VkFGQmM1RlorWTdWa1M2UCtoTVNCRndPaHZOYzV6bnowVThpZU1BdkVt?=
 =?utf-8?B?U2VBSFRuKzIzOHlKVGFNN1lsQVdRRE9CM1lOenpibVExVTZHbzVYSEN0SDQ4?=
 =?utf-8?B?eFNJQzJnMlVMb3B6OU9SYm5tZXJRTWlOcHYxU081bVRZb0dtZGtRSDR0Zk81?=
 =?utf-8?B?amlUZjlZeVhvN2xOeXdwRmRZT3JhRjNzSXBLc0x0MFhpMlJhVE5tYWNqY0ph?=
 =?utf-8?B?VnpXemRmYkNvbEg3cEE1dm1EVUNrcktTYmRBVkZqR2U2R3hUY0cvaDBPeUdU?=
 =?utf-8?B?Mjg3OFhYYzBqT3MvOG8vaUZEWjNwckN3SEl2RUE2VkMvd0tDS1l4SzIrOW1r?=
 =?utf-8?B?MVBHUWU0QVdjb2ZINVk0U2cxR1NoWHgvMDBLalJHelo4N2NQY0ZIUmp6WFox?=
 =?utf-8?B?NTdkdXdIM1lLMkJ5d0NzWWkwcGpuYzhVVnpRMDVzYXpickdFUnFPU0pnQ3Nx?=
 =?utf-8?B?cFExWWRzZitDVXAwZVRQbFV6M1c4VW5lbGp3VllNTXp1Szh6SFU3V0pXb3hr?=
 =?utf-8?B?YUxUT09zb2JldVZic0RmUk9QREphRHYybE5lL2FDMVFZcCtyOHhTTldvVVpq?=
 =?utf-8?B?bUY3d1pKYTAyK2NZc3pZRmNJQnpmUDVubm1LaWNJWjUvZ3VqQnVoK01SdGVF?=
 =?utf-8?B?ekdvSEd4dy9IaDZ1WWRvVUdrVCsvRHNDYVA0SWU5Ymhhb2orN3k3aldLRlFm?=
 =?utf-8?B?MmRnSDg0WHZpSEVPcWVGR2FJNlhnTTc5OHB6Wlk3bVIxVndrQm80S3pxcFc0?=
 =?utf-8?B?QVROMmNpMmFCU1kxVEI5cTVRZ2lCeUFJL1NuakFaUk5IVzRkYWdJSEFsOVE5?=
 =?utf-8?B?Z25JbDRaRG52SE9mS2tEL2xRZGg3SUF4Y1E5SExJQXhoMHdRTGErMzkxcUlO?=
 =?utf-8?B?cndWajFPK0NyU1NpNWxMd20xb2FjMEtPZnowelNCdEJBN0pLb3VCZnVScDFR?=
 =?utf-8?B?Y1A5NE5TMXNrSzlBZ3YrS3VIQVdSZ3FWS2x4NXRlT1pxUS8rdis4SjVmc2h4?=
 =?utf-8?B?cmZiUEJJSVlNdmFvSng3ZkdIaWFROE9oYlFHc3NsSHVqR0EyYXRwbTBKNWl0?=
 =?utf-8?B?N2F3SElqc3JUdDZyQ2VacVBzMTZrQmZFYmkxQUR6SDd1UGlqUllJQ2dKaWFK?=
 =?utf-8?B?YmUyVGRueXhDb0VIbGFsSUFYakh4OTgwQ01tRGRVd0xGMGd2KzhxcjdqUjFT?=
 =?utf-8?B?dkpQU1JkME05ZGRDNUtoS1dDWnc5a0tzd2l4Yk5VWU1nditNTSt3dVFlM0RL?=
 =?utf-8?B?S2RWbkh1N1R6cE5NbDhPaVlxQlVRa0VaT05lTWdvNlBPMU5kVW5aMWRETVBG?=
 =?utf-8?B?NGsvVTZUMzJxUFlYWVozdTlYR29XcDV0QVMxcjFMMzFCa1hzTlJkYkgyRHNw?=
 =?utf-8?B?a3J6MW9QbHI5TU9hSWx5TGxvSE5nSkF5SFFuTUJQN1NJUC8waFUxRUI4SGdE?=
 =?utf-8?B?VWdtRWR5cmdYejdqMWZDYUhtWTFSYUg1MUJZOTF5SWV1TjZIY2J1VElHV2JB?=
 =?utf-8?B?NTMwblpOT2VwbDFCTFZOUnZlRkZSalloSjJWZUw4MERldisyR2pHSG5kL0ZI?=
 =?utf-8?B?MllnQ0VVcG14Qk1SUGRIMWEvaUIyckZ5WVNLTWFtYmFxdlNTcVpKM0ZHOUJ5?=
 =?utf-8?B?dGo1eEkwQzF6Q3FCbVRDMDhZMDdPQTZmT2prWHljTk5QdC9EenhvZmJyckpi?=
 =?utf-8?B?WjMrbUw0SE1jRjRTbEE3NGRLeXBvbHZpMjN1QmhEaEE4TFNKM2FIS1MxU0pr?=
 =?utf-8?B?QXYrK0F6d292dEFBTDFrZXY5dXNNODZlNmRSbjN0UGxZQTBVT1BSNU5saEJn?=
 =?utf-8?B?Z2dEOVhob0NmM1hPZVUxbHhPYzB5di92RjM0VXZEa29ZQytpaWJCbmtFdDl0?=
 =?utf-8?B?OE9UWDhHOVZEQ21GM2d5b1ZsNEkzS0xmelB0N3owVFdvT1IvQkc3WUpucGZH?=
 =?utf-8?B?L3NOSDZTcCtkR29zS2N6MTk1SzllVWoxdGI3eW5MM1F3UTZlOW90RHhmeTFK?=
 =?utf-8?B?eDdMUHBLdkRPbzdPZTFlcjZuQWtITEVHYXJNc3ZsOGt5TW9JVzd2UTczMS94?=
 =?utf-8?Q?MEr8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baef9931-421d-4311-9c2d-08daf28b80ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 21:50:20.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/AzDlLMLteIypRyze4wNKr1Ald2xxIYCKoQn+U+B9d/idDi+dA6BsnIHADhGxDEDf7d8Hs9AKVnVge9EHhZGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIHN0YXJ0ZWQgZG9jdW1lbnRpbmcgaXQ6DQo+DQo+IERvY3VtZW50YXRpb24veDg2L2Nw
dWluZm8ucnN0DQoNClRoYXQgZG9lcyBhIGdvb2Qgam9iIHRvIGV4cGxhaW4gSE9XIGV2ZXJ5dGhp
bmcgd29ya3MuIEJ1dCBkb2Vzbid0DQpyZWFsbHkgY292ZXIgd2hldGhlciBhIGZpZWxkIHNob3Vs
ZCBiZSBtYWRlIHZpc2libGUuIFRoZSBzZWN0aW9uIG9uICIiDQpqdXN0IHNheXMgdG8gdXNlIGl0
Og0KDQogICJpZiBpdCBkb2VzIG5vdCBtYWtlIHNlbnNlIGZvciB0aGUgZmVhdHVyZSB0byBiZSBl
eHBvc2VkIHRvIHVzZXJzcGFjZSINCg0KQnV0IHRoYXQgYWxsb3dzIGZvciB0aGUgZmxpbXNpZXN0
IG9mIHJlYXNvbnMgdG8gdXNlZCB0byBqdXN0aWZ5IG1ha2luZyBhDQpmbGFnIHZpc2libGUuDQoN
Ci1Ub255DQo=
