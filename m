Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB3B6BDB14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCPVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCPVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:41:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E95BDB5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679002882; x=1710538882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FEbVyzm4VqVjRiITPOPbP5GqmEfUWg7i5h+YC7iSeoE=;
  b=n4dEzqCC8KO3VPFX4IczHsCfiBm0aWZF0gB2vgqYxJNdKLjYObZIOtrM
   8ZyMcnzkJZKv9kawzc2X96srwYgx4qsje7LrIRtWJSf6nNWGmnjIH5DPv
   VUV9ulmvQwBDeYU06b5II6weANwkdeIbnLM424tLJoqfM0h1YVsdz2f+7
   TWt5Czb3dHv/nunByWhR/5qmezMFRMTezZwJnPVId2sxmrcE7hK8KMoBA
   ziSY4keFhreYws1j4DIDdz+wIU+i1UP+MTQFjblVqPvziAB1XDMPWhUqh
   /7r8GozI2U5bZ2iD6eMk2EzTWqM8ocqnOCWI03hW6MO6pZjwZEoqw/Qun
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400704209"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="400704209"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 14:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="712508252"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="712508252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2023 14:41:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 14:41:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 14:41:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 14:41:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 14:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3NoS3LKqgcq7PRR2nHtDCog9u0mEAiyoPc/AcxU32oVACAtoJW3N/PI2cqHc8HCbhIoMbl3G0kvY/OWx1HVt8/nsUe1c9E/nZAjna2Ip9mfmuxHUEDxPP+pMpNpPcxB5PGcXxrBO8Ngqeucn+OzPXwtnBbH7NhdQBw5K3BvLbpNmhFVP/uTkKwoMwPsNwj5MV+jJqOYv2IymwwnTrTBHZOkNZZ8DOjjGQJ8QSxhNJHYzltC9FBNZJUaRkWSlonybA3TVrVuyzdkUGa6SvWOlDA6SCMh8vtiHz3OBZmzkr4G7IO9dAQm9emXMdPFLp6IosIFUK81J4G0EHGKROBTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZADEOy6w6z4QOvcAvRn8dArr3LY402JGkl8JoncbvxI=;
 b=CPdg8f9PsPd7kVC6utRJjxN93Yb5RhXqEd65A1v0rP0TH6+8/d0KPnfWCUcihpCgAh+lq35pTVvFf6+nx1RF0ZOJzmMgMJXjRI+INWGKrpVKrz1GvwcoTFuawkQQku/PqOochgYeC9EB/MyuQLhjwcA8/nC09tXvRUiZzfq9DuuSmqHTUEp2/CbGVnol7TuTTlCaChnmH71hgHxfeMeAj3ujy5i3yncKVD1ikcdleVd2sI1xkP57+b7tg9M9Lp9tN9Y9a1kgja9eh+u8Y+TSq+yPD3TvUu38MyvmFUUi7zBaGoJAra61oLsjZ6bKsC3QoOo9bEMV+OfKUdmnJLrixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 21:41:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 21:41:12 +0000
