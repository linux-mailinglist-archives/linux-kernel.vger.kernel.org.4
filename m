Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D596640ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiLBQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiLBQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:30:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B49E3697
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:29:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 792D462320
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646A1C433D6;
        Fri,  2 Dec 2022 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669998533;
        bh=Pf5oJxPaCUXq/MkhRqDLU0HC91yoKf1DriJwDt3OALM=;
        h=From:To:Cc:Subject:Date:From;
        b=WpN3dhvsWIVma3mtdFNwqxTtzR1iHcliaUFUS0MIqbHWVzge1Opp/87bf8+FuVd0T
         /732mCB94RIpT3sPcSXSYvpxZKGoeIGEYoqXyFPQGoLYx610+Ool3UWImR7YvOy0nV
         uPurKJq5Dq7zpCzdRp1fga2hhoQf3KsuYPE9sIDVmlBasjf3jJsNpObyMkD1ITgogS
         lyqop2jfdSqjPf1slX0znpToHjExOBfR1knJwpBBcHY+en+SL5Ddccov/lCZMjY3yq
         MWTRkuLWFeP3NT2M2ic9co9+shoXj5/EsvK0wR9EmSRB/QNcyJRDJeOJuwsF7RRlUB
         KXfPE3l7RER3Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH next] arm64: alternatives: add __init/__initconst to some functions/variables
Date:   Sat,  3 Dec 2022 00:18:59 +0800
Message-Id: <20221202161859.2228-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
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

apply_alternatives_vdso(), __apply_alternatives_multi_stop() and
kernel_alternatives are not needed after booting, so mark the two
functions as __init and the var as __initconst.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 0f5eaa4c3a39..d32d4ed5519b 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -196,7 +196,7 @@ static void __apply_alternatives(const struct alt_region *region,
 	}
 }
 
-static void apply_alternatives_vdso(void)
+static void __init apply_alternatives_vdso(void)
 {
 	struct alt_region region;
 	const struct elf64_hdr *hdr;
@@ -220,7 +220,7 @@ static void apply_alternatives_vdso(void)
 	__apply_alternatives(&region, false, &all_capabilities[0]);
 }
 
-static const struct alt_region kernel_alternatives = {
+static const struct alt_region kernel_alternatives __initconst = {
 	.begin	= (struct alt_instr *)__alt_instructions,
 	.end	= (struct alt_instr *)__alt_instructions_end,
 };
@@ -229,7 +229,7 @@ static const struct alt_region kernel_alternatives = {
  * We might be patching the stop_machine state machine, so implement a
  * really simple polling protocol here.
  */
-static int __apply_alternatives_multi_stop(void *unused)
+static int __init __apply_alternatives_multi_stop(void *unused)
 {
 	/* We always have a CPU 0 at this point (__init) */
 	if (smp_processor_id()) {
-- 
2.38.1

