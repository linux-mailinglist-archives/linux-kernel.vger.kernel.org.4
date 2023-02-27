Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E26A3C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjB0IR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjB0IR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:17:26 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81451C7C2;
        Mon, 27 Feb 2023 00:17:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOSr3w+iAEqXsLn6LIyzh8zEWlLewBzbi9tDu0zPhwOlV9Rrq2Yva0FEajt/utcVcazw2zz1CDP6XS4Pjx48FLPIEeILgThaXrzsXPHV8dNOLCCAd00ab2LSlcqvGEtc7cihjRSPCzaP2lTZ0iJ6Bwg00xdTK7nkLZZK2jcbwbtTimoWtMkMPdtqiiKrAAnjbb5b3s88k14oDDBr7pnh5bN6r9V3AVQOA0skltPoPA4waP9esIPNRBhJ8nfzxKBN9iDQXZ82CM6Et0jpWL6vZ5cS6e1vjucYW38KyCc6mCR10zGl/1rkqVfa/QD9XV/BH5pe1STx87bbnHQUPapyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJcpID4SNOYib70EMuZebEz/Tke5UL9H80+xPapihhI=;
 b=lc30y1l0JsfU2AHMjLCjvEm7XvqAStzCGBKAO89IDmljoUyVjErgR2s+bEiQTboG2cmsPa4SGxf36xBxGmD22hhIv5R+2lsnXojYmsa4u23Mnrg8hEWjJSfkk+2T9H5VbtioCyduRha5752OXIAxUclA8QZEE55SqNstxLsZBSgwuK7Q7xsI/h6ZB463ijc7fssNvCqRVnvhHhDPOvlPLsPI24LQC9dOZ4ANS+/W8XjjoBG7OlG3POgL0s1O1EeYjZMysZIpUe79Bi+c4qhqXnCtENGbswp+KEZ7EYxWlXARggBYD6lZu5UcELlI7fJ3ekULQ3M2BMJ1HfNeRYZKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJcpID4SNOYib70EMuZebEz/Tke5UL9H80+xPapihhI=;
 b=EawbdWtmeRnty4x6z2vZpSJAPE3MCxyMdqFbmmYLsfKkXAew/eNKiSylS2G2NIF7D9ImNP76FCuQF82P/RcAyL5QgWEU7F9o5W3XvlnYBbp22l3S0SafFut0g3dvYx9bKkX+1GRBfP7jg6c6T7zvzRBoG7HgMlP2sk/QHpEX8nk=
Received: from CYZPR05CA0034.namprd05.prod.outlook.com (2603:10b6:930:a3::20)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 08:17:21 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:a3:cafe::8a) by CYZPR05CA0034.outlook.office365.com
 (2603:10b6:930:a3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16 via Frontend
 Transport; Mon, 27 Feb 2023 08:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 08:17:20 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 02:17:16 -0600
Message-ID: <9a4448cf-9064-c763-8887-791c4518af8e@amd.com>
Date:   Mon, 27 Feb 2023 09:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Swati Agarwal <swati.agarwal@amd.com>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>
References: <20230223141402.23979-1-swati.agarwal@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate"
 clock
In-Reply-To: <20230223141402.23979-1-swati.agarwal@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 52539c99-13a0-4909-bc10-08db189b0c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVY5iLhvodoDzsmc26/3t88X7Ty4g3iMggUQee6ic7Y6YqYeEoVJcudZ8tovh7+liIEyFNUe4WHf6/Hf7cINHmLgGYARblaqzTjsEb2K9vHGjIthujoOpa/AqwWuaZIWPZGbIc4PuHYjkaKxi5fPuSqjYtf3W2aZ1tVLpRcn8FUnGo2h6jbN2sZ9ecfl4gC7Ge24OxZaOZap868XIQUB7AHIx8mfA7ZXpyuu6NxxDcKkhKy6dGIA2e/nSHAB5PVbdFFZrpA5XdzReC0mvMNSwW3SNebtsYWdHDF0HaSAuS4My9gd68vgFhcOCzMDPQy1mnvlJTZkHLSwFCQnL5cNdObytHKR6owZr7o8hxYPRIYlDSU5aag+pU0vy1x2B+75beT3GPaVZTV12CcFuh2FBRJUNnQYrW08OSJrYtqUyZ1/SKTP9ZKKBliJw8GLBzcTy+I8M7LCzRTq2VoVFlrfE2lXmLpX+I0v+apfXwqlJ3/HIrapUQYnzH5tDyvxWiHJM8QaF7I8lbqklRe51Y2Ciis+w6u6Wtai9t+TFNh75R2KN6t6uQdLqAtH4aflYWpYLXpuRlAeTHXd0RZAGZLvC6H7+hpeHeMzOAnRdXWG+hH3BA7wC5Wq61EcoQ5+4uuynvyMPd4hCQzhOFYjwQd+6cVkeMe2wdiReZ57vOncI1cdPRUpYgBmrT1YDRY6s79DE6tsQuZllqLFCQi/wipwoY5WKoOruduhbm9Qay7+1hVFyP69qgzpF6lCDsZHIAmz8frnL32W7b573RSOxi8ocg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(86362001)(31696002)(40480700001)(40460700003)(41300700001)(4326008)(8676002)(356005)(8936002)(70206006)(70586007)(478600001)(110136005)(82310400005)(16576012)(316002)(5660300002)(54906003)(26005)(44832011)(2906002)(36860700001)(83380400001)(82740400003)(81166007)(6666004)(186003)(16526019)(53546011)(426003)(47076005)(336012)(2616005)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 08:17:20.6660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52539c99-13a0-4909-bc10-08db189b0c42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/23 15:14, Swati Agarwal wrote:
> Add support to read the optional "gate" clock property and request the
> clock which will be used to ungate the DLL clock.
> 
> For Xilinx platforms which has DLL module, dll clock must be
> ungated/enabled when SD controller operates at higher frequencies like 50
> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
> clock from the driver.
> 
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 4eebbf801b41..1fd7528c14fc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1870,6 +1870,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   	int ret;
>   	struct device_node *node;
>   	struct clk *clk_xin;
> +	struct clk *clk_dll;
>   	struct sdhci_host *host;
>   	struct sdhci_pltfm_host *pltfm_host;
>   	struct device *dev = &pdev->dev;
> @@ -1943,6 +1944,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   		goto clk_dis_ahb;
>   	}
>   
> +	clk_dll = devm_clk_get_optional_enabled(dev, "gate");
> +	if (IS_ERR(clk_dll)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_dll), "failed to get dll clk\n");
> +		goto clk_disable_all;
> +	}
> +
>   	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
>   		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
>   

Based on available information, that it is not clear what gate clock really is 
and what it is used for, I think the patch is correct.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
