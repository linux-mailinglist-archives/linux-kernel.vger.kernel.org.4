Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1265E71B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAEIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAEIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:52:50 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C7E0F8;
        Thu,  5 Jan 2023 00:52:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ierp7rZLmWFmgbRA8SMyCKYGrvO0+IOYskkU11BgeCJNSc3QoL2zJJctINcA+UhUUp7HiTlm3dpYCdPvUd/JBJwMXRnki1MHWU/H6h3AXmBiVhKGWgOEo9oogPMHcYGgwrypetQIzujje+uZS2FB4vuh7Tf9DgB/eiBBGQPrU3U5Po2AtAKnmOhcDswHs0KY+vnNRZxis6+av6mZ/baq5wPYWKaTU98J4baZxz6bjcO8ISv+gMPGXXJ2vn809lVvrghX9/xjo/khV0huJ38gs+3QbI4Srb53IcwBPJChRBhDxlxIsUnPmvq50fOU4BiLzEeKR7owM2FP9ay0Y6O4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBO/u8f4XZ0zrr4cEfnAeXQI5cqvIux/haJeG6HQvi0=;
 b=G0mHF+a+x5I1am20uvPBIeXExnnMx8Jk7pX0u7IvOGopHdugib297fb9uK7Rx3sspli2hyYVgsZKKq88sd0BxL2hBqpt8LnFRm9He2xY8xgSXnEKnq5BOjvDAu1iVGU0mZ6UPWgIYCqD19ESvvQKVQAeQLAQ7ykNis8eT5zrIckkl/XP9fGu61reBKhgWQUU5S2K9HWkLTxqmZCemGcgJ3JJQtiKvV9pn9pucu51zLOg+G07hcL+RMHc7A62ta/v+NTrFdPWWtAbaghyZ+Gv5LsrjJY5m0l4l+U5hSVtsJaRkhihhL/iFTXvdma428BWam7sBeHbuHcJHpinaNV/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBO/u8f4XZ0zrr4cEfnAeXQI5cqvIux/haJeG6HQvi0=;
 b=sdz5cZ+GUklvV1UKEyOuRYXIslZBMBHhsi7Q7hloKHq8K8p3ajl921DmX81fvxtD8QoefpsafOwkhqfoTz78xyD0z2y4Vo+GXokYjjQJtNuLLgj9Mwo2gSuorsErxh0q61yiidFt5Pag6e6EcSGJ7KPlpyq7gzKVUPUJLTkJdvY=
Received: from BN8PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:70::26)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 08:52:46 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::f4) by BN8PR04CA0013.outlook.office365.com
 (2603:10b6:408:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 08:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 5 Jan 2023 08:52:45 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 02:52:40 -0600
Message-ID: <cdd7e3ca-0837-c3c1-e5f8-751909d687a3@amd.com>
Date:   Thu, 5 Jan 2023 09:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: zynqmp: Remove clock-names from GEM in
 zynqmp-clk-ccf.dtsi
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     David Heidelberg <david@ixit.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <24ce27f91a55ed04ca7ee2ff7db0c674702ef722.1670594284.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <24ce27f91a55ed04ca7ee2ff7db0c674702ef722.1670594284.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b828d2-59d6-45d4-cd89-08daeefa371a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtRleed+YVM/o8KMK0qxSRPllFkbvZyKvOubI+CF4+kYNd9DILm0vV+fLqvxwmX6/xk3PONdENAaIvVxeybBiT3Z7gHKqiL930+JwM/AGKKRY7gFhhSXe/L3zEZDKic9wEehBXvArRP6GlR/BHtUxNB5+4A/MoRuYZhUjEgShRKDsv2A9rgOszoccas4snvflz90j9S7CAL8btlfHPj0UkXmFralkXk1683BHDDuhb1T9ORTnCfdDFU2urwURKEtHfU2iReUwtAV/m4+3j2CbU8UbkKg4rdf/Das20Bicw/7M2+yKgvtLxYsslY/uG6wZZWs7stNn57+UVURKHc3KOIoYUROnd2E6x+78y0qd6T7YNMM+pxdaNmXTILQOZFt0jbHZ+vDVhtbDKpHUeTO9peg8Q4X+H0alcTAcvPZknVV91qPCht1GoNJK9nWvUgPMxLS4w5UyodWQI1fVlDPN6TW89uzKaezB7Ux4xrtvastDEBBfaY7dr3TwzFzAojiSFdRbxReXFYfzTO1DSTE5XVmgDDPz2U4YDgdV2pg9MIB6xVsgRSzbscRi70WwlanZVqypHhEv3h7xTRH/dXN3X/QcuAjtGtpPTJhh0TZYFxh8/q25L+5MpdbTanYPtsz5sUyBnHGFPXcqU6scSzsIYa60EHBE4FsZF9QiU/tolgYe/L9E0ttjCbJU5jlPdxJ8pHm3WIpuyR4cr8RrYRWVQ0HNtU6qhGaeKcJ80qhlikLHbWpUC+pq53vu3MP1hfOtraXOW41qvZOYIbWkzhEQDFrmA/vaol0rTdL5vXcAoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(36860700001)(426003)(336012)(83380400001)(47076005)(31696002)(40480700001)(86362001)(40460700003)(82310400005)(81166007)(82740400003)(356005)(36756003)(44832011)(2906002)(54906003)(110136005)(16576012)(41300700001)(7416002)(5660300002)(4326008)(8676002)(70586007)(8936002)(316002)(186003)(26005)(53546011)(478600001)(16526019)(70206006)(31686004)(43740500002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 08:52:45.9615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b828d2-59d6-45d4-cd89-08daeefa371a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 14:58, Michal Simek wrote:
> Remove clock-names from GEM nodes from clk-ccf because they should be only
> present in zynqmp.dtsi. And as is visible both clock-names defined didn't
> really match.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 4 ----
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 8 ++++----
>   2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index e172fa05c9a0..3e9979ab60bb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -135,28 +135,24 @@ &gem0 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>   		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> -	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   };
>   
>   &gem1 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>   		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> -	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   };
>   
>   &gem2 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>   		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> -	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   };
>   
>   &gem3 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>   		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> -	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   };
>   
>   &gpio {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 233127d94204..518a3d98b4b9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -512,7 +512,7 @@ gem0: ethernet@ff0b0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 57 4>, <0 57 4>;
>   			reg = <0x0 0xff0b0000 0x0 0x1000>;
> -			clock-names = "pclk", "hclk", "tx_clk";
> +			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			iommus = <&smmu 0x874>;
> @@ -527,7 +527,7 @@ gem1: ethernet@ff0c0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 59 4>, <0 59 4>;
>   			reg = <0x0 0xff0c0000 0x0 0x1000>;
> -			clock-names = "pclk", "hclk", "tx_clk";
> +			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			iommus = <&smmu 0x875>;
> @@ -542,7 +542,7 @@ gem2: ethernet@ff0d0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 61 4>, <0 61 4>;
>   			reg = <0x0 0xff0d0000 0x0 0x1000>;
> -			clock-names = "pclk", "hclk", "tx_clk";
> +			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			iommus = <&smmu 0x876>;
> @@ -557,7 +557,7 @@ gem3: ethernet@ff0e0000 {
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 63 4>, <0 63 4>;
>   			reg = <0x0 0xff0e0000 0x0 0x1000>;
> -			clock-names = "pclk", "hclk", "tx_clk";
> +			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			iommus = <&smmu 0x877>;

Applied.
M
