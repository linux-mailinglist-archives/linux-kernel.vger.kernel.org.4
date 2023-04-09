Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC06DBE29
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 02:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDIAJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 20:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDIAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 20:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B497B83D7
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 17:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42415616C3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 00:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A17C433A8;
        Sun,  9 Apr 2023 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680998961;
        bh=ps76pyu3TDlG2IApvb70QcdiPajYqBKpLTa4tWI5Ohs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tK6Zxue4K7UPtqIlVK/fMHIZgv7oixQdk1BL5ZW14GAUjy6ZqGU9ktImZlxBMtfNv
         bbUiMeGuiiZ4QqYQriftxfvFRdS9o8QL+r9OUKQiBvYBQ5AfuRHEZ4SCKQpjtmou1Z
         pbQUDhMTbzRD4nylA/2lDqhUZCu6MXFOLyXiRfaBppk44OCJPG/kvzs6oeB7gb+TBE
         ASRjwIELp0sKp3YYK0XneCuLGY+FrIzj9DzOaASnKjpgMcR8ziB4hjxqKPPzNwNSjA
         j/AOvNZiNijwXR9tMb/f1iUowHFhqEGkH3GRMh/tcV9zbY3YQhmFbC4LnvbyLNR79L
         J4oMUy7jsmjPg==
Received: by pali.im (Postfix)
        id 36D14213C; Sun,  9 Apr 2023 02:09:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] powerpc/86xx: mpc86xx_hpcn: Call uli_init() instead of explicit ppc_md assignment
Date:   Sun,  9 Apr 2023 02:08:11 +0200
Message-Id: <20230409000812.18904-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230409000812.18904-1-pali@kernel.org>
References: <20230409000812.18904-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

