Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059E69EF25
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjBVHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVHPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:15:24 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41734313
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:15:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8Pl0ICcIaXtxSKFNlgvwtGiIGp+YMjqygwif2yRNgzVJMNCFfX/zXthHh9jQJRU2s0RFS05vuvVSmDyz3whXLaAmKiAqj/s/8iIfAPmWk2hLSRGQfILTuprnjPxtg9hwflq21jkPbLU2bZs5opnNJu0ehgtv4Yzj/tV+BoqaIESfAvyJGhx84BuCPpJxLvLtatogxPei0UtTt5ybHK5cY+hsXHe+ZX8UVChcw/3fNcWNZJuP6AInUhPAGkBpvfgM1VVJ/YT3qD675/US/1z4PS9ComHcGEBZeH64H0G3yYf9qiZrh9R8KcWrdGZM5slqbfA531C/CPkaPId7jUo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1nfF6+ZsmHoyXMx8EoBBhhd9H7NbxZxuoNeQ0ciZyc=;
 b=L6jh0h77jURhqFreTnlfz2r9y/J1fPBmd/uApkKnvrXOAJdjuRB8Kyt2MDXMz1y4ra5SqGUUvA6yaZknD7itGLqDXTwUCs/NNQ0A4qsr+kMjUcVFRLJWCgjQcUSzRkXxFPbQ4GdqhbLQfZIeRlwu8Q3uvguk8aEkdw/icHwIile8p4XwYckD9/tPPt32eSPLXQjAnkWpKQHlsDTkKPs0tHlqYv0w5EkABpE4LGmu1p7Z+Q/8MQD8Klej0+IrzTM5mSsA/ycmgqZOwLtYMx29OuO6c0+Cv4kujJpX9qPYsdhPQwjrRBeu9LZxL6lZd9QFhxEqhJmViTzwxbo8j+zyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1nfF6+ZsmHoyXMx8EoBBhhd9H7NbxZxuoNeQ0ciZyc=;
 b=2Au1pQlRufhg77S/SWOX/iMFDAp4J6B8uu4Ia5Pl26T+/UNSIsyRUnpHQb/2WBIz/3vogRhcg4OG0H1tyb3SVyqveqBPZ0XQIer9oiu9rGE2p/s2qqWG0D2WlozgFEpgdKN3wkmenhMttcsYUXrlhYO1M1f8qLdktAq7kiTYQT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 07:15:16 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 07:15:16 +0000
Message-ID: <591d19d9-9d98-0d4c-c061-759dc5dec738@amd.com>
Date:   Wed, 22 Feb 2023 12:48:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH V3 2/8] soundwire: amd: Add support for AMD Manager driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-3-Vijendar.Mukunda@amd.com>
 <03cac551-b77e-0109-5895-5a009e0fba61@linux.intel.com>
