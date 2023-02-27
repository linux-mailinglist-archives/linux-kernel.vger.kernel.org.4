Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2A6A4928
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjB0SFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjB0SFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:05:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B2B46F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbmlt++yXztM3qspjpAYWKaSERxhCoa0HqHzhnkMSH8hRquwifGU3UpuBxD5MJezRSkRj7LSfH3MsFiHnBE5U5tVvjM/SJZJ3WAtDpJG3iLI4Me/A2M1jLj50puqEU/a+suhvksGJCOdfuqF2IflfW9o6/ujI7vogIoli/jkxX9LNV38cHBs5XzjHLQDBhaafOCdzPhl63uyJJK/Y8Xgs5+S1nD6g/5Km3b8pu9yMe1NdgX8rY8AemHI2//3PYbhZ86wy4k0/H9uap9HAr9IIcDG6b4Rc7cJVkEK0YlHgqzamz/OQLBHvxTXBMgJBdrqbaCThGgVqTbjVorp9szaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y50qX6zAbi4hJ/Mz1hQgiDCH/OhbXMp4Kb3GmA7mBTg=;
 b=J0mlzMqWIPvHL3QVf86y4IhRWZ5+Pz7fiKruYC8cCg8XhspHN1IsIxzI81tAwJ5YiF7LycSnJGFxY15KWZm4RBGr0vv33/dpZX36TlnSnuZz20iRpORn6B25LusMiBjqAPJPO1FR4y7ZFRy5xXnsfL2Jks9ne1MQ+Q6wZPyWj0KbU36mlnPVXBaiHhm9VsJd/iiPoE86yoQO/jJOR1J6Q52DvdpbvjcAk09GKDOJa3dMmbQYO5784kUsUr995e5G6N7yC1uys9lH3pqgyJ+Zpyl8EA/Er34NnvPfLM/8s9CLORmgWgVCX21nHvphkPyrY01hMjBUJhLk6e9bWGnQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y50qX6zAbi4hJ/Mz1hQgiDCH/OhbXMp4Kb3GmA7mBTg=;
 b=DPgM86nFGyc+VgTYxOiokhE1qWgMupRJaxcJPJu2iHYdUTx8Scc+e+94aYJxhG6Nb4aO7u52uMHUOlDzWY1Fij+B9WivevpsB7NxpDGnLnOVa/58zKjg83xW4mKzpcFCYWbgbG328kOeSmLpQNYj0oo77w/XwhE+qiEjqy1wQ9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 18:04:30 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 18:04:30 +0000
