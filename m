Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEF6482C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLIN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLIN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:28:01 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2093.outbound.protection.outlook.com [40.107.6.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B873F4F;
        Fri,  9 Dec 2022 05:27:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHFjSVP9mAaH81QcWVFjvXJ+N1nkqSJ3u7NTKZ65p3PKspJxvyQ0oJIbIcFH74/ErsXMruBHez6HVH138LP+yXe7/O2XBwU/DF+Fgx+XV7NHgSKs/0PItEEl21w2gBkYASo3zi39khfKMb4U4d8uTnQPy8mcAP5yD/Q6RPnrJJtm1KBdcDZ81GXEI6Z5HYplwY1dbnhpYnt+JZeFRw2txNYhwl+LtjoktsZQXB1D2DrCduHLeHwd7/p6LkXshUscppSvaY57IefyruTfowFLnFYzoZ5NUlh+6C27UqVAjywYZpQj8tMrvmCGGQ+xFjhteVd4BFunUONDOUat+vpQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKsl44Fgly2Cy1P3irNIi11lnj/Y34qYXrsYAT0Uhcc=;
 b=YrAoDI3noGlwS8KjFvAJUOS4dOm/8xEyVGf79AfZNjVq9Th7cuhcKFKwqxtQZhSNnMwAZPunDn1Hrh7ArWA/HIhDjuqgjtDbIJ74oMaFSiqQmycBpRobCvfXaBxOupeEUyYXp0+2BcauY95/Dhm93wNk9nX36FoZXEwJ2yWEzoLAR6Hg4SFqXTvLlzm1/ySXrmwni9S/MO9Y7kIpBtccXsJjNYeR/3z+P9RU//mNbgOjLP+aZcAE96LgboH8/BmbXE3Rg6HUzkrIZf5eVUIDOiDdvS1wbV/vDfStUvEHTOD3lo6BOzAMuzvzczDWfPiZJeFz8aOZmOqL2QfR6QDGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKsl44Fgly2Cy1P3irNIi11lnj/Y34qYXrsYAT0Uhcc=;
 b=OMoIyHtgAY2bIjF+S5ZvBO5mmB+uVrvfqwRIVTAQEah64uv7BOGt+XmLlt5oXcH+kR6+ZHu3oaGMypQnoYafXesy3galCVvLJo667yPUt2d2vVhUYu/tiRGHmtaIKTBtEjaWcanxiyTJzfIMPRRgbPV0AcVUIsL0Pd/c0WhUALA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1827.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 13:27:57 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 13:27:56 +0000
Date:   Fri, 09 Dec 2022 15:27:55 +0200
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
In-Reply-To: <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
        <20221205105931.410686-4-vadym.kochan@plvision.eu>
        <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
        <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com>
        <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317DADE7450282444BFED32951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DU0P190MB1827:EE_
X-MS-Office365-Filtering-Correlation-Id: fffa2bdc-93e4-4b23-bf6a-08dad9e92ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDwSuW7wyz3uzHXtSS+fcxvu0IzfDJWd3PsVBlB/wm1eTkf4fX+3G7vK93sFSYUtOOKKc+l5iZddZQfTRdx6rIWYcszESJMlhMGVKPh7JJKAz5sCbxOM7RsLTZ7nmBXfs3hhbzAKsmbkjGnHkmcjQ87kczQd/cBQcrLhWCvy6kHjf1kH1Z70bxYx+E4ZCOnKT1V+j7EwI29DBuCA9rBHtyh4+OwGs+qTDUrwFI0Y+ZpnJ42b4TalayLpGMRZxiLfS/e/xN8Kom5vBhwKWK1sptXZkMnZbabM7gpU2+8zMmEGxgc1oE5YsItvrX+vZs/eCT2klpgjQJhij3k2T6EA4sCSLiVbMvk07VPdpbtB7D8lJL7Z0uTJ4pTGk38vkY65db0i4zkZo8fSO92DE520IrEmcHcXfVYBY4opckW9kScgazH0karwuxa4mYmGVA+NErdNwgV1C7SLdCKhdr3mQfsOYf5yfOq/t7mPCkSsQwy685cAR3mtO8wrVJwPmX83wX9CWozBu4gAwJaqcXuE7qMKeHl2/opv1qpvI1NTWrUNAMRifwNhLiBM15jhltFnXfiBQXfYCbszknXG/FeSw2Occ+b6AQ08LV25v6r9UiKhqYgzRcPEO00aQD5+JUz7fFQ46boAvcjHsBzTl/PZbMD8JDNZ13n+d6aaFTiG398tBO3LMSMfNYStdQ5g+5xOtZBGg0fFvAXrw0s7/JLQDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(346002)(136003)(366004)(376002)(396003)(451199015)(5660300002)(38350700002)(86362001)(478600001)(38100700002)(41300700001)(4326008)(8936002)(66946007)(2906002)(44832011)(7416002)(66556008)(33656002)(83380400001)(110136005)(66476007)(316002)(54906003)(53546011)(186003)(8676002)(55016003)(52536014)(6506007)(7696005)(9686003)(52116002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c+419U3syErs58fwV5FfGy7J8kbYl9HRyCO3KJeYFVaPWD9JaX1iXIr0Tj2d?=
 =?us-ascii?Q?PrzryJhCfZxwhOYta+ISF+smJoOWGc5xNYeakcxwE2Jecl6MSRuZAhWV/2N+?=
 =?us-ascii?Q?ynkU4aNzon+ETB9znJfyOGzUW24wEFcBQ6L0dTfxU2dpMhLevOpOwT0A7mmX?=
 =?us-ascii?Q?ippbs+BxTFlk4vHwOTy4T4H+K2y3mqtuD2YW7rtaev1pEf8UXgNlaDiOS+ge?=
 =?us-ascii?Q?SV5PXJ0OpAdj2sQxI0DFyWgoqE1dnxPXhX8N57LLnjj5YUR8RWH0sW4YYHyh?=
 =?us-ascii?Q?5gH9B6gyCbdtvNKChnxi6/0yo6KuLVk347MR2HJXbgRZbUiRv8OP8KZwoKef?=
 =?us-ascii?Q?FXIfhsXoY1Ls4JVjsjUM8Bfb6c8OeYdKoR4F5TnDNXVeb89VC/Z8ZRPDmldP?=
 =?us-ascii?Q?r5jqu3BVIrsfw03GJyso3aaRqIZck07AAET72rXSNkmrAuFXYwWmnkCk+oDe?=
 =?us-ascii?Q?pCn6ljpT5xSuQmAS8ImRspKAYT97Or5jtXHS3/uMxUpKQegQnD4Hvo+gxIbu?=
 =?us-ascii?Q?qQ4swldN6vQTnfNB8kQlUswc90VuVSHQPqL6LeI4wpZBg0YCSaeYDL+8Pr29?=
 =?us-ascii?Q?WaIlEnWqLKpMHGLPgMatjI4a09YFVfrjU90u60vJcAr0uIiUnXqfIZYioWGz?=
 =?us-ascii?Q?1Tyg47ol2K49HaJ9nqvrd/xzZZ/WWMpAJ+Ytx6vLGYoDU0G/nZZJ025vLyvW?=
 =?us-ascii?Q?0uyJMneCU6vQyJv6JY1d1IjvLoUzCCWqO0Yb/4FGfGxEBdZ94njkwk23jDSl?=
 =?us-ascii?Q?ZwBYBSjHd+GZOxqotgyc4oIJgMl7hZEWAJWw71j8HREyOcb+2KSIb3uovDGz?=
 =?us-ascii?Q?wAtlSzuyFCEBfo++aMK5efBwLPlL2sSeIB4K2dGCiHE/1uvEb3qxHlNKC0gh?=
 =?us-ascii?Q?JdZ2mZPEUOYr0as6DvO6fv+z/R384R5GiiQ3H9ES4C+giyp2ojwbWijvbrn3?=
 =?us-ascii?Q?1linsGabV7Kirb0FPDhxT8bwVWM212MC1ce0f4vSFQ6pgOafpEadKYFP2V/2?=
 =?us-ascii?Q?nQnyP/jo+ZKJ9QMYSeo4vfyWehHpEBirU72bL2hxqIQXXe1WH4CTL+VF8eI9?=
 =?us-ascii?Q?Rl1bq3IXo3tsAF9ViJ/QQN4xFLP57yS8Hvz7eurlzxZ3h7I59YGuLgCfXndl?=
 =?us-ascii?Q?Vo8uehatkhjYTC7p7PIgQJ7xa0qo0CA+gKx8XUiu3ACRbesmaReiaoYvWEZQ?=
 =?us-ascii?Q?bnqWbJRyiOQh1HjGInudDe1XKqdam8giV0ENA49B8iyY6UxbWutWFQ6tZWS7?=
 =?us-ascii?Q?Vbo/3WtDwr6jMONXct9GUe0imb/cHv7fIRZR064akPn9B236RWjKLogWD/cv?=
 =?us-ascii?Q?YLz06KJF1+XIrKg+pYTruqybPqAXYDb/Bbg0PLMo5/A2aIh9uGYxcdz9CPn2?=
 =?us-ascii?Q?fUeeb2L/QE4H+u0Nv5aXdxqcs5yEWCCI5T8kuBCDWA+mEr7WitrHfsQVqW6S?=
 =?us-ascii?Q?J2KMtjcopKdYemHLG/mraapJr1iM0wSy0UreQfl0N6Gx09R/2TxM+1EE/JXZ?=
 =?us-ascii?Q?DlxrG8il6KHr8m0fYG4k1STyTSPMXqsprU6J7wLTdFtjecozgbAQ8ssS7CF/?=
 =?us-ascii?Q?zM8zvKG9c7z7DQYToSzjPwWTd5Ioqa9tMnxv0Fs7g7cG0XuF21tp/bbkm4Jo?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa2bdc-93e4-4b23-bf6a-08dad9e92ee6
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 13:27:56.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35q7e6hRndha6E9NO2V4iF4J6M0vHnNOD+H0Dftj0PHUKRPo8+/jJobtF8BlNQlfV4RtvghLZtu1sOy04MkNJF8aZswWo1YOaIn7m477QOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 14:13:06 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 9/12/22 14:10, Vadym Kochan wrote:
> > Hi Adrian,
> > 
> > On Fri, 9 Dec 2022 13:53:58 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> On 9/12/22 13:39, Vadym Kochan wrote:
> >>> Hi Adrian,
> >>>
> >>> On Fri, 9 Dec 2022 09:23:05 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>> On 5/12/22 12:59, Vadym Kochan wrote:
> >>>>> There is a limitation on AC5 SoC that mmc controller
> >>>>> can't have DMA access over 2G memory, so use SDMA with
> >>>>> a bounce buffer. Swiotlb can't help because on arm64 arch
> >>>>> it reserves memblock's at the end of the memory.
> >>>>>
> >>>>> Additionally set mask to 34 bit since on AC5 SoC RAM starts
> >>>>> at 0x2_00000000.
> >>>>
> >>>> Can you explain more about how a 34-bit DMA mask works when
> >>>> SDMA only supports 32-bit addresses?
> >>>>
> >>>
> >>> So, after I set
> >>>
> >>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> >>>
> >>> then sdhc core sets mask to 32 bit, but then dma_map fails to map
> >>> bounce buffer because the base address is higher than 32bit - 0x2_00000000,
> >>> and 34bit mask fixed it.
> >>
> >> What happens if the bounce buffer gets mapped in the range
> >> 0x1_00000000 to 0x1_ffffffff ?
> >>
> > 
> > From my understanding, on the AC5 SoC RAM starts at 0x2_00000000 so the bounce
> > buffer can be mapped in the range 0x2_00000000..0x2_ffffffff
> 
> Right but I guess I meant what about 0x3_00000000..0x3_ffffffff ?
> Isn't that also in DMA_BIT_MASK(34)

Yes, you are right.

> 
> > 
> >>>
> >>>>>
> >>>>> Co-developed-by: Elad Nachman <enachman@marvell.com>
> >>>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
> >>>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >>>>> ---
> >>>>>  drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
> >>>>>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
> >>>>>  2 files changed, 40 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> >>>>> index 08e838400b52..5f3db0425674 100644
> >>>>> --- a/drivers/mmc/host/sdhci-xenon.c
> >>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
> >>>>> @@ -13,7 +13,9 @@
> >>>>>  
> >>>>>  #include <linux/acpi.h>
> >>>>>  #include <linux/delay.h>
> >>>>> +#include <linux/dma-mapping.h>
> >>>>>  #include <linux/ktime.h>
> >>>>> +#include <linux/mm.h>
> >>>>>  #include <linux/module.h>
> >>>>>  #include <linux/of.h>
> >>>>>  #include <linux/pm.h>
> >>>>> @@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
> >>>>>  		return pltfm_host->clock;
> >>>>>  }
> >>>>>  
> >>>>> +static int xenon_set_dma_mask(struct sdhci_host *host)
> >>>>> +{
> >>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >>>>> +	struct mmc_host *mmc = host->mmc;
> >>>>> +	struct device *dev = mmc_dev(mmc);
> >>>>> +
> >>>>> +	if (priv->hw_version == XENON_AC5) {
> >>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> >>>>> +
> >>>>> +		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> >>>>> +	}
> >>>>> +
> >>>>> +	return sdhci_set_dma_mask(host);
> >>>>> +}
> >>>>> +
> >>>>>  static const struct sdhci_ops sdhci_xenon_ops = {
> >>>>>  	.voltage_switch		= xenon_voltage_switch,
> >>>>>  	.set_clock		= sdhci_set_clock,
> >>>>> @@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
> >>>>>  	.reset			= xenon_reset,
> >>>>>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
> >>>>>  	.get_max_clock		= xenon_get_max_clock,
> >>>>> +	.set_dma_mask		= xenon_set_dma_mask,
> >>>>>  };
> >>>>>  
> >>>>>  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
> >>>>> @@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
> >>>>>  	xenon_disable_sdhc(host, sdhc_id);
> >>>>>  }
> >>>>>  
> >>>>> +static int xenon_ac5_probe(struct sdhci_host *host)
> >>>>> +{
> >>>>> +	struct sysinfo si;
> >>>>> +
> >>>>> +	si_meminfo(&si);
> >>>>> +
> >>>>> +	if ((si.totalram * si.mem_unit) > SZ_2G)
> >>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> >>>>> +
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>>  static int xenon_probe(struct platform_device *pdev)
> >>>>>  {
> >>>>>  	struct sdhci_pltfm_host *pltfm_host;
> >>>>> @@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
> >>>>>  		}
> >>>>>  	}
> >>>>>  
> >>>>> +	if (priv->hw_version == XENON_AC5) {
> >>>>> +		err = xenon_ac5_probe(host);
> >>>>> +		if (err)
> >>>>> +			goto err_clk_axi;
> >>>>> +	}
> >>>>> +
> >>>>>  	err = mmc_of_parse(host->mmc);
> >>>>>  	if (err)
> >>>>>  		goto err_clk_axi;
> >>>>> @@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >>>>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> >>>>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> >>>>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> >>>>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
> >>>>>  	{}
> >>>>>  };
> >>>>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> >>>>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> >>>>> index 3e9c6c908a79..0460d97aad26 100644
> >>>>> --- a/drivers/mmc/host/sdhci-xenon.h
> >>>>> +++ b/drivers/mmc/host/sdhci-xenon.h
> >>>>> @@ -57,7 +57,8 @@ enum xenon_variant {
> >>>>>  	XENON_A3700,
> >>>>>  	XENON_AP806,
> >>>>>  	XENON_AP807,
> >>>>> -	XENON_CP110
> >>>>> +	XENON_CP110,
> >>>>> +	XENON_AC5
> >>>>>  };
> >>>>>  
> >>>>>  struct xenon_priv {
> >>>>
> >>>
> >>> Regards,
> >>
> 
