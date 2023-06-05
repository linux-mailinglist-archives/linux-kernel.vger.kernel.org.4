Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF5721F48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjFEHOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFEHNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:13:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170D10D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJo9acQiriMgQtbtPWij4FfpNRu6in7i0DzfsQj92jJ5FA8cZAX/qbjSrvnmRwzEjacDvv02Eqi1slb5JCM1sBcnMzOPGZ5wOxal4oTnZlxkNHz3Ws70xynAuNOK+OuQUQyXvZ2hxt8h8EoyLA6G8MK3n5j2P8TFzAdUtas4WNY9qvvRu4TdvuJBVLCWU7X3ua9WDV+GXnrdBOSf08PwaL8Lfe5uc2f5gO5kmSS9YwEo/JaICVGZzS5Epqgtfy2hdEYf+BTALWhxETGmd/SVlHNy5LCLY6ZSwGHpFPwxIFP9dKolSkQxt/lk+BUJE4fP/vf5kq5A35P/G2MYQsHzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAT2znBgT2kdNQZXuvXJIyEca3K7oBlJSxypGbyrwPk=;
 b=GeV9wEx2SZxG6AhGMPleZ5t4mActxSWtC2ZDnlZ6tIpdCMCPCpjcMtvY8/ecmlE3j60WwSUDAZVjwFPEH9An7PCMRyTja7o5ofvH0cKtTZQjvBFgTdBSTeSEpW9iO3bU9aCZqPiGl59V1t664P0GQ5YnZ4a+/0skIZ8KnK0TCvqB4kz0y9RETQc67SXepHpyTDOfOPX6eYdzphqha8mwWEqWkTBBEP1R7+PHtsC+HH684TWQjgp+2HQ0p2Ko7j8CR0/rs7mrMZp3+0svwhB50vpMP0naKj28dydYNvjxhxqpDnzqSYRZzbJgPQfUVAd+zG2KxKtwVsVwbP9hMNmiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAT2znBgT2kdNQZXuvXJIyEca3K7oBlJSxypGbyrwPk=;
 b=EWMcGX3hsydoL3nMoxD6LUyCT8oYJ69lxkYeLWPFFJ5Gf3uYM/pSdfaG9srr5uBIy6d4f1zMhzgJpcbN4njkDC9bzAvIS2gFIwpemvbFpL+uj4CpahZYU0AdmEk8UKM9AqHJor7LGsOWLEM4y2QXfhXtZJg1b+2voB3Aud/yJqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB7292.prod.exchangelabs.com (2603:10b6:303:157::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Mon, 5 Jun 2023 07:12:39 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 07:12:39 +0000
Date:   Mon, 5 Jun 2023 00:12:23 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf/arm_cspmu: Decouple APMT dependency
In-Reply-To: <3509b299b19b8bf89700c77c2bb695c740926ae7.1685619571.git.robin.murphy@arm.com>
Message-ID: <be916ba8-1d2a-89dd-7374-b07618fa9b29@os.amperecomputing.com>
References: <cover.1685619571.git.robin.murphy@arm.com> <3509b299b19b8bf89700c77c2bb695c740926ae7.1685619571.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:76::28) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e64e73-d11c-4142-bc82-08db65943f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bq486IGYygzNMaeoCx7BblOH7CNIiknaEHht8ldg9E2WuAarkAHHxwDuorsWbq9mG5QvEN3jXRDDJJ4mKHpJvtd2VI6RXiFEfmM2Pgk7oUUeXAzHbrLFMKdDPIw8ebpbJfz5ZvwwF1ANy4XOTG2w3fxvaAXxBzYhXZYxhTXXZRe+uH0D07qnn85vNlRA5w92viZduut50iWnYfRr3iQWYsmuvthk0fwIi7z7OoyMS2FR7T3k1vWBUEPgScYb2HBnj3cTM4qbADpJb8THdluENKst0KCqJuw7Nt4BDMrjNpWNTE0J6evlGhKg2zNik5AeCTqu5jSBy8ReExk0KGd75cpy9mKlVeTrjKIdiZGxpGGfdZs8oPkjSCCDX/lG0JeHvIWPhPUs8iRDciyhBoR4DCogYDJgTv4Q3bdxCxUw0B6gdgqOcEC2M+DiRYHYzJEorJQgDf6EgkZcdEzbuA84B6/EGTyKxW+HtCF06HIUVvIlWnW6Zr+uL9x6A/8dgYU+VNFcwlTHX4yyz+mm55NI7qWzPuSAyXQ23uIq3k4OEsz/llvAZtYhiYPHdbpggLf2CgfigHn330aVXbxxMpUB+tyAQTh0HUiIMKe45lkmIktZ0wXcxx5vfpsYbFV5Z7/X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(396003)(136003)(376002)(346002)(451199021)(478600001)(2906002)(6486002)(52116002)(6666004)(2616005)(83380400001)(186003)(6512007)(6506007)(26005)(31696002)(86362001)(38100700002)(38350700002)(316002)(31686004)(8676002)(8936002)(66946007)(6916009)(4326008)(66556008)(66476007)(5660300002)(66899021)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7uNvCAYVUPJBVtdqwhDkoxDPufTEW9QKwnpWwuJg6SQhjwHLM2A2WzqEvYJn?=
 =?us-ascii?Q?i7zT+xBdnAuACLoIf7dnjJ9tDqsXXUg//o75TIevOGIQAFdEhSLC4uYKQ9LG?=
 =?us-ascii?Q?S9M23X6n8S/BKCB51fl65wyU2lsfsu3f/1oIwLpRqN5ucsTQQjQ9gCWTTkTV?=
 =?us-ascii?Q?CuyI9t8T7lALVs+toqRUxeyKAvBvOj1+dnosXMvLicPzXAfb2BBXbw+T8GV3?=
 =?us-ascii?Q?9XBc49nytKj46Gz3AMylIJS+47H6yjh5C/vAuLkid+ayboq0W9+VJyMI2wgQ?=
 =?us-ascii?Q?/2XnQBp5eDYvTL5tbuSZ6Or4w214LYzXYY1pngdgAgWyaJ7xqQI9Ya73LVQu?=
 =?us-ascii?Q?po5t7x9nFCtXWEk/pLdPSKhPRg1vFai2xF8A7HMLNJJraJv6iqcHbCHi7k2h?=
 =?us-ascii?Q?J78pVgHZhKw/3CVHaH+UurNp9ijm0vrK6nmTR1gZazTuiamAjGJSrDfFPFmt?=
 =?us-ascii?Q?xu+QdXLn6/csDnFmPrmrm3vJ2JcKVKyF1OP2bP24qHQcd6X47k0yjV/+pn11?=
 =?us-ascii?Q?Wmzbyr0STjaLZSWE7zftHQl9p5LuFgHBXSwtVfCCW/DyJP0rXdblDJTorf2o?=
 =?us-ascii?Q?yWqb7Ucs/TJz4Injinh+M3FpQ9wwo3nWBU97Z0R+ElV2d6NUvN69Cf248AQH?=
 =?us-ascii?Q?0w/wkJYyJbtSnFlR+55RNKRbSo/SmgsdQ/GFpz4MbMplndbNhrGzKVKRskQ3?=
 =?us-ascii?Q?EHZA9J5HgCvQmizTI7DfJHPROfjXxhROTzlzmDyCRRsPbgY2sFOGe6EOK1QO?=
 =?us-ascii?Q?6thfntgbvwEBJtgSjqItSES2RpPkJeYPCCs+wC6V9/MXHyLC/0s9RwA9DLTG?=
 =?us-ascii?Q?9zrZE2+qcx+xfVjHlw/cXAp4T+ihmv6gMpa7W59YaqeKuh0SDoPBEeRDugh4?=
 =?us-ascii?Q?XPxfSebmPUWx4KfvUhZX5ZCmwW3XTgBmX5g+n4uz6LqDe0pm3jhTepMT6Jyk?=
 =?us-ascii?Q?w+HqmFyZerh31+VSwf7OO8nKRz7gPfUP3iMA87yJ5IPDFezaXQaHuzUluFZl?=
 =?us-ascii?Q?kY2msUNh0K/gu+m6Uhmy16Dxb6XZom+Yrm+Ilk3N0JSLXPdBjiAGrI0N9Z1K?=
 =?us-ascii?Q?u4ShXgsfhaokV5UJoKxSAROQR0JqZJV15wkFSJ7bYrRFJUV/DCaAKwK7YkHa?=
 =?us-ascii?Q?O3igyVuHXdKSQkcIEuWk6dOsdR7iVeIjk/Lh+ne1FLhFDG2VV/ITzljJu8rZ?=
 =?us-ascii?Q?4pr8XhjMqzJqP6p2kPoMx873jDETKanEgxWBBLDc6wm5eAtankkqh/scc1iU?=
 =?us-ascii?Q?JxZ06Mi140eN96aYlj0d+rp2dQw3UzNJA5ewmkYbIhsCnVzAtaanggdYOgw3?=
 =?us-ascii?Q?j6nemMmTtO7iNQZs68hnrYkpwfk3vPmG8RG5dNeMS1Q2aStOuP2AehQ6S03I?=
 =?us-ascii?Q?rZZwgIuEMO5/zH9VVOF/fy7+2Sg5vgudw9q7zQsOPkNaU2ceyuNCwyxL/wlj?=
 =?us-ascii?Q?KXiFNj1/AWotdyHUP6x2nWbEkYJszGl5Pn6Xx7AwvE7oC5Z/mc7cjzKcqSNK?=
 =?us-ascii?Q?7C7sE7tLhp/W0ubgLrjLdivLa+DUUeJ6Gwr1/lIvuG60GVmZvRfnh3RfnXsu?=
 =?us-ascii?Q?4QUqZhg8kMEwSBu0Ld9YQut3cgv38i9zux7EwAik4OYez2HUq9Y3LpWmP+Lp?=
 =?us-ascii?Q?YwAmqWlcT+NQvUPIdFSRxTw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e64e73-d11c-4142-bc82-08db65943f06
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 07:12:39.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BAwNSLvb+8t9lPTItnwAc666ZYQaMvhWG8JKLRHCT7qlYRTnR3WWrMNA7acQHnJr5Mpko3bl6BYKr7M0urMf8z5ELvdE9LHUysVdGv+IBMeGas2iNzg5ayAUAIVr97W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7292
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

