Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B84692B02
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBJXVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBJXVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:21:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501561D37
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676071300; x=1707607300;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZZ8zunseM7NQUC2YGeUupydqE0tBL2Guo+MTE6rDpZg=;
  b=Kw+5K/fvA5ChYypKEoDvByd09gNLYQWCEC0ESeMgt/JhvSidbFrJfIep
   mKntj7+u49qSRkc+XotpeQH1i5Na/rulRj1dMbNGFT1AJJZx3PFrPngTc
   qg0z3quvtC2iR5vtFNRXitjQ+IZ9D8OAZqi3ML00MXsi0RbMccEeOjvsf
   x2ipYkmEgj9fZ+wRFkpLOiI1E1LrVls2FtZnEA6g2jEHjQrnDwYDKVmC0
   kF/U7+ISNjBSmXhkjwrUreGwA80E13amvxdlaKk8RsOuENj7t01JqSq6Q
   XGDrW2lsQeefuM0kX9mTcDlALbngwoOPFMT1HA8QwNVL2Wo3cXv8Pf1+z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330561990"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330561990"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="792129284"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="792129284"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2023 15:21:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:21:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U389COG856jn1Zbf51ULU3HZKoS/P4jZsVS5pS2QibsYVDgbnic4jAZvqNSFMc5YSCFIt04YuovMTsJzYaIOp4/TdGQ5QQUC4gEB+VBYAcKchD7sMXVIyJsoBCjdcq4ZGiuZQfTgbk6eWzNNLL0SyE5J6U65tCaSwXEIndkTB37N7B8ThiMFTrpNX4J5OCa50MXp2I20bCjqYCBr9IIrNS/5rwDGDEEq2STWn8hWAfKoNXT/q5UJAgdXXu//AtKd8nQoSkz5pvYDaaeZENHJo0rRMmxz5n77TN6shHwWURnX9OMdLqR+FiYn7+X99i9nYjcB+K4mioQIaFlFCfxkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya22i4iTTp/dZR6z04Z3VpBfxhhoi+Q0ApVsnxWfPB4=;
 b=S91hqx7Q5H1XdsU4pOUFWv+za8GnkDLOGoQRfY/izflKptn8EfAH3qWk59wN2NSEXhzJ3W2fiIBGzz0FKb0YFY/R1LXUdxvcE685b+I152Huh5GhYdMnItNhMvpCG4h6GSf9UYFVkxZIPULEosagiiLk15aj0X/NfY0XoJPKDQUO7jSyyzmYfLnaHH1lbTwUrgX/bLJad1PhmCLRZ++dkdlChCaHYVh/yoI9O69NWId9Dd/q8ZTdAY7FA1JA8yQ7T785ixQl3evD+S9AJ3vyu6fGbt4PMldmYWDUE/zKoipmyJz/xBV8Zz2nrYIIc1jxKRGf1mpgik0lhlBvNSSkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 23:21:34 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.021; Fri, 10 Feb
 2023 23:21:34 +0000
Message-ID: <b14598a8-2ab1-eda2-e1fb-a5f568e869d5@intel.com>
Date:   Fri, 10 Feb 2023 15:21:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] x86/resctrl: Implement rename op for mon groups
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tony.luck@intel.com>, <tglx@linutronix.de>,
        <x86@kernel.org>