Message-ID: <63f1cf0d-28d5-b648-be22-caf7bdb96fdf@intel.com>
Date:   Thu, 16 Mar 2023 14:41:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] x86/resctrl: Only show tasks' pids in current pid
 namespace
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <james.morse@arm.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20230116071246.97717-1-shawnwang@linux.alibaba.com>
 <95fca7d1-d473-e9e2-b6c8-c4ae3d44d2df@intel.com>
 <7b331383-e6b7-f94b-6af8-72d5d8d688bf@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7b331383-e6b7-f94b-6af8-72d5d8d688bf@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BL1PR11MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa24488-d0c4-488a-9f19-08db26672967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TmQrvvx0kKMiyTeESqUVGc85HaIskcRXee6YxisyE9QsC8NaToaiI5C3/H2PLa46968KfRB01K+jyttEZ8E9F0gLZht1kD9k1FYE9L6KENqrjCuojoQT6Wf1EY7MZfKYBTp5ah6K6seJmR1Oh3xGEtuWtl4YLzHyyhATnzLD4lxzPCgCoXxNLYiCwdXR1hS9qLoh10YioN0GfrhG311R72QFcuTFcyNp+IL5HIif9/091D5akqgrLhcPQEtAEsYq6/7JdWxAxPAAIiHJBE1nWcivoS/c9qzQZLgRjxqi4QMDVmaEQ820kxa9XQvRRJ7EUINbVusnfE2wrlXgzsBpf7b2wkj+hEFC9hmkSN0vNISW8bZj119wnnLLKf7W4f3EH35+WODbV91OC+W9/1NFYh6Ko0ffOLHVcwyAK9oKPyJaZMJoPs+Pg/fSNnHqM2lHAJaOZfhtrTL8ctZLrKlQIvYKa7v2UaPR4Hc64hkMlGSip2a3I/2DZ6IZn4M1CexpDAtfYCZiZcA1YCzoCzKf03IwG1+U+VHSwweUqTJQEP7OwUuJ2JJdL9prtTbjIBDWy95JWcmKBcXUYCtDTZrutnwbCw9EeS5S5tK4frlNVbW28ku1OInBp+291jIsS6Tj1VK4ScIPu0shd7eqffN+edYrq2XNW6ffp4kFaweZxgcnokgMKHL3NyVMYwfDVWSOPSeMIc9aQyDJUF18SxzE1zxl4jgp3td0kY4isbcRa/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(36756003)(316002)(6636002)(478600001)(2906002)(8676002)(6486002)(5660300002)(8936002)(66946007)(66476007)(66556008)(41300700001)(4326008)(44832011)(6512007)(53546011)(86362001)(82960400001)(31696002)(2616005)(6506007)(26005)(83380400001)(186003)(38100700002)(31686004)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNkZ0M1MlJSS2l1NUtkc1k1T2V0Z0d6MHE0WWZTbERZRFkvZnNGL2dKWTdr?=
 =?utf-8?B?c29zUHJPek9mc1pCMUZzcFQ1UTQ4TDAyT0lkMEcxRnRrZHpsdDh2dkxSTWk2?=
 =?utf-8?B?aUxwYXdyMi9hbEdLYlp5cllRNlc0UkxlWjQzZG9xbTloYTA5by80T3NpVUtu?=
 =?utf-8?B?RTMyMWRMZlUrSHJoanJXekpPVFZETktVT2UzU2ZrVnM0TmFtLzdDeDlRVEta?=
 =?utf-8?B?Tjd4dEJLSURhSnp2eWx0RGl5WVN1UmtKRnZxbENERVBlcXpIL0xYNXYxMGxt?=
 =?utf-8?B?VTBCb1B2RnM1NUpzblErMURvZTRET1Vlb3lqbWtrMEszdXVqNm1KWFRLdllm?=
 =?utf-8?B?UWk3K1pDWlNIclpqNklXVVdINjlnRlNGZWU1aUJ4TlpBOVdrZkR5cUttelpB?=
 =?utf-8?B?OVlTcC9nM09NVkNFd0llSWhiUzV3bFYyOC82S0Yyc01MNkkzdDFjSXNOTFVG?=
 =?utf-8?B?L3ZGZjRYMUJkUDZLZnpEejAxM2JDRXN5MHVYeE43TGhKT2J5VnFBWFAwdno5?=
 =?utf-8?B?ZUZrTkFVOE15K3djcDVnQndZWEZJZGFpTGdPKzlhYmt1cVpySkdVTTFZaEls?=
 =?utf-8?B?T1QwUVFtYVJPbjhCMllSTHRiSXAvZytjaGJXbUE4RjRlbkkzYTFmekdaU2RD?=
 =?utf-8?B?dTNYTDdDYzA0TjlyVWZRR1VHV0JJZW9teVN3RjFGY0s2S0JrM1F0WlJXWnVE?=
 =?utf-8?B?VmwxNlFmcW0yVXV2eStRSENCWTRYMzlvVjFCNWZ6UXozb01oZXNmcjNCZFVy?=
 =?utf-8?B?VkpsRnJxM2hPNjFrcktocGZvVERYbHJ3NzZiYTk3eU9mNVpKd2xscnpuYVVI?=
 =?utf-8?B?UFl0ZWdtUGlrU0ZRYmcyWGxPcmI4aWx2L2VWYjAzVGVPdjJ5UzczYXQvR2FP?=
 =?utf-8?B?RXdtaC84ZU1jK3NyQUdqNlpvVXhXK0pwS2g4TXZOQ2RUSmMyWHBtaGZ4Umth?=
 =?utf-8?B?bHVEZWhEQ0ZkQUlmdGVUbDNvT3dIaG9RK2lWZFJsUmM3alpZYzBTaU1JN3Bo?=
 =?utf-8?B?d1J5d1N0L1R3K2pMK2RoRFFwYStYaVFaUkNoSkxzTlg3UUZuT2U5bTF6UE5o?=
 =?utf-8?B?NGh5cWVsbUJFamJielFpUG4weEpieVlraUNrMWIrRzJhTmltbU1TS2VkdjhL?=
 =?utf-8?B?YnBvWkVCakJOZ1pDN3RISCtjckNvMk1yTWZDdkRHNVNKVUpSM211NENRaXVR?=
 =?utf-8?B?dDNRNlpkb0tOdEg3RjlsT1pGY1dkRk56c2VOcjFZbEQwQ21HOCs3cDBWaUJz?=
 =?utf-8?B?dU10c0s0YUxVV0NQZVBlR0EzYnpRQmF6eUdCOUo5MVZLajhkTDcvWjBJUFFp?=
 =?utf-8?B?RTkwZE1jU3lGVE5SY2w5REs5MEtoYkEvV21DVzIvRk1NOUY5ZTM1ek05NTFj?=
 =?utf-8?B?U3UvWEhIc0FvaWMwemJjMlZqRkxSN2swU3hzYkQyb1lla2JrbHFyakJ0QjBH?=
 =?utf-8?B?cE1QdFpxaFJoTVNsdTBEZkpmUWI0NGEwQTZCM3ZsT0JoS3dxdVZnSm5tZ2J2?=
 =?utf-8?B?SWtoUFRIZnZURG9PREZYSmkzRGRlTHRoVFRGanlqKzVTc1NXczhmMEhrWHc2?=
 =?utf-8?B?WmErbk16YU1IWmIya28rdjg3YWNkWUFmKytjOEZCbzVpMlNnNEpUTmJDNzRY?=
 =?utf-8?B?aHUyQXF1clNUcHZucHQ5Um4zcnpmVUhpT2NZWDU4ZlcrbHA5ME5uL0hSTVFQ?=
 =?utf-8?B?RWRxQmVEY2FmVzVwUnAyWEhEUkd6R3pXWGtZVHlZdzdwMENGVHZLWUthZm45?=
 =?utf-8?B?azZCMzkxK2pZUmw3c1IzbCsrdXZialZ4a2I0RkZnbWg5K2dtTzdSSmVIaVdM?=
 =?utf-8?B?d0wzT09QeDN4anJCdCswS1pjUWs3c2F3cXN2c2NCVThGTjNiT1VTU1VZQUlz?=
 =?utf-8?B?b2E2ZGFQMDVVUTBRckZhS0Z5YS9sYWl4SDZBUVNNNVNMVXNwZkFoTHBzQm9q?=
 =?utf-8?B?dUt3VXhSay9hR21QemNUelhEc1Zsd1cxY2RidzBsZGFVSmptU0RiTE5weURS?=
 =?utf-8?B?Y2dvbGdoNlBBcndEMzZRbk1oQnNwdElwb1pRT2ZIR3R0OVQ2OStDRG9aL1U3?=
 =?utf-8?B?UUN0aHJ2YnVWUzVHYWFOZWJGbEFvN01jaXE2Y0FuajRrem9yWlJJMkZBditH?=
 =?utf-8?B?Q2Qva0w1WXhBZE1kRlZOZ3pFNUpMNlp1SnNhbFAyRVE5M0F0a2Z1VHdQVVlE?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa24488-d0c4-488a-9f19-08db26672967
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:41:12.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hrPoHT5eBH1CStY+FFpWexUCZ2s8JLJFxRAedrEWeGx70NzHsf9/MZB9t/C+ctPCD3MzEYfCud82RUmzCmqEVB2cQSDYiHqtFSRY0IWmfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5384
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

