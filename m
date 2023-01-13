Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F8668BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbjAMFwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbjAMFvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:51:07 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89BFB1D3;
        Thu, 12 Jan 2023 21:51:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsJuz7HLehuIeGfSetYzFmsRkXt7iVxBXGyvy/qiS8wvHoKbm9RMUCgkfMuioClI8YPZYIsRTgruGySym0hGPDr+muM2xjZoDCI2n3XFiRrMNzWW8F9vVxxETvneNSxO525awCY0UuZxTt8ia1UXP/xzljSOdNVw9EOjMlAW1EewvCA1Cj86MC4E77dU2RHWh6WuzWyYW63z2EJTLgh1MPmSP1qr9OYzzxTnUOla+cWxEvlahOYaGRx99T/AQ29aiBMLSleBKs4EFGO7f2MpwbrQStJDofk0m3+G0riMKa4WG2lGPkxj+R2xtbfqU1pE5ZNpM0hSBgcNNBBufx/wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiZmqVW63B46866X+0gv8ofWrsU1N1Pw5PxoCq2zaZQ=;
 b=cWAqfaVCvAkjXj8s0h+4VTKLXR8G1m5FxYSNdhTYr5m3m5iMOD/OLQ/uDAf2lNyTARxWpoxDS87kCd8nsUiIMQq9i+Opbp5he6NzV3zHBWw7Xusalm78POB3tOId2YX+xat+iBrMoGatxKT/LPBSnHcb/hOPjQHH1R4BAHoOkgeeKB1jH0OSrg9rztS4wyX0ORJsrTvM4o6C/okFek7clqJjOrUop9xx0YK49Ygrf8/YY6goSV/brJIhpV21tmbjktOMUn6+39JKSBLS6J4UurdDqV8jr+6yTVE8xmYsw1Jr4QPfQngXrghDbb6L5WgKZLAYkxdGCDoL2ewSYCQn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiZmqVW63B46866X+0gv8ofWrsU1N1Pw5PxoCq2zaZQ=;
 b=VJf3OwW+kw6JxBQEyLqTik9TDvMQwocEr9DUMvZJEDktiaRn/hVi/RXXSTsi3iYGqowQAxHZciP67FaSGxW043160fKh9LzUPVolQQUG7/qzBqzfO7T2r4F+jG2x1DzNIZgl3B3IyM+nn37nvs8hlZWtTPWBni8XHLsg5z6QCV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 05:51:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 05:51:02 +0000