Content-Language: en-US
In-Reply-To: <03cac551-b77e-0109-5895-5a009e0fba61@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 26993d7b-9293-45bc-e130-08db14a48be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/GaibkDiMjXNyhzPNQ2n/ngKThU5UiaL7W8b+i7TfZk20NQN7Q6d6MZmPs0EJmChUISU5DH2/IHZYaOo27Wq4QyorWAEifx8IVnFeu2cj9IfZ1dkQ+lI+571g+mhqve97j6q/dvOd+e6t605hG6PWhik7MVdaRLIvpCi1UCbF0jjzJ0jvuLYeJU/RJB0pr69tfUna3Vxbo80607hnO+t0R51dmjnTC1AmsYFDEAjzXkOq/tORuB/pjaCzycY4/b+zMXPY/2OseOu79qnjS3j0JpkZM14mPUBxnUhY5tl7u8xNIff7zbB5LKJ4cFVXp1bWGThGQCwMlIGipi07TUDZGEHR2lB2ky9Tfz3GLUZrQNffrzYzW6C0JleiLtqN0RxLQxYBdtvJY5rRKPTL+5zXqMxtzE5cOt6MkJI0B7rZWdoiDwD3NcwexnjcH3sLgi+68fJJLr1ATm63htEepk3a8/uzV3cOF4yY5RnmmrzDRo4la3+UtPU5mIec3qoqMeg3zMMH6EKeRSHy8rvvKeTjgwLW5ETTTfmfdQYts8rWYM5ReS4ulnMxDjGsrAdmIn/Ert074Qkdu84wZC2K6GdnaIU/FhwLlMQ1A+KZPU38bpPxRXzrIoXMo7yfLnbUC9vrlBvGgjXFKJitZPyir07CoBdlHcvUCKICeC/gi4/rsEAuiPAWH4m0ZqYfgONBUeQwmCgbyLGkT5PuJqovvBcDPVy/2eXqsBsEsImmGQM68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(316002)(26005)(186003)(6512007)(53546011)(41300700001)(4326008)(8676002)(66476007)(66556008)(66946007)(6486002)(54906003)(6506007)(31696002)(478600001)(86362001)(6666004)(2906002)(36756003)(83380400001)(38100700002)(8936002)(2616005)(30864003)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1QvU093ZWtsSWpvNUVjZEtiRmt4ZkkybUZ6OE83M2h0RjVQdGl4V0hQSzZH?=
 =?utf-8?B?QlZBaGZyMTdMMU11NDZoSWRPS0VoQjBPS2lTcGphdThYK2JjVXdNZVdaWDc5?=
 =?utf-8?B?eUtLSTYyTWhXSnltem5xS1grRHJkWmR0dXJwYzJzMHVsM3RkRGZRSXlYN0ZG?=
 =?utf-8?B?aEhhMEdLdDBoejhOSjRoclpXWlBWeXpwdzArWnNyVVF2KzJIZnhVSHlBbW5T?=
 =?utf-8?B?SmtCSGt3blM1bStWYkFlVlBGNVc5QTBqU1NLMC9iMjIrSnhPSkxTWjdLNTBD?=
 =?utf-8?B?WVdwQWM0MXVWWElwMHZrQ0N6UUJ5cFJDVGxxWTNEY0lpeDlpYU1WUHIxMlU4?=
 =?utf-8?B?M3hWc0VGdXFjZFhzb0pZU3F5RU9hdG5QSXRlK3F1RzlmdjdBTFJHbjNPU2k0?=
 =?utf-8?B?WTdvMm5CKzVCQ1FwWW1xN0xaMlVyR3N5dWxtZzRZZ1RGS2ZhclNFd205REgv?=
 =?utf-8?B?cWl3bTd5MGhVZHV1TWw5KzNtWERsT2UxaFk5TFR1TDllZEJ5RkNSU1pWNG93?=
 =?utf-8?B?aHdzZVNDeklVWVB2ZFFBT3MwWmh0bXl2WTAzanVvVHNPNG9jVEpGTDhiaUVi?=
 =?utf-8?B?aEhWd3pscnd0VUtRazFQVlZ6a3ZRVk1hYzV4d3QvQmt4Y2YxQlMxemkwaDhk?=
 =?utf-8?B?TWRZYXJKVWJLMkdGd3pPcjFvb2lhdVFLUzFnN1NSeHpMZm81bTVkZ0Eza292?=
 =?utf-8?B?c2JMNlg4QS9waWNaVlN0akNWMzdvendlb1dNcXc2bzRDK0VudnFsUXdoMEZh?=
 =?utf-8?B?Mmx6NktSS0ZsdUIvQzJJYmdIWXk2dXJNVmxYOWdjTkNNdFA5cW1wUTlJaVhu?=
 =?utf-8?B?UWpHNlI2UC8wOGtZMDR4L3pscGNzV0tyRE0xdzJmelBucWwwVjV4bU1pdkdO?=
 =?utf-8?B?Vm8yTUR5TlU1d2NJcVFaZUxoR3VZd1lIT0pIMHMwWllIdFhHelUzMkxpaXo0?=
 =?utf-8?B?aVMwNzBmdXBXV2dJeFFDVnlaQXR3SWV5UEl4YnVmQWNkQ1Rmci8yM1JKVjhu?=
 =?utf-8?B?aGJaeFkwOGtqdWwwajVhZ3BkWC9rNHBYaEdIR2pjK2lNUWNQS21PZWc5MGtj?=
 =?utf-8?B?L1Y4M1NLRTErbUdvQUkrYVY1dlJEdE85WEFhaFVxSVJ1RVFpRXZVaUhtZDlR?=
 =?utf-8?B?UFZSZmVaMWVtWmtUeUgzUnA3aU92RGkyU3FJZmxhYVZrVUdodHFuZE1CVDRJ?=
 =?utf-8?B?SGM3M1orMkZDWGYvSXNrK1VLVE9mUGZRcm1FTnNSdk1UV04rbURqSko1RGlG?=
 =?utf-8?B?VWYvUzdwVFY3dWYyR25RNjA1RENrT2FpQlhaenVmcHdiUWwwSnRhSzcvb0Vj?=
 =?utf-8?B?OExaZ2kxN3E4UWRZYVZSL25CeHhiRHBkaFBGZDJPazNzcTVmVXczUUdFZDNV?=
 =?utf-8?B?dUpFVEZPTm03OXNUK1dLYVFoK040KzlxWlFVNk5ZWCtlYWV3QzFLMElIWnJP?=
 =?utf-8?B?VkRjZW11L3d0M3ZvVWxLNUptZENYSklCRXpkUVNwZWwrN3Q1SCs0Wi9kd2J6?=
 =?utf-8?B?UWRCSmY3Vjh0bDRFZGhsd3Bac2J5MjZHWGRCL2U1a1NvaWJ1S21ZQmo4Tm5r?=
 =?utf-8?B?eFA2cFN1V0NWb0dzMW9ZNkJMb3M0QVdBWHF4eGljMUZpUHJscW4wZXFXL0Z6?=
 =?utf-8?B?SmZTaVNRaFNQVmRvaWloOEZySmxCV2NWNko1bnUxK2tnWlI5c1M3aWtnZTNk?=
 =?utf-8?B?WnNuMDdJMklHQkU1ODZ3SmRUSHNvT01LdzF5dlJkVGE1OG5sWFJFUVlyNzc0?=
 =?utf-8?B?RDJma3JlUlhYU3N3NjdPUk5FUnY3Z3NxUTI0dVVUREVJTnJIVkVhdkJsV1RL?=
 =?utf-8?B?dzlyb2xWbEEvNnU5Tm1iUGxZZVJHWHdkNnAvR1ZrRERiV1RtMzdia0JGYytw?=
 =?utf-8?B?UzNXaEM5MzlKcklqRXh5VFJmYVVDTVc4M0MvMk9rTXJpd3ZackVoaVgycmd3?=
 =?utf-8?B?cFlONkdNSlNIemNoLzk5ZzNxenRtb2lqWk54dzZaQWZvM1F1R0t6djJZVEZK?=
 =?utf-8?B?TVA2d3RPSWlsWHoxRkkzVGtiT3hLRWRFWEJWVmpTLzJOMG9ydGxhbFVZSlBi?=
 =?utf-8?B?OWZ0NnlSejZqclhadXFMQlRtTzlHT3hiOUg5TjhJSWVIWDdPQWd3MWRBQkV1?=
 =?utf-8?Q?ZbF2xm3up3tDFF7pj0+RsJNfw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26993d7b-9293-45bc-e130-08db14a48be2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 07:15:15.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvvjR2awEHmHG0wP2E1RDCq7oDglggD4D7Xq0Q7kjmfy1xsWuM9JFLPnZDEe8BIDuNAwWFinCZ8OPT4ZMOWxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/23 21:27, Pierre-Louis Bossart wrote:
