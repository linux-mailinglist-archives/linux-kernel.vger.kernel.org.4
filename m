Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5429C5F6190
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJFHR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJFHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C14B986
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B2461861
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DEEC433D7;
        Thu,  6 Oct 2022 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665040672;
        bh=w9W7UBpVdspzCyp6qUSPQAQAXbvMYaSbMRYZmTO4oSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1HVQJNxlNTNOXW0QK/oloZXr/BfPEYQmtRgt+XfD5WPHOtKRssM2aR3KVYJfEzOV
         xzRBv2NPcusfEyme5F8TuA/xyELvb7joEpSGuNMo7PnsUqt+FJSbL3vQpwrr7RJfjy
         jsw6d94M7lhEHj6hnuIHHx3EoFnt+qmIblM12CxDeGXF9vrPIBGJdKy9Fdnk/R2ep2
         8hUX+H7r1d/zw91NxlqKgChRu0h+uPqmRy62YhYLIofwiCdFCrHeoxc371xNNFGqkS
         Mfurgm+G/9HtR55C3+E4BEQIHBMuiACaB5dMsWfEPelLDVpAUC4pwlYNULWa6cTXqo
         IQLqY9Y21g1TQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] riscv: move riscv_noncoherent_supported() out of ZICBOM probe
Date:   Thu,  6 Oct 2022 15:08:11 +0800
Message-Id: <20221006070818.3616-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006070818.3616-1-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org>
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

It's a bit wired to call riscv_noncoherent_supported() once when
insmod a module. Move the calling out of feature patch func.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/cpufeature.c | 7 +------
 arch/riscv/kernel/setup.c      | 4 ++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3b5583db9d80..03611b3ef45e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -272,12 +272,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
 	case RISCV_ALTERNATIVES_EARLY_BOOT:
 		return false;
 	default:
-		if (riscv_isa_extension_available(NULL, ZICBOM)) {
-			riscv_noncoherent_supported();
-			return true;
-		} else {
-			return false;
-		}
+		return riscv_isa_extension_available(NULL, ZICBOM);
 	}
 #endif
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2dfc463b86bb..1a055c3f5d9d 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -299,6 +299,10 @@ void __init setup_arch(char **cmdline_p)
 	riscv_init_cbom_blocksize();
 	riscv_fill_hwcap();
 	apply_boot_alternatives();
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+	if (riscv_isa_extension_available(NULL, ZICBOM))
+		riscv_noncoherent_supported();
+#endif
 }
 
 static int __init topology_init(void)
-- 
2.37.2

