Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0183D6836C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjAaTqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjAaTp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:45:59 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D88577D4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:45:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3woKvp2p6qh+MnquQmj2yw6eWgn2RwYfMNZhwSsVrGVZn3c5X6xuhf/B02wO4IFvPeiVLcwPxm1eyIwTBBqHLL03KmcDJ8fvCj45We2Zbm8zj3u76aZDMyLyoT2R3TG0fFddcr+KEoIdADB55WC3f9CbUpGw4yabOxJqR0D8B0TGWoD967pMXE+rZL/DucyX8Q5p6hUBM01AlMEDUyYVE1Tg/djoq9xxq2IUzLec7Zp1+mXR1yPDPBeCsQSLD2HQJeArwFoRmOT+QEwWuv5VImEBRd3/cODUPJozRE2L7XzhIUJ2669biwTGwshnK40LaJoTanN7fbj0KFkO4Fs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmu3OGSBMQIi65GiTH1IijOUxZH9j78JP48LWiVlTgE=;
 b=FwcBjh5aN6R0oA56REx167Ynye5V28akiGAfBS7IBe4PXMe4zbRaczRzDWVeA9hGPg1jz3g0CLOWwX/ZQcVWlm0MqAbY0MnkrzruN4lpW0cS5f32/DEpDvGQdtTp2FrQv6rpalkUebfKAWT8HashTocxGnxoUFZTzxg87hkvz132RlwaNc3XE4tgUNAe9UKkpZ+T+Pw70DMzX5Jdy7fCNRAtblDCB2ADCB1ZFXPbNikBmfkJevUMaAiI6kkPr7EerHNPUB71R6j8GPYeHUTpNiPTKVeMY8PasRLSVowi++9d9gDAaVpXa6F41bRQPPINIqWugpaazV0LL/dx9l1+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmu3OGSBMQIi65GiTH1IijOUxZH9j78JP48LWiVlTgE=;
 b=ADEOsDbE/VgFT4O8SuX3i0nLG9D7HaxverAVuq9S4Jmu1XXKLFaV0kFyXJrEdQJCTviFaVmPI7rBAnLzsCkVJFR8YuHSI6anCOiH5Wt423Bdt18jlbGMf4QWtlXJU5NyQaMNbri3HN/jyqk70XbyfV/rihGxfOjMKBrcazCrc+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 19:45:51 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 19:45:51 +0000
