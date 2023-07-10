Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E03174DC44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGJRXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjGJRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:23:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F7C4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689009778;
        bh=Po8zatGdqlYMZWOZUJg6IjuWUDm0hMZ3hfIyOjTmbbA=;
        h=From:Date:Subject:To:Cc:From;
        b=inHcvuHgJ6+kGglivZs+J5puItQ/9KKRtdW4br3T8Wj5PZ8ofQIXRsUryd28xMPrB
         xxtn6A+NEvS66/jVTHg22sJHvPzfJTaA4xnx1ImAmQvv7ZqlR32hWspayqicXHkSpn
         HB3lQJmPf5kLh2fA1EGRnUQM4CDo8MirfNqRqZ40=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 10 Jul 2023 19:22:53 +0200
Subject: [PATCH] tools/nolibc: completely remove optional environ support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230710-nolibc-environ-v1-1-173831573af6@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGw+rGQC/x3MTQqAIBBA4avIrBP8yaKuEi3KphqIMRQkCO+et
 PwW772QMBImGMULETMlClyhGwH+XPhASVs1GGWs6rWSHC5avUTOFAPLfthb4zx21rVQozviTs8
 /nOZSPrDxIJBgAAAA
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689009774; l=3008;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Po8zatGdqlYMZWOZUJg6IjuWUDm0hMZ3hfIyOjTmbbA=;
 b=41gS/HHhHLxlE9tEok/zIl0587jw7tWgppPEkfHInFScwMONZQMd1GgNhT164GZSOmVQTcZnB
 LVa0Y71qSheC4WyGwPdV4NK2Y8nfzA49DcMpX9TBM4vymxf/ENvb1Us
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 52e423f5b93e ("tools/nolibc: export environ as a weak symbol on i386")
and friends the asm startup logic was extended to directly populate the
"environ" array.

This makes it impossible for "environ" to be dropped by the linker.
Therefore also drop the other logic to handle non-present "environ".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Note:

Given that nowadays both _auxv and environ are mandatory symbols imposed
by nolibc of pointer size does it make sense to keep the code to make
int-sized errno optional?
---
 tools/include/nolibc/stdlib.h                | 12 ++----------
 tools/testing/selftests/nolibc/nolibc-test.c |  7 +------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 902162f80337..bacfd35c5156 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -83,11 +83,10 @@ void free(void *ptr)
  * declared as a char **, and must be terminated by a NULL (it is recommended
  * to set this variable to the "envp" argument of main()). If the requested
  * environment variable exists its value is returned otherwise NULL is
- * returned. getenv() is forcefully inlined so that the reference to "environ"
- * will be dropped if unused, even at -O0.
+ * returned.
  */
 static __attribute__((unused))
-char *_getenv(const char *name, char **environ)
+char *getenv(const char *name)
 {
 	int idx, i;
 
@@ -102,13 +101,6 @@ char *_getenv(const char *name, char **environ)
 	return NULL;
 }
 
-static __inline__ __attribute__((unused,always_inline))
-char *getenv(const char *name)
-{
-	extern char **environ;
-	return _getenv(name, environ);
-}
-
 static __attribute__((unused))
 unsigned long getauxval(unsigned long type)
 {
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 486334981e60..7f4611ce1795 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -40,9 +40,6 @@
 #endif
 #endif
 
-/* will be used by nolibc by getenv() */
-char **environ;
-
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -939,7 +936,7 @@ static const struct test test_names[] = {
 	{ 0 }
 };
 
-int main(int argc, char **argv, char **envp)
+int main(int argc, char **argv)
 {
 	int min = 0;
 	int max = INT_MAX;
@@ -948,8 +945,6 @@ int main(int argc, char **argv, char **envp)
 	int idx;
 	char *test;
 
-	environ = envp;
-
 	/* when called as init, it's possible that no console was opened, for
 	 * example if no /dev file system was provided. We'll check that fd#1
 	 * was opened, and if not we'll attempt to create and open /dev/console

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230710-nolibc-environ-79f425ce6354

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