>> +static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val;
>> +	u32 timeout = 0;
>> +	u32 retry_count = 0;
>> +
>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>> +		if (val)
>> +			break;
>> +		usleep_range(10, 50);
> that's a 5x range used for all usleep_range() in this file, is this
> intentional?
>
usleep_range(10, 20) will be enough.
Will fix it.
>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>> +
>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>> +		return -ETIMEDOUT;
>> +
>> +	/* SoundWire manager bus reset */
>> +	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	while (!(val & AMD_SDW_BUS_RESET_DONE)) {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
>> +			break;
> so if you break here...
>
>> +		usleep_range(1, 5);
>> +		timeout++;
>> +	}
>> +	if (timeout == AMD_DELAY_LOOP_ITERATION)
>> +		return -ETIMEDOUT;
> ... this test will never be used. the timeout management looks wrong?
Yes it overlooked.  Will fix it.
>> +	timeout = 0;
>> +	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	while (val) {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
>> +			break;
> same here...

>> +		usleep_range(1, 5);
>> +		timeout++;
>> +	}
>> +	if (timeout == AMD_DELAY_LOOP_ITERATION) {
> ... and here.
will fix it.
>> +		dev_err(amd_manager->dev, "Failed to reset SoundWire manager instance%d\n",
>> +			amd_manager->instance);
>> +		return -ETIMEDOUT;
>> +	}
>> +	retry_count = 0;
>> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>> +		if (!val)
>> +			break;
>> +		usleep_range(10, 50);
>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>> +
>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>> +		return -ETIMEDOUT;
> that one looks correct though.
>
>> +	return 0;
>> +}
>> +static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>> +{
>> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
>> +	u32 val;
>> +
>> +	mutex_lock(amd_manager->acp_sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	val |= reg_mask->acp_sdw_intr_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> here you handle a read-modify-write sequence on the INTL_CNTL register...
>
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> ... but here you only read from the same register. what's the purpose of
> this read?
This read to print the register value.
This register read is really not required. we can drop dev_dbg() statement.
>> +	mutex_unlock(amd_manager->acp_sdw_lock);
>> +	dev_dbg(amd_manager->dev, "acp_ext_intr_ctrl[0x%x]:0x%x\n",
>> +		ACP_EXTERNAL_INTR_CNTL(amd_manager->instance), val);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_STAT(amd_manager->instance));
>> +	if (val)
>> +		acp_reg_writel(val, amd_manager->acp_mmio +
>> +			       ACP_EXTERNAL_INTR_STAT(amd_manager->instance));
we will also remove ACP_EXTERNAL_INTR_STAT register update code.
This change has side effects.
ACP_EXTERNAL_INTR_STAT register should be updated in ACP PCI driver(parent driver) IRQ handler.


>> +
>> +	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
>> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> can you explain why the writes are not protected by the mutex?

ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7, ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11, ACP_SW_ERROR_INTR_MASK registers
are soundwire manager instance specific registers whereas ACP_EXTERNAL_INTR_CNTL register is part of ACP common
space registers will be accessed by ACP PCI driver and other DMA driver modules, which needs to be protected by mutex
lock.


>> +}
>> +
>> +static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>> +{
>> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
>> +	u32 val;
>> +
>> +	mutex_lock(amd_manager->acp_sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	val &= ~reg_mask->acp_sdw_intr_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> you don't have the read here as in the enable sequence to presumably
> that wasn't needed?
please refer above reply.
>> +	mutex_unlock(amd_manager->acp_sdw_lock);
>> +
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> same, not clear why the writes are not protected?
please refer above reply.
>> +}
> ...
>
>> +static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lword, u32 uword)
>> +{
>> +	u64 resp;
>> +	u32 resp_lower, resp_high;
>> +	u32 sts;
>> +	u32 timeout = 0;
>> +
>> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	while (sts & AMD_SDW_IMM_CMD_BUSY) {
>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +		if (timeout > AMD_SDW_RETRY_COUNT) {
>> +			dev_err(amd_manager->dev, "SDW%x previous cmd status clear failed\n",
>> +				amd_manager->instance);
>> +			return -ETIMEDOUT;
>> +		}
>> +		timeout++;
> no usleep_range() here?
will fix it by using usleep_range(5, 10).

> Also is there any merit in using the same retry count across the board,
> this is about command handling, not enabling the hardware - presumably
> this should be tied to the SoundWire bus frame timing, not internal delays.
>
>> +	}
>> +
>> +	timeout = 0;
>> +	if (sts & AMD_SDW_IMM_RES_VALID) {
>> +		dev_err(amd_manager->dev, "SDW%x manager is in bad state\n", amd_manager->instance);
>> +		acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	}
>> +	acp_reg_writel(uword, amd_manager->mmio + ACP_SW_IMM_CMD_UPPER_WORD);
>> +	acp_reg_writel(lword, amd_manager->mmio + ACP_SW_IMM_CMD_LOWER_QWORD);
>> +
>> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	while (!(sts & AMD_SDW_IMM_RES_VALID)) {
>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +		if (timeout > AMD_SDW_RETRY_COUNT) {
>> +			dev_err(amd_manager->dev, "SDW%x cmd response timeout occurred\n",
>> +				amd_manager->instance);
>> +			return -ETIMEDOUT;
> usleep_range?
will fix it by using usleep_range(5, 10).
>> +		}
>> +		timeout++;
>> +	}
>> +	resp_high = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_UPPER_WORD);
>> +	resp_lower = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_LOWER_QWORD);
>> +	timeout = 0;
>> +	acp_reg_writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	while ((sts & AMD_SDW_IMM_RES_VALID)) {
>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +		if (timeout > AMD_SDW_RETRY_COUNT) {
>> +			dev_err(amd_manager->dev, "SDW%x cmd status retry failed\n",
>> +				amd_manager->instance);
>> +			return -ETIMEDOUT;
>> +		}
>> +		timeout++;
> usleep_range() ?
will fix it by using usleep_range(5, 10).
>> +	}
>> +	resp = resp_high;
>> +	resp = (resp << 32) | resp_lower;
>> +	return resp;
>> +}
>> +
>> +static enum sdw_command_response
>> +amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
>> +{
>> +	struct sdw_msg scp_msg = {0};
>> +	u64 response_buf[2] = {0};
>> +	u32 uword = 0, lword = 0;
>> +	int nack = 0, no_ack = 0;
>> +	int index, timeout = 0;
>> +
>> +	scp_msg.dev_num = msg->dev_num;
>> +	scp_msg.addr = SDW_SCP_ADDRPAGE1;
>> +	scp_msg.buf = &msg->addr_page1;
>> +	amd_sdw_ctl_word_prep(&lword, &uword, AMD_SDW_CMD_WRITE, &scp_msg, 0);
>> +	response_buf[0] = amd_sdw_send_cmd_get_resp(amd_manager, lword, uword);
>> +	scp_msg.addr = SDW_SCP_ADDRPAGE2;
>> +	scp_msg.buf = &msg->addr_page2;
>> +	amd_sdw_ctl_word_prep(&lword, &uword, AMD_SDW_CMD_WRITE, &scp_msg, 0);
>> +	response_buf[1] = amd_sdw_send_cmd_get_resp(amd_manager, lword, uword);
>> +
>> +	/* check response the writes */
> revisit comment, grammar does not add up - missing to/if/after?
will fix it.
>> +	for (index = 0; index < 2; index++) {
> what is the 2 here?
2 denotes SCP commands response buffer count.
>> +		if (response_buf[index] == -ETIMEDOUT) {
>> +			dev_err(amd_manager->dev, "Program SCP cmd timeout\n");
> that's one log here, possibly 2 ...
we are checking inside loop.
>> +			timeout = 1;
>> +		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
>> +			no_ack = 1;
>> +			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
>> +				nack = 1;
>> +				dev_err(amd_manager->dev, "Program SCP NACK received\n");
>> +			}
>> +		}
>> +	}
>> +
>> +	if (timeout) {
>> +		dev_err_ratelimited(amd_manager->dev,
>> +				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
> ... and one more here. Is this needed/useful?
Even if any one of the scp command response reports timeout , we need to return timeout
error.
>> +		return SDW_CMD_TIMEOUT;
>> +	}
>> +
>> +	if (nack) {
>> +		dev_err_ratelimited(amd_manager->dev,
>> +				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
>> +		return SDW_CMD_FAIL;
>> +	}
>> +
>> +	if (no_ack) {
>> +		dev_dbg_ratelimited(amd_manager->dev,
>> +				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
>> +		return SDW_CMD_IGNORED;
>> +	}
>> +	return SDW_CMD_OK;
>> +}
>> +static int amd_sdw_manager_probe(struct platform_device *pdev)
>> +{
>> +	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
>> +	struct resource *res;
>> +	struct device *dev = &pdev->dev;
>> +	struct sdw_master_prop *prop;
>> +	struct sdw_bus_params *params;
>> +	struct amd_sdw_manager *amd_manager;
>> +	int ret;
>> +
>> +	if (!pdev->dev.platform_data) {
>> +		dev_err(dev, "platform_data not retrieved\n");
> can this happen?
not needed. we can drop this check.
>> +		return -ENODEV;
>> +	}
>> +	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
>> +	if (!amd_manager)
>> +		return -ENOMEM;
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENOMEM;
>> +	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
>> +	if (IS_ERR(amd_manager->mmio)) {
>> +		dev_err(dev, "mmio not found\n");
>> +		return PTR_ERR(amd_manager->mmio);
>> +	}
>> +	amd_manager->instance = pdata->instance;
>> +	amd_manager->mmio = amd_manager->acp_mmio +
>> +			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
>> +	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
>> +	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
>> +	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
>> +	amd_manager->dev = dev;
>> +	amd_manager->bus.ops = &amd_sdw_ops;
>> +	amd_manager->bus.port_ops = &amd_sdw_port_ops;
>> +	amd_manager->bus.compute_params = &amd_sdw_compute_params;
>> +	amd_manager->bus.clk_stop_timeout = 200;
>> +	amd_manager->bus.link_id = amd_manager->instance;
>> +	switch (amd_manager->instance) {
>> +	case ACP_SDW0:
>> +		amd_manager->num_dout_ports = AMD_SDW0_MAX_TX_PORTS;
>> +		amd_manager->num_din_ports = AMD_SDW0_MAX_RX_PORTS;
>> +		break;
>> +	case ACP_SDW1:
>> +		amd_manager->num_dout_ports = AMD_SDW1_MAX_TX_PORTS;
>> +		amd_manager->num_din_ports = AMD_SDW1_MAX_RX_PORTS;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	amd_manager->reg_mask = &sdw_manager_reg_mask_array[amd_manager->instance];
>> +	params = &amd_manager->bus.params;
>> +	params->max_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
>> +	params->curr_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
>> +	params->col = AMD_SDW_DEFAULT_COLUMNS;
>> +	params->row = AMD_SDW_DEFAULT_ROWS;
>> +	prop = &amd_manager->bus.prop;
>> +	prop->clk_freq = &amd_sdw_freq_tbl[0];
>> +	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
>> +
>> +	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
>> +		return ret;
>> +	}
>> +	dev_set_drvdata(dev, amd_manager);
>> +	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>> +	/*
>> +	 * Instead of having lengthy probe sequence, spilt probe in two and
> typo: split.
>
>> +	 * use work queue for SoundWire manager startup sequence.
> The wording 'startup' is confusing in that you do not have a startup
> sequence as for Intel. It's just deferred probe to avoid taking too much
> time.
will modify the comment.
>> +	 */
>> +	schedule_work(&amd_manager->probe_work);
>> +	return 0;
>> +}

