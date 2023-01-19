Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7718673918
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjASNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjASNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:00:27 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E139D4484;
        Thu, 19 Jan 2023 05:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTmTcmYT7dWuTRzfaoQTFZDp0vPqfoHcJBqegs9iYX4DYaZdX/sYzDpZlRZR5rpg9xIPNW3/R/az8PmTU5paJIGyIXPBl6DRc/u0KxV/JLcy7KISc68DN+jPzjuq9UL+apK+B4p3EwtV7AKwptBs37K6hUzorCiPeKP1UdPdu1913QHOmQAd6649pJ54T6Usv3LTz1ApfcYbWKkNDRzts4lhkiQ+CkGWTpefm7RcZioCFFcT0f37QfznFv8/lPA0KDRdBNGBlU26JzBJO7Ev3+FmHLYrhdlEIyMkhjWIfG00BP0k/ZuuLCUA8+5opiWupFsDf3HPSOkQsOVf1UjMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAIjldhDl5F4rrLg7OXNmCguuRZmXx/HvVz+E8c7K+0=;
 b=kwUqh7B8hxunTIdazefTiQZgzsT1BCwuv3Vx/YVt90OLaWQVt5fyENdVGBMBoDK0lIt0q5rR2knmgCMg6hgF0TY3WlKlz1/vA9tNsIvJN9o+Leoqsz2MpBS/BGwAxVh7MqvlqZOCUZsMewphIf2vUf1nQ78LxJH0Anx3s71VB/dPBhb3zH1L3jdc61YrCpnmQmxNluPwG522E6y4cyfQr0tSP4omTDw9TDjKk39cdkfX3xSh7i9zvRyRAjSK5QCTReMSnue5E/Mi4z+TX66CRJ518MbXls8Zc4Z/ndrLskJYeyRGCEjx7OskodS+F6G9HF2eMEHKBf2jtNh0Ww8uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAIjldhDl5F4rrLg7OXNmCguuRZmXx/HvVz+E8c7K+0=;
 b=IPapmWzWaDqQYE1wEXnr/4M8SIcT8EFJndO1shNGIakbLdk9XsOmpKjPGl/s57Rc95lx0tqAghPjfbbHzym2xgeBYk/F6TmiaXLStfPf7TqiMshDpIDaCEz+Ur4yRZikv7pMBJtB+UENfkgHMslfWmVkadPqrGU/Gl/1dn7U8Ow=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 13:00:21 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::5c) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 19 Jan 2023 13:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Thu, 19 Jan 2023 13:00:21 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 07:00:18 -0600
Message-ID: <f45ec1b8-fc0c-273e-3457-cb793f3568bc@amd.com>
Date:   Thu, 19 Jan 2023 14:00:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ARM: zynq: Comment interrupt names IRQs for pl330
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <8e5a921c16efe09030fda036340186c11dd990bf.1672908030.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <8e5a921c16efe09030fda036340186c11dd990bf.1672908030.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|CH0PR12MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 729e437b-60d1-43f0-98ca-08dafa1d1f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rHqsRo4LzGHG6qZhIJQ+cKH2+1Lca9vkhHMGjiSuEuj/ZEYugbCjT0nUit/v1fXwix5LuF6aQtZyHQyn0lXH4DlP7ce6OJ879uC9fcdSsqgiM3eVi4jKXwJtfP3sKE2y/wax6BNTVVPqGRauUTmZ7oPNqsU7hKEV9bLev3fcJtvb9whn79fU+C8xstHUxUUn+3plqiJ4wHJNkrOXobFJ9SitYXlCr9XLEVrBji0it1NXfYzya+qrz1ZOAzDpxCykvsMt4/wi9OY4aruNGGT9/phkFK/w6uX3QpjE5xkjH+HqW0uZIUZWaWvgbX5TRTRJS9F/hIsBNA0gK6crInVzkZS01yw+I5ELjgCjNIyChYKX70DlkGe1YKZ9cbbh/XOnr1twsc4PgDadhxKFwnXFlebPWSKg3Pl/wXMTCdQjzeW1C7zkrVZXCXVjNlJJwHof57MtYmze0GQ+7zQ+ZZP5OS3MKfmcZnNM6uwlM3DqnovC0zBItnYdNHY2yLpo54aQRJl211do4VnyDvGq5JRzkNwhvW9toy7muO7pDao/uKtcWiftIHu5i5cQuHfCWm5dMawf/aV79TRpxoFgUhK9GrJ0zGHVFg9133OVstDV1cdjTm7LRebeVVs27A9eKKtAXs8gDJefXAWSpTWRLO/W0h/8z7nk/L6k6wXkg7lRux60IbM6T6px2whj47lCN0+dkuO/1hFYVwCtNfPW4VsVjwRNrmbHQ6UPmNimflNUdyVx+wHqMbhZj7ueMGS9PN/MYUEEe6i2Lp8dpOQPECBiifFBkEyPZNbHfH2+w/B+aE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(86362001)(53546011)(31696002)(6666004)(478600001)(36756003)(16576012)(8936002)(5660300002)(316002)(82740400003)(4744005)(40480700001)(70586007)(4326008)(8676002)(70206006)(41300700001)(36860700001)(186003)(356005)(26005)(16526019)(2616005)(82310400005)(2906002)(83380400001)(44832011)(81166007)(54906003)(426003)(47076005)(110136005)(336012)(31686004)(43740500002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 13:00:21.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729e437b-60d1-43f0-98ca-08dafa1d1f3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5283
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 09:40, Michal Simek wrote:
> pl330 DT yaml description doesn't define interrupt-names property that's
> why comment it but keep it as comment.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/boot/dts/zynq-7000.dtsi | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 25fbca70ac1f..c5bb6ddd5370 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -347,8 +347,10 @@ dmac_s: dmac@f8003000 {
>   			compatible = "arm,pl330", "arm,primecell";
>   			reg = <0xf8003000 0x1000>;
>   			interrupt-parent = <&intc>;
> -			interrupt-names = "abort", "dma0", "dma1", "dma2", "dma3",
> -				"dma4", "dma5", "dma6", "dma7";
> +			/*
> +			 * interrupt-names = "abort", "dma0", "dma1", "dma2", "dma3",
> +			 * "dma4", "dma5", "dma6", "dma7";
> +			 */
>   			interrupts = <0 13 4>,
>   			             <0 14 4>, <0 15 4>,
>   			             <0 16 4>, <0 17 4>,

Applied.
M
