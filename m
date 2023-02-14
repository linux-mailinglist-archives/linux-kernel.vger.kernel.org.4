Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C77695875
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBNFZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNFZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:25:41 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25918B29
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 21:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3bWKheo8k/bfAhm2J0LHyZGVhKpEIuip1Ik3JagjSQxj6Rl/AYmbbyh1wb5crSGmMmXNHY1QYLMR0WxE5avntuSutahtG9kjfX7YIL+fzevJpq0Q+HcduIMkD+kpxHlrw5AYa+zPMo90LI8TbjDDUEN8c2OojJrTWT5XKDIWeAxG/kjVR5kF8TEBTvr/fLwEebtXEbSqZ1DVNvwrVXacbetXJBrftSBCre8UUZOEsXBgSPuzTxdMxhUSLuxKi0trm2Uzso0waoF6CeiaeAsI3ZjBzNvH9J4JVMXaBJp0z7xxgbSNp4T9fLAk1Ih5rLHUBlp6RLrAejxkKblw0wzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6od+0QOySAblVXEIXtXOjlimQ8OmlEzfi0U0/5d6M4=;
 b=kTakj6Ape/jsX8mk8lTTiTFvd7QVGSaiNPOWeYjPVW4xQQTbwK47R5oFSNwLem2BID7DfIF2jmjrjgtm55/DOdDcw50EM0+mgZYLhUbKynqmfvZ+vpA6EDQCVq0SsRpiOuZvuiLq+ocIdSPSOgDOEF9RyMxoOv6218Wm1H3zyUcYszY8+k/5ad3zhNK9vIN2YQ5029xzNnM4hjy0g9YZ3Jax6mfTBtAmPrdc97fU+rLSqXSur/ML/czp+waRH1x9qY4VRYBXXmCE2G8qtiE1R1sEiUiLH7cFfXtYNNPXN5NXOxjFWZIe/ZFqxGeqGfr7eWw6kaGXtqIH57lzRDGzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6od+0QOySAblVXEIXtXOjlimQ8OmlEzfi0U0/5d6M4=;
 b=k4ogF/vMRazoPwNbw6pdlww7Z21O6bq2Z7lv6cgPCOIQl0ZIfEYh9B4tyGIKNl7qKqcoC22lPmJ8wKr26Fxs4+xCae883jIr2EtTb4Nc2JEi8xmUbnUTOkdnWfmN9205jI5OyMG/uX/IHTbKu6BK4H2gnYg96mC8mz7xW1lo3eQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 05:25:34 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:25:34 +0000
