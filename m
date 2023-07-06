Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7082D749512
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjGFFuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:50:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C36110
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688622613; x=1720158613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w6/BBpGC9o6TMtXs4FPV+zb5Oys3dj7edttjfM+T3Mw=;
  b=LSS5NONWXJKLNGkMKCuGFNZcNd8BvO9C8u7pZi8qEcS8szSFGY2lZPfl
   hHeJHFdikCrM++Ny+D0PhSLxoduSSzmXhqAl1NTXqFJJg9KbKekoIu+wW
   GO3oA7P2euTsUpj8n7dngl8HAO3UkhPTFPF0EQjNBt494mojrXzMxdr4B
   inY7Jdk50usDBVNtN74ZilDkHcbWqFwtqVpiZfgh2OOJzy/9AT8EXmUlW
   C8ku/Qj3PwP9FqWuDgiBxFVCAoNqE1Igz9VoLrHXbXsRra/vT8uIzY5Tj
   3ETeUwTDh3FRq0bMQyHpadmXFbUIresocPijXhp9AXtc4J8kRYo1ivhv+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362383031"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="362383031"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 22:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719479867"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719479867"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2023 22:50:12 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, brgerst@gmail.com,
        ebiederm@xmission.com, xin3.li@intel.com
Subject: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Date:   Wed,  5 Jul 2023 22:22:31 -0700
Message-Id: <20230706052231.2183-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a null selector is to be loaded into a segment register,
reload_segments() sets its DPL bits to 3. Later when an IRET
instruction loads it, it zeros the segment register. The two
operations offset each other to actually effect a nop.

Fix it by not modifying the DPL bits for a null selector.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kernel/signal_32.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc088f97..7796cf84fca2 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -36,22 +36,27 @@
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/ia32_unistd.h>
 
+static inline u16 usrseg(u16 sel)
+{
+	return sel <= 3 ? sel : sel | 3;
+}
+
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
 	unsigned int cur;
 
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
+	if (usrseg(sc->gs) != cur)
+		load_gs_index(usrseg(sc->gs));
 	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
+	if (usrseg(sc->fs) != cur)
+		loadsegment(fs, usrseg(sc->fs));
 	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
+	if (usrseg(sc->ds) != cur)
+		loadsegment(ds, usrseg(sc->ds));
 	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	if (usrseg(sc->es) != cur)
+		loadsegment(es, usrseg(sc->es));
 }
 
 #define sigset32_t			compat_sigset_t
-- 
2.34.1

