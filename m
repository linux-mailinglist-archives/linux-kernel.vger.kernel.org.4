Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E50668E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbjAMGsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbjAMGrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:47:33 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F978E8B;
        Thu, 12 Jan 2023 22:32:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJkaEcU3UCaWhQ903cn9sqv7mnBKuPymduUJ2YSQ1VOpJ79/5vdA/5Nm3e3Yr9X/Gc0mO4RkfaCwB6+ypNKaslr0+bXJmX9MoRYRVqdlZ94dXY8oBiaHR8LqDHTiS/dprA3D2WJUfdKMu+t0mrBlHPOLFhXgWpCSd6/zoEp+ik1Q5HVPoLErH+SPriTnoIIcnglsLL1cz1bfPYBHlifozk9PoyCNxqbPfvzlnSMa9/NOg4Eq1gi7DavfLpBQbt94FOsVq1bpOJP96wrTetGic+pd3bZa6CriOI6vfZOZvi2/FGfa7eS2YQVmbqZPlWjzzrLsoThAdVvvQyCN6N7n5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIAF/nN4oCRDMOIGnLqoJX4y0sF0HUQRT1syZO2fLFk=;
 b=amhhV5yn8cBV3IsY5m5g6nwfxg9CqPqFUIUogTJ9rUY4SQ0WOqDLCKmHgUX9e9jNyo+Xs6a/BdGTyQJEI1H5ZyNf5RgcFFgCbAWklotN/F0vLsoBnbuij6IIl80oJ/+R79BPllcxkVZQ7rPrc9ubj3JvlczTcjbuCLwqMn7ivrbGa4kJeS8Ati1COWyLOmLZi+HJYYuMHO+5gCOCjQ+Z6vQ+pS8VSi7Z48UEEtZJYUga+f8F0a/xsVEKgZ8EPeKEHhAdR9vRUvDPojN7iE4Gex4J/Ls0HE6wCpCTdTm313V8e7hl7jCDlL76TX2xJlQ+h7Ru7qTEF8g1wUwA06HGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIAF/nN4oCRDMOIGnLqoJX4y0sF0HUQRT1syZO2fLFk=;
 b=YmIEmnuq4S6xW+6+vTcmYxs8RYjwyW6MLTrzx/CEOjjwhZ/hwUx03p5azHzeK5q4gpXGBPMUQez6fpQmjJEOhOk09Cyq6ZfHgzD/p5fhk3Oa3aIfg/1rCWASFKakTCkQm7sgTtr4BcaZtKOKAzR4QsSaAMrFCgAAZhidG8tH1MQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 06:31:14 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 06:31:14 +0000
