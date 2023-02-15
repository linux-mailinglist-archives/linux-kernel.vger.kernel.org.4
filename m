Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587F697947
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjBOJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:48:09 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FAE3431A;
        Wed, 15 Feb 2023 01:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyLDE04ODc8JOMtXQfd6fDqxe7X9TCEbFAOmkZJUCogpVugDWsC4V+llxEqH87xdvQTCjnpE4SnFls5POOZUk6tEVUGz9i7J261VBL77mySSPpt12zlql4BcGyTlfQ9eCaOqw8LfvxHiI9A4YLoNpmPD93/Ft8JZcUU5j2YH7cfJ4wXqBTx7QOtfqq2s7nBW37APMIK19xGd0YHwg0gPhyWBR2+OtJQ9QbsWe8L507w9X1W+Ocr2+hTHXk3vzjWlORqJlJpwLQ0tjzDU9pVtbEOA0259fIwL9jIpAPihqEz0O7nkhfKK0OPgq6K/OUijv9lT8u2/3paIG9EeSo3ZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//5s6MWlEQzScrF9JyHzDXZu5zwbXHKZtcIT2aR2qdc=;
 b=Ru8Qgt0MTZpFhQrpQbEuMwjC5myi9saneudMSAZVsompN8R7fVEKP3oJT7n1NI+ppf1r2eENvtI2lx9RGdQB1U4QuMYvdzD79EBfwhMUk9cQxA8nh+tXT0hSPqcliHRsJkPDbYbji0X+0rIVj8EWVnz82B3TVAxuR/dwsdfrgIWyQh0dMtlz81XcW1Svz5c8aAVBsyrVFQnthW5pRShYGbnT8uPFxBKizTCbID83dUqFZhHKw1w8479KSwFcq+mBjhjFA2Lk8Nw3uo7zuFbEekEtr7yUJR5ocVsAP4o7qtYWQrPY7+SSdyrx41w3XX7/1tg4ciBCDCrMEkMUbC7B1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//5s6MWlEQzScrF9JyHzDXZu5zwbXHKZtcIT2aR2qdc=;
 b=T/APsQIhVj3qmP/3NHEK1xoI5G2VBYaaZUQ261VtjvvGavtxC1+HqjklGKQH/+uvUCniiBh0Qm8ol0Ra2pqEoLiVAqFOcW4+9agXk/P5VID4VDCmryCK3rLs6xSUfN1isq4To57qB27n3XgDRNkIGw28q8PIr84v86MsmI2C7KfzVnaQY/bpdF4zCUYp82GtWzSRaesa/EKS5huskutmNmugFFMhAR7UtWN2LejhaKAa8jWdNFEbOK83CiCOvvua9AuOluQOjyiJCb7pngtHIRpE+joTXsHQdMdJNgxZEgG6lkobnhoCO3khVc9jb7zw2t3bmEE0XvsmcnCgS7o+8g==
Received: from MW4PR03CA0263.namprd03.prod.outlook.com (2603:10b6:303:b4::28)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Wed, 15 Feb
 2023 09:48:05 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::70) by MW4PR03CA0263.outlook.office365.com
 (2603:10b6:303:b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 09:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Wed, 15 Feb 2023 09:48:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 15 Feb
 2023 01:47:51 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 15 Feb
 2023 01:47:48 -0800
Message-ID: <55f2d37f-9f60-a767-265f-86f75e77d5ab@nvidia.com>
Date:   Wed, 15 Feb 2023 15:17:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] soc: tegra: cbb: Drop empty platform remove function
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>, Sumit Gupta <sumitg@nvidia.com>
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
 <20221212222549.3779846-4-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20221212222549.3779846-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f16b42f-6433-4d46-91c4-08db0f39bbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAT41/BX06B5FnSafPyUFdUe/CJGji132K2O0fTqLZApGcehyvD+f4Lqehtn4xFVqDUTcm4QV8N3X0KZQqCIGoSHexmU2Hx1n7d0lukrtw4M8CeKKXW7bPGqb5x2x2So+bk/5di/oASE1GX1eUUS6jynLhdHqyDx6r0yuxTGbpGdfyV/qkuxui1uRVYfROBKC0qQon4CkBnE0P04W/B2qPj6GwjtTtTJnf7GVUBHhgjsYtrgsHt+u6295tIidpk7iWX7gbSnh1ftG4cK7phq96O3+QOvoI7FvSC8rhtoal7NUUcZc/9t28Wx/CrkpHOReaNi8pHpVNzBQNi5QrMtrA5CgII1Sni/oV4C9Iz1/OFoS5nTkv/i15IzMwftj7ha8AkMLzxCPsyFGymfBxgtvTr6g7UO2uBxMTaTiL4Ebzef6qQ19mLgRLHu2Ef3wWm4KHTkYlgfbC6Bme+ImeGmKJU/fqiLuJTZK6bF77THq7HtDwFKFt9d5cN69p9VoSYMO8606S0mxDV8SsvRFie/Xi6Z9bfYcSAMegb9Mz2AoWfLg6v6IgJgZm5WE/6CRi/gjeetAYcvSObcP8GFz20M4U/oLBPxptGR5BcAriSr+O3qaa0R7CmQtpFklZmNy3KF4hlJF9rD+ASKvS9Ri55iUdEuaCxuMB/v4RJLgE6k5HIwj1DX4MgsS8gjMVMHWlxgN4D8lGAg1GmIMs9A7a5/VVd1rA7OBOd1lPLZLyqfiE8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(7636003)(4326008)(83380400001)(40480700001)(36860700001)(40460700003)(41300700001)(110136005)(70586007)(82310400005)(16576012)(316002)(54906003)(6636002)(2906002)(5660300002)(36756003)(8676002)(8936002)(70206006)(16526019)(336012)(478600001)(426003)(2616005)(47076005)(53546011)(6666004)(26005)(186003)(82740400003)(31696002)(31686004)(356005)(107886003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 09:48:04.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f16b42f-6433-4d46-91c4-08db0f39bbd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/22 03:55, Uwe Kleine-König wrote:
> External email: Use caution opening links or attachments
> 
> 
> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

> ---
>   drivers/soc/tegra/cbb/tegra234-cbb.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
> index 3528f9e15d5c..3b26dcf9a70c 100644
> --- a/drivers/soc/tegra/cbb/tegra234-cbb.c
> +++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
> @@ -1066,11 +1066,6 @@ static int tegra234_cbb_probe(struct platform_device *pdev)
>          return tegra_cbb_register(&cbb->base);
>   }
> 
> -static int tegra234_cbb_remove(struct platform_device *pdev)
> -{
> -       return 0;
> -}
> -
>   static int __maybe_unused tegra234_cbb_resume_noirq(struct device *dev)
>   {
>          struct tegra234_cbb *cbb = dev_get_drvdata(dev);
> @@ -1088,7 +1083,6 @@ static const struct dev_pm_ops tegra234_cbb_pm = {
> 
>   static struct platform_driver tegra234_cbb_driver = {
>          .probe = tegra234_cbb_probe,
> -       .remove = tegra234_cbb_remove,
>          .driver = {
>                  .name = "tegra234-cbb",
>                  .of_match_table = tegra234_cbb_dt_ids,
> --
> 2.38.1
> 
