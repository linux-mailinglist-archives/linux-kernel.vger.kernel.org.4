Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3451970FBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjEXQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjEXQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:27:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30FD3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:27:13 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684945631;
        bh=+yjURdh4Gw0iv1zcKNP9yQwERjDy1N0llqhBN14GwCE=;
        h=From:Date:Subject:To:Cc:From;
        b=Yie6dcFb92zaoqR5XDD15VqsLdK+8pEe7mvg4HqAGcxB1BKqaRzh9pV0FxGhd1lHn
         qosPbKhnDAjE9+XQf5m90Xq8b/zXztc19zxbeqlDOyzLnjgtK2N5xTtTYVhkDl11wK
         bCNPkwbjKqInt0NmmbIodNe5pkvzdLQWTW5M5ITI=
Date:   Wed, 24 May 2023 18:27:06 +0200
Subject: [PATCH] tools/nolibc: s390: disable stackprotector in _start
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230524-nolibc-stackprotector-s390-v1-1-5044d42230cc@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANk6bmQC/x2NQQrCMBAAv1L27ELaWqV+RXpI1o1dDEnZjSKU/
 t3gceYws4OxChvcuh2UP2JScoP+1AGtPj8Z5dEYBjeMbhrOmEuSQGjV02vTUplqUbRxdugCTdT
 P1xgvEVogeGMM6jOtLZHfKTW5KUf5/o/35Th+XSJ/1YEAAAA=
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684945631; l=1601;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+yjURdh4Gw0iv1zcKNP9yQwERjDy1N0llqhBN14GwCE=;
 b=dXurvyihFtDs0PtghqpB8PY+aMcTnNDj5C1pt/iKH7qecQaqDHFm+TC2ACbpZ1tmcFFZliG+M
 0qj+FFuBbiSDixGLGivgKWmJcRgM0IQZThrOLz1dE5Vy2GBNArxwuSL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390 does not support the "global" stack protector mode that is
implemented in nolibc.

Now that nolibc detects if stack protectors are enabled at runtime it
could happen that a future compiler does indeed use global mode on
and nolibc would compile but segfault at runtime.

To avoid this hypothetic case and to align s390 with the other
architectures disable stack protectors when compiling _start().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-s390.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index a738e7f3f8e8..516dff5bff8b 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -8,6 +8,8 @@
 #include <asm/signal.h>
 #include <asm/unistd.h>
 
+#include "compiler.h"
+
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
  * syscall returns 116 bytes and stops in the middle of __unused.
  */
@@ -164,7 +166,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"lg	%r2,0(%r15)\n"		/* argument count */

---
base-commit: d5d0994c2f3cae2d2bdc04b98c6212e72efe0509
change-id: 20230524-nolibc-stackprotector-s390-0bc5c197ff6f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

