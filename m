Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB36E6DBB23
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjDHNYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjDHNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA132D520
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 06:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 774036143F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 13:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA873C433D2;
        Sat,  8 Apr 2023 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680960250;
        bh=ps76pyu3TDlG2IApvb70QcdiPajYqBKpLTa4tWI5Ohs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5DDK8GI+rwvjJPfZEVp80zJfVVp8JpL4yQrVaExPzOfnPcYpewHbcb5OA0jfC1rR
         FHldYjZtQ3UtLbQmXxZYby67EG6pS3EDZw4FZwfF5wdVDOq+CCE1sYgVfmtd9ay2v5
         zVWKDlIBpuKD1K3Twseu/S0T8Ou5vkSc0od8dPDrr827ViP++aIiHuocJImOSlfdWr
         uS7nRFH5WeDt3n83/E0Z/APHg5ni6LV8Un316/6feLD/cHnLGcqps/Q2vp5iEDnwjR
         qamRvrC64lD4ebM4jH81mls0fVgHqsp08bLb0QrpJvGCvgYe5X+OSYbrOacGvxpc1n
         SNxbneZmpBL9w==
Received: by pali.im (Postfix)
        id 6F567213C; Sat,  8 Apr 2023 15:24:06 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] powerpc/mpc86xx: mpc86xx_hpcn: Call uli_init() instead of explicit ppc_md assignment
Date:   Sat,  8 Apr 2023 15:21:50 +0200
Message-Id: <20230408132151.8902-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408132151.8902-1-pali@kernel.org>
References: <20230408132151.8902-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling fsl_pci_assign_primary(), it is possible to use uli_init() to
conditionally initialize ppc_md.pci_exclude_device callback based on the
uli1575 detection.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 645125cc8420..812110673d88 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -46,10 +46,6 @@ mpc86xx_hpcn_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	ppc_md.pci_exclude_device = uli_exclude_device;
-#endif
-
 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
 
 #ifdef CONFIG_SMP
@@ -57,6 +53,7 @@ mpc86xx_hpcn_setup_arch(void)
 #endif
 
 	fsl_pci_assign_primary();
+	uli_init();
 
 	swiotlb_detect_4g();
 }
-- 
2.20.1

