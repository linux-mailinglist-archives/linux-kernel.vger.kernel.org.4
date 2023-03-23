Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBFE6C6FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCWR7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCWR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:59:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27F40FD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679594342; x=1711130342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1V2KINPGhMDbvvFhxw+D1In5GA/OPvE0LcG51mNhw7Y=;
  b=fM2b+XAC7fbigUx33FhgSXUJm1EciuRJOxKqQPoT5xncax9oTFRsu8gz
   3/Ow1tmwkJZhgqfQLDrYlJE2IeXJ2GL63cb4cqRDrRHcYFNIwWjfHQFHa
   VrFW8v/i3G0X93H2zR5ggYNnSCtRGu6lR7kib9voNzDiXz+CFhkd2Uo4K
   mdKx4/TFNiPbtHfgHzJjsmn62Ni4JNWgiHiXTRHUXiYagtQXYwDv5A/ld
   nj9IIDk6OPxRFypRMUAe2Pd4/8Sd8UCbM1GmcFUEjlmTkBtWn3EiyT6Y7
   Z8BexFCVHjVNDtMMVh3azwJNAaxRJtepg1yoP6YNrCS40Fm5n6ExlYezQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341131639"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341131639"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 10:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="825924397"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="825924397"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2023 10:58:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 10:58:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 10:58:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 10:58:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 10:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfNkHm6XxDZpVRtvqDuO4iWkDUrX+ge3qSs1Gz8+VlkACM0PVBKiqf7nstcCMBzVxUv06tGNLAQqeCH2GPagld2IaXxIYEhUKSZGpdQWOFlfNfjeK85bqizkeKxpcfE0viNd9j1e3ezHGjSxhzD9TqMXgP11oY5M2HaL9muThKjzyTiKtizeMxW1ebi7c9605Y5+WpRIPONyvtzvcTOlhtGEqdbJg9Kdi9aizg8BgCGRxoyV+UnUVHKVUa77ipEqmhinX4EaNAIO1crNKnaZhQmnZmmXA3jPVtj+KttW3XPK3Ml5sz9FeAh0i4Q9l7pTo5xqdKj12ywwkLQA5iiI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vuRV+I6vLENdbh+bnDp+tJNfds1aGgNOIOausKcZtw=;
 b=Y4HbbLEhDRjwI1+zyKfKE5drLbiczd1hgP+EkxaouAuP2gj3+h8Msm0W+OG3aG6YJ47iKU5pRJ/BvEaBR5YkBVoqZh6FCru2292JkbzHhmCWP4gKTSDVUO6eae6Jx/ViwLK7CenWfDWnKmkY1pxP+/WVkNRyD0xcsjSvrBI9p4FVsTWaH3Bna+tPB59UGHlZCQBeE4yIPMcd/2OUUsiavy1/JzoxivYdccOjpxsUBZvRh3IEmejvEOsjGuHHaoOvIL11Bdbj+Ho4t90DQ9jdKp+H2n4cMN+f6RTRETmiKnZeG0wuUtn8MLjB0bIAJDvye1WJFyVWgS6krLcoMMm8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA1PR11MB6965.namprd11.prod.outlook.com (2603:10b6:806:2bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 17:58:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.038; Thu, 23 Mar
 2023 17:58:18 +0000
Message-ID: <ce57dcbb-5464-3340-34d0-af1e3f191b85@intel.com>
Date:   Thu, 23 Mar 2023 10:58:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/3] x86/resctrl: Factor rdtgroup lock for multi-file
 ops
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <20230308131452.383914-1-peternewman@google.com>
 <20230308131452.383914-2-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230308131452.383914-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA1PR11MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8e9245-3d58-406c-3882-08db2bc82edd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCQunRV0S9nOWfd0JiL/q68poRFmBok8q53qmGQNmIhsXDEPokmNvYfHcWk4GhIY2gzgywP+q/HsgTQJ77EJxU5CbUjLdEf0u2JUo/hbbh4mufs2naKZAdKPIYaYJjICp56x7kYm8f9sq7M7Y1vBA8ifr+E//T2dOFX41tiBoeBnEP/D7FkNB4jMF0ZDPqg+h6f/W4iVj98fFSTsUk9mFCIOxLF2AMuuIwi6DKURvUI7b1ES9oqmTxjhPqzktAWGi9x0gZNuy/Dp3+9gi9UUQZuqynjdgwkRd3+nbuMothUoqxfWGidZgpv8aYWQcQ0TbCKA7dRGj+ZYp3igzu+jBLqw3JJUnOlLHdkWVtGwAAcei4Eijt27SHiW89mEWmYY9HXdkHx4IIMw3xnvfm2w+Yr4QXYlBTPr0W3lcT7tJYza+VulBTy1Zx/aLEh51a1R8NN4c3pjBKZOb2Zx2v33X0rxH1n3Elj+4ulUTrBM0sqCAIaQeWYzAz+8Q9g12ez8a6hBViUSDPJhP0IyWnMLihImm3qsW5it3yX7u9KbljhS3FE1woULIaH5rlSE7454Ca7BSFFyLZux/zFd+/gPBIpw7VGSaeryb7x4sa2s198s410y3UycM/kOVtmrFVbgJybs3mrTNISVNJq04+VItg5m4ZQ1X6E9GmVN8eeVYdtaNy2tglNN0OpDHK8WzFhqOgPk9J4M5eIv/itNamNL8ONt0qmojfWnQPwpN1Ag/fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199018)(2616005)(6666004)(6506007)(53546011)(83380400001)(36756003)(38100700002)(6512007)(186003)(26005)(82960400001)(8936002)(66476007)(31686004)(41300700001)(4744005)(44832011)(5660300002)(478600001)(7416002)(86362001)(8676002)(4326008)(66556008)(66946007)(6636002)(316002)(31696002)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZLSDhKOTh4Um82UXFZT3M3eDJTdnlrU25zcHFWckM2dTVydHlPU3Y0eEw5?=
 =?utf-8?B?OVU1SE5tWXV3R3NOUlJjdko1eXNzVytIdzc0Vi9jdHJkM3BRVk1EU0t3TkFV?=
 =?utf-8?B?ZThOY0cxaWc5N3VYbWFQQXJLakF1ZCtoMkJxMlFGZi9zdGR1aXRIRzNnSzkx?=
 =?utf-8?B?YlBWRG5mNUJydWcvUXMrS0pNRkN3a3VuajhHempuanovMTdnK01KT2RXUSs4?=
 =?utf-8?B?MkVWVDlnTWd1dDROYzN1N3l4RUh6NFN2TEs2MndGeWMzeXp4SkNieFBuVy81?=
 =?utf-8?B?Mks5anYzaE05aFhQcjQzeHRtc2ZoRzBiTHNBVk5LUGxLYVY1ekF2MUtKUFRQ?=
 =?utf-8?B?ZXNnQkM0OUswVjJ1U2liQ04vR1VLMDBvODU5bEJxL05ta2JNT3VWZ1hYbWVn?=
 =?utf-8?B?ZEJlZld6Tm1mc3QvYXpQWlZ4YWlFYXJBMCtOZEQ4RWpYWXpXakp4c2RlUTds?=
 =?utf-8?B?VXRCKzBPZ2hUODFYOWdFZUlYb0ZiZTZjL2NkV1FrSGFtbVFLVW9qMm9memoy?=
 =?utf-8?B?Q0ZEcW1Rc1UyQkxJZXUzbW9hSU90Z2ZpTDFCVURhSFUrUzBycEF1YUY0Z2I4?=
 =?utf-8?B?UEFvOE9nR2JGZU1JU2N5b3NkQnMrTXBSU0xPTi9aaDdDWWxLY0xtTmRCQVkv?=
 =?utf-8?B?SElhbVhpVjFpMEFtNUVtU3RJTVR1UkU4Mlk5bEhBcmF6VXBNUmJZZVRiQkta?=
 =?utf-8?B?TGdHMU9SMlQybzVZdmlBWE45NDM0VklkY1BqQTUxc05DdzBPSlAwUEJ4dDJK?=
 =?utf-8?B?QkJrVzlsb3AvYVFIREhJaUUwNE1jcjZGRmpIOE9Rd3dhVHd6WjJOZ09VN2l3?=
 =?utf-8?B?SDVHUGM2NER1dUhVN2hJZjBoMGRGb0dtNXB6MkZ1VG9EdG92RXBJN29CT3p5?=
 =?utf-8?B?YXl4U0J2VUhINU03b1h6SnpqN3BJUWJXbTJwN3krWUt2UldIVjc2eDZSYUxv?=
 =?utf-8?B?dXl3QlN4MWgxWjFrVHJJVGRpQXZmZ1ZtRC9lQTRsQ2xPZXBaMitkYmptZVFm?=
 =?utf-8?B?TGwxZVZXM0tYK3RETDM3UkYvQWUzWnJWRkpTYWZPZVBMR0hwVTFFV3kraEEw?=
 =?utf-8?B?aWlxejBHOFE1eG45eTNhaitpRGY1b2JBdDREenRsM1pidFRqVlhOcEVZcTFQ?=
 =?utf-8?B?M3NndFRiUEZhNEdiRm9zWURiTUxvOGVOL29xNjIrMUE0NkNvMlR2QmRMTmJQ?=
 =?utf-8?B?eTQvdTJySkN1THFzazdLWmQxcTdoSHJZa3pObWZGVmRLWTBubmgrbFdTWGN0?=
 =?utf-8?B?eU85L1RHK3FaazZRbUNqekoxL3d3bXBDdHA1RHhPSi9nelRRZFNFOUpkUDhC?=
 =?utf-8?B?dlFLbUNoeGQyVnNFNmlObDh2aGlpcHZoQWVwdEJTcXNUT2FyOVVTbHVBOTJx?=
 =?utf-8?B?TGFWMG5HRmRNaEgrQkt6NWozeHhHdmtjNWFiekN3VS94S0Q2OTlHQXVLKzg0?=
 =?utf-8?B?eXJxM0E1UG12UGU5Q3VYdVgyMFFzb1c1TFdkU3VZSDg0NmcyQktYMU5ZdTBz?=
 =?utf-8?B?WE1rU2R4czZueU53MVA1OHlQQ2tYbFU1b0RvZXo2b3VzU1ZDejJnd2tKbGEw?=
 =?utf-8?B?eFNRajRkWXp2UXFSSFdBSUsvRVY0NnRkSU1PbG5HR21iaG5uYVVHVkd4NGI4?=
 =?utf-8?B?Qm9TRzZVMzZ6L1B5eHVMOXgxbHNUK2ppSlVBNjhuc1JIZ1VxSS9Xbi9JZEU2?=
 =?utf-8?B?N0phYld1djRpT3RkS0RWMHR4cEZFSHBiVklhUStmOVlTK3Z3bThXcklEY2hv?=
 =?utf-8?B?Q2ZqT1BNZHhKd1F2OXJjbUQwMGNrTXpxdDBiNmZZQWtIb1YvUnFBVGp6aHdQ?=
 =?utf-8?B?MEU3VTZWUDZIUnU1enpMZGpSQSttVDZEcGRkZzc2UElueGlFTkx6SENtM0p3?=
 =?utf-8?B?cXJTZzdLcmVhYmZLTGdBakU1c3JQWk1wSXdHZmo2SU5FcUM3UzloRHVjWkJK?=
 =?utf-8?B?RnkwczBXeDJHdDBtc2Jmci9acjBRRjFyL3VpRHhCN3ZlVG9uKzYzUEJ5Mk1z?=
 =?utf-8?B?YXRDTzVLR0hWRUVvOVN5ZXFLNWpTVnBwZ3hMb0puc1VSNEpXQTNyVGxyR2Rs?=
 =?utf-8?B?SHRQZlQyV25hWmJvemV6bTh5b05EQjIxcldjdkJQMkhMRjdyNEk1NGwzSEJp?=
 =?utf-8?B?MmYwTzZWN1U0SVg3aGRQUS9udzFLUk5ibWgyMFRmeEwxKy9XMmNmYnM3a0ZF?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8e9245-3d58-406c-3882-08db2bc82edd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 17:58:18.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP0hcdBI5lW0fpweHhIvLfBYuCdFgChhhBNDNT5z1ZseEE+FCIE0bmkmXX5SkSPNGtkxn3jRn3llaKltL5eBNSlBbt9nW+WFo9NekWHf9/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6965
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/8/2023 5:14 AM, Peter Newman wrote:
> rdtgroup_kn_lock_live() can only release a kernfs reference for a single
> file before waiting on the rdtgroup_mutex, limiting its usefulness for
> operations on multiple files, such as rename.
> 
> Factor the work needed to respectively break and unbreak active
> protection on an individual file into rdtgroup_kn_{get,put}().
> 
> No functional change.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
