Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A66B424F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCJOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCJOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:01:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890011151D5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:01:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA485B822BF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1651DC433EF;
        Fri, 10 Mar 2023 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456898;
        bh=mKGr1ypxxF+X86Tp40In+ocfizQZWE08+13VDMyFtKs=;
        h=From:To:Cc:Subject:Date:From;
        b=kAwUaG4HVbRtWn1cBmNVqoVVPq5YkHkTAg4VjF9d8uYVG73w+fp0TUHlrqIp2T0YB
         6bg7nlfFYU0Fk0WkXPCovchICKr5neGoOdcTYn32+LBtZoHaY7jMt7bAAN1niYl47A
         rE/Y9v1i4JTXQmwBWP8EckehUbM6Fc87SJrvuD5sZdac5e/ObEgcTXcSA+nI/7Y8kn
         Gdyip129SVoRtTeYQB6lZKfrywBPofiR2MqT+uarenABArCPc9WuaVA+a2utgMtamy
         G8M1n8rzhysT2qmJI+l35iX9VBQclUDeaotFhg9qXYpbcu/7d6oEu4nw9w0bw3qQTu
         y3+seKYb2ThjA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dyndbg: allow including dyndbg.h in decompressor
Date:   Fri, 10 Mar 2023 15:01:26 +0100
Message-Id: <20230310140133.291594-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

After a change to linux/module.h, dyndbg.h is now included
indirectly from the decompressor for lz4 support, which in turn
causes a build failure on 32-bit Arm:

In file included from include/linux/module.h:30,
                 from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
                 from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                 from arch/arm/boot/compressed/decompress.c:59:
include/linux/dynamic_debug.h: In function 'ddebug_dyndbg_module_param_cb':
include/linux/dynamic_debug.h:307:14: error: implicit declaration of function 'strcmp' [-Werror=implicit-function-declaration]
  307 |         if (!strcmp(param, "dyndbg")) {
      |              ^~~~~~
include/linux/dynamic_debug.h:1:1: note: 'strcmp' is defined in header '<string.h>'; did you forget to '#include <string.h>'?
  +++ |+#include <string.h>

The decompressor has its own replacement for the linux/string.h contents,
so the normal declaration is not visible here. Since the function is
not actually called, it is sufficient to add a declaration, and this
is in fact the correct one as it matches the definition in
arch/arm/boot/compressed/string.c.

Fixes: 7deabd674988 ("dyndbg: use the module notifier callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patch that caused the problem is in linux-next, maybe fold
the fix into that patch if possible
---
 arch/arm/boot/compressed/decompress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 74255e819831..0669851394f0 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -31,6 +31,7 @@
 /* Not needed, but used in some headers pulled in by decompressors */
 extern char * strstr(const char * s1, const char *s2);
 extern size_t strlen(const char *s);
+extern int strcmp(const char *cs, const char *ct);
 extern int memcmp(const void *cs, const void *ct, size_t count);
 extern char * strchrnul(const char *, int);
 
-- 
2.39.2

