Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD26751CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjATJ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjATJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:56:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CA0AED83;
        Fri, 20 Jan 2023 01:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnxiNlLcf6kVzClnnMY0Zb4VSvGe3K68sPwV8MEqEhmP60tZoBU1iO1RJnjBfT+Y7zmufSbweanTCpw0JXaMwHdugrPHWGr0FSW+MR9+j2f2WYAalYyftFcl7rkybAfkFr9iiHqLct0aNndy2iHbUB/PLf033S74oDshKqJqVP3yzhzszuJQuKNYfweFUL8brkDBZWCngOAFscd+z0AEzJYjcOIWapdsWURxVDqfDaHJ3b9D+ERUgBT9M3IlfOkFJFL/K1VECnyC6fnOFqgwjqPrZGfLtJS/lIFTNtEdWxT89k+MRS9APsF8IaVGARemd26Ro6COYdBkp1RoMM4Q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf+2yfxTgiuFVjXZrVrv2P40ZNQPX9wcnigNLG1TkAg=;
 b=TgukSw3f5YZqFFq/ZOjz74+X5PSRTEgauJfinVFnvJV3YygRUXHBbsilCWnGUQA/t9wj+iSiuosAtfKXlNzwwYV1EpMT5tBvgtThnIbhPHHiF0LBaz5CGwkePiPBGVzxarI/Etsrg3P0twa9xiYIjwvJCu6jnbCBaU6E3EgRMrFgxljY51DESljPVwR3cscl83GpDS/m2B5L2l8sP01VyiZ3log1PrPUn/EP8FPk9WgfVVwtIURkq5DUnzwwaV/aVMrPD03HrRc7wF4K0PY+ZSZx5QzlMICjELe9XU6bQrQpv0KMS7P8nd7ARIglzq5i7to0wu+CIr7TvCekydRvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf+2yfxTgiuFVjXZrVrv2P40ZNQPX9wcnigNLG1TkAg=;
 b=T2ixMQLt6zbjySC+jDm7gb1Na6iwau5bYLA5JlXyy9GeMRxSmPoGUMSrwhBN2xluvuG1IOxh2nQkC8/gVyOvt9DE/Kg3KyI7AaVenywwzxCoDCXwsVdJ4mby98ns46Z5Av8MXa2dYPODJmebHJpttDCDeuCAZXUe44lU428rBtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 09:55:42 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Fri, 20 Jan 2023
 09:55:41 +0000
