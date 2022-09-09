Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1FD5B3F06
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIISty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIIStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:49:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9406E2BB35;
        Fri,  9 Sep 2022 11:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvv4NU1mAIcmZHiSYTRcnso+3yDfrcv0l8NEzohtrtyPAa2MSvbO/XLImaaGtHs6MsE2VF9dyvxaeaSnkY3C5j2zwUXdrOLxHALPv1J3AiHqMGW3iFPvqDJYGlJMDKEcSPYT2Tv9ryxwCMiG9IT2wDh79bIQJYCbWx2V0sQ7/gAD3RcXTYSO2m7ZWxTiVYy3DqpuHg9wx6hE5zT69/wdaSwmfTZLpEyFL5Mqiv6Eh3wmbzuErjg3LXWq1oIUChS/25NWTM3H7ZBPI90/D2RbBzW2yGeuvBNhmGQTEx5D1UlFHyykTgqdKCk5rZ8ModctGRS0snkAsJ52Y9OFiwS4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TreCTSrx7p9vq1LDmhRNmZmhCAOOTeSMRpblK9gM0N8=;
 b=kV5GqrMhyfbqBq64tcvr1VbsIdPIK2VgkjwVveygy3fO4bYTwseaJpI4CbK7g5AJoE9TyPUWDI49+h9VGq/Wt0MDRaHMDlhrzYzeugADjHuMV0ykL7uDTyOCfngbF+PDCYNnprmRnNTjS27QYLn+q0Zo/V7Cxn/i77QeMkx54c+r+En0UtlStNre+jyT1zuqpe+CGBfLBUBG98+iZQR18nqZ3QQ4XOuyEZqlG+vQc2DBfm5kzxvi2c7839Z4KMqpNuh8dsKGFwiRJCTXxeLaoEJzc27HP7mnbt2VXUVtWHtBLKT9vtzUrw9wrPJO9MyNcVtRKVy/tto3CHFeGtPCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TreCTSrx7p9vq1LDmhRNmZmhCAOOTeSMRpblK9gM0N8=;
 b=jFq1kkTnHf6C1H9rw1f1MCUAGIV8wH7e7KwcRRo4lOTgoI+1Md/4ElXawBiDhtsJbVQNfQJFsYkFCL1a3nzGorKXVtRyr6u/Qg/j7S+Mg99ZQfHZVLKLA9p4AQW9182nU2mneuXH5nvQ/WWSQeloevuXCXG/HSkHv/hHFBBLxA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 9 Sep
 2022 18:49:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::8ba:6e9:9e9c:da5%6]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 18:49:44 +0000
