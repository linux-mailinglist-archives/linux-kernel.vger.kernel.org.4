Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3BD64CE69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiLNQyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbiLNQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:54:04 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC11205D4;
        Wed, 14 Dec 2022 08:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP/WRTryRPCPxsxa8uK7QQSLor12giddkzIcjngLBy18dIMdrBlIWT/9cPblnBPpB33dI11B0t+LXI8G91GmfXrBkGcXgWNbRD3tEJ43PooziN2yja7kyZwl0/q644WbWf7bEi1/p6A9ygQ4MZj+HylCuCYPm2APhX4iP10S/h+PseEoo0YZqBYY9903mU8eWHVlA6NcIlM1l+WeTSelDtkiiMCOYrebk7CVQkJjy2d+nb2qbBRYdyr9s+R+yQztaYzxSsehDf2a2EpE5eslReY7TcoWjktUGV7OgQq0zgySM1i/gWe0Sf2D1k+CVVP7sTzT7W4abS/+FhpsxbB7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmupLmvXBaBhUO0S6AdX0AvvVWK4Mqr5cM8gqXUJfX4=;
 b=IxYJ7yFX9BvJH3KoI9G1PedmeHH2rgTv2KN+jQ8HYu68GxnlnWc3rBxdxb1p9TkgY0Ga7upG2dahxzQPo7R241Z+fYZTYpK/OcjOosuUW2oRI1NvT43OxEGB0MIHSOaG6HzYD5EuGcRGPFVpt/QCvaCU29FlutCZLqY8FL+zAX0XqKVtT7iyPoe3zRvsHJr2Fnv+eDbyzDdh6bV2X4ekV+BpF4vcyBUMl16QKDxNmrusPk82UgLe+uB0cswMWXDPQHOSZcf4DMWCJLQ60kfFjyrbaVpr+bG6fjPrQ5ieMLhoigYSGsvhAChq11cjfph4gJrOPuIowy0DmXUsiAt0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmupLmvXBaBhUO0S6AdX0AvvVWK4Mqr5cM8gqXUJfX4=;
 b=ZqsZAX75IfNCYpyZHHI9arx3tpbjLLImfn0NGD0GIhHbsRJypuymyRVUmQGbfeaB5x5UHrDd67+cDY9r79dPgjPflQXyBKholgUneVEFdkjImuxZRzKMxtsbT6mOfwJxMOwUxM+1ABxOjRAT6um368atEgrfUHN2TPLF0EjCCDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 14 Dec
 2022 16:53:59 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b%7]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 16:53:59 +0000
Date:   Wed, 14 Dec 2022 18:53:56 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [RFC PATCH] arm64: dts: ls1028a: mark ARM SMMU as DMA coherent
Message-ID: <20221214165356.6tbzmfyoifqt4cwk@skbuf>
References: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
 <2a188b8a-ab16-d5d4-ed5f-f8eec236e4ca@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a188b8a-ab16-d5d4-ed5f-f8eec236e4ca@arm.com>
