Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF260D205
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiJYQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiJYQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:54:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D841ADBF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu30so22157619wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxmsLKzFVvKcS3WMj1YQZz1vx7/2bMhWnQ94H0bmWEY=;
        b=Nykt+sLEadPMO+cbi45gb3Ye9NF4TPpULSSO3kp+XegRbPdux6w/+ZO3CR3SXQRW8I
         R3TuAZZf1w7TrwlmiHAZ86B2JWU42B4iOt8JBUaz6eJeiBBy1XkUogeLCwFtGfszG9uR
         Z3rcrOhRdGx2cafEhzZkq8e1iQe9O7MFXbfFvujOvM5KHs0wioEYKntJ/BBvMa941RoX
         +hpKjDKTz1JH+yS0JdHZ4RzjqXIc5ObsolSvx7vq9a++fXRWX1RlSr6DmT9rqchhO4LG
         KvJzUCvEhmdpE1rxgBVZ1ozzNn44JG024aTd8a59jr+v0PkKHBZ0JwY5do5aEDVyYWDQ
         UwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxmsLKzFVvKcS3WMj1YQZz1vx7/2bMhWnQ94H0bmWEY=;
        b=7koiRsWXxacVIr5HDCAL2hTKvRwEPhCQ4jMFowaWy7PW5ZPpItTY0+j+HVKPLWLb46
         HJWsl432w23lFsmGijvLwQHso9RimwYs8D9PURpiLcSv6MZZPEGqZyYIHbZ9/SJNTsnZ
         19EWeu6nIaB7Ajsn+sSWOn2Fzm9P6pQ4aI4oqS1wn0MIAKz9JlZa4mdrVK2HBMkCZIQf
         HsJsIqBueXzXxX3rCkffyTDci5m37uQ/Ul1/9kLzjdUfo+4rC2ydRepXU3E+g80aVEC5
         Krr0TadfRM9RBVSAC7snZ/gFDHkzrwU6iuKudVkw09crzia4edaU32UZMhGC9fPUvsfe
         AOwQ==
X-Gm-Message-State: ACrzQf28DE5pRmhgXntRPvjr3CvF4NENvaeARb3zJpu1P34b/AhNiRIb
        95TyD9xgDXXuQOcU3hS6Zq8=
X-Google-Smtp-Source: AMsMyM4kPGoX2AJWIBlWQttHFd0s9iY+Inu6HTE/NlV0jO9C0/NXk1FfdKL8gAxUmJyeRSU69QkXEg==
X-Received: by 2002:a5d:42c7:0:b0:236:4ddd:3576 with SMTP id t7-20020a5d42c7000000b002364ddd3576mr18079744wrr.289.1666716875926;
        Tue, 25 Oct 2022 09:54:35 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:35 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 2/5] iommu/sun50i: Consider all fault sources for reset
Date:   Tue, 25 Oct 2022 18:54:12 +0200
Message-Id: <20221025165415.307591-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have to reset masters for all faults - permissions, L1 fault or L2
fault. Currently it's done only for permissions. If other type of fault
happens, master is in locked up state. Fix that by really considering
all fault sources.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 270204a6ec4a..bbc269500800 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -869,8 +869,8 @@ static phys_addr_t sun50i_iommu_handle_perm_irq(struct sun50i_iommu *iommu)
 
 static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 {
+	u32 status, l1_status, l2_status, resets;
 	struct sun50i_iommu *iommu = dev_id;
-	u32 status;
 
 	spin_lock(&iommu->iommu_lock);
 
@@ -880,6 +880,9 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	l1_status = iommu_read(iommu, IOMMU_L1PG_INT_REG);
+	l2_status = iommu_read(iommu, IOMMU_L2PG_INT_REG);
+
 	if (status & IOMMU_INT_INVALID_L2PG)
 		sun50i_iommu_handle_pt_irq(iommu,
 					    IOMMU_INT_ERR_ADDR_L2_REG,
@@ -893,7 +896,8 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 
 	iommu_write(iommu, IOMMU_INT_CLR_REG, status);
 
-	iommu_write(iommu, IOMMU_RESET_REG, ~status);
+	resets = (status | l1_status | l2_status) & IOMMU_INT_MASTER_MASK;
+	iommu_write(iommu, IOMMU_RESET_REG, ~resets);
 	iommu_write(iommu, IOMMU_RESET_REG, IOMMU_RESET_RELEASE_ALL);
 
 	spin_unlock(&iommu->iommu_lock);
-- 
2.38.1