Message-ID: <abb1ec0e-2a1f-09bc-f11c-8e5be4526927@amd.com>
Date:   Fri, 9 Sep 2022 13:49:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/7] cpufreq: amd_pstate: add module parameter to load amd
 pstate EPP driver
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Jinzhou.Su@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-3-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220909164534.71864-3-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::19)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: f72617da-672d-45dc-8daf-08da92940f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRRm6OSeTVV1/Ed5+zvLIyLb6eol2fP3y5svKZsqdL2+RzNTbBFbrLHCc6L8x3ftwa7olA2szGDDthef9DQFW5z8GzxvtdNxShoqOfWfQz90E0FOA31aWvtevdywMdbXFc+DIizUNNwwRYYbo4GB2OouL+TeT1IagED8oPbtX38xpr+47dChB20Fblc397uFMAereGso7NaG9N6gr3thhY40i/tDqNOqqjniysCO3Tr2X2oU2MmQEOvaOvEtj9BAlL6UseQgP72yjy83BR3M/mSUBl0exxfcOj4V00qElgYmsqXQPrPcWP0IVyGZVrSenV3pURrG/KOT/DfEn8gumdfganIY+p/qvY43a9F6oCkGvL8YyOBQKWxbQg+VnCIFucuW1WWRo7DgrFDV9S3QzNVzoOUVmqtYv1TkyllAW47hY7I7SoTJAqqo6sQqRWGgdSkceRZ8It2OdwxndRLgafeiNJVQSQ2NjKPKr+a8YFZIpvyhoV5FDn32MFSbiINotx9pY1EEr2JaIXFxDUgTk9j7m7+roneqX9V8G98rMYKA9R3WNnYKIJl8FxGnGwnlFl/YEZ865jU1M9JnytE+lj+aOTpFBtWD5G6csM0KFcifeOHfNQPadDRS8QDuGz3ERs7TciwAAx0JhcDP4V2OxaX0nPGQlHMoeVJ7FGJ7Cye2LeMbFlw8KS9pQahHkQYkuv0v55bCh2LPUG7jfvdIIk5WK9mejNU/rxu8JG3V8gmtdVZ6o4AkrKdaGiaiFzvDK4WEzDxGdccRW/jawq0lTW0suG5ved05aM/UWLAlF+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(4326008)(36756003)(5660300002)(8676002)(2906002)(8936002)(6486002)(41300700001)(6666004)(316002)(66946007)(66476007)(6506007)(31696002)(86362001)(478600001)(31686004)(26005)(53546011)(6512007)(38100700002)(186003)(66556008)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWE0b2VlZjhnY3ZENk9tcUhVcmE4cWVqUWpyekUzUjhCeUFUTHBmcDNGcitX?=
 =?utf-8?B?UHhoS3IwV21aSFd5RExQellmUDJ0eUJDM2J1RmpRczU3citUeWIvV2RKQnlS?=
 =?utf-8?B?emR1eEFrWm4zenFqalJwaGE0clJRcWdkWDdnb2M2K3IrOHJHQ0MyTXhLaUFW?=
 =?utf-8?B?NEZBUzg2THlJK2JHY0dWRk5kTTBUd3AwZ2ZqSmdiNDAwVEZZZk9ITWhBLzY0?=
 =?utf-8?B?TmlLUkI4dFJhVUxMenhuckZJOUhURUJmT2hvZHpNR1FZRlV2QkEzYk5xY0p4?=
 =?utf-8?B?bDQyY2NCcVJoVmJhYTZYcjFlK3ZqK2o0ck80cDBMRk5oRFVUQjNjdW05UlNk?=
 =?utf-8?B?a0o4YUFZRVoyOElZN01IVHg1N2laVzBmamVtRzZ2UmpVaDJNSHJOeWRGWHln?=
 =?utf-8?B?NjdLTitIOUVLaXhyTy96aU5jeUpmUjlpeXcyakhnYUl1S0EzZmNBbzJGZlVy?=
 =?utf-8?B?ZUxPOTN4ZkxqeFhNYUxWSGplOXhnSittbldBYTg5aTJUb0g2TVJTWGU0K2Z4?=
 =?utf-8?B?ek5CbzRJSDc4bE4xQ1JGSEcwZDlOUE12eGJxcldXK1FUbXBnM21wTzFuRVda?=
 =?utf-8?B?VEZ2dUZJRkQzSkFRd1d0eGNwOHkwWTNvTW93Q2VQdCtyS05KeDB4REg5ZFlI?=
 =?utf-8?B?Uk5sV2VFZFNGaTR4R3o1TmptVVY1RjdoMi9WQmhHZHpYenkrY1ZLdms1enJq?=
 =?utf-8?B?UFdrL0EyaDBjT0dWQkNtT2JibjBmdCthYTcvR0VKMHEvZ2NjTGs2TkRqUDJF?=
 =?utf-8?B?RThxbDd2SllYTEhYTFNRbXMvQzZ2V0UreVQxNnY1MXlETkk3Y1pnWHBzSENa?=
 =?utf-8?B?eG8yQ2VabVh2K3ZTN1kvTFg2ZUxIY2VuNmRjdUdwdURVUEhwbVBleERmWTJG?=
 =?utf-8?B?QzNwN3M0Tko3ZkhLN1pjcjlYOEtXaEUxVHRzUzFzR3RLYUcrREFRcytQeDhG?=
 =?utf-8?B?SFdORUFWU1pldWpNc1lYZU5DREZRbkhOV2wxOEN6VENrbFFZeHFLYi82bHFz?=
 =?utf-8?B?THA2S211UnE5N0plK2pJbFhPZ3psRU50bkhZSE1yRUs0ckRYZWpINTYxSGtH?=
 =?utf-8?B?UmFyblFnZXV5NXVsTVJ6N0NzSWFEWjVyMWgwbVI1YmhvQVUrd0IzUFc5aDJG?=
 =?utf-8?B?c090a3FUTVB0dlFEL0tYcWFSSFlSMktoQjFRTndKSW42N2pBdzhOTmxuanpO?=
 =?utf-8?B?czM0SnNmY0NtbWlhck9hK0Q4K1NwRFNZYXU4ZHM3WUFqRi9Cdk1hdDdIZzZU?=
 =?utf-8?B?VndwUk1KSUZickVqREZ1cjJZc0ZJbHJ6K0kyRHYwK2FIUjJWN2E4eWdCNTND?=
 =?utf-8?B?MlNSVzR2SXphZmhxWGNXZ25vU0Q4MWl1QzVOdE5EWVBsWFIzejZaSkxuNkEv?=
 =?utf-8?B?QXhiaUpjMzdsa1BiSnhmM2FXQWJHam1FV1hPdnRWeTdCVzk0dk02MFhYbWM0?=
 =?utf-8?B?K1QxcnhXRlNlcG80b0MreEd4T21WTHhYWmlXb1d1aWQ4UEFzTEZ1NE4zVmVO?=
 =?utf-8?B?KytBVlpHdXNyVU9WdEZLaURyVHpEM2NVeG1UdkNDcGNwdWs2SGRMTkVSTENY?=
 =?utf-8?B?bUFhUDNzYkViMXp6dUJZKzZCMDBwbmtUNEtROGN3OGZDci82Vkx5d1ZmTGdS?=
 =?utf-8?B?V1I5U0lKeURLampWN0xuWE9tU1M0dG1NT2RVd3NjWWxUMHJ2Uk5WYXdDemFQ?=
 =?utf-8?B?UFA4YUJBeGhjTFJ4cGFYekV2U1ZDRWxjcXBmS0FSYjJaazlvMmthUk1FQWIy?=
 =?utf-8?B?a0dGU0hNWTU4TC8yUW5sTjRIS3J3U2d2ckZiN0dkT0tYTjkrZVROU3NGeE1h?=
 =?utf-8?B?d1FsMVhPTHNlQTFyT09MczQzdy9jdnZlNjFzTG0xSVE0ak1TenNaV1VUNHBr?=
 =?utf-8?B?cTVRbXNsZUN4ZW1zSldCTG0xY1VrZktNUmtaU3JHU25Zd2VnRjB5c0U0YkZz?=
 =?utf-8?B?UWFxQ0JHajZJeUQwQnFLaTBBeDJmWTNuN0JPYk1sTHRUZzJDeUx2dVgrSmhp?=
 =?utf-8?B?NG1yMklRSVNEbnd0RkZLSWpvN3RaSGtvWEkvOG1jbjcwS0RNcWpLT3NhcExj?=
 =?utf-8?B?NlhPRmdscWttSHdQaVZkN3U3MGViQy81UWtjRS9oVkxuMUV5bFlrNkMwZW1P?=
 =?utf-8?Q?yY3JbMwM1BzcMltugF1cj5CL/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72617da-672d-45dc-8daf-08da92940f96
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:49:44.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfxwHD1alNYJToOlGXHiLd9faYs2wMcitBI+fxIdY4KTbkZ3KX+v2C0tfbNWu2iNJPPC771AHnXvwS1pmr0gow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2022 11:45, Perry Yuan wrote:
> The amd_pstate mode parameter will allow user to select which amd pstate
> working mode as booting mode, amd_pstate instance or amd_pstate_epp instance.
> 
> 1) amd_pstate instance is depending on the target operation mode.
> 2) amd_pstate_epp instance is depending on the set_policy operation mode.It
>     is also called active mode that AMD SMU has EPP algorithm to control the
>     CPU runtime frequency according to the EPP set value and workload.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a2463f785322..451295284a26 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -58,6 +58,12 @@ module_param(shared_mem, bool, 0444);
>   MODULE_PARM_DESC(shared_mem,
>   		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
>   
> +static bool epp_enabled = true;
> +module_param(epp_enabled, bool, 0444);
> +MODULE_PARM_DESC(epp_enabled,
> +                "load amd_pstate or amd_pstate_epp (true = amd_pstate_epp driver instance (default), false = amd_pstate driver instance)");
> +

If you're operating in EPP mode or not the kernel module is still 
'amd-pstate'.  So to a user I think this is a pretty confusing 
designation.

I would propose the following instead:

 > +static bool epp = true;
 > +module_param(epp, bool, 0444);
 > +MODULE_PARM_DESC(epp,
 > +                "Enable energy performance preference (EPP) control");

> +
>   static struct cpufreq_driver amd_pstate_driver;
>   
>   /**

