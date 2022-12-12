Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8164649E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiLLLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiLLLjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:39:47 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2137.outbound.protection.outlook.com [40.107.7.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965C13FBF;
        Mon, 12 Dec 2022 03:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYBHHA0ekOuU/7/imN1iKVk+jXBi0Bb83Rfs/pnCSgGTsNxJkvqtOIs6B+rEPd+dOwouCgfFmKlXp3cIwQPEBe7IYQismtDP+yAl4DikHxVXky5qRwCR2iIMBN4XLKxFQqjEjG9huGmfr2no9FJCz2JGUr+YVaSZNpkRoYSBzeXsULnRchS2VUa3OT0VIoOJyBzYuvhjugvpxDbCEl1uGvgi/YnPSTSBvEijILLfxBwPALfK8mDva7n8WVYHGi2NvvSl9hKUV710KPef72rtbSrPVHTMMI6Dh1Ji/H/x5/BRAwm1UXIVpy/PrY6nn/VRmNnHRhrzpL4cMp5k/n3mUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MShXleVe0LY5//x9pDMcpRh1tkvfQZWJBMjIxEuHUCo=;
 b=OtwYQeIGDEKY0mPlaf4hU+Sk1sZFGu4k7mmOFfeTDua3A1qRolqu2y7mfXgys4B0ATUY84yA9lmWsu3IBZipe7ZVW4hXstq7LcMg+ygk8atPBC3tG27t4wOkexVt15ERjkuiY0p6jAsYWPRYxZne0YDTzIET6BZRG0wqZPXiyxWr5WrsCYVoaNTSvYFiv7vCqJ+CmCzt4wCNSgoTI5HuCJvEzJyd4CIJ8BnRyNiUUv45RQry96u9Cl0Y/gDOrWj1UkRskaxxo8sjcR+vYBF5Du/Az6Q2eQtmfQUiJA0FtGLNcCAxtFCakGv8FwqgMr84GxfLwWmtNu0GNvCLN1NjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MShXleVe0LY5//x9pDMcpRh1tkvfQZWJBMjIxEuHUCo=;
 b=L51EzWwjfNWgRkzGM8aX9q6x9Cdg+wM0Q7fd6GgQfZKuG72KIQ+w6nn+8Suc9+BOrZG8eWOuUPu4WXDtGnUEBwBUttw1TqO/QbUiT6T1pnX9OonA27hc5/pjmTSOFVYpHCLpRB0mqXWWLvdV7wBOW+KpVsdhEhgW/J/8vnx5MBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM7P190MB0744.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 11:34:02 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 11:34:02 +0000
Date:   Mon, 12 Dec 2022 13:34:00 +0200
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
In-Reply-To: <44f642bc-8810-80d9-368a-15994de7f50d@intel.com>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
        <20221205105931.410686-4-vadym.kochan@plvision.eu>
        <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
        <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com>
        <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com>
        <VI1P190MB0317DADE7450282444BFED32951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <44f642bc-8810-80d9-368a-15994de7f50d@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB03171A8F65844DB789D85B0495E29@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM7P190MB0744:EE_
X-MS-Office365-Filtering-Correlation-Id: baf913eb-7ab7-4611-da30-08dadc34c478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KA+0ltXBJ5gUzoq0VFOS6GsE897UKlKqqOGDO+VEyYaTh4aZNpIojzqPQ1Aqnax9b34YLoBV+Pkdlgq/y6H37lXKNXh+ZhCo2bt/rS0vPYexQIyxuz49mEbQdhZtGqifEcyJl/Sbrc31rXPzKDtk5i/YaTvkS7ML1boBsAprd+lcau4Hdn+51rpvilfFZM+QiulxZcTvjTGcVLpo2hOFmcWPuYfIsyEYBBpyV6hqp1lyKXI+vXgxXgMkMtGG66Cwv7Y0dLd3lIf/I7OUJWmRraL5wC8r1TMaG1IJQe3WBZmZz4hO2Dme5mrhjnME9t1GJxD1CA2iFvtneIXuMNIaOQcQgFElNs+mQac6r/vDcQ70gRx1As34gFNpxykSOHNiF+U/n/G0myUTWVho2DoQShSazbrqvxph40YJZZwMgrP54R7tdm8EXi36XztSt5gDnoZvyVfXt6FnAE7YXvuz6/CYm1Bwopc1/ngh1rLYAlOPvZ/f/UpBgbhE95QAx6/+gXLJzsh/oOih1L/jG26jg5xaStC6tyThcLyXLMG9cBN6Ti+Koq2IiLH7k0JcQTU9obujMybGsi6fphHVPMNOoTW/wxn0+kcJ9+O6d/KregSvH8VC5iTebfMxSGSjhpVoMrfAtmNp5xz/UJEp7UkbfylBa78tT9BdGJERYGYJK4OmvydffZBaO6ya8HnfW4hOsI+DGqiY0v1xvfkkknciqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(52536014)(8936002)(7416002)(2906002)(44832011)(83380400001)(186003)(8676002)(478600001)(4326008)(66476007)(38350700002)(66556008)(38100700002)(66946007)(6506007)(110136005)(316002)(7696005)(54906003)(9686003)(55016003)(26005)(53546011)(33656002)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v5MXvEvYost4+tuV8SwvBdMHW+bsEz7sGFHfnZHmXWzpLMhcHo4mzXxEkFeI?=
 =?us-ascii?Q?/EC9HvEsHI43NSI23B5ljdjwW6BjH4zmss/VMXkaBbmQEsxSA4h1VXt9kcxj?=
 =?us-ascii?Q?UlvXP7+nCEMo/Amj89aikDBUIBME/Jqf8zQ6jJgvPV97AyKx6vhRjVAC0xXk?=
 =?us-ascii?Q?hE7ZKXvsw4yk94AQfaQ4Pio1dpThHoOGUK+3oMAFRF21GwxTQHfBbPwijlUk?=
 =?us-ascii?Q?OEyuy9mu2o+6s5nRcjK6HcVAIVXdDSyFqEoepGIDqpAEpN9dto6L/+UIYXKz?=
 =?us-ascii?Q?hiFaDB8NoM0G5c9nXJWyKQajbOvR9Vf7pPCecHEphcepYoRXFzLO32r9taWg?=
 =?us-ascii?Q?qDt8YyjOa25sItwbKo4AlC07Ga1V2RHjHEOvLO3BeCf2LbqBOKYCkEAV9AjI?=
 =?us-ascii?Q?cHJH7T/+7dHXqituPc5NoGMHl6fNfWJaWeFGmWGmf381QRAoF/kRJSedrufI?=
 =?us-ascii?Q?9iI4S13FbRmrsIpl1Tlj6zvgAFuYV5GIWF7nvhSpvAi1Fh81nsA7849rZfF/?=
 =?us-ascii?Q?6xE9BSC79du7ZPHRMYGFUDEkN64vn+oGhrsE59m620rLt4UcIPjEqXbMq9uQ?=
 =?us-ascii?Q?gFrfUcSZ9gGgADcCq4DGk7X2Y9JZWxwb3JiksUdtr+FGBbYIBC027IdMEF2K?=
 =?us-ascii?Q?HZtku/pDPObH2kTKlRcywc+M0mnoIjas3tSfyDQ7FAj3n0m7qU1JLOL2iCx2?=
 =?us-ascii?Q?CyzEZF6vt9SVOqd3v7GCdbUt6YNkp5vAMr+69ZutOLIGiVx3eNFFl+1Q/oKo?=
 =?us-ascii?Q?X1N61LNodpwlqA2vH8cSMi2wsIno7fQPXc/q/v0BOrce7MCsa/9zlow7Bemf?=
 =?us-ascii?Q?vfr/AedDKgOO4M9QwRDtim8KyCIcq0Q+aGMhfhFAPlm0eWIhRQrRa0zP/9V2?=
 =?us-ascii?Q?xOuKaF9o4gkH9lEUluSzjWJF6ENoIKf/j+XfHSuX9wLKF3N4E6gOaudolxev?=
 =?us-ascii?Q?PjSHTVWGZmxuIwpkA23ZYGvC72chwlYIiPiEBqgnvbQzURSjWEQ7MmBxLx4b?=
 =?us-ascii?Q?1f63hbhvgUx1uR2dIRYabr7VI/0hOSgq7CTGoPOMm5mK8Sr3xKc+lyufOKpH?=
 =?us-ascii?Q?vYDeDUQrYlT63z+FAO8Th1TlwZhzim6jYonYtNxr2g8AikRVxLE5i5ZKUKX9?=
 =?us-ascii?Q?EJF2lQ1W1O8lLW1loW+Cje485/TOk0maUXu5sP22/mHWGsE1v6W66tRZAyD7?=
 =?us-ascii?Q?RKkDFF/dRBxSPhbbtYEb51AmodebbSqsqI1llFsll+SJpkwRXxAhjOQkxUkZ?=
 =?us-ascii?Q?DLvQpwhirDv1KZ3rhZYJsfglsHvPVN3kFD6dFTJUbzWmlAm53RMpWwuEV8d9?=
 =?us-ascii?Q?I+DgMN45Iagn4hd493MDhIGbDOA96TGmdUlVn39ZLy2OjJFbySJts4pmmFiq?=
 =?us-ascii?Q?TTRnetmJwUHmSMokKxBTLrwYMxvzqO5mXV/j+tj16Em5TLD+bAcMIa2naEAR?=
 =?us-ascii?Q?FkQDmQkXygs96scn6NWRQE9v34U63v4kZUrawtU/jXCzEREZaTvfFcX9OfZY?=
 =?us-ascii?Q?MFeteSZayw7VJaFd743QihSoO2qCsqgcU3aqOPzSdyLGvq5yxZoXV70Vxq/G?=
 =?us-ascii?Q?6fPfc+iPhvC7/ITUYYcg72XGbzTxXH7LV4rztKioh/rgsRAhF0Ym2gtmCpz8?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: baf913eb-7ab7-4611-da30-08dadc34c478
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 11:34:02.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evNk9dMjrJVDw30Eax53Ji570AVOcYrOUBlKwPwbVggWJ7oZ443Xm5VPi22WCiOf4rNX0dyU4g6fZIw4rk4xbIqdiM6eZ8AE02edw7uNCH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0744
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

On Mon, 12 Dec 2022 10:42:36 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 9/12/22 15:27, Vadym Kochan wrote:
> > On Fri, 9 Dec 2022 14:13:06 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> On 9/12/22 14:10, Vadym Kochan wrote:
> >>> Hi Adrian,
> >>>
> >>> On Fri, 9 Dec 2022 13:53:58 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>> On 9/12/22 13:39, Vadym Kochan wrote:
> >>>>> Hi Adrian,
> >>>>>
> >>>>> On Fri, 9 Dec 2022 09:23:05 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>> On 5/12/22 12:59, Vadym Kochan wrote:
> >>>>>>> There is a limitation on AC5 SoC that mmc controller
> >>>>>>> can't have DMA access over 2G memory, so use SDMA with
> >>>>>>> a bounce buffer. Swiotlb can't help because on arm64 arch
> >>>>>>> it reserves memblock's at the end of the memory.
> >>>>>>>
> >>>>>>> Additionally set mask to 34 bit since on AC5 SoC RAM starts
> >>>>>>> at 0x2_00000000.
> >>>>>>
> >>>>>> Can you explain more about how a 34-bit DMA mask works when
> >>>>>> SDMA only supports 32-bit addresses?
> >>>>>>
> >>>>>
> >>>>> So, after I set
> >>>>>
> >>>>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> >>>>>
> >>>>> then sdhc core sets mask to 32 bit, but then dma_map fails to map
> >>>>> bounce buffer because the base address is higher than 32bit - 0x2_00000000,
> >>>>> and 34bit mask fixed it.
> >>>>
> >>>> What happens if the bounce buffer gets mapped in the range
> >>>> 0x1_00000000 to 0x1_ffffffff ?
> >>>>
> >>>
> >>> From my understanding, on the AC5 SoC RAM starts at 0x2_00000000 so the bounce
> >>> buffer can be mapped in the range 0x2_00000000..0x2_ffffffff
> >>
> >> Right but I guess I meant what about 0x3_00000000..0x3_ffffffff ?
> >> Isn't that also in DMA_BIT_MASK(34)
> > 
> > Yes, you are right.
> 
> So it would fail in that case?  Is it possible to use devicetree
> reserved memory or some such, to set aside 64k for the bounce
> buffer DMA mapping?
> 

The main restriction is that only lower 2GB can be used for DMA.

I already did send solution based on reserved memory, I can send it again in context of this series.
Also what about the solution which Linus suggested ?

[cut]

Let's just create a new quirk:

SDHCI_QUIRK_31BIT_DMA_ROOF

Define the semantics such that this will allow DMA for buffers that are below
the 31st bit, but does not have the semantics to limit scatter-gather buffers to
be 32-bit aligned.

[/cut]

Thanks,

> > 
> >>
> >>>
> >>>>>
> >>>>>>>
> >>>>>>> Co-developed-by: Elad Nachman <enachman@marvell.com>
> >>>>>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
> >>>>>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >>>>>>> ---
> >>>>>>>  drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
> >>>>>>>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
> >>>>>>>  2 files changed, 40 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> >>>>>>> index 08e838400b52..5f3db0425674 100644
> >>>>>>> --- a/drivers/mmc/host/sdhci-xenon.c
> >>>>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
> >>>>>>> @@ -13,7 +13,9 @@
> >>>>>>>  
> >>>>>>>  #include <linux/acpi.h>
> >>>>>>>  #include <linux/delay.h>
> >>>>>>> +#include <linux/dma-mapping.h>
> >>>>>>>  #include <linux/ktime.h>
> >>>>>>> +#include <linux/mm.h>
> >>>>>>>  #include <linux/module.h>
> >>>>>>>  #include <linux/of.h>
> >>>>>>>  #include <linux/pm.h>
> >>>>>>> @@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
> >>>>>>>  		return pltfm_host->clock;
> >>>>>>>  }
> >>>>>>>  
> >>>>>>> +static int xenon_set_dma_mask(struct sdhci_host *host)
> >>>>>>> +{
> >>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>>>>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >>>>>>> +	struct mmc_host *mmc = host->mmc;
> >>>>>>> +	struct device *dev = mmc_dev(mmc);
> >>>>>>> +
> >>>>>>> +	if (priv->hw_version == XENON_AC5) {
> >>>>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> >>>>>>> +
> >>>>>>> +		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> >>>>>>> +	}
> >>>>>>> +
> >>>>>>> +	return sdhci_set_dma_mask(host);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  static const struct sdhci_ops sdhci_xenon_ops = {
> >>>>>>>  	.voltage_switch		= xenon_voltage_switch,
> >>>>>>>  	.set_clock		= sdhci_set_clock,
> >>>>>>> @@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
> >>>>>>>  	.reset			= xenon_reset,
> >>>>>>>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
> >>>>>>>  	.get_max_clock		= xenon_get_max_clock,
> >>>>>>> +	.set_dma_mask		= xenon_set_dma_mask,
> >>>>>>>  };
> >>>>>>>  
> >>>>>>>  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
> >>>>>>> @@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
> >>>>>>>  	xenon_disable_sdhc(host, sdhc_id);
> >>>>>>>  }
> >>>>>>>  
> >>>>>>> +static int xenon_ac5_probe(struct sdhci_host *host)
> >>>>>>> +{
> >>>>>>> +	struct sysinfo si;
> >>>>>>> +
> >>>>>>> +	si_meminfo(&si);
> >>>>>>> +
> >>>>>>> +	if ((si.totalram * si.mem_unit) > SZ_2G)
> >>>>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> >>>>>>> +
> >>>>>>> +	return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  static int xenon_probe(struct platform_device *pdev)
> >>>>>>>  {
> >>>>>>>  	struct sdhci_pltfm_host *pltfm_host;
> >>>>>>> @@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
> >>>>>>>  		}
> >>>>>>>  	}
> >>>>>>>  
> >>>>>>> +	if (priv->hw_version == XENON_AC5) {
> >>>>>>> +		err = xenon_ac5_probe(host);
> >>>>>>> +		if (err)
> >>>>>>> +			goto err_clk_axi;
> >>>>>>> +	}
> >>>>>>> +
> >>>>>>>  	err = mmc_of_parse(host->mmc);
> >>>>>>>  	if (err)
> >>>>>>>  		goto err_clk_axi;
> >>>>>>> @@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >>>>>>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> >>>>>>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> >>>>>>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> >>>>>>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
> >>>>>>>  	{}
> >>>>>>>  };
> >>>>>>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> >>>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> >>>>>>> index 3e9c6c908a79..0460d97aad26 100644
> >>>>>>> --- a/drivers/mmc/host/sdhci-xenon.h
> >>>>>>> +++ b/drivers/mmc/host/sdhci-xenon.h
> >>>>>>> @@ -57,7 +57,8 @@ enum xenon_variant {
> >>>>>>>  	XENON_A3700,
> >>>>>>>  	XENON_AP806,
> >>>>>>>  	XENON_AP807,
> >>>>>>> -	XENON_CP110
> >>>>>>> +	XENON_CP110,
> >>>>>>> +	XENON_AC5
> >>>>>>>  };
> >>>>>>>  
> >>>>>>>  struct xenon_priv {
> >>>>>>
> >>>>>
> >>>>> Regards,
> >>>>
> >>
> 
