Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC6B6B4775
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjCJOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjCJOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:30 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201BB1241CC;
        Fri, 10 Mar 2023 06:47:48 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id h18-20020a4abb92000000b00525397f569fso821064oop.3;
        Fri, 10 Mar 2023 06:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaG0TuJkSsZEq6KyR2Pw2svGg0iIophmgifd7AAJgZA=;
        b=E870DmYviOD4XvhGfEdWWmo8o49DNkFGvrKdex5tarbQ4VpibvjGyHyvUDmaTrzWZX
         yC56+sBvrx+nlPfdsRzdwU+B3oCUe18s6l9yKjqtlVvOnczcsN5PXW/3grx3Uzw8KmJX
         6kHDr7dbA/3q3z7cRq97G6LhGxREaJRNX8ueSKgCsvCi+Wgl8CQY6gcgX/Li3euJ0ZGu
         KDvZnAtO/bVdgqtfHd9x0zMKI9YKnSimeJYE7Ef6UbiOnXL9HqhSQIs4+MKPf4k4Z2Eh
         5XOnZVmSlmV/zMawgxfDynKhIqqJMPUKb7oXyZ1RWbzyAK6yhxVzK4O0UDqbVXW/zpkY
         VDFw==
X-Gm-Message-State: AO0yUKUlXYGEj5cfVSuiihCS+1F9pGHRl5ww/tgwobZfOe1GlsrfaOVT
        rkV3j2pT+Aqr6HzRsEOeymygkktw4w==
X-Google-Smtp-Source: AK7set8+gWXMSTtGEYuxYj+rHrEgRcQwcPQPrVXthx8wns6wXVi81jocwA/15crUkZWCDQp+pYVWYQ==
X-Received: by 2002:a05:6820:174:b0:51a:ac9:775 with SMTP id k20-20020a056820017400b0051a0ac90775mr12553434ood.6.1678459665482;
        Fri, 10 Mar 2023 06:47:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a9d0845000000b00690f6d9a737sm134796oty.8.2023.03.10.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:44 -0800 (PST)
Received: (nullmailer pid 1543027 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: omap: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:09 -0600
Message-Id: <20230310144709.1542980-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3ab078112a7c..baafd6211ac4 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1191,7 +1191,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		return err;
 	if (obj->nr_tlb_entries != 32 && obj->nr_tlb_entries != 8)
 		return -EINVAL;
-	if (of_find_property(of, "ti,iommu-bus-err-back", NULL))
+	if (of_property_read_bool(of, "ti,iommu-bus-err-back"))
 		obj->has_bus_err_back = MMU_GP_REG_BUS_ERR_BACK_EN;
 
 	obj->dev = &pdev->dev;
-- 
2.39.2

