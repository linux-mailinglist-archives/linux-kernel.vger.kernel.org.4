Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754CE68E244
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBGUx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBGUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:53:41 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E703FF18;
        Tue,  7 Feb 2023 12:53:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXcYQUj5h1bqOn/kwoib92RfjSFskBNa8bSnExZV0NFmNgu5YROoEtmnIIkSdxL7RZc74mDhM2OSdbwvI/28jWkwlG5zYb7Zfcqj+R7xo3CFkNkpDU4KMW/8WmxMAem8v9vEryDf/koG/15y6yISqArs5Qs2LL1a76RqvR77jVoOZTGNuxu3cmJvn1OwSSXSCfJqGJQIGkoi3WNmePCBejbYNNyTjt6zyU83JUieo1JedAY9Dt0kdqxb+ERpHHmPLfziyc8kch/G89AHMpS1qKtCDFMrTl+dpPNWc6WVw9XExwMBoygVRds1uG780VfQUl1t0eKvwV3cIOKeZgJPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAh7AtkAYVquaBCsfvsPLMlc8KQkpSaevHi7HsjV3pg=;
 b=joaWtDeeHO54m1r/xH/CxpAIBjZEXLJ293S2ABDmi4R8W7mzn0oP9nojKU2IoMdTH9urC/AsKNTszmTOs/N9U6QDZzPBoeFpr62fJRQGhsKi3lutUP7a9TzGI60qF3yZSpT9/NmcPfj8gGJyuadi/PW7H2rX5lxXACOS9IdfNtgqPu0oh6q7jf+H9nPu6G9RN5JL+GqOe7tZ02enW/xc7I2F0pKLChvfRMYdqyiAQ9bwSFe4cDxUwGn6YkQwoOEpFp2rLHX9rlq5cNIaRa4eD3nrEdj1aXbqUfQK2CpzqbA/XHlIkeArd3idSPsXn1IwObLOaQ2R1uuBHxoSZilWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAh7AtkAYVquaBCsfvsPLMlc8KQkpSaevHi7HsjV3pg=;
 b=v+34oJtw4nOXEHocnnWLR3ycplEtSZZIpPP7I+mtbVNjmZFNQc85Y0xWZmt4YCq3ySnWWcAOdoAfcaoPkPDIL2s2zAwZ6CH+ltbSq0Pjw/KEIK7rpiUUTJMxD9uOCAOg9TOm8+KmwTuQTs900kTh4LdroJTnPYYsRmF5yC2ppAE=
