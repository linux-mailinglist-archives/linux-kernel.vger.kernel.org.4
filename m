Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317E967A292
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAXTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAXTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:23:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EC474DD;
        Tue, 24 Jan 2023 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674588220; x=1706124220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o4s7CXDgTpKdP5k/FeUA8gJ4K1GvznLIa5qjCAM0yhE=;
  b=eVgZzLCIwtoIrgn3FLK6sPeO34RxauEE4g8/OxM9AEcGa9lINiZxGQ+h
   0GCNbCHTyEZNr31FJOxMUwS6rgR5DIHqUm1VEIRZVg3hVZDSOAl8PH3ka
   Q44rt/ETZNPcIk10QJjtfPXgovYokwh65QX+i7MCuE2jmC9D4NeOs3xr/
   GN/FakRxLxyKgoMGI1Op5tItEVipStNfvsIDwsSeLeEoek7prEIQNwxPl
   2ALTBpGiwTjVKFdeg51hmdVvDCu5coIavMzFj2D/VxQoUeP7QMnWYc/mm
   NeFcAQf30w+Nhk8gRFADzVxtl0vIj92k48XOEpKSM9esIDW+COad11PCm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="314286331"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="314286331"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 11:23:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="694460435"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="694460435"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2023 11:23:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 11:23:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 11:23:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 11:23:38 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 11:23:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoDAOJ8uyq0Jg5OumX29QejjqiEOgQozZ+SSfMuJnFn4RJL0alyiGzj1r3trqXmx31kJkw/4M4jkDTDHbpeU1Md8mwsinEP/n7pDG87+Tv//OPSSZepdmktom7FTzgeTYAtGxcra9GxrBz9o5qnMZD3EuWUL12nLrwX9G1m/0naAH4sj9p8aPCUnZGc5ubRSSv4z+s7ra4pvDSB6eIWljtRQdMDrEzIU/j3/iwPbzBIt5dzq3Tkm8dP9gzNxGahxhMmEVjHfCZT8XRSsKH5uZw90+hz5ZQawG2agHUCpjUGzvA5VC7gf44890FIntsRvRkevZ7UlL0rxTxZjQVHMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzWii7Rq8/NOho4o1K4vrWRLMzRd0nBq/jxaVKZDjLw=;
 b=LUCAxJB/X9+pU/IxtQ2c2RAa477rnl4pX9ap505RJ/IyqAsdRtLIeaYl42qWfe6Rf7VNeVPJN4hpWCGYKHKyFplmsy+kZwnicXIHXqRMOHfPILAEG5UV5PebNfmrXXR3RZDh2Gl0ljSr0AjYBZns20TANZo1xH6zS3u+tsTW/tEWeett1oRa6UeikH8U+0iXvUnoe1oClZuakqTBFs9igklUYxhvE8UVh8R9waY5WHnTf2FyBMfioD56bI2AR6LUxe4RXAGOMnaZn8h22BDlpj/WzT/27PYr0+BAtsnDuxqpD6I6c7UmBeDgcNVkdxcDqgNVYstWixaV6NZ7YUIb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 19:23:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 19:23:31 +0000
