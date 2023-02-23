Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537B86A023E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjBWFCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWFCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:02:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23B36685;
        Wed, 22 Feb 2023 21:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcNBqutJM44ixzR4hItr319167BOWyd/MNRdLSMO4INdIUBi1t+M+tFEcjqW1+l2jGfFl0icBAzA2IBPvMO0kpYgSrsaCeSYlX7j3M2mu6OaA3bDmp7Wsz7p3LcEFOKtSgKo6U2hlSdEZEnFAs70jZlAnad6vacaR08N3MYhB0ToSviZ25D4+oNZOUKBbBuwyEYWB/mA0Qct+qQu3dkoMCcfCFmaraXpiZk6w1SSLVYLx2yi23nQnAX2lVRt7bT5rStVwi/y1W3SWzMfxI8c3SELL8xLOP0WCquRx2aOOlx/3oVJ5ZXA0K+z1TtHONWzR/oSq3ZbJys8XZz+oKO3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTF7NJzZO1xvRMZbGVmHXsKNUSsk7eM/gT63TTDszzc=;
 b=eeMfTudCs/ZwehPAVWehy43GMJWCPJ2OUZtw3qnxmq0uhts9mXDt38LOkAw6gRm75UdAyCkImZLP/GSvrOUCQXVmOiUgQ3VFiOCp1mqAZqug9U6DnHJibTxvAKOsi6BYxK70W+XUxwzAQYf8kUictSZb1OomgSxxXannPqRDrjFNii1G9dSBp5MPSGX64qGLn9/sa7JU2R6+04KO3lOhWqqGu7pSwAq8T4GC/mIMybZ+VHQWJxm0STk5x1hZx8tC5/kGMTTc1eaAxscU0fECHkQsX7zt6GN3HeIgDuH/6meDv7Qzdz5EOkBVk99MNwrkiQqDxOgF3w4FkXOJ73wPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTF7NJzZO1xvRMZbGVmHXsKNUSsk7eM/gT63TTDszzc=;
 b=tQN+45HAreI2y1AssdKHJJ3NJLZZGkNmXR4Un9fveI+G/49rRgDY/7XT20SmI3PH182seoTa3auz4bzI9orea4AadU4OVvRfU576bKF61c1QU5T07LR5kRDXEOy8o1t2Mk1Q1KAyHvllw1vAVxNMigPrX+ASHKAqceCmujQJuEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 05:02:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 05:02:08 +0000
