Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B208572D0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjFLUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFLUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5783B1FDD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4FB662F10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F55AC4331F;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=RJIxQIPv98cFdGnQ5M/j79pA+ccw3K7v8tVhytUfcWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdmqTYvSUtUw3pB9G4iaZtzICMezEbOlxH6Bnzksv0VfFchRRj6VfiF/CoPMuMR98
         lhrv+xcBc/gDnBOkPiJiO1fs1PAaxSWIt+/VmMeW9EgqxRCX6868XqlxwjdwXRnZ4k
         AnLMDQkh/kdSjsYmlXySZJNsLPlTT15DdZo57zw7smoZLkSH5yM14WUdDGYxHrm4rD
         wxmmJ/dUSVvPQBM7afo4CT4t1MAdIpLs9GSR7qg6xXabsiVmazTOVKNHsJv1UbqJMB
         9DFApRo9x5zixvARzzF6lK9ukRWqzWHbl8kpPKwJ1GR956dOSuRHUtwmkoIxvDEahT
         x+LP+fsFUurhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF55FCE3A7A; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 31/53] tools/nolibc: simplify stackprotector compiler flags
Date:   Mon, 12 Jun 2023 13:44:52 -0700
Message-Id: <20230612204514.292087-31-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Now that nolibc enable stackprotector support automatically when the
compiler enables it we only have to get the -fstack-protector flags
correct.

The cc-options are structured so that -fstack-protector-all is only
enabled if -mstack-protector=guard works, as that is the only mode
supported by nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index bd41102ea299..47c3c89092e4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -76,21 +76,11 @@ else
 Q=@
 endif
 
-CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
-			$(call cc-option,-mstack-protector-guard=global) \
-			$(call cc-option,-fstack-protector-all)
-CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
+CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
+		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
 help:
-- 
2.40.1

