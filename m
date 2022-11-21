Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1899632F62
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiKUVxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKUVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:53:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07435FE2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669067610; x=1700603610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0IoKiko3hbKu6x0nb1igfmlntTMfQS+lHJcPKzSybMU=;
  b=gRoaNp/5cbf24ttGzpiSLvK6ZLt0hxTKvTsuQl0s+aq8SbYw8Rgv9ZIY
   1BAj4v3p1Ako0C77mGt3Ixm0LgCd1QrETj+7ezShc08zXhq3nif9bwnE+
   OuX4GJeSZcREnuzeGMRHyWz0BoZHFVtfozJScinZOqifmQUFnTz6IeYj+
   0EpjPq/CCUK5bn/NCDKbAVC2COcL/MxOApFiIY+Cn/AupX94RIQn0+qOy
   14G3xypKxVVC2vqHHLK8Usao4oKilYV+85v/TieRN+/OOTwMRTbd0H+Wg
   hMlU5+yftHEWWNJf7asOAWL/CSbP5yNUCnZH3aZdp2zv+shB44UAWjTyV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311300305"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="311300305"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 13:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="970228277"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="970228277"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2022 13:53:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 13:53:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 13:53:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 13:53:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 13:53:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kph9o8mrlBkmk64K2zOpXGeibWj6erS+GLoUBT5x+vFgia/5ukFYcAAdQEWTgoN2/2YFyuP/yPzA3Gtid5WM3seb8upWKlT2qaDUzA7QJFQvMj0RwdGRH0YJ5dTAxxEpaXW8zuatfI/t9fF4yna0UyZmvcFh8fhLzKPmVYIxmnxPTADkCJqozr+nySu3FjmUA5ux5+6dwZsj3qlE5SXjBabO/wBDkGGJx/qSrlHijDoZC3F+ftDd1L7hjOFgQkc1MRRh0ZlbhJxlW/6tEyEVev3W6FR2UoxGcBqdqse2M/qP/4XT4UdYK22Vip97hdLk64wB57GZl3Vf7logqYrwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMhPFPk8w4jmdy1e0RRiqp4rUstD3ITgJI5kpkMK36g=;
 b=mFdKJJKR96fXA1WFtvAYQcfdD7jxIdaS3LJVUjOX4CxOmvakdtelhA882iJw66aSu4DC4Z60cWmj/PFSJLUODT8D+NjPZaBWWfIVHz8//b2y1HsDAHM3HLiHYfmRwPKt3yXnoQM8GNDGJpvg5fQAaOqaER8NgyXlO647hRRycmdC/JZGskLuW0aILD+1Kv3SHfA7d3P2PeroCNkja+QHtYKqQlbS0Eu+a9EhZANk0zzrbmpROFp3E/f+kjB6AIRbu2e7Ntl/Rw7B3KHS93Qn+gBMk4Ytz+jjl3Faa81Kjv/Eqk0iE0Wf7LWhQXgOjmh5s9WcDfhEHH7vZAXWksJWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 21:53:27 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Mon, 21 Nov
 2022 21:53:26 +0000
Message-ID: <54e50a9b-268f-2020-f54c-d38312489e2f@intel.com>
Date:   Mon, 21 Nov 2022 13:53:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/2] x86/resctrl: IPI all CPUs for group updates
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <bp@alien8.de>, <derkling@google.com>, <eranian@google.com>,
        <hpa@zytor.com>, <james.morse@arm.com>, <jannh@google.com>,
        <kpsingh@google.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <x86@kernel.org>
