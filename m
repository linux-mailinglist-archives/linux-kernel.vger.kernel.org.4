Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96151648B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 00:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLIXym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 18:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLIXyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 18:54:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE05FBBA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 15:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670630079; x=1702166079;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z64vC40YRvzt3+SpIN28l3dCNhBQtorrOvA/7HedBmY=;
  b=EYMhUpUnU2nY0Nc6WGtIPisgo1y/3Y5+oqH4+7rwmYMVgt58Fue8pBWT
   iSmNpZhThyQa7dWqmbSbffi7ywrxlHz78Wir1TGyRfNpHdHMuqA3Dx117
   Xpb5IewkzU1zu0tsuP9yhF5LS/gSTNCwAbfyXKQYhCprQIib8wWUDNOen
   HlrexqYAxnTbpi3x2YRGq7Etyhv1IaEMUq/r/bCnbVONEaN4Opehq9fys
   0E8yxSB5k3c67W8EE87U36ejPhBBo3Zy+90Xie+mRLWCCHHqO5Pu/eWQf
   TsgDp1HO1V56cwdQQSsDnkSJyZSW5OznkW8KAFD9lX5bRmskKsZTOvIgZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="316272244"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="316272244"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 15:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="641172099"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="641172099"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2022 15:54:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 15:54:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 15:54:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 15:54:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 15:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koBfs3DT/mOMnXaVIufwYZ+sStiEJBUXNvcXhnO3h3i4e9Y9NFOQK6ZAbt8a3XSQZvcDM/zvCwHePZnQvrO1UoprTVYTn0K4nErSIwfz9sDJeBYUOIap0BnEJEj+AFTtUXhHmLk/OQVmoVqN6Fl/vJN4HW8W5dVi4pzjJLBBhrRiKLzUq6G9R8Y4wWRx95uP1SLDtRFtZiojrXWv6v1dFXZhAz9XpVXwPY9qX/paCVsDmVXErrZo/NePOViROh+KPJFmc39U1UYnR4ru3z1J9nnu1zqvRBBEMMda6OUbQMBDh54IgwDwMkrFwWC0hhdMf6CJnrASko+C2LwsIGSCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp6eFRp/gNrZc4p+AIZWkIJHu3dwZjmPpZ+r89Ej/kw=;
 b=bBHO6JLXqozYnbzY6LR2N8mFA1WqZZV+75hSOVBnCQlUPXKHX/Z4HMKQ0hfrYtJeA84PXiW90NJOIfEbTRJkB1N8WkeRlcAKWThv/3Q0zugh/0kV5k5hBf57Au57V7QvWXz6etP4hs8ztQHSRoUMK3eqhnuGsQL1wfv3IG5DeWci2SpNqZBemssK33tWtLUmxhJjxony3GE7TYBeTckhxqpSb+mdWsdQufffFrSVLB3/IKQuLQeScmzZWHVsb1vG+hzBcaAZrL1rgFclFk6q/xAP/T2bYF7VZecLA1yPQWOUCZ2WUvwD/vL9De+sdzRGVe0CA9z1D2CSpeA6sIVMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.16; Fri, 9 Dec 2022 23:54:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 23:54:31 +0000
Message-ID: <cdcfcd64-c76f-0d2d-6653-0229c956f2bc@intel.com>
Date:   Fri, 9 Dec 2022 15:54:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with
 task_call_func()
