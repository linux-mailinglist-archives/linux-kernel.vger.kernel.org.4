Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9BB6D39E4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjDBSsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjDBSsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:48:19 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6ECA65B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:48:18 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 332ImDkS012487;
        Sun, 2 Apr 2023 20:48:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/4] tools/nolibc: add libc-test binary
Date:   Sun,  2 Apr 2023 20:48:03 +0200
Message-Id: <20230402184806.12440-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230402184806.12440-1-w@1wt.eu>
References: <20230402184806.12440-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.17.5

