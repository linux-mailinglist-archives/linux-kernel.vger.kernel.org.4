Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472C688B22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjBBXu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjBBXuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:50:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1A171F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381853; x=1706917853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FVWSuu2ZLHXXpLiKEDUKAzXJIVpg85xwTMJPGl1eWdg=;
  b=f8lHg9m3K+vq/YUI4XqlQe9WHcoO+jjJTxLL4lhUOJL6fBy3Q7xNV+mR
   Rt876GxsLUw+kC/n1+gXCY5mPLWPywiXJ5z6XkP9GsS/fmSXHp8UDrvx0
   sijt+V8PxT8gYHE+MUtmqzcth5A0zMDrfyV3zQda1fWPWMVoNPLA6NKEF
   bhpkPHlky08oWv2ieRdHk/kXTQxYtUz6n1aOoK5jc/8NwFnHwREkCbRnn
   +NInzGdmZaQb9GIFjYLN4wxhrX106OXiC4WEzvwEv+hB/Gtuzrh1JVNmI
   6HmSet8Uo+MJkt0AKMNA6Dg9DY1JYZGkkcIsBxSo/IW03TBpYaOb9yiry
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="328622126"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="328622126"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="734118433"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="734118433"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2023 15:50:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:50:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:50:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:50:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:50:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icg3cVwmVqmrhgdzz1lZCwKGs0VnNI462foO16WTIP4y4dDvpozGtuzXt2N7mWLJYcP0kC0mA2ntxF+HO7aht8jCb7BhEoO9PhldBnd/04Izi0FQzdWqNHlBz9T6fk6PlQpdR0+GaZD0ixcmM1+CJW8FYBydNhlSHuhvL8SyyzpYipVv+1WdxTot1sj8cZEFCcNGz5cqKI9EqAk4f+SjWyohamsrV+j+7u04+UWqBCzsX754qS9+E3RNyxdQQaoaQaFnSe89dSlFKMWbpYbBhqI91DVjfiE4KUdeO1wlFeOv73MPA8VhwCiKVfd2JheG0KHSs5pe/s5IFJO3rQGc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or9lNchRf7Y2SIklI3AdbCpsrUGUfPfG5oOfVKXT/Wo=;
 b=UPMQ8h2uRYK4VA9Od08L5y8b1U6Sq3fJu9FCARQhDVyhF7Ir2Q/xqqoZ8qcHkTxG1oFOWDCkBuVPHqgkXMn06NPnpLLslXiNAg9wtbHfGgZNdj4brZ9hD/Zw4huAA2LdvTiR1ZYp3eSPXVwVuqxCgjMohJnCTXgb+ZEd7ZdbS+LDwuGRWEIY1XMKRsbAwNcD99gfFete/2JBFfRSXOWbse5FaLa5GKtf3igU9B7/m+C+rYoQ1OlejG5bUd5Nl2Zg1DPtiabY3mUrKMLoPQN/gs6dJ+GCXUxl9stxV7QruCCuMQLlv3K/1/LJeiD8/h17FoF0C9KemtqxOiZx/TLSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Thu, 2 Feb
 2023 23:50:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:50:49 +0000