To:     Peter Newman <peternewman@google.com>
CC:     <bp@alien8.de>, <derkling@google.com>, <eranian@google.com>,
        <fenghua.yu@intel.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <jannh@google.com>, <kpsingh@google.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <e28c1f27-f320-511b-e5ea-c278a570d709@intel.com>
 <20221208223059.4086209-1-peternewman@google.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221208223059.4086209-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fdc895-085a-4737-d046-08dada40b6e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wy9KaSrCzbpiuAvnF5loQdcBejVZhGLY9DssE89ejDAGpnNzmZr99Euxdo+vTD/ptiYfhYi2mYIgNydWKOiO6RytYsMHZBLk95CCXXPxYvYnBBRJxL53YIzN4SzYjHklMIECA1zBU++DL2pnfPHtDU3c0GjTnr8pR8A9rlCWF9dSWyUBc0ujwvQFibfV7FyQiwAf7iDiAQN+YN1MaSgK6Sxa1e9DbZczJElhkyHqa/dt2xT5K1Ix08EO46p51x5XgPw/Ej+9/RlZ9FfTnEfgLoLWYK+VsTDMtrhBj9unOHhJcyCj7YRH8xv2VS99mI0RpJFq64Rtk9DUAQlMA9CTkae6anRHc4PpLpHv5V2gOBKU1sHqq2X++lPrHyJonNOGXuDy2CGpGKQoX/oc4ArKaZrwLoLsHaj5p5M378JmDqF1JMDLBE15eXoTikfSmEm1LirS//MPSU6mjd4/pWfyuIlrtejVnwGyXSnOjiQyTzqR4148Yb/QZfAVEXyK94ncugJPsERbd5kITVZp0R4BUki7ih5WIbKNgrCT0V7YyJ6CPHXnPsgPJV7maP16ayiS6PmAnGx7Rc99c9jYqk2OS6zzyNs56SepFTmzDHZr3t+48vJryS7Fos+Kk/kLApdYS35FIixGQ+Ubim7NUbppIigMIs1pMavdla3UZzat7XneUtmbcXjdxMDfAyyvCx0AVFTR827SvW6JWu+Kf6KpmWOW4M64DrXZ7lLpqHD2rA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(6666004)(15650500001)(83380400001)(2906002)(6486002)(44832011)(31686004)(478600001)(5660300002)(7416002)(316002)(53546011)(6506007)(8936002)(186003)(36756003)(86362001)(26005)(82960400001)(6512007)(41300700001)(2616005)(31696002)(38100700002)(6916009)(8676002)(66476007)(4326008)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YngwaHUra2VabnVXdFhHZHJjY2UrYWZQQUNsZ2p5Q1ppTXpSUU5FWmFkb1Nz?=
 =?utf-8?B?TFo1ZGwzclMrNHNVb0dxTmZDalVCb2U4VFdtN2NUYldzY2VtSW1HWWZvdERL?=
 =?utf-8?B?Q3pMWTVYdDI4V1Jwc0wxMkJuK01pTW51YktqSXh6Smc1Q3V2bjdpWTVSbnEy?=
 =?utf-8?B?UkpnRUl6aWxnbU1ndVU2ZGtNVk1ody9mSzdhcHZwNGJwY002MTRWenU3N0RV?=
 =?utf-8?B?bG5ISzI4aW14MEhmTmdFWmV5cnVKNHJqeTRIeXlSQlZGSG9EWlpkMm5rNnBQ?=
 =?utf-8?B?T1FsdDR5dEtQbTNDckVSY01QekxLbHpVZnJ0MkFTeFRwalVkeWZzMWMwVHVj?=
 =?utf-8?B?L014UDdSdk83T1djUE9iaDlsc3BaMFYxTzFUc3RSMjJDMmpmZkFLd1dtZkZL?=
 =?utf-8?B?N21iYjJ2d0ZlbmJwMXhOQUtOYXRiUmJxZHlFOG5yYnN5bG13MGVWTXFxMmNy?=
 =?utf-8?B?bVZvT0gxSEFEUU5IbEx0M0RIYUh5QTFWVkhYcHZGM2hzZHo1OU9SUGdRbmE4?=
 =?utf-8?B?UXY0OHh0Q3ZkNGxXcy9KUVVuQysrcXhtWUJBWkJiaEF6WEJaN0NBUkdqczJJ?=
 =?utf-8?B?MUt3Q1hGbTdSazR6MVkzaTN1T1pIUWlPYndKYk8zQWdyMExlbE1STERQbk9D?=
 =?utf-8?B?NUllRHFPTmtHYmloY1lhWVFkdzVYSVJLa2ZlT0VDRVh4eGN3ODlSa0p4N0pG?=
 =?utf-8?B?NzNWVndjNE9Sa0FBS25Sd0R5SldVNDhRZmlCL1F6WVVDVHptZHlsanNLL1hi?=
 =?utf-8?B?QnhOYVdMR21pMmRsQXp0blRNcnIwSGh6c2thdHFjdTNqeFpKRnZRMThQTDcr?=
 =?utf-8?B?Z1Rnck1rOGVOaWtIYi9nVkQyb1d5TXBHelZoMjRrQmo1U3lnWDQ3aWR5T3Nj?=
 =?utf-8?B?Z2ZaeUN3R2FtOTJ4KzZjMTZnUzNMOWhrdVo3WjZVelBOaVZkcU9WSlFJR04x?=
 =?utf-8?B?eXd3WEtFTUlmTVdmM1ZvRGR6cVRkY00vWEFRZmpTVHg3MnVVb3FkT3ZUUzlQ?=
 =?utf-8?B?TVY0cWNMOFN2M1NpV1lmemFEMk5Nb0FXM2tENWlBNnVQb2ZNODQyWkwwbWhy?=
 =?utf-8?B?UWFSV29wL0oyc0QwRnYxOGd5RngydmIrbmREMm9VWDRlRHVxdXFDQ3JkNERy?=
 =?utf-8?B?bkhxUHpTY215TlZFaEV2b1puVFNqNzBXdHBSOWhic3pHcUFoSXR6Z2NKa282?=
 =?utf-8?B?MFF5eElkcHZsUFo1aWtQVVpTTlZxYmRPcDhVUU5xczYvbFR3bjkvZHhSMGtM?=
 =?utf-8?B?RktJWU1ndVVlR2M3UHBKbnM0QitqRDhEaWE5MHlOeG9kbFNienJNZEZNUXBo?=
 =?utf-8?B?Yit3TDFhZXhyVUZia2szVDBoTlpLVEZkZEZCQ3JNNmJVNFplNGwwQ3FxZTJp?=
 =?utf-8?B?ekJnRndlalhJd0ZnSE9hSWMxdnp0R2RaMXRZQU9vYmNTTnZvekRPZkZCYWor?=
 =?utf-8?B?Yi9RZEhRcGN6azFBQVB1cGZBY2NrdTJFWWl3SHdCQVp1d21MK1dRQ3UxWEZi?=
 =?utf-8?B?TVROMHJXdUc4RGFNUDg3VENSNGpLcCtEV3RCdlJJb1ErN0dHbFpWbUpwb0to?=
 =?utf-8?B?aFk2ejF0cEpnQ1E1bnlqTEp3MlM5b1NqblphYUtzbFIxaUl4N1FMbHBxSXFQ?=
 =?utf-8?B?UytpTklQTU1vVzdFdXVXeWdZMjAxNGhsUUh5WGRONVFsVjVLSWVFSENKSUlv?=
 =?utf-8?B?VlVtclpTYkU2OEQyTFAwOWpTSWZ4YXhjMTlwTEttdVRsWmg1OW5yZzJZOGlC?=
 =?utf-8?B?ZHYxRGVPL2F1MUwyaE1IS256cmR0eG1OaURpQVRZRGpwUU9EZnk2T1Y3OG42?=
 =?utf-8?B?NzUxdzlhOXlaWnFieUxWREI4UDVNcHJJMXlBb2c4QlN1eGMzY0svTlRqMVh3?=
 =?utf-8?B?dk84RmQ3Rk1yVVQvZnVDY1BldEF5NGlZU0NRSU0yMSsvblRWR3piV0Rydm1I?=
 =?utf-8?B?ZWFqaW9aMTZFa0J5K0ZyZEdsMmhQeis0czBremtPQ1AwVU5rK1pqTnBOMGtT?=
 =?utf-8?B?R0RaZERBbTR4S3FtQ3V4eWdaVWdnd1VieHBtMDBvUVVSQWFTdnQ3cVdaaU4v?=
 =?utf-8?B?Z21RWWUwT1d6VHFpN1FqRThUYi9yaTlPSEJqRVNmeDVBc2ZnWDFzMXNCN2Zk?=
 =?utf-8?B?dG12VUlReUtGdGFFRjZ6aFl2b1l0UGY0R1NVdTBXMWo4Y3ZVYUVGb3Zhemd3?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fdc895-085a-4737-d046-08dada40b6e2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 23:54:30.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Rib65d79JtlRpBh71eqkHxCedPI2326v7YKLaIk7ieL6h5AqFIyamdh+nQPi/CRvTiqua3Id820+hgt6OIUTk2VB80DWt0fJQhRYbKi0ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12/8/2022 2:30 PM, Peter Newman wrote:
