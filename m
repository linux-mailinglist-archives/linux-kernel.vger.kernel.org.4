Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8457349D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFSB6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSB6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:58:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB39E54;
        Sun, 18 Jun 2023 18:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVJaFEgVhWCAfk2p1ypDncmluYYFEriI8TXQGyflRnac2LEYO0068TZLu1T40lNvVDya9kJen3Z32kDptwVysPcu+3ogq8Bv+xRMsuhDNDCpXbs8C2x2dgtk5BWzuYVcpNbKn/TyLEkty6VePNO9/VMwIoFD0s1iKmekS4a6y3MBBtuu5+mTTO1hr009n71nhTLGz5+TEGK+JNQ+uiy2to8SuYDb6BFcLn7cyYjZLrdHF1BNGEvwjjxbJGafAb1c9FQbypBL40bYgN2EUEu7LNDUuOuIiY2O0XPepWUc6cyNeT4lb1Auy7rq/keTO0DujmFVAM1v2Z40ougu+PTSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJte0v8AFYSeVrYT6Rv9dyWuU5leuflKnZbQBkuGLyg=;
 b=TKcWL9NLefRPO+cTo7UawjuPBVzUtJeHmtaGEDaowT0aX68ee98l81G54ow9QmRTB+Okh6jnOay+xkpy7fmnnpe2RbatIGmy1rfAujkYpfWlMtfwUKIhqP7S77PvUG/N6qZw3slNuP15iqPk8t193wnLg3QXrwemlVqn8bFavP7MQZE9CpB4hokaZDPqcqLkLdddrlPprY8zySrzCpgVUIrmeYjL1e4DDAi0kjbkhAiHR7uCm948L/ub1eoShHSmJg5VOzud19zIz1SuArAoXIXn4ijTvjNLDlVZGIZ2ahpZtkjQmZnh2HntksjiOV12twFTok56FDdWpXuv3huayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJte0v8AFYSeVrYT6Rv9dyWuU5leuflKnZbQBkuGLyg=;
 b=pPAbPjiibaccZsXprRIGInbQhvxFVQwadQpcrxbgJywg6FY69MRbRnZxpZf2TD9x74CiOOlhO/n3k1hq5yDx7LtHtRLqwxRpZj5uehXQJ3kDDEl2LWZJNf/lLESyXxc2URjzS6SgmNnK+Hhzyqa85LmCb960XucN9YCOqDMiq3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 01:58:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 01:58:34 +0000
Message-ID: <d155a305-2d57-a76a-0860-71c3a5c99624@amd.com>
Date:   Sun, 18 Jun 2023 20:58:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/5] cpupower: Add is_valid_path API
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com, Ray.Huang@amd.com,
        Perry.Yuan@amd.com
