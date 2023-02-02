Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F7687A23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjBBKZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjBBKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:25:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433E10433
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D83FAB8247A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B94C433EF;
        Thu,  2 Feb 2023 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675333540;
        bh=Gb3T6TsLfV5TwqGHgvcKYvFwI4gAsDkyqVqCfdmHoKw=;
        h=From:To:Cc:Subject:Date:From;
        b=DPpuP0HWq3SUWfvJp0qzlvYHWj9A4nfE0PfUhgnnwtEIO5/IfCGazWW6T453qZLJu
         mRhd9CfsQMaL6hmPr6APq+RFjTFIaVmwL5ICcrGJLo5lFSuFpemdyxWsEf3ZJ9kbgr
         0BVK9I1B1Srh/H/xt8LU0KfQuGvqpVFkygv9KRCShj6RTOVJyOkKIqu/erDM1OeHiy
         dMwoa0//0pC34elUZEM9ImnCTaNF9sO9e8Zkmyce+LrsKKN3+76vBCsm/AsOkb7zTn
         YWSSw4LyM+pTLMbszWohMM4+kHWjp26NRizRMTB0dbCS+EDDG78Z9khedCRjpommt/
         kqAAeU8b9aKMQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: proc-v7: fix out-of-range adr instruction
Date:   Thu,  2 Feb 2023 11:25:32 +0100
Message-Id: <20230202102538.999026-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Before the change to CONFIG_ARCH_MULTIPLATFORM, some CONFIG_ARM_ERRATA_*
options were always hidden, but now they are user visible in expert
configurations, which caused a compile-time failure in randconfig
builds with all of the errata enabled.

arch/arm/mm/proc-v7.S:545: Error: invalid constant (fffffffffffffbf4) after fixup
/tmp/proc-v7-5b364b.s:1611:2: error: out of range pc-relative fixup value
 adr r3, v7_crval

The problem is that the extra code size puts the v7_crval definition just
outside of the range of the 'adr' instruction. Use the adr_l macro instead
to allow longer offsets.

Fixes: 84fc86360623 ("ARM: make ARCH_MULTIPLATFORM user-visible")
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/proc-v7.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6b4ef9539b68..fe1469aa5be5 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -544,7 +544,7 @@ __errata_finish:
 	mcr	p14, 6, r0, c0, c0, 0		@ stop userspace TEEHBR access
 1:
 #endif
-	adr	r3, v7_crval
+	adr_l	r3, v7_crval
 	ldmia	r3, {r3, r6}
  ARM_BE8(orr	r6, r6, #1 << 25)		@ big-endian page tables
 #ifdef CONFIG_SWP_EMULATE
-- 
2.39.0

