Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81716AD494
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCGCVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCGCV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:21:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FC5708D;
        Mon,  6 Mar 2023 18:21:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n02kpGzub7fqEEOMyJrrfVjSyzdevkxKR7BhZ66u4JlUj32bKFf9qRRzzKCqxzRZdMl5MjvRATMLUuGfdjx+QsL92dX47CdCxwjlefbavbNDDmJcHs0NCw9RMRoVMgy44/ABvBdy07pX01LlSePl3Mco4yrpW4W+Fzd2x01vr5tuXY1D4vkgrCOHLSAIDRTKDeLQGfkJYr7q3Z16KO9BWVrT2fUd50UxbAcTRtu1Q1T6ayY4+CHPdl1JM+UHJ/mypigFnNy9Hr8C7Lmq00xVpGh+n9r4tw/M3JN6BUG2rbN31/Pvqdu4Mo+kiSsf0vPfHDk/X0KMZZ6SguA4QXYuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRcZi4cBpf/AFptEPb7+DhSC6alrPtucbVXwXz5i/LI=;
 b=TkN1nD4FPwRK8yqHPpPDetTEDL+n/Jk1cjtier5lmqmI/dALLd9a6t53ZWB8os3CIbUx+4lQQImU3fcPjvTzqGLMQXtXJ638BUKdHGUXk4V4SxW7+tgt7Wz0JbNrBAI88XbB+mL5pth/kIsrjTz9DZ861dEzb7EnLOkAxRa6foACuqOD7cfTjf9248hEAKRAP1wFWuJeW6AkBnOSF1lZM+YH24wZWfZMoaKhhK41xElgfMpLR5IvdzX6GDeeb+igOaSLxNTkkY25I12Z/ikUeqV149Uc1WVmfm2aD1BgIkZ0PqlvAd4wVVmUbTNFbyoMUHE8HVzGLn+Z5uNo6EyYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRcZi4cBpf/AFptEPb7+DhSC6alrPtucbVXwXz5i/LI=;
 b=C/SOsZNrjIzfqJ9CE57rHjHmeBxg0qpNKtCBzLE8WtjutZ//6wZt+SSIDzijXufSdLRbcxyzxg0b9SkLUWpjBQMSs6VS0XW3fQp62cYhc2dS+BVn3sSTT4xMVe2+mHvuXUWseo+Xmufzb8vOdx6rtxWUFKB86biykWRNLiQbY4o=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 02:21:14 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::66) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 02:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 02:21:13 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 20:20:36 -0600
From:   Brad Larson <blarson@amd.com>
To:     <fancer.lancer@gmail.com>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <gerg@linux-m68k.org>,
        <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v10 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Mon, 6 Mar 2023 18:20:02 -0800