Message-ID: <5b025fa2-2d69-8098-6e76-0948fb4809e9@amd.com>
Date:   Tue, 31 Jan 2023 13:45:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 4/8] x86/psp: Add IRQ support
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-5-jpiotrowski@linux.microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230123152250.26413-5-jpiotrowski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:8:57::16) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: e7eae758-a728-4743-f1d6-08db03c3c20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk+6pQXEOH9M1cLEvj6EpFE/7+ZtTbO+8AuU/Bz4pjTvVlS09/10EgizQc4NDdxVSa+wvSlnh3Kwvy7xu8PTZw8tecJEgwLi6+6a06HIP5bpkLXD7zTnU3lsPgk2W7fday5R1QX95gBRJ0nkXyDNyTbHBy9mCbxBJRpdPn7Y1m7TkxDTv4uV7QCBrLzAcm/3I1xNeU7T7NsXvOdXUT+IefXxD4hZuasN/nHxKgyE+c/eIGOl7JZadBg2ZEk77B40UBzbsJkkGC9Wd96LT/lBZmuuv/hiLwG6duzfGkCN/UJDwTAacpG163StC3o3Llt6DX6sAY6WknZ+jHtgwWq0gvJixW2MXKqFLMHjDqA6qfN67k7I33knhcnbBc9BgVWAe134khgycD6LwzhiBh3xR5T0/uK5YclwzFzr9yYGv+GD8ukg+mZuLKvUB8TwKvLcBnHF/TTkYjdQlHkHXVo8hD5Mpm8gB+Xtf6ZQ2+ZZJTyUVqgdEs9E5Lw2yqZg2mTLhxZYecOsNXlfTuFDORZALpBInGy/Qw3VesYNNWJjcyVoVHY3Cc8v+wcNhFQeWrBdqPA6A6syc6Q05tpWMRx/j9SaNBojZbd477WlP4E9HWdT9yVvnCIZWIeWBEdeCJGMuY/XallAG4XmJJYjDs4XiyyFLFxXVP9V4vEMi6d7r0r31IJzBZ6euMtEsvWvwl+Xe522tGJaC5glnDfGg0B9tgE+hKMBX8/+OsRakWhFpb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199018)(41300700001)(66476007)(66556008)(31686004)(66946007)(4326008)(83380400001)(8676002)(316002)(8936002)(6512007)(2906002)(54906003)(5660300002)(478600001)(6506007)(26005)(53546011)(36756003)(86362001)(31696002)(6666004)(38100700002)(6486002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTFoUzhlK01WUCtFNGNSeU4vcUZOanRRd3dKZ0xrRlFCTjdvd1FQcWhtYzhF?=
 =?utf-8?B?VGNVL1F5NWMyOHl0d21Sa3E4YUVBV1lVSTBhWTdHemlGK2xPU3RibkpLa0k5?=
 =?utf-8?B?Q0srVFJRVnFBdDFsTWtzaFJidE9CUHVLdHh0citRamJiNkx4UXlJMWl4c0Qv?=
 =?utf-8?B?WUxqZ3hFL1VxZ1VrV1RuU0NBMXlydTMwdFhmeEFTbG9ja2orYUJoN1dZRnVL?=
 =?utf-8?B?MFFQdk1SSjFndmU4dlMvVHlkeWE3cm80NHk3RkowelZwUjl6WEZjY1RVY2xO?=
 =?utf-8?B?QWlpczlDSVV2d1hlTE9hZGZlMk42bmxLZHV5QiswRi95RnhqcmxCL1JCZFlK?=
 =?utf-8?B?ZVpXRlc3dUhaWkFWeVVFVnFKdFVKTGxwRFVsNTdBM0ZHL1UrVVlOY0RHUTM2?=
 =?utf-8?B?d0gvS2gyNE1xZ0s2R201dVB4Sk1HMWVFZTFmWjd5czB6NlVjTWJwRXRKZVk1?=
 =?utf-8?B?dkw3bEJTRzJ0bmc5SGVUYTlPM2xIYldTNGFGNXQ3WHFEbExRbmtkanNvbS9n?=
 =?utf-8?B?V0R4OU9KQUQxaXhtZlZNcWZISHhwVWNkN1daZ3gzMlFKVnhxL2hsTll5MUFI?=
 =?utf-8?B?L0hQZEg5WG9SazZQYU1iaTkxUEErdmdKZm9FcmxMdm1zNVVUaG0zVG04SkJF?=
 =?utf-8?B?RFFROE9UWlRWdldrekltemY4Uml5K0tQQjJiZ3BVMEZGT2tDY3BRS0ZINXk3?=
 =?utf-8?B?WlBsUGZRN25SY0pUNWd6K0FBcGNSbFRMaVhQZnJmOEw4akxjYUlDSHZRdzhZ?=
 =?utf-8?B?SUVQNkVvbXg0MmE5SlZlbVk5Rm9UK2pnY1ZQUjluc3lHR1ExVDVUdGEvRTRJ?=
 =?utf-8?B?OXVVQkkyVlltM0tVN1o4VTVNMk8vV2xIKzA3Q3BzcjdUbDhybVdIU0NBT055?=
 =?utf-8?B?dGxkQmRVa0dPR1UxMEJFUTh2b3crcjJrN1A0eS92WVRGNFlxaXlmR0UzRncw?=
 =?utf-8?B?NGw3d2N1NDdwS0VyVDROVFBjQ2pkRzE3YjdKNFRPcW96bUl2L0pCaXBUNFJk?=
 =?utf-8?B?VWtjT05EcmFabjFaK2J0N0VKK1VER0QxMm5WNlZ5SFBuK2h1bXZMWlFEblZO?=
 =?utf-8?B?WTFEUVBNL0s1Rmh6TWZjUldjS1FwVys4Qlhpd05oWFlrVWg4QlRZeU5id0U0?=
 =?utf-8?B?S01jbkxLbE4wSE9tQmprcTR3ZVZIemNFK2tjU2sxRXVIZUgxZkk0MVhKYnlm?=
 =?utf-8?B?RGFUZ0p0WUtqVzFMOVN4VTJoY1kwc2FuR2Urdmgzc2wrOS9LWFJxaUUrdnJY?=
 =?utf-8?B?OVBveDZET2pZQ2o1SzFTdjc4Y09sT0laS1paL1ZXMFJZTzBMQnFwYkFadWV3?=
 =?utf-8?B?ZmVZL2dvK3FtOVFxYldGSWNGRjVBWmFTSW5HQ1R6b3hsQTlPMENkTkNpTXBT?=
 =?utf-8?B?aTlGa3JlSG9zR1BiM2wwc3hqRmdoM2d2bmVqcGVEdFpiSjZ3eFBGNzhuL2JU?=
 =?utf-8?B?ZENTWXJWa1R1a3R0VkxqclQ0OUdXaTFTbWpmcVNxR0JhWWNDS0w3ZVBFamhq?=
 =?utf-8?B?eFdvUmhlczBEM0JOTUJQT3lyc3NjbjltTGZreXhTRVpCU3pOSmVYYSt5a2w2?=
 =?utf-8?B?SXFTNUhUWDBpeVk3b3pjcUdBZ2RZNkZVN1lvNXB2akRVQm9seFBVNytZVUhJ?=
 =?utf-8?B?NjNCakpXdVh5eW9aOVRuSGllTVFSQ3A1dlNmQ3NYbjI3eG5DdmxSOWVtM3li?=
 =?utf-8?B?dlBhSWpyME84bm1kaXM4RlB1a05ERXpYWWRob2xwdk9MLzIyUTFVYkwva0RR?=
 =?utf-8?B?WTBENmwzdUlLWktYaFF2N1p6QjA2bDJrakErNnFVSmpoMllubjAvK0dPemRh?=
 =?utf-8?B?ZHhQUWtkc1E5ZnZZUVBrdk8zbEUzMWxEQ0hzRk9kczluckFSUlFQbW0wcTk2?=
 =?utf-8?B?WWtHc3VoOFE0ZEtOY2QyWWk2cjlKb1JsdTRBR1hMWXpsQi9YQzI1R3FvR3dz?=
 =?utf-8?B?Vm13SUNJQ3Izanl4eTAremNIakxaZmdhSHRidHNsVlEvK2Y1MzdkZW5xVGxj?=
 =?utf-8?B?R2JjaEFQN2hOejBHeTUvcktwRjNES1VOQ2pGM2F3TGhUbm5nOWtDSXBhV2tt?=
 =?utf-8?B?bTgxOCtwMjFTMTVHbC9Vd1pNK2pTQVBqYWVTRWgway9YN09NR0hNa3JZTkFq?=
 =?utf-8?Q?6rakqtXVXly9tIE+yQblFSfko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eae758-a728-4743-f1d6-08db03c3c20d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 19:45:51.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvAqnMyWbJopMSNPJa4pgN2qL1lMe8twGFaMg8HnDzEZyhxjakxkNS1Db0nh/6pmDcMXiokY0pUM6zMKUulM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 09:22, Jeremi Piotrowski wrote:
> The ACPI PSP device provides a mailbox irq that needs to be configured
> through the ACPI mailbox register first. This requires passing a CPU
> vector and physical CPU id and then enabling interrupt delivery.
> Allocate the irq directly from the default irq domain
> (x86_vector_domain) to get access to the required information. By
> passing a cpumask through irq_alloc_info the vector is immediately
> allocated (and not later during activation) and can be retrieved.
> 
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>   arch/x86/kernel/psp.c | 179 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 175 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
> index d404df47cc04..24181d132bae 100644
> --- a/arch/x86/kernel/psp.c
> +++ b/arch/x86/kernel/psp.c
> @@ -1,8 +1,176 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -
> +#define pr_fmt(fmt) "psp: " fmt
>   #include <linux/platform_data/psp.h>
>   #include <linux/platform_device.h>
> +#include <linux/iopoll.h>
> +#include <linux/irq.h>
>   #include <asm/hypervisor.h>
> +#include <asm/irqdomain.h>
> +
> +#define PSP_ACPI_DATA_SHIFT 0
> +#define PSP_ACPI_DATA_MASK GENMASK(15, 0)
> +#define PSP_ACPI_CMDID_SHIFT 16
> +#define PSP_ACPI_CMDID_MASK GENMASK(25, 16)
> +#define PSP_ACPI_STATUS_SHIFT 26
> +#define PSP_ACPI_STATUS_MASK GENMASK(30, 26)
> +#define PSP_ACPI_RESPONSE_BIT BIT(31)
> +
> +#define PSP_ACPI_VECTOR_SHIFT 0
> +#define PSP_ACPI_VECTOR_MASK GENMASK(7, 0)
> +#define PSP_ACPI_MBOX_IRQID_SHIFT 10
> +#define PSP_ACPI_MBOX_IRQID_MASK GENMASK(15, 10)
> +
> +#define PSP_ACPI_IRQ_EN_BIT BIT(0)
> +#define PSP_ACPI_IRQ_EN_MBOX_IRQID_SHIFT 10
> +#define PSP_ACPI_IRQ_EN_MBOX_IRQID_MASK GENMASK(15, 10)
> +
> +// AMD Secure Processor
> +enum ASP_CMDID {
> +	ASP_CMDID_PART1  = 0x82,
> +	ASP_CMDID_PART2  = 0x83,
> +	ASP_CMDID_PART3  = 0x84,
> +	ASP_CMDID_IRQ_EN = 0x85,
> +};
> +
> +enum ASP_CMD_STATUS {
> +	ASP_CMD_STATUS_SUCCESS = 0x0,
> +	ASP_CMD_STATUS_INVALID_CMD = 0x1,
> +	ASP_CMD_STATUS_INVALID_PARAM = 0x2,
> +	ASP_CMD_STATUS_INVALID_FW_STATE = 0x3,
> +	ASP_CMD_STATUS_FAILURE = 0x1F,
> +};
> +
> +struct psp_irq_data {
> +	void __iomem *base;
> +	int mbox_irq_id;
> +	int acpi_cmd_resp_reg;
> +};
> +
> +static int psp_sync_cmd(void __iomem *reg, u8 cmd, u16 data)
> +{
> +	u32 val = 0;

Remove this initialization and ...

> +	int err;
> +
> +	val |= data & PSP_ACPI_DATA_MASK;

... just make this "val = " which sets the initial value. And if the mask 
is 16 bits and the data is 16 bits, there's no need for the ANDing

> +	val |= (cmd << PSP_ACPI_CMDID_SHIFT) & PSP_ACPI_CMDID_MASK;

Same here, the mask is 8 bits and the cmd is 8 bits...

> +	writel(val, reg);
> +	err = readl_poll_timeout_atomic(reg, val, val & PSP_ACPI_RESPONSE_BIT, 2, 10000);

Use some #defines with informative names for the 2 and 10000.

> +	if (err < 0)

This can just be "if (err)" since readl_poll_timeout_atomic() returns 0 or 
-ETIMEDOUT.

> +		return err;

Blank line...

> +	return (val & PSP_ACPI_STATUS_MASK) >> PSP_ACPI_STATUS_SHIFT;
> +}
> +
> +static int psp_set_irq_enable(struct psp_irq_data *data, bool irq_en)
> +{
> +	void __iomem *reg = data->base + data->acpi_cmd_resp_reg;
> +	u8 mbox_irq_id = data->mbox_irq_id;

Why not just make the mbox_irq_id value a u8 in the struct and eliminate 
this variable (here and in psp_configure_irq()).

> +	u16 val = 0;

Remove this initialization and ...
> +	int err;
> +
> +	val |= irq_en ? PSP_ACPI_IRQ_EN_BIT : 0;

... just make this "val = " which sets the initial value.

> +	val |= (mbox_irq_id << PSP_ACPI_IRQ_EN_MBOX_IRQID_SHIFT) & PSP_ACPI_IRQ_EN_MBOX_IRQID_MASK;

This could possibly truncate the value specified. It would be better to 
check for the max value that mbox_irq_id should be (6-bits == 63) and if 
greater, return an error. Then you don't need to do the ANDing.

> +	err = psp_sync_cmd(reg, ASP_CMDID_IRQ_EN, val);
> +	if (err != ASP_CMD_STATUS_SUCCESS) {
> +		pr_err("ASP_CMDID_IRQ_EN failed: %d\n", err);
> +		return -EIO;
> +	}

Blank line...

> +	return 0;
> +}
> +
> +static int psp_configure_irq(struct psp_irq_data *data, int vector, unsigned int cpu)
> +{
> +	void __iomem *reg = data->base + data->acpi_cmd_resp_reg;
> +	unsigned int dest_cpu = cpu_physical_id(cpu);
> +	u8 mbox_irq_id = data->mbox_irq_id;
> +	u16 part1, part2, part3;
> +	int err;
> +
> +	part1 = dest_cpu;
> +	part2 = dest_cpu >> 16;
> +	part3 = vector & PSP_ACPI_VECTOR_MASK;
> +	part3 |= (mbox_irq_id << PSP_ACPI_MBOX_IRQID_SHIFT) & PSP_ACPI_MBOX_IRQID_MASK;

Same comment about mbox_irq_id as above.

> +
> +	err = psp_sync_cmd(reg, ASP_CMDID_PART1, part1);
> +	if (err != ASP_CMD_STATUS_SUCCESS) {
> +		pr_err("ASP_CMDID_PART1 failed: %d\n", err);
> +		return -EIO;
> +	}
> +	err = psp_sync_cmd(reg, ASP_CMDID_PART2, part2);
> +	if (err != ASP_CMD_STATUS_SUCCESS) {
> +		pr_err("ASP_CMDID_PART2 failed: %d\n", err);
> +		return -EIO;
> +	}
> +	err = psp_sync_cmd(reg, ASP_CMDID_PART3, part3);
> +	if (err != ASP_CMD_STATUS_SUCCESS) {
> +		pr_err("ASP_CMDID_PART3 failed: %d\n", err);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +static int psp_init_irq(const struct psp_platform_data *pdata,
> +	const struct resource *reg, struct resource *irq)

This needs to be aligned under the first parameter of the line above.

> +{
> +	struct psp_irq_data pspirqd;
> +	struct irq_alloc_info info;
> +	struct irq_data *data = NULL;
> +	struct irq_cfg *cfg = NULL;
> +	void __iomem *base = NULL;

Why are these being initialized to NULL, they aren't check or returned 
before being set.

> +	int virq;
> +	int err;
> +
> +	base = ioremap(reg->start, resource_size(reg));
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);

ioremap() returns NULL or a valid address, so the above check isn't necessary.

> +	if (!base)
> +		return -ENOMEM;

Add a blank line here.

> +	pspirqd.mbox_irq_id = pdata->mbox_irq_id;
> +	pspirqd.acpi_cmd_resp_reg = pdata->acpi_cmd_resp_reg;
> +	pspirqd.base = base;

Add a blank line here.

> +	init_irq_alloc_info(&info, cpumask_of(0));
> +	virq = irq_domain_alloc_irqs(NULL, 1, NUMA_NO_NODE, &info);
> +	if (virq <= 0) {
> +		pr_err("failed to allocate vector: %d\n", virq);
> +		err = -ENOMEM;
> +		goto unmap;
> +	}
> +	irq_set_handler(virq, handle_edge_irq);

Blank line...

> +	data = irq_get_irq_data(virq);
> +	if (!data) {
> +		pr_err("no irq data\n");
> +		err = -ENODEV;
> +		goto freeirq;
> +
> +	}

Blank line...

> +	cfg = irqd_cfg(data);
> +	if (!data) {

s/data/cfg/

> +		pr_err("no irq cfg\n");
> +		err = -ENODEV;
> +		goto freeirq;
> +	}

Blank line...

> +	err = psp_configure_irq(&pspirqd, cfg->vector, 0);
> +	if (err) {
> +		pr_err("failed to configure irq: %d\n", err);
> +		goto freeirq;
> +	}

Blank line...

> +	err = psp_set_irq_enable(&pspirqd, true);
> +	if (err) {
> +		pr_err("failed to enable irq: %d\n", err);
> +		goto freeirq;
> +	}
> +
> +	*irq = (struct resource)DEFINE_RES_IRQ(virq);

Blank line...

> +	iounmap(base);

Blank line...

> +	return 0;
> +
> +freeirq:
> +	irq_domain_free_irqs(virq, 1);

Blank line...

> +unmap:
> +	iounmap(base);

Blank line...

Thanks,
Tom

> +	return err;
> +}
>   
>   static struct platform_device psp_device = {
>   	.name           = "psp",
> @@ -12,7 +180,7 @@ static struct platform_device psp_device = {
>   static int __init psp_init_platform_device(void)
>   {
>   	struct psp_platform_data pdata = {};
> -	struct resource res[1];
> +	struct resource res[2];
>   	int err;
>   
>   	/*
> @@ -24,10 +192,13 @@ static int __init psp_init_platform_device(void)
>   	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
>   		return -ENODEV;
>   
> -	err = acpi_parse_aspt(res, &pdata);
> +	err = acpi_parse_aspt(&res[0], &pdata);
> +	if (err)
> +		return err;
> +	err = psp_init_irq(&pdata, &res[0], &res[1]);
>   	if (err)
>   		return err;
> -	err = platform_device_add_resources(&psp_device, res, 1);
> +	err = platform_device_add_resources(&psp_device, res, 2);
>   	if (err)
>   		return err;
>   
