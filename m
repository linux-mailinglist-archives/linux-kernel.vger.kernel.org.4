Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B526CA7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjC0Ofn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjC0Ofl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:35:41 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7A3AAC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=TQEVb06h33yxhmY3vu7gB3cHE9jPWdXlacdCPPkILAc=; b=IwhJp
        YsIGR9unG81YdDeSnR/hdUO6PGgiMyenAT4ayTFuFiZR5n8fDLQ6iRze6QZR9WL2/eenMWYXV20le
        V+nIYlDCY3SuwUb+qszBvqR2wLHP2/HeRUQDF28DtnChs7upds7rIoWfzoQFX9I8Eq1bzWarXRGgV
        tBVJ5luBiyukT2IMGQOIffFfHd4qlfJzmdgHUstZlgu+/vLz4BH3W8wUzy2hDzw3dSJmCfZGaw+Nc
        FZnJ2uTLCIMgXHpg2kLO8D9SvQgLRRoPicS5D127FQodRFfVfLfcpQojf4jp8VH8h+D2AVeyzSEyP
        duZxbP19lR4hhQf7awKT3mZVmOHVQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pgnw8-00031z-WD;
        Mon, 27 Mar 2023 15:35:06 +0100
Date:   Mon, 27 Mar 2023 15:35:04 +0100
From:   John Keeping <john@metanate.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Message-ID: <ZCGpmHUWyZVaeIIx@donbot>
References: <20230324111127.221640-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324111127.221640-1-steven.price@arm.com>
X-Authenticated: YES
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:11:27AM +0000, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal). But also the use of a NULL domain is confusing.
> 
> Rework the code to have a singleton rk_identity_domain which is assigned
> to domain when using an identity mapping rather than "detaching". This
> makes the code easier to reason about.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v1[1]:
> 
>  * Reworked the code to avoid a NULL domain, instead a singleton
>    rk_identity_domain is used instead. The 'detach' language is no
>    longer used.
> 
> [1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
> 
>  drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index f30db22ea5d7..437541004994 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
[snip]
> +static struct iommu_domain rk_identity_domain = {
> +	.type = IOMMU_DOMAIN_IDENTITY,
> +	.ops = &rk_identity_ops,
> +};
> +
> +#ifdef CONFIG_ARM

Is this #ifdef needed?  I can't see anything ARM-specific about this
function or .set_platform_dma_ops.

> +static void rk_iommu_set_platform_dma(struct device *dev)
> +{
> +	WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
>  }
> +#endif

Not shown in the patch are the pm_runtime hooks.  Do they need to
change like this?

 static int __maybe_unused rk_iommu_suspend(struct device *dev)
 {
 	struct rk_iommu *iommu = dev_get_drvdata(dev);
 
-	if (!iommu->domain)
+	if (iommu->domain == &rk_identity_domain)
 		return 0;
 
 	rk_iommu_disable(iommu);
 	return 0;
 }
 
 static int __maybe_unused rk_iommu_resume(struct device *dev)
 {
 	struct rk_iommu *iommu = dev_get_drvdata(dev);
 
-	if (!iommu->domain)
+	if (iommu->domain == &rk_identity_domain)
 		return 0;
 
 	return rk_iommu_enable(iommu);
 }