Hi Shawn,

On 3/15/2023 8:06 AM, Shawn Wang wrote:
> On 2/16/23 5:43 AM, Reinette Chatre wrote:
>> On 1/15/2023 11:12 PM, Shawn Wang wrote:
>>> When writing a task id to the "tasks" file in an rdtgroup,
>>> rdtgroup_tasks_write() treats the pid as a number in the current pid
>>> namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
>>> the list of global pids from the init namespace. If current pid namespace
>>> is not the init namespace, pids in "tasks" will be confusing and incorrect.
>>>
>>> To be more robust, let the "tasks" file only show pids in the current pid
>>> namespace.
>>>
>>
>> Is it possible to elaborate more on the use case that this is aiming to
>> address? It is unexpected to me that resource management is approached from
>> within a container. My expectation is that the resource management and monitoring
>> is done from the host.
> 
> We have a scenario where we only want to mount the resctrl filesystem under a specific container.

This scenario is interesting to me. My assumption has always been that the resource
management is done from the host and not a container. Especially since a container
can only add its own tasks to resource groups.

> And We found that the pids in the tasks under resctrl are inconsistent with the pids obtained by top.

Indeed.

> 
> Besides, current rdtgroup_move_task() uses the find_task_by_vpid() to get the real pid.
> Our modification is also to maintain symmetry with the rdtgroup_move_task().