Message-ID: <ff01e54f-72e2-8baf-ac31-3c249002e3d5@amd.com>
Date:   Mon, 27 Feb 2023 23:38:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V4 2/8] soundwire: amd: Add support for AMD Manager driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-3-Vijendar.Mukunda@amd.com>
 <606c1b31-d83e-6ef0-8b01-45e7e0be4cbc@linux.intel.com>
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <606c1b31-d83e-6ef0-8b01-45e7e0be4cbc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d18fa4-c5dd-4a73-915a-08db18ed1277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jpwq9xaPkVx6bFvxncmOjozIqZy//nAUbv5IuyMySMx0ov7djKBz1BdQpu+udApp5R2zYL2ZdyVfOL7V7PSGsKItdFKKRoC97wnjoT/Tq/Zzf6lw9unagrXBPpK9Dlsz4uGNce4wLhz2m589L4bEC+dTTlIhAH4M2/19n/xS2BgB7RyGG4+awUsuff4NycUc0XwSTbB1xQ7nd6N5cK9sIn5yHm4IKYjmGXIdnskukGKrA+eTwcCPDbELFuit75RxMfaYiUgazAtKcHmbVOySbRbJKggKZyAWngaRuHPwdAjX7TTFKUqnQh+4+uQSgIe/y+zCrWt7xrJSN9M+fIDuBE4n7ymPUvfv4oAyUamVzk1OHLW/nHtNE4DkZb7+Hi03JXVN3jJxyk6QPkYzzZfIKH67TxZOhBupJ/CUFemyz0eKOXEWbtmwR1mqGw35Mc+UQBX5hgGltvkuo95JCsfcnM8Q/bRo5IjEVteB6XP4KAQo/MiV4QNvrq3jk55jTS+/vk/IiWLvSWCRrZMg/JY2n4qOBQEPmF/UDyQxeEYlpuEZzznTmWgna62QojE+x9ynBToMfZ1HBswlKynzJ7n/J2qg16+Kynw1zg+Hibogm8mU5vUKaByHZCby0s3EKrHZn1Tw8dbbwlvKjn/IIhGaIYoFew2HOsOrCnlv8YIpMPK0JHCD450L7EhFo5/JQPf6QJXjv7sIeLy+pqR4p6tsYP3cruX/WVhkEnJIXWyqllE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(38100700002)(31686004)(2906002)(5660300002)(83380400001)(8936002)(186003)(2616005)(6486002)(86362001)(66476007)(66556008)(316002)(6512007)(53546011)(66946007)(8676002)(41300700001)(6506007)(4326008)(26005)(478600001)(54906003)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBISVFCeEJDcjBnWmhCeW0rcDVENldxY2JBSy9jbCtWTkh0SWdNbDlFMjIv?=
 =?utf-8?B?Zm54QWFDS1pXNnVSQkJDSjdEZVNzS3B4M3hOMnhVQmhxUUlaQ1JjQjI1VGJq?=
 =?utf-8?B?dHdXRnZNUlA5V2xHb3h2M3JPQlRuM3drR0Vhc283SXYxRWNQTzQ1aDFmVHUr?=
 =?utf-8?B?cW83RlFlR2JReTdBMml4ZzFoY0ovbGg4dTMvdnNaYXpNSzRNd0ZHM2FBYVY3?=
 =?utf-8?B?WTJBckppeVZzc2xpQ3Q1b2VKcmRHek83UnZhV1FWOWZhajk0WWtwSGJ5djFo?=
 =?utf-8?B?K1doenkvU1ZNa25XT1IvMTZuZExNaHNQcDlWM2x1WHVSa2RrQWMrTGZLa3F2?=
 =?utf-8?B?TVZwZFlGck9RQ3krWXNJNDE0WjlncUh4WlBMVk5rMjN2emRvQXdMbXpFUi9j?=
 =?utf-8?B?TEtWVGhSWFpBem1TdW4xbGdSZjRCaUpYU3JaK0EyRFdqeUxtbzFGRTg2cHJO?=
 =?utf-8?B?dElOL05tN0piVHF6bUhTb3R4UklhcWx4U3JuRitvSTBPVzFaNHJXYjhIamZR?=
 =?utf-8?B?NkJjTlJHbnJlVm1MelJ4TTFxL3JsY29aSXNKQXBTd0RhaHBKNFo2Q3BOa2Uz?=
 =?utf-8?B?SHRaaXhETkJ2NGdSanloamxGZkMvd1VyZVlUMUllWFJ4RFUyZVB4MWs3OUhl?=
 =?utf-8?B?NTBlUWZSdzh2ZEJ3WWhZelhwdXFtN2d4bXN2STc0bVNGZTVpd081SHpQbVR0?=
 =?utf-8?B?WkFNZ1BqZHEwTW5sK0dlVGp2Q0wvcUVOYmVqVG1zNncyb3dXNnR0RlpGNjc3?=
 =?utf-8?B?dWU2b1hocXp0cm5wL0VPRUxzTDQ5VWNVazhCb1RZMm94b3J6ekRKTVdwRWpK?=
 =?utf-8?B?ZjZLVTFPRHRWUUx6c2lmUDN3bXNiSzVwUk9hN0JyeWE5WXBFRFZxZUcrZVQv?=
 =?utf-8?B?bDBpQ2MwUElnb0JtWE9ENm9LSXlBSXpOVldTbEp4NVlTS0ZrbmUwU0JFT2lZ?=
 =?utf-8?B?V3J5WFM5eVE5b0xNaDFYTU0yZ3BVL3FYQUFkbFhQbi9yOG1vSnhZK2k1SEFh?=
 =?utf-8?B?SXJWVUJESmFJNVZUNkF1NUNNeUxac253Z0JRM1Q1NVNQTzI2STZLeTBnb2Q4?=
 =?utf-8?B?TEU0a1J5cGZuSmxaYW1jekhna1lsZ01XdVF1YVkzWitFM3EvaXVCY2xlS0o0?=
 =?utf-8?B?T2RNeHJPOUQrQmxOVmlMeEpSRHplZmZwSE5WRDk1QmhFdTRUUnlIcndFYWVD?=
 =?utf-8?B?ZHFOMGJRSlhYRHJrYXAvYXVxYVVJd29FdjRJSWpGeGExRWdtS0E3Q2FxODRq?=
 =?utf-8?B?OEswYUFiUUx4a3R5L05ydFZmcDROYUhpdk14N0ltUjU2SmFpQWtORnJkSUdK?=
 =?utf-8?B?MXIzR1lBSS9BSTBDRHNYd3BCeFI2aDNLZ1VsTFg1Z281amdWejFaSE1Fb1JX?=
 =?utf-8?B?ZkRZcGlQVW5GUWVQRWpaZW96bDRrK3YvQWRlN3VUMGg2S1VtVldSbkNpQkIw?=
 =?utf-8?B?U0hmdEE4b2krOU9MWHJ1clIwd1NzM2FCYzd5eFNGRUJzMzE5bjNZUUJuMlQ1?=
 =?utf-8?B?cVFWVE5KMjRXTDl1UDZKZ0wwUEk4akxocDFSTDdzNmdBOTQ2WnNRZjI0eHNn?=
 =?utf-8?B?ci9iL0pPWmpzbW1IUW1uNXpTbjZRUktaVWZCbEdEbWhucGZnbG5WR1FKSkhG?=
 =?utf-8?B?NHd2OWRyM0hPR3BVTjhENVhCa0M0OGZQdU00MTlCL1QwVnhUSWMvb2NSamI1?=
 =?utf-8?B?c0p5WHRLa2p0ZDVGUUUzZDJ2dWZ0UFdpb2t4RXkyQmpHa3orSC8zWDM2cW0y?=
 =?utf-8?B?S24yZVJxVUJsSVV3VlNIZEdPUEFsUmYxc0JoR3ZNN21sNkhjalNKNnhSdDhw?=
 =?utf-8?B?TEhiWW5QU3lEK0J6Y1JjOTVZTDg5R1hJc0sxNndsVmdaMVZUN3VORnI4RENE?=
 =?utf-8?B?Mnp0RHZQY1FqVURkbWZpWDlUNHRGMDE1TUI5blV6WTYwR0Flayt3bWFUNEp5?=
 =?utf-8?B?WmZzcGNKZDU3dU96Sk5NU1VLejhMTHdOVlVTbTNoQU1mNyt0cWF5eTJ2VEhL?=
 =?utf-8?B?VFFzRG9VbHQzU3hlZGJRcVQ1T25MNUIvN3lnSXhtcVFyZUtKWkNScWp5cHdj?=
 =?utf-8?B?SWNmMlR4eThLeFlaaDdkNEg1QjhQYUZRTjgyc2E2c3hVbmljNGsvYWE3aHZ0?=
 =?utf-8?Q?qjcnlcX8ASFuxpn0LDbwsntee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d18fa4-c5dd-4a73-915a-08db18ed1277
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 18:04:30.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1W0K30rMaEruyMAawVj8DZ8GhM5BmJjNsdLJ5qijamQMyK5kn2ZUfPeinZ0AVGfMXPPomR65EZ63anu65qzqrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/23 22:05, Pierre-Louis Bossart wrote:
>
> On 2/27/23 10:47, Vijendar Mukunda wrote:
>> AMD ACP(v6.x) IP block has two SoundWire manager devices.
>> Add support for
>>   - Manager driver probe & remove sequence
>>   - Helper functions to enable/disable interrupts,
>>     Initialize sdw manager, enable sdw pads
>>   - Manager driver sdw_master_ops & port_ops callbacks
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.c   | 749 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_manager.h   | 252 ++++++++++
>>  include/linux/soundwire/sdw_amd.h |  67 +++
>>  3 files changed, 1068 insertions(+)
>>  create mode 100644 drivers/soundwire/amd_manager.c
>>  create mode 100644 drivers/soundwire/amd_manager.h
>>  create mode 100644 include/linux/soundwire/sdw_amd.h
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> new file mode 100644
>> index 000000000000..63cd8d066602
>> --- /dev/null
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -0,0 +1,749 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * SoundWire AMD Manager driver
>> + *
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/completion.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/soundwire/sdw.h>
>> +#include <linux/soundwire/sdw_registers.h>
>> +#include <linux/wait.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include "bus.h"
>> +#include "amd_manager.h"
>> +
>> +#define DRV_NAME "amd_sdw_manager"
>> +
>> +#define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
>> +
>> +static void amd_enable_sdw_pads(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 sw_pad_pulldown_val;
>> +	u32 val;
>> +
>> +	mutex_lock(amd_manager->acp_sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>> +	val |= amd_manager->reg_mask->sw_pad_enable_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>> +	usleep_range(1000, 1500);
>> +
>> +	sw_pad_pulldown_val = acp_reg_readl(amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>> +	sw_pad_pulldown_val &= amd_manager->reg_mask->sw_pad_pulldown_mask;
>> +	acp_reg_writel(sw_pad_pulldown_val, amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>> +	mutex_unlock(amd_manager->acp_sdw_lock);
>> +}
>> +
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
>> +		usleep_range(10, 20);
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
>> +		usleep_range(1, 5);
>> +		timeout++;
>> +	}
>> +	if (timeout > AMD_DELAY_LOOP_ITERATION)
>> +		return -ETIMEDOUT;
> nit-pick: add a new line here since you're starting a different sequence.
>
will fix it.
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
>> +	if (timeout > AMD_DELAY_LOOP_ITERATION) {
>> +		dev_err(amd_manager->dev, "Failed to reset SoundWire manager instance%d\n",
>> +			amd_manager->instance);
>> +		return -ETIMEDOUT;
>> +	}
> and same here, this is a new sequence starting here so a newline would help
will fix it.
>> +	retry_count = 0;
>> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>> +		if (!val)
>> +			break;
>> +		usleep_range(10, 20);
>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>> +
>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>> +		return -ETIMEDOUT;
>> +	return 0;
>> +}
>> +
>> +static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val;
>> +	u32 retry_count = 0;
>> +
>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>> +		if (val)
>> +			break;
>> +		usleep_range(10, 20);
>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>> +
>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>> +		return -ETIMEDOUT;
>> +	return 0;
>> +}
>> +static void amd_sdw_ctl_word_prep(u32 *low_word, u32 *high_word, u32 cmd_type,
>> +				  struct sdw_msg *msg, int cmd_offset)
>> +{
>> +	u32 low_data = 0, high_data;
>> +	u16 addr;
>> +	u8 addr_high, addr_low;
>> +	u8 data = 0;
> nit-pick: this looks a bit messy, usually it's simpler to have
> initialized variables on separate lines. If you keep the low and high on
> the same line, then at least use the same order.
will fix it.
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
>> +	u64 resp;
>> +	u32 resp_lower, resp_high;
> nit-pick: resp_low? you seem to use this low/high pattern in a number of
> places.
will fix it.
>> +	u32 sts;
>> +	u32 timeout = 0;
>> +
>> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	while (sts & AMD_SDW_IMM_CMD_BUSY) {
>> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
>> +			dev_err(amd_manager->dev, "SDW%x previous cmd status clear failed\n",
>> +				amd_manager->instance);
>> +			return -ETIMEDOUT;
>> +		}
>> +		usleep_range(5, 10);
>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
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
>> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
>> +			dev_err(amd_manager->dev, "SDW%x cmd response timeout occurred\n",
>> +				amd_manager->instance);
>> +			return -ETIMEDOUT;
>> +		}
>> +		usleep_range(5, 10);
>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	}
>> +	resp_high = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_UPPER_WORD);
>> +	resp_lower = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_LOWER_QWORD);
> nit-pick: newline here.
will fix it.
>> +	timeout = 0;
>> +	acp_reg_writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	while ((sts & AMD_SDW_IMM_RES_VALID)) {
>> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
>> +			dev_err(amd_manager->dev, "SDW%x cmd status retry failed\n",
>> +				amd_manager->instance);
>> +			return -ETIMEDOUT;
>> +		}
>> +		usleep_range(5, 10);
>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	}
>> +	resp = resp_high;
>> +	resp = (resp << 32) | resp_lower;
>> +	return resp;
>> +}
>> +static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
>> +				      int cmd, int cmd_offset)
>> +{
>> +	u64 response;
>> +	u32 uword = 0, lword = 0;
> couldn't figure out what uword and lword refer to. Is this high/low as
> above or something else?
its high and low. Register naming convention uses
upper word and lower word. will use naming convention
throughout the code.
>> +
>> +	amd_sdw_ctl_word_prep(&lword, &uword, cmd, msg, cmd_offset);
>> +	response = amd_sdw_send_cmd_get_resp(amd_manager, lword, uword);
>> +	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
>> +}

