Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68C374DCF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjGJSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGJSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:01:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C012A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689012096;
        bh=DcJOOQNmpUkNsP7qakyEiaMLq0aFN20n09sMnLh0WJ4=;
        h=From:Date:Subject:To:Cc:From;
        b=inTSR+fC6JNiWyjaGmdlROBmV5GQmj8KYjMLrLokVlVSq7gVhz8bpIZ/ziBrQQWy3
         8oYqX8xMxyfIjHf/S1NzdikS7asiAv4pg3NJbVAIAZqjMsjjd8q2hymHM+NFCwYPs2
         0VHi16TQYUG5RP+ySMD03uWKE95PwMV1D0F8qps4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 10 Jul 2023 20:01:34 +0200
Subject: [PATCH v2] tools/nolibc: completely remove optional environ
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230710-nolibc-environ-v2-1-78b0c465338f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAH1HrGQC/3WMQQ7CIBBFr9LMWkyBtqgr72G6qDjIJAYapqKm4
 e5i9+av3k/eW4ExETKcmhUSZmKKoYLaNWD9FO4o6FYZVKt0a2QrQnzQ1QoMmVIMwhxdp3qLg+4
 7qNKc0NF7C17Gyp54iemz9bP8vX9TWYo6ow9a9kZPbji/kJjZ+qffB1xgLKV8AXmvCKixAAAA
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689012095; l=3528;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DcJOOQNmpUkNsP7qakyEiaMLq0aFN20n09sMnLh0WJ4=;
 b=Ppz+7R6x3mnslqtdyf1zkfkfIxxQdSB9z6qcdjHlHJ2GNdNTzDwViyi34/CYTIde8nDbxg3/l
 /GsU0anWGehD/eHi2F3HVUEhN09NXsFvhmpbRTDJKCdXYOUjCvjHTRy
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

Also add a testcase to validate the initialization of environ.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- add testcase to validate initialization and naming of environ as
  suggested by Willy
- Link to v1: https://lore.kernel.org/r/20230710-nolibc-environ-v1-1-173831573af6@weissschuh.net
---
 tools/include/nolibc/stdlib.h                | 12 ++----------
 tools/testing/selftests/nolibc/nolibc-test.c |  7 ++++---
 2 files changed, 6 insertions(+), 13 deletions(-)

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
index ec0c20df76b2..f357bd815abc 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -44,8 +44,8 @@
 #define SINT_MAX_OF_TYPE(type) (((type)1 << (sizeof(type) * 8 - 2)) - (type)1 + ((type)1 << (sizeof(type) * 8 - 2)))
 #define SINT_MIN_OF_TYPE(type) (-SINT_MAX_OF_TYPE(type) - 1)
 
-/* will be used by nolibc by getenv() */
-char **environ;
+/* will be used to test initialization of environ */
+static char **test_envp;
 
 /* will be used by some test cases as readable file, please don't write it */
 static const char *argv0;
@@ -786,6 +786,7 @@ int run_stdlib(int min, int max)
 		 * test numbers.
 		 */
 		switch (test + __LINE__ + 1) {
+		CASE_TEST(environ);            EXPECT_PTREQ(1, environ, test_envp); break;
 		CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
 		CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
 		CASE_TEST(setcmp_blah_blah);   EXPECT_EQ(1, strcmp("blah", "blah"), 0); break;
@@ -1119,7 +1120,7 @@ int main(int argc, char **argv, char **envp)
 	char *test;
 
 	argv0 = argv[0];
-	environ = envp;
+	test_envp = envp;
 
 	/* when called as init, it's possible that no console was opened, for
 	 * example if no /dev file system was provided. We'll check that fd#1

---
base-commit: c9851cc968ac2ed87b83aee0cbec476b07d53a4c
change-id: 20230710-nolibc-environ-79f425ce6354

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

