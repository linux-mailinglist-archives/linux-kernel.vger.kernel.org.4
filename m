Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90E6648233
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLIMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:10:53 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2102.outbound.protection.outlook.com [40.107.103.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356093FB95;
        Fri,  9 Dec 2022 04:10:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5lErK6EIY9ScnLCau1dJwp0g1KjqQTpK9uVAayqmM7tKaTTsBZmqKZE8N01wqiDaj+ahvMItnKWO750RevyhoecZsc/RXtbX/E59VqTpl7a+/ViDHvu8EM7VvDt2j1sJgjYEt/T/r0W2TUGmztpDiC2+YayYmTD0BYVlLXj2q1MXBSJgvdRJiGMd4p1R90ztWjxDyzWXQaBK+cixziqVXEufd92qdhrTMLvV0jcEBWniwhCar8Zgqf9XSPcVZkn96BNL1QcjYw5hhxLk5Di28NccQoCdncATFAP8QpcPZUJk1EHAwEdVDpOotJuJrQFzkGPKEOlntzUAih8ZmtubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3MIj4nGJw9z+qaBA9ZBWWGKXuCwVRS2us7hqDIV94U=;
 b=Y1NrpD6zj5uq3X8DTHzYWLOrQTrCQFP01fJDFGJgdq2G5wWVfpcA0K770UuagrFpugoGW6wRsv0mKZWgxT9peyWuRrVjdugYC/mUykEVb8Iaa5Ac94sfVOUAR+VuYCyYeCHAsHl/CcArxmkvZbzkGTna/6H7XFgza/d2kpMRqzisPULEPwcIF/oDkCakNoOPlQFBevHrqZHCRJpjixAJWxYAJDJWLdcT+sjRoQF+ZbkMsw9nzygKUspeItTqmN6mJy91jGM+KYlytAcEuPlduGQ/xZnV9SRh1UCn3pmhCXHn/4FmLT7N1DEYl3TIqwrAeIU74C8biKSG/qdLRBEP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3MIj4nGJw9z+qaBA9ZBWWGKXuCwVRS2us7hqDIV94U=;
 b=YcLk1BnADfJow+1k8/Tuib6N6SyAt0ImrBhM0HV3XEUaORzuF3sTMvR2U6Ezi7aHikidtTQ0I9o8OyUuZumXLf3U+GmDjM+5PrLJ17uvWPpyYJqGG6FILbC60q8xJTeaoxndgeJY/S/iraklwiNzxV1f7s4dy+p5O0l8+tzBu/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB2001.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 12:10:48 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 12:10:48 +0000
Date:   Fri, 09 Dec 2022 14:10:46 +0200
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
        <20221205105931.410686-4-vadym.kochan@plvision.eu>
        <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
        <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: AM7PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::14) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DU0P190MB2001:EE_