Message-ID: <20230307022002.28874-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306160017.ptd3ogundxvus5zm@mobilestation>
References: <20230306160017.ptd3ogundxvus5zm@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: ec77ae33-c016-44f3-24c4-08db1eb29fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQfKP3DPHarDMTqOYgB4AOPc0OzRTuisxk+RT9zUPShSI+B7Mamd7Sq9YatNu8LO4JQK9XTNfRDXEUKGmHo/sHC9WrPY2+Duu7c2YJQEkffifGy/bNoncOGuglAGtfQESZyTqxWtZD7yAVFg348tvh3xQeE4zfMUmSyCY82WKu6wrN6bFR3LYvD9m/2r7DlS566k14NOwvFYtXp/QDwUT6ZJBrrQshI0uwZyFFSDyGwfoJtuLOuSPzDqTLQ/rFLTQCr0VJRuaofkg0J/3lSJnaIS3FYjKLepZURuzDQmYjECdP/ZJsQVgI3q2/QewfKE0sLvOf8BPVnwwnnhEPCG9FYNiKOi9bza0nl/QS0yhYsnD9cnh45cwa1+1Y7aGargD26LHLduQj9KS/QELTTD9iCMvPyHMIOhIQ6fQ9WWLLdPy6EA9FTpBcZfitKJT41lijTXVs02u+bG9ook3KceL+8FX5cJpZSVgtj7FnC1KnIdPEoBXtrhGfwtsNdSUxF7buqVkmXPA3D1aFdnBI4le766qrx72A59PwBuWkU60fXxlwyOw1N9Vac8hdtC6AqCkksrmUV1WjHUgyL7Qs7wIMX0TicaqDNQHv5l5W+o/DQNkTFieUBcxObAPpUL4h8WuIcmJDDl0IKeyNXGED5XqBiboJMFFYMdptZf1We1AadpOiRB4u5DH6HQbS1UDLgDBm+TiAnkGI0Ulmhnz3PaqdNqoMOHmA4+OsNZezUk81s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(81166007)(82740400003)(36860700001)(356005)(36756003)(4326008)(1076003)(7406005)(2906002)(5660300002)(70586007)(6916009)(41300700001)(70206006)(7416002)(8676002)(8936002)(40480700001)(6666004)(82310400005)(47076005)(336012)(186003)(2616005)(26005)(53546011)(16526019)(83380400001)(40460700003)(426003)(54906003)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:21:13.6218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec77ae33-c016-44f3-24c4-08db1eb29fce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 16:00, Serge Semin wrote:
> On Sun, Mar 05, 2023 at 08:07:34PM -0800, Brad Larson wrote:
>> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
>> with device specific chip-select control.  The Elba SoC
>> provides four chip-selects where the native DW IP supports
>> two chip-selects.  The Elba DW_SPI instance has two native
>> CS signals that are always overridden.
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>> 
>> v10 changes:
>> - Delete struct dw_spi_elba, use regmap directly in priv
>> 
>> v9 changes:
>> - Add use of macros GENMASK() and BIT()
>> - Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()
>> 
>> ---
>>  drivers/spi/spi-dw-mmio.c | 65 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>> 
>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
>> index 26c40ea6dd12..2076cb83a11b 100644
>> --- a/drivers/spi/spi-dw-mmio.c
>> +++ b/drivers/spi/spi-dw-mmio.c
>> @@ -53,6 +53,20 @@ struct dw_spi_mscc {
>>  	void __iomem        *spi_mst; /* Not sparx5 */
>>  };
>>  
>> +/*
>> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
>> + * gpios for cs 2,3 as defined in the device tree.
>> + *
>> + * cs:  |       1               0
>> + * bit: |---3-------2-------1-------0
>> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
>> + */
>> +#define ELBA_SPICS_REG			0x2468
>> +#define ELBA_SPICS_OFFSET(cs)		((cs) << 1)
>> +#define ELBA_SPICS_MASK(cs)		(GENMASK(1, 0) << ELBA_SPICS_OFFSET(cs))
>> +#define ELBA_SPICS_SET(cs, val)		\
>> +		((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
>> +
>>  /*
>>   * The Designware SPI controller (referred to as master in the documentation)
>>   * automatically deasserts chip select when the tx fifo is empty. The chip
>> @@ -237,6 +251,56 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>>  	return 0;
>>  }
>>  
>> +static void dw_spi_elba_override_cs(struct regmap *syscon, int cs, int enable)
>> +{
>> +	regmap_update_bits(syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
>> +			   ELBA_SPICS_SET(cs, enable));
>> +}
>> +
>> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
>> +{
>> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
>> +	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
>> +	struct regmap *syscon = dwsmmio->priv;
>> +	u8 cs;
>> +
>> +	cs = spi->chip_select;
>> +	if (cs < 2)
>> +		dw_spi_elba_override_cs(syscon, spi->chip_select, enable);
>> +
>> +	/*
>> +	 * The DW SPI controller needs a native CS bit selected to start
>> +	 * the serial engine.
>> +	 */
>> +	spi->chip_select = 0;
>> +	dw_spi_set_cs(spi, enable);
>> +	spi->chip_select = cs;
>> +}
>> +
>> +static int dw_spi_elba_init(struct platform_device *pdev,
>> +			    struct dw_spi_mmio *dwsmmio)
>> +{
>> +	const char *syscon_name = "amd,pensando-elba-syscon";
>
>> +	struct device_node *np = pdev->dev.of_node;
>
> Drop this since it's used only once below. 
>

Removed

>> +	struct device_node *node;                                         

Renamed *node to *np

>> +	struct regmap *syscon;                                            
>> +                                                                       
>> -	node = of_parse_phandle(np, syscon_name, 0);                      
>
>	node = of_parse_phandle(dev_of_node(pdev->dev), syscon_name, 0);
>
> +	if (!node)
>
>> +		return dev_err_probe(&pdev->dev, -ENODEV, "failed to find %s\n",
>> +				     syscon_name);
>
> Hm, using dev_err_probe() with known error value seems overkill.

Changed to: return -ENODEV

>> +
>
>> +	syscon = syscon_node_to_regmap(node);
>> +	if (IS_ERR(syscon))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
>> +				     "syscon regmap lookup failed\n");
>
> of_node_put() is missing in the error and success paths.

Result of the above changes are:

+       const char *syscon_name = "amd,pensando-elba-syscon";
+       struct device_node *np;
+       struct regmap *syscon;
+
+       np = of_parse_phandle(pdev->dev.of_node, syscon_name, 0);
+       if (!np)
+               return -ENODEV;
+
+       syscon = syscon_node_to_regmap(np);
+       of_node_put(np);
+       if (IS_ERR(syscon))
+               return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
+                                    "syscon regmap lookup failed\n");

Regards,
Brad