References: <20230125101334.1069060-1-peternewman@google.com>
 <20230125101334.1069060-4-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230125101334.1069060-4-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6466a3c9-68c1-4686-005a-08db0bbd8c85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FdyiJfM8mdfQ7eC7eUdyQ+mQ810EHPSL4lS5Kz5gYVD64yUDMZJcLJy3Jf0xSW/EFXTTxm/Jas+6JGKs1n/EH6JMCNUkNH2GCBcaR9m++LUVyUVIMpzG/EO+mp/IHumR65cp5igvl7EO4ok/Yxc7CQf2ql6NRJ1fhcErTs8L0uvLFKGsi54H1BaCbUcfBTWVPNUOlJ6RorGkd+B3bcAmVP2lxoRRvQOM50sP0sxI+7qzpneQUlmHvLBkbmR1yAU3mKL6moCNIKsj08GyL1eA2qhvkX5rhzFNWdE6MW+oDiZA4RKTPLH2l9h7Drz5y4zPgUcvq97bdrWbH8MX4X4i4E0ZEYVYwKTsfzXFS3t18fofeM29V4kt+a2GvCC82NibXpIWJLNwe5E/dDuGao5q8Uno2vKGvMJK4sipU0AMRWoEyRILGWjSk0CZWiXpOdhgQIbQMzWc3zguA1h8AvZtoMYCIhoyLlLsy4LpTIr/mW32/DKihNDxqrtPFc1deq8N9pQo7nnFWbrE8TDX3n9ssWf54IsZbGpUXAYTALwEMjzwu/qw7ObWRT6arajvRE+StsmYqnGVddP0aZlhLTyf4j/NaY+l+6zs6wpqwA6z4L7r0u4Z5XVZhEJ7DdgnQqObOAFNNLBVyCPl1BxPM6BfDB8sTs7w+NHTms1bg3LRuCB5FsSnlOBi2PQ9jpHYofEnaM2mqgvp4ZdCTyfHdrx+Ia1g1HtmGXsJpwF+rQsaNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199018)(8676002)(66476007)(31686004)(66946007)(4326008)(66556008)(83380400001)(41300700001)(2616005)(38100700002)(82960400001)(86362001)(5660300002)(44832011)(6666004)(316002)(186003)(26005)(6512007)(2906002)(6506007)(8936002)(7416002)(36756003)(6486002)(31696002)(53546011)(478600001)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZRL2pUQVBTUDNHalVJNHJDeGJuZ0J4cE5wcjh6SzJXNWY0R0FWcEduVk5n?=
 =?utf-8?B?dzE2Rm12Vi81SmZwdFBKQXh3OUVnYVQ4KzJWcmZaTHIrYXI1MW1CdGV6bDhu?=
 =?utf-8?B?d0VPQjhsdE5HNkRFeGZOQ1AyTGlIRWl3NGZKQmdEMmZMMHFaMGNxaTYyMlBF?=
 =?utf-8?B?ZGlJTHAraXlJbU55OThMdzJ6Z1Ribzk3SWNMK1MyQkxpUEdYaFlkZmxtN3Nh?=
 =?utf-8?B?UW13KzZWTXBNbHhRMXFLNnhvcVdDY2haUzRzSU8vUHliL2ZFSU9GcE5yZ3hU?=
 =?utf-8?B?djkxRXVIZmxEK0ZwNEJXOEMvM29HRXYvZU9Wakl6TnNqdFhzSjMzcmxscmll?=
 =?utf-8?B?TWtLbEpzQXM3UDc5VStZNnlRRTliTlA0eHc3ZHdLN2FOVW5sTkhyY3lUaGJT?=
 =?utf-8?B?TGJ0NGV5STdNQUFMYWFrc0Rnc3F6QkhCR2lXZXpnODRlNWJ2eEMrZW8wS2pZ?=
 =?utf-8?B?NmRKaTBQZ3BzQ2tpMTNMczhnYXNmR25RemNPcVNMaHNzUVIyRHJ1NytrZ2xl?=
 =?utf-8?B?dHZNdzhQeDcrR2FSZlltdmsvQ3VkWWdidlpHVTlHRXJGNXNnYVlic0NYUVdX?=
 =?utf-8?B?b1VmUTVuTnF4VmtqdmExT0h3QjdPWVVlZ1dlTHdDajNXN0lRWmtUWitrZXJ3?=
 =?utf-8?B?dnpSdVNRMTR4Z3pxM2czdkI4bVV1cDBwYlRvbFJHU2dCWGxOMWtRRVA3YXlC?=
 =?utf-8?B?cjZid2lsbTZhc2RPUE5zeE8zeFVsQUtsOVNwbzA4emUxc2hRckxDVjhaak43?=
 =?utf-8?B?d3NXN1VjRkZySTRxb2xqL2lvWWV6UzVnWHYyci9YNmMrVlhjS3d4NzNMc1NX?=
 =?utf-8?B?SG9FSEd2S2tFVVBHODN1Mm1CVmZBTGk3OGhkSnoyalZKeDljRHBpQ2NBN1Jn?=
 =?utf-8?B?QWMrelVwUmRTaXkrUlhVL3VPYzhyZlY1TWtOZVFqbDRnQkNBckp1YXNiOGpH?=
 =?utf-8?B?bHEyQS9sNllzdjRGV3ExYmpwLzFCOXRlNDJSTHFmem50RmJzWUJMNmQzRWFt?=
 =?utf-8?B?eU1ySG5pbm1UaTI4dGh6WXFleGZNQWdFZlZrc3RRcFFZTldTb09kSmkrQ0RK?=
 =?utf-8?B?V2hLOFNvWDk4VStLeG4zVGg0ako0UFNXYWhqRFl0bEw2Sk9VT1FELzhwUXJ0?=
 =?utf-8?B?T0o1SjF1eVFzTmV4djZhMFNYamM3ZFRRTDRhcjUxWFhyRUNrNjBnZ1hrbWUv?=
 =?utf-8?B?TnU2dWd1eWpUTDBOMmJpN0YwUGJUZjYwTzVBRTVVYWJJQzhkVXVxeFlqNHZ3?=
 =?utf-8?B?bnB3M0FONmZCY0h3Zmd2NWdWYjVWN1RRWG1QQVpPY0xlVm00T1pBaTBXUzRl?=
 =?utf-8?B?RExZUnpUQzhMcE1MYlZzSkxxK3JDNlNPNEdTUnFCeDFOemRkc3pYSTdrZVF1?=
 =?utf-8?B?Rm9nS2FmZHFPMDh1MU8ydmQ4MDBOZkl0YU80aVpoUjFpZFRWU2hBNjI3R2NH?=
 =?utf-8?B?V1NhTVJocUx3bms1RDlvTEZyQjM1ck10cFY2akxaSm4wOEFwd0NQYVNobXox?=
 =?utf-8?B?OUs3V21QUm5ZbnYxeTZVSkhIYmxMNGlZTG9QYjdQZURFV1Q3S1BqbmQ0R0VF?=
 =?utf-8?B?Rk5jeDNtQnVJL3N3U1kzc0tneEVVZllJdHdKcS9LbHhtVVE1bzdEOENNQlQ0?=
 =?utf-8?B?T21qOElKZlBNcFh5cFNYY3NXa3hvK3BpWjNJaE5BNGV3TCtVUVJRUzE1ZWFz?=
 =?utf-8?B?UUVMMmk5UDRMb1VFVHRveUZBS3p3OUVSSDNqZE1RajFRdEc3SDgyWFAxdkFx?=
 =?utf-8?B?eUVKbXdMUWlDR2hmcXc1dGtTcTFHc3dRUW5EZmpjQWkrYjlGL05MNktIZmRU?=
 =?utf-8?B?d1dqM1E1d20xV3R6Vi9NWnhXMEQ5dFJ1NndMRnJCWHlaejhXY1RxM1M0UHZN?=
 =?utf-8?B?OW91WGpXZmI2c0QvSnBJQ3gybnhzcURBQm5NQWlHZ3p3ZTVuTTFMYzNuSU4v?=
 =?utf-8?B?M0ZJNHFkVjU5YnBqZlVkTXRuUm1ZdTZ6bnZ5WXNXMVdoL1VKaE5PcWtWUk15?=
 =?utf-8?B?c0FjaUpMY1R6MDBIemJNeXFoMDZGVDJJMGlnNDRuUTV0NWVtRSt4Z3JVei9k?=
 =?utf-8?B?SVgxL1cvbGU1N2YrOTRyc1dGMmxlWXlBNmtEWUZlRVhtelBOY1ptY2ZDeDBF?=
 =?utf-8?B?bDlCYzFray93ZksvdFpEalYxaFR0V1RaWXJuNHZqU0pMYmRyLzd2UHo2bWdq?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6466a3c9-68c1-4686-005a-08db0bbd8c85
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:21:33.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: De7ZAcyfkpeYVbOowy0MbK8891WUhD5ljucdlCImOrYd1JjIkpYGD3gxKJsLHb2iAzCe0YIpX/GJ0vQOEJZTv4BiFnDmF0BCAeIjv8DMcDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 1/25/2023 2:13 AM, Peter Newman wrote:
> To change the class of service for a large group of tasks, such as an
> application container, a container manager must write all of the tasks'
> IDs into the tasks file interface of the new control group.
> 
> If a container manager is tracking containers' bandwidth usage by
> placing tasks from each into their own monitoring group, it must first
> move the tasks to the default monitoring group of the new control group
> before it can move the tasks into their new monitoring groups. This is
> undesirable because it makes bandwidth usage during the move
> unattributable to the correct tasks and resets monitoring event counters
> and cache usage information for the group.
> 
> To address this, implement the rename operation for resctrlfs mon groups
> to effect a change in CLOSID for a MON group while otherwise leaving the
> monitoring group intact.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 75 ++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b2081bc1bbfd..595f83a517c6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3238,6 +3238,80 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  	return ret;
>  }
>  
> +static void mongrp_move(struct rdtgroup *rdtgrp, struct rdtgroup *new_prdtgrp,
> +			cpumask_var_t cpus)