Message-ID: <7785f9c3-93f2-7e7b-9c8d-8f86a0c9a76c@amd.com>
Date:   Fri, 13 Jan 2023 12:01:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/6] acpi: cppc: Add min and max perf reg writing
 support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-2-wyes.karny@amd.com>
 <85925bce-f30a-b2df-309f-bd4b510a117c@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <85925bce-f30a-b2df-309f-bd4b510a117c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BY5PR12MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b66664-542f-425f-65d1-08daf52fc4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViWO3jygjFJRtBeu/sYFAMPq1jjvXqb03Oav5AoYvGuMt5FMDJR0oftzcksEhmvoOxQjqaqG/pvtRuG8UNlfynGr8FxYHE6NoPkhjhLqecI4C7vhW0R9K3CnAUTA8rtt/YE7KekiVDG/TlNT914Qdwio7fCnTD6V1M0ozbSjJGMUSBA4tCWnNQc+HCcDOFv6HeRi8Z/jNsBjv8MC06yRMhTytqKnG5AAtIBxOFRqcOavO4VsDg46iMhUdEx77bmYsF9USUuWCKpJibTX5/gbpDtOlFCGVDoHArOpfB9GipezDcNA3x+jL0FrWbs3WdFybaGS0X7O3AqA10AULbxJta8XzMLQ/oOClqhV6WKsiNmeo3W6YqU/vH/yIOJDQ2cQE7r5mxipC7eNZdITORximy0caaLqnqsEeS0USbv+4PK/SEw4mEUH3ahuUzA6GDVZTJfOx0IEI8lSnbpqB/vmKgrSfgGkunLPEG8bJG84oncXrwUqnAP4ccYY2+USiXEwLt/7R5RH/+jrArRQgCTbjrSLFNZi6i40Aza1OgEYXBg+JbgaVJsMf1yVbv3htmCEpjOIu15Rpcg/rvrHrbQPayCjcGXdNce4SbOvTzyTyOiVxNxWD6gPsu3i7HLM7xHD2ICSOr4843BaCK5ojOQdTqqlPeA7Z5vKvBWiV/99WEvL6Qoi/GtyEbQTOK4Z9idqlgNWZ5kR1ffP6aeay+v5vxtgfw2sYRejVqM7YbvjvKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(2906002)(110136005)(5660300002)(316002)(6636002)(44832011)(36756003)(2616005)(38100700002)(83380400001)(31696002)(6486002)(86362001)(26005)(53546011)(6506007)(186003)(6512007)(478600001)(6666004)(31686004)(8936002)(66476007)(66556008)(4326008)(66946007)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJLYUZJQmtVRjE5eTJ1WGpFVithS21YRFdPbHBPT0NDazU3L1Z4cmZDQU1R?=
 =?utf-8?B?S2luV3F3Z0NXaGkrM1REMGc2MWREWFJ0RkpDRmwvaGIzc2ZhNExYWkhkVTVU?=
 =?utf-8?B?VExMa0FtUVJ1UVBSQk11UkFWRjh5L3MxVjJiL3ROaEdLSS8yRXdFUVpXaTQ2?=
 =?utf-8?B?U2FJOU5wR0dXakVmUHlsZzdjQXpSNXZpaVNZQ0VrMTY3RUdXSldIS0ErQzk3?=
 =?utf-8?B?Ym1oWmIvdzdZWnpWem9jWk92ZEorUngrWWlGYmhIMm9zb3BFMlRJazFmTGx0?=
 =?utf-8?B?em9zR3FyRFVlb3hGT2d3UGd1SnRVc2lTN1NxUHpWWDQ0ZjdobHU2QlR2bWFS?=
 =?utf-8?B?Y0pTcjRKbVJFdUJwV0RqNCtEaCttcEhnelloT3E2NmZtZFc2TTk2RW5UNDRs?=
 =?utf-8?B?Z2NjVGhvaHNGUlRHZVNyc0dDOERuMlE3RHM4bnFIcmV2Z2oxcThVVXJXUk1U?=
 =?utf-8?B?QWkzcEVvVVNPdDRZcjRyUWo5OUdwN1JnQmxVWUc1eGZoNjNMOW8weitrQlJj?=
 =?utf-8?B?RjY5ZjJnVTVvcVI5K09zMDZpd0o4VkQ4TGw3ajRJK3BMS3lBRFp0dWkzbGNF?=
 =?utf-8?B?OFNBcjk5VXgxcW5yMkJnU2tNcjZOL1g4b1MyWTZFQkprcjVNTXVKaWlpTGxY?=
 =?utf-8?B?blVBTGpUWVhRaFpDRHZOVXFnTnYzUlhTaFRjRTBjdUJMVDJreTVLK0Q1VDNo?=
 =?utf-8?B?OFp3NmdlVmhUbU9DVnYvdUVXNkNlcDZBc0YvREZMWEVJQjNPRE5aQWh2NFor?=
 =?utf-8?B?MTJqaVZsQ1ZuRkpHdDVIK3MzbTZub3Q2bmdGZWNSYlk2YmNEUGI3c1RjOTBW?=
 =?utf-8?B?MjcvMUplYXZCa2NzOG1CY3ppRExWK0RMaGpPRS9vY1YrUTNIZW9uWFE4eklY?=
 =?utf-8?B?SnZBS1owNFdBK1pvbE43cGxaaFlGanlYRHl4RTRDWHhmajc4VUxRUTBZWm01?=
 =?utf-8?B?WTdWVytad0RYU3JNVStGUkV0dmQ5TFlIOHRlV1hPakJQUUtkcVkrd0M3aFlV?=
 =?utf-8?B?VjVxbEE2Wm8wKy9VUnZsbldoYjNJN1NKUUt3NDQ5N0ZGRzg1bGdBS1VEOU1G?=
 =?utf-8?B?YTNXVWpMM1VwVHpDRHdWejMxbWU5L1VVUThPbmxCNHp2aGxiNzJwbWxrVkR4?=
 =?utf-8?B?SWRwUDlxY0R4OFh2U3I1S2J6cldaaytGMWtCSTJzSjJFTS9ybzNKb3dOSm00?=
 =?utf-8?B?U3hITVdiMTdJSDRGeEY4NW5ubVBzZHRudkUzdWJnQjRjTWIvNklFUFQrc0tC?=
 =?utf-8?B?TWx1TXErRzhHVmJNeWc1ekRKaG80Tk9wTUZuSkdBNDVKVkt5VFNJckxER1pE?=
 =?utf-8?B?UDMvRkwvbEdRYlhKVG5Qc0xrUzFYUS9XS1FkK1Vmczh6REJLSUNVbC9ZNUtt?=
 =?utf-8?B?QmYxNDVhTE0vV1lkUllYRlpZbWlGM3lGRWZVY2NCcUl3K0o5MGsrc2paTkVy?=
 =?utf-8?B?c1NlcGhDTkpiTTRsc1JsRXlSUVV2QXJhUGMwSkgyZEpqZ3huRklYL0NEZHVD?=
 =?utf-8?B?T3JjYUMxTGl3N3VyaGxnTG9wZmtQNnVJYzVUOTN2aU5KTGxsTFJ0K3lENEJY?=
 =?utf-8?B?ME1NZ0FVUllsMDl6eERhSXlWVHlUWkJ2MGhpRzJzV1ROU2JadHdUaWU4Q29R?=
 =?utf-8?B?aitVUVRoRVNJMlJtRS94UHBqaDI3WTE4K1VDakJEZkZaelN6Nk5WVGZhTDJo?=
 =?utf-8?B?NGpVT1B2VXYzYkpIVVJYdzA0dlUvSFFqVUlrWDdjWSt6SHJqNEVFNWtMOFhz?=
 =?utf-8?B?NmJpbmlWRHJmS040dVhKR01rMlJzUk1yQ1RRbzYzRjZJak5TRjRoMFhIa0lO?=
 =?utf-8?B?L3dtZjVtQUdqQVB6TGJmblhxMkk5QmxNTGpOak9ybWJuR0RxVDBWVkFoQ1l6?=
 =?utf-8?B?VzlyTUp0MnRqUnQ4K2g5QXNFUUdVL2xGVEVtSmJKZ1RpaG9KdE02Mlc0dEpB?=
 =?utf-8?B?MjhTRmg4aGxvUjlSM3l0NHNzYkhoTUF1L05DRDJBWjY3V1I4RUQvUlVwSEYw?=
 =?utf-8?B?dTVoc0lzNVRJMTVqbVpPaVJwdzQzcXVlSGMyUWpKY0kzVXF4TXVmWlVMU3pm?=
 =?utf-8?B?U0h2RituditnSThoOXpvMGdYVndKU3p3NnJBbmc4emY1YzlucmtUNmg3WFhm?=
 =?utf-8?Q?uITtKdz7hb147GBp/4ghaIPSa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b66664-542f-425f-65d1-08daf52fc4cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:31:14.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWVEWP7Et8AUemeW2jZYgoKYd7C25K1D+q7Rlui8DZK1nk5fMFuNQpDSDcvJp23vCnkURhoPV/H/+paZbvKsNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 1/13/2023 11:07 AM, Mario Limonciello wrote:
> On 1/12/23 23:21, Wyes Karny wrote:
>> Currently writing of min and max perf register is deferred in
>> cppc_set_perf function. In CPPC guided mode, these registers needed to
>> be written to guide PMFW about min and max perf levels. Add this support
> 
> This is generic code, so  I think rather than PMFW you should just say "the platform".
> 
>> to make guided mode work properly on shared memory systems.
> 
> on AMD shared memory systems.
> 
>>
>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> 
> With the commit message cleaned up:
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Will do the cleanup part. Thanks for reviewing!

>> ---
>>   drivers/acpi/cppc_acpi.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 02d83c807271..c936ff503965 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1487,7 +1487,7 @@ EXPORT_SYMBOL_GPL(cppc_set_enable);
>>   int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>   {
>>       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> -    struct cpc_register_resource *desired_reg;
>> +    struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
>>       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>       struct cppc_pcc_data *pcc_ss_data = NULL;
>>       int ret = 0;
>> @@ -1498,6 +1498,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>       }
>>         desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>> +    min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>> +    max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>>         /*
>>        * This is Phase-I where we want to write to CPC registers
>> @@ -1506,7 +1508,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>        * Since read_lock can be acquired by multiple CPUs simultaneously we
>>        * achieve that goal here
>>        */
>> -    if (CPC_IN_PCC(desired_reg)) {
>> +    if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
>>           if (pcc_ss_id < 0) {
>>               pr_debug("Invalid pcc_ss_id\n");
>>               return -ENODEV;
>> @@ -1529,13 +1531,11 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>           cpc_desc->write_cmd_status = 0;
>>       }
>>   -    /*
>> -     * Skip writing MIN/MAX until Linux knows how to come up with
>> -     * useful values.
>> -     */
>>       cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
>> +    cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
>> +    cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
>>   -    if (CPC_IN_PCC(desired_reg))
>> +    if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
>>           up_read(&pcc_ss_data->pcc_lock);    /* END Phase-I */
>>       /*
>>        * This is Phase-II where we transfer the ownership of PCC to Platform
>> @@ -1583,7 +1583,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>        * case during a CMD_READ and if there are pending writes it delivers
>>        * the write command before servicing the read command
>>        */
>> -    if (CPC_IN_PCC(desired_reg)) {
>> +    if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
>>           if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
>>               /* Update only if there are pending write commands */
>>               if (pcc_ss_data->pending_pcc_write_cmd)
> 

-- 
Thanks & Regards,
Wyes