I have a couple of comments below

On Thu, 1 Jun 2023, Robin Murphy wrote:
> The functional paths of the driver need not care about ACPI, so abstract
> the property of atomic doubleword access as its own flag (repacking the
> structure for a better fit). We also do not need to go poking directly
> at the APMT for standard resources which the ACPI layer has already
> dealt with, so deal with the optional MMIO page and interrupt in the
> normal firmware-agnostic manner. The few remaining portions of probing
> that *are* APMT-specific can still easily retrieve the APMT pointer as
> needed without us having to carry a duplicate copy around everywhere.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 45 ++++++++----------------------
> drivers/perf/arm_cspmu/arm_cspmu.h |  4 +--
> 2 files changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 3b91115c376d..f8daf252a488 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c

...

> @@ -319,7 +309,7 @@ static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu)
> 	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
>
> 	dev = cspmu->dev;
> -	apmt_node = cspmu->apmt_node;
> +	apmt_node = dev_get_platdata(dev);

Was platdata changed too? If not, I think this should be

 	apmt_node = *(struct acpi_apmt_node **) dev_get_platdata(dev);

> 	pmu_type = apmt_node->type;
>
> 	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
> @@ -396,8 +386,8 @@ static const struct impl_match impl_match[] = {
> static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> {
> 	int ret;
> -	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
> 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> +	struct acpi_apmt_node *apmt_node = dev_get_platdata(cspmu->dev);

Ditto

> 	const struct impl_match *match = impl_match;
>
> 	/*

...

> @@ -910,24 +900,18 @@ static struct arm_cspmu *arm_cspmu_alloc(struct platform_device *pdev)
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
> +	apmt_node = dev_get_platdata(dev);

Ditto

> +	cspmu->has_atomic_dword = apmt_node->flags & ACPI_APMT_FLAGS_ATOMIC;
> +
> 	return cspmu;
> }

...

> @@ -1047,19 +1029,14 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
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
> @@ -1109,7 +1086,7 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
> 	int cpu;
>
> 	dev = cspmu->pmu.dev;

You didn't touch this one but shouldn't this be

 	dev = cspmu->dev;

> -	apmt_node = cspmu->apmt_node;
> +	apmt_node = dev_get_platdata(dev);

Ditto

> 	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;


Otherwise the patch looks good to me.

Cheers, Ilkka