X-MS-Office365-Filtering-Correlation-Id: aae75ee8-ce66-4153-1758-08dad9de684a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVdg6+0B+Ww0Ha6W3yFYo14ba0zN5UvjPb4ie2gKaO+VjO95xcFEh++W7DMzwWF1ReM+II2bquKzdFfK056P/GrwCBV9dRC6xdg9DKVxWFNMNUMWwg+LJKceKU4VbsRhTUYo2mWk1D17BQMcQByPan44+qx4z/tqeIhvcbuC3m7VHaDqYw8eaXgPQh51ysVvONfBa9hD7a9ZagmvPSTqd39q3sBpLHOLW2K4QUfg6J5ibOPLkW6VB61uCjwlyMOJ0LMUoA7TN7W++N5scT7K/B0mut7tf2YO/NunZBWnJWFWsW4b2ynUEZ1FIuK/P+lH3k3xypxHT2ZiUqc8NnF2Uz7JIyrUXCWCPxMTeMJ/OCw/MlfpgOHwtRNoI0Ow+gy2G2MLXnZMXnfkUV2FSxl7o4RXbx1U/mh+Dwz2G+J6JrJt6VgW2LQrqaw0OWlhbvtQ6BJ6E3vc4c05DMKduoPn7kDS0/wZhfv6S1PpLZ1SQ1jBBleQi1MztpLNDlPA5NWv5zFVLfgKBzpiQwm07DEwrQndHrcga7+TM1t8e2IOVhAAGMNFqNpP9Xe1yjEs0KikPLohz0bfTCTBmxMCayd1tDyBmObn0/e2KeXJzwNKJXz5bRmi7g/9RrhX5He75dDmsFfWmCVohoDS6HBSBoR2pSKUXOG3kCIly4xfbnYiq5sJU84lK7lclQK6Jg8nB9kMTbhzhVjbRkHiExRv7uy7MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(396003)(366004)(376002)(136003)(346002)(451199015)(83380400001)(86362001)(38100700002)(38350700002)(2906002)(44832011)(8936002)(5660300002)(52536014)(7416002)(55016003)(26005)(41300700001)(9686003)(186003)(478600001)(66946007)(52116002)(66556008)(7696005)(53546011)(66476007)(8676002)(4326008)(6506007)(110136005)(316002)(54906003)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BPKGTfUIkAkDrgY0zx/0fB3NmYXTbQU5FDQfFT7YIid9uwrMFdeRgiaexit?=
 =?us-ascii?Q?XypANJ1hKqeVtkMFVwioLwl+aRTpWbXACj+9d8LjEmlW4mOzAiwNL7q89Fkp?=
 =?us-ascii?Q?UD9NjT4BExDjsF/wH2tNlI3bx8B3Eg6H+Emu9uSOkxTGeI1mFf48bjhUSKzr?=
 =?us-ascii?Q?tA3EvKSXs90Ile3OmW5McdWHBj5jwV8bmfe1gTjv24n19isC5b9TTmT3JjGP?=
 =?us-ascii?Q?TUIf7Pxdar3/EXu56ID5Y6q6XddARjwIVuPiyye3zhh1j3f0LI8tei0vlZi2?=
 =?us-ascii?Q?lXLwnAq5nNQhkRGakbOk7Vyqwx5l4BYgAZXv3HPgsZ3TD8p7jGU9IlDpjAlm?=
 =?us-ascii?Q?gL/xcWbTX92q2+k17XH/apGkZvLskOJujDzcfKK/RcHxkXNddg6toV8wjw1l?=
 =?us-ascii?Q?TgWCOTrBu1EDVDHX7jfRzTrkABRsrU5NchABSaVXbIL8EaLcVGLG5Lf6Lg7r?=
 =?us-ascii?Q?QgMhNB4fZpE1egStkIzkz8KmIjctpLBlfng3XfVGZRbeBmgn/xWI8xNJHU+N?=
 =?us-ascii?Q?PcmLLlq0z7QTKgwBlIkrqjngcQFjCXmdtZymiIErXL3/7Etcm+IOuhLbHzxm?=
 =?us-ascii?Q?OygmXnNCoZI3u3PHfZg/sTxTK8oUF1dc/Dx3ULLTRipRKiWAo7qBNUTdVFur?=
 =?us-ascii?Q?NdUX36GQ3qKxCE6tWkuMDZPTX4FLoDqXlFw2brAht2F3DNXLC3pkxqQOcdvB?=
 =?us-ascii?Q?oByL4xj4D4rdTlY53M1dbumHc7AYEzKOHb6ysRs47vL16SEmtMZiAmBDMSfk?=
 =?us-ascii?Q?4U+nT/INJCo2xs2KG81+7lYTsyNAK3X+nn/D89On71hWy8h0ofrpvcvIa4q2?=
 =?us-ascii?Q?SZNjb8vph0BfGAh30hOuPx/dztwgT0cDR861K+xjEUFuVPYcFgYgEDA9/Kz3?=
 =?us-ascii?Q?4VM2BAnP+GKGs9aPz0Dud1PZys79wpuwWuLRwpwyhkSmwNQ2ww59pr0BxVQw?=
 =?us-ascii?Q?BgbFKDsbYGA0f0d4YwnWPH0sBTH2MolnmTc4HokdnIbjq89NA39rPDddjotL?=
 =?us-ascii?Q?sXqgwWDw8R8wxKzqgG+pFYlX9MwHEPY6aZfx2xw4Fm+AG/wygqmy6CRs9PxT?=
 =?us-ascii?Q?nAUhBKT+9X5YCRkMVu+qYjK3HHg0xgpKl7aGkjzfiYJEYUGCh2pkN6vrOAEx?=
 =?us-ascii?Q?OI761E2W0Wom/IiuIdBNahfmRqsB4WH7MsxZpnlfWGFsRLSX1RZaSqMyj57C?=
 =?us-ascii?Q?ihaUf34e2e9+4E0NPDUdHfEy9STWIV7Hzi+LGz7GPdW2sviZwvMXz2CC0ACR?=
 =?us-ascii?Q?SkKj3fJxtXc5CXJf/CBUPFlFBa/YTzv/axCeWRchHwotTMTJzrvlZeL5Vy4G?=
 =?us-ascii?Q?9MLmJdnMkokYO7sKO0j61kv/OOkwbF5EB6P8ylEkGpxbSxKbocvEca1NduvD?=
 =?us-ascii?Q?Ar4/PdbC7cldxJ0RPF9mVaMqpkx8jOt1Y6+NUQ9WSTTnwGYTKSivbDnr2dPc?=
 =?us-ascii?Q?U4e4CbrLtyPDGV7xdG5XGrRYHvcFAYV2VdOZrkeMWFqZHxStfdjKQklly355?=
 =?us-ascii?Q?dHzm+C2f6OtXfnC/5yHW14PyjCfugQIz2McYeG7MHxbNfEw6xTCJsfxnNY4q?=
 =?us-ascii?Q?lMj5Z+d27saF/We8iAvGogRQbm5Tp3INy3peOSYDrt0VL9Ker8LEcozq6FMk?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: aae75ee8-ce66-4153-1758-08dad9de684a
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 12:10:48.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSXRmDoH6p0EnsZf8NUokUHZArrx8ZOpGhwHhesU5IWOESmprWJhl2nGfYuSi5aqGW/lBqJ8w1Lxefl4LJ5GdmxVJ3rB1Wvs8yhf+a/LiNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB2001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, 9 Dec 2022 13:53:58 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 9/12/22 13:39, Vadym Kochan wrote:
> > Hi Adrian,
> > 
> > On Fri, 9 Dec 2022 09:23:05 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> On 5/12/22 12:59, Vadym Kochan wrote:
> >>> There is a limitation on AC5 SoC that mmc controller
> >>> can't have DMA access over 2G memory, so use SDMA with
> >>> a bounce buffer. Swiotlb can't help because on arm64 arch
> >>> it reserves memblock's at the end of the memory.
> >>>
> >>> Additionally set mask to 34 bit since on AC5 SoC RAM starts
> >>> at 0x2_00000000.
> >>
> >> Can you explain more about how a 34-bit DMA mask works when
> >> SDMA only supports 32-bit addresses?
> >>
> > 
> > So, after I set
> > 
> >>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> > 
> > then sdhc core sets mask to 32 bit, but then dma_map fails to map
> > bounce buffer because the base address is higher than 32bit - 0x2_00000000,
> > and 34bit mask fixed it.
> 
> What happens if the bounce buffer gets mapped in the range
> 0x1_00000000 to 0x1_ffffffff ?
> 