References: <20221115141953.816851-1-peternewman@google.com>
 <20221115141953.816851-2-peternewman@google.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221115141953.816851-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: b63e718a-569f-4023-993d-08dacc0ad1ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va6S8Y67f7SdPNs1JNOECp+mDqlQ2kKdYrRYc3J7sFEAQJrR1uGWD9GgsR5hdN+HTsMN3PI6htt5Roon55HUtn4H3ISkwytxlVVeMgF1l+yVf4oyCUCCgCa5mWPrBrSYBcH/YbE6xWB+ciYtJoedw1R6tK/e/bplAFEeRKh8N9ubWqtEaYs1SDkL9pTTh0JynJVLXV3FRte/lgSGpK9muKOjaDcmSQ/ywAug9W1qs4G07LpbxurVSXY3cp7zQ5lGG3I05hxvSC0x1M0m82ISmanwrW+UNf5J5Q/3wd1hLnELgl1Pb5pke7HxIarak9iadj7BntGwtCbOYP+16nb51FZteOvoyvfoyQtY4WIWl+/bq2reVfisIEwVVgOR7+edBl5PUewhQy2mN54cJur/xoTdFxL23G6ZhCe8OwFdqJwfeXR0hsODr2rPVF/CF/jU0uwkSb7H8PNPJOe7aCTYBP6KJqta5c3RS41qjElaq7aKTa3h0otONosb4HNLmJaaDYkA3Ru+Y57n4sQrC81aWkpTm6iofQcF8L3/48A1V++M3WsUqBXGUb3gBsqaeGs8bVQjm1qTTA8hD+aQ+enkHK35zTr2T+wrxuffDR791GhRRU5nupHh06ULKOxFPBEt/YqZgfVZNkeOYZSE+iFfyNZg15EDg/kQ3+REEdZeUptwF1A7rzcZXrUASzwYUhwFbkRDMEGuUQ9F1qKsnsqAz9UVgrMZzG4kXTO//hz/SHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(2906002)(31686004)(2616005)(66946007)(66556008)(53546011)(41300700001)(36756003)(31696002)(86362001)(4326008)(6636002)(38100700002)(82960400001)(83380400001)(6506007)(186003)(8936002)(5660300002)(8676002)(66476007)(15650500001)(26005)(6512007)(44832011)(316002)(478600001)(7416002)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qjh4UGRJZ0t0RXJmM21JQzJTQWF0dGhVa2pUclhzN3FDdDNrL1NyZnpvWSt1?=
 =?utf-8?B?YVpQQ1Jxa2lEMTJjNGRpbVBsRDhNNlhPaU1YS25hT21aVFZWTG9WVEtmakds?=
 =?utf-8?B?ckc5R3lwaitoZ2N4dkxzZ3F2T1hwcFNwNE9aWFJ5SDJsWEE1eU1WT09oUG5H?=
 =?utf-8?B?VmFxUzJSNlV3VDA0TEhKamI5Q1NNUkhWMmVhWmowL0tpLytsNVdRaU9UbWpk?=
 =?utf-8?B?Q2NMN2E4K05Ib0NuVUd3SGE5NU80VnVSd1F6ZkZoaXV3UDh2YkRHVDZKbjJW?=
 =?utf-8?B?eGV2Ri8raDdteG5JSzNuOUNCM3NNaG9NMitWa0swQU11N1pYcWF2bUo1YVQz?=
 =?utf-8?B?WlE3UTNFYlJGZEIxNHJHNGVDSHFRemU5NkZoYnpxM001UHh0WWwxM0QrWkZu?=
 =?utf-8?B?SWpSNHpKRDB3N1JJcTZ1bW81WlRZc1NmMU1QMDBoaSt5eHJ0VkVMaUhMZllu?=
 =?utf-8?B?YndBYUV1dW84VUw0OUhST1dHWDF0ZFcxNTlKL0tyRHVhaFVpZVZaQy9kcVhD?=
 =?utf-8?B?MmEyVXpyeVNCVisvQVdaVjV5bFhTeXBzaU9DS1E0elRoalNCRFJSRkFlQXpZ?=
 =?utf-8?B?VTV4bGRhU0l4N0JxZ2FsYm04VUd6NkZwY2Q4Y2RrT1RhYXZNQTR4ang0dGdI?=
 =?utf-8?B?TDRCSVpQQU83M0FqckdBN2tuREJBaG5sL3FGZ2RLTlBTTDRMZmdzN2Q1d01L?=
 =?utf-8?B?VTVHdDduK0R2ZHBNYXB1OWxJZ0paZ0w4Q2xKeVpoVTJKNlBBVzFQMXJsRnZH?=
 =?utf-8?B?NXpOV1Fxb2txZmhoVGU0UDlPM0RJUkkvekJydHIvOVZtZC9EU3hhNmI3WWFB?=
 =?utf-8?B?WElHZkROeU0zODJhcGhjRVRDQzZvMlpzQVFaQVBxb1RDSDF6Mi9nbFVXZW1H?=
 =?utf-8?B?c1J5bmNGZDBJeDhCM2srclRqTTBzSlZRc0dvTkFGVkdOVW0veGhsNS9ZdUx6?=
 =?utf-8?B?UmNrbEdQQ0JmbVk1dHZHM2diSS90TmIrYmh6WXJJczdPbXZPaWhRaTV2RjVr?=
 =?utf-8?B?UlFucFFlNUV4dTdnZnBBOUtTK01LR1QyYXNJaFgyRjVlSFpYUFMxSkVmNndw?=
 =?utf-8?B?TVZlUTgrc0U4UGhCcnduN2VnU2N3VGIzQWVzZWN4bi9qT2VVd3NCQmFVYi9J?=
 =?utf-8?B?SHByaHcxR0w0Sk96NUxhTVZESHFKU2c0eEVpbzk3cmNObDZndXR3cWVWOG1h?=
 =?utf-8?B?N0c4Vkh0U3B3b053bkJhanduaHhObWhKQU5sbHhDSmo2Q2NiM2tLT1l0Um11?=
 =?utf-8?B?Q2ZhSUhodjVRS1Y0WHI3RjVyV29tUzFIWVJmMjh0czJrZ2pDNzgvYVBFVVY5?=
 =?utf-8?B?NnlRL0s2VlFZSEF6bW9iekc1RWM1bzRXeEFSTTc5anR0REhoZCtTbHFmRXk4?=
 =?utf-8?B?bUMxenhJMFNNVUc0bUdiZ1gvWFBNS1pobUdVZnhZbmVlZVBJWW12WWgxemw2?=
 =?utf-8?B?cTV2S3RqOElqazFTbXZxdENmSWNtV1p3NTVMcm5RVWk4SDIvM2k5ckZOQjZQ?=
 =?utf-8?B?Y0xZeGtFMGgwem4vUzlBcHZtNjFZbDFPTmN6Kys1TzgvZVUxRDNwVGxPUGZk?=
 =?utf-8?B?M2hodThHaDVJRWtsUk1FWFpac2F3ZnJYMkZGZkltR2N3S1ZBR0dSTHlKS05S?=
 =?utf-8?B?TlFhWkJHUXBNSGNaVDBoS0owZ2FFT3pUTzdSZnBLaG9sRzhTT0txZlhIeFBv?=
 =?utf-8?B?UkZaNlpDU2ltbGRqbk1Bd1pzQzlRRGtxZ1IzVVVQS2VCdGtQNGpLNnU1bmFU?=
 =?utf-8?B?alpZczFjWVV4Snk3c0xiNDMxdkkveElIL0VvYWdhbWNHQjh3YkVYV25oZ2VF?=
 =?utf-8?B?VHBXdmg4bzJlSVF4NDhoYUF5eWJPclFKTnhRTFRSRE9uTGZIQlREcExBMzll?=
 =?utf-8?B?bWM0ZFkxU1VCOHlaZFkxV3NTVXM4QXAvRit2dGl4ZFd6K0RkRFBqa0hhRDI1?=
 =?utf-8?B?dUdSTlZiNlBIUzY1SFFxQ0RPSjNpbjVsK29ubVkvOE56MkxzNkc5ZjR3TWJj?=
 =?utf-8?B?VjljVDg1dThuN1NoeUtoL1NiL0U3bFFkUE1hU0F3YStpNWJrQ09mc3Y4Zm9y?=
 =?utf-8?B?ZW5Ia296eURUV3RFc1JPeExrT3hCNEZHaDcxVHlUUnJBMUhJblJRL0FSbzUv?=
 =?utf-8?B?eGV0bFlCK25IRFZOUWt4SEdjWEYvMzAzWk1TYjY1WWhwYmJRenoxQUVPME9B?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b63e718a-569f-4023-993d-08dacc0ad1ad
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 21:53:26.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CO4TsGCULbsxDwR5zVzbw0gu9iHPZwqyrEmijIQLjI5WwcXuUPHGWOWzyhbm2tQ7xHkIlB6UdhKOXUiYqEM04zruMpV6u0xgth+m8WKnOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/15/2022 6:19 AM, Peter Newman wrote:
> To rule out needing to update a CPU when deleting an rdtgroup, we must