Message-ID: <d7d43c53-a482-100f-8a25-4dae6500d184@intel.com>
Date:   Thu, 2 Feb 2023 15:50:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 18/18] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-19-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-19-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS7PR11MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: f74fba37-635b-4cce-7ddd-08db05784fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhnESzP+QyWlgEBDW0IHRLQmPgdqWmGCA9PuOxkpuSz7d+d1nEM4y4mwUVWVR1dA7cCaE3d1WHIYNSPJnNBBCRrY6D/Qff0Q5g4QcsNNcFeN1U3n1JhV7alE87BqdGB1sZ8tB93PUt7QAohBUvg4ZJT7m3dz7O8J8nF3DNAMjaWFNWDQ6nvMjqWjlOKk1f+qeLWEj4norN19/AtTAqy44KKuWdIYfBCkg41v7tpdUJVnz2kx5MC7X2hVAj+dSNdUPVGNGUbRYGvCJNXut1oxxdW4innhvmHtxP106y5XmRa9CcBeapmUEZ8RxtgvelymtBta3hT/K9cD5odV7FbdRNXETGgTIQzB8ihTFTqM02LatGHUbz0UzWwDPBxN60r3FJs60DV7j4liXgAOpCHd8my5Lyh+8Doyoj3ACxyQfLRodoedxibFf7MgQbDucTnZojLVNRDLNLJfsT5EQrr+be6GHbB4eHrXWHoGD8+qWW7NtnXRaFVkBTz1iA3feNM9I7aGeIB7UNe/X8tFybuaaYumDGd+DD+Pc/Zb92MsaYxc9n26woQ9NWBLCBGHRCBPmXOPwCWNCeV9Ez3NFftCwrgG4cA0d9OJuZDgSsXk1qJKs7V/QDwaK6+7ktReXckv88sl4trygvM5gJ+rmPOw1giNSNFhPdqm3euBrV81wcTrmaMQ1afn4xFnrwGEp/9bzTnBlNcsITZctzvzIElWj9R0iiAqHzlprgrkjxFcEL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199018)(66899018)(31686004)(2906002)(6506007)(44832011)(7416002)(8936002)(83380400001)(2616005)(36756003)(8676002)(4326008)(66946007)(66476007)(66556008)(41300700001)(5660300002)(6512007)(54906003)(31696002)(38100700002)(316002)(86362001)(53546011)(186003)(26005)(6486002)(478600001)(82960400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWw2dEhDcElxdzBmcjM3TytsWCtZOEdKbkhtVVRxTVE2VDJzU2Nhd09BZUR5?=
 =?utf-8?B?WXdvZFkzcUpjekNxUkdFbytDUVVYZk54ZVZsUzU4MHd5SmZxS2dUcHp6SDVI?=
 =?utf-8?B?RE9jeTJmTG9IMytIcUR6RW1RaFZaaHBHWk1JeUVpZjRFMm1EWGZYR3U1MlRX?=
 =?utf-8?B?K0JSeGhITFpFQnNDOW56a1hKT25pa21ERFRlcE13Wi9XNmsyRmFWeXluWnFi?=
 =?utf-8?B?OGtOTjJMYlJWL2Z6NE9CMzNUaTJZcHBoZzRuVVdxUzl4RzhCNm4rMU8ySmdV?=
 =?utf-8?B?SnpndDN6Z3hMcTBZc29PaGtCRFlkV1BBWGJmTVJVa21zQ3N2MmdpUE9uT3Zk?=
 =?utf-8?B?ZHUraXFnR1R0QVVZbFRXellRdVpxSDhidGxBaGJ2UHl0Q1lGbi9oZjN0RS85?=
 =?utf-8?B?V2Mrd25oSjJlMEE0RXFpNk5iajhSeFl3L0J6cEx3TDNXRkV3S2FDbEdNOWpk?=
 =?utf-8?B?a29hQnB2QnE3MXB0NmkwK1Y5L2NwMEhWOEZBUUJYb2o2MlNzRUxIeWRKa21m?=
 =?utf-8?B?OG1MZ0p4d2w4SDY2MHdXREhIN1ZVU2Vrd2N3c1EyUi8yeEhVT21yKzIyR0Fw?=
 =?utf-8?B?T1lQMnNEYjlvMmRjZDA2WC80ZlZCQ1hRbUFuaVVtOWxmNnRnUHJWenhNbWp3?=
 =?utf-8?B?SjVjTkUvZjliTWdVUU5QYVJFdVloN2dkRXNIaUtiRG5WVklUaGNvM3JRMWpk?=
 =?utf-8?B?L2JXL1ViOThvK2Z4TCtVNjFRbUNpaGpMeEdTZlhsNjVTU1NaTEhpOVNsWCtY?=
 =?utf-8?B?RVdLS0ZuM0d6b2RwRDZ0c3Uxakw4QkVyV2FZbjhud0o4QXN2MnNmWENiSE4v?=
 =?utf-8?B?bHZMa25xbEErWmhraFNZSS96aWpPWXpGQTZxS2ZMb3FpMUcrcEVINHJWQ0ZP?=
 =?utf-8?B?aHNKblFMb1AxckluWU9tSTJQQ1BtYzVhZzdyWmxQMitNanQvdSt0TlgyeXkw?=
 =?utf-8?B?SUpiZ2ozZzlSL2JqdE5CNHFEc0djRzhDNzd6Z0VKeFFldHVlNUh6dzlKL3Br?=
 =?utf-8?B?dGZOdFhNeFo4UzlBVlByY1pVSTltTldDZmNPVkJtUnpsb0JLTnZEazBlZlAx?=
 =?utf-8?B?ZDI1MmxXblFTZmVvUk05K0xGQmc3K1hBRktpcWsrUFBGQ3ZzSEdNU3dHbzZ6?=
 =?utf-8?B?S0svRDZ1R1IrTW9VV3lMRlFrSU02RDlZSmpWamxYTStBck05YUdTMXhpWCth?=
 =?utf-8?B?UHVtWnBmMmhrQjZDQXdFVldKdzNubWZKaWhUelVNUC9oR2RaaVlXdjRRZEh2?=
 =?utf-8?B?a2YvRmlNREoyWDArcUQyUk9NVEEySDdDZ2ZhaWVGOHRVcTBudzRIaDBlWXhX?=
 =?utf-8?B?amU0V2MrbVhRSnZxSnNKZkhWSnlncXEzN3dDTlBReVRhNVE4R2xaY1JQcXdV?=
 =?utf-8?B?bThobkd1UjYzczh4VHp6UXA5QmllRHZreXJnWkMrYTlzbXhONUtncU4yQTRl?=
 =?utf-8?B?VjMvbjJOU1Zlc0Q4K2EzTjE2U1MrM3B5QTFoYkNOeXpUYWY1VjkrczdxMXJj?=
 =?utf-8?B?MWQvNWVzRWtteThTVjNqM1M5cFRzWHVRWUN0L3J5STJtaVd5Y1dZSGJrOENr?=
 =?utf-8?B?ajAwUGlicXZZRFczSS9qZjhJVWlhNjNWbXpSZlQ3TkxwM0xWbEVuZFpKa2NC?=
 =?utf-8?B?SXJIT3F5WHJYWWtUNlpwaHQxZjlYNHhTZmFJWGkvTy9uQjRJUll5amFHU2ZI?=
 =?utf-8?B?WnZ5NVNwWWpyMDlNTWc2UTluMFJ1V0J0Mk9hN1djOVlVVGRYcWdmRy9LRjVy?=
 =?utf-8?B?WXdTM2ZuckE1azNOV2JOeXRTcVNaUklYbnduRUl3bks5RUNQSSs4dUowbTNp?=
 =?utf-8?B?Q3FQOHRMWjhySVlCbW1XdUZBVzdNVXhiK0VFMnM0aVNReGtzdVdKYTVvbkRL?=
 =?utf-8?B?SnBiQzArL2xFM3c0OEZWaGI3UWVPWkM0U2VtelluWFQ2aUlQb01rUDhuSlRX?=
 =?utf-8?B?VGoxcGdXalRzNzI5RFgwUklXclY4Sm9ISUpzMXFqQ1d1ZEJpWWljZlFQSGF6?=
 =?utf-8?B?ajNiZjVkc0laV3pabFBVK3BiSlhLTnVpN1ZXcWU0SFR3d3MrRzBTd0xjYVdZ?=
 =?utf-8?B?VDFwMjIyZmlGZUVLRENTOU1IZkRObThhNVVBeXgxbHFObEJIaUthZGNPZlRj?=
 =?utf-8?B?bnUxUTh0NC9mVWd3SHo3VW9TVUkremdYWTR5MW8rY3UrTkFIcHdLUmNlbXc4?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f74fba37-635b-4cce-7ddd-08db05784fbd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:50:49.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UScSemezq8NcvemUL8bhIAgArqe/CGbwZnGm6AiiaAs/VToj67ZUKWs9zeJnmLq4RCe5kIcE1pXFE/gWgTgFTch2H8k6kSJe7oDD4ztuWkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
> 
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against cpu hotplug. The cpu hotplug
> code already has a mechanism to do this using cpus_read_lock().
> 
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.
> 
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
> 
> All but one of the filesystem code's domain list walkers are
> currently protected by the rdtgroup_mutex taken in
> rdtgroup_kn_lock_live(). The exception is rdt_bit_usage_show()
> which takes the lock directly.

The new BMEC code also. You can find it on tip's x86/cache branch,
see mbm_total_bytes_config_write() and mbm_local_bytes_config_write().

> 
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() can
> walk the domain list under rcu_read_lock().
> The other filesystem list walkers need to be able to sleep.
> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
> cpuhp callbacks can't be invoked when file system operations are
> occurring.
> 
> Add lockdep_assert_cpus_held() in the cases where the
> rdtgroup_kn_lock_live() call isn't obvious.
> 
> Resctrl's domain online/offline calls now need to take the
> rdtgroup_mutex themselves.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 33 ++++++++------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 14 ++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  3 ++
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 54 ++++++++++++++++++++---
>  include/linux/resctrl.h                   |  2 +-
>  6 files changed, 84 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7896fcf11df6..dc1ba580c4db 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -25,8 +25,14 @@
>  #include <asm/resctrl.h>
>  #include "internal.h"
>  
> -/* Mutex to protect rdtgroup access. */
> -DEFINE_MUTEX(rdtgroup_mutex);
> +/*
> + * rdt_domain structures are kfree()d when their last cpu goes offline,
> + * and allocated when the first cpu in a new domain comes online.
> + * The rdt_resource's domain list is updated when this happens. The domain
> + * list is protected by RCU, but callers can also take the cpus_read_lock()
> + * to prevent modification if they need to sleep. All writers take this mutex:

Using "callers can" is not specific (compare to "callers should"). Please provide
clear guidance on how the locks should be used. Reader may wonder "why take cpus_read_lock()
to prevent modification, why not just take the mutex to prevent modification?"

> + */
> +static DEFINE_MUTEX(domain_list_lock);
>  
>  /*
>   * The cached resctrl_pqr_state is strictly per CPU and can never be
> @@ -483,6 +489,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  	struct rdt_domain *d;
>  	int err;
>  
> +	lockdep_assert_held(&domain_list_lock);
> +
>  	d = rdt_find_domain(r, id, &add_pos);
>  	if (IS_ERR(d)) {
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -516,11 +524,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	list_add_tail(&d->list, add_pos);
> +	list_add_tail_rcu(&d->list, add_pos);
>  
>  	err = resctrl_online_domain(r, d);
>  	if (err) {
> -		list_del(&d->list);
> +		list_del_rcu(&d->list);
> +		synchronize_rcu();
>  		domain_free(hw_dom);
>  	}
>  }
> @@ -541,7 +550,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>  	if (cpumask_empty(&d->cpu_mask)) {
>  		resctrl_offline_domain(r, d);
> -		list_del(&d->list);
> +		list_del_rcu(&d->list);
> +		synchronize_rcu();
>  
>  		/*
>  		 * rdt_domain "d" is going to be freed below, so clear

Should domain_remove_cpu() also get a "lockdep_assert_held(&domain_list_lock)"?

> @@ -569,30 +579,27 @@ static void clear_closid_rmid(int cpu)
>  static int resctrl_arch_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
> -	int err;
>  
> -	mutex_lock(&rdtgroup_mutex);
> +	mutex_lock(&domain_list_lock);
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
>  	clear_closid_rmid(cpu);
> +	mutex_unlock(&domain_list_lock);

Why is clear_closid_rmid(cpu) protected by mutex?

>  
> -	err = resctrl_online_cpu(cpu);
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return err;
> +	return resctrl_online_cpu(cpu);
>  }
>  
>  static int resctrl_arch_offline_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
> -	mutex_lock(&rdtgroup_mutex);
>  	resctrl_offline_cpu(cpu);
>  
> +	mutex_lock(&domain_list_lock);
>  	for_each_capable_rdt_resource(r)
>  		domain_remove_cpu(cpu, r);
>  	clear_closid_rmid(cpu);
> -	mutex_unlock(&rdtgroup_mutex);
> +	mutex_unlock(&domain_list_lock);

Same

>  
>  	return 0;
>  }

Reinette
