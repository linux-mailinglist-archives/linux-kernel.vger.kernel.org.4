Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA460D204
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiJYQyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiJYQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:54:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC518E06
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so6256576wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XVDf5CNGXohyTDwQXIUTQefWV+zveKEvdiJ0iEMiCo=;
        b=nWWvtDEnIFtSZIk2LCzs577LelT3TwOr923486IySggt0BodjQKLBytOshOzTgOkYW
         ShmNzTVUSj8yF8YpAsjkfXnqZw9wZ5Uxu9cFvPR9mPLSpXrh+BkPuGjsXfVTCZW1lhnx
         0nTXG8MyhhmQg8vNm8SyUcRZLE8mXL8mUBGwSQHSBzwib4mvgtW7KuJzCIXJrps8u9xz
         lEykKyUDhLTep6wRxxb1huTpc2j03/jY6taCCgvFu/pOHj1NuUf4lp0rjTTClFpPNGUX
         f7e54GNHC3jhmlr7DPiVXmhJPTzx5nKyRS2lKAXqqXmREcNaaQYCs2/OmzZLNBHc8nHX
         604Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XVDf5CNGXohyTDwQXIUTQefWV+zveKEvdiJ0iEMiCo=;
        b=5YQIfeVo44kcGxz3FunMbymIYgRseQXePk15U7r5vMGzW6kmQyOGSjS7WbXONp0arP
         Jh6ruNc1KbYPO9gSoKiDIyQ9xz/85puY4mGNjSaa8vRIitrUjSYkanWgxUZeSLXJyGMN
         GhrsENuqAycxV+nyF0O/dhLFP0gdVLDNU8r3VutIICXTIEE2IZa+CP/Pv/YHixmHvs4V
         85grZtjbzwGkqRN2DGlYuI59d1mtfqB8wKpaEYCbCy83sG7m3s8/Uv0N6F6b9XELvPu0
         nxcD9drGd/Eyx7JK9kqoR/xE8XOmYSHmZQ06bCh9BBdZbax+Q4UXNi8sYdqhWF399hw5
         +21w==
X-Gm-Message-State: ACrzQf2+250w4Cd3I7fKzJwHGIa22HXJDV98p05jL2PheGpQXKhBP/P+
        A/K4w0vCgV8cPDAly4p0XGw=
X-Google-Smtp-Source: AMsMyM4URGw014tILeGzQZ66S57zVWE5z6thpheFKt2ksgimTOOtljhHjSVf/MlhT/s/B/o2zDdIQA==
X-Received: by 2002:a5d:6dcd:0:b0:235:f087:fec2 with SMTP id d13-20020a5d6dcd000000b00235f087fec2mr18867780wrz.444.1666716874910;
        Tue, 25 Oct 2022 09:54:34 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:34 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 1/5] iommu/sun50i: Fix reset release
Date:   Tue, 25 Oct 2022 18:54:11 +0200
Message-Id: <20221025165415.307591-2-jernej.skrabec@gmail.com>
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
index cd9b74ee24de..270204a6ec4a 100644
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
2.38.1

