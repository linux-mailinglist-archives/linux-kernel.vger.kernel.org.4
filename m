Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE31736FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjFTPDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjFTPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:03:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDAA1FE4;
        Tue, 20 Jun 2023 08:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrO+dQdBFzkZOz/NvKnNe6/1sUm5oC4N1haOS2QAo3XfcCO+8AT39/vHSI23raGu0ALQQQaKwoWk2hz1Z0XaJKYwIjVhLhHAIfTWRv2X+cTPV/FgC880816S6BnbdcIccFobqP+SuiMpROpRzQLJpd+HDlmWGfa/2ZYsLycsK1y2K8JzalZXpMNzKI8RLH3tpvVBoqaJlVN/g8NXrM+LcZ0OAyz14MyMYVL+yQRoXbuBYGNTbWTYXOysunFHs2ZfVfgIVrcPIu2Qv3w1+ucLLigGdlVv/2lmGkQxHSp4m9jf9uNiiYV13LrHjrIHAVJ/jaATwcTYYET22y6+6r0Ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RmKzI83/swIFcwn0e2mqn9z4niB/gInXxIZiCgtm2Q=;
 b=Yyk6u4zDJ+ClalFJdkotl+p5FAIu3NVQu98jKI55ne+SLXiaekdujwiun5VStrW7Z9yY6apAKnRrPBy/7HoYJhrDozDAtP8eW07Pi2XEm2aU1wHDvjhmgCqWtvqA/Lo3IMYZy80AlQRPeVFvsK5CrABYf8EQYf55i63fcOB2wlrsl+sntB5BznkwVSGUn74LxVlm6tp+n2bCJOw+xV/Nyl8+dV+TWWboG8LE4fj2RoWGSjicLpOfMuhITQA/vL8BemlTWT4iCUVjZg11G6l0OdI9+CwG8q27DkYVGw6nRqbrNVxP09kiF9XGVFcBMjFB/a27o/3JffPPuXkU83It8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RmKzI83/swIFcwn0e2mqn9z4niB/gInXxIZiCgtm2Q=;
 b=0/wciB53oYggtpFSyyljN0AQl2OMIR/sAvnSwGQSYpFU0e9zNB17tFylQyQHSg/pdAFHhMy2QJ0YKOuIiYTgUSAxrpgn1w3dcsSmPhdf3x/qloKFSZpOgpRw9+16FTB8G2x9o3/gcCorKS2NFfFn7r3rPxJavo0b6OQHT7ctkPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 15:02:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 15:02:03 +0000