Message-ID: <7b5198f5-1894-5ab5-f84b-410cf102268d@amd.com>
Date:   Tue, 14 Feb 2023 10:58:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-3-Vijendar.Mukunda@amd.com>
 <a3a75ead-5430-ae32-a6ae-78314bc637f1@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <a3a75ead-5430-ae32-a6ae-78314bc637f1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::22) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e30fb35-7198-49c5-f573-08db0e4be5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cq2NVF5XFrg/mpMjZPEOUgl1zMbW03RdnV7WKsxg2q0u4MokPWfaXM/IgDsxzRv2agMNdKROSs4gOtU5PhyFHMFQB6zp9EhaMij0T+02lLDBTLA1IKr2wtq2NKN6CKEUVHEFlmSnwayHeyYOWMvReAJTWJxBQVG5kVXojgRzu4jdth6wjZLwqQ/YJD+8BvLfh1wasRdTnWaQzDqrcBGJYMNdeivsCLEgsHnNbhtEmGu5CUg4ThQacP6+prMaX86nsxepV8a9c3tH37wrKXI2x2YTKXJ+3NsuXiGiqiHuimfQWO0oJ+0RfbmSKEB1wj25SYwysnE2iStxRd933o8+t9LHZ/4iIxDfeo6jHGuVEYBZXF0eSC8c9VNymal+6SZ5DNV5U8uAOsbHk691tKV3zXzxFYNX6h5q/JWl8NLXk6qgizahcscKVi/ciuy45WebbyP7VsK6RJTKHPud97bygZAogAZJCg1eM0NMrMN2s/3FV8MfDedpaguvDYvTmJlze6zyOPkVT5uElgc6JQx1jzBxIxHFSVabh2rIzSRLE/iA2hd2qb7GERJiUfRbsryMuPHqGshsUWzSGBpqYs5pyKcEQ+hMYp8nk1/DZhjuNgC5XpLDnXgAdqk7TuiU5YukHiIiZ1CcCBDtGu6RjAkERdx+jQ1Pgf8G7z7nyaLkA0tZp1rVNsN5n1ubZ0eHsYGzoi81qiOhy4CMA3uixFul2LZw9l2xRPAvHWSIeaX8R/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199018)(31686004)(54906003)(4326008)(66556008)(66476007)(41300700001)(8676002)(8936002)(316002)(5660300002)(66946007)(31696002)(38100700002)(86362001)(36756003)(53546011)(6512007)(26005)(186003)(6506007)(6666004)(30864003)(2906002)(6486002)(478600001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnAzQ0ExalZOR0Rocm1jTzNQMFhwWDBOMXZqV2JvT0o0ZS9qajZUaWRhWWVj?=
 =?utf-8?B?U3ExazhtR3V1Y21vdytia3d0V3puYjhIdjcyVEpyRmxZRFg1TXZacWxmRzFp?=
 =?utf-8?B?cGFVK20vdjZkM2pGOWFta1VrU2JsdzlMSy92SStGZkZmZFBRTkdCZ3ZjTHVl?=
 =?utf-8?B?TGFNNWtXdmdLYjN0cEZ0dTNKL0VVMDVIdk9GdVJrZTk5TjhFL1I2Si8zQWpn?=
 =?utf-8?B?YUR3L0NhNDNTWW0yd1NCR0hIRUlNL00xN1Z1WWw2bDl3V1F4dVJhOE5QNTZQ?=
 =?utf-8?B?clF5STI5a0hXbk1pUDI4bUtxRGZnYmtlMTQzUWJ3Z0NUdHFuMitpN2lsUVF0?=
 =?utf-8?B?czFndEw3ZkIxU0ZqRyt1czNqdVJ2ZkV4akhGVHAybFpOZWtsazRjdFF4RDd0?=
 =?utf-8?B?bUlORWh1T0YxYUp6K3l5czl2TzJEU243Z2wvYlpwYVBWc1JQNXh6S0FCbG1K?=
 =?utf-8?B?d1dDSjc0cExOcFpOQm1zVE9XdkF2cXRtL1NzWE9uYTR1NmFuRTlZc0ttdVJR?=
 =?utf-8?B?ck92dUxjeTBaQnVDME8wcWZhaENTZmMzWmlvZEt5dHFzbDlmTG5FbFZ4SzU0?=
 =?utf-8?B?MDNLVmlabWN4NXpKelMzcXJmNHhHZE9yeTlvQ1h5Ky9naldSY0xBWkR4K1pD?=
 =?utf-8?B?N29FTXhOVm1ZRnhrdEZqRWtiZ0ZDRjFGRnFZYXM0ZEJSZFJyMFM0bDFJOWxa?=
 =?utf-8?B?SlFJa1RuUThid1dIRHFUSWNRREVZN0ZyVWxoYk8rL3dFQWJUTTZvT2VybExD?=
 =?utf-8?B?eVlMWU01KzhGbWgyRTZhYWcyd1pCY0lSb1JVbUtSK2E1WDdNSEFkblY4b0hE?=
 =?utf-8?B?Ty9Ma2g0cnJzbmlvdC9wM3hTdkh1YkpzUWNwS2p3V3NCUm1oQjZSWjYvdHBi?=
 =?utf-8?B?Q2VQODZrdjg4bXpzeFg1dk5oOWxyTFlZWURMTHo4THRTeTRGalZHa3VFNElW?=
 =?utf-8?B?VnpQK1JTV1V5VndVSWhidFZiUFVkdGNDK1VBMW9YVWhpaVVDQ3h3TmNjc0Mw?=
 =?utf-8?B?eHV1VHpBRFRXaGxuY1NncW1rWmErU3BtSGZJVTJwWCtUNysxRFdSSUYvQnBX?=
 =?utf-8?B?alp0ZWRmNVVhOFY3d0YySjZmc2J6UnlmaS9VRzBZVWFFVW5LNEpDb2RFM2cx?=
 =?utf-8?B?VDJrdmZQUGx4cjZnNXpIWW1pYmVwbm0yS1hkcE5FQktYSWRNWXl6dU9GSWN3?=
 =?utf-8?B?SzlJeHhUT0RpaTZtbDNsZ0NvQ3Y5YURnTGpvNXBudTZQTTN4bjBGQkxXUnBr?=
 =?utf-8?B?ZlNEOUdLRitkOTAyalh0dzMraDc4ZlYvcUtXaENXK0hZOEw4dU42TTgzZmFP?=
 =?utf-8?B?Z0RoUHlkVFVScUlsWkNwZTVUTzh0cU81ZFlNSWJWUG9NYXJBUEJNcE5jTkR6?=
 =?utf-8?B?OVhQYTAyR08vSUJYb0kzOTEvMnp4RWJad0ZPbGwwNHNwdnE1aEZCWnl4Q1NF?=
 =?utf-8?B?UzRrZXFqd3pEM2l1YktTS2twTWh4TTVpMk5yb2JwcC85ZjVrMmVpMVZtMkJi?=
 =?utf-8?B?Y0gxb1hjMkZyYUZHUEFmZUt2WkEvR2trWmNGRU9WWEdWa3p3TlhMaGlBQU8r?=
 =?utf-8?B?QUZhMWNLaEhwZ2IrQWRFMlIvRkVHNVIwTCszQkNPL3piSlVEbU95Q0pMTUN3?=
 =?utf-8?B?VW5CZUsrSHhmTUpYaHBjQWJ4NW14UU5EaEY0OEdzVjhKbzNzenBteGV0NE4x?=
 =?utf-8?B?NTBFaEJEcVdBSitrQXBnQ0U2NEVMamFjaENRd3p1RDVwSG9OR2hVaVlXYjhl?=
 =?utf-8?B?THdrT1R2cjVuUHRzcndzY0pYanRCanhvbGk2dmwwaXpMd2pqUFNPNjIvN3dQ?=
 =?utf-8?B?cTFBSVRUZjJYeE1WWkM1eGhYNU10QXZsTjFxQkZZemdzd1d0cFRxYy9ZN1BE?=
 =?utf-8?B?cldLWlZOWTN4RXA5d1VqTnQyVWJJcmR5KzRMTlQvU0J1NGJoYXBvT2VCbDdz?=
 =?utf-8?B?RHdmcjFFVUYxalduZStOTmpSMUxQVXJhV002SHdBRVpsSk1iM0FLOHZxeUhW?=
 =?utf-8?B?SkxNUlVqTEN4S1czV2tKOWVkTGNRS1dmWDU4eVYwVFBnbHJubXQ3MyttR0N4?=
 =?utf-8?B?ZnpuYkNCQ20xeElvc0R2cUNRUGRyNmtQUGZUNTEyRjNPVmhZUGE1bXY2cyt4?=
 =?utf-8?Q?GVeaKrjdyQicNZ+L25I9Ul2d7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e30fb35-7198-49c5-f573-08db0e4be5c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 05:25:34.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +54nbvjIYDuZNzDZrBCgWbF8rq/A0A5ID7zI/qKoayapCcfCNkndO6LsrtiZs/JCQt7OBi3G0zqyqZ5qi4wB7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/23 23:35, Pierre-Louis Bossart wrote:
>> +static void amd_enable_sdw_pads(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 sw_pad_pulldown_val;
>> +	u32 val = 0;
> useless init

Will fix it.
>
>> +
>> +	mutex_lock(amd_manager->sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>> +	val |= amd_manager->reg_mask->sw_pad_enable_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>> +	usleep_range(1000, 1500);
>> +
>> +	sw_pad_pulldown_val = acp_reg_readl(amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>> +	sw_pad_pulldown_val &= amd_manager->reg_mask->sw_pad_pulldown_mask;
>> +	acp_reg_writel(sw_pad_pulldown_val, amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>> +	mutex_unlock(amd_manager->sdw_lock);
>> +}
>> +
>> +static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val = 0;
> useless init
Will fix it.
>
>> +	u32 timeout = 0;
>> +	u32 retry_count = 0;
>> +
>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>> +		if (val)
>> +			break;
>> +		usleep_range(10, 50);
>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>> +
>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>> +		return -ETIMEDOUT;
>> +
>> +	/* Soundwire manager bus reset */
>> +	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	while (!(val & AMD_SDW_BUS_RESET_DONE)) {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
>> +			break;
>> +		usleep_range(1, 5);
>> +		timeout++;
>> +	}
>> +	if (timeout == AMD_DELAY_LOOP_ITERATION)
>> +		return -ETIMEDOUT;
>> +	timeout = 0;
>> +	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	while (val) {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
>> +			break;
>> +		usleep_range(1, 5);
>> +		timeout++;
>> +	}
>> +	if (timeout == AMD_DELAY_LOOP_ITERATION) {
>> +		dev_err(amd_manager->dev, "Failed to reset Soundwire manager instance%d\n",
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
>> +	return 0;
>> +}
>> +
>> +static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val = 0;
> useless init
Will fix it.
>
>> +	u32 retry_count = 0;
>> +
>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>> +		if (val)
>> +			break;
>> +		usleep_range(10, 50);
>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>> +
>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>> +		return -ETIMEDOUT;
>> +	return 0;
>> +}
>> +
>> +static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val = 0;
> useless init
Will fix it.
>> +	u32 retry_count = 0;
>> +
>> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
>> +	/*
>> +	 * After invoking manager disable sequence, check whether
>> +	 * manager has executed clock stop sequence. In this case,
>> +	 * manager should ignore checking enable status register.
>> +	 */
>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> +	if (val)
>> +		return 0;
>> +
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>> +		if (!val)
>> +			break;
>> +		usleep_range(10, 50);
>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>> +
>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>> +		return -ETIMEDOUT;
>> +	return 0;
>> +}
>> +
>> +static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>> +{
>> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
>> +	u32 val;
>> +
>> +	mutex_lock(amd_manager->sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	val |= reg_mask->acp_sdw_intr_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	mutex_unlock(amd_manager->sdw_lock);
>> +	dev_dbg(amd_manager->dev, "%s: acp_ext_intr_ctrl[0x%x]:0x%x\n", __func__,
>> +		ACP_EXTERNAL_INTR_CNTL(amd_manager->instance), val);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_STAT(amd_manager->instance));
>> +	if (val)
>> +		acp_reg_writel(val, amd_manager->acp_mmio +
>> +			       ACP_EXTERNAL_INTR_STAT(amd_manager->instance));
>> +
>> +	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
>> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +}
>> +
>> +static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>> +{
>> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
>> +	u32 val;
>> +
>> +	mutex_lock(amd_manager->sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	val &= ~reg_mask->acp_sdw_intr_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	mutex_unlock(amd_manager->sdw_lock);
>> +
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +}
>> +
>> +static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 frame_size;
>> +
>> +	frame_size = (amd_manager->rows_index << 3) | amd_manager->cols_index;
>> +	acp_reg_writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
>> +}
>> +
>> +static void amd_sdw_ctl_word_prep(u32 *low_word, u32 *high_word, u32 cmd_type,
>> +				  struct sdw_msg *msg, int cmd_offset)
>> +{
>> +	u32 low_data = 0, high_data = 0;
> init for high_data is useless
Will fix it.
>
>> +	u16 addr;
>> +	u8 addr_high, addr_low;
>> +	u8 data = 0;
>> +
>> +	addr = msg->addr + cmd_offset;
>> +	addr_high = (addr & 0xFF00) >> 8;
>> +	addr_low = addr & 0xFF;
>> +
>> +	if (cmd_type == AMD_SDW_CMD_WRITE)
>> +		data = msg->buf[cmd_offset];
>> +
>> +	high_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
>> +	high_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, cmd_type);
>> +	high_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, addr_high);
>> +	low_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, addr_low);
>> +	low_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
>> +
>> +	*high_word = high_data;
>> +	*low_word = low_data;
>> +}
>> +
>> +static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lword, u32 uword)
>> +{
>> +	u64 resp = 0;
> useless init
Will fix it.
>
>> +	u32 resp_lower, resp_high;
>> +	u32 sts = 0;
> useless init
Will fix it.
>
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
>> +	}
>> +	resp = resp_high;
>> +	resp = (resp << 32) | resp_lower;
>> +	return resp;
>> +}
>> +static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
>> +				      int cmd, int cmd_offset)
>> +{
>> +	u64 response = 0;
> useless init
Will fix it.
>
>> +	u32 uword = 0, lword = 0;
>> +
>> +	amd_sdw_ctl_word_prep(&lword, &uword, cmd, msg, cmd_offset);
>> +	response = amd_sdw_send_cmd_get_resp(amd_manager, lword, uword);
>> +	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
>> +}
>> +
>> +static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
>> +{
>> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
>> +	int ret, i;
>> +	int cmd = 0;
>> +
>> +	ret = amd_prep_msg(amd_manager, msg, &cmd);
>> +	if (ret)
>> +		return SDW_CMD_FAIL_OTHER;
>> +	for (i = 0; i < msg->len; i++) {
>> +		ret = _amd_sdw_xfer_msg(amd_manager, msg, cmd, i);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return SDW_CMD_OK;
>> +}
>> +
>> +static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
>> +{
>> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
>> +	u64 response;
>> +	u32 slave_stat = 0;
> useless init
Will fix it.
>
>> +
>> +	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
>> +	/* slave status from ping response*/
>> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
>> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
>> +	dev_dbg(amd_manager->dev, "%s: slave_stat:0x%x\n", __func__, slave_stat);
>> +	return slave_stat;
>> +}
>> +static void amd_sdw_probe_work(struct work_struct *work)
>> +{
>> +	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>> +							   probe_work);
>> +	struct sdw_master_prop *prop;
>> +	int ret;
>> +
>> +	prop = &amd_manager->bus.prop;
>> +	if (!prop->hw_disabled) {
>> +		amd_enable_sdw_pads(amd_manager);
>> +		ret = amd_init_sdw_manager(amd_manager);
>> +		if (ret)
>> +			return;
>> +		amd_enable_sdw_interrupts(amd_manager);
>> +		ret = amd_enable_sdw_manager(amd_manager);
>> +		if (ret)
>> +			return;
>> +		amd_sdw_set_frameshape(amd_manager);
>> +	}
>> +}
> There should be an explanation as to why you need a workqueue to
> complete the probe.
We want to separate the manager probe sequence and start up sequence.
we will add the comment.
>
>> +
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
>> +	amd_manager->sdw_lock = pdata->sdw_lock;
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
>> +		dev_err(dev, "Failed to register Soundwire manager(%d)\n", ret);
>> +		return ret;
>> +	}
>> +	dev_set_drvdata(dev, amd_manager);
>> +	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>> +	schedule_work(&amd_manager->probe_work);
>> +	return 0;
>> +}
>> +
>> +static int amd_sdw_manager_remove(struct platform_device *pdev)
>> +{
>> +	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
>> +	int ret;
>> +
>> +	if (!amd_manager)
>> +		return -ENODEV;
> is this possible? From the code just above wioth dev_set_drvdata() it
> seems there's no error code, so the remove can blindly use the pointer.
yes i agree. will drop this check,
>
>> +	cancel_work_sync(&amd_manager->probe_work);
>> +	amd_disable_sdw_interrupts(amd_manager);
>> +	sdw_bus_master_delete(&amd_manager->bus);
>> +	ret = amd_disable_sdw_manager(amd_manager);
>> +	return ret;
> return amd_disable_sdw_manager(amd_manager); ?
Will fix it.
>
>> +}
>> +
>> +static struct platform_driver amd_sdw_driver = {
>> +	.probe	= &amd_sdw_manager_probe,
>> +	.remove = &amd_sdw_manager_remove,
>> +	.driver = {
>> +		.name	= "amd_sdw_manager",
>> +	}
>> +};
>> +module_platform_driver(amd_sdw_driver);
>> +struct acp_sdw_pdata {
>> +	u16 instance;
>> +	/* mutex to protect acp common register access */
>> +	struct mutex *sdw_lock;
> may be acp_sdw_lock then? sdw_lock sounds very generic and confusing IMHO.
Will rename it.
>
>> +};

