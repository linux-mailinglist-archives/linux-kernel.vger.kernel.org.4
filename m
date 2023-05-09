Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052B56FCE55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjEITLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEITLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:11:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0D40C8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:11:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaf7067647so43662095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683659498; x=1686251498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiDsH8G1Ml9mu5sSlgFdINiWzY2jO1Z5sTjGCqCyfWM=;
        b=OHoAELdpBVUNdBcedKgaIrSzqY8mpapJQEE3me1X0GlYJxG1opVIZ82ANS24D8UPtG
         Pt2dawEt+S0ERzDZ8ezL8OcIOWWqO9L1eryK0o6pszAoxIMPuD+jhRqXzf4me//VM0PJ
         FOun4S3oDVIRhH/u1JmX6/c6pNlrGnzsUTZo/kz6gQSktOKQpHhNl8K+TyCsqJj2ZBJJ
         52ig+ToxXnJIEh0wyCZF8Mth2Ax7GsgmBOe53OpuwAyHtGFjM2n+j9PcppngFiyluFiP
         EBB4PWuxCYUiTExHMAvHAH8/2SO0zwGCGhatUE5MKIJDvVd7xgbPqD3z2bM8x5sGuxoY
         vSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659498; x=1686251498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiDsH8G1Ml9mu5sSlgFdINiWzY2jO1Z5sTjGCqCyfWM=;
        b=OSOQtGKpg2CeDUYdwjeuNbxxlSz6ygLwCT1fFrrKsOq5rFweI/Fbj36HFFBi0RLX1e
         R7w5Xf/S1lEV0tUnsx/E9ljMSXhM6cQJaYkpqJcj5D/BGTqBih5yyQri2g5W42Fxzypl
         j1ufNS4Is+P/AkVDbaT/ovhwPojOclGMTRVGjLzpgTuKH5xMcPGMNgntOr79rI2IAfp/
         Vlf/yRfqGARy4qj85sRg2EKsU0qtiYBdKMb/U8wyYUgNGjC3sFvOeh2D7dY4uKt4SUoG
         rTGuwOXDTt0jqdyOsQEGsFw4xADtJ3EnQRYQowIfrIGmZFmdunhtUADmzKswo8Z5wl0M
         /H4Q==
X-Gm-Message-State: AC+VfDx3McXqWHBDIo/lixbCXZ5RgNhDiib+T3xBLlYWrTf7047+0Y4z
        CAdbjG1ZmFQY7jQ74QvlZG8=
X-Google-Smtp-Source: ACHHUZ4c9dGsxc56Vq7d4bMsklNgYny1qzmRzvIIBCBIw/4YDrf9m4QoU1u18kmttsWz08c//8Vl+Q==
X-Received: by 2002:a17:902:d509:b0:1a6:51a6:ca76 with SMTP id b9-20020a170902d50900b001a651a6ca76mr18757686plg.11.1683659497972;
        Tue, 09 May 2023 12:11:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902b94600b001ac78ac2cafsm1955579pls.239.2023.05.09.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:11:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu: Suppress empty whitespaces in prints
Date:   Tue,  9 May 2023 12:10:48 -0700
Message-Id: <20230509191049.1752259-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IOMMU_CMD_LINE_DMA_API or IOMMU_CMD_LINE_STRICT are not set in
iommu_cmd_line, we will be emitting a whitespace before the newline.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/iommu/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..0dd6ed6bec47 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -176,16 +176,16 @@ static int __init iommu_subsys_init(void)
 	if (!iommu_default_passthrough() && !iommu_dma_strict)
 		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
 
-	pr_info("Default domain type: %s %s\n",
+	pr_info("Default domain type: %s%s\n",
 		iommu_domain_type_str(iommu_def_domain_type),
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
-			"(set via kernel command line)" : "");
+			" (set via kernel command line)" : "");
 
 	if (!iommu_default_passthrough())
-		pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
+		pr_info("DMA domain TLB invalidation policy: %s mode%s\n",
 			iommu_dma_strict ? "strict" : "lazy",
 			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
-				"(set via kernel command line)" : "");
+				" (set via kernel command line)" : "");
 
 	nb = kcalloc(ARRAY_SIZE(iommu_buses), sizeof(*nb), GFP_KERNEL);
 	if (!nb)
-- 
2.34.1