Please do not impersonate code in changelog and comments (do not
use "we"). This is required for resctrl changes to be considered for
inclusion because resctrl patches are routed via the "tip" repo
and is thus required to follow the "tip tree handbook" 
(Documentation/process/maintainer-tip.rst). Please also
stick to a clear "context-problem-solution" changelog as is the custom
in this area.

> search the entire tasklist for group members which could be running on
> that CPU. This needs to be done while blocking updates to the tasklist
> to avoid leaving newly-created child tasks assigned to the old
> CLOSID/RMID.

This is not clear to me. rdt_move_group_tasks() obtains a read lock,
read_lock(&tasklist_lock), so concurrent modifications to the tasklist
are indeed possible. Should this perhaps be write_lock() instead?
It sounds like the scenario you are describing may be a concern. That is,
if a task belonging to a group that is being removed happens to
call fork()/clone() during the move then the child may end up being
created with old closid.

> 
> The cost of reliably propagating a CLOSID or RMID update to a single
> task is higher than originally thought. The present understanding is
> that we must obtain the task_rq_lock() on each task to ensure that it
> observes CLOSID/RMID updates in the case that it migrates away from its
> current CPU before the update IPI reaches it.

I find this confusing since it describes why a potential solution does
not solve a problem, neither problem nor solution is well described at this
point. 
 
What if you switch the order of the two patches? Patch #2 provides
the potential solution mentioned here so that may be helpful to have as
reference in this changelog.

> For now, just notify all the CPUs after updating the closid/rmid fields

For now? If you anticipate changes then there should be a plan for that, 
otherwise this is the fix without further speculation.

> in impacted tasks task_structs rather than paying the cost of obtaining
> a more precise cpu mask.

