Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC71660424
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjAFQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjAFQSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:18:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50906E0E3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54831B81CDF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C995AC433EF;
        Fri,  6 Jan 2023 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673021919;
        bh=EW8VuLXuuvlzNJq2/6iUnL9lcYqvzUPKSTREGokX3kI=;
        h=From:To:Cc:Subject:Date:From;
        b=HWIboicRvlNnrdhhsFnP8Pt2gC3Ez0wa38mafawyZrpy3DuaXROymSItelLUKxD1E
         y8B2bJS91YNb5G70mQyrXKTm0mW6ZvencIL1OTCwVejBxSof2BwACNK9AGf1q5u56M
         M9v9sLGoFxfn+fOEZVbJpGy4H3l466M5X6U5xBnLcqepsKu+gIyQeRnqaz2vgiaOk+
         rQOYHlO4mYS7hV/TUZ/bGOvjPahVaO/uD//iaSRiKi9NZ7TliQ2NfMBg3alAVrVR8j
         SBmJP/rV13lN9+Df89xkW6hAPgOMO3jTPlBzCFrvbfd+ME3Myk2KsvfhoH/kUeJs/O
         wkoMzLyDbH66Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: include <asm/pgtable.h> from proc-macros.S to fix -Wundef warnings
Date:   Sat,  7 Jan 2023 01:18:21 +0900
Message-Id: <20230106161821.2374823-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Since commit 80b6093b55e3 ("kbuild: add -Wundef to KBUILD_CPPFLAGS
for W=1 builds"), building with W=1 detects -Wundef warnings for
assembly code.

  $ make W=1 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  arch/arm/mm/
    [snip]
    AS      arch/arm/mm/cache-v7.o
  In file included from arch/arm/mm/cache-v7.S:17:
  arch/arm/mm/proc-macros.S:109:5: warning: "L_PTE_SHARED" is not defined, evaluates to 0 [-Wundef]
    109 | #if L_PTE_SHARED != PTE_EXT_SHARED
        |     ^~~~~~~~~~~~
  arch/arm/mm/proc-macros.S:109:21: warning: "PTE_EXT_SHARED" is not defined, evaluates to 0 [-Wundef]
    109 | #if L_PTE_SHARED != PTE_EXT_SHARED
        |                     ^~~~~~~~~~~~~~
  arch/arm/mm/proc-macros.S:113:10: warning: "L_PTE_XN" is not defined, evaluates to 0 [-Wundef]
    113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
        |          ^~~~~~~~
  arch/arm/mm/proc-macros.S:113:19: warning: "L_PTE_USER" is not defined, evaluates to 0 [-Wundef]
    113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
        |                   ^~~~~~~~~~
  arch/arm/mm/proc-macros.S:113:30: warning: "L_PTE_RDONLY" is not defined, evaluates to 0 [-Wundef]
    113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
        |                              ^~~~~~~~~~~~
  arch/arm/mm/proc-macros.S:113:43: warning: "L_PTE_DIRTY" is not defined, evaluates to 0 [-Wundef]
    113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
        |                                           ^~~~~~~~~~~
  arch/arm/mm/proc-macros.S:113:55: warning: "L_PTE_YOUNG" is not defined, evaluates to 0 [-Wundef]
    113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
        |                                                       ^~~~~~~~~~~
  arch/arm/mm/proc-macros.S:114:10: warning: "L_PTE_PRESENT" is not defined, evaluates to 0 [-Wundef]
    114 |          L_PTE_PRESENT) > L_PTE_SHARED
        |          ^~~~~~~~~~~~~
  arch/arm/mm/proc-macros.S:114:27: warning: "L_PTE_SHARED" is not defined, evaluates to 0 [-Wundef]
    114 |          L_PTE_PRESENT) > L_PTE_SHARED
        |                           ^~~~~~~~~~~~

Include <asm/pgtable.h> from proc-macros.S to fix the warnings.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v6.2-rc1


 arch/arm/mm/proc-macros.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index fa6999e24b07..e43f6d716b4b 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -6,6 +6,7 @@
  *  VM_EXEC
  */
 #include <asm/asm-offsets.h>
+#include <asm/pgtable.h>
 #include <asm/thread_info.h>
 
 #ifdef CONFIG_CPU_V7M
-- 
2.34.1

