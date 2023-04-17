Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4386E54C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDQWsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDQWsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480F49CA;
        Mon, 17 Apr 2023 15:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE88621D4;
        Mon, 17 Apr 2023 22:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A28C4339C;
        Mon, 17 Apr 2023 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681771695;
        bh=u6/6uW/rx2JuHFXB4ndkciesh2ZCckbEAGctN29yNms=;
        h=From:To:Cc:Subject:Date:From;
        b=hgqOWDCDp/NaH+YIS/4Z4iD3atlZii3Ycud9CfBx5sJ/DkOBPyM1qJBsrBvLlcWp2
         iREMhw0G0lKtO2g+CT/BrHyaaHCJqxnF7r3GP8qVXW1slRrnP5D0pS5aQHAA7bDM3x
         RkD1nxA1siEwh7iH9HXYlCyBNrtjR8ZsjjEQLTLG3+xSodqxeNa0pIo9C3gb2ypglY
         IeM1E48I/m8OXCXdp/UfrtisOtSvjFYLeJjzG9XvKbVa8os61IrsG5jqc0lgfQ0ZHO
         tPTDO25isdgTSy47d2BAaWaGHMq85oVmPZiq5vrkAY0o+4uaaauaytrELYLYJL4ckh
         gvsCKPVybH5jA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] module: fix building stats for 32-bit targets
Date:   Tue, 18 Apr 2023 00:48:04 +0200
Message-Id: <20230417224810.2922059-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

The new module statistics code mixes 64-bit types and wordsized 'long'
variables, which leads to build failures on 32-bit architectures:

kernel/module/stats.c: In function 'read_file_mod_stats':
kernel/module/stats.c:291:29: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
  291 |  total_size = atomic64_read(&total_mod_size);
x86_64-linux-ld: kernel/module/stats.o: in function `read_file_mod_stats':
stats.c:(.text+0x2b2): undefined reference to `__udivdi3'

To fix this, the code has to use one of the two types consistently.

Change them all to word-size types here.

Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use long instead of u64 everywheren
---
 kernel/module/stats.c | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index bbf90190a3fe..cdcd60695399 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -280,8 +280,8 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 	unsigned int len, size, count_failed = 0;
 	char *buf;
 	u32 live_mod_count, fkreads, fdecompress, fbecoming, floads;
-	u64 total_size, text_size, ikread_bytes, ibecoming_bytes, idecompress_bytes, imod_bytes,
-	    total_virtual_lost;
+	unsigned long total_size, text_size, ikread_bytes, ibecoming_bytes,
+		idecompress_bytes, imod_bytes, total_virtual_lost;
 
 	live_mod_count = atomic_read(&modcount);
 	fkreads = atomic_read(&failed_kreads);
@@ -289,12 +289,12 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 	fbecoming = atomic_read(&failed_becoming);
 	floads = atomic_read(&failed_load_modules);
 
-	total_size = atomic64_read(&total_mod_size);
-	text_size = atomic64_read(&total_text_size);
-	ikread_bytes = atomic64_read(&invalid_kread_bytes);
-	idecompress_bytes = atomic64_read(&invalid_decompress_bytes);
-	ibecoming_bytes = atomic64_read(&invalid_becoming_bytes);
-	imod_bytes = atomic64_read(&invalid_mod_bytes);
+	total_size = atomic_long_read(&total_mod_size);
+	text_size = atomic_long_read(&total_text_size);
+	ikread_bytes = atomic_long_read(&invalid_kread_bytes);
+	idecompress_bytes = atomic_long_read(&invalid_decompress_bytes);
+	ibecoming_bytes = atomic_long_read(&invalid_becoming_bytes);
+	imod_bytes = atomic_long_read(&invalid_mod_bytes);
 
 	total_virtual_lost = ikread_bytes + idecompress_bytes + ibecoming_bytes + imod_bytes;
 
@@ -315,27 +315,27 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 
 	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Mods failed on load", floads);
 
-	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Total module size", total_size);
-	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Total mod text size", text_size);
+	len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Total module size", total_size);
+	len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Total mod text size", text_size);
 
-	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed kread bytes", ikread_bytes);
+	len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Failed kread bytes", ikread_bytes);
 
-	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed decompress bytes",
+	len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Failed decompress bytes",
 			 idecompress_bytes);
 
-	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed becoming bytes", ibecoming_bytes);
+	len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Failed becoming bytes", ibecoming_bytes);
 
-	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Failed kmod bytes", imod_bytes);
+	len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Failed kmod bytes", imod_bytes);
 
-	len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Virtual mem wasted bytes", total_virtual_lost);
+	len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Virtual mem wasted bytes", total_virtual_lost);
 
 	if (live_mod_count && total_size) {
-		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average mod size",
+		len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Average mod size",
 				 DIV_ROUND_UP(total_size, live_mod_count));
 	}
 
 	if (live_mod_count && text_size) {
-		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average mod text size",
+		len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Average mod text size",
 				 DIV_ROUND_UP(text_size, live_mod_count));
 	}
 
@@ -348,25 +348,25 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 
 	WARN_ON_ONCE(ikread_bytes && !fkreads);
 	if (fkreads && ikread_bytes) {
-		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail kread bytes",
+		len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Avg fail kread bytes",
 				 DIV_ROUND_UP(ikread_bytes, fkreads));
 	}
 
 	WARN_ON_ONCE(ibecoming_bytes && !fbecoming);
 	if (fbecoming && ibecoming_bytes) {
-		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail becoming bytes",
+		len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Avg fail becoming bytes",
 				 DIV_ROUND_UP(ibecoming_bytes, fbecoming));
 	}
 
 	WARN_ON_ONCE(idecompress_bytes && !fdecompress);
 	if (fdecompress && idecompress_bytes) {
-		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Avg fail decomp bytes",
+		len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Avg fail decomp bytes",
 				 DIV_ROUND_UP(idecompress_bytes, fdecompress));
 	}
 
 	WARN_ON_ONCE(imod_bytes && !floads);
 	if (floads && imod_bytes) {
-		len += scnprintf(buf + len, size - len, "%25s\t%llu\n", "Average fail load bytes",
+		len += scnprintf(buf + len, size - len, "%25s\t%lu\n", "Average fail load bytes",
 				 DIV_ROUND_UP(imod_bytes, floads));
 	}
 
@@ -387,8 +387,8 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list) {
 		if (WARN_ON_ONCE(++count_failed >= MAX_FAILED_MOD_PRINT))
 			goto out_unlock;
-		len += scnprintf(buf + len, size - len, "%25s\t%15llu\t%25s\n", mod_fail->name,
-				 atomic64_read(&mod_fail->count), mod_fail_to_str(mod_fail));
+		len += scnprintf(buf + len, size - len, "%25s\t%15lu\t%25s\n", mod_fail->name,
+				 atomic_long_read(&mod_fail->count), mod_fail_to_str(mod_fail));
 	}
 out_unlock:
 	mutex_unlock(&module_mutex);
-- 
2.39.2

