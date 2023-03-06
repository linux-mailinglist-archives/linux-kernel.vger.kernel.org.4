Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC816AB6FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCFHZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjCFHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:25:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E5B1E9FA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:24:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImA3Eo2sXniTztsTmOq2G8mWtQPXZtAr2sbmkBJ2JQlEOYhTYcE+32hmLuEG/HhPU0MTZV+QbXPzGlQHoJ3s/mn9T2/g/pArTOO1qMb9iC34EUVk7A9Muh6H47dHJA4CXHD5QCtHEjSaJ/U/4K0OVU1nMtwiEN1+K+U+hP7sTeHDRzy0r6bFxFjjlK24XiNFHiC2PtJ2jFoZK4SfpKAOwrzNtke2Z+yGV08C4IKdBu5vnDp8S08TrSrdamdc03DOOYCInsUd0TUsOyaI9IOB+qCAbC2GzQNvcABTBltsV59XjyIS4x1b2L2F7KDd5gnUkSaZag3aBNzBjGFmB9GtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgTy72VHB21a2/3H2uAqa3VZwnvr0U5jvkn0aNC3WJw=;
 b=E1jDLsEt/L4MzhSkSqdD13ZtZYjhtiz7/0kxrRlBx1Lr6yEPEmSW6ZmarVxwMsmrq3ZPfvb9Ne7mokWTLKfmQ28dkR3VlxfD8kTnahrWZht49+/9X2O9cWqNXQGXXf+419wNipco+ZN25TL6r28Y322lUtmrrZ2vMqCvR9GG6BbBlXaVZpIwG+JqsutBgb2YFaPYNFEeKiZPRFOyX/2/WuyUAw7WhDOu0Mr7ppCWoxDLuHBPBfh5lO00uoVf0tZTlaQ2G7m7P9WQY53ZKmDIXnOnlUStHvm9XrDdfP+fnhi9hUEBoyVBUdslN3oDcmMh0xyTd5hHSh0nh6xxD0I0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgTy72VHB21a2/3H2uAqa3VZwnvr0U5jvkn0aNC3WJw=;
 b=cEzRLuz+n0epGLfMzGizvXoBr+vGZVJGbCPE54vyHIxKJEd3VhdVOm9HeDRwmfh75JayWdjsIzZUTp4k3s8iCsrfcFP7cWKgzAZQyNirppbfqTPF1VDGQ6O3LkuRSPYgUGaW6WMfIe1F2n+womsZEy5TwFrxqWW+04Vo4Rl/hn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 07:24:43 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 07:24:43 +0000
