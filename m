Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177865E719
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjAEIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjAEIvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:51:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0715F1B;
        Thu,  5 Jan 2023 00:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPMM7kvrgTLPUQ7kfxI97UYAv5M+tf634gAKNjsiYVcEQq0C2c28cMv7cY3a5G9hDovQQLMTjV4Mz47378MqAQRrg8mcM6+smCTBabULIJfpsaZOEntdkUc6Gh95U3WK7bRsF3wsGf00tCwc7C/Mj4VDdyt9sC8wm8L6ORlqBsWqXdfZDisLBlrFAseraH+Ilm7fnhHAJSgVgtMjYjKAZ/yTACMmRGKSopYAbhcF2tHqWT5d+dfHXsGfSnp1loSyFhg+1gDEmRWhfJTL/dV7AxA+9XvkuO6kbKBghVlm7CTWqIhFpymb1jNL06EqyThbsRxgVAFsAhu69gNq+IbMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JV53xKfEXdo+Tyiho6clOYpGxFn6dfcQPiZuu2uJQo=;
 b=WF91IZV0+pBQm0KPxnfSF0Jsz0S9h9Tmv5zcVrbEdM+J9khsfLXVpad/j9Bx9EDhtKzZPEGKNdnuw/jmfeqplwCrufn50DY9fhRuKqcyX3TEwSxgp3qqDZwDkyVINjoiDWq6bRJ8/oetl/PAEjTVwFvkYEGbu+PD998LhOa7VLOwd/6NqV9L9C7yvR/+PQa32MLoj3uIxOAlaBgOVOuLqJKKDjKRNyR8BlG6av1Aw3na4ISQjbq01UAy8SoL6BqclIJHl011cLMVFVTJlDH0WKI4Xw3oOe4dS4t4jSw+RTHh+d0DzdDf/YdYCwHDFRggrcEkUOOqE2adnwoJ3nfwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JV53xKfEXdo+Tyiho6clOYpGxFn6dfcQPiZuu2uJQo=;
 b=ohK0G4+l9JXcmiJaykxKb2p5SWo5GQbA7KAZ3KArzqKJX22+JIVia84WuNDprh1wV/RTo3sr2EWnBU8EAJwTf8OhyO/IuNcS41GrYDsXVpZt9148VX3fs28HVb4mb18F0vLIEE+wm7HPevHkBic1sMSZz1JItn8jfMmncA+be0A=
Received: from MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) by
 BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 08:51:50 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::5a) by MN2PR01CA0044.outlook.office365.com
 (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 08:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 5 Jan 2023 08:51:49 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 02:51:45 -0600
Message-ID: <8be5b2ed-9d0c-e628-fb34-5241c2492794@amd.com>
Date:   Thu, 5 Jan 2023 09:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: zynqmp: Add mode-pin GPIO controller DT node
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Piyush Mehta <piyush.mehta@xilinx.com>,
        David Heidelberg <david@ixit.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <69924a8e2c01e5a1d25d098adc53224ddb841f46.1670594085.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <69924a8e2c01e5a1d25d098adc53224ddb841f46.1670594085.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 003f4108-f127-4eb1-119c-08daeefa15aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiwrdbZF982NRXYYtVx/IUB4zpmW5FwB7KoVaSVal0bPn6Tc5BH6+Bj9Q586aPckN6vY8nov4eUxPzZ2RmaSKlaUyLm2/mfKce45CYi9/JskynKAJAl26Hc+BsmD97JInnbkAMOJzNEmdCpDid8zk/g4XlMmgYPpAsFSq/lLihfsFHUVpdzUFXxvVxV6dWbDVRkywypz4CtotxYZdodlQafymu6NPPAvrbsSOW8HatKC+vRiGmi5CDoUaS8UcxpYKAE9hk/l2AoFE+NONOpH1ozWHrXLpQBsigqKdroPtsbjnqtZzW3NOrmPfXl0SBwhJ6IBJ5FznLeoKyJzJFDpjGhUexMkSGObxeAtLQaN96SCgWrLquGWIITwwn5+OMcKLcz0tvB3UBceeVxczaG0VUe88su79HFdxIRAsRKGUkdyfdxgXHQmvD7gUn0n44aeHjG6VjD37NJifxedZfnDebaMQKcAFYjlUtyYIwtwHpFDadQQ82Uv2biPJxL3iCfgRmxdA0omR1rHXy4dFNcfHI68PFYKkR3F74Mq97dPqyGb/IvhP3HoMQLRJIR6MgPUZCqNQ9ZdaZrQ/FalZ2J6IqjKDhbBwJ1OfZxUAstgOfZuf4PNTBx6baZ8tx2PBNnDwq6Xe06kGt5nDVxK6ywew956UnT+nlI4uFQqHGKdlTYfo4PGnTisZQ+F7tzMQcuNriqGCwPZCFAXrN14XDYszXbALMjfOa3yn87pfx+wC+acgGQ31U0bRyEw2d5B6V4qnjcYQkuvrIYO9roSrlChGuTs9rnipxGm4WMtC+Ztn6k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(426003)(83380400001)(2616005)(26005)(16526019)(186003)(82310400005)(53546011)(40480700001)(336012)(40460700003)(86362001)(36860700001)(31696002)(36756003)(356005)(81166007)(82740400003)(41300700001)(4326008)(8676002)(7416002)(5660300002)(2906002)(8936002)(44832011)(31686004)(316002)(478600001)(110136005)(70206006)(54906003)(70586007)(16576012)(36900700001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 08:51:49.8579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003f4108-f127-4eb1-119c-08daeefa15aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 14:54, Michal Simek wrote:
> From: Piyush Mehta <piyush.mehta@xilinx.com>
> 
> Add mode-pin GPIO controller DT node in zynqmp.dtsi and wire it to usb0
> controller. All Xilinx evaluation boards are using modepin gpio for ULPI
> reset that's why wire it directly in zynqmp instead of c&p the same line to
> every board specific file.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 99273cbbc75f..8553299f12eb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -13,6 +13,7 @@
>    */
>   
>   #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
> +#include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/power/xlnx-zynqmp-power.h>
>   #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>   
> @@ -183,6 +184,12 @@ pinctrl0: pinctrl {
>   				compatible = "xlnx,zynqmp-pinctrl";
>   				status = "disabled";
>   			};
> +
> +			modepin_gpio: gpio {
> +				compatible = "xlnx,zynqmp-gpio-modepin";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +			};
>   		};
>   	};
>   
> @@ -814,6 +821,7 @@ usb0: usb@ff9d0000 {
>   				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
>   				 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
>   			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
> +			reset-gpios = <&modepin_gpio 1 GPIO_ACTIVE_LOW>;
>   			ranges;
>   
>   			dwc3_0: usb@fe200000 {

Applied.
M
