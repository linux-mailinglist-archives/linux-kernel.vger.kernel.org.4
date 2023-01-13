Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D5668B94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAMFhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAMFhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:37:11 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2B0E25;
        Thu, 12 Jan 2023 21:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjI2r2OHtzP3QXh7l669AZkd4XXOu7L95KANJQ62BgBk78As5Ex6HQbhsG0ea+PfVnbFCc2AfS6K1dQEHfXEiECB2l0F0uM1ulCrMQxz9NyPmPe/6sxHBC/BdG3wI+TJvU5Y3WazSeeJgSVEJLpUL5rqVE9mYBYw4rNmNMFdtjwWT9hAhohZmBPJlU94AUpKdt5JYoj1aIOKytEKynKJi4BySHdqaN9lBKBnP8NpPxHlaIt4fmgsJ0/INLgydEmdyvjXwhYMZqx6cQej/vzWJoUYAv13Dqj7RKraNYHizleUBw6RcJL6bA1RyI4rxhDZNqYabe+6S2vWNCrNFeAsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My0UomKHrgn3jwzeSmDSvyiRLQwVvyugCSnz8s+fkKY=;
 b=JKOq1mT+lJb8j7NHBnINPHR6XZafAZsT6ev72fFvwMQ2tRLGfi75uwwfd8VCccYUFOlYouFiEEFN8rZ4y07SYrRZIKLvimI4DEmvQfPKlv2fQKCPCiEZtVgkiO7AE/xHbHas7FpRXW9dcGXXZ6zwZI7E/e2iny8qOSRHEtwYmdyIJSsEpWddsR/ezlV7SFcsgwUOoNi48j4/woDuHQDZDub0udQnSSf79bCUpclFIkugYWDb4a7eIdLnFKq7j7+lNjiqPByO8QEZyHZqrSMyVPfhKsQPoi4jxk3ilvkI9pFkA7JEUevwgUrmHCu6p5NMYNYpx/NPZOor5VqGnrzlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My0UomKHrgn3jwzeSmDSvyiRLQwVvyugCSnz8s+fkKY=;
 b=17rKcsUw4uIZ6KxP1XDh6pJj4iCt/9ptvIekvEnrfo8B1iZ7tMZzeV1RaaK7RhsFTv1vh6X3Lq1ZfsMJ7E4WFyZwcLTZSOftrynGq5/RM8jKqPE96Gcrs1VrS7X5wd4OoayUc0kQc0yDjsrf8y0zZcy1lm3MRcMHp8VlDZmAvZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 05:37:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 05:37:07 +0000