Message-ID: <942eb899-2577-b534-514b-f46acdf06fc9@amd.com>
Date:   Mon, 6 Mar 2023 12:58:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V5 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
References: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
 <20230302062107.207845-3-Vijendar.Mukunda@amd.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20230302062107.207845-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::6) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c5ec06-4797-4cd7-4afa-08db1e13da77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8V1yUjcAmUn5rQXcwrURgKc5YhN0vZeAf5dLyxAV+aMof2zo/lM231ngFOY6iK1rq1gPJMQYXygbr01XyG1SxLR8CRmVYD2elsnluC/JMtpkzBdwUO2j5YnklDNLKqs8RaudzaJgGRCUqaPsF31n+bakPywuuAFcjD+daSTkWImlzcD2HSLNNgoPDkUzhkzTRf8h7W7HzBLo+yDHJh8W8ctKZIMtp7twQheQPnpCxI0EMgUs+oXPsRUBrdobu2q8qrgnb6kXi1kl1tUyke2ZgI3zPs8VfVT/JKJ/umEdXcRVELHXPBYUw+dmOpVJIMjO9sUI7lsyYRwfBEbXm4ElO9r48ZjEX0To0TCTHom1x08AoF17lHVaFITu4xcGYARKnf5mfSHQlLywNt6XFN6/dNMwb+P5crmVHTsmt5KSViRoCXyDETIBQzF2X6vdoS6B6s3bcMddHCNnrME4IXLKq3bWtQPQjSREDAkoJKmk5i24KbC3lzmxvzLtj94DVVBGoU7nr3L3PEOVdyIIRf9Hj6WxVVqMnONc/olwp2Zyt/r4WsH/+p7Nq9C0Ec07tAbJMtEjQaQiRHBfh3SYE+DZdH00fToRpHwrKCP4uerKmOvzI/zfIK3ph5xcop9QYO4BPAYCyV1aRzZGTrnt11tnro/qw7h+IdeD5cKaMhyzFb+UL4/4WcLVcQlOlt76CxzFUA6O5LLQaWG+ye2KqV9jJ+SF+YjxcRSXKaIZjPWg3XwNLP2AK1elU9dEnoZoo0LRXUfI2xxCd9il379gIu7ccIjhbbpAK0o2RGNQjBw3uE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(26005)(6506007)(6512007)(53546011)(6486002)(6666004)(36756003)(83380400001)(31696002)(86362001)(38100700002)(186003)(2616005)(66556008)(66946007)(66476007)(41300700001)(8676002)(4326008)(6916009)(31686004)(2906002)(8936002)(30864003)(5660300002)(478600001)(54906003)(316002)(43740500002)(45980500001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JnUkVhOFhrL1dIemdDQ3lIb05ISEY0UkZ4NEJ5NCtrVS9XY2ZmQ1pYc3Y4?=
 =?utf-8?B?dXZtNm41VVNTVjBkekpXdnA4K3RkUXFwMHNZTERlbWdVdTlTZDlkOUxHdGJR?=
 =?utf-8?B?cnJweWlJbk9yc3RKbTJjUDhwd2ZxRGFFdU4rRmY2eUM3SkRsNzNycnFGWEhW?=
 =?utf-8?B?dUdQNFNuK084M2pFYW51SVZNWEU5QWNXUFBodmlLUmJsNW5hUHhxZXM4Nlhq?=
 =?utf-8?B?c1cvZUliZUdBTmRmbGdHenMrR25venJCd1A4Vm1vUXNXTXIzeGlKOXFsOXlt?=
 =?utf-8?B?R09GK0pPRE5aU3k4YmFRSndoejRhMDlpQWhCUE5qYWdpeEJsZGtoUTczMVVq?=
 =?utf-8?B?a3dPTmZzaXhFdjlKUDlyWmJiSkwyMFp0ZWxnbWk0UnhOeDY2R2UzNmJEaW1Z?=
 =?utf-8?B?d0hWQkdpV3YyWVJEZUNUdmNaaWlDNnRyLzgzbXZ4eVBYZ2ZTU1FoSGROaXFH?=
 =?utf-8?B?QTZLVnBVMHBrajRhblgyZ3hQSFY3djgyN3R0enlUSE9rak4xajk1TDBBZG1F?=
 =?utf-8?B?TGNCNjBTMmV1b1FOVlZ6YU52WFJYcm1yRWlkWSsyTENvTHhobXZOUXdWYTVh?=
 =?utf-8?B?Q2QyWEhoM09CT1dpckdkbnBFdHdIUHNqZFhEUGhtNmpwOTUvbGZ1OEhWSUVL?=
 =?utf-8?B?Ky9RL2V3ZTV0Y3VlM0c2Tzh3aUJzYm5RQmd4bEI5Y3dSYkxqVzMwMXFHdm5R?=
 =?utf-8?B?ZUdTa2NHT3ZQZGNRMFRZc0s0VlAxM1ZwbXY3Q2dXNFdqMUwydlE3b01xU1lZ?=
 =?utf-8?B?RVFsQ1BKa2lBRzV6SlJ2dk1NL0pXcFNFUVhBQmR6dU9XRUxWSmJhYTN1NzVO?=
 =?utf-8?B?QXEzQ3NrY0d1dWR0MytVRUN2djBUMGswRTBkOUFLUzBhUk9lZHpWYlk2Zjll?=
 =?utf-8?B?SkF3bCswTUJOZjYrNmNybjhyQVRLbjBkcXloNUQ0OEwzMjd0QTNNaGZDd0Y2?=
 =?utf-8?B?NStCRERGSmNBV3k5YTFGY0R3MzJOV0JiM2tmWDdPcE10WUxtN294dTcwOEQ2?=
 =?utf-8?B?dlA4bHV4bFJyN0VVaW9zeGpDQlp1YXNpZ2NaM25rZnoyVVRvVFlzVUpDbVdT?=
 =?utf-8?B?RTNaWmdFU0FMR3hxTndlQ2lMOWZ3b3hQV3R4WGdFS0wvc091N0VFRllDTkhN?=
 =?utf-8?B?VFgrcnk2azF4eE9PVzAvaEw5aVI1RzhvU25Pd0ZUeW5DNTBqTEl2c0R5Nkcw?=
 =?utf-8?B?eXBEalUvSGdSWTBzbzRsNFFtM2ZWZTZaejFTN0dBbDhtNVFsZjhXcEVUajRv?=
 =?utf-8?B?MWdnL3VmZm16MXpIaW50UGQ0d1I1UEEwK0VaUy9QS3N0TzNza1laZ1FYb0E4?=
 =?utf-8?B?VkpUUmsvOGhqeG53VE1QVWI3dGRJblNHOW5TRnlsMmVxNHpTWWRXMndoKytK?=
 =?utf-8?B?OXVWdGpxOE5DTVBSQ1RBNEx6cWM2QnN3eGZQV3BzeHV0bG82cDhGQS8xWUFW?=
 =?utf-8?B?NVFVdGwvWjU2cXZrMUJkMlJDQ0ZEUXdyTFAvNzIxVzFjbjREc0l5S09mMndk?=
 =?utf-8?B?cnZPa1pJYXY3eFF0M2s4S3UyRkxIVStDOGJUbllHUEMwR0Z1TGtpRHJSZ09y?=
 =?utf-8?B?djFSZFIxOXFWbmF3VGxONnhxcldMT1NGR2N0ckRWR3psN1Fqd3FqRmtsQlox?=
 =?utf-8?B?dG5uWndQb2RvbkRMbXM1Sy9NRVUrMTdMd01RWDd3bGJ3MEl5ZXR5dGFwdnB4?=
 =?utf-8?B?KzhvWUw0WEJXWTZwRU05YnVHdVpTNDNmRnM4MG82cjlkTjBkUTlrWElUb2Vv?=
 =?utf-8?B?aEVmZU4vcUFmVjltY05GTi9iT3ZDM1g5TUtoNW1aZ21BWHhOV1NwWDZPcCtS?=
 =?utf-8?B?Z3oyVGlYWFMzVFN5K2oxSjNTNlAxYkpsWGhPUm0za0xqMTVkZGhMYTFsdFI3?=
 =?utf-8?B?ZlZPN0tLTWdTZjI0bmoxZ3BLL2VoK3BZR0dDL1lkS0lSdVpLZWNHN0ZBMzlL?=
 =?utf-8?B?MDNRQnp4b0lxRklCa3FTb0t6VHBYdXlva05rN25YWTJBUm9DcXR3R1NWU2ZQ?=
 =?utf-8?B?Q1Q4d1NpNlY1ZVVjU1p5MHQwREltQk5BSXo5M0JKcjBGWVRIYnQ3VkU5MVgr?=
 =?utf-8?B?YnNaeU1hUS9JbzRBUUZUYm44TDVhTGVzZktaamE2ZkU4ck8vWHE2MXQxSE1w?=
 =?utf-8?Q?0z+p63CmuVNonhXFpqs2hOZI4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c5ec06-4797-4cd7-4afa-08db1e13da77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 07:24:42.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKuqwOP8qKAu+xnNjxdFYdUEHzYnKz+/Lc3KoU7x5weTX1GjIrE7G+sg6B0Q0BKN8IN3KDgFjwOyFmUXO/RdQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/23 11:51, Vijendar Mukunda wrote:
> AMD ACP(v6.x) IP block has two SoundWire manager devices.
> Add support for
>   - Manager driver probe & remove sequence
>   - Helper functions to enable/disable interrupts,
>     Initialize sdw manager, enable sdw pads
>   - Manager driver sdw_master_ops & port_ops callbacks

We didn't receive your reply mail for v4/v5 patch sets.
We will replace usleep_range() with read_poll_timeout() and respin
the patch series.
>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c   | 756 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_manager.h   | 252 ++++++++++
>  include/linux/soundwire/sdw_amd.h |  67 +++
>  3 files changed, 1075 insertions(+)
>  create mode 100644 drivers/soundwire/amd_manager.c
>  create mode 100644 drivers/soundwire/amd_manager.h
>  create mode 100644 include/linux/soundwire/sdw_amd.h
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> new file mode 100644
> index 000000000000..32fb17df465a
> --- /dev/null
> +++ b/drivers/soundwire/amd_manager.c
> @@ -0,0 +1,756 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SoundWire AMD Manager driver
> + *
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include <linux/wait.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include "bus.h"
> +#include "amd_manager.h"
> +
> +#define DRV_NAME "amd_sdw_manager"
> +
> +#define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
> +
> +static void amd_enable_sdw_pads(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 sw_pad_pulldown_val;
> +	u32 val;
> +
> +	mutex_lock(amd_manager->acp_sdw_lock);
> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
> +	val |= amd_manager->reg_mask->sw_pad_enable_mask;
> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
> +	usleep_range(1000, 1500);
> +
> +	sw_pad_pulldown_val = acp_reg_readl(amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
> +	sw_pad_pulldown_val &= amd_manager->reg_mask->sw_pad_pulldown_mask;
> +	acp_reg_writel(sw_pad_pulldown_val, amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
> +	mutex_unlock(amd_manager->acp_sdw_lock);
> +}
> +
> +static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +	u32 retry_count = 0;
> +
> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
> +	do {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
> +		if (val)
> +			break;
> +		usleep_range(10, 20);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +
> +	/* SoundWire manager bus reset */
> +	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	while (!(val & AMD_SDW_BUS_RESET_DONE)) {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
> +			break;
> +		usleep_range(1, 5);
> +		timeout++;
> +	}
> +	if (timeout > AMD_DELAY_LOOP_ITERATION)
> +		return -ETIMEDOUT;
> +
> +	timeout = 0;
> +	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +	while (val) {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
> +			break;
> +		usleep_range(1, 5);
> +		timeout++;
> +	}
> +	if (timeout > AMD_DELAY_LOOP_ITERATION) {
> +		dev_err(amd_manager->dev, "Failed to reset SoundWire manager instance%d\n",
> +			amd_manager->instance);
> +		return -ETIMEDOUT;
> +	}
> +
> +	retry_count = 0;
> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
> +	do {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
> +		if (!val)
> +			break;
> +		usleep_range(10, 20);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +	return 0;
> +}
> +
> +static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 val;
> +	u32 retry_count = 0;
> +
> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
> +	do {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
> +		if (val)
> +			break;
> +		usleep_range(10, 20);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +	return 0;
> +}
> +
> +static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 val;
> +	u32 retry_count = 0;
> +
> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
> +	/*
> +	 * After invoking manager disable sequence, check whether
> +	 * manager has executed clock stop sequence. In this case,
> +	 * manager should ignore checking enable status register.
> +	 */
> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> +	if (val)
> +		return 0;
> +
> +	do {
> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
> +		if (!val)
> +			break;
> +		usleep_range(10, 20);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +	return 0;
> +}
> +
> +static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
> +{
> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
> +	u32 val;
> +
> +	mutex_lock(amd_manager->acp_sdw_lock);
> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	val |= reg_mask->acp_sdw_intr_mask;
> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	mutex_unlock(amd_manager->acp_sdw_lock);
> +
> +	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +}
> +
> +static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
> +{
> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
> +	u32 val;
> +
> +	mutex_lock(amd_manager->acp_sdw_lock);
> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	val &= ~reg_mask->acp_sdw_intr_mask;
> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
> +	mutex_unlock(amd_manager->acp_sdw_lock);
> +
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +}
> +
> +static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
> +{
> +	u32 frame_size;
> +
> +	frame_size = (amd_manager->rows_index << 3) | amd_manager->cols_index;
> +	acp_reg_writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
> +}
> +
> +static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, u32 cmd_type,
> +				  struct sdw_msg *msg, int cmd_offset)
> +{
> +	u32 upper_data;
> +	u32 lower_data = 0;
> +	u16 addr;
> +	u8 addr_upper, addr_lower;
> +	u8 data = 0;
> +
> +	addr = msg->addr + cmd_offset;
> +	addr_upper = (addr & 0xFF00) >> 8;
> +	addr_lower = addr & 0xFF;
> +
> +	if (cmd_type == AMD_SDW_CMD_WRITE)
> +		data = msg->buf[cmd_offset];
> +
> +	upper_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
> +	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, cmd_type);
> +	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, addr_upper);
> +	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, addr_lower);
> +	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
> +
> +	*upper_word = upper_data;
> +	*lower_word = lower_data;
> +}
> +
> +static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_word,
> +				     u32 upper_word)
> +{
> +	u64 resp;
> +	u32 resp_lower, resp_upper;
> +	u32 sts;
> +	u32 timeout = 0;
> +
> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	while (sts & AMD_SDW_IMM_CMD_BUSY) {
> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
> +			dev_err(amd_manager->dev, "SDW%x previous cmd status clear failed\n",
> +				amd_manager->instance);
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(5, 10);
> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	}
> +
> +	timeout = 0;
> +	if (sts & AMD_SDW_IMM_RES_VALID) {
> +		dev_err(amd_manager->dev, "SDW%x manager is in bad state\n", amd_manager->instance);
> +		acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	}
> +	acp_reg_writel(upper_word, amd_manager->mmio + ACP_SW_IMM_CMD_UPPER_WORD);
> +	acp_reg_writel(lower_word, amd_manager->mmio + ACP_SW_IMM_CMD_LOWER_QWORD);
> +
> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	while (!(sts & AMD_SDW_IMM_RES_VALID)) {
> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
> +			dev_err(amd_manager->dev, "SDW%x cmd response timeout occurred\n",
> +				amd_manager->instance);
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(5, 10);
> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	}
> +	resp_upper = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_UPPER_WORD);
> +	resp_lower = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_LOWER_QWORD);
> +
> +	timeout = 0;
> +	acp_reg_writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	while ((sts & AMD_SDW_IMM_RES_VALID)) {
> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
> +			dev_err(amd_manager->dev, "SDW%x cmd status retry failed\n",
> +				amd_manager->instance);
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(5, 10);
> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	}
> +	resp = resp_upper;
> +	resp = (resp << 32) | resp_lower;
> +	return resp;
> +}
> +
> +static enum sdw_command_response
> +amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
> +{
> +	struct sdw_msg scp_msg = {0};
> +	u64 response_buf[2] = {0};
> +	u32 upper_word = 0, lower_word = 0;
> +	int nack = 0, no_ack = 0;
> +	int index, timeout = 0;
> +
> +	scp_msg.dev_num = msg->dev_num;
> +	scp_msg.addr = SDW_SCP_ADDRPAGE1;
> +	scp_msg.buf = &msg->addr_page1;
> +	amd_sdw_ctl_word_prep(&lower_word, &upper_word, AMD_SDW_CMD_WRITE, &scp_msg, 0);
> +	response_buf[0] = amd_sdw_send_cmd_get_resp(amd_manager, lower_word, upper_word);
> +	scp_msg.addr = SDW_SCP_ADDRPAGE2;
> +	scp_msg.buf = &msg->addr_page2;
> +	amd_sdw_ctl_word_prep(&lower_word, &upper_word, AMD_SDW_CMD_WRITE, &scp_msg, 0);
> +	response_buf[1] = amd_sdw_send_cmd_get_resp(amd_manager, lower_word, upper_word);
> +
> +	for (index = 0; index < 2; index++) {
> +		if (response_buf[index] == -ETIMEDOUT) {
> +			dev_err(amd_manager->dev, "Program SCP cmd timeout\n");
> +			timeout = 1;
> +		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
> +			no_ack = 1;
> +			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
> +				nack = 1;
> +				dev_err(amd_manager->dev, "Program SCP NACK received\n");
> +			}
> +		}
> +	}
> +
> +	if (timeout) {
> +		dev_err_ratelimited(amd_manager->dev,
> +				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_TIMEOUT;
> +	}
> +
> +	if (nack) {
> +		dev_err_ratelimited(amd_manager->dev,
> +				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_FAIL;
> +	}
> +
> +	if (no_ack) {
> +		dev_dbg_ratelimited(amd_manager->dev,
> +				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_IGNORED;
> +	}
> +	return SDW_CMD_OK;
> +}
> +
> +static int amd_prep_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg, int *cmd)
> +{
> +	int ret;
> +
> +	if (msg->page) {
> +		ret = amd_program_scp_addr(amd_manager, msg);
> +		if (ret) {
> +			msg->len = 0;
> +			return ret;
> +		}
> +	}
> +	switch (msg->flags) {
> +	case SDW_MSG_FLAG_READ:
> +		*cmd = AMD_SDW_CMD_READ;
> +		break;
> +	case SDW_MSG_FLAG_WRITE:
> +		*cmd = AMD_SDW_CMD_WRITE;
> +		break;
> +	default:
> +		dev_err(amd_manager->dev, "Invalid msg cmd: %d\n", msg->flags);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static enum sdw_command_response amd_sdw_fill_msg_resp(struct amd_sdw_manager *amd_manager,
> +						       struct sdw_msg *msg, u64 response,
> +						       int offset)
> +{
> +	int nack = 0, no_ack = 0;
> +	int timeout = 0;
> +
> +	if (response & AMD_SDW_MCP_RESP_ACK) {
> +		if (msg->flags == SDW_MSG_FLAG_READ)
> +			msg->buf[offset] = FIELD_GET(AMD_SDW_MCP_RESP_RDATA, response);
> +	} else {
> +		no_ack = 1;
> +		if (response == -ETIMEDOUT) {
> +			timeout = 1;
> +		} else if (response & AMD_SDW_MCP_RESP_NACK) {
> +			nack = 1;
> +			dev_err(amd_manager->dev, "Program SCP NACK received\n");
> +		}
> +	}
> +
> +	if (timeout) {
> +		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
> +				    msg->dev_num);
> +		return SDW_CMD_TIMEOUT;
> +	}
> +	if (nack) {
> +		dev_err_ratelimited(amd_manager->dev,
> +				    "command response NACK received for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_FAIL;
> +	}
> +
> +	if (no_ack) {
> +		dev_err_ratelimited(amd_manager->dev, "command is ignored for Slave %d\n",
> +				    msg->dev_num);
> +		return SDW_CMD_IGNORED;
> +	}
> +	return SDW_CMD_OK;
> +}
> +
> +static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
> +				      int cmd, int cmd_offset)
> +{
> +	u64 response;
> +	u32 upper_word = 0, lower_word = 0;
> +
> +	amd_sdw_ctl_word_prep(&lower_word, &upper_word, cmd, msg, cmd_offset);
> +	response = amd_sdw_send_cmd_get_resp(amd_manager, lower_word, upper_word);
> +	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
> +}
> +
> +static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
> +{
> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +	int ret, i;
> +	int cmd = 0;
> +
> +	ret = amd_prep_msg(amd_manager, msg, &cmd);
> +	if (ret)
> +		return SDW_CMD_FAIL_OTHER;
> +	for (i = 0; i < msg->len; i++) {
> +		ret = _amd_sdw_xfer_msg(amd_manager, msg, cmd, i);
> +		if (ret)
> +			return ret;
> +	}
> +	return SDW_CMD_OK;
> +}
> +
> +static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
> +{
> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +	u64 response;
> +	u32 slave_stat;
> +
> +	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
> +	/* slave status from ping response */
> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
> +	dev_dbg(amd_manager->dev, "slave_stat:0x%x\n", slave_stat);
> +	return slave_stat;
> +}
> +
> +static int amd_sdw_compute_params(struct sdw_bus *bus)
> +{
> +	struct sdw_transport_data t_data = {0};
> +	struct sdw_master_runtime *m_rt;
> +	struct sdw_port_runtime *p_rt;
> +	struct sdw_bus_params *b_params = &bus->params;
> +	int port_bo, hstart, hstop, sample_int;
> +	unsigned int rate, bps;
> +
> +	port_bo = 0;
> +	hstart = 1;
> +	hstop = bus->params.col - 1;
> +	t_data.hstop = hstop;
> +	t_data.hstart = hstart;
> +
> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> +		rate = m_rt->stream->params.rate;
> +		bps = m_rt->stream->params.bps;
> +		sample_int = (bus->params.curr_dr_freq / rate);
> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
> +			port_bo = (p_rt->num * 64) + 1;
> +			dev_dbg(bus->dev, "p_rt->num=%d hstart=%d hstop=%d port_bo=%d\n",
> +				p_rt->num, hstart, hstop, port_bo);
> +			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
> +					      false, SDW_BLK_GRP_CNT_1, sample_int,
> +					      port_bo, port_bo >> 8, hstart, hstop,
> +					      SDW_BLK_PKG_PER_PORT, 0x0);
> +
> +			sdw_fill_port_params(&p_rt->port_params,
> +					     p_rt->num, bps,
> +					     SDW_PORT_FLOW_MODE_ISOCH,
> +					     b_params->m_data_mode);
> +			t_data.hstart = hstart;
> +			t_data.hstop = hstop;
> +			t_data.block_offset = port_bo;
> +			t_data.sub_block_offset = 0;
> +		}
> +		sdw_compute_slave_ports(m_rt, &t_data);
> +	}
> +	return 0;
> +}
> +
> +static int amd_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
> +			       unsigned int bank)
> +{
> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +	u32 frame_fmt_reg, dpn_frame_fmt;
> +
> +	dev_dbg(amd_manager->dev, "p_params->num:0x%x\n", p_params->num);
> +	switch (amd_manager->instance) {
> +	case ACP_SDW0:
> +		frame_fmt_reg = sdw0_manager_dp_reg[p_params->num].frame_fmt_reg;
> +		break;
> +	case ACP_SDW1:
> +		frame_fmt_reg = sdw1_manager_dp_reg[p_params->num].frame_fmt_reg;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dpn_frame_fmt = acp_reg_readl(amd_manager->mmio + frame_fmt_reg);
> +	u32p_replace_bits(&dpn_frame_fmt, p_params->flow_mode, AMD_DPN_FRAME_FMT_PFM);
> +	u32p_replace_bits(&dpn_frame_fmt, p_params->data_mode, AMD_DPN_FRAME_FMT_PDM);
> +	u32p_replace_bits(&dpn_frame_fmt, p_params->bps - 1, AMD_DPN_FRAME_FMT_WORD_LEN);
> +	acp_reg_writel(dpn_frame_fmt, amd_manager->mmio + frame_fmt_reg);
> +	return 0;
> +}
> +
> +static int amd_sdw_transport_params(struct sdw_bus *bus,
> +				    struct sdw_transport_params *params,
> +				    enum sdw_reg_bank bank)
> +{
> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +	u32 dpn_frame_fmt;
> +	u32 dpn_sampleinterval;
> +	u32 dpn_hctrl;
> +	u32 dpn_offsetctrl;
> +	u32 dpn_lanectrl;
> +	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
> +	u32 offset_reg, lane_ctrl_ch_en_reg;
> +
> +	switch (amd_manager->instance) {
> +	case ACP_SDW0:
> +		frame_fmt_reg  = sdw0_manager_dp_reg[params->port_num].frame_fmt_reg;
> +		sample_int_reg  = sdw0_manager_dp_reg[params->port_num].sample_int_reg;
> +		hctrl_dp0_reg  = sdw0_manager_dp_reg[params->port_num].hctrl_dp0_reg;
> +		offset_reg  = sdw0_manager_dp_reg[params->port_num].offset_reg;
> +		lane_ctrl_ch_en_reg  = sdw0_manager_dp_reg[params->port_num].lane_ctrl_ch_en_reg;
> +		break;
> +	case ACP_SDW1:
> +		frame_fmt_reg  = sdw1_manager_dp_reg[params->port_num].frame_fmt_reg;
> +		sample_int_reg  = sdw1_manager_dp_reg[params->port_num].sample_int_reg;
> +		hctrl_dp0_reg  = sdw1_manager_dp_reg[params->port_num].hctrl_dp0_reg;
> +		offset_reg  = sdw1_manager_dp_reg[params->port_num].offset_reg;
> +		lane_ctrl_ch_en_reg  = sdw1_manager_dp_reg[params->port_num].lane_ctrl_ch_en_reg;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	acp_reg_writel(AMD_SDW_SSP_COUNTER_VAL, amd_manager->mmio + ACP_SW_SSP_COUNTER);
> +
> +	dpn_frame_fmt = acp_reg_readl(amd_manager->mmio + frame_fmt_reg);
> +	u32p_replace_bits(&dpn_frame_fmt, params->blk_pkg_mode, AMD_DPN_FRAME_FMT_BLK_PKG_MODE);
> +	u32p_replace_bits(&dpn_frame_fmt, params->blk_grp_ctrl, AMD_DPN_FRAME_FMT_BLK_GRP_CTRL);
> +	u32p_replace_bits(&dpn_frame_fmt, SDW_STREAM_PCM, AMD_DPN_FRAME_FMT_PCM_OR_PDM);
> +	acp_reg_writel(dpn_frame_fmt, amd_manager->mmio + frame_fmt_reg);
> +
> +	dpn_sampleinterval = params->sample_interval - 1;
> +	acp_reg_writel(dpn_sampleinterval, amd_manager->mmio + sample_int_reg);
> +
> +	dpn_hctrl = FIELD_PREP(AMD_DPN_HCTRL_HSTOP, params->hstop);
> +	dpn_hctrl |= FIELD_PREP(AMD_DPN_HCTRL_HSTART, params->hstart);
> +	acp_reg_writel(dpn_hctrl, amd_manager->mmio + hctrl_dp0_reg);
> +
> +	dpn_offsetctrl = FIELD_PREP(AMD_DPN_OFFSET_CTRL_1, params->offset1);
> +	dpn_offsetctrl |= FIELD_PREP(AMD_DPN_OFFSET_CTRL_2, params->offset2);
> +	acp_reg_writel(dpn_offsetctrl, amd_manager->mmio + offset_reg);
> +
> +	/*
> +	 * lane_ctrl_ch_en_reg will be used to program lane_ctrl and ch_mask
> +	 * parameters.
> +	 */
> +	dpn_lanectrl = acp_reg_readl(amd_manager->mmio + lane_ctrl_ch_en_reg);
> +	u32p_replace_bits(&dpn_lanectrl, params->lane_ctrl, AMD_DPN_CH_EN_LCTRL);
> +	acp_reg_writel(dpn_lanectrl, amd_manager->mmio + lane_ctrl_ch_en_reg);
> +	return 0;
> +}
> +
> +static int amd_sdw_port_enable(struct sdw_bus *bus,
> +			       struct sdw_enable_ch *enable_ch,
> +			       unsigned int bank)
> +{
> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +	u32 dpn_ch_enable;
> +	u32 lane_ctrl_ch_en_reg;
> +
> +	switch (amd_manager->instance) {
> +	case ACP_SDW0:
> +		lane_ctrl_ch_en_reg  = sdw0_manager_dp_reg[enable_ch->port_num].lane_ctrl_ch_en_reg;
> +		break;
> +	case ACP_SDW1:
> +		lane_ctrl_ch_en_reg  = sdw1_manager_dp_reg[enable_ch->port_num].lane_ctrl_ch_en_reg;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * lane_ctrl_ch_en_reg will be used to program lane_ctrl and ch_mask
> +	 * parameters.
> +	 */
> +	dpn_ch_enable = acp_reg_readl(amd_manager->mmio + lane_ctrl_ch_en_reg);
> +	u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
> +	if (enable_ch->enable)
> +		acp_reg_writel(dpn_ch_enable, amd_manager->mmio + lane_ctrl_ch_en_reg);
> +	else
> +		acp_reg_writel(0, amd_manager->mmio + lane_ctrl_ch_en_reg);
> +	return 0;
> +}
> +
> +static int sdw_master_read_amd_prop(struct sdw_bus *bus)
> +{
> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +	struct fwnode_handle *link;
> +	struct sdw_master_prop *prop;
> +	u32 quirk_mask = 0;
> +	u32 wake_en_mask = 0;
> +	u32 power_mode_mask = 0;
> +	char name[32];
> +
> +	prop = &bus->prop;
> +	/* Find manager handle */
> +	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
> +	link = device_get_named_child_node(bus->dev, name);
> +	if (!link) {
> +		dev_err(bus->dev, "Manager node %s not found\n", name);
> +		return -EIO;
> +	}
> +	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
> +	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
> +		prop->hw_disabled = true;
> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
> +		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
> +
> +	fwnode_property_read_u32(link, "amd-sdw-wakeup-enable", &wake_en_mask);
> +	amd_manager->wake_en_mask = wake_en_mask;
> +	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
> +	amd_manager->power_mode_mask = power_mode_mask;
> +	return 0;
> +}
> +
> +static int amd_prop_read(struct sdw_bus *bus)
> +{
> +	sdw_master_read_prop(bus);
> +	sdw_master_read_amd_prop(bus);
> +	return 0;
> +}
> +
> +static const struct sdw_master_port_ops amd_sdw_port_ops = {
> +	.dpn_set_port_params = amd_sdw_port_params,
> +	.dpn_set_port_transport_params = amd_sdw_transport_params,
> +	.dpn_port_enable_ch = amd_sdw_port_enable,
> +};
> +
> +static const struct sdw_master_ops amd_sdw_ops = {
> +	.read_prop = amd_prop_read,
> +	.xfer_msg = amd_sdw_xfer_msg,
> +	.read_ping_status = amd_sdw_read_ping_status,
> +};
> +
> +static void amd_sdw_probe_work(struct work_struct *work)
> +{
> +	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
> +							   probe_work);
> +	struct sdw_master_prop *prop;
> +	int ret;
> +
> +	prop = &amd_manager->bus.prop;
> +	if (!prop->hw_disabled) {
> +		amd_enable_sdw_pads(amd_manager);
> +		ret = amd_init_sdw_manager(amd_manager);
> +		if (ret)
> +			return;
> +		amd_enable_sdw_interrupts(amd_manager);
> +		ret = amd_enable_sdw_manager(amd_manager);
> +		if (ret)
> +			return;
> +		amd_sdw_set_frameshape(amd_manager);
> +	}
> +}
> +
> +static int amd_sdw_manager_probe(struct platform_device *pdev)
> +{
> +	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct sdw_master_prop *prop;
> +	struct sdw_bus_params *params;
> +	struct amd_sdw_manager *amd_manager;
> +	int ret;
> +
> +	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
> +	if (!amd_manager)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(amd_manager->mmio)) {
> +		dev_err(dev, "mmio not found\n");
> +		return PTR_ERR(amd_manager->mmio);
> +	}
> +	amd_manager->instance = pdata->instance;
> +	amd_manager->mmio = amd_manager->acp_mmio +
> +			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
> +	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
> +	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
> +	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
> +	amd_manager->dev = dev;
> +	amd_manager->bus.ops = &amd_sdw_ops;
> +	amd_manager->bus.port_ops = &amd_sdw_port_ops;
> +	amd_manager->bus.compute_params = &amd_sdw_compute_params;
> +	amd_manager->bus.clk_stop_timeout = 200;
> +	amd_manager->bus.link_id = amd_manager->instance;
> +	switch (amd_manager->instance) {
> +	case ACP_SDW0:
> +		amd_manager->num_dout_ports = AMD_SDW0_MAX_TX_PORTS;
> +		amd_manager->num_din_ports = AMD_SDW0_MAX_RX_PORTS;
> +		break;
> +	case ACP_SDW1:
> +		amd_manager->num_dout_ports = AMD_SDW1_MAX_TX_PORTS;
> +		amd_manager->num_din_ports = AMD_SDW1_MAX_RX_PORTS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	amd_manager->reg_mask = &sdw_manager_reg_mask_array[amd_manager->instance];
> +	params = &amd_manager->bus.params;
> +	params->max_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
> +	params->curr_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
> +	params->col = AMD_SDW_DEFAULT_COLUMNS;
> +	params->row = AMD_SDW_DEFAULT_ROWS;
> +	prop = &amd_manager->bus.prop;
> +	prop->clk_freq = &amd_sdw_freq_tbl[0];
> +	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
> +
> +	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
> +	if (ret) {
> +		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
> +		return ret;
> +	}
> +	dev_set_drvdata(dev, amd_manager);
> +	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
> +	/*
> +	 * Instead of having lengthy probe sequence, use deferred probe.
> +	 */
> +	schedule_work(&amd_manager->probe_work);
> +	return 0;
> +}
> +
> +static int amd_sdw_manager_remove(struct platform_device *pdev)
> +{
> +	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
> +
> +	cancel_work_sync(&amd_manager->probe_work);
> +	amd_disable_sdw_interrupts(amd_manager);
> +	sdw_bus_master_delete(&amd_manager->bus);
> +	return amd_disable_sdw_manager(amd_manager);
> +}
> +
> +static struct platform_driver amd_sdw_driver = {
> +	.probe	= &amd_sdw_manager_probe,
> +	.remove = &amd_sdw_manager_remove,
> +	.driver = {
> +		.name	= "amd_sdw_manager",
> +	}
> +};
> +module_platform_driver(amd_sdw_driver);
> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_DESCRIPTION("AMD SoundWire driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> new file mode 100644
> index 000000000000..811ed9ee3d86
> --- /dev/null
> +++ b/drivers/soundwire/amd_manager.h
> @@ -0,0 +1,252 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __AMD_MANAGER_H
> +#define __AMD_MANAGER_H
> +
> +#include <linux/soundwire/sdw_amd.h>
> +
> +#define SDW_MANAGER_REG_OFFSET				0xC00
> +#define AMD_SDW_DEFAULT_ROWS				50
> +#define AMD_SDW_DEFAULT_COLUMNS				10
> +#define ACP_PAD_PULLDOWN_CTRL				0x0001448
> +#define ACP_SW_PAD_KEEPER_EN				0x0001454
> +#define ACP_SW0_WAKE_EN					0x0001458
> +#define ACP_EXTERNAL_INTR_CNTL0				0x0001A04
> +#define ACP_EXTERNAL_INTR_STAT0				0x0001A0C
> +#define ACP_EXTERNAL_INTR_CNTL(i)			(ACP_EXTERNAL_INTR_CNTL0 + ((i) * 4))
> +#define ACP_EXTERNAL_INTR_STAT(i)			(ACP_EXTERNAL_INTR_STAT0 + ((i) * 4))
> +#define ACP_SW_WAKE_EN(i)				(ACP_SW0_WAKE_EN + ((i) * 8))
> +
> +#define ACP_SW_EN					0x0003000
> +#define ACP_SW_EN_STATUS				0x0003004
> +#define ACP_SW_FRAMESIZE				0x0003008
> +#define ACP_SW_SSP_COUNTER				0x000300C
> +#define ACP_SW_AUDIO0_TX_EN				0x0003010
> +#define ACP_SW_AUDIO0_TX_EN_STATUS			0x0003014
> +#define ACP_SW_AUDIO0_TX_FRAME_FORMAT			0x0003018
> +#define ACP_SW_AUDIO0_TX_SAMPLEINTERVAL			0x000301C
> +#define ACP_SW_AUDIO0_TX_HCTRL_DP0			0x0003020
> +#define ACP_SW_AUDIO0_TX_HCTRL_DP1			0x0003024
> +#define ACP_SW_AUDIO0_TX_HCTRL_DP2			0x0003028
> +#define ACP_SW_AUDIO0_TX_HCTRL_DP3			0x000302C
> +#define ACP_SW_AUDIO0_TX_OFFSET_DP0			0x0003030
> +#define ACP_SW_AUDIO0_TX_OFFSET_DP1			0x0003034
> +#define ACP_SW_AUDIO0_TX_OFFSET_DP2			0x0003038
> +#define ACP_SW_AUDIO0_TX_OFFSET_DP3			0x000303C
> +#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0		0x0003040
> +#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP1		0x0003044
> +#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP2		0x0003048
> +#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP3		0x000304C
> +#define ACP_SW_AUDIO1_TX_EN				0x0003050
> +#define ACP_SW_AUDIO1_TX_EN_STATUS			0x0003054
> +#define ACP_SW_AUDIO1_TX_FRAME_FORMAT			0x0003058
> +#define ACP_SW_AUDIO1_TX_SAMPLEINTERVAL			0x000305C
> +#define ACP_SW_AUDIO1_TX_HCTRL				0x0003060
> +#define ACP_SW_AUDIO1_TX_OFFSET				0x0003064
> +#define ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0		0x0003068
> +#define ACP_SW_AUDIO2_TX_EN				0x000306C
> +#define ACP_SW_AUDIO2_TX_EN_STATUS			0x0003070
> +#define ACP_SW_AUDIO2_TX_FRAME_FORMAT			0x0003074
> +#define ACP_SW_AUDIO2_TX_SAMPLEINTERVAL			0x0003078
> +#define ACP_SW_AUDIO2_TX_HCTRL				0x000307C
> +#define ACP_SW_AUDIO2_TX_OFFSET				0x0003080
> +#define ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0		0x0003084
> +#define ACP_SW_AUDIO0_RX_EN				0x0003088
> +#define ACP_SW_AUDIO0_RX_EN_STATUS			0x000308C
> +#define ACP_SW_AUDIO0_RX_FRAME_FORMAT			0x0003090
> +#define ACP_SW_AUDIO0_RX_SAMPLEINTERVAL			0x0003094
> +#define ACP_SW_AUDIO0_RX_HCTRL_DP0			0x0003098
> +#define ACP_SW_AUDIO0_RX_HCTRL_DP1			0x000309C
> +#define ACP_SW_AUDIO0_RX_HCTRL_DP2			0x0003100
> +#define ACP_SW_AUDIO0_RX_HCTRL_DP3			0x0003104
> +#define ACP_SW_AUDIO0_RX_OFFSET_DP0			0x0003108
> +#define ACP_SW_AUDIO0_RX_OFFSET_DP1			0x000310C
> +#define ACP_SW_AUDIO0_RX_OFFSET_DP2			0x0003110
> +#define ACP_SW_AUDIO0_RX_OFFSET_DP3			0x0003114
> +#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0		0x0003118
> +#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP1		0x000311C
> +#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP2		0x0003120
> +#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP3		0x0003124
> +#define ACP_SW_AUDIO1_RX_EN				0x0003128
> +#define ACP_SW_AUDIO1_RX_EN_STATUS			0x000312C
> +#define ACP_SW_AUDIO1_RX_FRAME_FORMAT			0x0003130
> +#define ACP_SW_AUDIO1_RX_SAMPLEINTERVAL			0x0003134
> +#define ACP_SW_AUDIO1_RX_HCTRL				0x0003138
> +#define ACP_SW_AUDIO1_RX_OFFSET				0x000313C
> +#define ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0		0x0003140
> +#define ACP_SW_AUDIO2_RX_EN				0x0003144
> +#define ACP_SW_AUDIO2_RX_EN_STATUS			0x0003148
> +#define ACP_SW_AUDIO2_RX_FRAME_FORMAT			0x000314C
> +#define ACP_SW_AUDIO2_RX_SAMPLEINTERVAL			0x0003150
> +#define ACP_SW_AUDIO2_RX_HCTRL				0x0003154
> +#define ACP_SW_AUDIO2_RX_OFFSET				0x0003158
> +#define ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0		0x000315C
> +#define ACP_SW_BPT_PORT_EN				0x0003160
> +#define ACP_SW_BPT_PORT_EN_STATUS			0x0003164
> +#define ACP_SW_BPT_PORT_FRAME_FORMAT			0x0003168
> +#define ACP_SW_BPT_PORT_SAMPLEINTERVAL			0x000316C
> +#define ACP_SW_BPT_PORT_HCTRL				0x0003170
> +#define ACP_SW_BPT_PORT_OFFSET				0x0003174
> +#define ACP_SW_BPT_PORT_CHANNEL_ENABLE			0x0003178
> +#define ACP_SW_BPT_PORT_FIRST_BYTE_ADDR			0x000317C
> +#define ACP_SW_CLK_RESUME_CTRL				0x0003180
> +#define ACP_SW_CLK_RESUME_DELAY_CNTR			0x0003184
> +#define ACP_SW_BUS_RESET_CTRL				0x0003188
> +#define ACP_SW_PRBS_ERR_STATUS				0x000318C
> +#define ACP_SW_IMM_CMD_UPPER_WORD			0x0003230
> +#define ACP_SW_IMM_CMD_LOWER_QWORD			0x0003234
> +#define ACP_SW_IMM_RESP_UPPER_WORD			0x0003238
> +#define ACP_SW_IMM_RESP_LOWER_QWORD			0x000323C
> +#define ACP_SW_IMM_CMD_STS				0x0003240
> +#define ACP_SW_BRA_BASE_ADDRESS				0x0003244
> +#define ACP_SW_BRA_TRANSFER_SIZE			0x0003248
> +#define ACP_SW_BRA_DMA_BUSY				0x000324C
> +#define ACP_SW_BRA_RESP					0x0003250
> +#define ACP_SW_BRA_RESP_FRAME_ADDR			0x0003254
> +#define ACP_SW_BRA_CURRENT_TRANSFER_SIZE		0x0003258
> +#define ACP_SW_STATE_CHANGE_STATUS_0TO7			0x000325C
> +#define ACP_SW_STATE_CHANGE_STATUS_8TO11		0x0003260
> +#define ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7		0x0003264
> +#define ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11		0x0003268
> +#define ACP_SW_CLK_FREQUENCY_CTRL			0x000326C
> +#define ACP_SW_ERROR_INTR_MASK				0x0003270
> +#define ACP_SW_PHY_TEST_MODE_DATA_OFF			0x0003274
> +
> +#define AMD_DELAY_LOOP_ITERATION			1000
> +#define AMD_SDW_DEFAULT_CLK_FREQ			12000000
> +#define AMD_SDW_RETRY_COUNT				1000
> +
> +#define AMD_SDW_MCP_RESP_ACK				BIT(0)
> +#define AMD_SDW_MCP_RESP_NACK				BIT(1)
> +#define AMD_SDW_MCP_RESP_RDATA				GENMASK(14, 7)
> +
> +#define AMD_SDW_MCP_CMD_SSP_TAG				BIT(31)
> +#define AMD_SDW_MCP_CMD_COMMAND				GENMASK(14, 12)
> +#define AMD_SDW_MCP_CMD_DEV_ADDR			GENMASK(11, 8)
> +#define AMD_SDW_MCP_CMD_REG_ADDR_HIGH			GENMASK(7, 0)
> +#define AMD_SDW_MCP_CMD_REG_ADDR_LOW			GENMASK(31, 24)
> +#define AMD_SDW_MCP_CMD_REG_DATA			GENMASK(14, 7)
> +#define AMD_SDW_MCP_SLAVE_STAT_0_3			GENMASK(14, 7)
> +#define AMD_SDW_MCP_SLAVE_STAT_4_11			GENMASK_ULL(39, 24)
> +#define AMD_SDW_MCP_SLAVE_STATUS_MASK			GENMASK(1, 0)
> +#define AMD_SDW_MCP_SLAVE_STATUS_BITS			GENMASK(3, 2)
> +#define AMD_SDW_MCP_SLAVE_STATUS_8TO_11			GENMASK_ULL(15, 0)
> +#define AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(x)		BIT(((x) * 4))
> +#define AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(x)		(((x) * 4) + 1)
> +
> +#define AMD_SDW_MASTER_SUSPEND_DELAY_MS			2000
> +#define AMD_SDW_CLK_STOP_MAX_RETRY_COUNT		100
> +#define AMD_SDW_QUIRK_MASK_BUS_ENABLE			BIT(0)
> +
> +#define AMD_SDW_IMM_RES_VALID		1
> +#define AMD_SDW_IMM_CMD_BUSY		2
> +#define AMD_SDW_ENABLE			1
> +#define AMD_SDW_DISABLE			0
> +#define AMD_SDW_BUS_RESET_CLEAR_REQ	0
> +#define AMD_SDW_BUS_RESET_REQ		1
> +#define AMD_SDW_BUS_RESET_DONE		2
> +#define AMD_SDW_BUS_BASE_FREQ		24000000
> +
> +#define AMD_SDW0_EXT_INTR_MASK		0x200000
> +#define AMD_SDW1_EXT_INTR_MASK		4
> +#define AMD_SDW_IRQ_MASK_0TO7		0x77777777
> +#define AMD_SDW_IRQ_MASK_8TO11		0x000D7777
> +#define AMD_SDW_IRQ_ERROR_MASK		0xFF
> +#define AMD_SDW_MAX_FREQ_NUM		1
> +#define AMD_SDW0_MAX_TX_PORTS		3
> +#define AMD_SDW0_MAX_RX_PORTS		3
> +#define AMD_SDW1_MAX_TX_PORTS		1
> +#define AMD_SDW1_MAX_RX_PORTS		1
> +#define AMD_SDW0_MAX_DAI		6
> +#define AMD_SDW1_MAX_DAI		2
> +#define AMD_SDW_SLAVE_0_ATTACHED	5
> +#define AMD_SDW_SSP_COUNTER_VAL		3
> +
> +#define AMD_DPN_FRAME_FMT_PFM				GENMASK(1, 0)
> +#define AMD_DPN_FRAME_FMT_PDM				GENMASK(3, 2)
> +#define AMD_DPN_FRAME_FMT_BLK_PKG_MODE			BIT(4)
> +#define AMD_DPN_FRAME_FMT_BLK_GRP_CTRL			GENMASK(6, 5)
> +#define AMD_DPN_FRAME_FMT_WORD_LEN			GENMASK(12, 7)
> +#define AMD_DPN_FRAME_FMT_PCM_OR_PDM			BIT(13)
> +#define AMD_DPN_HCTRL_HSTOP				GENMASK(3, 0)
> +#define AMD_DPN_HCTRL_HSTART				GENMASK(7, 4)
> +#define AMD_DPN_OFFSET_CTRL_1				GENMASK(7, 0)
> +#define AMD_DPN_OFFSET_CTRL_2				GENMASK(15, 8)
> +#define AMD_DPN_CH_EN_LCTRL				GENMASK(2, 0)
> +#define AMD_DPN_CH_EN_CHMASK				GENMASK(10, 3)
> +#define AMD_SDW_STAT_MAX_RETRY_COUNT			100
> +#define AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7F9F
> +#define AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7FFA
> +#define AMD_SDW0_PAD_PULLDOWN_CTRL_DISABLE_MASK		0x60
> +#define AMD_SDW1_PAD_PULLDOWN_CTRL_DISABLE_MASK		5
> +#define AMD_SDW0_PAD_KEEPER_EN_MASK			1
> +#define AMD_SDW1_PAD_KEEPER_EN_MASK			0x10
> +#define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1E
> +#define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xF
> +
> +enum amd_sdw_cmd_type {
> +	AMD_SDW_CMD_PING = 0,
> +	AMD_SDW_CMD_READ = 2,
> +	AMD_SDW_CMD_WRITE = 3,
> +};
> +
> +static u32 amd_sdw_freq_tbl[AMD_SDW_MAX_FREQ_NUM] = {
> +	AMD_SDW_DEFAULT_CLK_FREQ,
> +};
> +
> +struct sdw_manager_dp_reg {
> +	u32 frame_fmt_reg;
> +	u32 sample_int_reg;
> +	u32 hctrl_dp0_reg;
> +	u32 offset_reg;
> +	u32 lane_ctrl_ch_en_reg;
> +};
> +
> +static struct sdw_manager_dp_reg sdw0_manager_dp_reg[AMD_SDW0_MAX_DAI] =  {
> +	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
> +	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
> +	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
> +	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
> +	{ACP_SW_AUDIO2_TX_FRAME_FORMAT, ACP_SW_AUDIO2_TX_SAMPLEINTERVAL, ACP_SW_AUDIO2_TX_HCTRL,
> +	 ACP_SW_AUDIO2_TX_OFFSET, ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0},
> +	{ACP_SW_AUDIO0_RX_FRAME_FORMAT, ACP_SW_AUDIO0_RX_SAMPLEINTERVAL, ACP_SW_AUDIO0_RX_HCTRL_DP0,
> +	 ACP_SW_AUDIO0_RX_OFFSET_DP0, ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0},
> +	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
> +	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0},
> +	{ACP_SW_AUDIO2_RX_FRAME_FORMAT, ACP_SW_AUDIO2_RX_SAMPLEINTERVAL, ACP_SW_AUDIO2_RX_HCTRL,
> +	 ACP_SW_AUDIO2_RX_OFFSET, ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0},
> +};
> +
> +static struct sdw_manager_dp_reg sdw1_manager_dp_reg[AMD_SDW1_MAX_DAI] =  {
> +	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
> +	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
> +	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
> +	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0}
> +};
> +
> +static struct sdw_manager_reg_mask sdw_manager_reg_mask_array[2] =  {
> +	{
> +		AMD_SDW0_PAD_KEEPER_EN_MASK,
> +		AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK,
> +		AMD_SDW0_EXT_INTR_MASK
> +	},
> +	{
> +		AMD_SDW1_PAD_KEEPER_EN_MASK,
> +		AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK,
> +		AMD_SDW1_EXT_INTR_MASK
> +	}
> +};
> +
> +static inline u32 acp_reg_readl(void __iomem *base_addr)
> +{
> +	return readl(base_addr);
> +}
> +
> +static inline void acp_reg_writel(u32 val, void __iomem *base_addr)
> +{
> +	writel(val, base_addr);
> +}
> +#endif
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> new file mode 100644
> index 000000000000..c14a291a40e8
> --- /dev/null
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __SDW_AMD_H
> +#define __SDW_AMD_H
> +
> +#include <linux/soundwire/sdw.h>
> +
> +#define ACP_SDW0	0
> +#define ACP_SDW1	1
> +
> +struct acp_sdw_pdata {
> +	u16 instance;
> +	/* mutex to protect acp common register access */
> +	struct mutex *acp_sdw_lock;
> +};
> +
> +struct sdw_manager_reg_mask {
> +	u32 sw_pad_enable_mask;
> +	u32 sw_pad_pulldown_mask;
> +	u32 acp_sdw_intr_mask;
> +};
> +
> +/**
> + * struct amd_sdw_manager - amd manager driver context
> + * @bus: bus handle
> + * @dev: linux device
> + * @mmio: SoundWire registers mmio base
> + * @acp_mmio: acp registers mmio base
> + * @reg_mask: register mask structure per manager instance
> + * @probe_work: SoundWire manager probe workqueue
> + * @acp_sdw_lock: mutex to protect acp share register access
> + * @num_din_ports: number of input ports
> + * @num_dout_ports: number of output ports
> + * @cols_index: Column index in frame shape
> + * @rows_index: Rows index in frame shape
> + * @instance: SoundWire manager instance
> + * @quirks: SoundWire manager quirks
> + * @wake_en_mask: wake enable mask per SoundWire manager
> + * @power_mode_mask: flag interprets amd SoundWire manager power mode
> + */
> +struct amd_sdw_manager {
> +	struct sdw_bus bus;
> +	struct device *dev;
> +
> +	void __iomem *mmio;
> +	void __iomem *acp_mmio;
> +
> +	struct sdw_manager_reg_mask *reg_mask;
> +	struct work_struct probe_work;
> +	/* mutex to protect acp common register access */
> +	struct mutex *acp_sdw_lock;
> +
> +	int num_din_ports;
> +	int num_dout_ports;
> +
> +	int cols_index;
> +	int rows_index;
> +
> +	u32 instance;
> +	u32 quirks;
> +	u32 wake_en_mask;
> +	u32 power_mode_mask;
> +};
> +#endif

