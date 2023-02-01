Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE3687194
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBAXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBAXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:00:25 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973976C114;
        Wed,  1 Feb 2023 15:00:23 -0800 (PST)
From:   Sam James <sam@gentoo.org>
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: [PATCH] gcc-plugins: drop -std=gnu++11 to fix GCC 13 build
Date:   Wed,  1 Feb 2023 23:00:09 +0000
Message-Id: <20230201230009.2252783-1-sam@gentoo.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest GCC 13 snapshot (13.0.1 20230129) gives the following:
```
cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
 :./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: tree_code_type
```

This ends up being because of https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=b0241ce6e37031
upstream in GCC which changes the visibility of some types used by the kernel's
plugin infrastructure like tree_code_type.

After discussion with the GCC folks, we found that the kernel needs to be building
plugins with the same flags used to build GCC - and GCC defaults to gnu++17
right now. The minimum GCC version needed to build the kernel is GCC 5.1
and GCC 5.1 already defaults to gnu++14 anyway, so just drop the flag, as
all GCCs that could be used to build GCC already default to an acceptable
version which was >= the version we forced via flags until now.

Bug: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108634
Signed-off-by: Sam James <sam@gentoo.org>
---
 scripts/gcc-plugins/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index b34d11e22636..320afd3cf8e8 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -29,7 +29,7 @@ GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
 		  -include $(srctree)/include/linux/compiler-version.h \
 		  -DPLUGIN_VERSION=$(call stringify,$(KERNELVERSION)) \
-		  -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
+		  -I $(GCC_PLUGINS_DIR)/include -I $(obj) \
 		  -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
 		  -ggdb -Wno-narrowing -Wno-unused-variable \
 		  -Wno-format-diag
-- 
2.39.1