Message-ID: <85925bce-f30a-b2df-309f-bd4b510a117c@amd.com>
Date:   Thu, 12 Jan 2023 23:37:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/6] acpi: cppc: Add min and max perf reg writing
 support
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
 <20230113052141.2874296-2-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230113052141.2874296-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:5:337::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d5ce29-7681-4f9d-67ae-08daf5283547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyHDsHfZJXXnDirEMNsKYEwbY5kXekCBtU0I+Y+XZCo6ppLxBh4cJ+An0TTlmBmB848Gx7Jbb+9cNRS4++4/p/ye5RdxsgR71Cwx+xYLSYbyz9Yn29wQZln1Uu3XpHmPG2MVesdg/+9Zlavvn+/YbypSpfiCBgiE9FZYXYZaUPOswLd1FAFEs2L/toL2tblAArJDkQStXTeu4QyiuYU4gvwzNzngaeYBUQ09X4g0v/DphnnDI0OkX4+bwCQPH8jSXgvDZF7pj19CMPOUL6fr/i1qDKCTYsThwjwCbqcwnuS9o5SFlbkHJV1uxp5mMy5I7y92UK7OA3QXqbMlQ5e4BewxvjkS9nz5ARt10MjGQbCKQrW01t16hnn19mjiljhFAjTj32rzBhIm+0s4C25HGd7ittTrBG9DYKmwK4HCivsSjvpeDB8ZkAB2NL2gxrBZ0ZBiCS3fiq+6Njf1p7hP+HuO9kKQIBhG6FuVMouYccF0tW2vOJF/wYw2pbp2tBrtSuegikVepFfld7vtmUVBUMn/hnVZwax+1r4ebTleERJ/W9lt+P+oQ7gsjtECOK3N+b9EaL5QUou/jc/4JNsUJIdzhlYJByLvPDdfqTzkGAwzkeDhudUulsbUFMRqiwMfga6n3ATL1J5TgHOTooBxBk11PImuqIHPN0EataDik3U35xCWcmNwU6yoeRYaNo2iV/QIqMGxD587YVxboKZ1dmNv2Y71ajnv9BSDAnR3cSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(8936002)(2906002)(5660300002)(41300700001)(66556008)(4326008)(8676002)(316002)(66946007)(66476007)(110136005)(6636002)(6512007)(38100700002)(2616005)(86362001)(44832011)(31686004)(186003)(31696002)(83380400001)(36756003)(53546011)(6506007)(478600001)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJjK3o0Mk54bitjWVQ4eTBZd2xSajJQaGF2OVNVcVIrV2p0L3YzelJ2U0Nk?=
 =?utf-8?B?WGEyT3ZqNkVSSFg3dDBZK1NhN0lBaDYrYjhRV0tkTDBIMjhDbzhSZzMzeXhh?=
 =?utf-8?B?dnU5ME9KbWREOWFmRy9CWUhEV05EOUZ3eHVoM0prZk5Nd1pROWFzTmdtU08r?=
 =?utf-8?B?SkZoNEhJWm9BVlRXcm45VU9hY3VoNWsyK0pmSFF6ck1ON3ArMG5hc0d0YnEr?=
 =?utf-8?B?cjlSTGNvTFZYMmdVZlIvRlpvUUdUSVpFUmx3NEw3MWFZWXk3K3VHY1hNYS9K?=
 =?utf-8?B?TC9BaTVJbW1iSy8rend2R08rbjFKejEwVUZ3akllRjNBMVV5R0dvUWVrcmVo?=
 =?utf-8?B?ZjlzR0RzVkxkS1UvazVGdVZDUldZYWJSNmttRUkzUjBxRldtcGZabTZOWjFy?=
 =?utf-8?B?L2xwVnAxMnFnem5pcnpIQTA3dklNbmJxMHJiRlJ6SnZ0SjVGZ0RhZ2xmeVox?=
 =?utf-8?B?S1pTb1dmRml0M28rUFFFOFNyTUpGSG51czNHTVFpNm90NGFpb1l5QUZicWVF?=
 =?utf-8?B?cno3TGZYUzRNeVRDMXY4bjd5eC9aL1lLaEh5N00wZW0yR05aNzhCS3UxL0Uw?=
 =?utf-8?B?RElTTlZrYkoxbFFkYnN1NjkvOGN1YVpxT1l6VWtwU1hlMklaTjQyRlA2NG83?=
 =?utf-8?B?c1NQWnRrYVdzY3BGdlVobm13bllYSTRZdjBMUW9OZ1ZhNXlaaDhUZnh4N0k2?=
 =?utf-8?B?UnBTWVIvUXhSSzFIYTJKWlJxTDRpYldwZHo0UUJRUnJjZXZYb0d5Y0dIcjFX?=
 =?utf-8?B?Z0EyQ2F3bGpXS2ZDOFhhNlhSWFpKV2xucEpZQXdxQmVYN2FoeldEbHo0VVMx?=
 =?utf-8?B?eVNjMlFrdFUreVJ0UHFpQ0g5T3doWk9CUldqd2psa3p3QjF0NDQvUzh3elFt?=
 =?utf-8?B?cHJINjVPRDNGdk1pZTVOdW1nR3ZQeEhwMkJiM2RMcmF4RGtkeVdIeHBST1NS?=
 =?utf-8?B?bG1sZHFoSzRWRHZQSmo5b29QenFEb2JvQ24vZDZQWmcvblhha1lYUlVhaDJ6?=
 =?utf-8?B?MzdPUkN6bE1tOWRneko0Ny9XZzdDSS9VRlJHQUpLL3lLOVE1RU1iR0NqdXRy?=
 =?utf-8?B?QWRUbVRxZ0c5QmJZc09DbGRzMjlpMnVmWXZBOS9JVWdlWkZ2RU5QOGF2U3NE?=
 =?utf-8?B?V3hUNU9qU252eVBZR3lPZVViVU9BeDVHMHhheVpWWHhROGlJT2ZIVFlvSHlw?=
 =?utf-8?B?Q1dpQU9ib29HVkpodTM0NTA2VUJsekE5cjRLRHp2eDBlNnN5Vk9CTTJmRWRG?=
 =?utf-8?B?T1d4T0tjZmlxbUhhZTNMMGxMbmhURFJZNFNIK0ZEbUJpc1J1VkpLV1hTSWFI?=
 =?utf-8?B?QlM4a2NubDM5L0hSeEdOTStnOThydWoyblBCSktMaTJzbW5rV0Vya0RURGN6?=
 =?utf-8?B?VHRZZHJENGdnM2t5TFpDdHhVaVBNeWJHMGl5WjNXKzB6aUl1alNlSEhkam1V?=
 =?utf-8?B?bi9SZVVzN2t3UUtsc29INGZkUDhYZEwyTFhTZW1KV0cwMmFZck9tbUJ1UkxD?=
 =?utf-8?B?ZUhQbFhkaFRJTW1DMmFRNkVzRmw5cUthUENWbmxQVlNSeE5kUFRRYk1CaWdh?=
 =?utf-8?B?U3gxTGRwZUlKOVdTSnY2ZG51LzRYRFgxNUd1a3hkdUlmYURZTHlFOXIzOHR4?=
 =?utf-8?B?U1lUN0tiaUI1NGFCV2hrSHpGN1pLZ0NvVjJ0T0lNZ293UktMbkpuWWtMZDhJ?=
 =?utf-8?B?czVqWVIvOVNKOUJnY1A1bUoxMzI3R1pqdzV4TWR1ZnJuWTYwMjc3OVdYQ2FO?=
 =?utf-8?B?NEdlbEpINUlmRjN1WlFDZG5MeDZnZWZKcTB6ZCtHVUlOQ1pnREMwRmxZOFNG?=
 =?utf-8?B?UVY4dFpFZFZzS05OdTdRNVQ5aEplWUhrWUxJd3k0WlBhb2x5NGE5ZjZ0WjUv?=
 =?utf-8?B?UEtDOVM0RFFidE5kYXl1SFN4MGVPVFdrUkRhaUY4TUZPMEdYM2krc1ZUaE81?=
 =?utf-8?B?NHF6bjE2QWEycnNVWVd2QUVydEJVZ2cyQ3ZLYXN1dGZFbXg2R2pmNHoycTlK?=
 =?utf-8?B?VGtIRDlxNy9OYnlsSkdrb2RsV0h3RW1IcGFNa1JnNjFLWDgyODFnOHVzOHdE?=
 =?utf-8?B?RUpSRmljRHE4Sy91TlVNTUpNWFhBbVY1TWMwQVVIakhmY3ZKY1greDRwOXRj?=
 =?utf-8?B?TFBONEdJaHBTSDYxRnZweExwT0MvL2Z5VXc3Vkw5OUQ1WVZsNGVIQ0hibGxw?=
 =?utf-8?Q?cw/wgjbeJpNW7s4sDVCvNOd8qOH64HYvWNIG+3j6FQ/f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d5ce29-7681-4f9d-67ae-08daf5283547
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:37:06.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ybvW0OhsRc6IJcQSMWYxPmYSpFTwCAf4x4bhnPtMxouwvCgabBnxIaehjTqNwFa6BuEoeZsEId5C+sV4q6zFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
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
> Currently writing of min and max perf register is deferred in
> cppc_set_perf function. In CPPC guided mode, these registers needed to
> be written to guide PMFW about min and max perf levels. Add this support

