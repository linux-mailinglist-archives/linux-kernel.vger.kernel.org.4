Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA44F678014
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjAWPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjAWPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:40:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33523CA12;
        Mon, 23 Jan 2023 07:40:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlrUtUDruVMa+c6o8hwS5EByM1TE+9asbbahCJ23YgRWSpGL/YdjYffDHozvoeXhUSPfcApXcD5lxtetBgqnTUWZZAggv6ScQEFAH/vi6ydGTx+0EkX5E9plTKJHtFvy+9hYsItLB7AZHTMwAbjVvSiziC/uLyibcjXJzBGdFdLwtrDahrs/oBWtkg0TCOtzCVGa3rqcslbMHw+JnOH79vzuQwCVmtq+dUfJzye60w/Ws5er/ppQNOTYWm7ulQBartAYYJdgrbgoaDdq0amZgmJLHXZAAhAnuagufwOY3DbeUCVFKmnaOX3DETn1jT3ZIH0n7O7IUG7Tj14x1zR+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUNe64xNpB4cYgaY3MqqeEcRelyg9kF+dCZEJ7hRJ5A=;
 b=HXlm0Jewh4Ixjq9ZSYpUnGpbYi7BAk51BYITCt0W40J0Y4bpkeihy0TbrIxIQidHvLHf5ae65mNVXfx+own7DffRDStewF0IYzS3R5opUtJrXS/V7WTsuU8Zovcgq6585FNZEN1187Oiz47rMjLu9ApHq3kjNWgmmr+Kspwa7PhLoAr0lKUnOIzTxd53XMqv3YofmbKcroWKqXXS+BlPvy27SqAIppxotRNRP4Q3Ff8McunteLHpspLslRQ5PRWljnOR5ogBKiLhosq+2p4Ba3oqa7BdLM+umwW/8CWxG7Ti11+dRW3wzNO/ZoeeiTyrDog+YKGT296hcGZ0GB7oOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUNe64xNpB4cYgaY3MqqeEcRelyg9kF+dCZEJ7hRJ5A=;
 b=nd0tdyyQDq78G9dcjE++g+BdJzqqkoJko+5JIQswxt+UB51sS9O5BPkVXOgamMw2x7hKi5XlGYYGZPTsSN5o0GFTSuTPYIE94Iq5H3aqyUsFQIxhzaEP8Sm1luYdSY/iVxQTf4DTndr7Mry43eO7P1kY3reA3mLNmTEsL0AaFkg=
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 15:40:03 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::57) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Mon, 23 Jan 2023 15:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.13 via Frontend Transport; Mon, 23 Jan 2023 15:40:03 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 09:39:53 -0600
Message-ID: <26046a72-27e6-213f-6b69-5cb82367dcf9@amd.com>
Date:   Mon, 23 Jan 2023 16:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 05/13] dt-bindings: serial: cdsn,uart: add power-domains
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
 <20230123151302.368277-5-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230123151302.368277-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1cc4e6-6526-47d3-6a0f-08dafd58185f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkJXSlrBL4JdptHeal1btJHgn9MxkrTfrsdBEFvbeg+/rEdIghy3eizRPGLM2GbmpwEAzhJjm23A50M586MU3S0EaZlL0wdn1wXtNHgtopq9LgCNvAuxWiGnXelxXI3FklJIxPtrfjXRRWk4WSRuypgZEnVZGltRidTk4XxwN8l0ECwoh6CfHqjGeoHPaxc+OSH0Yc/6xuzB3VpBKkktF7leaAdra7UXwnDIxGBPEj/AUW4IhoZ4CNhYnMspJ+Ss/WDGjLxKQWI1EPbv17rTGR+l4Ru1MSeXVDLbw6J3OcqhJiejJfwUSObiWbw3NQ47LDYvvcJLgxMTkM0jlDUo1Dty1ci8/mKc/HkIWHAtgfEVCQFVETTaA9+IiiaKEopyssmJWROxWbw2aYUurkK/JhF8JpLQCZ418esygJeQJqtJmPUGSI0E6iFHqM5sN51r3iadXeXLGIz93fvJHI4G1hsLXc89R5Tzy3QRCG6R1yLXh18hy/DSVKrEe058EJNBxcQQ39S9xUdT+xZEL9tbnPD35DXx4AOi84h1mEK1S/5gymHs7MBQ9wAdD3Vx156u0jS6n1RKMwmlW02ENf7JrDj7pPiYxcZ6INwY9A1jkXvpnwGkVYV+YmJMD1kFoV9XWjB+yCXCihux8vVSfg2kEEdYPRRveSvw4Qaar8fAZ/Ov8Flr5B3ejRiyhTqLWTIcMq5/i2yvnIK0jIxmuokv+HOmNSJ85Ae5RUdAmS1CRxZ9bcmE7Wzco6H7A8ooht1d98IMAUOgvfr3aKncA06EDImmK4yiY3CUbwXMhYfXQ4AryMdLE2LHljnNgJp7dxJQN/1yv50ZIuXD62HbVRcVhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(921005)(82740400003)(7416002)(41300700001)(31696002)(86362001)(356005)(81166007)(44832011)(2906002)(8936002)(5660300002)(7406005)(82310400005)(40460700003)(40480700001)(26005)(8676002)(16526019)(53546011)(186003)(47076005)(426003)(336012)(316002)(70586007)(16576012)(70206006)(2616005)(478600001)(110136005)(31686004)(36756003)(43740500002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 15:40:03.3577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1cc4e6-6526-47d3-6a0f-08dafd58185f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/23 16:12, Krzysztof Kozlowski wrote:
> 
> Few Xilinx DTS have power domains in serial node:
> 
>    zynqmp-zc1232-revA.dtb: serial@ff000000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/serial/cdns,uart.yaml   | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index 0c118d5336cc..38925b79cb38 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -9,9 +9,6 @@ title: Cadence UART Controller
>   maintainers:
>     - Michal Simek <michal.simek@xilinx.com>
> 
> -allOf:
> -  - $ref: serial.yaml#
> -
>   properties:
>     compatible:
>       oneOf:
> @@ -46,6 +43,9 @@ properties:
>         port does not use this pin.
>       type: boolean
> 
> +  power-domains:
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg
> @@ -53,6 +53,17 @@ required:
>     - clocks
>     - clock-names
> 
> +allOf:
> +  - $ref: serial.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: cdns,uart-r1p8
> +    then:
> +      properties:
> +        power-domains: false
> +
>   unevaluatedProperties: false
> 
>   examples:
> --
> 2.34.1
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

btw: I was running it and I have seen that properties are checked only on nodes 
which have status property okay. On disabled nodes properties are not checked. 
Is this standard behavior/setting?

Thanks,
Michal
