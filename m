Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79AD63AADB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiK1O2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiK1O2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:28:48 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CD71F63A;
        Mon, 28 Nov 2022 06:28:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgU8UGiy8JZyJMQk4H4yIt8SJurbmCLHdbJuxQ+CVgvl7QCj+5pKpWCv+I3G09OWDX7mRTt5Q4nnQyXvvrGo5priMKHwbGRiKZ25iEOwPi00bqupcboiXVviA54zZel0eTVUJXcmltdboWRpvNwEt5VhiAtfMIFsr9oZQHlj1/wtomV3yh3CxfJW26ILt+ca+CbXV+5scOm9QwG89/0DXqE4c5r6EJ28U/6fWBw0W0awcv5OMibUR7ySlsgs41P1Vy7fyndbzWfCmKGIR0npyettIk1NnzTBIiOjQTlyP/VRLlsZkJCtXE+RPVWW8od6kximZufCp8s5GkmQios8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Pn20lTQ+ZzAoar5TCXA0QykJjeNNhK/Q1nc7Yig7A=;
 b=aHPF+Ba7KF2XO4LltaEkj9xTl793DDXpw0P5AcTZ4BJOLBwcAMFdHxRpLhvlw4EPaRYfF12cJN9F+3EI98TujY6cFsdJ2kIPT08JyHs98cnVLcwu9OyZf34QLegzcQZX7x9ELLJE2HG+AfRdNAsvkSX0G4fa2gZo56jiPZtMPGHL5SdSxMD7T0ztVsEZD7KrcW0nMoZM3K9C8/x2ERtvP2rBRKIALb2MVIXOrOmMEbj8BeB3W1pJ8nWpDAjCLjrUwm0sAxDPEiFQknyC9+xrsHijiTTiP+A7bU4+ShJklAMvInmLuz4vrHOkQpggQrs8OKQlbwajkLHqYew03b2AKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Pn20lTQ+ZzAoar5TCXA0QykJjeNNhK/Q1nc7Yig7A=;
 b=jDekB+jN6z1fU4BMlH+cSCvn4qiZweGIuw0yiVERFDzlYrAm76fyBRV8Ez9MvF2tp31+vuCRk67F3ORBQ5k+IJBNWuryxueW54p+oBPtzMAD9Q8mGBwdHhdA3avNvJKwcGlUHCi3usJQqHq74rRMHqgTgw+xxtlD/IzsSNn1um8=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:28:45 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::30) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 14:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 28 Nov 2022 14:28:45 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 28 Nov
 2022 08:28:17 -0600
Message-ID: <9f3a9cb0-1c48-ec6e-d07a-77cedee2408e@amd.com>
Date:   Mon, 28 Nov 2022 15:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: xilinx: align LED node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221125144136.477171-1-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221125144136.477171-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: fe725277-2ae0-476c-aaec-08dad14cdb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66svY1vQAJVEPmJiIR2bqzGrGQPQMIH2e+n/qz2rnoEaNv9qybunVwVhWlrwUKomgOzcND24fqiS+SQsOBJuwU+z+2ND250LX8aXhRl8IixpDyO6G3FjRhwgyUN8TFaP8gUCrLspnvyopiVU2vddG1zIIuhdaUjAS/F4DQLsZ4tT8VfZaK6muIlhW3Ef1fYWAxGx5Y5ObctcOlvwI89tn+G4beRtaFVcR93hupH8DqjUDQlm7CxlCJJnBu6kZJQkzZ0FfY5gwCw50z6+AYCDLp7Kdg5+aAbKClPMeu13SelzOYsl/uMBj0u1u6blLYbdtbFc09QTXd3cDB5OsjvaX2xSHbiBspn31fBjuMZNU36w16WK+Y5zFPnPn8i9vsaB0oOvvtWzofAXi1KMo/r966W1U5IYuTegKlJdTU/XeMXMxL1OpsvccjGzdMUtxNQ48P9B27oBjILf/lX6k8GfPK2PDO3D+KYOvDI4GC57mWGY/fT7Eflmjsjg5U4q2ZH917yVrEbu1xgFuGZ6HEXmXaIGkvd4O1zjJk44nD7R2Z3dMw0DTWWIo5ocykAxNQLYX9kdCmJCwcHJgsqGDp9bJXfhWowMq1Hgo929jdbFv7eXyCODsqG2NtrdxZfEcZPRjlxQft6gLjBh9GR95DjX362cG3ROlBBOhabBOoSRBtm9nKzbdDDJ3PpkshgfiL/8fLzxloq8Rl4gxzRL8XmX1OEg16B1WZE/BjnQnCha3OoYqS/uxt4DnfbIhmFt2A6TWyPZ4FOU4aYRIieBu8vNbDPBihwCGsG/A2eSZzdRtwU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(426003)(81166007)(44832011)(47076005)(82740400003)(6666004)(40480700001)(336012)(36860700001)(82310400005)(8936002)(40460700003)(316002)(16576012)(186003)(16526019)(478600001)(31686004)(26005)(53546011)(356005)(70206006)(70586007)(8676002)(86362001)(31696002)(36756003)(2906002)(83380400001)(110136005)(2616005)(41300700001)(43740500002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:28:45.2257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe725277-2ae0-476c-aaec-08dad14cdb48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/22 15:41, Krzysztof Kozlowski wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> The node names should be generic and DT schema expects certain pattern:
> 
>    xilinx/zynqmp-zcu100-revC.dtb: leds: 'vbus-det' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index d61a297a2090..6948fd40554b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -86,7 +86,7 @@ led-ds5 {
>                          linux,default-trigger = "bluetooth-power";
>                  };
> 
> -               vbus-det { /* U5 USB5744 VBUS detection via MIO25 */
> +               led-vbus-det { /* U5 USB5744 VBUS detection via MIO25 */
>                          label = "vbus_det";
>                          gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
>                          default-state = "on";
> --
> 2.34.1
> 

Applied.
M