From my understanding, on the AC5 SoC RAM starts at 0x2_00000000 so the bounce
buffer can be mapped in the range 0x2_00000000..0x2_ffffffff

> > 
> >>>
> >>> Co-developed-by: Elad Nachman <enachman@marvell.com>
> >>> Signed-off-by: Elad Nachman <enachman@marvell.com>
> >>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >>> ---
> >>>  drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
> >>>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
> >>>  2 files changed, 40 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> >>> index 08e838400b52..5f3db0425674 100644
> >>> --- a/drivers/mmc/host/sdhci-xenon.c
> >>> +++ b/drivers/mmc/host/sdhci-xenon.c
> >>> @@ -13,7 +13,9 @@
> >>>  
> >>>  #include <linux/acpi.h>
> >>>  #include <linux/delay.h>
> >>> +#include <linux/dma-mapping.h>
> >>>  #include <linux/ktime.h>
> >>> +#include <linux/mm.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/of.h>
> >>>  #include <linux/pm.h>
> >>> @@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
> >>>  		return pltfm_host->clock;
> >>>  }
> >>>  
> >>> +static int xenon_set_dma_mask(struct sdhci_host *host)
> >>> +{
> >>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >>> +	struct mmc_host *mmc = host->mmc;
> >>> +	struct device *dev = mmc_dev(mmc);
> >>> +
> >>> +	if (priv->hw_version == XENON_AC5) {
> >>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> >>> +
> >>> +		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> >>> +	}
> >>> +
> >>> +	return sdhci_set_dma_mask(host);
> >>> +}
> >>> +
> >>>  static const struct sdhci_ops sdhci_xenon_ops = {
> >>>  	.voltage_switch		= xenon_voltage_switch,
> >>>  	.set_clock		= sdhci_set_clock,
> >>> @@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
> >>>  	.reset			= xenon_reset,
> >>>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
> >>>  	.get_max_clock		= xenon_get_max_clock,
> >>> +	.set_dma_mask		= xenon_set_dma_mask,
> >>>  };
> >>>  
> >>>  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
> >>> @@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
> >>>  	xenon_disable_sdhc(host, sdhc_id);
> >>>  }
> >>>  
> >>> +static int xenon_ac5_probe(struct sdhci_host *host)
> >>> +{
> >>> +	struct sysinfo si;
> >>> +
> >>> +	si_meminfo(&si);
> >>> +
> >>> +	if ((si.totalram * si.mem_unit) > SZ_2G)
> >>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  static int xenon_probe(struct platform_device *pdev)
> >>>  {
> >>>  	struct sdhci_pltfm_host *pltfm_host;
> >>> @@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
> >>>  		}
> >>>  	}
> >>>  
> >>> +	if (priv->hw_version == XENON_AC5) {
> >>> +		err = xenon_ac5_probe(host);
> >>> +		if (err)
> >>> +			goto err_clk_axi;
> >>> +	}
> >>> +
> >>>  	err = mmc_of_parse(host->mmc);
> >>>  	if (err)
> >>>  		goto err_clk_axi;
> >>> @@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> >>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> >>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> >>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
> >>>  	{}
> >>>  };
> >>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> >>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> >>> index 3e9c6c908a79..0460d97aad26 100644
> >>> --- a/drivers/mmc/host/sdhci-xenon.h
> >>> +++ b/drivers/mmc/host/sdhci-xenon.h
> >>> @@ -57,7 +57,8 @@ enum xenon_variant {
> >>>  	XENON_A3700,
> >>>  	XENON_AP806,
> >>>  	XENON_AP807,
> >>> -	XENON_CP110
> >>> +	XENON_CP110,
> >>> +	XENON_AC5
> >>>  };
> >>>  
> >>>  struct xenon_priv {
> >>
> > 
> > Regards,
> 
