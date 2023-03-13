Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884846B80C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjCMSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCMScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1185A74
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E935B811E1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D2DC433D2;
        Mon, 13 Mar 2023 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732228;
        bh=W+fW+GaLv1eYNbTlx2ySkmSxwEEfYBzIfMGA/H1zPac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rH/MCVbKSXu9ot3ZQ0Qy8B3weUd+cMfiNd0Tmf9+3da7IYDJNklPKProJ1v1Hp6WB
         oTJ+yPGFMqYDf25wAci03yskwsNdoU12pXS+OtmycZlMddHniV/OAqY8K5m1R2sbcp
         chEJjO9zT56BA6c5+okDz5S8DIBXllCgBtYpNxoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 33/36] ARM/dma-mapping: const a pointer to bus_type in arm_iommu_create_mapping()
Date:   Mon, 13 Mar 2023 19:29:15 +0100
Message-Id: <20230313182918.1312597-33-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2362; i=gregkh@linuxfoundation.org; h=from:subject; bh=W+fW+GaLv1eYNbTlx2ySkmSxwEEfYBzIfMGA/H1zPac=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82TU3trW/t7ZIa3j9d6Ou1M5F3ae72GSnzUrU3HmRK 3GXUfe+jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiI1x2GuXI1bIVf36jYLPaR Ll9VPzW5lZH5C8Ncif69Fy9pTj3HEPb9xfo4wS2hf/ijAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the function arm_iommu_create_mapping() to take a pointer to a
const bus_type as the function does not modify the variable the pointer
points to at all, and the driver core bus functions it calls all expect
a const * type.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/arm/include/asm/dma-iommu.h | 2 +-
 arch/arm/mm/dma-mapping.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index fe9ef6f79e9c..82ec1ccf1fee 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -24,7 +24,7 @@ struct dma_iommu_mapping {
 };
 
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size);
+arm_iommu_create_mapping(const struct bus_type *bus, dma_addr_t base, u64 size);
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8bc01071474a..b4a33358d2e9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1543,7 +1543,7 @@ static const struct dma_map_ops iommu_ops = {
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size)
+arm_iommu_create_mapping(const struct bus_type *bus, dma_addr_t base, u64 size)
 {
 	unsigned int bits = size >> PAGE_SHIFT;
 	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
-- 
2.39.2

