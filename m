Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07965E73B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjAEJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjAEJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:02:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7062B5014F;
        Thu,  5 Jan 2023 01:02:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxyxMzbH97al9KsSUiMZim3U07xHbLl1oy2sgu2bCQcIoIuiOqNvrjOJ/fsvUwpwyNReivOeLBfiJTvrpmjKGledzHck5+YpkEc8fytFUNPZCspvxa+Bh8xfnMqbKoALMhTumzf7I4z7m+zqOwiTJMbbl6cfDgLLoy7UPR6doaQl6PnbzUiKEdpgeyXYxOFZJ0HJo5m5BOxjoWvJFSTzx0EKVzSOQZSDi3S3YKHJ8mb2kN0aud1zmbZ/6Bm1Fcfyu589Us5+brzzW25zGZLKrsaPC975kZgR8MgLwoRewKgoTLMOas/+QW4BtiE2J0fae9wbn4khXX/m9IBMPWuu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kZBRuH0jhmBydENfCYSi5krR/0htCPEB5JChd0YsUQ=;
 b=GdBlkprhVuulKdkbmquFbZqR+0FJ6NtZwsSIohiKZ5MU6kEmDihErwcPOeuWQ4Ncme/5rbD9Y9tf24isWLZAHrL2hOc4Of1tXw8ZU2Kewq5KKjIfoaHiwAyUIAMaTHBu2XINr65ZpKNoKWZrsacWagtAIuet1Hm08P3PNd+gS86F7CVyBYFe87z+uDCzuFKz/S9Rn6Drw2POT/RMzvEq3jcvvN02ikvxkruHC2GpN5HTV8fc04vzQ1Q2ThPsNDd4cXYVWNicDoyKOFJYPkPXpn1t/LvQGofm15a7BiWiYLrzWLkJK8dIreycn39bCTSoEisVqKNU8oCc9QS12JSHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kZBRuH0jhmBydENfCYSi5krR/0htCPEB5JChd0YsUQ=;
 b=bm6NnrhFK6sFmgtlJyvlQ7sZD0ZVLdv+S/wXFwCUBJ8rMDpZe97FfNdNGshptFGfr6qc9pyuAyy4XoInwQYCMGq7CtRIy3yxJQHufwF+nYotrkP8+VU/gm6/PH1LpoQ5GO0/toFhN22X99iWvh9vXca+XJV4oH87ATkiEECDCW4=
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 09:02:16 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::27) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 5 Jan 2023 09:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Thu, 5 Jan 2023 09:02:15 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 03:02:12 -0600
Message-ID: <2d49b993-377c-216b-c147-212ae355ae7f@amd.com>
Date:   Thu, 5 Jan 2023 10:02:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ARM: dts: zynq: Add xlnx prefix to GEM compatible string
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <5452508cf2bb4213e9cff9b957d663c30633e81b.1670593872.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <5452508cf2bb4213e9cff9b957d663c30633e81b.1670593872.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 67273f60-d57f-4795-8974-08daeefb8ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pi2r1mO3Shg3ujOLG5rBhNbPpeCYP7zkpVrOvavuiGaLnhfSHVcpd5gi0CiVlAq1AxXD1vj6Nvq+ERFcdslGtvWQ9BzA2SlBpt4cAnkc0OaGXv5wNSDmyKa1zUDxd2fG0E/S6hR7bOuVlJciLOfNsxQ3LS+nwmAoU7s7nqgjwHgKa1zVIwsLaU15rL31LvcLxQ591G0tg9TawoesB5zoDROdHTBqJtC4HeegZvv0LgXZutp4rFbNoYpf+g8EfAfHIvXyz/CojiaZVKZ4bRxQEKS9qUUwCbVe+pQ5dAOBW55ej0F0RVeCFiEflvHffKGb2YroudUtbf9puTYpnEeZgEf1eOJv6nShIMCsegBV/WFDPtHOdQcN3jl860fsuQ/U7/wfQX6kj/f0B4uraWU0ZSlDVQybc6HCGmPggXYnNZ0jHnkXoyY50Mee+q36ZnYFonRc7gUdLVHOvuh+vSzXRc267JeSY7ViuxemYSxy2B0baqnHuigxBgMscI/2T/R2G6So+MEp95QzPnj/xfkTSoIimr+CjL5mXD1uVmV6ncVsqwP7Lw9zasDtKbP6ttjnx+tUIaFcNKYCH6SM2PLIdhyN2GhMx4afrzjEjJu0GscvIGttDWk16Ss8V1D+DtTgaalUW1MNOjPPO+0+NmhXM9swcaQfyC0WAhakyk7F8uGOx5fpZtQdaM1GDmg/7x5rmEAKBHCDmG8u2f0oKMFkXVJHk0nBMkaJzfSApv9+c8Wl7JoUSW9ABsqbgldav4yUQhHlWP3oPtiltbkZ9jWf7pL5YfD9xlqsGnt8eK1+SdaOR/1rBM6aApnPFX2EBmdX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(36860700001)(426003)(336012)(83380400001)(47076005)(31696002)(40480700001)(86362001)(40460700003)(82310400005)(81166007)(82740400003)(356005)(36756003)(44832011)(2906002)(54906003)(110136005)(16576012)(41300700001)(5660300002)(4326008)(8676002)(70586007)(8936002)(316002)(186003)(26005)(53546011)(478600001)(966005)(16526019)(70206006)(31686004)(6666004)(43740500002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 09:02:15.7187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67273f60-d57f-4795-8974-08daeefb8ac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 14:51, Michal Simek wrote:
> From: Harini Katakam <harini.katakam@amd.com>
> 
> cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
> favour of xlnx prefix. Add this new compatible string and retain
> the existing string for compatibility with uboot drivers.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index f96f19a8a83f..25fbca70ac1f 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -243,7 +243,7 @@ qspi: spi@e000d000 {
>   		};
>   
>   		gem0: ethernet@e000b000 {
> -			compatible = "cdns,zynq-gem", "cdns,gem";
> +			compatible = "xlnx,zynq-gem", "cdns,zynq-gem", "cdns,gem";
>   			reg = <0xe000b000 0x1000>;
>   			status = "disabled";
>   			interrupts = <0 22 4>;
> @@ -254,7 +254,7 @@ gem0: ethernet@e000b000 {
>   		};
>   
>   		gem1: ethernet@e000c000 {
> -			compatible = "cdns,zynq-gem", "cdns,gem";
> +			compatible = "xlnx,zynq-gem", "cdns,zynq-gem", "cdns,gem";
>   			reg = <0xe000c000 0x1000>;
>   			status = "disabled";
>   			interrupts = <0 45 4>;

Based on discussion 
https://lore.kernel.org/r/718283a9f5493ab63b4aaa12337dd5cab6538ff5.1670594172.git.michal.simek@amd.com

will send v2 with removing deprecated compatible string.

Thanks,
Michal