X-ClientProxiedBy: BE1P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::15) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AM8PR04MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: ab656a7e-e5ac-4552-6848-08daddf3cbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu4HkVxFb+ztPXpDmji3mVwBqPjFVjjGUd4vJqhHDADqpZvh+K/XYfohg+uPZ7RIqMe8DT9ECfnNIwlf4rzoYIN0qMGAONwtVXKxoAYIIY82AWElI0YcIKGkF+3Ner3uGfVEhxhSlYZOXWdW27NhewQCFQiCdPvet9Bj2kYI3F7G6HMOHHltd0FMKJV5p8T9pIV1F9PIa/x28Kv/sfmZeY+m8p7NXGmj7EaVpuy8rdiYDWf4Xh4p/G9wr0RdAVwLVECHfKQrYTtCcf0VdwrCSshbhUHUFTzlEtAOn1rqdHTEylDurnC/mTlg7cl5Z0e/C+jl5NrexiVRyJIUCqZBTrX+YRgmSP4ipj9PYf7m0LV1pNEKGqMefyDCMDKpfm0TDIniPceTyT1G6gr7BcSW4oP2cWAAUzfmOCfyhe1u02WEgj0FHpV7TpqTwfn6Grf75WgJItwcPJDK67E7sBY8EK8V6ccO2cbFM7GJHwM6nXlLo+YxsyRGT5OFGQ6YybPn7Cxa+VknFO6sWG8TYBsnGpWMC31CVipUNubQMQtl20EZafUrPQEl9/WLO97HfJE95UsWYOX4Nq2mLrFmo3Ll/bvB3V5akTF02qR6ms9YMpfDP8Y0pRO1m1kAZUM/DWPicnUZrkryDf6iUkDN+tonp0iHlDasuz5+v5/HLEGvOForbCN3xLBkY5MuKABvtFPbnSnthwyWqe9P0W3bGzOQ0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(83380400001)(1076003)(86362001)(7416002)(38100700002)(5660300002)(8936002)(41300700001)(44832011)(8676002)(966005)(6666004)(33716001)(6486002)(6506007)(66476007)(9686003)(6512007)(66556008)(478600001)(66946007)(186003)(26005)(54906003)(6916009)(316002)(4326008)(2906002)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NI8u0ui4MksRWgeseFKsjihZgnLsj6myxYj3PVX0WwcA7oIt12KaSlVWiiXW?=
 =?us-ascii?Q?kfxeIngX2sEoSQY+Br655aCAD4rFaZ0o4fhBtWQWsZn791qgjVHhU16Zn0mj?=
 =?us-ascii?Q?L1qzPKW0BS2uZ72C8/hrs3WlqL5xOMIxNnKbf1XX/sV9bWY4ZojgOB2Mm2Cx?=
 =?us-ascii?Q?LEOmRi4j1/8NO1AMdR3BIS79S2Wud6R9BR7nAbz+tqRq7TIYIA9LBWmqLOrC?=
 =?us-ascii?Q?Bwk107IfQ9BAk7Ab7+PgK0HGbXbOCPXImEBgc8GyMiwwMJq5CJDDxbOXYZUo?=
 =?us-ascii?Q?se4OIGkZXZUbwdRAk0SHSp+5wseeNowM2vgtsMFu9TX8rdWYPtq5StCtTxq1?=
 =?us-ascii?Q?c+8zzF8euOuyBuT1OLjnPsA7I01qY0VmvMDpb+RV2Uene8YXiw/0E7h54CQj?=
 =?us-ascii?Q?KcX2ciL4h4boh+yhid+duAF1k1VbDfVAyfo7tXXv1/wzhSQQRFmqCw7F2gnN?=
 =?us-ascii?Q?XVtgEknZ/u4GWSHfo35J5an8LprD+caZOEO/yCVtnerqz1gBBV/w2p+pxtxq?=
 =?us-ascii?Q?3E9X7FWoHft8C81+JL0oXSDJeIAVnq0S9N5shVP4D9uquVrIJLLaH9/BvLG0?=
 =?us-ascii?Q?p79IVZ9t/d1QeASWBpK68+6k8ths9QPOF0gGupzn0Lsuuh3UFVXgk7bYOkOz?=
 =?us-ascii?Q?TsEDFml/hYn/VBTXFSXU1Ze4T34SKBQBjq+9oAIU7KxPA5OFwGxasWgHDiuy?=
 =?us-ascii?Q?/HTWASY0EIfgB+7iv2Gl+/jdORzzEVRE5Sn7VjhZfpjrZzzohf7duZLaa/6W?=
 =?us-ascii?Q?P6Q0dDbZJt2m+ZAp35sN5+5REdk39E/qyxpM0LCe2uj7JmVsclSnJ9QBaEEE?=
 =?us-ascii?Q?SoNS9RuJeU2FLUZ5kLvLaVGls+eY6vemVeuQagJ7kfNnfWKlfMJRJET8Cnbi?=
 =?us-ascii?Q?3ofdxFNNCruUxmXv5/f3Z1LL+ztpuxFvEUYw35FWc7xSJrnDaea8amNz9YZQ?=
 =?us-ascii?Q?FDlvETJsuWjC4sdXxqFtLaWBn4b7MHuJBG3BLbQm6N/isPH7U7Y/Dz+Uejzs?=
 =?us-ascii?Q?jTErddTY1Hk6UilZj030gsWLV8MUXDlwKAI+7XIGwT/B980RHqUSq4HVSIw4?=
 =?us-ascii?Q?CFEbeGJlyd61WbgjOiAq0UzcsGliP/dy2GQNpF/5nGDYurS48CTzw0ISTN0f?=
 =?us-ascii?Q?0DAfXuX+HkIh2rKS/+QDRTuqAVFYzY4WNAZtv/stskpMsv8BJPXaA815q4/h?=
 =?us-ascii?Q?25jpk+nbDWYHvMLxNmTHkEGMp3vj7cw9kjcRUhy/TH4ykr8TdwjdzsvWQ0Mr?=
 =?us-ascii?Q?ryCvL7qsZvEy79huWZOtDo4doTEcN594jzUucy+8zULJS+rupZaST+pzEaQW?=
 =?us-ascii?Q?GpxMziiIaP1qPmsSKciZ3ydUQchRThqY6JmN3bqF49V0B/vs5sc+kAhATVRX?=
 =?us-ascii?Q?VrBJmV1KpCcMo9VDQwQ+C1jPj4+fCz9j1Qa6t2hF7lU3Vf2UFsxni3o1k4PS?=
 =?us-ascii?Q?bQrnQFKo9dUT/vWt1OLqdL4AbnWE2DAU02g6Da02SJ4pRn6m2ofrCRsp3orh?=
 =?us-ascii?Q?CBvBZ3pWUdOOh2nMJt/x6kwssyC8Odf9CvadP2P5N1JrqHGS31TQdqw0JPkB?=
 =?us-ascii?Q?gkPcRzQcySjQX2v5UEF+7Q6J2Bx1Jm1vlXpcVdbe9fHszY5cmzX3IsHFg3f5?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab656a7e-e5ac-4552-6848-08daddf3cbd1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 16:53:59.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7YV7F9V/d+lIfp4kzcqoDDXXzDRS/OrSYdu2VstWq1GExIs6Q+3Wov1ZPDvbhr1WqgH2oa1gjsF9q3QoNSyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Thu, Dec 08, 2022 at 07:01:16PM +0000, Robin Murphy wrote:
