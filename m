Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC755BE659
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiITMw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiITMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB8D6BD54
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B5B26210E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16710C433D7;
        Tue, 20 Sep 2022 12:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663678374;
        bh=U2NjIYtUJR5OXr9K2auIY36C7VyjzJHarIAbb64A0VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYLElmIqhRe36EeuriNj3ZAqZIE1MiPkoTT2UWaBZ8Pf5qgtKlJNW4pjmIIj738Wr
         xA29py/LXhAKq987G07X+FDqHw+5biqSVsCPegeRrB6BL7nIuMyLcQIZux7111FDsD
         7YIwTwBP21184hGWgue7fKLZBVVzxErCQnzo/MlLegRV+GpovhD9Sj+pYsL62uUPDk
         DhYQdZGP3YV29wYvm4dWuYISu+4omEfscGR8VndPPSWiFU/nBD17LkX563CuWS47vI
         XFs1cqlHtGaKm0XemQGOncmdptmv//dnS64sOMcGF7/3J79iT/jdHtVRROZ3g3wWxv
         D4QGPYFdhHWgA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 3/4] habanalabs/gaudi: use 8KB aligned address for TPC kernels
Date:   Tue, 20 Sep 2022 15:52:44 +0300
Message-Id: <20220920125245.161233-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920125245.161233-1-ogabbay@kernel.org>
References: <20220920125245.161233-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

I$ prefetch is enabled when sending a TPC kernel to initialize the TPC
memory, and it has a restriction that the base address will be aligned
to 8KB.
Currently the base address is 128 bytes from the start address of the
device SRAM, so prefetching will start 128 bytes before the actual
kernel memory.
Modify the kernel address to be 8KB aligned.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e80ebace49c8..92560414e843 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -984,9 +984,10 @@ static int _gaudi_init_tpc_mem(struct hl_device *hdev,
 	init_tpc_mem_pkt->ctl = cpu_to_le32(ctl);
 
 	init_tpc_mem_pkt->src_addr = cpu_to_le64(tpc_kernel_src_addr);
-	dst_addr = (prop->sram_user_base_address &
-			GAUDI_PKT_LIN_DMA_DST_ADDR_MASK) >>
-			GAUDI_PKT_LIN_DMA_DST_ADDR_SHIFT;
+
+	/* TPC_CMD is configured with I$ prefetch enabled, so address should be aligned to 8KB */
+	dst_addr = FIELD_PREP(GAUDI_PKT_LIN_DMA_DST_ADDR_MASK,
+				round_up(prop->sram_user_base_address, SZ_8K));
 	init_tpc_mem_pkt->dst_addr |= cpu_to_le64(dst_addr);
 
 	job = hl_cs_allocate_job(hdev, QUEUE_TYPE_EXT, true);
-- 
2.25.1

