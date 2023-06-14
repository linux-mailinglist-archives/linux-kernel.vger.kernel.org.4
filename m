Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2397305AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjFNRGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjFNRG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C313E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D00CA61542
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B11C433C8;
        Wed, 14 Jun 2023 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686762388;
        bh=IzRWhdBJbcEgHie+AfmJ1TfzRd1tYjsi5h/A0SNdze8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smQcIBxnp+uHpcp3B4gZHVTHtsLsPvk7LzPNCHaPHXDdgWQfppJOBbHWv9OiMYr66
         u0o41zBEh60PJysSMHJ86S6d/EkB7rB/QOMOe5h7x1qHDgNUqsdaorrRnRbtDtRFJJ
         QKNUMDnIr91hos/JiBNnRg7o0RdVxQTX4xlOv3q3rj//YrQma9pOrbeW+TBcPLrr0N
         7T1CvpFyG+ALpuyiSQGY+zhrEs5ddA/s9K6n6ltPGbEAMaBT3JueCPQBFSVE6FuTDp
         zFAzI6bjX09kP3Hm1px4uVEvnPaVaOxWIOyzEhUcNPV64MZqSnHYQGeT/WDIq0Lw5m
         kokFqBXz8U+kA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 2/3] riscv: mm: mark CBO relate initialization funcs as __init
Date:   Thu, 15 Jun 2023 00:55:03 +0800
Message-Id: <20230614165504.532-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614165504.532-1-jszhang@kernel.org>
References: <20230614165504.532-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two functions cbo_get_block_size() and riscv_init_cbo_blocksizes()
are only called during booting, mark them as __init.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/mm/cacheflush.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fca532ddf3ec..fbc59b3f69f2 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -104,9 +104,9 @@ EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
 unsigned int riscv_cboz_block_size;
 EXPORT_SYMBOL_GPL(riscv_cboz_block_size);
 
-static void cbo_get_block_size(struct device_node *node,
-			       const char *name, u32 *block_size,
-			       unsigned long *first_hartid)
+static void __init cbo_get_block_size(struct device_node *node,
+				      const char *name, u32 *block_size,
+				      unsigned long *first_hartid)
 {
 	unsigned long hartid;
 	u32 val;
@@ -126,7 +126,7 @@ static void cbo_get_block_size(struct device_node *node,
 	}
 }
 
-void riscv_init_cbo_blocksizes(void)
+void __init riscv_init_cbo_blocksizes(void)
 {
 	unsigned long cbom_hartid, cboz_hartid;
 	u32 cbom_block_size = 0, cboz_block_size = 0;
-- 
2.40.1

