Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B52663E55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjAJKfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjAJKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:35:29 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBE4A965
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:35:27 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 25CEC1A009FE;
        Tue, 10 Jan 2023 18:35:41 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uwe-ESfTXsim; Tue, 10 Jan 2023 18:35:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 27B581A0092B;
        Tue, 10 Jan 2023 18:35:40 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     ogabbay@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        osharabi@habana.ai, obitton@habana.ai, dhirschfeld@habana.ai,
        mhaimovski@habana.ai, rkatta@habana.ai
Cc:     linux-kernel@vger.kernel.org, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] habanalabs: remove unnecessary (void*) conversions
Date:   Tue, 10 Jan 2023 18:35:13 +0800
Message-Id: <20230110103512.4690-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data is a void * type and does not require a cast.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/misc/habanalabs/common/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 2c1005f74cf4..a42ae8bc61e8 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -781,7 +781,7 @@ static void mmu_dma_mem_free_from_chunk(struct gen_pool *pool,
 					struct gen_pool_chunk *chunk,
 					void *data)
 {
-	struct hl_device *hdev = (struct hl_device *)data;
+	struct hl_device *hdev = data;
 
 	hl_asic_dma_free_coherent(hdev, (chunk->end_addr - chunk->start_addr) + 1,
 					(void *)chunk->start_addr, chunk->phys_addr);
-- 
2.18.2

