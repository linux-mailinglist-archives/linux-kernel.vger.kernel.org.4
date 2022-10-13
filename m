Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D655FE0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiJMSTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiJMSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:19:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E3FD26
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:14:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e18so3761367edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy++TP4MEmK9+IncYVXW5dpqxIdw3c9kXrFdre+ha14=;
        b=CQ9TnzAPgu0twXcz51eJtm0MYyiV+U12yy5ia/sBn3YqCfoEQNZbJox/YeWnpaIBoE
         TYEM9Hw0EGjn2tXKlAWjrkaORyfaKwcar28Ec7NSFIeLYAllGCqNh2pU2PYx3LxsqxFG
         6z6XuuKosJtWm6yPV0CdYsnYS7GdnBmUj7R82Ws3yOFTwaIxD32pVpcKhNvW/hq4azh/
         pyxMhT+TJGWjw77Bz/d7ZlNR59kXaW9mCpfOPX3rRypwf8LOMd1e3Oc7h8YH1pyz08E5
         rppEhw2WHhCkDKW3evmIBSWV1bQ5vA0vM4LjoFtItLlNwt+gYHNoOtSigZItkYpjUT00
         NUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy++TP4MEmK9+IncYVXW5dpqxIdw3c9kXrFdre+ha14=;
        b=E/hcam9xPbuJtlt7A+19V7jhkhBBiZ+g+AhwLc5wZjLMyTeoJdB5+t+e9j9mAaDBob
         uHKChv1zvwzV2RqvSxjGKrjSxpwfX8kWlHLQE/8MtBz1AzECmvVT5rFXAQPd9z8WkYOS
         JZ/RF3j98RPywhH8VJaA/mG9aV0X8LdADGDyX6i2ZIgSpzSbG2lBDzWQ0yFF3ryfwhNF
         iopJs5SUoim/Wy0DuLMV3XIyG1VYZtD21lLmUkYcxv6olbvH33JaQ0Fnx2SrKvqBQewC
         Z1mNces6nxediRZ+kc15mk/aCnOgSLXiIBs/2n3wnqK3LmZd5d9cMDoi2ktFBWy1ghmB
         onnQ==
X-Gm-Message-State: ACrzQf2sVc48hoPOf3HYemCzcI+qhlGQjKwLN/D0PkMk4njuWcgKW7sI
        Drhi0ARVKY/2/LP4UwFFfDM=
X-Google-Smtp-Source: AMsMyM4ICzUCjoigsNUFgWVeKqBHqBJ1tuJkf0WbPLqftDEHH2D+3WKsfapHPDp486t6zWZt35VE2A==
X-Received: by 2002:a05:6402:1944:b0:457:fed7:5c30 with SMTP id f4-20020a056402194400b00457fed75c30mr873109edz.278.1665684766034;
        Thu, 13 Oct 2022 11:12:46 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:45 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/5] iommu/sun50i: Fix reset release
Date:   Thu, 13 Oct 2022 20:12:16 +0200
Message-Id: <20221013181221.3247429-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
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

Reset signal is asserted by writing 0 to the corresponding locations of
masters we want to reset. So in order to deassert all reset signals, we
should write 1's to all locations.

Current code writes 1's to locations of masters which were just reset
which is good. However, at the same time it also writes 0's to other
locations and thus asserts reset signals of remaining masters. Fix code
by writing all 1's when we want to deassert all reset signals.

This bug was discovered when working with Cedrus (video decoder). When
it faulted, display went blank due to reset signal assertion.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index a84c63518773..c777882d0ec2 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 
 #define IOMMU_RESET_REG			0x010
+#define IOMMU_RESET_RELEASE_ALL			0xffffffff
 #define IOMMU_ENABLE_REG		0x020
 #define IOMMU_ENABLE_ENABLE			BIT(0)
 
@@ -893,7 +894,7 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 	iommu_write(iommu, IOMMU_INT_CLR_REG, status);
 
 	iommu_write(iommu, IOMMU_RESET_REG, ~status);
-	iommu_write(iommu, IOMMU_RESET_REG, status);
+	iommu_write(iommu, IOMMU_RESET_REG, IOMMU_RESET_RELEASE_ALL);
 
 	spin_unlock(&iommu->iommu_lock);
 
-- 
2.38.0