Could you please add some function comments on what is moved and how it is accomplished?

> +{
> +	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +	struct task_struct *p, *t;
> +
> +	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> +	list_del(&rdtgrp->mon.crdtgrp_list);
> +
> +	list_add_tail(&rdtgrp->mon.crdtgrp_list,
> +		      &new_prdtgrp->mon.crdtgrp_list);
> +	rdtgrp->mon.parent = new_prdtgrp;
> +
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(p, t) {
> +		if (is_closid_match(t, prdtgrp) && is_rmid_match(t, rdtgrp))
> +			rdt_move_one_task(t, new_prdtgrp->closid, t->rmid,
> +					  cpus);
> +	}
> +	read_unlock(&tasklist_lock);

Can rdt_move_group_tasks() be used here?

> +
> +	update_closid_rmid(cpus, NULL);
> +}

I see the tasks in a monitor group handled. There is another way to create/manage
a monitor group. For example, by not writing tasks to the tasks file but instead
to write CPU ids to the CPU file. All tasks on a particular CPU will be monitored
by that group. One rule is that a MON group may only have CPUs that are owned by
the CTRL_MON group.
It is not clear to me how such a group is handled in this work. 


> +
> +static int rdtgroup_rename(struct kernfs_node *kn,
> +			   struct kernfs_node *new_parent, const char *new_name)
> +{
> +	struct rdtgroup *new_prdtgrp;
> +	struct rdtgroup *rdtgrp;
> +	cpumask_var_t tmpmask;
> +	int ret;
> +
> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	rdtgrp = kernfs_to_rdtgroup(kn);
> +	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
> +	if (!rdtgrp || !new_prdtgrp) {
> +		free_cpumask_var(tmpmask);
> +		return -EPERM;
> +	}
> +

How robust is this against user space attempting to move files? 

> +	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
> +	rdtgroup_kn_get(rdtgrp, kn);
> +	rdtgroup_kn_get(new_prdtgrp, new_parent);
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
> +		ret = -ESRCH;
> +		goto out;
> +	}
> +
> +	/* Only a mon group can be moved to a new mon_groups directory. */
> +	if (rdtgrp->type != RDTMON_GROUP ||
> +	    !is_mon_groups(new_parent, kn->name)) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +

Should in-place moves be allowed?

> +	ret = kernfs_rename(kn, new_parent, new_name);
> +	if (ret)
> +		goto out;
> +
> +	mongrp_move(rdtgrp, new_prdtgrp, tmpmask);
> +

Can tmpmask allocation/free be done in mongrp_move()?

> +out:
> +	mutex_unlock(&rdtgroup_mutex);
> +	rdtgroup_kn_put(rdtgrp, kn);
> +	rdtgroup_kn_put(new_prdtgrp, new_parent);
> +	free_cpumask_var(tmpmask);
> +	return ret;
> +}
> +
>  static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  {
>  	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> @@ -3255,6 +3329,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>  	.mkdir		= rdtgroup_mkdir,
>  	.rmdir		= rdtgroup_rmdir,
> +	.rename		= rdtgroup_rename,
>  	.show_options	= rdtgroup_show_options,
>  };
>  

Reinette
