Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87B65CAD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbjADA34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbjADA3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:29:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFB2DEB;
        Tue,  3 Jan 2023 16:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOUvKu3XIadQKr7qcTnpVQNtmGy9KYVcghnfjEZZGpwoiD7rNl2OY4B2w7VeRf2P7HcmVfQ9IYUulFAe+/o2QdAM8XPKTkp+WB+PP4LJD3gqn+M5m+kBXYAryXROGShzeuDs7mLfIRE3lXLkMGRqip936cA2GZxDOUDZZTszFArM4uVVsQAsTbcDLUk+mr0vHxqVLYh8nrIyn5yCpTTFsBT1Qv7vZwxVG9xz+Ryc58Q86SvwyuiTBR2OZ9SBdERHlC7Y56HOMGbXBREtCjzgmxM0GZr0/xVRbvJTm5u3nhAqigfz+xLSkOr9GHiKWXV9LKoZbC+e5s+hjPcWDhEzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4LUYPcNnyTMftopklVIc/EQdKUU2juku2IDINLzD0I=;
 b=AB0qP4zF+17bLHtmfdr3PtFIdU2WEM5UCNqbqZ+0JbKCih4NA46mf7S2ac9BmMIUzCKNEbl50vZEqieiCSOK6l5aUJ0UD3Kh4T9hMwDrX1JIeA7DUoS9zHf6BJpIGjN7F3gIZPrMU4Cv60oFE0ICmi7UYz3ME32J7tgcdBsSiiMmo4xtaC0+NbfVNltwHvGK0FH6g9BPQJ0m+v8bKxmiHoHUT290LAyhCfIv/ULGU+9hoLCCHs4L2fDmh8SI84I6QUox/uUY8JqmSm3f92IXYe+btW9iy3AA95FerMl2FHcdJ4J6F7zbE98tPZ1ZcbxrXzTN3NifXW1MdUPGLugn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4LUYPcNnyTMftopklVIc/EQdKUU2juku2IDINLzD0I=;
 b=sPwnKEO834mtRWo5yfbYzX/XpK/YmgjTQtlUpID9Za0YknW6NiqRbuIL94UpAQui4ryCd7dtgwOaSrwt5Ry/3acmeN3tP3iMShdoPcivBKeCo0wT4Q+Gv6aFbxnFGPJOk/JQMfU2hihEI4nhbxRHOzka3Up9Tl1zqcjfgdVfduA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:29:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:29:17 +0000
