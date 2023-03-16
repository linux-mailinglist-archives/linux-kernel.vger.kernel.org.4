Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89226BDABE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCPVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCPVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:18:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17B1984;
        Thu, 16 Mar 2023 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679001523; x=1710537523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OGMntYrXC3KEXG+K7VKaEU1YVr2ND4ZRd8nKWUrUHjQ=;
  b=UUw1nq8cpPCDBdw6Ou8J+4yOaYAjertUZtQxZQ7rC2QXuN64cMOPEFeR
   K56kpP9uSPfpuV1NLFfuYXia02gOa+9v9FzUGeuVKqJUpAx+8PRuI2VhI
   I/Xx9fu4TezI9s681rrNHvq3w5f9AlN3TEIseTjVriQK2KGGcW01NbR6D
   EnhJQ1X5juOGYIayIc4dYsDXxwT2JckTjquY7dIr7iPZs7SIClRwCqfbu
   eiC7JMEzPxqlA1677f+gJtVkdcHAFlAiGUPSx2nwbSAVH/cQJdrN2kQWm
   u59CffF6PLHzsXmnwgfWPq3/Dmt5AoKvQTjmSxfaltiBoEE+bczLwfWa7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="318510434"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="318510434"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 14:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="854205092"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="854205092"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2023 14:18:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 14:18:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 14:18:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 14:18:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 14:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGdAQXUihD+WsyN+cSP+EYAg/Z/25K1lpTjTe+8cFvJrP+KEJt44o/WVFWL8gudvqK7eYFHYDl481MYJMt8NPFIVv/gejGMZYfia3zT/WSSLJ9kdyVu9rLNkjSuEuVQRpU0p7mXzbdjKRK0xMkxlFqDkVJvAE2JW2gcgakjTYAiQT1FSzAFcx2/SpYY3L12/L17bAiFF8/bn0e/toau6vbhmSW1mla5Rj0Edv4xG3cG/Hsdg8P6n13uiFypkEHPtHy74Vk1t2digeiuo6k5RkzqexvzBlZ+HrWV+gOoIgPghyEEbg/X8gSo02l2e//olWVKj44xQF7R8718KD8FnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3K17eDVZ3qGYtp6H0Lkz+yExRyE7etir6iovWY5wgw=;
 b=hNcrWX84nNCR6qP1mBkt9MiqNz0dRY4w+j3WpZcQhndRS95pTc+Ez7ir+2H08FzW/wZeXyUbTUbJkdDA76lt9qm5ZvbZZ0Vzrke3GGrZruhowiQ0U6z6BJbYHglVkg8jRArqDzmqz4sGm/Z8XrkajEVWBGeEn/LScCWd5Y2R3Gyxp/iOsX20HdTmvOMo9nENGnBXWq1satavGGWQPdBtHIq+ENue8OzDIKSv+3KA6D8lLbSzwRO7b438Uzs6BAff+3zaV/TK4j8dUhO3FbrHu0Blqwkj+sw4I/cIYcMesa1jso2+nZYTeE3fvdfwV55+X8jNwXfLQJZqIJSxel3KNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7831.namprd11.prod.outlook.com (2603:10b6:8:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 21:17:53 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 21:17:53 +0000
Message-ID: <b2587ef0-38da-6714-f26c-5b8a16fba340@intel.com>
Date:   Thu, 16 Mar 2023 14:17:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/7] x86/resctrl: Remove few unnecessary rftype flags
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778867236.1053859.12920879751317268318.stgit@bmoger-ubuntu>
 <1a45fc82-9339-d086-2e70-27fd91906b8a@intel.com>
 <edcb0810-df39-669b-ebf2-5988a71525e9@amd.com>
 <4af7feb7-7663-7bab-33a4-7ffce092f55d@intel.com>
 <c07dfb04-4502-47d8-ad89-9f9c7898f246@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c07dfb04-4502-47d8-ad89-9f9c7898f246@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: ad313c0b-7aac-410c-81f9-08db2663e739
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Twu7yGbrsV5KJ4rrhevGBN3opruK4be4obd4sj4QK9B5OqMFXHFQyDP+db5N0rL8b3lYDI3rThF99iyrX0kJy4BXvHbKtOG46m/ftXbJOqYlLWMm9ByVvGXwT8gfnYhXVgbIj8F8oUNyHsRt2QHygomJ2rsySSvt9SjYuU5sJcJq8wZBdvz7ES+9WV345vb2SJDBLs0ptci3XhbeI9CesWKEDmxwj4QjOeE1ED602NYljeVXriemjCQWSHHYzWpc6/rWly1oWVUg+3oxUHR5jAmMM6IES3T/JqDGkybPzed2zywqUODjDykpLu4WUD38dUesz5ku3K1jjHBYdGFcp/KETc8gz3JzceveeOZP2xb9jKxziu3LRUWmTOgLtMdl1prZIs9bi/+wJADouo0LhMwzPfup6asoQiJV69oFoEnJu+2f/dppk7lfaTiOMIL1z1RBa7yrvudcY98xSoTtkS5Z1GYKun2UnPN0e50fBBdeCUmCLAvQTL7zEajd6AK5jVR6lwnKhXVBBpMBx1JtJm0dNMaE+gDvcnEHnrIYsH7gP64QrEd0MIXQPwHeYHnHp8L2QnjxAAKnIReFhITA/v2z+T5NRNMXwiDR7CWOixU9+0KPS2z/N0lmjmffXRzW10iQ/rXqUQ43em+4sylvcXwAprN89swx5+8hpv+by/ohoptcsxqTwDS27wY0yRYz1FlecOabtx4ik2YhvU7Y9Lj8SQzUjLhAL7hgFB0iCvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199018)(31696002)(36756003)(86362001)(82960400001)(38100700002)(41300700001)(44832011)(2906002)(8936002)(7416002)(5660300002)(7406005)(4326008)(6506007)(66476007)(53546011)(186003)(2616005)(26005)(316002)(6512007)(66556008)(6666004)(6486002)(66946007)(478600001)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dng4QU02UGowVDdSN05kVjFJZlBMY09GMnl1Q3gxTDErVlpibFdENE1GaXBC?=
 =?utf-8?B?UzMyOTlkQVZLWDVRQ24yblNBV2ErV0RuQnVmK3FJUFRqK1B0bVBTMThlYklH?=
 =?utf-8?B?WnBxMW5VVzJ5dDlTSWE2TGk3R1lDZUFYbktTc09qOFZsRW5Vc2V2YXltV1hL?=
 =?utf-8?B?Z2Jma2dtWlRicFdJNDBQajVLWVZKbjBZSUdtZy95VG1oRDMyMEVLbHN3M0Z0?=
 =?utf-8?B?OEx1TzF5REhXYmN6VHFiRGRXbGJwMEFRd3FZRFlzS3dmdzhnNjNNa0huZU1j?=
 =?utf-8?B?SUt6SFdnUmxDaXJIdHo5ZDhvYnVRTTd2bm5BV3dYTFAyQnp1YXZuSUoxVDlL?=
 =?utf-8?B?VDU1UnZTRzE5MkNSTXBTK3ZTZUw4NGwxUUF2cytEK01GL1NPMlJsZjlkdDNz?=
 =?utf-8?B?d0hmNzgzYTlSTCtvNXQ3TnIzZWZkWXRQc0E5RHVPbFZtcDZaZFE0eVRMaXkz?=
 =?utf-8?B?R3NKR3dxMXhUUzdQb0NSRXp1dEtmMEpBd1diSEl6bkVwOWQvZ0UzcVVjMDZm?=
 =?utf-8?B?ZnZTQURjeTR0c3JCZ1ZlQ0RlNklIUWxzT2VrR1RGbWluVGtXYzAwSXh6SUZj?=
 =?utf-8?B?emxJM1ZDUzA5UDRObzdxWFo1YUkwWW5lNkRWcGhsUzNPa04vYTQxcXJueHM1?=
 =?utf-8?B?OWl1SWgwWTBBajVPQWRIdDRrT21oS2g1UEE1bnA1YytTVGdjZEtkbFUzaStO?=
 =?utf-8?B?UTkyaENyMWZvcThNbE5EcmxyYjZwRWJ2QkIxbDRoUmx2cjZFMS9HYlpISGM0?=
 =?utf-8?B?SVJ6b1cyRURuOFNUSWI1V0ZhR0lJL0dicGFyR3hKQVRzS245TVVyUHhScTVH?=
 =?utf-8?B?UWpkYlBINCswQWVXMCtPYVhuNFQrWThxTlBIUUFhVE4wYXhRcWZ3NnhBdTFj?=
 =?utf-8?B?VU5GMkNFZTdWODEzWmptN0JoNzZzUEc1eEp2WStnOG9QWkJINkVra2hMY0tw?=
 =?utf-8?B?YnhCZzAwRFREVVRlUUNJU1c2bUZ4cUlMa1NRZEliZWdtQmc2RklMYTRieHdv?=
 =?utf-8?B?NTdLVSs1bmQ5bzNRTTBsYlJGV0svcnhWNXUzbk9WQmxudnlCaERMRWcrQWRi?=
 =?utf-8?B?QnNoa0w1ZVpVc0tpVDhSSVJMMmhsUXVTR3lsV0NYa3RUKzZEa0FpcHByMjJp?=
 =?utf-8?B?SnhtYnVrdzV3TXBFRjJzZEI4K0pOYU9DQTg5cytoZU1tNXRWYk9uUEJYWStI?=
 =?utf-8?B?TytHWjJSaUpFVDNpOGlCUEwzS2FhVURDaFhUY2t0VU45MUVkdDd1OGJRaVV5?=
 =?utf-8?B?cEZubWRFRmdVQjFZbklCQk40UVdtdENLcTk1YW0yZW1jWFU2VWhyRmVYYjJx?=
 =?utf-8?B?aHA2MU43c3VET3pHelpmZVNpOFVtckRZUnZ1SXQ2S2QyeGhBMnh6dnlTWVBQ?=
 =?utf-8?B?THpucFhqenc2TUhOOW9yMGl2dS9QS3F6ZzJLcUg2VWpPRUVrVzV5M0I4L2Vp?=
 =?utf-8?B?Qkpsa3ZqRVBGT1plMEdxaE1kUXhQMlJIQWNjVDk5MjduZFp0eEl5bHFGY09U?=
 =?utf-8?B?b2FpVFIwZWJtOS9KMm9oZ0cwRnhHUnBEdXNLaE4rZ2NsaU1JNVhPQzM3blFG?=
 =?utf-8?B?dWtDYkg4b1Nudm5MVGRTWWFvZnVvNFRpUDVrbHM5RmVhZzVFVTFiMmIwSzFj?=
 =?utf-8?B?VzBGSUJzRUJiV2phNjB0b3loa2g1UEpJeE91b2ZSSWlnSmhwWkJUUzcwYStk?=
 =?utf-8?B?KzRUdE1QTy9GOTZBQVlkVlcrSk56UHdHa0tNWDYxSStxakpvdm5IZHJNTGlw?=
 =?utf-8?B?aHJlRWI0eXRuVWZ0bTBuNDh2dzRwS2JSYjdSL3ZLcytSdmJlazJnZXZDaGRr?=
 =?utf-8?B?d01XK0o4UWZZSzQ4cjdPcHhySFlOMVpIbW1mT2tjdm5hL1VIUm9pWmo4OUV2?=
 =?utf-8?B?K2M0VTNtc0RxUmNqZlVTV0JWY3BpeDNuQVk2RHRIVmVvL3FzZXRvOUphakJh?=
 =?utf-8?B?MFhqN0xLdG8vSmdxZVlxOUpiNTNORE1tRkdtY1hRcEdJYnRpd2pnNlBKVEZt?=
 =?utf-8?B?VUhhRkIrQjRLYXorQmJwVnpra21WOWVNMzQ5bllhbUgwRytQblVMWlJpR0Qx?=
 =?utf-8?B?WGZGOHFZM0JVVUIvWnowSzJlUG1WWUtjNWdURXRqa2FMZmRtcUpFSjBiZjZC?=
 =?utf-8?B?UW00TmlPVjVndzRWVEw2N3FXczFoYkRrVXJYcUV4dllZemRuWVhTTDJXSFBj?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad313c0b-7aac-410c-81f9-08db2663e739
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:17:52.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWqYejAjgR+VUOL6Ja8jvDaYkUgqaoAeQGc02KgB/x14bsMTndzLl2vSym4ThP/N5zeLBOCO9lOU3k8jptB6PLNVua2AZJgbceD0zWqJ8a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7831
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/16/2023 2:11 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 3/16/23 15:41, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/16/2023 1:31 PM, Moger, Babu wrote:
>>> On 3/15/23 13:33, Reinette Chatre wrote:
>>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 15ea5b550fe9..3c86506e54c1 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -3163,7 +3163,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>>>>>  {
>>>>>  	struct rdtgroup *prdtgrp, *rdtgrp;
>>>>>  	struct kernfs_node *kn;
>>>>> -	uint files = 0;
>>>>> +	uint fflags = 0;
>>>>
>>>> Hoe does changing the variable name from "files" to "fflags" simplify
>>>> the code?
>>>
>>> I should have said readability of the code. Its actually fflags we are
>>> passing to rdtgroup_add_files. While changing flags below, I changed the
>>> variable name to fflags.
>>
>> You are correct in that it is the actual fflags parameter but what it
>> reflects is which files will be created. I do not find that using "files"
>> makes the code unreadable. 
> 
> Everything helps. I changed it because I was already changing few things
> in this function. That is not the only change in this function. Here is
> the main change in this function.

I did read the patch Babu. I trimmed my response to focus on what
I was responding to. Our opinions differ on readability of the current
variable name. This patch can focus on just removing the unnecessary rftype
flags.

Reinette