Message-ID: <8e9dfbe4-ae16-5813-379e-7a958c90ab92@intel.com>
Date:   Tue, 24 Jan 2023 11:23:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     <babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
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
References: <20230109164405.569714-5-babu.moger@amd.com>
 <Y7xjxUj+KnOEJssZ@zn.tnic> <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com>
 <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
 <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <Y8/CSrU8Bo298VzO@zn.tnic> <72cdefc5-1601-5c43-9ea4-4b637f5fafa5@amd.com>
 <Y8/07cV+t0PrqWX9@zn.tnic> <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
 <1e662209-93d7-2247-4212-8c78748c69bd@intel.com>
 <12f98b80-38ce-5912-fa10-33d6b8a2fa81@amd.com>
 <f6e24e38-31d4-e2f4-4dc1-13208a427a77@intel.com>
 <2cf1380e-ed98-d943-e492-ebbe9238b51c@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2cf1380e-ed98-d943-e492-ebbe9238b51c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS7PR11MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: b2067021-b23c-484d-f0ae-08dafe407a58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uu5QFYXL7z9RaKlv60wEkeMAElXgv6bvxCTah2kbqVRyY4sWwDut/gVTJ2kRJJBMMSJ8xQ45okW4x7/Nly2byWoSJXmINATUC2YtwvWoHH+13+e7sVrVoBfOHZD6BmoyB9D0ABjfgULi+cEo7wYqPhyifIW4rPfDRIKATIrv5CM3MT9PMsM0PlFmJvAwJDyUoz12vxAJKM9NxKuee0c4dVM2XgqRpuraSLAC2RIWE0CiaFbIakn0PuHqofFQykPn9jPD/y0zlef7rnNgwyV7ecgeozMOFdomKBG323mXfpzhqKdd7ij9AZb2VU17v27Lkwy+3/V5RhZ66+9403KgAPsPwQi+J2WB+e5XtOUcws4zvYH0qZz+qtthzRfiEI+1W5Muf+uQiFz1rJkHwRZel7d1J54m852nwZ6M31Ge5q9sxq+AJR8tmNqlBqOvGA+XoszBQq0OLGnBLPKwjiL1zrogY5o27PAlVdLusKzFr6F+jWz2TUKhhlQHUp/3GKimQSRq25uYekdJ5okO2+fD/TTgbZMyaPoAOsL1z8ueoZAiOBz3aHAufCckb0KTGbs619xz7SpkwK4PZisTkD5XdiUzn5Xbi0xRcE1RQEDALyk+xiJMyZzDBIvK/TTeLHIEAR4cBAYbFvFPRxqMJeJSJTtkXKthzkBbrYO1+1CA1Ecl1MZitpFb21I2Vq6VDqQY5vzffKuuid1qmYyt0AREKUIDLFeOVIhCKchWa36DmnYSbIjP0btCOp2oMjvQ+ylWsJOZ1pRlm6enAizsfekfMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199018)(36756003)(316002)(86362001)(2616005)(31686004)(66476007)(66556008)(53546011)(54906003)(186003)(26005)(6486002)(6512007)(478600001)(31696002)(6666004)(966005)(82960400001)(6506007)(38100700002)(4744005)(2906002)(41300700001)(8676002)(44832011)(6916009)(5660300002)(66946007)(8936002)(4326008)(7406005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdPTHpGVVNuTE9CenRLNWlsZi9odk0vZlhtRERwdGF3UHR3Wm5WOXNIRFdR?=
 =?utf-8?B?Z2Z0bDQ4MGd2cnF4blk5S2J0bmpGaXZ1ZDBsK2dyZTI2MERwd3hTSmJnSmZk?=
 =?utf-8?B?aWxURzhIN1FlRDBGNHdmRGpISmZndjMyNkcxSkRPejNJMS9qYkdVZm1rUkpq?=
 =?utf-8?B?eHRqVUU0MWhGdEQzTlQyZ1V5Yitkb25iTXZGdHZ6ekhRTHRwRzhlaENneHZ5?=
 =?utf-8?B?QlozTUZrdnRReGx0R3ZuWGR0ODN5QUtQZXJsM2NYWFFSS0NOK2thVWIzUjJI?=
 =?utf-8?B?R0VpeW0zdnBGbDRkclZkSnkvU3lGbU13d2d5YlI0REJoei9va3h3Z2VMeGlJ?=
 =?utf-8?B?ZFNyczYwdWtrbmR1aEVOd3FvOE43RkYyUkgyMXdBeW54aXJTalUrdC9PZnZC?=
 =?utf-8?B?UHFDc0FFQjRrWHAzMnZ3VUJUWGpBZlFJRUJ5RERGeGhEdVlUcEhjSEFMZCtI?=
 =?utf-8?B?UENCRUl1RmtEdEZzQ20yeDk5cjQ2N1QyckxSanRHT1lqaDZoMFFPZWtjMlYv?=
 =?utf-8?B?aS9HUUkzOVlKVXRSZ1E1a1hHdUdFb1hHZ3F5ZktmM3JQN09IT0IwRnhPZFJ4?=
 =?utf-8?B?VUo3WGZBZjI4ZmRGT1JrNGNidUp2SmtWVEx6WFNEQkQ4YURXMGpIdmFCOWYx?=
 =?utf-8?B?L3ZCcEM5aEovQWZmTlVqenVoN0FSaUZROFVPYTRQZ08yUEFTZnYySDVaUzFa?=
 =?utf-8?B?dkhoeUpTL2drbnpEdFNFY1hlUUxVM0lLL25oTVM1UTNmRm9xU0hOb2JHZy90?=
 =?utf-8?B?YWFaN1owMTNWMHo4eVVJK2s2UXQxSUpJL2pwd28vMFV4UWxyR2VZcmRGSUtX?=
 =?utf-8?B?V05MbVVIWGwrdFZHL28vVHltQ084VDY5L0UycHpJdkRuRmRUNSsxaFFjcFFa?=
 =?utf-8?B?cVFnRUExWkhwZFZiM0tNZVNqZ0Rvbk54OUhHbjVObCtLWXZuYmljR1RiT1dE?=
 =?utf-8?B?RFV5a0FlcEh3bWROMWlrRTdqM0RIYVM3YzJzTFpGTTlYUFk2bi91RjNBZzdj?=
 =?utf-8?B?cTRKVmF4czhxUWJJSUNhUmh5akYvWkJjRFV5OWlXQk5iWVF6OURYU1JhOGtU?=
 =?utf-8?B?MVl4RFN6TTgwbjVQTGVsWjU2VU0zV2x6Q1NWVU5HeG11ZEpySkNpbng0T21o?=
 =?utf-8?B?dGU4cldZNnAwc0lkZFljUTJFZVliWkU3bm1ZS215UHdiRm1hL1JRM3BZT0cw?=
 =?utf-8?B?RXp0Y0hMOXZUVW9Xd1ZVRHdyYjI4aDVCRi93TUtHSDFoMTgxNHhpWDlGNUdT?=
 =?utf-8?B?Y09vdVJCTHJVOWNta254MzhXMVFiTVQvZ3lpL2xETkdYZEMwaGJ3Mm5pcjNN?=
 =?utf-8?B?WFA2RC9UaUlyZFNPc1Z1RUZVMHgyR3h4bjMxWmJxelZ3ejhzZmgzakNNR243?=
 =?utf-8?B?V2Rhc3BmdlowL05Zb0orZFJiemJSeFZkWnNhS0Q1bXMvcWp3MEI5Zk5FS0FW?=
 =?utf-8?B?b2VjTUtlOW50d3MxeXN1ZFZRb3VoSmtIbTdKWERwWkh2S1lGQ1VSRHpSRXFn?=
 =?utf-8?B?OUdubFlUcytqNE5yci9xeXM5WmxMc2RZUkJRSTk1SVVtVTMzMzdIbTZtQjVj?=
 =?utf-8?B?ajh1Szl1QlB1VUhTOU9mNXoxYW9Kc05OK1dpRzNLeG42b0JTSEIyeFhnUnRs?=
 =?utf-8?B?VGYzdnBtd3hpd2RYR0I0U0xWZ1dmUGpzTWptVU1TYUhaMFVwMlNZcG1ud3Ex?=
 =?utf-8?B?TTFiM2txSy9hTlFLaVZwaE9hSmdWaGxsUTExQVZDTGpJcEI4SkdTL0p1NXhS?=
 =?utf-8?B?c2J6cmJBYjljeWJTSDJqd01oK3lqWnRpOHNWMU1hZUVXSVBYejhIL3QyNnlM?=
 =?utf-8?B?ZzJkNk5Kd3VHWjVTa0J5WkRZbmFBN1Vyc3RjbCtyc3loQldaUmN0WENrZlgy?=
 =?utf-8?B?eVBrT1pXR2FaYjlQZ3VKd2M0NFFxNXo1UDhFT3lwZXF5RU1SeXZCWkFNSzlM?=
 =?utf-8?B?R3Z3NGZWUTdidy9kTE9uakNBYXo4dmc0TTRlVVFuNVN3eUFZMXRsbmY1UGpl?=
 =?utf-8?B?UmVwdlRCdUp1UEVXV2RzMlJxck1RMVdzTzRWTmw5UzdnRmgzSFRPa3VGNzF1?=
 =?utf-8?B?M1BsZnR3SHdjbG5ZLzZCY1dkYmU1ME9CRW5UcW9ObnNKWEFPQkJ6VVEyUUpT?=
 =?utf-8?B?ZnhnWWo5WGZqUk1PTFB6RWpyd3BaU09IL0lrMzN3M0x1K1BYV3pNQ3MzY3Q2?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2067021-b23c-484d-f0ae-08dafe407a58
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 19:23:31.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFUANo8x5q300PbPS9ET+2V39WLh4hJlUR/Oo0efNpI/wBayp5JD6enrtN+1B6Jf6QFefW6lqzKZOVMCbIPTXdN9YpqzHLKHbh9hKlPDHmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/24/2023 11:03 AM, Moger, Babu wrote:
> 
> Yes. It is available.  But, the feature BMEC is not explicitly available.

I think your addition [1] to the resctrl documentation explains
well how user space can determine which parts of BMEC are available:

		If the system supports Bandwidth Monitoring Event
		Configuration (BMEC), then the bandwidth events will
		be configurable. The output will be::

			# cat /sys/fs/resctrl/info/L3_MON/mon_features
			llc_occupancy
			mbm_total_bytes
			mbm_total_bytes_config
			mbm_local_bytes
			mbm_local_bytes_config


Reinette

[1] https://lore.kernel.org/lkml/20230113152039.770054-14-babu.moger@amd.com/