Message-ID: <07827f74-0c63-259c-37ff-86905c496b71@amd.com>
Date:   Wed, 22 Feb 2023 23:02:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cpufreq: amd-pstate: Let user know amd-pstate is disabled
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, ray.huang@amd.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223013032.2011601-1-kai.heng.feng@canonical.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230223013032.2011601-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:806:28::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: bf111ecf-94cc-4ffc-b66c-08db155b1d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ger7XM3KVwCmGOa0ZzNGJ5hUntBKdTAmAE3bEkixye/Ef5PRaru/UbOcT+PEzpmMBaCRBciG/R3btQpNhGF0bl9PlJf8EZtwBD6r4NUN2v/jIBRjG9axnmPez2XLV4lH8oECa6jAlr0qunqfd3pcpzJ7457czZx7HfkGwamqD7Gvv5t/tf5ngfR+ttgpwNMpqSVDAtjmc5Hf4X8z3YZdkC2J3BhIDyG5J7FDF3j7/6amvGwz4CZOTLAQVK+OXFaMGW+KFrDFI9VeNpdHtY5lmWKFnfj8580Ih2oqm4uvA2I29xtJYywgZhOV/M1SN4vHU5JtBXADCgA2W+Tibg0GtacC5KgY22M1mpwBfOfDa88zQ8bITcFC+IexmPh1LT2h1YwGnYD47VNmBZmteSho6ZMZssEqjY2MYwDoADJGdxuP3Oxt3AeAKIoUuq4d82dQ9CjWZWG/Xp2gsXPB+losyNEnwlSJ/RzklEM+YruTNuupU1mnxK0Jd9GcDEfDRHXaL1fSkb9u0L/SbdETjqNMdA8CtZk5eKpGCdhdbNOZf50ZKK20DAJRMK0IYfjPSwmwQpITQ/HAJVwReqxe6yqwcsTjWghU9aNml9zIC3f15XZq9HzmR5WKuQq4JE/4aJrX3RBNLUoA1vuAKtNcQyf/shrTZzULwWst94hm2ZsHj80poWn/iKu3rNe7FdhyrAWKM+FmxWzTH5Ivt6WrRZhtasFIt9TMHRvvm6XMIKmmChM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(36756003)(31686004)(44832011)(5660300002)(8936002)(41300700001)(2906002)(83380400001)(66556008)(66946007)(4326008)(66476007)(8676002)(6666004)(316002)(478600001)(6486002)(966005)(186003)(53546011)(6506007)(31696002)(38100700002)(2616005)(86362001)(54906003)(6636002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFJ5VW1JUmg4VmJQendtenpmZWp2eDFjK3BIZW5JKzNWRFVqVUlCbGUvSEFT?=
 =?utf-8?B?NU9BS0lXSHNheDRkT2lwdGg1MkUzdjlKVHlvVUVuS2I1MERJcDVreVpKdjZ1?=
 =?utf-8?B?OXZ5aXlGTGc0Y0VCN2x3eHQ3N0NybHhjM0NkWThnRGNhcGl6a3JSL05Ibzhh?=
 =?utf-8?B?ZlpXcDZQTHFIcktza1Z6emI2OSsrV3JRRE5NN1I1Zzd6MlBLM2xmWmdlWXZ2?=
 =?utf-8?B?RG01eDczVW5lQyt4RTJndDBvYUNMSXBmY2pobVF1blRRVUNTUURaVDYzYWxC?=
 =?utf-8?B?SGFiOHdBQ3F4cmlCWkR2dXVaT2lWY2l6UGpvOHFMMk9ob1NLSXZIYVUrdVp4?=
 =?utf-8?B?VVd4R3pxdS8xY0p4RGUxelhaYkEzd2FjLytlQlJUSEc4MnhjbDhTbjg5UmQy?=
 =?utf-8?B?MzJ4dVVvOFRWMUhoL1MwSlRTQ1R3QkFkYTVmVnFWUGhrN3BGa1Q1SGcrZjd4?=
 =?utf-8?B?SkxwYTVoeG9ESXQzVTRja0N1eENtTFlhWlNCV1dIa1BrcHNua2tNN2dXRkNy?=
 =?utf-8?B?Vjl4VXE4RWZYMVlCZytPSktOemRnQ2U5Y01tMHZua1diL1ZTeXFEaWZUMld2?=
 =?utf-8?B?NlZGampSWGIzL3FLM245UG1kKy9QL0RNcVJnTThnWlREQit6bXpFZVhReC8z?=
 =?utf-8?B?dTRkemZUeU16dHl5NjZFYnZsSVdMZlU1aWM1cThJcHFGTjN2WEt5MFcyS1ZG?=
 =?utf-8?B?ZTBhMzhzNkFCcDRsLzVVZk94SFBhd2pYVEpXdWJQbXlrNDNKY0NNbTRJVVBG?=
 =?utf-8?B?WmJGWlo3bmtvT2NRUXJJelFVNmlVUm9HeHBDS2Z6M0FOd1ZXZ3Rmakg5a0FP?=
 =?utf-8?B?Q2hTeGEybkl4WjVvaTlFcW52V2tkQmxQeExyak8yRFB1WWJrMitMZDdlWisy?=
 =?utf-8?B?SjFWRjRXWmlBaW1GVUk5YVJPeXFpVmRNc04zekhxR0JBWW1scXV1dTJzTE5K?=
 =?utf-8?B?b1ZyK3FuWTVVZTFGYUpBYVJWSWMrdWZaTXgvSnV4VU9sek9HeERnd0JBdjVU?=
 =?utf-8?B?K25XWEhRVlYveW9OZVlUQ2tFTEw3Rk8vQmFLcktWeGxjdHpUcWo0SGt5eGtj?=
 =?utf-8?B?Q1NyQUZ0d1pBbFdreStlQmsrWDErVHBIN3VQN1J0SlREanV5b0F5MDluYXJQ?=
 =?utf-8?B?MVh4K3FhczBDQkZaOUVLNEhPbUNWd3BBV3JobU1vUEVGOTFsTWxUeWIxN0xp?=
 =?utf-8?B?ZUhyQmVYR01kaENSMTRpUlMxWWpaYlVsWHVmTUs5NmhEZDg3ZjdtZ1JybDVv?=
 =?utf-8?B?Sk9sSElSejVSQzJvMHYvYUl2aXdCQ1dHUHNTQlB5VUxXbFJlSVdDdDc0ZE8z?=
 =?utf-8?B?Q00vUXVNeVd3aU5aYmczUjB4Q2lNQjk4dkVtMWRGZFZrVnBZUDJldnFod0xs?=
 =?utf-8?B?bXFBcUFYMmlZMi9kbXN1RjN3aC96Sm9zUkwzM2RRbE42RHVhR0N1UkdIUExQ?=
 =?utf-8?B?bGJteGErYWlxL1VMbTJteXJSNDVlSVFpTVMzM2NRMko5ZWJhaWhtL1hyNUlq?=
 =?utf-8?B?bDFaZlg5cUNhbjEzRFZLL2xkMDBrR29PNlA2T2RjNGxHRWtLZW04REFoa0RZ?=
 =?utf-8?B?cmUwZDg2Q0pFaDlhN2hpL2hjelhaWXY4a0ZyaEh0NTc2TzN2YXlVZTM2QXFk?=
 =?utf-8?B?eUFOWWt6NHZTNmptNUt4em5CaFF1RlFpZFJoN1VaRWdkS3RMZ0hVUHRLVXAy?=
 =?utf-8?B?U2J6eW14cWxuV2VMSC82MVpGenlHam4rdi8vRCt1NytwZEVmYTRnN1E4MU9p?=
 =?utf-8?B?SVhReDdLb1Fac1VzRDlVeUppNG5uMjh5bWU3TmpRYWJrQ29pNkxQbGFVWU05?=
 =?utf-8?B?VHhJcWM3Nk1FYUJuSVltZHpRa1dVRmFYaWRrMXExT0xqcVFoMU9icWExMXUw?=
 =?utf-8?B?NGhNQWVQVXRIczBMTmlmbmNVem5WaEFlak9xWDIvZHZTbk82NGxDMDQ4bFpY?=
 =?utf-8?B?Q3EyK2Jqb245UFlYVERmd3I1cUdBWFZva2xrNkk5L3JxTFI4NFl2WmdyQklJ?=
 =?utf-8?B?aUFzTVNhTnpFR1lzbUx3dEtzZkNBNWlINjZVTHJ2YWtuejFTUGUwVEgyMlBo?=
 =?utf-8?B?bi9HMWJuQ1ZEb2dIcy9NR1BDelVsT3pHU2R6M21XOTVqdldDQndxTm5JVHl2?=
 =?utf-8?B?ZmRkenZaYnc2ejdjQTJWYy8wVE1KRUJTR1Izb0ltRHJDZHVaL1VkVGVURHRY?=
 =?utf-8?Q?J8P624HFWKElOXWX6sQVYqO1+e/NuRMFTzX9ieVeKTHj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf111ecf-94cc-4ffc-b66c-08db155b1d17
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 05:02:07.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+0qw+Pu2eX2tgpKCKM06+1UP1HFm9nxnIPkarHQ90inz8xR96C85CBL39ZNx0yxDFWG0jM35vcGgRAEjYkAVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 19:30, Kai-Heng Feng wrote:
> Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver

s/Commit/commit/

> parameter for mode selection") changed the driver to be disabled by
> default, and this can suprise users.

s/suprise/surprise/

> 
> Let users know what happened so they can decide what to do next.
> 
> BugLink: https://bugs.launchpad.net/bugs/2006942

s/BugLink/Link/

BugLink isn't an official tag, you should use "Link".

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 45c88894fd8e..305f73f657ed 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
>   	 * with amd_pstate=passive or other modes in kernel command line
>   	 */
>   	if (cppc_state == AMD_PSTATE_DISABLE) {
> -		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
> +		pr_info("amd_pstate is disabled, boot with specific mode to enable this\n");

The file uses `pr_fmt` so this will show up as `amd_pstate: amd_state is 
disabled`.  That's a bit redundant no?

>   		return -ENODEV;
>   	}
>   

