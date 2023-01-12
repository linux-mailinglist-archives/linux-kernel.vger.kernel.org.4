Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C64666788
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjALAQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjALAQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:16:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF09F5AE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673482568; x=1705018568;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=nPjkxA9F4lgFlYNA2tKrogH5X72f6t0upLeYiW4hyOY=;
  b=EAWG/bbRDFzCrVqLbIR6tAiBTDPL0JZzYHv2ujm81l2U8IcsmRcCdiJY
   /rtPP98OZntTsFWrPJXhIr0ZilQZggFb1K8RWaOHvIIWv40Agt1k4zDhQ
   suOoj3esFBjfQcyjdYjyRA67ULIpV0fLFDCZRrbclzSU30rIu+lc6xi/u
   FTpPT5A4xQEak9tuBQNUgzsAhuVSLGMlYVsXdRBqrBqIuiB0ZxNbW1ZwA
   Tftxtu8Lne1+c12azClbG8sdrhZORuhJqXukt7ED2yn4AJSyG+8SSsO/4
   7tLX/bTwUmdOJqezNOwWzbra4hBdWFP4cb4G+957YxM3RMYFEemzNxV9M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="388040465"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="388040465"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="650924490"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="650924490"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 11 Jan 2023 16:16:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 16:16:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 16:16:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 16:16:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 16:16:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1IUof6mcpoHDZ67u7pdSAhSWfsDX8hjfyWZQnXtq4bAwGep09kJRe6rbSbx+q1/MKPr6hGlop4+CtTqcl5evUOJ4vh3tTT+aftSqCeoDzoC1lKfyFmzRmR3Fnj3sFrdYgVFqKfejFPPEdTAhW6oFNntZDYhIS/vF29CtyOoL0kCT3jHyuucFp/SQSJ6hEtILhDCON5hAAoCXIInt2r6koMubGbh9KI1w1uf2u79L6f94QlG7nmeRhz7XXUrULB1VxYCDtMYnmRvvyNQc+Bz21rMy583b7x9momnB6qjKGGeQA86u7hOwoUQXBzsrH3OWemP9DFdtc/z4NTL5sSdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN0hnaKPM8RmNdOWK3KNMgA1wmY6Y41OCE/Vmrk5fps=;
 b=lHIy0dyym3Nb8L+Qb1KunvYcfv/zY+wsqppvT28+GdquR7JGLViL/54/XZN1R0ntixWwdgNs5TQO6CUVGgH/fDKCTEbPVL23k3pjYnM//ZZNN4gLPZXZLK+yaEnUtHWWYN2XuR7BRJv5lMmdaVLRaxouIo1vXynDQNma3Y0HiNhRUQOD+4/mdxrikVvUiVcS4wOSNvCZdqqaRNrztwj7BUbPNFeUvPbhJycH5ufar7ET+4oNATPFZ42ldidw6rwdghwyWj7xHcAWyVGX7BuTEviT/nFPLNxmFJcDOqwcQqD9OGALvdjadjCtDWIaZQC0XBQbjoUkcpe2Gb8rf+TwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 00:16:02 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 00:16:02 +0000