Received: from BN9PR03CA0751.namprd03.prod.outlook.com (2603:10b6:408:13a::6)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 20:53:31 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::7d) by BN9PR03CA0751.outlook.office365.com
 (2603:10b6:408:13a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 20:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.34 via Frontend Transport; Tue, 7 Feb 2023 20:53:30 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 7 Feb 2023 14:53:27 -0600
From:   Brad Larson <blarson@amd.com>
To:     <p.zabel@pengutronix.de>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <skhan@linuxfoundation.org>, <suravee.suthikulpanit@amd.com>,
        <thomas.lendacky@amd.com>, <tonyhuang.sunplus@gmail.com>,
        <ulf.hansson@linaro.org>, <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v9 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Tue, 7 Feb 2023 12:53:21 -0800
Message-ID: <20230207205321.12341-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119093450.GA14049@pengutronix.de>
References: <20230119093450.GA14049@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bfa097-2702-4f69-2f9f-08db094d5e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYno9IrjLMcSaDJQUDTTUGvIn9vNhjEfSVVsgQuMB8ljO5jrbs7SFDXZ6bvcR1+dSyTR0vjEpmMTI7Zs4zBe2kqWNdeDETXft/ER5CQ07lp1Y+7ioTGKKdtODRGX2SAPgi7P3nl9s9hHABzfplDhIUy+/2YxtIJLRu4+U55jzRZK3LAmFZPct3cfZV/+g3M2WSbzxQp+CIe+ky27aOguhGPQXFcWbkPVZAyP/Upwc1VgwWqkCppmrT2Rkaw3HUJ5uizrmbZPiNkREUbMQFivvPDKsg/I2xY0FNvVZrUDRIsRfu+kusGf7vJejB9E5gv6H0jYfE9XdjaBNQXT+jPEQ3ImBEEMV564eQYAQT2ndovVASaD61ddyPXh6wWzBNrTHdXaxZ/kLrSMSo8l5nIwzq+LXFcrlX2ScaNk9MrpuCBqq6q/SNd54ekxbJcTmFIP0eE5II6AJ4mCY/PVsKaQsePcsJpts9fokUFd3iuB+I9Ln7ATNCihNZrEyleRb/jPd5EcAhJ+VY5k8BW+j38yN6vH05V96C/AIy72Mww/Nn9URCjOWt5tn0xrRprqigEKIaVT+ifcdbTTZ98V9cMOa072wAyFYeUt7FAyokcixYNBbP6r9WOgDHTZMJJvXctZHfzieIpDJKMPrnu/uWRRfKaDQ9vRMNcG0n0p9v7A/OdcldLmE8kdQKEaxZv0hUSnFP6oy8aqlmF71wf+SRMXv6iz/OYSwQBMHZhKHZFJz5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(7406005)(7416002)(36860700001)(82310400005)(2906002)(82740400003)(81166007)(40460700003)(336012)(47076005)(2616005)(426003)(53546011)(16526019)(186003)(26005)(40480700001)(356005)(36756003)(54906003)(316002)(83380400001)(70206006)(70586007)(6916009)(8676002)(1076003)(478600001)(41300700001)(6666004)(4326008)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 20:53:30.6555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bfa097-2702-4f69-2f9f-08db094d5e95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Thu, Jan 19, 2023 at 10:34, Philipp Zabel wrote:
> On Wed, Jan 18, 2023 at 07:51:35PM -0800, Brad Larson wrote:
>> Add support for mmc hardware reset using a reset-controller
>> that would need to be enabled in the device tree with
>> a supporting driver.  The default is disabled for all
>> existing designs.
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>> 
>> Changes since v6:
>> - Previously patch 17/17
>> - Changed delay after reset_control_assert() from 9 to 3 usec
>> - Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()
>> 
>> ---
>>  drivers/mmc/host/sdhci-cadence.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>> 
>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>> index e92aa79a8be2..62321cef41db 100644
>> --- a/drivers/mmc/host/sdhci-cadence.c
>> +++ b/drivers/mmc/host/sdhci-cadence.c
>> @@ -12,6 +12,7 @@
[...]
>>  static int sdhci_cdns_probe(struct platform_device *pdev)
>>  {
>>  	struct sdhci_host *host;
>> @@ -521,6 +541,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto free;
>>  
>> +	if (host->mmc->caps & MMC_CAP_HW_RESET) {
>> +		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
>> +		if (IS_ERR(priv->rst_hw)) {
>> +			ret = PTR_ERR(priv->rst_hw);
>> +			if (ret == -ENOENT)
>> +				priv->rst_hw = NULL;
>
> The optional reset_control_get variants return NULL instead of -ENOENT
> if no reset is specified.
>
> This should return on any error instead.
>
>> +		} else {
>> +			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
>
> This probably shouldn't be set if reset_control_get_optional returned NULL.
[...]

Thanks I see now with the argument optional=true in __of_reset_control_get() it is
returning NULL and not -ENOENT.  This is the updated version.

+       if (host->mmc->caps & MMC_CAP_HW_RESET) {
+               priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
+               if (IS_ERR(priv->rst_hw))
+                       return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
+                                            "reset controller error\n");
+               if (priv->rst_hw)
+                       host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
+       }

Regards,
Brad
