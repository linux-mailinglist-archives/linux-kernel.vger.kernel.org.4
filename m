Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891A731449
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbjFOJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbjFOJkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:40:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492903AAD;
        Thu, 15 Jun 2023 02:39:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E84311FDDA;
        Thu, 15 Jun 2023 09:39:37 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D015E2C141;
        Thu, 15 Jun 2023 09:39:37 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: mm: Remove special handling for OCTEON CPUs
Date:   Thu, 15 Jun 2023 11:39:33 +0200
Message-Id: <20230615093933.121329-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro cpu_has_mips_r2_exec_hazard correctly handles OCTEON CPUs,
so we don't need the extra switch cases for them.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/mm/tlbex.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 80e05ee98d62..8d514a9082c6 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2123,16 +2123,8 @@ static void build_r4000_tlb_load_handler(void)
 
 		uasm_i_tlbr(&p);
 
-		switch (current_cpu_type()) {
-		case CPU_CAVIUM_OCTEON:
-		case CPU_CAVIUM_OCTEON_PLUS:
-		case CPU_CAVIUM_OCTEON2:
-			break;
-		default:
-			if (cpu_has_mips_r2_exec_hazard)
-				uasm_i_ehb(&p);
-			break;
-		}
+		if (cpu_has_mips_r2_exec_hazard)
+			uasm_i_ehb(&p);
 
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
@@ -2197,16 +2189,8 @@ static void build_r4000_tlb_load_handler(void)
 
 		uasm_i_tlbr(&p);
 
-		switch (current_cpu_type()) {
-		case CPU_CAVIUM_OCTEON:
-		case CPU_CAVIUM_OCTEON_PLUS:
-		case CPU_CAVIUM_OCTEON2:
-			break;
-		default:
-			if (cpu_has_mips_r2_exec_hazard)
-				uasm_i_ehb(&p);
-			break;
-		}
+		if (cpu_has_mips_r2_exec_hazard)
+			uasm_i_ehb(&p);
 
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
-- 
2.35.3

