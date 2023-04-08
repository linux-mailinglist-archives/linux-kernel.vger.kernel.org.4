Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7050A6DBB63
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDHOC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjDHOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0583EF99
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C686159D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8D9C433A0;
        Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962548;
        bh=GGCC6nIysok7nRf7iQxTO/BAJu5Xzrmg55AbDqZKllk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPnN8GzzL8eSxC1PHevEiO0J6Y3trRJtHFRr9FNNO/ug6afpyJzXnxKCIObo0eB9Q
         ctTRyaNDi78kHf/33i0MfdM2rN88ZBkjsJwLtDKbtKcZBrYWQy2juJoTANT2tq9pP3
         /YrkOHisbFnduPcDzguSX27zC7gt6Xk4ZE1sOjwwfb3NfHvg4ut7+90Cle8rxI1xTq
         cLOQJCimaVkVJaeJEV9MwhI9f5ixfsfDqq0m5eXOzXOEtZHF+ex5q1fH9uuNvVSbcv
         g/w1lKEP5eDDq1WWIBX8uNTQaPJTyVwgKi/O2appN15WD/ynNPM4Ye5GJ9op11ObJY
         zj9bu1+1M8VGQ==
Received: by pali.im (Postfix)
        id A01CA20C8; Sat,  8 Apr 2023 16:02:26 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/13] powerpc/85xx: Remove #ifdef CONFIG_QUICC_ENGINE in mpc85xx_rdb
Date:   Sat,  8 Apr 2023 16:01:15 +0200
Message-Id: <20230408140122.25293-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

mpc85xx_qe_par_io_init() is a stub when CONFIG_QUICC_ENGINE is not set.

CONFIG_UCC_GETH and CONFIG_SERIAL_QE depend on CONFIG_QUICC_ENGINE.

Remove #ifdef CONFIG_QUICC_ENGINE

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 64badacf126d..cdafecaecf56 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -57,7 +57,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 	fsl_pci_assign_primary();
 
-#ifdef CONFIG_QUICC_ENGINE
 	mpc85xx_qe_par_io_init();
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(p1025_rdb)) {
@@ -90,7 +89,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 	}
 #endif
-#endif	/* CONFIG_QUICC_ENGINE */
 
 	pr_info("MPC85xx RDB board from Freescale Semiconductor\n");
 }
-- 
2.20.1