Message-ID: <bffb7ba1-c8cd-2653-94a6-e0b5cb52bc49@amd.com>
Date:   Tue, 20 Jun 2023 10:02:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/4] cpufreq: amd-pstate: Set a fallback policy based
 on preferred_profile
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230615063225.4029929-1-perry.yuan@amd.com>
 <ZJG+Xhun1Ltw9ox/@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZJG+Xhun1Ltw9ox/@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:5:54::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6cde74-93fe-44f1-462f-08db719f4e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieb57r4nHJBaKn+EwMqNfOFHCTGNbik3JmvsOjXqUmeIlgNU0X8xHFptff3xNMB2GnSAOVjrNFal51B/WOzX601XNJJJkXAzmpE8Th6RSe/hIxJgph1FQg1KY6F8PI9iv4aiIFOas0gmat8GgDIL5pCftONpUjsNvHal4dkNkU8hrULXm4H7U+hvOaR5SvxCxIqTJL66B2OPZqqrYk7MNyjvcwlLYPJDRDIzALeUF7ylX0iRn2ZJ0kj6Slefw1Bnt4VwIczAt41uzZQ+BBcrdtqGJKNIHzXcnwT8XN7kf41mjFHVIrh2BIsbaM4dqWEwgRNpmxkw6MpVAg+c1lV/dEYYqndehAHDpTA+6WtDM4bZJyNC9JORb6k82npRlJaR0ryDkPzhaGPXyAHJuGB6g1eYY+ZckfyPivDA0uUlAi76GVLRBZE1UOhEiI85/0wwsGHzgt5/z9t7u3FwWRPEAh1Q+Lm5qThx1Nxer+13PIuxB5iyV/BIgzGyH5Pn3rAsSUeFpr2BhtHNyBgSUuxeIiJbcfMBOKMPfb6OosdtKOswkl97Cpi+rYEyRC16GF5LtgfK8Bf0rcTpi8ZNDguGwdWi1nN2IBTMDrnM/occxYB6NWsOEYNAe+NHr6urxmrzGtgLGNtq37M1/eWr33DDcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(966005)(478600001)(2906002)(6486002)(54906003)(316002)(38100700002)(31696002)(83380400001)(31686004)(41300700001)(5660300002)(66946007)(66476007)(66556008)(110136005)(53546011)(6512007)(2616005)(36756003)(26005)(86362001)(8676002)(8936002)(186003)(4326008)(6506007)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdaRWZCaFczK0RUdDRlVkJ3UkFwVDRtcEZyS3lnYk1nY3NJMFV4MFRheVdT?=
 =?utf-8?B?YklKOGx6VEl2KzE2TGR1RW1Ga2RWNzdOZ3JOZkhpOUhmaEhTTWc3MEtwdU1n?=
 =?utf-8?B?emlBZGF2ZVkwYmIzSmZzME9OeDlMd0E3MHVXZ1RaZExsb0ZVRlh1WVkwWHND?=
 =?utf-8?B?dFh4S0dyRU9OWXV2VDZaM3YwZEF4MXo0VzhQWHZpNGRzeEg3R1dtYmNhYXhC?=
 =?utf-8?B?L1ZEWG9ZYkVxS3pPUDM2TzdNME5nUld5SlBYdjBjak41bGJUV2RhL3NZY01S?=
 =?utf-8?B?RHhzaEZKRGE2WkZVUHhZbnc2WXZqeFd5WER2WlQ4Z2VMa2k0NFRXV0pSaHM0?=
 =?utf-8?B?Y1puZUVZSERZNjQyYXZDUUtxdTM3SVdMZUxBY2hwK08wQlpCVUFsYU1iQ2pI?=
 =?utf-8?B?MlhNOFB3Rlh0UGxXS1dIZms2UVNiaG0zTFpvcGpqTlZSUTlYOUNJYnU1RXFk?=
 =?utf-8?B?NGtIcUhZM3A0dVkzc0Fjb0tOWWJ4U2FuLzBtMVI5OU44REpBZkR0cFhPRzd2?=
 =?utf-8?B?bkJOUjRKcU5WQkFlQ2NpOHFJcWE0R2dsU0FKZjFWTkFUL3RoeFhyMW5rNnlK?=
 =?utf-8?B?NFdyTXpNOU93YXQrazhqNFExb1E0M28xQ2c4SUJ2YXFzM09zYXJUSjd0Q2pv?=
 =?utf-8?B?b1NVT0JJSWg4Tk1BVDM2QlJrSU9nRkJ6T253eUlJL0tWNWNHWWEzbkplVWsw?=
 =?utf-8?B?R3BGNGU3K0UyWkI1MGRPR2F4WXpiSjBucklqL3c2dEJaUHpZNXZlZkRJdkNX?=
 =?utf-8?B?cmdlakZEVjhyeWZMbWFlQm9WRE9DOHprc29EU2ZOWmlYUmRXM0pPeXg4NGZl?=
 =?utf-8?B?OWIvcG9sTWJ2UmUvdkszYldqMlFNMVQwUGZ6YjVpNHM3aXVCWU9ldnRMZzRm?=
 =?utf-8?B?Q3hEZWNwWGpkeDZQdG43eG54VmprVFpoaHB4bitmUVl5aTFZKy9GWkxyY05X?=
 =?utf-8?B?U2ljNXZzamJXK2UzTDNrWWJRbnRVRWdIZ3huOHduZjh2cThDMUlQbUk2a1ZV?=
 =?utf-8?B?Vk53bHdNd3F0dExtOVNjNzFmQTVXM3prL2ZJMkZxaWtoM1RrWXVGSnpLaUxh?=
 =?utf-8?B?bFpVb0U0eEVrc25ybFgvdUlRa1hlYUM1Lzltd0tYS0hscCtqT2RtL1JMSU0w?=
 =?utf-8?B?c1pHWDhScFVETGFwb3ZZVno3aDVUcDMxQ2lHOFNJWDhrak5MMUJDMDJvRm9Q?=
 =?utf-8?B?SktJZHBqam5rVEhYZnkxd3dkMW50bjZzUXBCRnFqbjhqTWpLZldoS1M3YkdB?=
 =?utf-8?B?MG1vSGpYc2RNR01keHJnOG5ZVUdML2VvZDdjZ2RXcDJHekYyRU9pamJLOEJh?=
 =?utf-8?B?Yk9mcXNHVDFWZU1yQnhOMFo3cmx6dzVWamhRVWdEb3JGa0NkK1ZjOUdHS2dm?=
 =?utf-8?B?cklENklnSUFCLzUzdkJod0JYMjJTb2wzSGZRSlFZQWpNSkVkMTd3VmswNDFq?=
 =?utf-8?B?WlFvcnpvVDdRL2paK2htalh2dFNPekFubXcvWW5ZbTcyL2duM0twSHJkZ0kw?=
 =?utf-8?B?RnJ2MFVVUXNzMlJPVUR2YXJ3UC9IY1huWC9JMnAvRk1IZ1cveDVseUNPNzRR?=
 =?utf-8?B?V0tkdWF4am5URmV1UjRINlQ3cjNlcFZkekc4ZmQ4Q1dHOThRdlBmYnMyRzBa?=
 =?utf-8?B?Z1AwK2RLMzQwTlUrNFNQN1Y5WEt1MVlGNW5memVBMGsrSlppaVhEbEpBelhO?=
 =?utf-8?B?QlltTWFtTkxJMXhxQmVXUFJGNFpMdmNjUHRsQ05hSW9kalVtVHFGdnVGL2ly?=
 =?utf-8?B?R0lRVXZpWXM5TlZ5Qld6V0wxZ2dMUkY5YnlqTnBBSTU2RVk1N3VSUXAyNVF1?=
 =?utf-8?B?T0NTOG5BdEI4NnN5a2g2M296TlpVMjhTUTVzaUp1N2EyZTA1RTR6cm43VVRZ?=
 =?utf-8?B?UTdMbHJwbGgzMG1oaVp0ZDV1ZzVJWGZZRGk4L2NEdzhkWEphNTUvc3E3VEtZ?=
 =?utf-8?B?V2VSUEZkMS9pcnRPQ3JVY2F1QkxpRmZ0N1B5dlZqMENRYkNHOEhtQXFOc0pu?=
 =?utf-8?B?QTh2THJoMUdQT3NQWFh2MkZWREtoL0FXMmt1U2Q3V1BhNWNmQVd3Q1RSVXVQ?=
 =?utf-8?B?bUdjeTVNSkdZWFAwbXJwYy9VMDh6WTdiNC9PS3BlV0NzMTJzd1ZBVmhacEcz?=
 =?utf-8?Q?P/Vk78noN05cDE5t5ebRCcir6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6cde74-93fe-44f1-462f-08db719f4e46
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:02:03.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sl4LI7cDv0T3P6DbLVWaUZtny9hzSe2FpNdlBwtWVvmu3w/I4qX5VyjKuGR+oke+JdShthbb4NcY+ziveyVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/2023 9:58 AM, Huang Rui wrote:
> On Thu, Jun 15, 2023 at 02:32:25PM +0800, Yuan, Perry wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If a user's configuration doesn't explicitly specify the cpufreq
>> scaling governor then the code currently explicitly falls back to
>> 'powersave'. This default is fine for notebooks and desktops, but
> May I know if the processor is powerful desktop such as threadripper,
> whether it will be default to 'performance' or 'powersave'?
It's currently defaulting to 'powersave' for desktops and
workstations.

Do you think we should adopt performance for these?

>
> Thanks,
> Ray
>
>> servers and undefined machines should default to 'performance'.
>>
>> Look at the 'preferred_profile' field from the FADT to set this
>> policy accordingly.
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
>> Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index ddd346a239e0..c9d296ebf81e 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1102,10 +1102,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	policy->max = policy->cpuinfo.max_freq;
>>   
>>   	/*
>> -	 * Set the policy to powersave to provide a valid fallback value in case
>> +	 * Set the policy to provide a valid fallback value in case
>>   	 * the default cpufreq governor is neither powersave nor performance.
>>   	 */
>> -	policy->policy = CPUFREQ_POLICY_POWERSAVE;
>> +	if (acpi_pm_profile_server() || acpi_pm_profile_undefined())
>> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>> +	else
>> +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>>   
>>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>>   		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>> -- 
>> 2.34.1
>>