> On Wed, Dec 7, 2022 at 7:41 PM Reinette Chatre <reinette.chatre@intel.com> wrote:
>> On 12/7/2022 2:58 AM, Peter Newman wrote:
>>>>>  2. resctrl_sched_in() loads t->{closid,rmid} before the calling context
>>>>>     switch stores new task_curr() and task_cpu() values.

...

> 
> Based on this, I'll just sketch out the first scenario below and drop
> (2) from the changelog. This also implies that the group update cases

ok, thank you for doing that analysis.

> can use a single smp_mb() to provide all the necessary ordering, because
> there's a full barrier on context switch for it to pair with, so I don't
> need to broadcast IPI anymore.  I don't know whether task_call_func() is

This is not clear to me because rdt_move_group_tasks() seems to have the
same code as shown below as vulnerable to re-ordering. Only difference
is that it uses the "//false" checks to set a bit in the cpumask for a
later IPI instead of an immediate IPI.

> faster than an smp_mb(). I'll take some measurements to see.
> 
> The presumed behavior is __rdtgroup_move_task() not seeing t1 running
> yet implies that it observes the updated values:
> 
> CPU 0                                   CPU 1
> -----                                   -----
> (t1->{closid,rmid} -> {1,1})            (rq->curr -> t0)
> 
> __rdtgroup_move_task():
>   t1->{closid,rmid} <- {2,2}
>   curr <- t1->cpu->rq->curr
>                                         __schedule():
>                                           rq->curr <- t1
>                                         resctrl_sched_in():
>                                           t1->{closid,rmid} -> {2,2}
>   if (curr == t1) // false
>     IPI(t1->cpu)

I understand that the test is false when it may be expected to be true, but
there does not seem to be a problem because of that. t1 was scheduled in with
the correct CLOSID/RMID and its CPU did not get an unnecessary IPI.

> In (1), CPU 0 is allowed to store {closid,rmid} after reading whether t1
> is current:
> 
> CPU 0                                   CPU 1
> -----                                   -----
> __rdtgroup_move_task():
>   curr <- t1->cpu->rq->curr
>                                         __schedule():
>                                           rq->curr <- t1
>                                         resctrl_sched_in():
>                                           t1->{closid,rmid} -> {1,1}
>   t1->{closid,rmid} <- {2,2}
>   if (curr == t1) // false
>    IPI(t1->cpu)

Yes, this I understand to be the problematic scenario.
 
> Please let me know if these diagrams clarify things.

They do, thank you very much.

Reinette
