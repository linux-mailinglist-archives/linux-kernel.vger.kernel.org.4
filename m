Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853266481DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLILjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLILjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:39:32 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D941571B;
        Fri,  9 Dec 2022 03:39:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkV6Etz+lBXxE1S07eILCbbMdfEWhZk/sNSmRMF18TCF8sxL7AFfFxUn/iSpajXWoBCPbmZxoiY2V2yv/zEx7vOKIaCJQaQo0XEifY+CaJOo+OqiLSf5PcScQY7Z95evycpuyMlgGuUL489TjQkteS0hTgvNLAHVtOrk0X3AFu1cg9Wu6Ln3a0pxSLKH6B0Kw9w+7F624V25xRuycffg30b8i2nUObTibgzD6BQwVPiylNsUp27jtpv+MG+V6b9XLru5+ad3D6DZXEQuw2jhHg1gM72kAg1frQxyh9gHq2/3KNvc1GAdqN6DJ23g7lw67/R1WB0wQy0dWOQwLL8q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58x0xvWKLpWU0kWb0P9AGkSqQ49P8MYNapB5m/yvY1U=;
 b=CXoIT2erFfR25w+fOTJRKjcp3oevUQ3/iww2hOrTKg1qzT5ySXqK28shz0Pa4NyZaGvDDy1a/3x9cInv9RB/AHytK6USJGuhQk4ZSuk37fS+7SlLsUnoVDxVHl0UqSPd/0f7gvyYzGLvUaRP28rXTSpRe1YHj9AH2qKMBOxmqd53bw7PXUDs39I+mSPoVBv7X34nuJ86q6jxBCt2ONTnvARknPCws4MuJkf2p3NOBqU7vNQlZaSsQxwEIk1ZvFjBE7S6xlDxWBtytw5AqZXgSHlYQxAzlND63klO4ElJ286PSOkv1ZBJgza9/nZeAKzF51VkkC+BqM5Wkr5X6HdfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58x0xvWKLpWU0kWb0P9AGkSqQ49P8MYNapB5m/yvY1U=;
 b=ZculRaDMHOUlLiA1D6ZQibzx4+wSibmVvOJNsloqGj4Tno6ZRwziVqSw9KpfVK52Jyg9vP+ZAgQ/doNVPv6Qw4tcAzMgAkmhFw+o6A+iaO1+obgbbYU8sCHPaC4gc1c6L0p/FQkx3NyUXxtEphH/UMq96enyvSheM5+7Pns4h0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB8P190MB0665.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 11:39:27 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 11:39:26 +0000
