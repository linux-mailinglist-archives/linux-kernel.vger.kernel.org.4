Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4552D72D0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjFLUri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFLUqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9651FC3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D2C62B22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39158C4339C;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=C0Q9VdND465nWzuW7Df4EbGHS4KOUK1apvejVVAdFFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6fYIoJGMAm3UTo2yCUg3fgy7OIk/4lbO/m4uQ+SBzI55BlWwzUSeTUQ+cGFjMAdj
         44ZI6dKQ65olNT7ZqX4pTfbluehPWrbtlYjrRsei2mKkt9RctqwK4TD/vH51IYjBV2
         BHPQiBJgrzivsCMsyrT5XyaJuBT2f2wAHec/mtlLxd4/awVHi4aXr3TdqzFJdqnAIq
         SF9WmLkwiIJcB8ubljzjIKj5Dos88OKP62o5nH1sC5IlgTmPxyk0fylzuVIytR3dIU
         mx/2S1gM5enhpoUd7TNnCTa7UNdVtgrmJ5GpBn0VcFPPOR0DhqUS2CLQv10yJPp/Ag
         cMiEj+pPyq9vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B1F69CE3A1E; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 04/53] tools/nolibc: add libc-test binary
Date:   Mon, 12 Jun 2023 13:44:25 -0700
Message-Id: <20230612204514.292087-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

This can be used to easily compare the behavior of nolibc to the system
libc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/.gitignore | 1 +
 tools/testing/selftests/nolibc/Makefile   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
index 4696df589d68..52f613cdad54 100644
--- a/tools/testing/selftests/nolibc/.gitignore
+++ b/tools/testing/selftests/nolibc/.gitignore
@@ -1,4 +1,5 @@
 /initramfs/
+/libc-test
 /nolibc-test
 /run.out
 /sysroot/
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index bbce57420465..0cbe13809b37 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -94,6 +94,7 @@ help:
 	@echo "  help         this help"
 	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
 	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  libc-test    build an executable using the compiler's default libc instead"
 	@echo "  run-user     runs the executable under QEMU (uses \$$ARCH, \$$TEST)"
 	@echo "  initramfs    prepare the initramfs with nolibc-test"
 	@echo "  defconfig    create a fresh new default config (uses \$$ARCH)"
@@ -128,6 +129,9 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
 
+libc-test: nolibc-test.c
+	$(QUIET_CC)$(CC) -o $@ $<
+
 # qemu user-land test
 run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
@@ -159,6 +163,8 @@ clean:
 	$(Q)rm -rf sysroot
 	$(call QUIET_CLEAN, nolibc-test)
 	$(Q)rm -f nolibc-test
+	$(call QUIET_CLEAN, libc-test)
+	$(Q)rm -f libc-test
 	$(call QUIET_CLEAN, initramfs)
 	$(Q)rm -rf initramfs
 	$(call QUIET_CLEAN, run.out)
-- 
2.40.1

