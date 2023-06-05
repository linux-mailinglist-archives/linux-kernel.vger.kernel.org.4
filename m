Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3A72316D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFEUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjFEUaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:30:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2098.outbound.protection.outlook.com [40.107.237.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4D98
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aULAd32Dpe2Y03zbr9zaMUZfQyqsar7Nnn5nSCNQRJJFYG4Y+rXAz2f9XgcdAyW5zWXiyqsGFX4CGmLS/QL44Y1tk5kJ3fUYvE3pgFfFch63diz3T2Q27PtdLU3FovL5PtdUuSmLy3Sa0WqHbyi61nfyDhBPGmVmLbAsPQNbRAcnwpSVGieKFP4Qcj/QOWDiPw5Tf/t7UhMtQAKvAqZY8ub//5shD/IHoCp+dlh9BtCCULBTtyAcZmKnURjAhxOW1clm2vPK3Xrj8P27gPIUvwdcvcaYOAga9eZBGSpXZM+wg3EkK0DhJr82qXIAP+dq6k/QE5wcTkGjEYUAVdDWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mNTzm6kQQDirapgHT1wtPPTGxnKkmmv5k1aY91pU/4=;
 b=WcmZ1Yy2eI1NJ1c9iLWkl6c6nl+AZqPVGby5Eyad6lSdbsfsd8K+wQtJx10poENvf9rkZqo4ronMIpIH6Jqrx6jvrlvIPYSXjcDQsvXZJOMJcCfIZwJcQ26KLfrDmw0oE2RyDLxqrG7W45WgIL1IH62Q7GGTldW3b+Cp8IAkt0GDH4fLsw8fCa40mS8UlQwvrkSX0MeW5nHAe24tGe4Qt1v7g9zl7mFVSpD63yB9zBdLZmuFTFFVaPMgkQoyP0qe8gtBPLLVRSeHGeaz2oqwe5Or73ZSAQ0g2GWrH4yHk4WjReQBmFTxjaExR4djd09y6puTxYsgUCahdftRkl067w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mNTzm6kQQDirapgHT1wtPPTGxnKkmmv5k1aY91pU/4=;
 b=kxkNrrtBii3AE+gFa8DpvPnEomAdMIP5PitlSoS9zWy0021z/ZmJKv3WkRUo7hLCGc9IF42N863BW8o0vjr0QyLvM+rOe785jJoMBpAcRxxICFHTeSWZ0LYQqapplK2TAgUJiGcbweaYO3nNHbedcfZP+7CugI70jBMUPamaWYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SN4PR01MB7440.prod.exchangelabs.com (2603:10b6:806:1eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 20:29:55 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 20:29:55 +0000
Date:   Mon, 5 Jun 2023 13:29:40 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf/arm_cspmu: Decouple APMT dependency
In-Reply-To: <88f97268603e1aa6016d178982a1dc2861f6770d.1685983270.git.robin.murphy@arm.com>
Message-ID: <f245332e-44d7-255a-4758-a12c21eb7917@os.amperecomputing.com>
References: <cover.1685983270.git.robin.murphy@arm.com> <88f97268603e1aa6016d178982a1dc2861f6770d.1685983270.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:610:b2::23) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SN4PR01MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 45df2764-103d-4ac0-3f2e-08db66039f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5R43Gjk/xeaAtp7EAs9rvnv1bvgOFEZwv0HIvdJL+edynLCcNHAVI8T4GbXxPZFl5uS2lR+lwatQ6W9F3f2dX9JcgC+zHJ1Cw491UJQxvYlC1buu6cM9ZFqlWyc8cGPQa5eC0nDcDDQJowC2JwQLP4orvrY9p5oPRRcPGf0+yvHNmG6amtyBVyhWIhmisR6oall7XE4xhLSaA5ZwPVkz9h2SgHOfOUuYM2uTBWWBYZDtgPXBsTxCQmL4UgbLu+YevUkwfiDiW8J5d6kFaxrWOohN42euAS2nT179WWkIO7nKYAzNtsnEK0gCW08Sl1uQLiEBARqBeK32QPQwGjb2tHCH4b45wwJaPXx/Iz1neiTY6tWw9IbqM9e6oe8xYH9Rl2gqGbS9neaBNAYV+UP6ZYR9g61T6blMChpScujRtRivjwVGAAV4xC+gxiiH14GtLXSwovuzfxhNwZhovr2qUVnZHemqmwGbxOOvilau08axyTOtcxBP1ANz0xRCTLoTaHVybYP6Zd2gKP33eyOZZaPS0awAadk+n2rYgym64I0G9orR76GPEZj/qdQPpwLyBcRlDO+lnoh1zNOPxDqjk7RKykv0lXrynJy5KQLv+Dvv9VfdBl9HeJsq5m1dmEI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(66899021)(478600001)(8936002)(8676002)(5660300002)(86362001)(2906002)(31696002)(4326008)(6916009)(66476007)(66556008)(316002)(66946007)(38100700002)(38350700002)(41300700001)(2616005)(6512007)(6506007)(26005)(186003)(83380400001)(6486002)(52116002)(31686004)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3QE+n+GP53xGnbu6/zu0w195dkXtFoioRACK5Atea/OFnaDurvYGB9U4Vt60?=
 =?us-ascii?Q?W1hENuVqyLVPRytAT/nTnQmO9qhusBmkWqntPyuwPWY8NKIF6BCI/L1YArYb?=
 =?us-ascii?Q?ccYvqEwRUuCwI/GBKrnnhYWeMcUf1Kw987oNeVC7VL085KvFvDncqsDf4VfZ?=
 =?us-ascii?Q?seVDZeFmk17XbEr602KipRx9G7teRnaSTeZ3YT3qQXgsMCT7kHW4sBSxpBBR?=
 =?us-ascii?Q?3lyOZ7WHCSTUqJJA5OCiuuSy4Td23oU++uZisVOs93ECJh/s75yLKbhNr48U?=
 =?us-ascii?Q?Lp/TpEuRh7eDlfV76XMhDyn2wbbN/pmdpJpO5Pu5anMCVingrb1FXDGPJOv5?=
 =?us-ascii?Q?l6zgbNzZQ8Yjd5TWvl7Nhs750sjZwCnaC3erXVx7DYsFVGJOE846bfF73Ur/?=
 =?us-ascii?Q?HkY9fMShcuYMURx4bGY9/ISqFI0RsKigIQWc5LAXCNaniZmx11qpOmAY6L6h?=
 =?us-ascii?Q?rd4jYD3Var5XfZdTHnp5keO/xHdcsFZOAeZbzFkvG1LUhWOZ9Is1RVlkh3X/?=
 =?us-ascii?Q?KuQedUQdyxfsDvJfUEDJf+GunUwEwlmOQaDUHXV3q9k76jfhvRKwXiv3LB5K?=
 =?us-ascii?Q?yZf6w9z4KE/2k/wjwt7SdXtX7uvwTE5qkH1LtM9C0WmZZcvFhtrNUWPMbpXl?=
 =?us-ascii?Q?JUuX3L0EZSKAOSrHXW09zzZDjEmjxutQgLq9eqsmB7PfjJzNUPuhwDwxiuaO?=
 =?us-ascii?Q?qJ+VOAtK6g469biQGxEZWz6IWqzJT8XdH2jRCp0SCob4JcXu2wvH3bOiAAC5?=
 =?us-ascii?Q?tb7sJCeFg9gFUUUuT/CI84acdov2DXXZ/7LhwpERPIp6+jBYN/i0t86A4YwP?=
 =?us-ascii?Q?a0GggTMXknvMT0tVPr7IpPlHWHTca5bRo8VuUSpbiL7kzFLv+9Smf5VNRo3N?=
 =?us-ascii?Q?jwEv6lPcZfIyHoy8MRSm6YfCl+MkII2yLocZrB4JIWAWGyywipZF4FFHfbLL?=
 =?us-ascii?Q?mkBR3RSwPAkuqWp+VWZlcICXf1w1q5x6tZjAgfaErMw9gS/Cq1+l7Yv/ZKSX?=
 =?us-ascii?Q?Wgj8ORvGt+WhhHTYHZ7DsCaO+k3SSDGcnHnxwuQDpkSgg8AZ51F7vI54LB4Q?=
 =?us-ascii?Q?cHUH2BpzSSXb/xHUouDPniApVLNWrcFmNms+hqSXf80XiBcLRFR3FOnDRwVj?=
 =?us-ascii?Q?w3ZrmPee8vMiMYd5w5Z0lFfIlfgIiNY1ovHZnpmWKm+VZt0P9VkMMEt86QoY?=
 =?us-ascii?Q?hVFHlIxWKE37OGuIPyTZdM0trhWfgLq4ZZ9i8SKOGLK9Dlh1w5olcu8BxIYZ?=
 =?us-ascii?Q?1dXrO4/Q0wJeJb9knlRYX0KfEsRw9ETgiTP8jOiI2q4hi6DycXc7ekyYKTn6?=
 =?us-ascii?Q?yD+GFstZzWNnNvy2p+XIwvd+oAJskDr3F5PMDWBIc5LU+8wSJczalKwYJIRI?=
 =?us-ascii?Q?y+aJULefJOI+B4p7UeG9ApJ05/dWlO3eGP05NMBdSvzyLppDbJydDG1Zij3M?=
 =?us-ascii?Q?rQFT2GUp+Z7yfGL5/7Lgv2Ny3/2XlQ1nq2/+pjA1CnCRZf3NWpUdZvwYiXex?=
 =?us-ascii?Q?y60afdRRCIyqeHWYzwB55iMY8Z4j9RZqwRqzy/FGwrFQ5LTlKegCjGgjTwXa?=
 =?us-ascii?Q?oCpIiyNokgD8jLhKRRjC4yqbtebbjIy8muvxq49LkAp6YJIYdtu8IVizegk5?=
 =?us-ascii?Q?/mxgAEuYDxw4p1YiDuMnwyE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45df2764-103d-4ac0-3f2e-08db66039f82
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 20:29:55.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvEILuOEMFMJrqpWeY6GX9HcLSddsqOLi1sGPkQox0xV5P4fyXW4mpZDWrNsKPkLUpGe4+wuPw/lpKa9EjlV8kuobnCf7o5c0ANxcgWMBvdvUWxoUKgxsIUjkSpz/anc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7440
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Jun 2023, Robin Murphy wrote:
> The functional paths of the driver need not care about ACPI, so abstract
> the property of atomic doubleword access as its own flag (repacking the
> structure for a better fit). We also do not need to go poking directly
> at the APMT for standard resources which the ACPI layer has already
> dealt with, so deal with the optional MMIO page and interrupt in the
> normal firmware-agnostic manner. The few remaining portions of probing
> that *are* APMT-specific can still easily retrieve the APMT pointer as
> needed without us having to carry a duplicate copy around everywhere.
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

>
> ---
> v2: Fix platdata dereferences, clean up now-unused acpi.h include too.
> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 54 ++++++++++--------------------
> drivers/perf/arm_cspmu/arm_cspmu.h |  5 ++-
> 2 files changed, 19 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 3b91115c376d..38e1170af347 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -100,10 +100,6 @@
> #define ARM_CSPMU_ACTIVE_CPU_MASK		0x0
> #define ARM_CSPMU_ASSOCIATED_CPU_MASK		0x1
>
> -/* Check if field f in flags is set with value v */
> -#define CHECK_APMT_FLAG(flags, f, v) \
> -	((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
> -
> /* Check and use default if implementer doesn't provide attribute callback */
> #define CHECK_DEFAULT_IMPL_OPS(ops, callback)			\
> 	do {							\
> @@ -121,6 +117,11 @@
>
> static unsigned long arm_cspmu_cpuhp_state;
>
> +static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
> +{
> +	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
> +}
> +
> /*
>  * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
>  * counter register. The counter register can be implemented as 32-bit or 64-bit
> @@ -155,12 +156,6 @@ static u64 read_reg64_hilohi(const void __iomem *addr, u32 max_poll_count)
> 	return val;
> }
>
> -/* Check if PMU supports 64-bit single copy atomic. */
> -static inline bool supports_64bit_atomics(const struct arm_cspmu *cspmu)
> -{
> -	return CHECK_APMT_FLAG(cspmu->apmt_node->flags, ATOMIC, SUPP);
> -}
> -
> /* Check if cycle counter is supported. */
> static inline bool supports_cycle_counter(const struct arm_cspmu *cspmu)
> {
> @@ -319,7 +314,7 @@ static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu)
> 	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
>
> 	dev = cspmu->dev;
> -	apmt_node = cspmu->apmt_node;
> +	apmt_node = arm_cspmu_apmt_node(dev);
> 	pmu_type = apmt_node->type;
>
> 	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
> @@ -396,8 +391,8 @@ static const struct impl_match impl_match[] = {
> static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> {
> 	int ret;
> -	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
> 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> +	struct acpi_apmt_node *apmt_node = arm_cspmu_apmt_node(cspmu->dev);
> 	const struct impl_match *match = impl_match;
>
> 	/*
> @@ -719,7 +714,7 @@ static u64 arm_cspmu_read_counter(struct perf_event *event)
> 		offset = counter_offset(sizeof(u64), event->hw.idx);
> 		counter_addr = cspmu->base1 + offset;
>
> -		return supports_64bit_atomics(cspmu) ?
> +		return cspmu->has_atomic_dword ?
> 			       readq(counter_addr) :
> 			       read_reg64_hilohi(counter_addr, HILOHI_MAX_POLL);
> 	}
> @@ -910,24 +905,18 @@ static struct arm_cspmu *arm_cspmu_alloc(struct platform_device *pdev)
> {
> 	struct acpi_apmt_node *apmt_node;
> 	struct arm_cspmu *cspmu;
> -	struct device *dev;
> -
> -	dev = &pdev->dev;
> -	apmt_node = *(struct acpi_apmt_node **)dev_get_platdata(dev);
> -	if (!apmt_node) {
> -		dev_err(dev, "failed to get APMT node\n");
> -		return NULL;
> -	}
> +	struct device *dev = &pdev->dev;
>
> 	cspmu = devm_kzalloc(dev, sizeof(*cspmu), GFP_KERNEL);
> 	if (!cspmu)
> 		return NULL;
>
> 	cspmu->dev = dev;
> -	cspmu->apmt_node = apmt_node;
> -
> 	platform_set_drvdata(pdev, cspmu);
>
> +	apmt_node = arm_cspmu_apmt_node(dev);
> +	cspmu->has_atomic_dword = apmt_node->flags & ACPI_APMT_FLAGS_ATOMIC;
> +
> 	return cspmu;
> }
>
> @@ -935,11 +924,9 @@ static int arm_cspmu_init_mmio(struct arm_cspmu *cspmu)
> {
> 	struct device *dev;
> 	struct platform_device *pdev;
> -	struct acpi_apmt_node *apmt_node;
>
> 	dev = cspmu->dev;
> 	pdev = to_platform_device(dev);
> -	apmt_node = cspmu->apmt_node;
>
> 	/* Base address for page 0. */
> 	cspmu->base0 = devm_platform_ioremap_resource(pdev, 0);
> @@ -950,7 +937,7 @@ static int arm_cspmu_init_mmio(struct arm_cspmu *cspmu)
>
> 	/* Base address for page 1 if supported. Otherwise point to page 0. */
> 	cspmu->base1 = cspmu->base0;
> -	if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
> +	if (platform_get_resource(pdev, IORESOURCE_MEM, 1)) {
> 		cspmu->base1 = devm_platform_ioremap_resource(pdev, 1);
> 		if (IS_ERR(cspmu->base1)) {
> 			dev_err(dev, "ioremap failed for page-1 resource\n");
> @@ -1047,19 +1034,14 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
> 	int irq, ret;
> 	struct device *dev;
> 	struct platform_device *pdev;
> -	struct acpi_apmt_node *apmt_node;
>
> 	dev = cspmu->dev;
> 	pdev = to_platform_device(dev);
> -	apmt_node = cspmu->apmt_node;
>
> 	/* Skip IRQ request if the PMU does not support overflow interrupt. */
> -	if (apmt_node->ovflw_irq == 0)
> -		return 0;
> -
> -	irq = platform_get_irq(pdev, 0);
> +	irq = platform_get_irq_optional(pdev, 0);
> 	if (irq < 0)
> -		return irq;
> +		return irq == -ENXIO ? 0 : irq;
>
> 	ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
> 			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
> @@ -1103,13 +1085,11 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
>
> static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
> {
> -	struct device *dev;
> 	struct acpi_apmt_node *apmt_node;
> 	int affinity_flag;
> 	int cpu;
>
> -	dev = cspmu->pmu.dev;
> -	apmt_node = cspmu->apmt_node;
> +	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
> 	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
>
> 	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
> @@ -1131,7 +1111,7 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
> 	}
>
> 	if (cpumask_empty(&cspmu->associated_cpus)) {
> -		dev_dbg(dev, "No cpu associated with the PMU\n");
> +		dev_dbg(cspmu->dev, "No cpu associated with the PMU\n");
> 		return -ENODEV;
> 	}
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 51323b175a4a..83df53d1c132 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -8,7 +8,6 @@
> #ifndef __ARM_CSPMU_H__
> #define __ARM_CSPMU_H__
>
> -#include <linux/acpi.h>
> #include <linux/bitfield.h>
> #include <linux/cpumask.h>
> #include <linux/device.h>
> @@ -118,16 +117,16 @@ struct arm_cspmu_impl {
> struct arm_cspmu {
> 	struct pmu pmu;
> 	struct device *dev;
> -	struct acpi_apmt_node *apmt_node;
> 	const char *name;
> 	const char *identifier;
> 	void __iomem *base0;
> 	void __iomem *base1;
> -	int irq;
> 	cpumask_t associated_cpus;
> 	cpumask_t active_cpu;
> 	struct hlist_node cpuhp_node;
> +	int irq;
>
> +	bool has_atomic_dword;
> 	u32 pmcfgr;
> 	u32 num_logical_ctrs;
> 	u32 num_set_clr_reg;
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