Date:   Fri, 09 Dec 2022 13:39:25 +0200
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
In-Reply-To: <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
        <20221205105931.410686-4-vadym.kochan@plvision.eu>
        <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DB8P190MB0665:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bd4118-56a0-4e72-a413-08dad9da06bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31f5Ei8rHo4HCaZ0ePMF5Fi93oAmUR32sRutYd2/R8zaguCTRP8ONYE3ChPtpykFBVhx/RnDjNXRYd7HSMMTY/V9B6546crYXbA0LCHAwclkygMQcGyZqa+7OSl5RxuPtE85V2vrgAAAJwC22/4FZaidRe4ovrsyiufHssEXTGMu2Sr1GuKh7JHlV6/hg9F1skuWCkC0AAM9+UyzPyYxcDfW76YEEjZLy4TXhqdtRq5YLIWlOIGTTcvuVPI6zYOdSC0d4L2aoMyKoqCWAG2XbixSdqo2ibH9By78h0DkkbIKhj2mcoOFw5IYit704Jl2zzkESSzmfIe8eYNVVkSVEDCChptEMhUvypKfYq3/2Vy4xN8TJXlpozQ91tPoPyXSOfP9qhfcQSV4FavY9kYnpKwjNgny6opSasGNzd+lZoxoygrH+mEUmlrF9OxClmuNWUZ/PMP76VGypeMSVIhCjV/Q1dLPiRpnC2XeQXA/WuNgM62O0wsTspuw4oGDAhUL8dFRAW1wEZFG0//7oBrM7Qin4BDiVonGlc2jw1fQPaA1ETyK2WD6h9TrlsI/+jWjzHPUooGWU/jRG2NggUzjtrf6/qWRmAUA4nEKt7mBZ1lNOPTNKxQO55MaF7VNzkyxuiw73h0QzFHN803cwtx4C/6qFXZNDccG5K+K+hVpUwsuEPzjs+rKk3foYy4ieLGz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(366004)(346002)(376002)(396003)(136003)(451199015)(33656002)(7416002)(55016003)(7696005)(5660300002)(478600001)(53546011)(38100700002)(44832011)(6506007)(38350700002)(52116002)(8936002)(41300700001)(26005)(9686003)(52536014)(83380400001)(186003)(86362001)(2906002)(316002)(8676002)(66946007)(66476007)(66556008)(54906003)(110136005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h0ZUz5/s4wY2FmD1LsKNNI7xbRUb2ZfejAUXeWivOGYl4LdzBHT32w98KtO7?=
 =?us-ascii?Q?/tYh+aWaoZjJOLQHDj8KyTHD0L/PPCWmdysJQHRg9S/dMpd9uj9pNXA9apfz?=
 =?us-ascii?Q?DNat6ZUyYupSF+mcRGj1NWCkaNZBvce+8peOwEngS5K4aPosyudOTjMMRXmu?=
 =?us-ascii?Q?gcUyPMfeZ7STiS1v1//YGhyT3JEr03gAtey4Z3OMvppJ8893gCSBvR/p0OFc?=
 =?us-ascii?Q?PfU0qKuSwNxY5LtD7ipEY/AfTnQR4ZWgYh50ckuiuEiI3IvDSgSBdMbKZ/2m?=
 =?us-ascii?Q?17kKj73mzKcIRo7U6BFTsaNK4AHqFetwZBLmsH4O3scqlKMIeDQ19FMZsh6O?=
 =?us-ascii?Q?Gh6C64ZpAslC+7Xij91w3wJrnAgakhuKvD3OEN9vhk2ZbLOnxp75MpGWVE0J?=
 =?us-ascii?Q?4RrOnEmTXInYsoTSQ4lltMTnhA4J27sbvAsFbZX9yIfOtDpOboPgEh41ENRZ?=
 =?us-ascii?Q?U41pqwqwpWrGEVa4lszmFTWmA7Jst1hfy4a/vAwYJik9p5lp74S5PUA2bbRe?=
 =?us-ascii?Q?kAcW67rAOyBDSaVkDiig/gL//UXfDrd/hHIsT+pSb4WpxoQDrYl8RTUIUjs+?=
 =?us-ascii?Q?8IqXjoP5zHmi9QfJbiIuEulzoA2iVOwZV89gC1FG/JZwsUxT1o9DSDO/jmB4?=
 =?us-ascii?Q?oKVwFM1cRn0ky0ykurDifNbhnqeMzX5bOvDdTnSYUUQieg5KPszTkBkOSs+6?=
 =?us-ascii?Q?GRETAUEBoujp5ykM4kxmvSuiV7XF+sVoz5bM/5WGPYQc/SJMIE4/xS4vl3Rm?=
 =?us-ascii?Q?n16nHi6YSX6HJvbjLXabLzR2iC0J5xAWf1qfHWEEga4BNtsf+CjoEdBMmXHo?=
 =?us-ascii?Q?74hgTdklvW3YO1tW7H8tvT4NRv5uNxv3GdbYjQ+rF0EkkifiRbfnITaRothX?=
 =?us-ascii?Q?m6XHPDVs7O5beV5J6FTZ2HMItvdJdvrCCcXFVfA2axBxE2qX/FH2DbpbIVX8?=
 =?us-ascii?Q?Xp/pZBmILrq6DatN1R4rbLLs5FvyZ9DiGxn0ZNUx2U+O2+8TWJYwaLFLqSj3?=
 =?us-ascii?Q?0akvA5U7l5k0rFLDF9W28F8EXgou2/5MVShhoViqm5bBmP6xdgJNCOz/5Baa?=
 =?us-ascii?Q?AO86TratcBdoY9Z+ShRRQCHZP6Mma+OJcy8nZpAr1LlkoqCEpi6ZPMJZ676e?=
 =?us-ascii?Q?QxSe1tXbj9VzEhgxBETxFr4CLwAsUU6yg187RI96LRt2mjnjdZmlYFvjYPQU?=
 =?us-ascii?Q?IwMnOaM8IJ+qI4TM9UU7csrmOybKEqMD7jOFOpadNXDIJGG3WBrjAyk3GxoR?=
 =?us-ascii?Q?2gKer5B0p0Y8v5RWCeEpgmAPKygD7qVYd8C4qcIq2NnUTE1/3kPDA+YWtA5y?=
 =?us-ascii?Q?x4b+PrTHFLSB15r21Wv3OwrZfLsefDtyrWBDZQAXwJiSkHYYsw5tTwTEkhTN?=
 =?us-ascii?Q?CkCqszBu1dQ7c9bF1zfAwfiOalg4uG7MAJzOByWYOcpjGlDFo2KDYYkDylcH?=
 =?us-ascii?Q?e2Ta7uNXirCkQpvn4o33lq7aCKhdud2n4R3Ng2mUPGkauZKkG5y8x6BzJw5q?=
 =?us-ascii?Q?F9uvYg98Ml7XmdYHx5PGjqFoFX4LImkKrz2FiQBHbGgF8UMaQnlv7/UIPqq8?=
 =?us-ascii?Q?sq5peaqwl/rYuAscZP0pYBb1k/U8tVgcMx6EfcIVICuwVU4Od52I+aTMW5jw?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bd4118-56a0-4e72-a413-08dad9da06bd
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 11:39:26.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tm4JxbTRbX85Am6fJIa02E+KQBDF1wqLyct6kMzbuLqkEWtgCT5vItANlxR2W+W5ZHJu0JyNFM09P5oJW6/7RrEJgTDvJ1kf5vMkPaQzpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0665
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

