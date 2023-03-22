Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC36C4EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCVPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCVPIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:08:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C53281043D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:08:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DE514B3;
        Wed, 22 Mar 2023 08:09:29 -0700 (PDT)
Received: from [10.57.53.137] (unknown [10.57.53.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8623F71E;
        Wed, 22 Mar 2023 08:08:43 -0700 (PDT)
Message-ID: <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>
Date:   Wed, 22 Mar 2023 15:08:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca> <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
 <ZBr5e6tn1i7EE/16@ziepe.ca>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <ZBr5e6tn1i7EE/16@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 12:50, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 09:02:41AM +0000, Steven Price wrote:
>> On 21/03/2023 14:38, Jason Gunthorpe wrote:
>>> On Wed, Mar 15, 2023 at 04:41:52PM +0000, Steven Price wrote:
>>>> Similar to exynos, we need a set_platform_dma_ops() callback for proper
>>>> operation on ARM 32 bit after recent changes in the IOMMU framework
>>>> (detach ops removal).
>>>>
>>>> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>> ---
>>>> This fixes a splat I was seeing on a Firefly-RK3288, more details here:
>>>> https://lore.kernel.org/all/26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com/
>>>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>
>> Thanks for the review.
>>
>>> Do you know what state the iommu is left in after
>>> rk_iommu_detach_device()? Ie is it blocking DMA or doing identity or
>>> something else?
>>
>> To be honest I really don't know for sure. But from my small
>> understanding of the code: rk_iommu_detach_device() ends up in
>> rk_iommu_disable_paging() which appears to switch to identity mode
>> ("Disable memory translation").
> 
> Can you consider writing this patch like this instead:
> 
> https://lore.kernel.org/linux-iommu/ZBnef7g7GCxogPNz@ziepe.ca/
> 
> ?
> 
> I'd much rather we move toward clearly documenting what is going on
> with the HW and remove this undefined "detach" language.

I'm really not very familiar with the code or hardware, but I had a
go at doing the same sort of conversion. The below successfully boots,
but it would be good if someone more knowledgable could take a look as
I can't say I really understand this code.

Steve

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f30db22ea5d7..3fd108f04a2a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -124,6 +124,7 @@ struct rk_iommudata {
 
 static struct device *dma_dev;
 static const struct rk_iommu_ops *rk_ops;
+static struct iommu_domain rk_identity_domain;
 
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
 				  unsigned int count)
@@ -980,26 +981,27 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 	return ret;
 }
 
-static void rk_iommu_detach_device(struct iommu_domain *domain,
-				   struct device *dev)
+static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
+				    struct device *dev)
 {
 	struct rk_iommu *iommu;
-	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	struct rk_iommu_domain *rk_domain;
 	unsigned long flags;
 	int ret;
 
 	/* Allow 'virtual devices' (eg drm) to detach from domain */
 	iommu = rk_iommu_from_dev(dev);
 	if (!iommu)
-		return;
+		return -ENODEV;
+
+	rk_domain = to_rk_domain(iommu->domain);
 
 	dev_dbg(dev, "Detaching from iommu domain\n");
 
-	/* iommu already detached */
-	if (iommu->domain != domain)
-		return;
+	if (iommu->domain == identity_domain)
+		return 0;
 
-	iommu->domain = NULL;
+	iommu->domain = identity_domain;
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_del_init(&iommu->node);
@@ -1011,8 +1013,26 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 		rk_iommu_disable(iommu);
 		pm_runtime_put(iommu->dev);
 	}
+
+	return 0;
 }
 
+static struct iommu_domain_ops rk_identity_ops = {
+	.attach_dev = rk_iommu_identity_attach,
+};
+
+static struct iommu_domain rk_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &rk_identity_ops,
+};
+
+#ifdef CONFIG_ARM
+static void rk_iommu_set_platform_dma(struct device *dev)
+{
+	WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
+}
+#endif
+
 static int rk_iommu_attach_device(struct iommu_domain *domain,
 		struct device *dev)
 {
@@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (iommu->domain == domain)
 		return 0;
 
-	if (iommu->domain)
-		rk_iommu_detach_device(iommu->domain, dev);
+	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
+	if (ret)
+		return ret;
 
 	iommu->domain = domain;
 
@@ -1049,8 +1070,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 		return 0;
 
 	ret = rk_iommu_enable(iommu);
-	if (ret)
-		rk_iommu_detach_device(iommu->domain, dev);
 
 	pm_runtime_put(iommu->dev);
 
@@ -1061,6 +1080,9 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 {
 	struct rk_iommu_domain *rk_domain;
 
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		return &rk_identity_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
@@ -1176,6 +1198,7 @@ static int rk_iommu_of_xlate(struct device *dev,
 	iommu_dev = of_find_device_by_node(args->np);
 
 	data->iommu = platform_get_drvdata(iommu_dev);
+	data->iommu->domain = &rk_identity_domain;
 	dev_iommu_priv_set(dev, data);
 
 	platform_device_put(iommu_dev);
@@ -1188,6 +1211,9 @@ static const struct iommu_ops rk_iommu_ops = {
 	.probe_device = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,
 	.device_group = rk_iommu_device_group,
+#ifdef CONFIG_ARM
+	.set_platform_dma_ops = rk_iommu_set_platform_dma,
+#endif
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {

