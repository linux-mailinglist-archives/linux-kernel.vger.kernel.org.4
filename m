Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32401688B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjBBXsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjBBXs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:48:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2786A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381708; x=1706917708;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tBncyPH8bD5a+GujyRuZz/lqKeOmaD9l/VLnfJTwcg8=;
  b=m3DHidJX+jPaYbnXhQ0F9WML44LSWqxjPuQitvovy3G1obLfy1Lfa+xy
   zVIiwJMj/Ww5gRKxuIYzJjs560rKxj8FFoyYoOUvXr0Z+DG4bMC9EJyfK
   KSdmhTRQOayCjeEkhRqYn3g3+OpqxhmAw9cKbgYvFcJ/5ievbyf8sFwig
   PRzsgnThuTgId/pwhFZAju1McUOYGGT+b81+7rUz3/KjRy41PH/UpzOva
   QZgZA7usuXw9XEFP4zE91mjFTsL/5exwXTf0doHx8u81bdNRPeHAqmcRv
   ZbzcAmBuYSxMrm5lB6DJJAneo30T5oVCW6nnvwPqrt2MOqEzNHM56sABn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="326302730"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="326302730"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="808123959"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="808123959"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2023 15:48:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:48:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:48:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:48:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:48:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT7NPfYFNuExmYnc2lynerQCagcnXOuBH5lVNuflfHwkzQZXmv/29Hd5098waMHGRU+cGBNYKjTCce61GTppp+gCcaobicu8C0FH+xcKKA9dIDsgTfWxpYjEtQim0paLaoOCtt8YLCfcfMqDeh0/ymlooYlp2gSZzxmMSK2qwdfDl118GH1p/FXz2s4qoE6T5IkUBNREuCJBrQYxxJs4azB6gT5YAbqNs0shO6CSBzLdSqng6vCVsJd8ZXFsDVnbhDfxQzEJHlwlSZrDwD3iPjUyDWLlqDaFw8evLnN8hxdbfCDJBidqfbp46wD/Qaq3cSKKaaHk7t6A5Y7JQjLZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh3pr+NoV8DWrI+7U1YpfkjmlkmrNjGoG5eGs0o90/4=;
 b=GgRR/xdTxhRfMwuXZGtKAtMD82yScUIe1/WcdKvLKiY4G8ZJjr2hSsbL5SeYXrR6z3Q7z7lJ+XeUr4E+4UBzp4cv5gH7qnZcHLUoNrMOY+3gg5XPri9KteNwuESQdhtzBpcJtukK/nWC8Elm3t5zOtGUfExam2iAww4s1pIUoJ5dXN7cNqkaZ9FmAkO3cI3CyEhMZmsUyfcjNvsYhYKv3ScPlpJDmjsnbe97szaAxHo8tVSfyGvUEpDLFRJiWw5M4d4DQZubEIapG03Y+zgUC5PobPV/qMp+JK42F1b2ktd2rovLhReSm/oZV3LX+vvV/IwuOFFjhC2MqBN1R9G0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 23:48:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:48:24 +0000
Message-ID: <b8b6cab4-ca7a-6314-7f5a-592440ea3f07@intel.com>
Date:   Thu, 2 Feb 2023 15:48:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 13/18] x86/resctrl: Make rdt_enable_key the arch's
 decision to switch
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
 <20230113175459.14825-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 204adaab-336d-4738-e67e-08db0577f905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gfnZtJJoZoPkkY6nyRqWB9vV6Ck+jPN2dMecsGltRTSk9+GcUDjoxsQ/CNP07ybvexqMdey+KEe0fSojuJeTJ1e1FSYZLn4EFII26mn8MW/u564xsupdUNts5EOBsYhJiJPPfFOSgQyXkmu3UECdNj7TshStDZmUVjR2L6snF50dRVZVE5t6uVMANBpThxJTo3OEYK+If1s6HijzC3QP+GOyxM71UeD3VekbTc7AbQUazSR69XQ3kQxztLCOMGUUKiSd1gz4Ox8OUqA3xPlS/P696ARY+Nk/cUawtt0bXbCuCljnjWt+6xhjiD/FrxN1xipX2KKQyndkIU7uMt7aUTYl/BmRVGU0g7o1OxgxGBg7+Cfcarp1XRrmve7NmuuZJRSLBMGq2bcG8EcpcxbOaWV1+WD8bTSFOzytf+XHZOA1P3+uiTaHCvLxzsB1HPIWS5SnCg4CaDJH04MYxIz+b4WnAuxmBg6PsnjuQ4ZXiRMu5Xkg4hmutLILpCRqzG8lCI+5WJzucSNbtqz83rjrPtyjEkaL2b20ejYLWeo1sZqyWNdk4O0G2kasngsYayAxGCg7DOE6F9vrN6ZbaErhopCnGVgFpP2eGEVefsZnRhLoiUiFgnViiVFwvNcRfPMzavB02d8VRNmiK/TxlshJdnVS8p7R9pVk1HwD2+MRBp6XekY26yAWFub9TUG1c6HrctQW9y5xpL9mfLcoJ3oFM+qFEF37dCoikQUbTqEfuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(36756003)(86362001)(31696002)(316002)(82960400001)(41300700001)(66556008)(54906003)(26005)(478600001)(38100700002)(6506007)(6666004)(53546011)(2616005)(8936002)(6512007)(186003)(66946007)(8676002)(44832011)(4744005)(5660300002)(4326008)(2906002)(31686004)(7416002)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhiU1JXZUhldy9jdGcva0F4KzV2K2JsNlN6dnZhSTl1aXdqRUlYMXZ2cHlK?=
 =?utf-8?B?N2UvQk5ITmFSeVF5dC8wSHpWS01RQndEcTcweU1ueTdUa0RSL2UxRXdndFpU?=
 =?utf-8?B?TVh5UyttVmhyWDdHV2JWNHJ5YlRUd0tKeTBJOG1EY0FVYmMxTXZUaHFJMHEw?=
 =?utf-8?B?ZFZ1enA4bXlvOGQyejZTR29QbkdEam12Y3M2Nm41MC9xRzd6TWxiZjVmTm5j?=
 =?utf-8?B?eE1FSU5neFRLTUE2QXB3N0krbm1EQ1ZMU0tUZi9mVll5VVJyRlN4YTlMNS9B?=
 =?utf-8?B?RW5iUTlvNzNKOStqMHJJdlM1dTlZdDdLSFhING5aVUxHUFlhYXdVUlQ2dmJH?=
 =?utf-8?B?cnhTVTd0RUlSMW9vUUs3QlBOYTNjeWxqYkdkSUNXUzFuUkxJK2VLVWw4ejNl?=
 =?utf-8?B?d1pqYXRoeUQ4OS94dWh0RHN2Y1hCWWRmc21HOS9zVlZJRmh1dlJrdEVkcVpm?=
 =?utf-8?B?Q0dERlFhUFVPalkxNGlYeE9mQVlHNi8xc0s5aE5ocHl5T3hLRkJKK0U1VEM1?=
 =?utf-8?B?Rjh5QlI1SGdxS04wd3IrUzh3QXNwazhGZ0IyeEhvdUpWbWlQYU9La2FZTmk2?=
 =?utf-8?B?WnBjUFFvM0taM0lJN2JlSjZHbk5QcDYwVUtvaUlER1p6TVh4dU4yeUlDa3Rk?=
 =?utf-8?B?RDZzSmdoZDFRVmRGMDJDN3VxNVpIY3lyamhVQUpiVmhkSDNlQjg5azN1Um9G?=
 =?utf-8?B?VzBQbGc4ZVhGUitDOEhxVklVODBBcUdxdEh3N0pqcWthVnp5UjlYUzUwQ2dj?=
 =?utf-8?B?U00zM1ZhNUFlb1B4ZXY1NU9lZ0tIcG5YWWxKeGEvVjR4WlpQK0p4UTl6Q2RY?=
 =?utf-8?B?bzhmdVdnY21KdUFTK3c1V3p3dkl2UDd2alB1STlINzlveDZUYWd3QXpzOGdT?=
 =?utf-8?B?QXpOMG8yME9FR2dWYWlpWm54eU1HYnRNZlVaaGQ1NEF5cEd2YzFCZkZpSFo1?=
 =?utf-8?B?ajVFcGJLTHdhTUtqandkZnFpZk5aMHN6VFZHbTNiQXFURVZHbkJsb2ZjQm1C?=
 =?utf-8?B?d3BtVkllYmNDQWR6NUc3Zm9OczJlNkJkTmxYbUl4VkpzYllVS0djK014RUFZ?=
 =?utf-8?B?SW0wZ2w1UVFHZzltMjhpWGdsZTVtaHpvcHdQWjJEZ2h1WXJmRlVoNStndEt0?=
 =?utf-8?B?MEtseVZFcHhoQmsrMUF0Nkcwc2gyVndqakduN1BlOVhiRFZYejNLTmFUaHRZ?=
 =?utf-8?B?OWFnUTdERUhQNnkzdWlxdWdTK0UwZjNmckNXVXJQSkt0SUJzVUVac0YzeUt1?=
 =?utf-8?B?Q0dtUHNBVzhjeGh0cENJeGVRV2EvVU5HVmhtOWgvc3ZuYnVhU2haNnYzOE5K?=
 =?utf-8?B?ak9pWjY0RFRnMi9LYVBHMlJwbEhCdlpIZGpidDBPQkU2VTVPNzhUL1JjWHRT?=
 =?utf-8?B?L2VUQlhScUZUcXUvRGdVSVFqa2grVG9wQVRhQmh1Vk5XVk13OVlrQjhqczli?=
 =?utf-8?B?RkVucG1US1NlalZ0S2V1Ukg2L2FrSkJqRnFjNnRPdmJ4NGFYVER0c0NlSGlN?=
 =?utf-8?B?ZjZ3Sjd5MTcvV1ZScEtZWDc4aS9EMVpwOVlHdjVRL2hHUXQ0dTh2VVhSd3JB?=
 =?utf-8?B?cTlKMU1WM3FTV0thQU5ScFU2TjlCQUlnUU9OUThrRCtwSmN2eHZUUlBxL016?=
 =?utf-8?B?c2YvZU51Z3ZVRnZESU9XdndGRXdHei9BYUJrTWJYSnhsSEdhVkd0L0JsVzFi?=
 =?utf-8?B?SXVZTGVwRXM0RzdKRXdTekJnc1pJb3oyZ3NGWE5yMzRUaVYzY0RJR0s0SFJU?=
 =?utf-8?B?bDNORmk3WU1VK0Ewd3RWOFFjNEpNOGhFVm41dlVmL0RycHUxUi9tbmlJYWhY?=
 =?utf-8?B?U3FwbGJQQ0I5ZzlYdDA1K1RxeWplN2xpMVJEYkt6ZUF4cHd6cnVyTWwvZldY?=
 =?utf-8?B?VDZDUk9TT3I1dWtrNkpROG9xbnNrK3VTa2ptYmY4OTRDaXVjMmJVc2ZKN3Mz?=
 =?utf-8?B?emFqeitCb29YbnBLYzVpOTF0emlSaVFHRThKTHdlWnU5MkdQVHNadDVvYlZZ?=
 =?utf-8?B?NnRUaTZtRWZ1WEl0ZVBSelByT04vUWREK2t2L2RoNE9rSDRsVnVxOVZLaFVj?=
 =?utf-8?B?Y09aRFhMWUx6YW1GamhUVUkzR3N2bmQ0MlVvbHc2bHgyMkhvUkVQc083cTND?=
 =?utf-8?B?RzJMV29DdkFhYW9LTGlGci9JdHhpY0ZLSitVVDhvSVpXZFJiSlNlNVpQOEEz?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 204adaab-336d-4738-e67e-08db0577f905
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:48:24.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmjHj6NwrMDt7FNunN5pM6eb2JQ7IMVpyIdliveHhtVS46VsjcKrqOExPBbiJ1uIwvxdNC+ak2OyEvf5fGXYNQuu1ee/8poXJShlWiXzPbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
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
> rdt_enable_key is switched when resctrl is mounted. It was also previously
> used to prevent a second mount of the filesystem.
> 
> Any other architecture that wants to support resctrl has to provide
> identical static keys.
> 
> Now that we have helpers for enablign and disabling the alloc/mon keys,

Please remove all usage of "we" in changelog and code comments.

enablign -> enabling

Reinette


