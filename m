Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B97647FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLIJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLIJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:02:19 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DF61BA3;
        Fri,  9 Dec 2022 01:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBLT9eTWKPoCg1ZvhJNLjTZC/53pqCc4vy3BiHlrIXWibuZqd0Z6LXoC+sopEVU8QP6ZStTkD6ccLv7ljvpQnNeqXtIz8bx8N/LtourkQJGliDaOw3xGTeN+/DksST8eaz4V6skykmaNlFoWltIg1v3IcSlV8j0lGOKfO5Hnb/nzixlSTZf8R8WDlA0iMhDCtAizkMDm3iXu2Rr9FxdkMeuobwkn16bZoF8xqZx3uUyMPBPupM2e8F/KCvkehVGdJGbdIrjqhO9iLaFGrwQy73cJPXUKpBOog9GEU+98TinrZBAzBh73thCP+AjvD03i/nrPsYBmJzmyi/L4vmqtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgNMzQb1JfP3ipPsZrEQbh0peZa9AmXvQZpGqQ03rqU=;
 b=QSblAP2LQIUtgXqZ2Cccxx/91VLh00owA13NwE5yBx0Ba/OzadX6zG/uUDH3N4w5KOlP+PU9Ccc0pePeAl9IplK34mN/cF+rC76AaUoKH/hfxn6QmGE83K34HYYXTjuhLgICOlbF6FeWXWwd5Xoh0+VY1fG3kruOPzHifdv/hBilVB/HcA+7pRnPsUdxvjeDuBuxUpYMiD1w28qO6BAhoP2jIl4tBJWj/IFEqW7uxEjh+2MZO50zaeKwwsXGb3PQk0fAfNPub3byO4U0WPux9fPbywd1E1fcPC3jNC6JAciijPGLJFWsdQXb3zWwDL3Rm34zBs2FyihSiw8AbRng8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgNMzQb1JfP3ipPsZrEQbh0peZa9AmXvQZpGqQ03rqU=;
 b=y2ljFMBMIp4TkKxx8DHb44WPNQKKeuHsdwt3yMLtDJgod9c1XtPzaQyZ4+gWDtPVv5RT5LnoLpXFrbWdtvd0hYCWdf5Gkh48kTE6XwSmcjZQ0fz0NXI3AiC+lPopvN6ISGkzzOhEHoUlQVGyUTDo4uFt69EZGue6uNarxBpUaUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 09:02:08 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 09:02:08 +0000