On Fri, 9 Dec 2022 09:23:05 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 5/12/22 12:59, Vadym Kochan wrote:
> > There is a limitation on AC5 SoC that mmc controller
> > can't have DMA access over 2G memory, so use SDMA with
> > a bounce buffer. Swiotlb can't help because on arm64 arch
> > it reserves memblock's at the end of the memory.
> > 
> > Additionally set mask to 34 bit since on AC5 SoC RAM starts
> > at 0x2_00000000.
> 
> Can you explain more about how a 34-bit DMA mask works when
> SDMA only supports 32-bit addresses?
> 

So, after I set

> > +		host->flags &= ~SDHCI_USE_64_BIT_DMA;

then sdhc core sets mask to 32 bit, but then dma_map fails to map
bounce buffer because the base address is higher than 32bit - 0x2_00000000,
and 34bit mask fixed it.

> > 
> > Co-developed-by: Elad Nachman <enachman@marvell.com>
> > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> >  drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-xenon.h |  3 ++-
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> > index 08e838400b52..5f3db0425674 100644
> > --- a/drivers/mmc/host/sdhci-xenon.c
> > +++ b/drivers/mmc/host/sdhci-xenon.c
> > @@ -13,7 +13,9 @@
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> >  #include <linux/ktime.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/pm.h>
> > @@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
> >  		return pltfm_host->clock;
> >  }
> >  
> > +static int xenon_set_dma_mask(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +	struct mmc_host *mmc = host->mmc;
> > +	struct device *dev = mmc_dev(mmc);
> > +
> > +	if (priv->hw_version == XENON_AC5) {
> > +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> > +
> > +		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> > +	}
> > +
> > +	return sdhci_set_dma_mask(host);
> > +}
> > +
> >  static const struct sdhci_ops sdhci_xenon_ops = {
> >  	.voltage_switch		= xenon_voltage_switch,
> >  	.set_clock		= sdhci_set_clock,
> > @@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
> >  	.reset			= xenon_reset,
> >  	.set_uhs_signaling	= xenon_set_uhs_signaling,
> >  	.get_max_clock		= xenon_get_max_clock,
> > +	.set_dma_mask		= xenon_set_dma_mask,
> >  };
> >  
> >  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
> > @@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
> >  	xenon_disable_sdhc(host, sdhc_id);
> >  }
> >  
> > +static int xenon_ac5_probe(struct sdhci_host *host)
> > +{
> > +	struct sysinfo si;
> > +
> > +	si_meminfo(&si);
> > +
> > +	if ((si.totalram * si.mem_unit) > SZ_2G)
> > +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > +
> > +	return 0;
> > +}
> > +
> >  static int xenon_probe(struct platform_device *pdev)
> >  {
> >  	struct sdhci_pltfm_host *pltfm_host;
> > @@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	if (priv->hw_version == XENON_AC5) {
> > +		err = xenon_ac5_probe(host);
> > +		if (err)
> > +			goto err_clk_axi;
> > +	}
> > +
> >  	err = mmc_of_parse(host->mmc);
> >  	if (err)
> >  		goto err_clk_axi;
> > @@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> >  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> >  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> > +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> > diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> > index 3e9c6c908a79..0460d97aad26 100644
> > --- a/drivers/mmc/host/sdhci-xenon.h
> > +++ b/drivers/mmc/host/sdhci-xenon.h
> > @@ -57,7 +57,8 @@ enum xenon_variant {
> >  	XENON_A3700,
> >  	XENON_AP806,
> >  	XENON_AP807,
> > -	XENON_CP110
> > +	XENON_CP110,
> > +	XENON_AC5
> >  };
> >  
> >  struct xenon_priv {
> 

Regards,
