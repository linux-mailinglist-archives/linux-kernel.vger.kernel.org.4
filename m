Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4645FE147
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJMScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiJMSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:31:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8C3188124
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:27:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s30so3826364eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEldd9wQdL+BNIpPagsN4syvK2Vu5z+yJRpIhSRKQMc=;
        b=qzluUBhJwWMerMPUe1gwWm6V5osUfex8TSHWUCaPokvqy+9fQRlP7jpgo9iflEUD6g
         clMX3iYM7P+JkEBVsDGWP/fJycFBwJwEj5F7/evQJKj89Q9Uq+rtrU5D8kLD3Ptz9o8W
         QGPC6LRUw4nVWr7SnJBkCg1O3NStZ/Bsmo/XcHOMkIUJNkLEjKN/2cGlflJjwhEtjDLG
         aVUbu9K3c9BXOsCY1+KOE1S1+NeKycL2yjfht2mOAaOSQDvmGRyMZH7+rF77Glo/k7LB
         ip6ygGlGS3didO4QLZtugOcfuvhQsFAyIWPR+8jGmCITGDyYQ9DxS+TGWikBtW/zo4qc
         DzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEldd9wQdL+BNIpPagsN4syvK2Vu5z+yJRpIhSRKQMc=;
        b=zpQxs0whNKA4hbshtq8dvM5VcnmtKM2++znO3Ot85dob0SkdwAOTRjv5uTGy9Xalg2
         gfP5jBUxIY7hcPlFmbvJ/E2lHCJZPm1ZtsqzhgYyhHA9iEO3XPv9hoyuBn1x0v+NTEVI
         xY/28KFFmKytL+tKcWjEp1o572P9SIIv4NDipiNC2XsqpB8pKwtzbJ6keoOokGFkTriA
         dG4b09lVwOwueouHIuayVwbIlBGLhMeHrWR+UKDQGr4mWMtXlxRVwJCv8i3xINLWxLKk
         ZIEueOlBjUJlP0B/s6v3J4tmTlXAJZsFUcR1lHEoT+RtGRmnlMW0W0IslVESP0cbNioK
         tiTA==
X-Gm-Message-State: ACrzQf2DNJQgAbP7pZsp9tcX6Y/3xdg8iJ+pAJNLYy0KxDjgo4v5VDet
        wRw3EII+5hBXbClqjzbhOrtMZui7tL8meRgn
X-Google-Smtp-Source: AMsMyM4KGX8o0jIoAtj6ooSj5qXqHN5XuDxpnQzzmUfbe78ND/6Vh84BPIfk+ap5UfNfS6dxEyMQNA==
X-Received: by 2002:a17:907:3d91:b0:78d:f675:5659 with SMTP id he17-20020a1709073d9100b0078df6755659mr766140ejc.92.1665684769534;
        Thu, 13 Oct 2022 11:12:49 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:49 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 4/5] iommu/sun50i: Fix flush size
Date:   Thu, 13 Oct 2022 20:12:19 +0200
Message-Id: <20221013181221.3247429-5-jernej.skrabec@gmail.com>
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

Function sun50i_table_flush() takes number of entries as an argument,
not number of bytes. Fix that mistake in sun50i_dte_get_page_table().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 135df6934a9e..7c3b2ac552da 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -512,7 +512,7 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 		sun50i_iommu_free_page_table(iommu, drop_pt);
 	}
 
-	sun50i_table_flush(sun50i_domain, page_table, PT_SIZE);
+	sun50i_table_flush(sun50i_domain, page_table, NUM_PT_ENTRIES);
 	sun50i_table_flush(sun50i_domain, dte_addr, 1);
 
 	return page_table;
-- 
2.38.0