Message-ID: <bf226a20-f22c-cf8f-4f19-eb21033ae1c8@amd.com>
Date:   Fri, 9 Dec 2022 14:31:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] Documentation: amd_pstate: Add amd_pstate state sysfs
 file
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
References: <20221207154648.233759-1-wyes.karny@amd.com>
 <20221207154648.233759-5-wyes.karny@amd.com> <Y5FTHGsezkdzwvUa@debian.me>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <Y5FTHGsezkdzwvUa@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::9) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f8d25a-1cb2-4bee-816e-08dad9c40ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXeTYX48GiPKxTTuyeC5+Nbag9Elix4FnOROHQ274f+g5U5FnxIY9t/B586RZkg15V6M4TpRRQrzi1sPe0cE5XYVHitLyz+1NIN9wIqxhKySC3vdK8k9QLPMDdmzVACwAg8/G+iPM5vOV/BGKpPwNK3Moy5qvt9i5GN9S5ttzfeWidOxdIqKOhgJLdDEDAyOf8KD8NyjK+fEd/MceoR/iRjuH5GAvujiQAFnSJQHHH8Bsj7mL9rwBH3dgGPR686L6X4MBeONF68lMDrX7UNEGC5SG6/aYubqp+hWuAfAkWjjB2SI3LNHcAq3+KCESIAryhkDO7YNm0m9Lknrs/mlkx5EcnUITAjg6z7LhHL2FzCY2plM07WY4IYbhcSy3TgS3QNgECalxyq7XeYvxfGk+uUC4u0WFr7A8JEALq1HDk/2tFZGT+QR/MTr91VknBmU9kcBKFlMkxlT8K3h5qliOiQitYKXpMracMH35m602PqeccPLSTsFBJp/Cw1qBaRA61pTZvmYWnTHPZGcAh/kg0vp6UqHobonYqnIm2KHoohPReI8l32/siLTHmvRnXbAZwT8XmrY7ntO/AmpIWQFLerycp3W9kyKspR19I0WhsWwtAtUW9NWa+rAdONS+etuNOgAdKzjeY2brb/0GOou3c1HVmKFpYYmoLqXYEMPSWfyFUXCCuRjgdtBzIQcjjJCn4QwonIGOxcOCvnfwNGNdH89BgLEOVugx5mpx5f8jQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(44832011)(36756003)(31696002)(2906002)(86362001)(83380400001)(2616005)(54906003)(6666004)(186003)(6512007)(6486002)(6506007)(53546011)(478600001)(38100700002)(41300700001)(5660300002)(8936002)(66946007)(66556008)(66476007)(4326008)(8676002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUFBVDdvRTArRGdscWc5eWVLUXBjYUNrNER4WFA2WHJ3UHJ5M0doOW5yU09Q?=
 =?utf-8?B?K2E4b2RoTzMweDc5ekpwc1A0TzhrZ21mU3pYNHlvZ3FTTFFYV2Z4akxWNFpT?=
 =?utf-8?B?MS81SXhyY09rU0pjZEkrekJCZTFaenlHaDdaSnJ6eDhFTkphLy9tWEVMR21n?=
 =?utf-8?B?RmJUUGloMituTzN0Vk5yY21ZcjliYXB1SkJCY0ZWaFJuMUFQOW1CeVdkRFpu?=
 =?utf-8?B?OExGUEhRUmxZN1BRVUVlYlQyc2NMaWNnNFhQMlF1UFhtR0NSOVFKZ3lCQkE3?=
 =?utf-8?B?ZmgyZUZZVFRicmhVdU9MdktrakdsZ1lDSzROMnQrRFgvelhOSGJpdE5GbVJK?=
 =?utf-8?B?cUs5L09zV21BY29ndFNKS3JLWHlKVkF4YjhvNnQrZHp5S0R1S0dVU2hRU1Ew?=
 =?utf-8?B?RGIwUlp6d2tMRmE4Uk5aSDBIa2lsSDlseXlJMnVpYUpENFlWNjdzN1NwL05a?=
 =?utf-8?B?TE1SU2pFWEl0M29YYm5tTlpxYS9HRGVzVWJzVjZQTVZ3LzFGajJLQzArTHp2?=
 =?utf-8?B?Y1JSL200d3hUMTZsZ2JHNWZTa3lESGtGeUdmUXBCUzg1V01aeXlGMm5SYlFT?=
 =?utf-8?B?Y0FDNkZ0S1N6ZVZkd2pHSU9JeTNDV1orcWV0Nm1nTExhRkVVV2wzclFFMUZT?=
 =?utf-8?B?c2Y2YkxUdWREakMxV0w0MjdveUptWlNFVS9iblR1eDlPc0xiMmUvaG5kV1ZU?=
 =?utf-8?B?d3RtWnYvRG5mbEY4N1N0QWxjL1h2L2hDejAzTjg4NmRSM25sZTRpV09keXMw?=
 =?utf-8?B?dmZoNDFIOTJEZXZVb0tSTU1Cekx2WnZCcTJhNjBSTVc2WU5LRklZay9XTUhp?=
 =?utf-8?B?NmNFaDBkUWREbWplTWN2bFFEcGJJdk00dXp3VnU4RGxFMVJCY2k3ZjZQV2Fq?=
 =?utf-8?B?dmpSLzJUbGIvMmFUL0lpT1ZkeEhEbGRQOGd3Yk9QQVNwb3ZDR3U0WmlMcVFC?=
 =?utf-8?B?KzZWLzhWTHJWY0VqZnVXeUVxcitlSEtyTjRmNFhtdVc1bWxMUklrb3NjZmlG?=
 =?utf-8?B?cFlSWkhUWXBPM0o3WkFsRVRxdUsrV0w4Z0lUcE9PMENrdm4zWVUwVTNqR29l?=
 =?utf-8?B?K3lsTUx6NTgvNzlDb3M3c3BOcHlDdThXdExJSWdnNUpFSE5adlJGVmxEeHBU?=
 =?utf-8?B?T0lUaHdMOUxYVzVqaWFmb0xzQUlXZmJVOExIclpURGxySjQ5bU5EOVlwZDNn?=
 =?utf-8?B?c29jUXhXNXc1djhVSWtMaFdOOHMweGNuSE5FdCtSVVVHdXNGUytzcEl1WGVY?=
 =?utf-8?B?b2ZsWGpVUmxybkJtM0poNGlGSitEcDlyWU1OWFhqT0NrRDdpUUh5RnIrcEdL?=
 =?utf-8?B?ZnlTbzJSQW1XeHVIRFZuNkl5M0RrWkQ3d3ExRCtKZTJHL1VHWWdvMmZwcTBX?=
 =?utf-8?B?eENxdzZNL1Q4T29KK1JJVHA0bnQ1S1o0R0QwSGpDL0JjZ3R6a1BlbEFpWTUr?=
 =?utf-8?B?TG5xWHRiM1dybk05dmRLQ2xuWWZKWE5tQ0g5UHRyQ0J5MHVEWU1CVWJtMm5P?=
 =?utf-8?B?eDg3Q3UzZWhnQnVINXEvVnVKMGkwbEV2aVo1MXFLLzNTV29LM3gvRVp4RytD?=
 =?utf-8?B?R3J1N2k4Skp4VGdzY28vNlhQZW13VTVDZEF5SjVOUGk3ZXk1S05PQ29ETTQv?=
 =?utf-8?B?SW1hNDhpcnl0ZitFbFJqbHQ5b1VLOUNHb0FsenB6WEI1cklHZHg1SXdaMW9n?=
 =?utf-8?B?TkJpVExkT0VPNDBlY0VESkE5UDZvYzhMQzRpM2lLU2NFRGplMEs0T3kyTGIv?=
 =?utf-8?B?MnhSQ0FjdVVJVTlXZHlKWmc3QXZYTVoxckNhUWdQN1k2UDFRaUltVWRFbzJa?=
 =?utf-8?B?ejlqaTBnditzU3FwREpKTDB0YjFhQ1NGTEZNNWJ2bkd1UEdXS1I2aG93Wndu?=
 =?utf-8?B?WU0yZFc4NGZKdXFDVzV0ODg1dC80SUFkQnNHM3dzRVFCa0dXUkJzeXVOTTNm?=
 =?utf-8?B?YUJJRUJ2bGtSWjc3YWdLdDJXV2crQ0RjUVJCTk4zd1c1ajYxUTM2bEE4SzN3?=
 =?utf-8?B?MUxUQmphenlpcWxMUXU0aFNaaGtDdkxFZjVmeVl4VGlJZW5XalVQU0JNcU5J?=
 =?utf-8?B?TEhZUW8xMlRnUmhnaTNMbVFRTnpOQ0RqUWdqQlhnN3ErWTJ1VVZYTzl2VjIw?=
 =?utf-8?B?dVBxUWVDbVFkdGxXOFdQV2ZvUnFKNzFLMzdKYWs3dDFtUkZCMVZ2cU5NeCtO?=
 =?utf-8?Q?AosJD66YTeK043UphuGOSG+Ye6peOfCaWM+eQGR2yngS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f8d25a-1cb2-4bee-816e-08dad9c40ccc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 09:02:08.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyWydhTDj10HHITFDfUsHxrNUfg3qJlUrvAPJT8A7qHPPrS8+vzdcCwtjMPtSRx4AUxOoL11KIV16Jao+Q9Q0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/2022 8:29 AM, Bagas Sanjaya wrote:
> On Wed, Dec 07, 2022 at 03:46:48PM +0000, Wyes Karny wrote:
>> +``state``
>> +
>> +``amd_pstate`` also exposes a sysfs interface to view and control the driver state.
>> +The driver state can be one of the following:
>> +``disable``     : indicates driver is in unloaded state.
>> +``passive``     : indicates driver is loaded and currently in passive mode.
>> +``guided`` : indicates driver is loaded and currenlty in guided autonomous mode.
> 
> Use bullet lists for above:
> 
> ---- >8 ----
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 4d3783516ddc2c..0d0e0affa3adb2 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -269,9 +269,12 @@ Other performance and frequency values can be read back from
>  
>  ``amd_pstate`` also exposes a sysfs interface to view and control the driver state.
>  The driver state can be one of the following:
> -``disable``     : indicates driver is in unloaded state.
> -``passive``     : indicates driver is loaded and currently in passive mode.
> -``guided`` : indicates driver is loaded and currenlty in guided autonomous mode.
> +
> +  - ``disable``     : indicates driver is in unloaded state.
> +  - ``passive``     : indicates driver is loaded and currently in passive mode.
> +  - ``guided``      : indicates driver is loaded and currenlty in guided
> +    autonomous mode.
> +
>  This file can be found here: ``/sys/devices/system/cpu/amd_pstate/state``.
>  
>  To switch to passive mode: ``echo passive > /sys/devices/system/cpu/amd_pstate/state``
> 
>> +This file can be found here: ``/sys/devices/system/cpu/amd_pstate/state``.
>> +
>> +To switch to passive mode: ``echo passive > /sys/devices/system/cpu/amd_pstate/state``
>> +To switch to guided mode: ``echo guided > /sys/devices/system/cpu/amd_pstate/state``
>>  
> 
> What about these wordings instead?
> 
> ---- >8 ----
>  
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 4d3783516ddc2c..6465bd39b7dcbc 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -267,15 +267,16 @@ Other performance and frequency values can be read back from
>  
>  ``state``
>  
> -``amd_pstate`` also exposes a sysfs interface to view and control the driver state.
> -The driver state can be one of the following:
> -``disable``     : indicates driver is in unloaded state.
> -``passive``     : indicates driver is loaded and currently in passive mode.
> -``guided`` : indicates driver is loaded and currenlty in guided autonomous mode.
> -This file can be found here: ``/sys/devices/system/cpu/amd_pstate/state``.
> +``amd_pstate`` also exposes a sysfs interface to view and control the driver
> +state, named ``/sys/devices/system/cpu/amd_pstate/state``. The driver state
> +can be one of the following:
>  
> -To switch to passive mode: ``echo passive > /sys/devices/system/cpu/amd_pstate/state``
> -To switch to guided mode: ``echo guided > /sys/devices/system/cpu/amd_pstate/state``
> +  - ``disable``     : the driver is disabled
> +  - ``passive``     : the driver is in passive mode.
> +  - ``guided``      : the driver is in guided autonomous mode.
> +
> +To switch between these modes above, write the appropriate value to the
> +aforementioned sysfs file.

LGTM. I'll reword. Thanks!

>  
>  ``amd-pstate`` vs ``acpi-cpufreq``
>  ======================================
> 
> Thanks.
> 

-- 
Thanks & Regards,
Wyes
