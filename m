Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58D4678017
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjAWPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjAWPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:40:31 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0520047;
        Mon, 23 Jan 2023 07:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMu4decx/MA9rlgArBdAUAn5dJsCsMVAx+S2/zZX+Ap0G41Sk5p+/n7pRuygYsH7CWemyUzd1/AouKXSWaNW5YzbtVoj5nct2jEsaAArgHdtnNCB6HGwewPlJxsP7z8m9S7hue9o4l7RrLd28HHBv4qk7OMUvIlf1YGRRPtqlpbkweUVgaLqB523YV+xgkbaJbg878BDfNqNI13BeyZBJP+lv9If8WYvmCihIn5RZp0dWDAp2F4zlDSzPC9k4YlAyvZ2b4DHN5EF+eyDod55bFMlayeT9DMmxMkkVb1Sdv1MMW+LX0TW2MMywrFWmrbwUf2k7hNuHR1Uuiw8HIi1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwVPy3tfDWSTyZtggwhPv4VcayJKldCUePhPLpC0I+A=;
 b=A8dyMLOVP2wET85rBYr1YP4S55qpWKayVpBzgZqyAvcVt93meEveuRNaFUrzGhDghYOJlC3dr/sWC4LWjvrpXwPfdhZ5Nm4gDZwYE4hop0nTKHH5KJTucPV+ZWqfkFfiBhfMXUrkcVWL/zBfBV27KKqLGm1p6rF6rvYFaVafuQH0G1qjpY84FoLWdV5dKmhol/H+zHL1t2wtoYRgupu2LfkL2aLqrJCaZgH9dlkV9IZDYIA3SJ+Mvlarj7D+jIFHDeL0h4BkeKvYDt52xzuftedgYikrsKhe0vLWNBf67zZNISRDrL5wpmhraPzK88KiOdrVlLiNUTuGtqJYlbccgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwVPy3tfDWSTyZtggwhPv4VcayJKldCUePhPLpC0I+A=;
 b=cBIyb+u3ho7TKfVfwQ5O6FY7g60W7RD4V/f031mACXDPFfdSw2vBvtOux9mpfvMXL2fTIHK3OKWLGiL1nhMacXXR66OGtONHLod2IoDZNNYx4ujGK/HDI8draNDYggBe2bLEwQ+MIl8mT8T0Xl1ZysIStp7E5jAxEwxTvITaAtE=
Received: from MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42) by
 IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Mon, 23 Jan 2023 15:40:26 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:10c:cafe::7e) by MN2PR01CA0029.outlook.office365.com
 (2603:10b6:208:10c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Mon, 23 Jan 2023 15:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Mon, 23 Jan 2023 15:40:26 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 09:40:16 -0600
Message-ID: <108eb19b-7e20-4a1d-17db-10370f088a08@amd.com>
Date:   Mon, 23 Jan 2023 16:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/13] dt-bindings: serial: correct ref to serial.yaml
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
 <20230123151302.368277-4-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230123151302.368277-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdd5619-1978-4fd1-6f61-08dafd582621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9RLUVTKYnrMwsQx5MD7AUOdRy7r3D+deq/Oc6puUglYNio+V1517z5NdGcTK7O8ycB4AjzgVU8i1F5BhYU74vPJinCvifg4nIvQ4xDGCEOdD8tp6HFLBaF+530itw/WF8YsGKQAqoHD0rqeZ1pWvvdB2KKsEbVarQiHtBiS38mLZmZzgNGIPnZX5zSXV2CyHq2FQs2d1P+ZD0OqxY+ngbghOOahtRdxqN3YUAkSzoBbIXmAA461wZe96VXEdb54mJe5IdZyXYX/iT594fiBpR+0Ft4zhlMX8JhL3Uq4HyMVTBHnJ29b5yiY8aOxz07WR74G5kJFGI5idbDRXKkTX2vef98N1wk+tk8zEavLNCXFrXwnXhXy5EsrEwfFJOTzN1/MkFDRBY1Mz92QJdxYEabcet5n+JdJXr5oUjdK4P4nzUFDEg0F8aVFTkVPADz3MVO/3Dnh9ioDnkd0H1H5RdOZ26/8BP19ZYL2jpe3gAvSroBvKl/PUU9LLZyvqGuBBJzUz3HgY6HaccM755H5n6aL9BMUuj7WEU+O978hb0sEsuxdcDBF9hafP5turmXBgviCjV07pShdj232+IscKvKtVHm4LpQ9P85xB4f5KT6WJ4AMsqbnULmZ6KJZSiaVVt0fgASq6d+HWdf6GFvMdgbs3M/5D6qA5tyZ7IUoqaz3T5R9NZLGEOXPVYLW7BBt+E0aJy+k/pgece2VeITnO+7JbfWtyjZ3ryA6zyVSoxLbF3XkImzvAiZCLvI8N517ySijGkPf08ikPzqgaxEjP/lm60KNEAxrMqfxYsKM3xraJ4mfQCKT4Lwe3te533nrVua0BZ1V+kMHQNxlmyPhhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(316002)(16576012)(86362001)(70206006)(70586007)(8676002)(36756003)(110136005)(186003)(26005)(16526019)(40480700001)(53546011)(83380400001)(356005)(921005)(478600001)(2616005)(81166007)(336012)(31686004)(7416002)(7406005)(5660300002)(40460700003)(44832011)(47076005)(8936002)(41300700001)(426003)(82740400003)(2906002)(31696002)(82310400005)(36900700001)(43740500002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 15:40:26.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdd5619-1978-4fd1-6f61-08dafd582621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> The serial bindings should reference the local (in kernel) serial.yaml,
> not the /schemas/serial.yaml.  The latter comes from dtschema package
> and is a small subset of serial bindings.
> 
> Usage of the local serial.yaml allows typical properties and children:
> 
>    xilinx/avnet-ultra96-rev1.dtb: serial@ff000000: Unevaluated properties are not allowed ('bluetooth' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/serial/cdns,uart.yaml         | 2 +-
>   Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index 876b8cf1cafb..0c118d5336cc 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Michal Simek <michal.simek@xilinx.com>
> 
>   allOf:
> -  - $ref: /schemas/serial.yaml#
> +  - $ref: serial.yaml#
> 
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> index 2f4390e8d4e8..6f65e9a81c29 100644
> --- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> +++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> @@ -63,7 +63,7 @@ required:
>     - xlnx,use-parity
> 
>   allOf:
> -  - $ref: /schemas/serial.yaml#
> +  - $ref: serial.yaml#
>     - if:
>         properties:
>           xlnx,use-parity:
> --
> 2.34.1
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
