Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8B661F81
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbjAIH4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjAIHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:55:30 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B04213E0F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:55:28 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3097so3v026018;
        Mon, 9 Jan 2023 08:54:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4/6] tools/nolibc: fix missing includes causing build issues at -O0
Date:   Mon,  9 Jan 2023 08:54:40 +0100
Message-Id: <20230109075442.25963-5-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109075442.25963-1-w@1wt.eu>
References: <20230109075442.25963-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the nolibc includes were split to facilitate portability from
standard libcs, programs that include only what they need may miss
some symbols which are needed by libgcc. This is the case for raise()
which is needed by the divide by zero code in some architectures for
example.

Regardless, being able to include only the apparently needed files is
convenient.

Instead of trying to move all exported definitions to a single file,
since this can change over time, this patch takes another approach
consisting in including the nolibc header at the end of all standard
include files. This way their types and functions are already known
at the moment of inclusion, and including any single one of them is
sufficient to bring all the required ones.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/ctype.h  | 3 +++
 tools/include/nolibc/errno.h  | 3 +++
 tools/include/nolibc/signal.h | 3 +++
 tools/include/nolibc/stdio.h  | 3 +++
 tools/include/nolibc/stdlib.h | 3 +++
 tools/include/nolibc/string.h | 3 +++
 tools/include/nolibc/sys.h    | 2 ++
 tools/include/nolibc/time.h   | 3 +++
 tools/include/nolibc/types.h  | 3 +++
 tools/include/nolibc/unistd.h | 3 +++
 10 files changed, 29 insertions(+)

diff --git a/tools/include/nolibc/ctype.h b/tools/include/nolibc/ctype.h
index e3000b2992d7..6f90706d0644 100644
--- a/tools/include/nolibc/ctype.h
+++ b/tools/include/nolibc/ctype.h
@@ -96,4 +96,7 @@ int ispunct(int c)
 	return isgraph(c) && !isalnum(c);
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_CTYPE_H */
diff --git a/tools/include/nolibc/errno.h b/tools/include/nolibc/errno.h
index 06893d6dfb7a..9dc4919c769b 100644
--- a/tools/include/nolibc/errno.h
+++ b/tools/include/nolibc/errno.h
@@ -24,4 +24,7 @@ static int errno;
  */
 #define MAX_ERRNO 4095
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_ERRNO_H */
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index ef47e71e2be3..137552216e46 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -19,4 +19,7 @@ int raise(int signal)
 	return sys_kill(sys_getpid(), signal);
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_SIGNAL_H */
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index a3cebc4bc3ac..96ac8afc5aee 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -303,4 +303,7 @@ void perror(const char *msg)
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_STDIO_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 92378c4b9660..a24000d1e822 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -419,4 +419,7 @@ char *u64toa(uint64_t in)
 	return itoa_buffer;
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_STDLIB_H */
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index ad97c0d522b8..0932db3817d2 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -285,4 +285,7 @@ char *strrchr(const char *s, int c)
 	return (char *)ret;
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_STRING_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index ce3ee03aa679..78473d34e27c 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1243,5 +1243,7 @@ ssize_t write(int fd, const void *buf, size_t count)
 	return ret;
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
 
 #endif /* _NOLIBC_SYS_H */
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index d18b7661fdd7..84655361b9ad 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -25,4 +25,7 @@ time_t time(time_t *tptr)
 	return tv.tv_sec;
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_TIME_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index f1d64fca7cf0..fbbc0e68c001 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -209,4 +209,7 @@ struct stat {
 })
 #endif
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_TYPES_H */
diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 1c25e20ee360..1cfcd52106a4 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -51,4 +51,7 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #endif /* _NOLIBC_UNISTD_H */
-- 
2.35.3

