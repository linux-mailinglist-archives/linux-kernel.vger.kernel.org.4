Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680FA638605
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiKYJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKYJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:23:27 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357F21E3E;
        Fri, 25 Nov 2022 01:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbodE+IyduvqISaDTdzW5kaufECepevCynawr1/AV+s8JOpk5MsyFMeANpvsYr8yhFSfe848aji174W8O5YVCy4M2wUOhX3bvzo50gzLL26O+wVmgFi0WCITj6cFLknjqIqi9QgUwWaaLUeZN2WeSYdtgj5XvsAqy/byhEErxs7kILczOpJCD3CoJ468Cmp7z6LiGvW0Stq2pCkFcVPr/z5zyxs5WnQRKfQ69V22AizbRWvLMZG0Cl4rC3aMmn2vCdKuvtm3zsBtq6ljXwF4ylWZuFgOfEuYOe53Qjc6YgAEOm9qfswZl8pbrxVcTsbMAh7dvxbmpbKeXL2lcVXHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNY5CV7v2iViqJvrFDinOpdP6cWWHLstHosZbwm2PsA=;
 b=fNWISL/g1G785FVnHWLt1d0mWPRhWWG1kr4wbTXtx/AdiNyYw1VBtrg69uZfuC/MJxWYtp1VGHWd6Tq3AEoANXMfPiXCTtmcFrnPmcU/1AHLv2xVEuQ8l3j3eeER1ethNCIiR1Av0yn8PicZFYgF2+m2jZ/SrQG6ucoQtJ+5n9fFeIYEgZ3m2unckFTyFIUFIrbMF+s9YA8N9UamoPG0digla6gu8fwUMTcCH0JJ9cT5tRcwXEapR4D7Ibw20LUDmHscjD0HMMBMyj/5YTKJ+GOpArbP/tj95XWEvb8vzVYqAJWoZcH47nq0AcDtMpckFULpu/yGN7XbECFrGQLNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNY5CV7v2iViqJvrFDinOpdP6cWWHLstHosZbwm2PsA=;
 b=1qzQ31eeEG0rKvNMa9W1Xy8zd+aY558xbIK5dk/z+f/FxA5jL1jwXiY68gwi/QBrQ/uGXQMfQJbKptwWCkv0FO0Vcl86FDrg9ZQqaMQoIlRoWhANUlIJzB011ra/xOkVcPrbEfQreMMZJcb6SCE/TpBaPEjeYQU33ZIZCkpaqBk=
Received: from DM6PR14CA0037.namprd14.prod.outlook.com (2603:10b6:5:18f::14)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 09:23:24 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::f6) by DM6PR14CA0037.outlook.office365.com
 (2603:10b6:5:18f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 09:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Fri, 25 Nov 2022 09:23:24 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 25 Nov
 2022 03:23:20 -0600
Message-ID: <90fbb273-510b-279f-1582-8336136c5a0c@amd.com>
Date:   Fri, 25 Nov 2022 10:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
 <20221114233940.2096237-3-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v11 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem
 device node
In-Reply-To: <20221114233940.2096237-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: d50a5f52-c285-4bd2-de70-08dacec6b3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbWYXCeLELB3zZDZuMxChjAs80Lfo4/y2/WvULVi/cc9C3rBDubVyVdoweuypeI4e1vibGvkNFAvdWYoqI7t3AygCe5J155WvCufLN9a3Qz5D/eGdtb1TK0y7jDnTpA7nAamSCGAn02TQJUspMTF+4uAnPaviSellj+pWICQ8UT8tI5j0P5L4sbxHiY47o8lf+Btphlt6wUNpGeoqajlQO1zyIBVVEpTSugplXw3sP4k6p66E7fkiwB6HcGN7bdxRFDou2sI1hT0wwMKcMJcXnxmspcEhtdWK7bBiLkTPkHfqP8RBx0TxNFqgoA0D5EDrkYTN2q9Br24E+98vZpNJ1Buus5UQDCtjDWVGtXhEnZ2ybhwUI37c3q6E2uKyvX6knXMBprMRNWvI2kB6ZIUIqnSqzLJKmuM3t2iGMk6UII7N8PQ2LNqW9dFmvxuOHe/slmOFNJ3eQ1RKtFiRwnGtS4X1X+xzXFLZBPQlnwYcrQwarmDdLs5yZCYK6MBnoK2vmlxxct0My3YH7BFoAbYo/vOGSdjleFUeKrj4iK+z3qsl7+bt6HzEOvgjge83CXWYuUtHgV4vqn06W9DNnDwGeijjuL3SwWGfjYHkcudcKUQNpkYgu+EoOBGO+j+3Bho+IZrRN4S1iM1n7/ikC+JrNXAgsXAAupetkk9TKtLrXl7WJWltk+274b16Vt8HRdMzWgSzQnL6OXf72jG0MDaIzKCj1IW2tp6baJQkfH1VIMdUGLunWtpRiOb7zdYtFGxataJRkjMmgaebWIbLki7kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(36756003)(316002)(40480700001)(186003)(2616005)(86362001)(110136005)(16526019)(336012)(36860700001)(16576012)(83380400001)(41300700001)(8936002)(82740400003)(31696002)(44832011)(70586007)(2906002)(81166007)(40460700003)(70206006)(8676002)(4326008)(54906003)(82310400005)(5660300002)(356005)(426003)(478600001)(31686004)(53546011)(6666004)(26005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 09:23:24.3777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50a5f52-c285-4bd2-de70-08dacec6b3f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 00:39, Tanmay Shah wrote:
> RPU subsystem can be configured in cluster-mode or split mode.
> Also each r5 core has separate power domains.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v11:
>    - None
> 
> Changes in v10:
>    - Rename node name to remoteproc
> 
> Changes in v9:
>    - remove unused labels
> 
> Changes in v8:
>    - None
> 
> Changes in v7:
>    - None
> 
> Changes in v6:
>    - None
> 
> Changes in v5:
>    - Remove optional reg property from r5fss node
>    - Move r5fss node out of axi node
> 
> Changes in v4:
>    - Add reserved memory region node and use it in RPU subsystem node
> 
> Changes in v3:
>    - Fix checkpatch.pl style warning
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 33 ++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index a549265e55f6..c0f60833c0ae 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -100,6 +100,22 @@ opp03 {
>   		};
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		rproc_0_fw_image: memory@3ed00000 {
> +			no-map;
> +			reg = <0x0 0x3ed00000 0x0 0x40000>;
> +		};
> +
> +		rproc_1_fw_image: memory@3ef00000 {
> +			no-map;
> +			reg = <0x0 0x3ef00000 0x0 0x40000>;
> +		};
> +	};
> +
>   	zynqmp_ipi: zynqmp_ipi {
>   		compatible = "xlnx,zynqmp-ipi-mailbox";
>   		interrupt-parent = <&gic>;
> @@ -203,6 +219,23 @@ fpga_full: fpga-full {
>   		ranges;
>   	};
>   
> +	remoteproc {
> +		compatible = "xlnx,zynqmp-r5fss";
> +		xlnx,cluster-mode = <1>;
> +
> +		r5f-0 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>;
> +			memory-region = <&rproc_0_fw_image>;
> +		};
> +
> +		r5f-1 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>;
> +			memory-region = <&rproc_1_fw_image>;
> +		};
> +	};
> +
>   	amba: axi {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;

Matthieu: If you want to take this via your tree here is mine.

Acked-by: Michal Simek <michal.simek@amd.com>

In another case I will queue it for next release when dt binding is applied.

Thanks,
Michal
