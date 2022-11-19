Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D93630E72
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiKSLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKSLcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:32:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A21C900;
        Sat, 19 Nov 2022 03:32:09 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A7057FF805;
        Sat, 19 Nov 2022 11:32:00 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     krzysztof.kozlowski+dt@linaro.org, paulus@samba.org,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        segher@kernel.crashing.org, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org,
        joel@jms.id.au
Subject: [PATCH v4 09/11] powerpc: espresso processor support
Date:   Sat, 19 Nov 2022 22:30:39 +1100
Message-Id: <20221119113041.284419-10-ash@heyquark.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119113041.284419-1-ash@heyquark.com>
References: <20220628133144.142185-1-ash@heyquark.com>
 <20221119113041.284419-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a cputable entry for the "Espresso" processor found on the Nintendo
Wii U, which has a PVR unrelated to other 750CL-like chips.
Only this revision has been seen in the wild.

Signed-off-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Signed-off-by: Ash Logan <ash@heyquark.com>
---
v3->v4: Move to new cpu_specs_*.h file.

 arch/powerpc/kernel/cpu_specs_book3s_32.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_specs_book3s_32.h b/arch/powerpc/kernel/cpu_specs_book3s_32.h
index 3714634d194a..c3cc0a019ba8 100644
--- a/arch/powerpc/kernel/cpu_specs_book3s_32.h
+++ b/arch/powerpc/kernel/cpu_specs_book3s_32.h
@@ -275,6 +275,21 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
+	{	/* "Espresso" (750CL-like) */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x70010201,
+		.cpu_name		= "Espresso",
+		.cpu_features		= CPU_FTRS_750CL,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
+		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
+		.platform		= "ppc750",
+	},
 	{	/* 745/755 */
 		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x00083000,
-- 
2.38.1

