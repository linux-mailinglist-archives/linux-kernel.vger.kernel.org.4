Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21260F341
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiJ0JKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiJ0JKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C97186E3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 146B6B82558
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD825C433D7;
        Thu, 27 Oct 2022 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861813;
        bh=tSX9KWeRRKgdyRd+ltEPm7bb1mNdvSggLOMwkpA8MaI=;
        h=From:To:Cc:Subject:Date:From;
        b=pfoQnXnMwbTuRISxVvze0SCxnIibPXssCt10jXVWR1Gxu8wGGKAVElFplEwaCZgIu
         UhYQ4pGVVAZvof61rFQJckSIs5txWQRmoSIcad39m8sZrnyhW6fU/IFfy0aNYTb45v
         uAjOuIRxrPO8ci6TgWoZL89F/hElVigPBhMhWX28mUSXGPndhS9lDcXh+LCNmkTaO9
         hwXAHaAQMQINIaeozy+C3aUytAIS8BdEhWWVEh/e3+4GpEPoOJNOSxcxWWif22gWsY
         X1prZekhJZkXbIGtd2tIxVUTKQ7VuBQauh6oOQPnubUf1AdGkWpBa77GUxwD7k2r85
         rKq7Mkwyq4fpA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 01/15] habanalabs: fix using freed pointer
Date:   Thu, 27 Oct 2022 12:09:53 +0300
Message-Id: <20221027091007.664797-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

The code uses the pointer for trace purpose (without actually
dereference it) but still get static analysis warning.
This patch eliminate the warning.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9b54d1df5302..dd01be5c4ba3 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -135,6 +135,9 @@ static void hl_asic_dma_free_common(struct hl_device *hdev, size_t size, void *c
 					dma_addr_t dma_handle, enum dma_alloc_type alloc_type,
 					const char *caller)
 {
+	/* this is needed to avoid warning on using freed pointer */
+	u64 store_cpu_addr = (u64) (uintptr_t) cpu_addr;
+
 	switch (alloc_type) {
 	case DMA_ALLOC_COHERENT:
 		hdev->asic_funcs->asic_dma_free_coherent(hdev, size, cpu_addr, dma_handle);
@@ -147,7 +150,7 @@ static void hl_asic_dma_free_common(struct hl_device *hdev, size_t size, void *c
 		break;
 	}
 
-	trace_habanalabs_dma_free(hdev->dev, (u64) (uintptr_t) cpu_addr, dma_handle, size, caller);
+	trace_habanalabs_dma_free(hdev->dev, store_cpu_addr, dma_handle, size, caller);
 }
 
 void *hl_asic_dma_alloc_coherent_caller(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
-- 
2.25.1