> It's more just good fortune that it ever worked properly at all.

Thanks for the response. I don't know much about IOMMUs or the ARM SMMU,
I'm trying to understand what you've said. I hope you don't mind a few
foolish questions.

> We have to make the DT authoritative about coherency because cases exist where
> the ID register is misconfigured.

Which ID register? The ARM_SMMU_ID0_CTTW bit in ARM_SMMU_GR0_ID0, as
read by arm_smmu_device_cfg_probe()?

I tried to find more about this bit (driver suggests it's bit 14), but I'm a bit lost.
First of all, I don't know where to find the ID0 register for MMU-500.
I looked at the register summary here and didn't find it:
https://developer.arm.com/documentation/ddi0517/f/programmers-model/register-summary/global-address-space-0-registers-summary?lang=en
Then I googled it and found this page, where it just says that at bit 14
there's indeed something named CTTW (unexplained) which is hardcoded to 0:
https://developer.arm.com/documentation/ddi0517/e/programmers-model/memory-model/reset-values?lang=en
I did however download the SMMU v2 arch spec PDF at
https://developer.arm.com/documentation/ihi0062/latest

and there, I did find it. But I'm not sure why the MMU-500 says it
*should* be hardcoded to 0? Is this what you call "misconfigured"?

On my hardware (both LS1028A and LS1088A), it reads:

$ dmesg | grep smmu
[    4.825109] arm-smmu 5000000.iommu: probing hardware configuration...
[    4.831625] arm-smmu 5000000.iommu: SMMUv2 with:
[    4.836293] arm-smmu 5000000.iommu: GR0_ID0: 0x7c013e80
[    4.841569] arm-smmu 5000000.iommu:  stage 1 translation
[    4.846931] arm-smmu 5000000.iommu:  stage 2 translation
[    4.852293] arm-smmu 5000000.iommu:  nested translation
[    4.857573] arm-smmu 5000000.iommu:  stream matching with 128 register groups
[    4.864776] arm-smmu 5000000.iommu:  64 context banks (0 stage-2 only)
[    4.871372] arm-smmu 5000000.iommu:  Supported page sizes: 0x61311000
[    4.877868] arm-smmu 5000000.iommu:  Stage-1: 48-bit VA -> 48-bit IPA
[    4.884375] arm-smmu 5000000.iommu:  Stage-2: 48-bit IPA -> 48-bit PA
[    4.893113] arm-smmu 5000000.iommu:  preserved 0 boot mappings

On the other hand, in the verbal (no registers) documentation of the
MMU-500 integration in my SoCs, it does say that "The SMMU supports cache
coherency for page table walks and DVM transactions for page table cache
maintenance operations."

Does looking at the CTTW bit make any sense for MMU-500?

> You've been telling Linux that that is the case, and now the message
> is finally getting through to VFIO. If we weren't also lazy in
> io-pgtable-arm about what shareability attribute to use for IOMMU_CACHE,
> you would have actually had the broken VFIO behaviour that that check
> is now defending against.

lazy in io-pgtable-arm == ??

I assume you're talking about something which is (not) done in
arm_lpae_prot_to_pte()? Could you please clarify, as I didn't understand?


IIUC (and I've been wrong before), the IOMMU_CACHE "prot" flag means
that memory mapped by the IOMMU for DMA is coherent w.r.t. CPU caches,
and VFIO specifically needs it because:

	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
	 * restore cache coherency.

i.o.w. user space can't execute cache invalidation instructions (DC CIVAC etc),
which would make cache-coherent DMA transactions the only viable possibility.
Right?

> I'd argue that you do want to make the DT change, because it's the truth
> of the hardware. Even if you did want to keep doing the significant
> extra work of maintaining non-coherent pagetables (there is a dubious
> snoop latency vs. TLB miss rate argument), that would be better achieved
> at the level of the io_pgtable_cfg, not by lying about the entire SMMU.

I do agree that we could set the dma-coherent property in the SMMU node
to skip some of the wmb() instructions in the TLB invalidation procedures
for stage 1/stage 2 translations. I wasn't trying to make any argument
in favor of manually maintaining the cache coherency with the page tables.

I'm just not exactly clear what does the page table walk of the SMMU TCU
have to do with the cache coherence of the DMA transactions forwarded/translated
by the TBUs. I mean, I saw the comment below:

	/* Assume that a coherent TCU implies coherent TBUs */

but I simply don't understand what is it that gives this assumption any
grounds.

> However, since Jason refactored things at the VFIO end too, it looks like
> this should now be consistently checked for every individual device
> bound to a VFIO driver, so we might be able to do a bit better, as
> below.

hmm, the change in vfio_group_find_or_alloc() between iommu_capable(dev->bus)
and device_iommu_capable(dev) took place in commit a9cf69d0e7f2 ("Merge
tag 'vfio-v6.0-rc1' of https://github.com/awilliam/linux-vfio"), says my
git blame. Pretty strange. I had to use git log --graph to find your
commit specifically: 3b498b665621 ("vfio: Use device_iommu_capable()").

> I'd be rather surprised if anyone ever genuinely built this
> topology, but it does happen to be the one other combination that's easy
> to infer with reasonable confidence.

this topology == ?
non-coherent SMMU page table walks but cache coherent DMA traffic of
SMMU upstream device?

Feasible or not, VFIO doesn't have a problem working with that device
even if the SMMU doesn't do coherent walking of its translation tables,
no?

> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 30dab1418e3f..a5ad9d6b51cf 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1320,7 +1320,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		/* Assume that a coherent TCU implies coherent TBUs */
> -		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
> +		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK ||
> +			device_get_dma_attr(dev) == DEV_DMA_COHERENT;

So this works for enetc, thanks. However, do we need to also consider
handling DEV_DMA_NOT_SUPPORTED, and thus, testing != DEV_DMA_NON_COHERENT
could be better than == DEV_DMA_COHERENT?

But from your response and the explanation in commit df198b37e72c
("iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY better"), I'm not
clear why we would keep looking at the COHERENT_WALK feature at all?

It seems to my layman eyes that we are artificially coupling 2 concepts
that have nothing in common, and bad reporting for one of them is
causing trouble with the other.

>  	case IOMMU_CAP_NOEXEC:
>  		return true;
>  	default:

Thanks!
