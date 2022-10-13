Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C895FE14A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiJMScm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiJMScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:32:20 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFB18811F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:28:14 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id bv10so4133355wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZtnjkPggA5SjkwbihxQWAD96AH19hj8hGJnqIV/2as=;
        b=h/9B8PjhRL0AdEzegsu1cN+YgPWzL8Yt8OtB9q1nNDhqtQ9BxH7ACySjVV/VeBVhsK
         YEPbewQmKHs4dq4cGsFmL1U83j8NROHxO5ExqKlrc0mBdk5uNoQOogiwnXYdFWZXGn6c
         VQi1BLth7T8fVggZGGh+vH4wQaH8B0d/qIZt/+yGzuhR+W3Vms4FimKOwuByoVAtmLoi
         WcCXELLiL+pB/sgBkYIYeROPfjjLJLAv/mucTGxPWSek5Xn25URUgyr0sCkeFkN3Xoyf
         M7gh6EM9INVsfa2wZbUPd/44s6y6wfRp4U1R5/9tuin5dtIrxDiuSioG+I8OaTONeVJM
         BTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZtnjkPggA5SjkwbihxQWAD96AH19hj8hGJnqIV/2as=;
        b=Khlb98/cEv+8hLsMl2b5YoN+Yxpk1pMYNxe235+djb4KraIH8XSHW9QnIC6sBZwc3G
         IABwTyj9gBpmkayRzr7N6UUVODiIQl7xMFyt+c+UqP6dj0OqLR8ybq+BmyE8CN5zilKs
         C13e51hprmhgauqb86shg8hJld/wI1rLVtzd0w6ig1UR5EM/gJ1URjBc4OPBe9DKsEdW
         TDYTwsw23cKMl5RcAn8EV7QP0Okoptno3vLEuz85sLG5GE0tqcY3V7GAkLRAHdTW7lpS
         p/peqmhb/SdC8MaCZGefDyM57soKEhP0+6THCXm4n03CuN+Hghtn+sJfQubGjoXQ288H
         iM1w==
X-Gm-Message-State: ACrzQf3iOMnarHoUx6wdCiHAMgRuxqqe+6Pvx9y/zTEA5PliK3Ej6ETQ
        KuNVsVGejH0IhsWKbMB8/tgGXpFc9yKYXZwn
X-Google-Smtp-Source: AMsMyM4nF065eBM9sudXyKpRFJ4LcfEKfLKhmQ5xJQh+63T0xHhPiB6dBG8cwR7SmZC8OKOCNNlJIA==
X-Received: by 2002:a05:6402:254f:b0:45a:1799:d8fc with SMTP id l15-20020a056402254f00b0045a1799d8fcmr859345edb.237.1665684771705;
        Thu, 13 Oct 2022 11:12:51 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:51 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 5/5] iommu/sun50i: Invalidate iova in map and unmap callback
Date:   Thu, 13 Oct 2022 20:12:21 +0200
Message-Id: <20221013181221.3247429-7-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapped and unmapped iova addresses needs to be invalidated immediately
or otherwise they might or might not work when used by master or CPU.

This was discovered when running video decoder conformity test with
Cedrus. Some videos were now and then decoded incorrectly and generated
page faults.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 7c3b2ac552da..21e47ce6946a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -518,6 +518,53 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 	return page_table;
 }
 
+static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu, unsigned long iova)
+{
+	unsigned long flags;
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(&iommu->iommu_lock, flags);
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
+
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_MASK_REG, GENMASK(11, 0));
+	iommu_write(iommu, IOMMU_TLB_IVLD_ENABLE_REG, IOMMU_TLB_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_TLB_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "TLB invalidation timed out!\n");
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
+
+	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+}
+
+static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu, unsigned long iova)
+{
+	unsigned long flags;
+	u32 reg;
+	int ret;
+
+	spin_lock_irqsave(&iommu->iommu_lock, flags);
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
+
+	iommu_write(iommu, IOMMU_PC_IVLD_ADDR_REG, iova);
+	iommu_write(iommu, IOMMU_PC_IVLD_ENABLE_REG, IOMMU_PC_IVLD_ENABLE_ENABLE);
+
+	ret = readl_poll_timeout_atomic(iommu->base + IOMMU_PC_IVLD_ENABLE_REG,
+					reg, !reg, 1, 2000);
+	if (ret)
+		dev_warn(iommu->dev, "PTW cache invalidation timed out!\n");
+
+	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
+
+	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+}
+
 static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
@@ -546,6 +593,8 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	*pte_addr = sun50i_mk_pte(paddr, prot);
 	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	sun50i_iommu_zap_iova(iommu, iova);
+	sun50i_iommu_zap_ptw_cache(iommu, iova);
 
 out:
 	return ret;
@@ -571,6 +620,8 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 
 	memset(pte_addr, 0, sizeof(*pte_addr));
 	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	sun50i_iommu_zap_iova(sun50i_domain->iommu, iova);
+	sun50i_iommu_zap_ptw_cache(sun50i_domain->iommu, iova);
 
 	return SZ_4K;
 }
-- 
2.38.0