Message-ID: <7e4d2d86-ea95-6d4b-1279-18407787306b@amd.com>
Date:   Thu, 12 Jan 2023 23:50:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 6/6] Documentation: amd_pstate: Update amd_pstate
 status sysfs for guided
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-7-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230113052141.2874296-7-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:4:ad::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 561ce29a-09aa-4ece-1189-08daf52a276c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPeu4LXtLZLTvzHVO/N08+S2j67or3PG3gxD1T2rmNAD+Oqmo7sOC2Vih7o92Y74tVzYlyLDE9YNT8APWptY9WvoG2JdOUcNqTmby0zBZLzu+W7fXYzlpifyIILqF0F0z+YjWu83kdIFUF8+oYTkKWd1s6Sq7IJ/3nX8Gaea0EAG/oErZ+4zKov7bXU4L7HPUcsToRnTCi3+bKvutgc5B/1XJw+uqMFq+KO4EL9Y946CWrUiHFJW7rrvHx6wZE1af5ZRwYs52CWIiBOrr4BQL/ObhYvrdttkERoxG8ii5tgYuAhkmQ55qVZ1kZ9Y6hb0VHHbTBH4OOzx3TsxkadOtOcO4UmIHiQrJkMWccKZNaKDzyRgcUpx5OfV0uGCKNXsHG4kld8yWYpblAE+mMKEZ/lUznXPx899SLZW7m5vdPWUe+8m1IfiahZI4hLTMe76zNW2vtiHU6sVDKo4GiKwX4sQaCfS05+tKoFt9WDHIH963hOM2z0KFbwzHiuPAUSpqVueJ742QkTEVPOYUWzA7Lt/PQuHP7deMsQe40c+d9/WlUhpzjzXDDM/2227caLD2gNWPqYqOkTttICvLSCWprAfT5Wj6zH2XXlffA8EFTAt01gY3VG9yBNuf1LoNQTwE7ReDPn4rFah0qevGdIPCQBrEqRw55DGfxwBb1VYH9fNhqxF/jlNqIe5ocSAfOD7MsGYsSozw4M0S4kgEr5gMxhwPsuyDuIJjVdAKxFcxAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(2906002)(31686004)(44832011)(41300700001)(8936002)(15650500001)(66476007)(4326008)(8676002)(66556008)(66946007)(6636002)(316002)(110136005)(478600001)(6486002)(38100700002)(186003)(53546011)(6512007)(6666004)(36756003)(6506007)(5660300002)(86362001)(31696002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBUT2hHbWdMNzJBQjhTRXpaM1dnZzlDemo2bUZVdWlpOHlZblV6bUdScGM3?=
 =?utf-8?B?MkFIZ1FCSVJ2RGZQVG9OQ3kxVnZubEJNNnhYb1ZJMHZMTytZWEZ3c04wMFRu?=
 =?utf-8?B?V0JSUHdWTCtxTDVsRzI0QVBTWWFvN2VkdFJITmw1NGNzbnY3anNNeCtlRTBk?=
 =?utf-8?B?Ny9tMGpMaHVDeDVCcGFYazgvaHBRN2UrZnQ0a3hRVzBuaDRZMVdFdDVWMW8r?=
 =?utf-8?B?ZWJ5QWZhampFMmFLRThmS1U0RmJRMitxcU5IelNIbW53eGsvZVNZODVmSm50?=
 =?utf-8?B?SDFUK2c1akVnZG5TN2JQNnhZd0hWMnFWSFFBaktzTVQ0ZUlDdHl6VG14Q2I5?=
 =?utf-8?B?ZUhwSzIrbWgxczZ0ODliRWcwc01Qais0TXNhUlM5bDRBSnFEem1ieW50N1Er?=
 =?utf-8?B?KzZhV0pPZ29hb1lEa0JZQS9Cb1RGY0tOTmdid21VbnFHZDRHTkpJWUh1djRB?=
 =?utf-8?B?TDVGUjhieUFma2tJenhZVnlKRXJFaTVZMk5ZVG8va2JuVC9jN3orcEJiMlB1?=
 =?utf-8?B?N09WemlKeVlhZ2hrNWtKTHp1Z3hiZ0hXR2tqMHR5UjhtWm5iUVB5dTF2UU1C?=
 =?utf-8?B?bzZHa1VPQTJHNitpNW91OTBybXhSNGpwcUU3L1JwYlQrTi9Gc2VqRjdxODM2?=
 =?utf-8?B?VVgxVU5jNEFLOVR4OW5SMmdZS0wwTCtCMjBVVmdPTWY3MkNSY1Avd0pVVDVG?=
 =?utf-8?B?VTE1UStvellJWGJRcXYwRnN6UHdnMmdVMGxLcTlodndpRTdZM0pFVlUxYUZR?=
 =?utf-8?B?ZHNUNU5xY3JrSWwxdWJOTk1YWjZyZnNRR2ZiZ3VVNnl4TW5uRG9YcnY2ZElO?=
 =?utf-8?B?SEFNVEFnRFJEbkhDZGEwWVNzL3dJdEZ1YWZxaHhtbitVWkplTGJuUGJ1Wnk3?=
 =?utf-8?B?YW5lejJHdGphNlNNSmdvQU0zM3lVbzBITGVySmdtZ2FtTkJJRXFWNDJPTml1?=
 =?utf-8?B?cEx4WUh6cEpjT21vdG9IQSsvWWliQU1qTjl2Rzh3eHFuRmk1NXl1a2k2dFBD?=
 =?utf-8?B?cS9Nd0VLMDdSeVZhMGEraHZ4dC9pRnpMcGNrZ09mOHhpTENpLytjY0tOOGZ3?=
 =?utf-8?B?Y2pDbUxGQXBGSjM1c2xwZldSSzZiZldhSVRNdFkrRmFPNW5rVjF2UVRJcUZy?=
 =?utf-8?B?SlYrL3ZaS3NRbHJDaXlvMEU1VW5MWDBXdXFTK3lyUnlMMDArTFhxQ3pWNXA5?=
 =?utf-8?B?SVNMUmVJTENkRlJMOXFzMGVJSE9pQW5venR3cVhDYi85dnBJQ2x5UmZaUkxw?=
 =?utf-8?B?N3hvZm1TSXlCRWppcWgzUlNwcmVqZStNVmxzTnFnd1p3VXRHbkE3RDhDM3o4?=
 =?utf-8?B?Q3NDSi9iWTdtM2ZCa1pWQXFTUXJUbW96d3ZPU3U5eWpGdWtzc0tZbTFNeHpY?=
 =?utf-8?B?YS8xV2Jjem1FU3F6bWoxQndUNFEwalVZVFV6ZzltbEFoeS9QMnBlSDR4RlVP?=
 =?utf-8?B?S2FoVmFnSjdTUDlTUTdYSWEvRXpORnp3K0lVeUZUUzU4S2h6RzUwc0Zjd3VR?=
 =?utf-8?B?VjQ1WEF5RGhzbmxxVG50V0dVVXFiMDFlNmNMM1VVb01xM1dObWJpdTgyRkZh?=
 =?utf-8?B?YUJSM1IwRWVxU0VmdkE1Nmxnb3lXOGUxT01nYW1hTTlHT3YyS0ZCdnZWdncr?=
 =?utf-8?B?Vlo2R2lSL1JkQ2ZreUw1TVhEMlhnYlp5bllldjNldUNhUHltZ0xnUmpWci9n?=
 =?utf-8?B?RGp4cnJOK2hwY3p1Qk9QNG4yK1ZYeHMxcDNVcFpUeFo4WmtWaEtJMnl6SDRK?=
 =?utf-8?B?S3QyVVhEMy9vZDM1SFlUTVI0R3k1bEpOS0pXWDJIZEpzeDJXaFIzWEV2ZytP?=
 =?utf-8?B?RUVFc0tPY3pUbzBvVG1xRDNrc29EVmVZU3NmRVI0NTFEN0h4eitFU0pxNnBW?=
 =?utf-8?B?VVhzYmkzUm9iSlRsZXZWNW0xdWVOaHllaVZkV1Qwb3I2RW5VVGROdDFWUFl1?=
 =?utf-8?B?YXlrZmJFVVQ4OXlURnoxZm9jOEh2eDRmUkZIRmhhMkZvK3k3dUp1bXh1QXVw?=
 =?utf-8?B?VEZyQk5EN2VmRnJUODQrOThqd2ErNDBQRTk2VnpYa1ZBSlpHZ3ZkMlFrYkNt?=
 =?utf-8?B?ZVNEdnpyQk5vNGIwczlTQnR0ZU1LU3YrUktmMFRHS2xoNGFGZmNKaGlBUFVX?=
 =?utf-8?B?NkRDejVDTm5VdUZWY1U5VzN3WUxnWE04SVY1cVBjV0tGZ0VJNHNjZVg2SGN3?=
 =?utf-8?Q?CEBun3IagyDengR73I1KgSRxDulboDMznGJWd+tL11NN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561ce29a-09aa-4ece-1189-08daf52a276c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:51:02.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lW8AQD1/W1JfuLCwAOLmFLSry/7Gz6/Ku2EXV9v27M+kN3FyxdkZNMLjlj6/IVj4KQ5V2tFCvaqFEmB4eeQO6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 23:21, Wyes Karny wrote:
> Update amd_pstate status sysfs for guided mode.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 29 ++++++++++++++++-----
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 55396981266a..92fa22e45a2b 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -303,13 +303,16 @@ efficiency frequency management method on AMD processors.
>   AMD Pstate Driver Operation Modes
>   =================================
>   
> -``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
> -CPPC non-autonomous(passive) mode.
> -active mode and passive mode can be chosen by different kernel parameters.
> -When in Autonomous mode, CPPC ignores requests done in the Desired Performance
> -Target register and takes into account only the values set to the Minimum requested
> -performance, Maximum requested performance, and Energy Performance Preference
> -registers. When Autonomous is disabled, it only considers the Desired Performance Target.
> +``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode, guided
> +autonomous (guided) mode and non-autonomous (passive) mode.
> +Active/passive/guided mode can be chosen by different kernel parameters. In
> +autonomous mode, platform ignores the desired performance level request and
> +takes into account only the values set to the Minimum requested performance,
> +Maximum requested performance and Energy Performance Preference registers. In
> +non-autonomous mode, platform gets desired performance level from OS directly
> +through Desired Performance Register. In guided-autonomous mode, platform sets
> +operating performance level autonomously according to the current workload and
> +within the limits set by OS through min and max performance registers.

Your intro and explanation go in different orders.  Also this reads very 
dense.  Maybe it would make sense to put some whitespace between each mode?

>   
>   Active Mode
>   ------------
> @@ -338,6 +341,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
>   processor must provide at least nominal performance requested and go higher if current
>   operating conditions allow.
>   
> +Guided Mode
> +-----------
> +
> +``amd_pstate=guided``
> +
> +If ``amd_pstate=guided`` is passed to kernel command line option then this mode
> +is activated.  In this mode, driver requests minimum and maximum performance
> +level and the platform autonomously selects a performance level in this range
> +and appropriate to the current workload.
>   
>   User Space Interface in ``sysfs``
>   =================================
> @@ -358,6 +370,9 @@ control its functionality at the system level.  They are located in the
>   	"passive"
>   		The driver is functional and in the ``passive mode``
>   
> +        "guided"
> +                The driver is functional and in the ``guided mode``
> +
>   	"disable"
>   		The driver is unregistered and not functional now.
>   