Message-ID: <47cfe6c9-4300-1d76-4073-3a4ff50830d8@amd.com>
Date:   Tue, 3 Jan 2023 18:29:14 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 02/13] Documentation: amd-pstate: add EPP profiles
 introduction
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-3-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221225163442.2205660-3-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:91::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfbecc9-00c1-4660-9b85-08daedeab6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lh9T6ZAoMInZaYybjs00ieQhKfSc1cRLZiQpaxZYue0EMLiSXErNMkNNF88ZEEYdchQyOw24GR3OZFzAgZWjsRn7fsqSydU8XABmRAQwoyFaD/aWHzYWVRsNQoolb6SB+iuLJ6DA9n/EEZjHMRlETjiDkufOoLdp6q2npoYp+b3SX3a0z6AMkgpZ0S7xrSFNUH/3izR5RktxKQSzRU7J5MZwsD2a1VmlKkeQdwMAlGAWULnjwCOrFNz1WgU5h+doLY6ziIWJ9lomtDVA0Q+WLwn2Zq3yQ3TJvaDW5NpNB2esi+YCtlHy3mYlck7IEnih+9Mt7aIxV8UvmDHiodHzaFiUWDWJdPzc+/DupbQiaKIhfw0qWO+qJUXNcNEd6WFIQlUbGyEdOTVh6umEWk6jUNlK1z/Io5220W4qMlwB4r41cv1es/L0wvF9DxkOMruiWq+LBiT7po0WYE5S8ygyx+x3NlCslo9PnMUrsCuBPujt+zgVnHLEg4Vjk/Gbq8WowmGRfJFpMkfBQzqJwI9ZrNY1xGEnhW3tu6/bTv6fCnF3LUMQjppI36M5o0FReKech6eSgOtJPNPEy//j/2I8PIuhW/jzcXA8tx8nc6QURY2r6qCxKZVJtyDJb5yaOCr0owG4ojhRsBf2C/jFGBjqf6icdCP+ZLa12aoaHc/iIESSsNL2QONjxdMxC6cvrB0qxt18/F/v2WAqPsX0eddv5xyuokp2dcu6ZV0y+jlueAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36756003)(2906002)(38100700002)(8936002)(5660300002)(41300700001)(83380400001)(86362001)(31696002)(66556008)(31686004)(6486002)(66946007)(6506007)(53546011)(66476007)(478600001)(6666004)(8676002)(4326008)(2616005)(6512007)(186003)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pHWXVFOWtCc0l5TTlvMnZURjhKTllqY0I1WkN1V0hTd2pMbklYYVFKREsw?=
 =?utf-8?B?K0Y5ZDdRbjNJMHpvN0hBSWpQRGRRQllBaDEvVUtSOFQzeWN3b1BYWW9qQklS?=
 =?utf-8?B?S2tlQnl4cHczRjJVbVBKeTVPSzIyYmJYMDFzVk5yWWxWY1J1OUExN011NUVV?=
 =?utf-8?B?ZS9JOE8xTUFFbU5RSkZmRlJ6TUROSGQ1N0FibXhZOXpGYXRGTzFUY3lRK0dv?=
 =?utf-8?B?eGxIbTFhZlgzYzJpM0ZJamtFNHZRbHZIdThpaytzUnJwMkhKcHNrMkU3dFNp?=
 =?utf-8?B?WjQ2amFTZVZ1anY1TkJoRFFqSXRMYzVCVE5HZGFBYng0NlIxYUNhRkVWRGhm?=
 =?utf-8?B?bVN4Y2NwK0pESWRNOXEveEZHVHZKaXN0NDc3MThoakZ4alV0MGJtTy8vbGpD?=
 =?utf-8?B?UzVybDdBelNOYmVBNS82TnZ4cGNYWjRnM1Q5RDAzeHhnSjYwNFpjUzAxWXNa?=
 =?utf-8?B?ZW03SVBxenQ0WUY3c2hEd0dDOEhBUkhiYmVBYXdWL21YUmM2UWxtVlBlZzBE?=
 =?utf-8?B?VHVZcGF3a3J2UDJabCs1eVlQeURBZk9MN0FkL2tMRzZSUW5ncm9YNWo5Q0Na?=
 =?utf-8?B?bVNpMklSRCsyWE5pSEsrekRBbytYTVF5V1c4Q3NwLytsbDk1a3pJRzZKQUNj?=
 =?utf-8?B?TjhJZzhLZnlRSU9xL3h3azRVclZlQUhSOU5PY0RUNk0wZXMvUTdmdXpVdG5E?=
 =?utf-8?B?ZE01UW55MjhoT2RYY3lHU0xlNkU4bEFEQm80L2RMVGJZWm5POFoyR3ZmVVJX?=
 =?utf-8?B?b3Y2R0VVSkZyMmp1N3FPMDhTaFh2aW5GWXAyQmhFY2U5M0xlRklaYmUvWlF5?=
 =?utf-8?B?WCttTFEvTUc1QnFyUFNYY3ZTT3RZek9zRmJuZGsxTlVRdjdMUFBacWtEaGhR?=
 =?utf-8?B?ZnR3eE5GcWV0WmtMd0V5ZUwvelREVThFbStHL0FDQWo5RktzTFFtYjA1V2ZI?=
 =?utf-8?B?NUs1U2pxWUk1ZnZuVHZKSVhHb3E3TFNFN05aS096cnFEMmVqclJ6Z1dQSHhV?=
 =?utf-8?B?RUt5MXc2OW5EclFXM3FjWlg2ZS8vbmhBUVZpd2M1c3dlRTFzcjRIckU3V21K?=
 =?utf-8?B?RGRVS1p3RVU2SHlzMXorbjN5endNZHBRa3pScnJHeTRabEpieUNWTHhpcWkz?=
 =?utf-8?B?ZkFCdTIvdmV1bHM1WmEwLzdDc3lOZmhNMGtEeTJXT09DN1VLdWkvQkVxY2p6?=
 =?utf-8?B?V0ZSVW5zenhuSFBnUEgrMERncWEzQXo2UVhsV2ZHWU5oKzV2ZHJIYW1xTVY5?=
 =?utf-8?B?MHc4dUxWZjRHV3dPT1F1b0lqaDI5N21iUGVDaEt4NjNoaUFQeTFFOE5XYWow?=
 =?utf-8?B?WGp0ZHJNTzlnRzZZMnhseGw0RWVwdkEreTVqbGM2VTEyNHlBNVp0VXlmWXR1?=
 =?utf-8?B?S1NKZUd6VXJRdExPdVRWOGt5d24xNnhnWnZnK2RHTzhrNC9kT0N6NzRibEdz?=
 =?utf-8?B?QkVUWmRPU2hFMk9GRVlIb1pWc0VVMjdDUVM4cHcramYzWUh5QUFWVWt5akVu?=
 =?utf-8?B?UUpMR0s5cGxJN0ZpdDVRbG96Q0llUmV5N1JXeUNkNGIyZmZmcSswWEFONUp4?=
 =?utf-8?B?dWMzWmRlRlpaYlZsU1JBZmtxaHk3b2pPaVVKeEQxVS9SVzFISngzdXlDUGgr?=
 =?utf-8?B?OUdaeXZ1Y2xXNGNLVnBVdlJzemVhZ0NZSkFGZDV6b2ozV3NHMG93NTJmOEpi?=
 =?utf-8?B?Mlh3a3BtZEVHay9GUGJKSHhmaUFFQXVyczRrRHo1WjAvYmpHVEYvS2Zxbmdm?=
 =?utf-8?B?MmpmL3pSVzZLbHcrSElrSys2dW9TZjVYekE0Um9SRThXUE9GcSs5NHBYNzZp?=
 =?utf-8?B?UXZveFZxOS9PdC96VnoyZkVOeVY0dW1SVHVOZkpaVVZxd0h1b1JjZWx1QWd4?=
 =?utf-8?B?N2lMbm9DV05XMXNmcnc2UFNIMGplYktKN2g0eXI5OFZ4QWRTT2RLTENUNUhk?=
 =?utf-8?B?cUk2K0VtUGhlNm1HKzBPYjVNWmZCbHNrZG1OUkxtSllmK2xseDE4cWR3K0Jn?=
 =?utf-8?B?MGtIc1pkaGRhMjhaQ0MrVytxTGsvUHl1VXVJTFlRYjdwc1hjSm8yQzlmVFQ2?=
 =?utf-8?B?WEtvTEtIYlhGKzJTcXVYdGtkWVd5OXJPMk5NRzlicW5oWklIeEx5RFVGQm1D?=
 =?utf-8?Q?lFAuM/O1tg6QZvJOd9xD+NlX0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfbecc9-00c1-4660-9b85-08daedeab6fa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:29:17.5291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LByxDKnPlRcYW8Z9KuXmxI7XnFSJE8yE8Vip98eKT74BHUyPaWqqfqwJIEDhVb68w3pvz5mO50Nv4Bj41MgdEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/2022 10:34, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The amd-pstate driver supports a feature called energy performance
> preference (EPP). Add information to the documentation to explain
> how users can interact with the sysfs files for this feature.
> 
> 1) See all EPP profiles
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> 2) Check current EPP profile
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
> performance
> 
> 3) Set new EPP profile
> $ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 06e23538f79c..33ab8ec8fc2f 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>   <perf_cap_>`_.)
>   This attribute is read-only.
>   
> +``energy_performance_available_preferences``
> +
> +A list of all the supported EPP preferences that could be used for
> +``energy_performance_preference`` on this system.
> +These profiles represent different hints that are provided
> +to the low-level firmware about the user's desired energy vs efficiency
> +tradeoff.  ``default`` represents the epp value is set by platform
> +firmware. This attribute is read-only.
> +
> +``energy_performance_preference``
> +
> +The current energy performance preference can be read from this attribute.
> +and user can change current preference according to energy or performance needs
> +Please get all support profiles list from
> +``energy_performance_available_preferences`` attribute, all the profiles are
> +integer values defined between 0 to 255 when EPP feature is enabled by platform
> +firmware, if EPP feature is disabled, driver will ignore the written value
> +This attribute is read-write.
> +
>   Other performance and frequency values can be read back from
>   ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>   