Message-ID: <4081d667-68e7-3d00-85ec-c6a974b9e761@amd.com>
Date:   Fri, 20 Jan 2023 15:25:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/6] amd_pstate: Add guided autonomous mode support
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <20230119115017.10188-1-wyes.karny@amd.com>
 <Y8pcfJ9Dd31gj+u6@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <Y8pcfJ9Dd31gj+u6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::19) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d49fa15-c766-4052-36b1-08dafacc7d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9DKF0A2bSEZp5CAosj7bhd9xDHWU/jmH6SiN3/LzscJIK5r0R6fzjfBU8fxTiICOrIwe34j8455p6SqfH52hIMyp8fzg5ksr2lIawrxZs/zVaRvtWJ79M+OVpffGoj2cy4S9UhyuP5T0+kBkWE+eN7PakO39c4C+tbrJHGF26fsrsFFdZ2xZVv3JRz+FsisbpSJN9WMdefXO5sxHRmEkCQ3bMtSTIzbeA2tWMEHJ9DfCbWW1Ie9SZiAJ/BQgaw/1cLcHlvGDAiw7asORrZHEobprfiuwSsnvHeI1WlgijCHv+ibssBPDpwR7O/UsSta2xiv9zP95IeBEFxV4QTXhgdr1Cjo8dR7UAzjlbPZtZuDoxwu/iuCKqv2YS97HuEzHCb/O8H9LxCwAehGDgu4ojQ19iuXI+ydHroRuPVK8cnWUMANO6ZXaeyB9dwsH9kfVK1idCu6dby5wrnim1ZGFzbmyvVhCMnhliZk1txonsStky4Q9TsRgUeODtASHpZ2M0vnAywZ7tPMz6XeyXP9IUo35kkAnJXx5/m9klEsjRiMM2tErZwJYBEW2r4tFue3H9M+zRYdYrp5ohMpeiGZXukth+eWfgTWYxWjYxpOVi5BAav0ACiTCp5wwv0/K5kjU2NoRSdQrT/1BcXVyrRsWLIkTXF0b0C8x1rhFzSTkdiGKYgLG14UejIWrFE1uaaW8KPBs7axxOYKSlu7DeMnVEd6MP2rp7ShhHfmyn3nSVhi5zVGead9PgNb0WzreI1miOdUzHwZAEWuyulW9mm69WJI7AApCof6I32O4qBf2dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(86362001)(966005)(6506007)(53546011)(6486002)(31696002)(6666004)(478600001)(36756003)(6862004)(316002)(8936002)(5660300002)(38100700002)(66946007)(37006003)(7416002)(4326008)(8676002)(66556008)(66476007)(26005)(6512007)(186003)(41300700001)(83380400001)(2906002)(44832011)(6636002)(54906003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRmditQeG5mdkEvaE8zQjczdWFqM1d6K3NUcS85WW5KZjJ3ZkF3R0NPRGhE?=
 =?utf-8?B?aVcxdnAvSTQ2Z0RnczFmT0p1bUpoVk5qbktRTjVtT2k0OGtoMFQ5NmRyK2Rv?=
 =?utf-8?B?YUFPWlorUHdOMHBCdUFsTXFyRHdtSi8yY0YyVUs2Q0NaZFphb2k3OVFTNUR3?=
 =?utf-8?B?V2JBZENYUVlKN2JFQXhjWEJoRE01WFFHOEFOZ0J5MWpEQk1oWDdHb1hkaVZI?=
 =?utf-8?B?cTQyZnVtNjNlZjRKOWNTbnZvak4yUFRFQ0pEMTM0SmN3c3N5UWtuQ3NnMlRK?=
 =?utf-8?B?VmpWSURLZlhxcmFMSUxUSkh5QytNU1ErYlBTNG5YOEZ4WitQMWZ3UTBIVE10?=
 =?utf-8?B?ZUZqT3VONEgybXRJQXJXSnNMN0NTNERUZjdTd1diRzNLMmFoYXl3VTlWMTdX?=
 =?utf-8?B?S2JnSG9JdVdnR2RUSFdxUnpZR3ZybU9TQ29PcmlxRXpKUXN4Y0hDOWVjNDBJ?=
 =?utf-8?B?VUtmaktOMjBtYlgxd0tJWXp4OXlKdmFrNWRQd1V1cFdQMEVua2NhSWc2cFF2?=
 =?utf-8?B?ZGhIT3FDQW1rOXRGdDFwcTdudDZxOGdGNGp5MEFZL0dFTWFKYzhPc1V4UkNM?=
 =?utf-8?B?dHNMNFMyZGpNZE1jR2VDcHpZcE13d1pnWVdGZ0YyZ0J2YUlSR0VsN0t1VllY?=
 =?utf-8?B?dkcrUERyK0lveDhkVnhnNFd2RFBEdDBrNkhrcmtVMmU2YlBkWlBwYWczUEpv?=
 =?utf-8?B?dFlSYjl0R090RjRiMUx1SDVEcDJmWjBiaWg1aDlvY0xEL1laMHYrS1R2bWJP?=
 =?utf-8?B?cjZBeEU1Z2ZGQ25VM3R5cjB2cC9nV1dFUWo4S1ZlZ2VEL3k1U3I5eW9EQi91?=
 =?utf-8?B?MUFGdEZFMmhQU1lCeHltT0h2T1prNEgwRFdOUHZZWXhTR2Rhcjd2WGRDbG50?=
 =?utf-8?B?NTdhTldJTUsySFhjbWNZRlJva0N2VkZLem9mQUV0dnE1Y1hTc3RjUjRhTUE1?=
 =?utf-8?B?RDhrOGtVMTRybmg5aUFINi9renZKTjNVT2l0RnNCNkV0UysvaklIQU84Mm9r?=
 =?utf-8?B?VFZUcDdqQW54YS9tUlgvcEZEbmluMHozV29mbDNIYTluanh0czR6dnhRVHEx?=
 =?utf-8?B?TTNQNVB0b081WTYzYlNzZndqVXhNSENGaElZZlpEczFZMndjQmpFNmpOakpC?=
 =?utf-8?B?dTFZaEVWQ0ZDK3RyTFZ3OGpIKzVCMzVLOHUrMm5ldUl1VTRHVG5tS0l2cjdm?=
 =?utf-8?B?MkpITnRCek1XcHNvWmcrSkgvTEtnZ0pPMWV1czVWRUZmMGY1UE9LbTFVMlVu?=
 =?utf-8?B?bUNzVVBpR281OUFSZ0RXTVpQRnh3VWViYUh5Skk0MnpvcmZTZ3pJcVlnMSt0?=
 =?utf-8?B?clV4ejZHSVRGWHE4cUxnWk9va3ArZ25ROEVzdFVOVGZPQ0tkY1NtMGdFVnpD?=
 =?utf-8?B?OFFsRTdNQ2xQVG92ZlZvQ3YveGVMb0x4bVd3Z1k0Qnc4K3R5eWxJYXd2OUNq?=
 =?utf-8?B?ZG5MTkNCaXNSVkFBYUV4R0RwdGZJb1I2cjVycGlKM044bWxUbTNoREQzTHQ1?=
 =?utf-8?B?bElDRGQyMitvM1doZk9nZnQ5TktnV1lvMjZ6aVVrWHF2UnBWUVhqVmU2cXhQ?=
 =?utf-8?B?aGN1K1R5ZXhqcUxNeUFEWHh1bVZ6NlBXNEJsWW1aellpUVY5dkUxbFdoVWNm?=
 =?utf-8?B?V3Y2bUt3M21zWUYrS2tpT1RFaG5vcVhtYzZvcC9nVTVoSFpNdS90ODNUVEor?=
 =?utf-8?B?MnhpSUtSalRQMTN0QWZ3MlRaM3R2SjYveGZLU05OS01aaFpLSjZqdkRubkZX?=
 =?utf-8?B?QlY3OVJRTjRMRysrWWc0d3QvSHIydjNZODc4SXozZjFQdXJ6bEtvUnpEa1Ax?=
 =?utf-8?B?RXRsUDMrTVpmbTJzaEN0d0FLelduY05VK3RlR2h0LzFFRUJBTjg1cTVVdGcz?=
 =?utf-8?B?bGpaZDFiczZndkwyeWxSRHBKazRFSzdRMUMrRXd5bEJISG0vZGdYQzdUL2Fq?=
 =?utf-8?B?MEVsL1JoZ1NDTlZjdTQwRWFmOW1zU3hZckdWa0pWYXUzcVp5S0hmUGIydUVM?=
 =?utf-8?B?a2YrWEZndHJrYkVXdmJxZ2FsbEdFaGQ1UjhRbGhTbGdoTldIbEpVR2Z4bDFN?=
 =?utf-8?B?b1BpZ3R2bzMwZUgwODhQditEUVNuQzE2RDFlbExlVk45Y2d1Q1BMNWtWdlVQ?=
 =?utf-8?Q?hZ7T4vcehOmdmXz08AlWQZ/B/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d49fa15-c766-4052-36b1-08dafacc7d80
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:55:41.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpqFAvmwhvTAXIG6iUiaY7494c5jE0vEMd7xruZUunAJfA2sEybOny2ErXipU7NYrRtmMMitdOUHQLJhu7ni2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,

On 1/20/2023 2:48 PM, Huang Rui wrote:
> On Thu, Jan 19, 2023 at 07:50:11PM +0800, Karny, Wyes wrote:
>> From ACPI spec[1] below 3 modes for CPPC can be defined:
>> 1. Non autonomous: OS scaling governor specifies operating frequency/
>>    performance level through `Desired Performance` register and platform
>> follows that.
>> 2. Guided autonomous: OS scaling governor specifies min and max
>>    frequencies/ performance levels through `Minimum Performance` and
>> `Maximum Performance` register, and platform can autonomously select an
>> operating frequency in this range.
>> 3. Fully autonomous: OS only hints (via EPP) to platform for the required
>>    energy performance preference for the workload and platform autonomously
>> scales the frequency.
>>
>> Currently (1) is supported by amd_pstate as passive mode, and (3) is
>> implemented by EPP support[2]. This change is to support (2).
>>
>> In guided autonomous mode the min_perf is based on the input from the
>> scaling governor. For example, in case of schedutil this value depends
>> on the current utilization. And max_perf is set to max capacity.
>>
>> To activate guided auto mode ``amd_pstate=guided`` command line
>> parameter has to be passed in the kernel.
>>
>> Below are the results (normalized) of benchmarks with this patch:
>> System: Genoa 96C 192T
>> Kernel: 6.2.0-rc2 + EPP v11 + patch
>> Scaling governor: schedutil
>>
>> ================ dbench comparisons ================
>> dbench result comparison:
>> Here results are throughput (MB/s)
>> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>>     1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
>>     2	   1.07 (0.00 pct)	   1.06 (-0.93 pct)	   1.07 (0.00 pct)
>>     4	   1.68 (0.00 pct)	   1.70 (1.19 pct)	   1.72 (2.38 pct)
>>     8	   2.61 (0.00 pct)	   2.68 (2.68 pct)	   2.76 (5.74 pct)
>>    16	   4.16 (0.00 pct)	   4.24 (1.92 pct)	   4.53 (8.89 pct)
>>    32	   5.98 (0.00 pct)	   6.17 (3.17 pct)	   7.30 (22.07 pct)
>>    64	   8.67 (0.00 pct)	   8.99 (3.69 pct)	  10.71 (23.52 pct)
>>   128	  11.98 (0.00 pct)	  12.52 (4.50 pct)	  14.67 (22.45 pct)
>>   256	  15.73 (0.00 pct)	  16.13 (2.54 pct)	  17.81 (13.22 pct)
>>   512	  15.77 (0.00 pct)	  16.32 (3.48 pct)	  16.39 (3.93 pct)
>> dbench power comparison:
>> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>>     1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.04 (4.00 pct)
>>     2	   0.99 (0.00 pct)	   0.97 (-2.02 pct)	   1.02 (3.03 pct)
>>     4	   0.98 (0.00 pct)	   0.98 (0.00 pct)	   1.02 (4.08 pct)
>>     8	   0.98 (0.00 pct)	   0.99 (1.02 pct)	   1.02 (4.08 pct)
>>    16	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.04 (5.05 pct)
>>    32	   1.02 (0.00 pct)	   1.02 (0.00 pct)	   1.07 (4.90 pct)
>>    64	   1.05 (0.00 pct)	   1.05 (0.00 pct)	   1.11 (5.71 pct)
>>   128	   1.08 (0.00 pct)	   1.08 (0.00 pct)	   1.15 (6.48 pct)
>>   256	   1.12 (0.00 pct)	   1.12 (0.00 pct)	   1.20 (7.14 pct)
>>   512	   1.18 (0.00 pct)	   1.17 (-0.84 pct)	   1.26 (6.77 pct)
>>
>> ================ git-source comparisons ================
>> git-source result comparison:
>> Here results are throughput (compilations per 1000 sec)
>> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>>   192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)
>> git-source power comparison:
>> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>>   192	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.96 (-4.00 pct)
>>
>> ================ kernbench comparisons ================
>> kernbench result comparison:
>> Here results are throughput (compilations per 1000 sec)
>> Load:	   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>> 32	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
>> 48	   1.26 (0.00 pct)	   1.28 (1.58 pct)	   1.25 (-0.79 pct)
>> 64	   1.39 (0.00 pct)	   1.47 (5.75 pct)	   1.43 (2.87 pct)
>> 96	   1.48 (0.00 pct)	   1.50 (1.35 pct)	   1.49 (0.67 pct)
>> 128	   1.29 (0.00 pct)	   1.32 (2.32 pct)	   1.33 (3.10 pct)
>> 192	   1.17 (0.00 pct)	   1.20 (2.56 pct)	   1.21 (3.41 pct)
>> 256	   1.17 (0.00 pct)	   1.18 (0.85 pct)	   1.20 (2.56 pct)
>> 384	   1.16 (0.00 pct)	   1.17 (0.86 pct)	   1.21 (4.31 pct)
>> kernbench power comparison:
>> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>>    32	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.00 (0.00 pct)
>>    48	   0.87 (0.00 pct)	   0.81 (-6.89 pct)	   0.88 (1.14 pct)
>>    64	   0.81 (0.00 pct)	   0.73 (-9.87 pct)	   0.77 (-4.93 pct)
>>    96	   0.75 (0.00 pct)	   0.74 (-1.33 pct)	   0.75 (0.00 pct)
>>   128	   0.83 (0.00 pct)	   0.79 (-4.81 pct)	   0.83 (0.00 pct)
>>   192	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>>   256	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>>   384	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>>
>> ================ tbench comparisons ================
>> tbench result comparison:
>> Here results are throughput (MB/s)
>> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>>     1	   1.00 (0.00 pct)	   0.70 (-30.00 pct)	   1.37 (37.00 pct)
>>     2	   2.64 (0.00 pct)	   1.39 (-47.34 pct)	   2.70 (2.27 pct)
>>     4	   4.89 (0.00 pct)	   2.75 (-43.76 pct)	   5.28 (7.97 pct)
>>     8	   9.46 (0.00 pct)	   5.42 (-42.70 pct)	  10.22 (8.03 pct)
>>    16	  19.05 (0.00 pct)	  10.42 (-45.30 pct)	  19.94 (4.67 pct)
>>    32	  37.50 (0.00 pct)	  20.23 (-46.05 pct)	  36.87 (-1.68 pct)
>>    64	  61.24 (0.00 pct)	  43.08 (-29.65 pct)	  62.96 (2.80 pct)
>>   128	  67.16 (0.00 pct)	  69.08 (2.85 pct)	  67.34 (0.26 pct)
>>   256	 154.59 (0.00 pct)	 162.33 (5.00 pct)	 156.78 (1.41 pct)
>>   512	 154.02 (0.00 pct)	 156.74 (1.76 pct)	 153.48 (-0.35 pct)
>> tbench power comparison:
>> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>>     1	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.08 (8.00 pct)
>>     2	   1.04 (0.00 pct)	   0.97 (-6.73 pct)	   1.11 (6.73 pct)
>>     4	   1.12 (0.00 pct)	   0.99 (-11.60 pct)	   1.18 (5.35 pct)
>>     8	   1.25 (0.00 pct)	   1.04 (-16.80 pct)	   1.31 (4.80 pct)
>>    16	   1.53 (0.00 pct)	   1.13 (-26.14 pct)	   1.58 (3.26 pct)
>>    32	   2.01 (0.00 pct)	   1.36 (-32.33 pct)	   2.03 (0.99 pct)
>>    64	   2.58 (0.00 pct)	   2.14 (-17.05 pct)	   2.61 (1.16 pct)
>>   128	   2.80 (0.00 pct)	   2.81 (0.35 pct)	   2.81 (0.35 pct)
>>   256	   3.39 (0.00 pct)	   3.43 (1.17 pct)	   3.42 (0.88 pct)
>>   512	   3.44 (0.00 pct)	   3.44 (0.00 pct)	   3.44 (0.00 pct)
>>
>> Note: this series is based on top of EPP v11 [3] series
>>
>> Change log:
>>
>> v2 -> v3:
>> - Addressed review comments form Mario.
>> - Picked up RB tag from Mario.
>> - Rebase on top of EPP v11 [3].
>>
>> v1 -> v2:
>> - Fix issue with shared mem systems.
>> - Rebase on top of EPP series.
>>
>> [1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
>> [2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
>> [3]: https://lore.kernel.org/linux-pm/20230118075210.447418-1-perry.yuan@amd.com/
>>
>>
>> Wyes Karny (6):
>>   acpi: cppc: Add min and max perf reg writing support
>>   acpi: cppc: Add auto select register read/write support
>>   cpufreq: amd_pstate: Add guided autonomous mode
>>   Documentation: amd_pstate: Move amd_pstate param to alphabetical order
>>   cpufreq: amd_pstate: Add guided mode control support via sysfs
>>   Documentation: amd_pstate: Update amd_pstate status sysfs for guided
>>
> 
> Wyes, thanks for the patches. I will take a look at them after Chinese new
> year.

Sure, thanks! 
Happy new year!

> 
> Thanks,
> Ray

-- 
Thanks & Regards,
Wyes