I understand, thank you for looking into this.

> 
>>> ---
>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 5993da21d822..9e97ae24c159 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -718,11 +718,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>>   static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
>>>   {
>>>       struct task_struct *p, *t;
>>> +    pid_t pid;
>>>         rcu_read_lock();
>>>       for_each_process_thread(p, t) {
>>> -        if (is_closid_match(t, r) || is_rmid_match(t, r))
>>> -            seq_printf(s, "%d\n", t->pid);
>>> +        if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>>> +            pid = task_pid_vnr(t);
>>> +            if (pid)
>>> +                seq_printf(s, "%d\n", pid);
>>> +        }
>>>       }
>>>       rcu_read_unlock();
>>>   }
>>
>> This looks like it would solve the stated problem. Does it slow down
>> reading a tasks file in a measurable way?
> 
> We didn't test it, but it is proportional to the number of pids in the group.
> In addition, only an if statement is added here, and actually the reading of
> the tasks interface will not be called frequently, so it will not be a bottleneck.

It adds more than an if statement and for a default root group task_pid_vnr() will
be called for every task on the host. I am not familiar with namespaces so my concern
was the additional task_pid_vnr() call. This does seem to be the custom though and does
what's needed to return the correct data.

I did test this and can confirm that when bind mounting /sys/fs/resctrl into the container
the container's view of /sys/fs/resctrl/tasks only shows its own tasks with the pids as seen
by it. Without this patch both the container and the host shows the same data, which are the
pids from the host namespace.

Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>

When you no longer expect any more feedback I'd recommend that you resubmit this
patch with the new tags to make it easier for the next level maintainers to notice
it and pick it up. To ensure accurate references to discussions you can add a
"Link:" to this email.

Thank you very much

Reinette