This is generic code, so  I think rather than PMFW you should just say 
"the platform".

> to make guided mode work properly on shared memory systems.

on AMD shared memory systems.

> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

With the commit message cleaned up:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 02d83c807271..c936ff503965 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1487,7 +1487,7 @@ EXPORT_SYMBOL_GPL(cppc_set_enable);
>   int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   {
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> -	struct cpc_register_resource *desired_reg;
> +	struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>   	struct cppc_pcc_data *pcc_ss_data = NULL;
>   	int ret = 0;
> @@ -1498,6 +1498,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	}
>   
>   	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
> +	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>   
>   	/*
>   	 * This is Phase-I where we want to write to CPC registers
> @@ -1506,7 +1508,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	 * Since read_lock can be acquired by multiple CPUs simultaneously we
>   	 * achieve that goal here
>   	 */
> -	if (CPC_IN_PCC(desired_reg)) {
> +	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
>   		if (pcc_ss_id < 0) {
>   			pr_debug("Invalid pcc_ss_id\n");
>   			return -ENODEV;
> @@ -1529,13 +1531,11 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   		cpc_desc->write_cmd_status = 0;
>   	}
>   
> -	/*
> -	 * Skip writing MIN/MAX until Linux knows how to come up with
> -	 * useful values.
> -	 */
>   	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
> +	cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
> +	cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
>   
> -	if (CPC_IN_PCC(desired_reg))
> +	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
>   		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
>   	/*
>   	 * This is Phase-II where we transfer the ownership of PCC to Platform
> @@ -1583,7 +1583,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	 * case during a CMD_READ and if there are pending writes it delivers
>   	 * the write command before servicing the read command
>   	 */
> -	if (CPC_IN_PCC(desired_reg)) {
> +	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
>   		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
>   			/* Update only if there are pending write commands */
>   			if (pcc_ss_data->pending_pcc_write_cmd)

