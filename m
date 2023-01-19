Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630D667392C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjASNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjASNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:01:20 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9FA792BF;
        Thu, 19 Jan 2023 05:01:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/qYN3Wq0CUtvTgk3EhvH3vEVWr9WwxNkiUapQ6gemjpRe2VV1MXPeRcA2ixYbrTKsvErxZ7XYLxPgMIi6gNCgMv7pp1DnOJldO1iPZ+Xu9Gm1PvnPf6vfrsMUK9itYqNDHulLjiNX4K9iJ/kqLYI/2GkQNkG6nJfT7nMQub0NrBi/oQTLGNxIb9amvXoXogX9BamhTUj9TMkvsWqtCU0O+2HjP40k4Moe1kZogQQt62bbER+oNWmZ0DezRDJw/Wl5SEXn51d1zwPGess8Rwiod8y1LRDeQhVvQpWdenkXEg2eGAeJodltEeOS+RPNTfMXF5ybXG0ABLKvTgEe358w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i76HrzGz6HNiRqJSxWsq9FQ6mSvhq5PmxYvx/HcYyrs=;
 b=fb2xJM5lnyrDTiEMN9hcZADbxeT9On8fmIJKR6gjRVqnVEg6txptf+T3ImBzCKRfWQH623WMPIU5L4PSVCT0aQY5YHbcjacoFBlhf/CPCOtAfe75HEv8WzaS4jrKFGNTiA7o4s1cGczVGVn5ifxED4wRWWMd7bRolKhNtqUKQKC5V7icG7cI8gci0OcrAyxcrxA0g0RZDJehmuCEOySuV+E9dsIEWsNiey0mLwqcB1GngZaFwYAJixq4NNdEUeyu/1dwMzUE0eVMlN8nyUqk1KXlQ1cy7LbQLGjkqmrAScfr7aUIU/TCq3cVOg+nULdQxzgJ5amlV20j1I3DVUMuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i76HrzGz6HNiRqJSxWsq9FQ6mSvhq5PmxYvx/HcYyrs=;
 b=k2xFlmGcj7BmMQKtddcS7HrrS4yk4TSrqZdz+m7FKwlsgJXHiZbLQ3oguM2wsruvUoCN+Hn9fQZVpxklAbqDXEHUYS23SrWURTW2TezCsPMAL70oow8W9RMedFG3127ITx311+YxBrYclOeg8sAm93rFRsZ/eE/OBHNLtI9rCRA=
Received: from BN9PR03CA0402.namprd03.prod.outlook.com (2603:10b6:408:111::17)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 13:01:05 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::d) by BN9PR03CA0402.outlook.office365.com
 (2603:10b6:408:111::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 13:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Thu, 19 Jan 2023 13:01:05 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 07:01:01 -0600
Message-ID: <ce401cab-a602-40fc-4033-8005a7903505@amd.com>
Date:   Thu, 19 Jan 2023 14:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ARM: dts: zynq: Add xlnx prefix to GEM compatible
 string
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <7768d5d68fe38dd8e9300e9c6e09c228e79b2862.1672909533.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <7768d5d68fe38dd8e9300e9c6e09c228e79b2862.1672909533.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d47cbb-eb84-488e-04fa-08dafa1d39d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yK2d76sydq1i2jF94A6OAfD832oPXLMC5Gm2940xXeO56tJjgldk8QXIErXhR90ZoqPh+H6IgNduqXXesBUqmgXdhSy5Lcnh+Rm6ddk1miJCcLjeD0T/NVBYohSYB3awm2OpXb/oLNZciFVhYNh1BnS8lD6F/l0guq6QC1sNTJE2gdyGuWurZTLUg32WlEPp7aqQ554GXtmPcTBGtWHUF3PZFVCz2EKtaIRge7FKFyDPuaiZJmEhYzFNZL0LLMA82Ea9hoObVkevgytH0F2kB8QMesLWfGZydmO+X+3kqvbhe9+QrHkIa5pChOMg4nrjxxU1PGh2RrCrDaCUx7KKluQ+8fGcy7h7RZgw2xm9ak0fTOGfKuB6XcvNnObt4/qXIFRnDTdZUopQ9zpNPjoxk5h1co9OqMoD9OjLKqdkSx8lYkdwYEMJyiz4P1N+QSYIzhjtfZhdppiTasaxiD42NcDqS7+OS3a9Q9bFzNC9Qv1RjR0/msdDiS2gCVoD/D0jVGJI7AbmRUvnt5cE98qmujaOqzZBEoLwohLLUl/A569UBabpaEv9PSXFTCJdk9f57I4cOOvVyotUt9g3vdt8nZAdKPdLSM69xtJtejrWoZ+6xySzfuu5Iz5aDo0uel9Kgk7a+d7ubNI7GhnjPu9x87U4WaKodsolNaJh7H8BhzvYvoQ6vYkbW6AdP0ZqO4TJEh5w0j7HqjMqkLFvaAxV28pUXj0TX9v3Y3624BqfonQHJ3KTatpnohWEXflWMbgYBv8xhS/liDF5n1eHufNyeQDElpq/22KNF+xcrJl/8k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(40460700003)(31696002)(356005)(81166007)(36756003)(82310400005)(40480700001)(86362001)(82740400003)(31686004)(16526019)(2616005)(53546011)(478600001)(26005)(186003)(44832011)(8936002)(5660300002)(36860700001)(2906002)(41300700001)(8676002)(54906003)(4326008)(16576012)(70206006)(70586007)(110136005)(336012)(316002)(83380400001)(47076005)(426003)(43740500002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 13:01:05.7069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d47cbb-eb84-488e-04fa-08dafa1d39d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 10:05, Michal Simek wrote:
> From: Harini Katakam <harini.katakam@amd.com>
> 
> cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
> favour of xlnx prefix. Add this new compatible string and remove
> the existing cdns,zynq-gem compatible string.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Remove deprecated compatible string
> - Update commit message
> 
>   arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index f221c60643e4..cd9931f6bcbd 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -243,7 +243,7 @@ qspi: spi@e000d000 {
>   		};
>   
>   		gem0: ethernet@e000b000 {
> -			compatible = "cdns,zynq-gem", "cdns,gem";
> +			compatible = "xlnx,zynq-gem", "cdns,gem";
>   			reg = <0xe000b000 0x1000>;
>   			status = "disabled";
>   			interrupts = <0 22 4>;
> @@ -254,7 +254,7 @@ gem0: ethernet@e000b000 {
>   		};
>   
>   		gem1: ethernet@e000c000 {
> -			compatible = "cdns,zynq-gem", "cdns,gem";
> +			compatible = "xlnx,zynq-gem", "cdns,gem";
>   			reg = <0xe000c000 0x1000>;
>   			status = "disabled";
>   			interrupts = <0 45 4>;

Applied.
M