References: <20230616120620.147643-1-wyes.karny@amd.com>
 <20230616120620.147643-3-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230616120620.147643-3-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:20::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 02adcb45-fe2f-40c1-283d-08db7068b084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XFSaj12wY0EYLz3T2hCUlwAj9/i40lb3Te/9A2nQsbtdpAG4Qr/DPseyPZ7eBo6dbY5jYkHBqF9BtsmHtDsOw3HJVqWI03tEqFVIJze+82CEcf/+xF8klf6BAlTzctsEWIlYrT6WwstpmSXnL9DvRG0sQOQWLIuq89Fp78ul52UFFxyttVmZLkAiqmub+09amnOsRHHEHzmvBHBWYGzWi7IfcbHOh39He1pHc7u/DC+LH6J54Wqpsh5OwrDzm82RJjBZArijBDUgWGbn3U3dltLAgKAPE8Hip93A1INtvq1ol9WQThak73dJGKymqZAItp1/ab6ilZHAnKi5pbNBaSksS5neZfx65mzR4hORoMEG/v/bDrfyx8xwV7u0nHPOzs1dWK0/oaVZ2EYnUaewuUGXhCn68WP/2r52NUhV5lqfk09LHPgNScjSLDm5C76f+mJ988G6/XCDfy8dLHvF4bybhp2QWYfbrxQgf7aIRB/VLsZfkCbtU6be0mnG9cfpqotzINVoOEMTVl25DScEzPYTKb8tkms+On1Er84zSl18QyrT8B+jWzDew5bPk7A6crmz+DNyrC29NBheP+G0MjkBMO0nudmzVm3KrcWKU5m7k3GU47iRfrSY3qFVppHMGI9cjwGWYWsCKbXmm7WJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(478600001)(66946007)(31686004)(66556008)(66476007)(36756003)(8676002)(4326008)(41300700001)(2616005)(38100700002)(83380400001)(31696002)(44832011)(6486002)(86362001)(2906002)(5660300002)(6666004)(316002)(8936002)(6506007)(53546011)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlVjWGErL2loNkFMVmVXMmNrcDBnV1RjQzkzYmwydkU1SUt1MjJpWFJhcjd2?=
 =?utf-8?B?WHVybkxnNEh5VkU5QnU0dmU4czVYY3FTb1dUVDhnUm4waFpTdkp6Ymp0YXJU?=
 =?utf-8?B?ckU0bVppc1MxVUM1cGpzVVltUlA1UlRXWHBJSWdGM1NIZnI3bUhQRkR6TnBr?=
 =?utf-8?B?UlNrc2tvaTdqQVZqTk9QTyt2WUpGRmJkZE5FenJGVU1DbFR0blRidTk5cjhU?=
 =?utf-8?B?dFRwTTZsKzl3RWcvWjM5UWdKcEJlNkEzbjI4QlVuYWViU3k2ZkFYOFRXeVJZ?=
 =?utf-8?B?OUFwaEltalJqODJ2RE1pMXVLa3htWU40SGUzQlhqRTdyMytnNXV2RWhOdzl2?=
 =?utf-8?B?LzNEdUZlVXozLy9iZklzTlNkZ0lRRE8wdXBOS0x3b2I3dzhxbG1FRlN2aTNE?=
 =?utf-8?B?OXovT2VVc05yVEgwWFFSaS9CMnB6WFUwblFSSVdKODdQdmJvUkxKck15Q1VZ?=
 =?utf-8?B?Yy92KzhHZER6RTJLamdnRWxCN2x0Sk5Bbis3bzNBMXVndmxEMWpPcDJNV3ZG?=
 =?utf-8?B?Q2xSd1B2VmNSdTlrY2J5VnBmbm5OVCtUby9oSFMzTWFCQUZZZ0xERVRLcDRo?=
 =?utf-8?B?dW1GVm1LRzRpQjgrYjRiR1VkLzhRRWNrRUIxNFUyS0ZMSlJQb2ZmQmxHMHBY?=
 =?utf-8?B?a2pXcjBUZDNhemRVOXU1R3hCQ0ZWSzNiTFJzVDNrekc1aTFjdHc3UVVxWmFP?=
 =?utf-8?B?OGl0bWhRK1hZM3FDTTZkRzJzSUt2STdnZ2xkdDRhMTVWV05vRFUranRKdDUr?=
 =?utf-8?B?MTVZY0s3VWVCOStKK3VYMnJ5M3BFU3c2bmRYanBManV1V29LSnFoQUo5UEJW?=
 =?utf-8?B?NDIyYjhzUlNQc3B5ZFV0VFN4SXVJZXlPRitHMHRWdTJ5Y0pnS0wrTXNVYnEx?=
 =?utf-8?B?SWVDMG1yWXAyZytBYTV0MTdxc0pmNUpDa3dvVUNhekJaR2ZJTGltVFRQQW9p?=
 =?utf-8?B?aFh6djJZTDdCK2kybkRnaDgrZjRBWDg2bFJDa2RhVGVDdkhBMmwxM3cwWGtO?=
 =?utf-8?B?S2lmdUV2UUQwbURBQ3gvQUpOMyswZ0hLY0JRMng3UXRSVW1ZMVNJUGwrOG1K?=
 =?utf-8?B?SFZ3b2dwOHRQbjZNaDdOYldRbmN0dWgyY3NPOFZ5dVNoK1R1SUF1K1AybmM5?=
 =?utf-8?B?bnFRT1l4SEtqamZuaEZBdUg5R2twdGVveHdMeFdnNGc5bkhkNGF3OHhxNTUy?=
 =?utf-8?B?N2FPcDVEekFiZ2puSU5UNWVpMzZMdkhZOWVSazBqSEJ1dU1IZUh0aHoxZ0V2?=
 =?utf-8?B?SDE5N0pZNHkxamFleDMxRUNpUXBJUDFlMFlDL1Y4K3loUzF1UHVhQ3lrcjFZ?=
 =?utf-8?B?MVR0RU9EWHF4V25NYk5DTEU0S01XL1BMOXN6czB4cnFIRmZUS041OVRFSzNF?=
 =?utf-8?B?MEJ5S1JjWHZYVzU0Vmx4YTdJRTZkTGtkT3NVSjBRT3FGMFRRbHliVGoybyts?=
 =?utf-8?B?cG5QSWovbUtYdDVJRlkyNXFQQWRSVG5qVWVrSG9XMHM1eHU4dXhQWURraHVU?=
 =?utf-8?B?Y2VsMHRBUTlhUHV2bDdZZ3lVaTl3Q1pNSzlBdXl6TU1RS0ZwOVl2ZXVpUjZ6?=
 =?utf-8?B?bkMrTG9IYU1vSmUvWklPeTV3SEhnMlNGdGY5bHZwOC9pd3N0emNSRDQ3OWI3?=
 =?utf-8?B?aTNSbTMzLzZXcmdOVThPM3dxOVBiVEpkaEVLdTRIVk9Ldi9HWFE0cHQzVkNO?=
 =?utf-8?B?M29BVEhRZzMwYnczTkJkRE9HWWZQTi9uUnB2NWJZYzZmNVRDbGNJZXZOY0p1?=
 =?utf-8?B?bTkvaXJ4Mll1aks1Rmg3a1RzN2FYMkIyZC9kUjl1eXZMdTZSaEN6U0F4cDRX?=
 =?utf-8?B?MWwzVFc5cmw3NXhya1AzMDQ0UXZKNmFvNng0MjI2Z3doZVlLUDVvaUJVenJR?=
 =?utf-8?B?T1M2d2NmeGljbUlUWm8xM1RhQ29IUHlqSWhzaE00ZlpjWGFocGhrKy81ODk4?=
 =?utf-8?B?N2U5eThrakRZQjA1QlZNbmxKS3k3U2NtOG0vdnhlZC9uczVydE9yNEZ2M1NY?=
 =?utf-8?B?Q0dWQXdSOElUNUZvZkFlNXBxVkxGMGp4bm96ZGx1MGk0d1pnVXhaOVlUTVZz?=
 =?utf-8?B?d0tNZWthUndPZGRndDQ3citUN0NQdDJVWGR3SzFCWlNzKzhwVEUrKzlleUxF?=
 =?utf-8?B?eU42LzNQUzFVNFJzUHVUNkt2YTlLRVhJTUlOM2h6V2RVWU9Da0d0a1dDL3Rn?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02adcb45-fe2f-40c1-283d-08db7068b084
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 01:58:34.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdFpUtW2Wl9MFrGAKVt1F6GuSxpTUQtUHC86raG/NmqZo291FDI0fY36mUK5ZSBSbksQbO/W401D8HF/fwsA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 07:06, Wyes Karny wrote:
> Add is_valid_path API to check whether the sysfs file is present or not.
> 
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   tools/power/cpupower/lib/cpupower.c        | 7 +++++++
>   tools/power/cpupower/lib/cpupower_intern.h | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
> index 3f7d0c0c5067..7a2ef691b20e 100644
> --- a/tools/power/cpupower/lib/cpupower.c
> +++ b/tools/power/cpupower/lib/cpupower.c
> @@ -14,6 +14,13 @@
>   #include "cpupower.h"
>   #include "cpupower_intern.h"
>   
> +int is_valid_path(const char *path)
> +{
> +	if (access(path, F_OK) == -1)
> +		return 0;
> +	return 1;
> +}
> +
>   unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
>   {
>   	ssize_t numread;
> diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
> index ac1112b956ec..5fdb8620d41b 100644
> --- a/tools/power/cpupower/lib/cpupower_intern.h
> +++ b/tools/power/cpupower/lib/cpupower_intern.h
> @@ -7,5 +7,6 @@
>   
>   #define SYSFS_PATH_MAX 255
>   
> +int is_valid_path(const char *path);
>   unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);
>   unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen);