s/cpu/CPU/
It may be helpful to add that an accurate CPU mask cannot be guaranteed and
the more tasks moved the less accurate it could be (if I understand correctly).

> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 +++++++-------------------
>  1 file changed, 13 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..049971efea2f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2385,12 +2385,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
>   * Move tasks from one to the other group. If @from is NULL, then all tasks
>   * in the systems are moved unconditionally (used for teardown).
>   *
> - * If @mask is not NULL the cpus on which moved tasks are running are set
> - * in that mask so the update smp function call is restricted to affected
> - * cpus.
> + * Following this operation, the caller is required to update the MSRs on all
> + * CPUs.
>   */

On x86 only one MSR needs updating, the PQR_ASSOC MSR. The above could be
summarized as:
"Caller should update per CPU storage and PQR_ASSOC."

> -static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
> -				 struct cpumask *mask)
> +static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to)
>  {
>  	struct task_struct *p, *t;
>  
> @@ -2400,16 +2398,6 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  		    is_rmid_match(t, from)) {
>  			WRITE_ONCE(t->closid, to->closid);
>  			WRITE_ONCE(t->rmid, to->mon.rmid);
> -
> -			/*
> -			 * If the task is on a CPU, set the CPU in the mask.
> -			 * The detection is inaccurate as tasks might move or
> -			 * schedule before the smp function call takes place.
> -			 * In such a case the function call is pointless, but
> -			 * there is no other side effect.
> -			 */
> -			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
> -				cpumask_set_cpu(task_cpu(t), mask);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -2440,7 +2428,7 @@ static void rmdir_all_sub(void)
>  	struct rdtgroup *rdtgrp, *tmp;
>  
>  	/* Move all tasks to the default resource group */
> -	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
> +	rdt_move_group_tasks(NULL, &rdtgroup_default);
>  
>  	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
>  		/* Free any child rmids */
> @@ -3099,23 +3087,19 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
>  	return -EPERM;
>  }
>  
> -static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> +static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp)
>  {
>  	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
>  	int cpu;
>  
>  	/* Give any tasks back to the parent group */
> -	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
> +	rdt_move_group_tasks(rdtgrp, prdtgrp);
>  
>  	/* Update per cpu rmid of the moved CPUs first */
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
>  		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
> -	/*
> -	 * Update the MSR on moved CPUs and CPUs which have moved
> -	 * task running on them.
> -	 */
> -	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> -	update_closid_rmid(tmpmask, NULL);
> +
> +	update_closid_rmid(cpu_online_mask, NULL);
>  
>  	rdtgrp->flags = RDT_DELETED;
>  	free_rmid(rdtgrp->mon.rmid);
> @@ -3140,12 +3124,12 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
>  	return 0;
>  }
>  
> -static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> +static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp)
>  {
>  	int cpu;
>  
>  	/* Give any tasks back to the default group */
> -	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
> +	rdt_move_group_tasks(rdtgrp, &rdtgroup_default);
>  
>  	/* Give any CPUs back to the default group */
>  	cpumask_or(&rdtgroup_default.cpu_mask,
> @@ -3157,12 +3141,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  		per_cpu(pqr_state.default_rmid, cpu) = rdtgroup_default.mon.rmid;
>  	}
>  
> -	/*
> -	 * Update the MSR on moved CPUs and CPUs which have moved
> -	 * task running on them.
> -	 */
> -	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> -	update_closid_rmid(tmpmask, NULL);
> +	update_closid_rmid(cpu_online_mask, NULL);
>  
>  	closid_free(rdtgrp->closid);
>  	free_rmid(rdtgrp->mon.rmid);
> @@ -3181,12 +3160,8 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  {
>  	struct kernfs_node *parent_kn = kn->parent;
>  	struct rdtgroup *rdtgrp;
> -	cpumask_var_t tmpmask;
>  	int ret = 0;
>  
> -	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> -		return -ENOMEM;
> -
>  	rdtgrp = rdtgroup_kn_lock_live(kn);
>  	if (!rdtgrp) {
>  		ret = -EPERM;
> @@ -3206,18 +3181,17 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
>  			ret = rdtgroup_ctrl_remove(rdtgrp);
>  		} else {
> -			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
> +			ret = rdtgroup_rmdir_ctrl(rdtgrp);
>  		}
>  	} else if (rdtgrp->type == RDTMON_GROUP &&
>  		 is_mon_groups(parent_kn, kn->name)) {
> -		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
> +		ret = rdtgroup_rmdir_mon(rdtgrp);
>  	} else {
>  		ret = -EPERM;
>  	}
>  
>  out:
>  	rdtgroup_kn_unlock(kn);
> -	free_cpumask_var(tmpmask);
>  	return ret;
>  }
>  

The fix looks good to me. I do think its motivation and description
needs to improve to make it palatable to folks not familiar with this area.

Reinette