Message-ID: <7052b867-6f1d-f8d3-374c-009c6181b863@intel.com>
Date:   Wed, 11 Jan 2023 16:15:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] x86/cpu: Enumerate LASS CPUID and CR4 bits
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Lai, Paul C" <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-2-yian.chen@intel.com>
 <9d935618-8f84-2d6e-4f4c-9d38eec2ba67@intel.com>
 <feab0dd1-2030-e31c-cbbf-9857c46d0c1c@intel.com>
 <fcde9247-55cb-b402-987b-66f24dc76271@intel.com>
 <SJ1PR11MB6083A0E582C1A01AA6788099FCFD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <SJ1PR11MB6083A0E582C1A01AA6788099FCFD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|PH7PR11MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb2fd76-30cb-4d31-10ff-08daf4323030
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTiQ8Ev2OE3b9CbN8ZuZOC7p/Vam8cK9aoqcZrCYgJPhV1oWUmlY4gWu0w+6cTActvEeGec4VDI9ZCtMNmAt2bIZZ7Y3jcxlLGUGm4dQk4aIDC9Wf9Ml7ktXzFNPA4odUZNih1ullJ440Eli0Rb8XArL04so6R1rEMcm85I+Ihj5ZRtZMDBAbd8qjKWJAukMT2VyzwunY0rCNUeLfki638jh5jSphUSPA6diHIDN3SgzouBgWpA+3M/96/j697BcHL4g+5ZJdJc8Hky43oQLmfmO8Kos6A1kw+1dQoLEY43TkOsQAf+CwiEt3V4WEQoPlJKeoXBqdVFMfAii+4zL6eZvTBZ6HFO/b0eHL0nsu6jSbzhsUbc8NVVzWRdhiILqro1HCnZFOPyPfEwd7XeMQhOGFOUfA0UrHZSwNkNIkT1dj2S+NofC93AJV6u2u6ZyNe+F8bo1prqwOVZ6Omy6Lm4XmdeBxrBDRR8rla4hZHlNYdMEgRGeijvQyBUViuZuwiTd8wkCMezfNR71m/s6imu6gNzhNgnlc9rutyaPTE2r1PkZdZw0lXs2r1GaW2u/igOORUiknQ+3P7X8shuDS86N6Bvwm8A8a1tpNXSu7+nzp2qXkrSbLTGu8KRdr2Eitxn5FlLITYYfBUqGQm1mYkn1Rl4anPO1ZahE7Gv67y07Gu+5Y0bzEpy8/afbCzUr6uoefnLddfLCkCkVZYNGz9xD6PddmP9Wn4odRHmzh9DAWDYmUikQ5ug9E3YLcPSGSupBJUHXiq0Jlz3TNChrDfF6iCRd3dkqQNY5VgBowkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(82960400001)(38100700002)(921005)(6636002)(86362001)(83380400001)(8676002)(66946007)(31696002)(66476007)(41300700001)(66556008)(110136005)(2906002)(478600001)(5660300002)(4744005)(316002)(8936002)(6512007)(2616005)(186003)(6506007)(26005)(53546011)(6486002)(966005)(6666004)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9MSWtCK1pHL0xjb011L0dhMnIvM2JwTWQ0RmFJRldycVg4ak92YVZwREhM?=
 =?utf-8?B?OG5mZWxQY012UkVwM2RWVWs3MHBPUXdPV3BBdHFhckhMbU94aXh4eUFLZ1BC?=
 =?utf-8?B?a2hIcFFMQ3UzSDQ2MnFEblFwQjFEczI0QW1EamYvMTFPaHF4aHBXS2NPd0Jv?=
 =?utf-8?B?TGxxc0M4T0E4YlNsamFCK2ZyRHdWTW9abTFTTlRjYTFEa0V0a0xIaDdIRVVw?=
 =?utf-8?B?c3ZKeGZoQWJlNUU4VVJyWlA0RmdDM1JpQnQ3WW9iUHpIWlZHaUFnYUNxdjlX?=
 =?utf-8?B?bFVTQXQ3SDVNdFJrOXRYem5DQ3VwTUlpNlUxME13SE9TSGNScnA5N0oxcmht?=
 =?utf-8?B?ZHpBb1ZUQXZvdXRCZTNpY2lmQzQ0T3QyQzBTd09EWWN3ZWdiRitPQjFWekhZ?=
 =?utf-8?B?WG9GRkFxZk45MkVTc2J0cjhicmVmbXdaSU5OKzJVd01qR1JwOFUzNTIxYUcz?=
 =?utf-8?B?SEptZEkxTU5qb1dqSTB6a1ZJcThrSE1LdCtUVzVZeW1CMCtycVMrYzNkY2JL?=
 =?utf-8?B?SXUyaUhWc3BuOEx3eCsvWDRWMlVZMS9uUDRuM1pWaFQ0cy90RW9qU29reXZ6?=
 =?utf-8?B?NzRvWDE0Z05LQWpDa3YzMzFuenp1UkxjamFMMS94ZzE0dytUY001OXIwSERn?=
 =?utf-8?B?c0dQQVZEdkVQZXRQanJKc3ozU25nWDVpYUtRV1RudkdBR29WZjIzQVd2QXgx?=
 =?utf-8?B?NEY0Z2NVMmFiR0RKbjgzN2loZmJVMStUTVdmdXVTblE5bTBmYUZKVENzdU9m?=
 =?utf-8?B?WENKb3JVdXF3ZXJ6cFVkbEVTdDhTMkFlSzl2V2JsazNBS2pjaDNZYy9xWHdV?=
 =?utf-8?B?L2g0SC9IRTBWZlppYkFxTytnQm1nalVoRkhZNm5TN2FiQllpbGJlS0ZVOGlz?=
 =?utf-8?B?djJ5UnF3am8xVnJtbElVVXUvMFRzQzdyRFpPQk9FcTVwSllaVWJFM2NNd2po?=
 =?utf-8?B?T0I2WHJuNU5UeUF3emhwbFhGNWFoN2VlNHdnRmxOeGpwNVZGTFZLYUNCeHdM?=
 =?utf-8?B?emQ1TnQ4SktQcXRrQnFDRjFJbEI4NDl0Q2tWZGRtY09seWNJOWZaVzZxc3Ur?=
 =?utf-8?B?bnM1eUhaRGs2dStsUm52QnBFeXdEaTUxV093R0NTbG5KbXp4U1p2WS9iQ3lO?=
 =?utf-8?B?VWdNbmxWdG5LRG9OaFRxY09pVDlsTWFCelk0UU04RVllVGcyT2x3SVpEMFh6?=
 =?utf-8?B?NnlXU08xTmtVU0hYQjQyQkJNT05VU3JYVFQ4Z01nVkFOb1F4N2x6Tldkem5K?=
 =?utf-8?B?djNaLytaU0k3T05NbzlvMzkzcE5IZXdwRitZMjFGM3YyWUZPa1dmUWRUUzkx?=
 =?utf-8?B?R3J4K1lJbFE5WTBOSTh3ZzRNU1FuWWRsM1pJSDJBRFZFL3FEOVRld0RYWTNp?=
 =?utf-8?B?T24rbU1GOXM2UGU3d3FObEVYSmlaTkpBbVJOZUVnVmJMVXRzU09rclphcHVT?=
 =?utf-8?B?Y2FMbTllaE05TVdLdVpUZVVSeFVNRkdjR2ExZnFZYVpwUDNUd0xqUlhaRVYv?=
 =?utf-8?B?QUNrZy9FOFhDVTBQV0w1bVpObEdhWElCdEtxbHZSZWtkQnFTTGd3ZmgwSkxi?=
 =?utf-8?B?Tm4yVHphSVA5UWZaaUJLczlOZ1MwM1VzV3JZaVh5alVmeHNMM0RsQWtZV21I?=
 =?utf-8?B?MFlVZDN5V0dHRm5nV0UvbllQak4vbDdrMTUxbmU3Y3NaVDNEK3pHdWJxVzhj?=
 =?utf-8?B?eHNBZW56cC9ybk9MSVJVQmZUc1BCTFRhcE9XM1ZHVWFPZFJCSlFQazRHQzBQ?=
 =?utf-8?B?Rmh3RjVGTTFSS1lFNWN1c0dVb0hJUi9renovYVREbGlNREJkTkFWM2h0bWtz?=
 =?utf-8?B?YlErYU9YSVY2aGRnSEpXMFNyd01OWFVpMnpSc3IrcVV6bHhaZjZINFp0WlJK?=
 =?utf-8?B?TlgxZ1VWYndlcDRFR1FOMkptV08zMTBxYXNWcWMrOVVEOEg1V291cjVLMTha?=
 =?utf-8?B?TS9ZK21McHBCa2ppQW41NGN4NjdGVlhTVmhrdVJ3MXJrMUgyLzkyZHVaNEtM?=
 =?utf-8?B?dnByRTFXdnlDeExhOVo2TVEyQ1YyQ0VTK242ZGNGV3gxcWQ2MHBwWnNZNGRa?=
 =?utf-8?B?bHVPQzJDRG1BUkZSQlVXKzVZZ25jRmdGUjdMZXBoVVgrdm85Nm1maThYTW95?=
 =?utf-8?Q?R7Cp+NarhM7eCncTMZ1AzfR1B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb2fd76-30cb-4d31-10ff-08daf4323030
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 00:16:02.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kitETjggliX890KnkG+asXW5sg5Omb7AVHAg9RCmf2z/bAlRiWzo73aEnV7pf+NI/IMS5k3Gld5uyRJOQNgJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
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



On 1/11/2023 4:06 PM, Luck, Tony wrote:
>> The LASS details have been published in Chapter 11 in
>> https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Intel is terrible about maintaining web URLs like this. Better to
> give this reference as:
> 
>    The December 2022 edition of the Intel Architecture
>    Instruction Set Extensions and Future Features Programming
>    Reference manual.
> 
> Maybe also still give the URL in a reply like this, but avoid using
> It in a commit message that will be preserved forever.
> 
Sure, I will add the detail document name and versioning info.

> -Tony
> 

Thanks,
Yian
