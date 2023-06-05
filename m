Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A5721F93
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjFEHb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFEHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:31:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2115.outbound.protection.outlook.com [40.107.95.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E517D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0wKqd6+wAzvIf7QDyFZPjVE/gy2Cp38/YK37L5ZeBrDVhnogRjZYW2eKywqhigNsqryWV4FnoDFtVHu0rxN5blNakUYcSwlKw8hTYYEnxRBljHmL3ObMQhIu1lbWOiBze7OX6/lvdo4GNwM0qcfJHlb5EnNIGQp4b8h6CpPrfzRbhpL8SFGQyHVFMenPukCq59Koewr7PLEo5bAdOCcoYZWsaPrMzZm5f3opDBuktKE2cCTPbpO/8ZpTcD8EY4rg8pKTSWkVXf3SRzdIzc/TVw3Os66HaHwYuncgePYy4yNTyPxkgYqAdAciTlZpCidbe7cex9vdSxnqv8x6sQNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j20m/MYh7nqHEE0avCf8rD1vUfDBkzsk4ytMIDAsWmE=;
 b=aQy3d0zxXrWKL4HnbM8o42PRnY7AYoM+ym0SiNFOPXLzdi5bfvpEDumiZHEeFvYsbhjvhf//ZN5bVXDf/NMNwd8iLnFZWQLBrloxMAvKUwPJnf2e/1vYBsOovJsKs9gIYSI4IUNo9xDkfU6yQZXlJ+a3N3mA8JniFahmm/CSxzhLveOf+UT9MvQzuKEA9xT35fPqc/IvE1GJvbnCc90jJ2dcCA7vAr5cFtSd7V2krsDYPJ0gBccvGaOsS3TEjCkeF+BFTs9/7UJplVqBgD91LTBehAb0gnJwMMaU8wWSVeyAhBeejsGATxIxmdbtPmgO/VuO4uUCiotxlfLkShrGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j20m/MYh7nqHEE0avCf8rD1vUfDBkzsk4ytMIDAsWmE=;
 b=LXXwnl36gthWe5+1wzs0BICfumu0SHZTqsiUyiKkEA0QBZUTAC6xYBp2oKmR0t2PF8v+9wS8fGIiS/YuWsjbHDXR3+3n9qC496NsHZc7fpH+ORNS6UAw9g4VhfnmeDr1044ul4F+3ac/11zw34g4313TseyzMokPvdkmQEyqcRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA0PR01MB6491.prod.exchangelabs.com (2603:10b6:806:ea::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 07:31:07 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 07:31:07 +0000
Date:   Mon, 5 Jun 2023 00:31:02 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/4] ACPI/APMT: Don't register invalid resource
In-Reply-To: <91c8787f1e84d79e110a057615c838f6ac244669.1685619571.git.robin.murphy@arm.com>
Message-ID: <2a5adc-754-ec3-d139-3d49e3d7f1f@os.amperecomputing.com>
References: <cover.1685619571.git.robin.murphy@arm.com> <91c8787f1e84d79e110a057615c838f6ac244669.1685619571.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:610:60::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA0PR01MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: da7b3af0-7d99-4396-08f7-08db6596d3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm33+Gdhyaflk3nZRlrjRCPAhjyZ3nBGQLlatjPELt2Cgo7Hk8A37OSKiwqA/p5KbmnmYJiH9k4T82tTT/BxnQQWJK3x0lrSm0P0PVVAhm3pE7rfv6dM2TWRzufAPRgO4Xypp9knVIMc4nbxyuROAEN5jJ/753c7NhXUcD/AE0sxu7+BlkmEPOTgzZ1yN8RKtytsJdAeyV+DOl0ciIzcu0vW8nRUWQsrQFU1vHqkstuKWU1vT90sfnqksWksun4QxVo0MxwXfzRC56+3f1ztfC7kUyuR621dSqpcNGRh8T7V5kMy/6sRUEcM4IZZE++H13cWfS4MHRt4wGVyOcwUYoAZdcRh9Z0FWbOrw43hFXA492YIIwrJX+bMHHXIoTFhl1v2QG1Ymcy7T8aXSAgHcW7QFzKJNtsYGTDX3MXBzK7yXlJ/u7HLuD8Zud/oviUoiT0MCRpZ66ybK8QzKbDuYQKnqKbgj1MWZPk9m0DgeqqHoWWZqTyxcwCqN7RYHj8NLFhDmx8PLlJF4t0aE7YkzkYYdhHbZ9wS4DE4B1mTDzUxcnW+d8ebslGNV5fkfQUMz8EHOsfOhYaVE3NFVkaq2bbRLdQmmvCFbecDdokdFaCk9hKKJaMkUji3LEmgjgGA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(451199021)(8676002)(7416002)(66556008)(6916009)(4326008)(66476007)(8936002)(66946007)(5660300002)(316002)(41300700001)(54906003)(186003)(2906002)(478600001)(38100700002)(6512007)(6506007)(26005)(86362001)(38350700002)(6486002)(52116002)(2616005)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kr59sGfhvjNlM65oXzkmfb2hQGsIpURcRBoS7jXq2tF3cCGur7U0tPa4g2nl?=
 =?us-ascii?Q?7DieP44AExFGhFAVoOdWJiy38iR+gcCMDn0aQDHfi7EF5bScNksyHRSjOevZ?=
 =?us-ascii?Q?fUCq/vfcW0tn8KERhCBK6yAGAG1/xlIENjXvCvb0PaK6BUePAHGkwzadGgcu?=
 =?us-ascii?Q?ZOcQsdpDp5PYgFF4tPe465siy3ROaRdQEa12rngRw+5+lZSmYxCJf5SPRs7r?=
 =?us-ascii?Q?F35810zH67STLq4+1SZZv+px3pEwFrTBx4LAHyc3d/klGxajZ1qmZqy2+Pzm?=
 =?us-ascii?Q?+T+BHo8mTIqS4xVIDcdO9Buj0G7jwrDUcg23mNVP+MqNiV3dai9vfZNBE4yn?=
 =?us-ascii?Q?oXMnEi/CGHu3/tV3huHPP0Xset12J+V09DJYQRxYRoxzop+V3J0dTPGZnKuZ?=
 =?us-ascii?Q?CMxsogyDHwngrbZQPinz5SkwPDtjSpPwZAxOncDZIya9V0cdWHWqz/KG8dlg?=
 =?us-ascii?Q?gQSm7Sr25qWLu1Pa771wFGWqoskLAGNl400FqesU6vgCxHlKkB0I/BJ/ATt3?=
 =?us-ascii?Q?fxd0tyTa22qbtzwiLHuBrBswI4dpWBjPK0egTD3nEmCk2r+UWjxXwZVecHCQ?=
 =?us-ascii?Q?HwnxklyGLv6PsIyzMZNBTExFKZN2oeyiyN9hiT1gBuF60n4koFaovTH3kgjE?=
 =?us-ascii?Q?J2/Ue27BFh6u3fUR/XtCyAlP+xvtu+dBDSixC5wXA3kDvHiKyB1s3N7Jr5Lo?=
 =?us-ascii?Q?Rj/Tv+IwN4QaP/YfPVIpvMfCBLzfuTKFfhdFVI6IkkZp2GasrNkk8AWlL98T?=
 =?us-ascii?Q?7d190pRq7vOeCdnTWitctQwzlRPUoOQeX6X3hGb6MkQP+D+PUECGJuEbCUf8?=
 =?us-ascii?Q?QoF4SUGhUcNwnLJTY7R2lB5ZyVDEzO2AoUfmfu9ZyMBhmHC/YkzyWe4ugO2p?=
 =?us-ascii?Q?pFVF2oYL+tnQWuaWkB+7ct3p6H0Z4ifRgwD8AV8Qoey/1UOgLoJBUwbMWeeL?=
 =?us-ascii?Q?Wd/zNP30RuXMXjm96kinELLeEXuBRzIDyTdupWFS53k20veq/U4t8RTdJR8m?=
 =?us-ascii?Q?iFdl0o1U6KIDblOQk5S1x4fd861XW27Nwu1sTrm/sgQsa2BSu7IhUOTbC9HN?=
 =?us-ascii?Q?4TKMeQOTC1DRCoOY3sKqegU3De8MceeysdWm38w0NxlMorETY/Uaq0Zv1nBV?=
 =?us-ascii?Q?P4Dw+gLoldtlBca82RpYONSw7f6V8mRR7b6+EZa6MiEWEdYdc5wPjZbpY4A0?=
 =?us-ascii?Q?+9MaPSE5QLIsSSCQ5Og3OLqImNI79OwUPlUa5V7MT9n/vQEczkwzLkjroxeR?=
 =?us-ascii?Q?MKp6eMT2iZBNHAzY9+vwMcDyHhmfXm/vlex66OY50euHEvncv3OHqiC6jYoc?=
 =?us-ascii?Q?LHyKtF4/OUhiknlO54ydkRi4IZ00uyLOe7ABFFHEIp/B4udDQWmq0eca9EWg?=
 =?us-ascii?Q?N3luGX+mBxK/W+NZxgxTJ8GyuGTQqzb8+DnhftSr8Qb86qV1uSIpEoSVFYoT?=
 =?us-ascii?Q?JfyXnGjtvJoBTSQPhoxBOWtNPlOjMzN23JqfZUBjmi32mzPVnl5LgzDrHByk?=
 =?us-ascii?Q?E1hTNLYY2qvv8b7G5m5piv5VGRtX682gGIf5zvWLYeVUWa0xJWu73yXbp/h5?=
 =?us-ascii?Q?aYlWfZb8MlKOrT7UrSXhXkvpCeHGavwcBrr/0Fw3uCMbhU74tJcIAN+NNiDf?=
 =?us-ascii?Q?6+U0OCdGJ3BOaLFbcTv0JGg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7b3af0-7d99-4396-08f7-08db6596d3b0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 07:31:07.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9zl/bniuspXNARkD5oaG9S+nIhy7HGppBaMqEq2GMVrkOgGP1aTVnm/tlyIz6Pm/x0P7isJbUVeCCl4eyhscUX3skwrzxHUI5GtARIHAiP3zme3bnvb0hip+oO5CHP4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6491
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jun 2023, Robin Murphy wrote:
> Don't register a resource for the second page unless the dual-page
> extension flag is actually present to say it's valid.
>
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: Hanjun Guo <guohanjun@huawei.com>
> CC: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
>
> Not a critical fix, since the driver currently works around this itself,
> but patch #4 would like to clean that up.
>
> drivers/acpi/arm64/apmt.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index 8cab69fa5d59..aa7d5c3c0dd8 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -35,11 +35,13 @@ static int __init apmt_init_resources(struct resource *res,
>
> 	num_res++;
>
> -	res[num_res].start = node->base_address1;
> -	res[num_res].end = node->base_address1 + SZ_4K - 1;
> -	res[num_res].flags = IORESOURCE_MEM;
> +	if (node->flags & ACPI_APMT_FLAGS_DUAL_PAGE) {
> +		res[num_res].start = node->base_address1;
> +		res[num_res].end = node->base_address1 + SZ_4K - 1;
> +		res[num_res].flags = IORESOURCE_MEM;
>
> -	num_res++;
> +		num_res++;
> +	}
>
> 	if (node->ovflw_irq != 0) {
> 		trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
