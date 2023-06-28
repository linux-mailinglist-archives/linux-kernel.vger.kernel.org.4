Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1559C740851
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjF1C0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjF1C0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:26:42 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37DD1FE8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z1zffectTB9rcW/9VvhqoyRjyFbnn/LHIsrcGrL4i7U=; b=J+fHCDGaN3Rcb9PYLQSdkAFK4p
        Efg4JzV2Wi/hMGarxH4xm6JjxYMO/0vKO/oIfjGGiWPoW+SdlWWfEiKL1oNxIe88fibpUlBvkeV2m
        ClF/l5moPDTM2geyGf6NQrSbNkHn2h1B9EPcYs6LHNOPEecct6KSpwijJvRcIPq3d1U4kDoNAtSFz
        67ex8M6dQJ9BggNaOaAT07tRCux43HyaY6RyMazPp/oiq/7gEaagtBCt1W56T1yIoEspIdMDg1U3v
        DpTxppLqqP0DCOsv34yqofivmqCJo8MiYJB0/IXB54OQeTa/31weRX1jklDZ7Wa6dMUxaUSrO6Vo9
        K+QqC4nA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1qEJm0-00GNA7-So; Wed, 28 Jun 2023 01:15:07 +0000
From:   linux@treblig.org
To:     sfrench@samba.org, linkinjeon@kernel.org,
        linux-cifs@vger.kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] fs/smb: Swing unicode common code from server->common
Date:   Wed, 28 Jun 2023 02:14:38 +0100
Message-ID: <20230628011439.159678-3-linux@treblig.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628011439.159678-1-linux@treblig.org>
References: <20230628011439.159678-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Swing most of the inline functions and unicode tables into smb/common
from the copy in smb/server.

UniStrcat has different types between the client and server
versions so I've not moved it (although I suspect it's OK).
The actual unicode.c implementations vary much more between server
and client so they're unmoved.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/smb/common/Makefile                        |   1 +
 .../uniupr.h => common/cifs_unicode_common.c} |  27 +-
 fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++++
 fs/smb/server/unicode.c                       |   1 -
 fs/smb/server/unicode.h                       | 253 +---------------
 5 files changed, 297 insertions(+), 264 deletions(-)
 rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (91%)
 create mode 100644 fs/smb/common/cifs_unicode_common.h

diff --git a/fs/smb/common/Makefile b/fs/smb/common/Makefile
index c66dbbc1469c..5a2edc72f5d4 100644
--- a/fs/smb/common/Makefile
+++ b/fs/smb/common/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_SMBFS) += cifs_arc4.o
 obj-$(CONFIG_SMBFS) += cifs_md4.o
+obj-$(CONFIG_SMBFS) += cifs_unicode_common.o
diff --git a/fs/smb/server/uniupr.h b/fs/smb/common/cifs_unicode_common.c
similarity index 91%
rename from fs/smb/server/uniupr.h
rename to fs/smb/common/cifs_unicode_common.c
index d09c585f20c9..edf09c8763be 100644
--- a/fs/smb/server/uniupr.h
+++ b/fs/smb/common/cifs_unicode_common.c
@@ -1,15 +1,21 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Some of the source code in this file came from fs/cifs/uniupr.h
- *   Copyright (c) International Business Machines  Corp., 2000,2002
- *
- * uniupr.h - Unicode compressed case ranges
+ *   Some of the source code in this file came from fs/cifs/cifs_unicode.c
+ *   via fs/smb/unicode.c and fs/smb/uniupr.h and fs/cifs/uniupr.h
+ *   Copyright (c) International Business Machines  Corp., 2000,2002,2009
+ *   Modified by Steve French (sfrench@us.ibm.com)
+ *   Modified by Namjae Jeon (linkinjeon@kernel.org)
+ *   Modified by Dr. David Alan Gilbert <linux@treblig.org>
  *
  */
-#ifndef __KSMBD_UNIUPR_H
-#define __KSMBD_UNIUPR_H
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+#include "cifs_unicode_common.h"
+
+MODULE_LICENSE("GPL");
 
-#ifndef UNIUPR_NOUPPER
 /*
  * Latin upper case
  */
@@ -51,6 +57,7 @@ signed char SmbUniUpperTable[512] = {
 	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e0-1ef */
 	0, 0, -1, -2, 0, -1, 0, 0, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1f0-1ff */
 };
+EXPORT_SYMBOL_GPL(SmbUniUpperTable);
 
 /* Upper case range - Greek */
 static signed char UniCaseRangeU03a0[47] = {
@@ -134,6 +141,4 @@ const struct UniCaseRange SmbUniUpperRange[] = {
 	{0xff40, 0xff5a, UniCaseRangeUff40},
 	{0}
 };
-#endif
-
-#endif /* __KSMBD_UNIUPR_H */
+EXPORT_SYMBOL_GPL(SmbUniUpperRange);
diff --git a/fs/smb/common/cifs_unicode_common.h b/fs/smb/common/cifs_unicode_common.h
new file mode 100644
index 000000000000..4b9703f897fe
--- /dev/null
+++ b/fs/smb/common/cifs_unicode_common.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Some of the source code in this file came from fs/cifs/cifs_unicode.c
+ * and then via server/unicode.c
+ * cifs_unicode:  Unicode kernel case support
+ *
+ * Function:
+ *     Convert a unicode character to upper or lower case using
+ *     compressed tables.
+ *
+ *   Copyright (c) International Business Machines  Corp., 2000,2009
+ *
+ *
+ * Notes:
+ *     These APIs are based on the C library functions.  The semantics
+ *     should match the C functions but with expanded size operands.
+ *
+ *     The upper/lower functions are based on a table created by mkupr.
+ *     This is a compressed table of upper and lower case conversion.
+ *
+ */
+#ifndef _CIFS_UNICODE_COMMON_H
+#define _CIFS_UNICODE_COMMON_H
+
+#include <asm/byteorder.h>
+#include <linux/types.h>
+#include <linux/nls.h>
+#include <linux/unicode.h>
+
+/*
+ * Windows maps these to the user defined 16 bit Unicode range since they are
+ * reserved symbols (along with \ and /), otherwise illegal to store
+ * in filenames in NTFS
+ */
+#define UNI_ASTERISK    ((__u16)('*' + 0xF000))
+#define UNI_QUESTION    ((__u16)('?' + 0xF000))
+#define UNI_COLON       ((__u16)(':' + 0xF000))
+#define UNI_GRTRTHAN    ((__u16)('>' + 0xF000))
+#define UNI_LESSTHAN    ((__u16)('<' + 0xF000))
+#define UNI_PIPE        ((__u16)('|' + 0xF000))
+#define UNI_SLASH       ((__u16)('\\' + 0xF000))
+
+#ifndef	UNICASERANGE_DEFINED
+struct UniCaseRange {
+	wchar_t start;
+	wchar_t end;
+	signed char *table;
+};
+#endif				/* UNICASERANGE_DEFINED */
+
+#ifndef UNIUPR_NOUPPER
+extern signed char SmbUniUpperTable[512];
+extern const struct UniCaseRange SmbUniUpperRange[];
+#endif				/* UNIUPR_NOUPPER */
+
+/*
+ * UniStrchr:  Find a character in a string
+ *
+ * Returns:
+ *     Address of first occurrence of character in string
+ *     or NULL if the character is not in the string
+ */
+static inline wchar_t *UniStrchr(const wchar_t *ucs, wchar_t uc)
+{
+	while ((*ucs != uc) && *ucs)
+		ucs++;
+
+	if (*ucs == uc)
+		return (wchar_t *)ucs;
+	return NULL;
+}
+
+/*
+ * UniStrcmp:  Compare two strings
+ *
+ * Returns:
+ *     < 0:  First string is less than second
+ *     = 0:  Strings are equal
+ *     > 0:  First string is greater than second
+ */
+static inline int UniStrcmp(const wchar_t *ucs1, const wchar_t *ucs2)
+{
+	while ((*ucs1 == *ucs2) && *ucs1) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int)*ucs1 - (int)*ucs2;
+}
+
+/*
+ * UniStrcpy:  Copy a string
+ */
+static inline wchar_t *UniStrcpy(wchar_t *ucs1, const wchar_t *ucs2)
+{
+	wchar_t *anchor = ucs1;	/* save the start of result string */
+
+	while ((*ucs1++ = *ucs2++))
+	/*NULL*/;
+	return anchor;
+}
+
+/*
+ * UniStrlen:  Return the length of a string (in 16 bit Unicode chars not bytes)
+ */
+static inline size_t UniStrlen(const wchar_t *ucs1)
+{
+	int i = 0;
+
+	while (*ucs1++)
+		i++;
+	return i;
+}
+
+/*
+ * UniStrnlen:  Return the length (in 16 bit Unicode chars not bytes) of a
+ *		string (length limited)
+ */
+static inline size_t UniStrnlen(const wchar_t *ucs1, int maxlen)
+{
+	int i = 0;
+
+	while (*ucs1++) {
+		i++;
+		if (i >= maxlen)
+			break;
+	}
+	return i;
+}
+
+/*
+ * UniStrncat:  Concatenate length limited string
+ */
+static inline wchar_t *UniStrncat(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	wchar_t *anchor = ucs1;	/* save pointer to string 1 */
+
+	while (*ucs1++)
+	/*NULL*/;
+	ucs1--;			/* point to null terminator of s1 */
+	while (n-- && (*ucs1 = *ucs2)) {	/* copy s2 after s1 */
+		ucs1++;
+		ucs2++;
+	}
+	*ucs1 = 0;		/* Null terminate the result */
+	return anchor;
+}
+
+/*
+ * UniStrncmp:  Compare length limited string
+ */
+static inline int UniStrncmp(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	if (!n)
+		return 0;	/* Null strings are equal */
+	while ((*ucs1 == *ucs2) && *ucs1 && --n) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int)*ucs1 - (int)*ucs2;
+}
+
+/*
+ * UniStrncmp_le:  Compare length limited string - native to little-endian
+ */
+static inline int
+UniStrncmp_le(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	if (!n)
+		return 0;	/* Null strings are equal */
+	while ((*ucs1 == __le16_to_cpu(*ucs2)) && *ucs1 && --n) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int)*ucs1 - (int)__le16_to_cpu(*ucs2);
+}
+
+/*
+ * UniStrncpy:  Copy length limited string with pad
+ */
+static inline wchar_t *UniStrncpy(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	wchar_t *anchor = ucs1;
+
+	while (n-- && *ucs2)	/* Copy the strings */
+		*ucs1++ = *ucs2++;
+
+	n++;
+	while (n--)		/* Pad with nulls */
+		*ucs1++ = 0;
+	return anchor;
+}
+
+/*
+ * UniStrncpy_le:  Copy length limited string with pad to little-endian
+ */
+static inline wchar_t *UniStrncpy_le(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	wchar_t *anchor = ucs1;
+
+	while (n-- && *ucs2)	/* Copy the strings */
+		*ucs1++ = __le16_to_cpu(*ucs2++);
+
+	n++;
+	while (n--)		/* Pad with nulls */
+		*ucs1++ = 0;
+	return anchor;
+}
+
+/*
+ * UniStrstr:  Find a string in a string
+ *
+ * Returns:
+ *     Address of first match found
+ *     NULL if no matching string is found
+ */
+static inline wchar_t *UniStrstr(const wchar_t *ucs1, const wchar_t *ucs2)
+{
+	const wchar_t *anchor1 = ucs1;
+	const wchar_t *anchor2 = ucs2;
+
+	while (*ucs1) {
+		if (*ucs1 == *ucs2) {
+			/* Partial match found */
+			ucs1++;
+			ucs2++;
+		} else {
+			if (!*ucs2)	/* Match found */
+				return (wchar_t *)anchor1;
+			ucs1 = ++anchor1;	/* No match */
+			ucs2 = anchor2;
+		}
+	}
+
+	if (!*ucs2)		/* Both end together */
+		return (wchar_t *)anchor1;	/* Match found */
+	return NULL;		/* No match */
+}
+
+#ifndef UNIUPR_NOUPPER
+/*
+ * UniToupper:  Convert a unicode character to upper case
+ */
+static inline wchar_t UniToupper(register wchar_t uc)
+{
+	register const struct UniCaseRange *rp;
+
+	if (uc < sizeof(SmbUniUpperTable)) {
+		/* Latin characters */
+		return uc + SmbUniUpperTable[uc];	/* Use base tables */
+	}
+
+	rp = SmbUniUpperRange;	/* Use range tables */
+	while (rp->start) {
+		if (uc < rp->start)	/* Before start of range */
+			return uc;	/* Uppercase = input */
+		if (uc <= rp->end)	/* In range */
+			return uc + rp->table[uc - rp->start];
+		rp++;	/* Try next range */
+	}
+	return uc;		/* Past last range */
+}
+
+/*
+ * UniStrupr:  Upper case a unicode string
+ */
+static inline __le16 *UniStrupr(register __le16 *upin)
+{
+	register __le16 *up;
+
+	up = upin;
+	while (*up) {		/* For all characters */
+		*up = cpu_to_le16(UniToupper(le16_to_cpu(*up)));
+		up++;
+	}
+	return upin;		/* Return input pointer */
+}
+#endif				/* UNIUPR_NOUPPER */
+
+#endif /* _CIFS_UNICODE_H */
diff --git a/fs/smb/server/unicode.c b/fs/smb/server/unicode.c
index 9ae676906ed3..393dd4a7432b 100644
--- a/fs/smb/server/unicode.c
+++ b/fs/smb/server/unicode.c
@@ -11,7 +11,6 @@
 #include <asm/unaligned.h>
 #include "glob.h"
 #include "unicode.h"
-#include "uniupr.h"
 #include "smb_common.h"
 
 /*
diff --git a/fs/smb/server/unicode.h b/fs/smb/server/unicode.h
index b48c7b11b9c7..8414c40f4cae 100644
--- a/fs/smb/server/unicode.h
+++ b/fs/smb/server/unicode.h
@@ -25,35 +25,7 @@
 #include <linux/types.h>
 #include <linux/nls.h>
 #include <linux/unicode.h>
-
-/*
- * Windows maps these to the user defined 16 bit Unicode range since they are
- * reserved symbols (along with \ and /), otherwise illegal to store
- * in filenames in NTFS
- */
-#define UNI_ASTERISK    ((__u16)('*' + 0xF000))
-#define UNI_QUESTION    ((__u16)('?' + 0xF000))
-#define UNI_COLON       ((__u16)(':' + 0xF000))
-#define UNI_GRTRTHAN    ((__u16)('>' + 0xF000))
-#define UNI_LESSTHAN    ((__u16)('<' + 0xF000))
-#define UNI_PIPE        ((__u16)('|' + 0xF000))
-#define UNI_SLASH       ((__u16)('\\' + 0xF000))
-
-/* Just define what we want from uniupr.h.  We don't want to define the tables
- * in each source file.
- */
-#ifndef	UNICASERANGE_DEFINED
-struct UniCaseRange {
-	wchar_t start;
-	wchar_t end;
-	signed char *table;
-};
-#endif				/* UNICASERANGE_DEFINED */
-
-#ifndef UNIUPR_NOUPPER
-extern signed char SmbUniUpperTable[512];
-extern const struct UniCaseRange SmbUniUpperRange[];
-#endif				/* UNIUPR_NOUPPER */
+#include "../common/cifs_unicode_common.h"
 
 #ifdef __KERNEL__
 int smb_strtoUTF16(__le16 *to, const char *from, int len,
@@ -84,227 +56,4 @@ static inline wchar_t *UniStrcat(wchar_t *ucs1, const wchar_t *ucs2)
 	return anchor;
 }
 
-/*
- * UniStrchr:  Find a character in a string
- *
- * Returns:
- *     Address of first occurrence of character in string
- *     or NULL if the character is not in the string
- */
-static inline wchar_t *UniStrchr(const wchar_t *ucs, wchar_t uc)
-{
-	while ((*ucs != uc) && *ucs)
-		ucs++;
-
-	if (*ucs == uc)
-		return (wchar_t *)ucs;
-	return NULL;
-}
-
-/*
- * UniStrcmp:  Compare two strings
- *
- * Returns:
- *     < 0:  First string is less than second
- *     = 0:  Strings are equal
- *     > 0:  First string is greater than second
- */
-static inline int UniStrcmp(const wchar_t *ucs1, const wchar_t *ucs2)
-{
-	while ((*ucs1 == *ucs2) && *ucs1) {
-		ucs1++;
-		ucs2++;
-	}
-	return (int)*ucs1 - (int)*ucs2;
-}
-
-/*
- * UniStrcpy:  Copy a string
- */
-static inline wchar_t *UniStrcpy(wchar_t *ucs1, const wchar_t *ucs2)
-{
-	wchar_t *anchor = ucs1;	/* save the start of result string */
-
-	while ((*ucs1++ = *ucs2++))
-	/*NULL*/;
-	return anchor;
-}
-
-/*
- * UniStrlen:  Return the length of a string (in 16 bit Unicode chars not bytes)
- */
-static inline size_t UniStrlen(const wchar_t *ucs1)
-{
-	int i = 0;
-
-	while (*ucs1++)
-		i++;
-	return i;
-}
-
-/*
- * UniStrnlen:  Return the length (in 16 bit Unicode chars not bytes) of a
- *		string (length limited)
- */
-static inline size_t UniStrnlen(const wchar_t *ucs1, int maxlen)
-{
-	int i = 0;
-
-	while (*ucs1++) {
-		i++;
-		if (i >= maxlen)
-			break;
-	}
-	return i;
-}
-
-/*
- * UniStrncat:  Concatenate length limited string
- */
-static inline wchar_t *UniStrncat(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	wchar_t *anchor = ucs1;	/* save pointer to string 1 */
-
-	while (*ucs1++)
-	/*NULL*/;
-	ucs1--;			/* point to null terminator of s1 */
-	while (n-- && (*ucs1 = *ucs2)) {	/* copy s2 after s1 */
-		ucs1++;
-		ucs2++;
-	}
-	*ucs1 = 0;		/* Null terminate the result */
-	return anchor;
-}
-
-/*
- * UniStrncmp:  Compare length limited string
- */
-static inline int UniStrncmp(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	if (!n)
-		return 0;	/* Null strings are equal */
-	while ((*ucs1 == *ucs2) && *ucs1 && --n) {
-		ucs1++;
-		ucs2++;
-	}
-	return (int)*ucs1 - (int)*ucs2;
-}
-
-/*
- * UniStrncmp_le:  Compare length limited string - native to little-endian
- */
-static inline int
-UniStrncmp_le(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	if (!n)
-		return 0;	/* Null strings are equal */
-	while ((*ucs1 == __le16_to_cpu(*ucs2)) && *ucs1 && --n) {
-		ucs1++;
-		ucs2++;
-	}
-	return (int)*ucs1 - (int)__le16_to_cpu(*ucs2);
-}
-
-/*
- * UniStrncpy:  Copy length limited string with pad
- */
-static inline wchar_t *UniStrncpy(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	wchar_t *anchor = ucs1;
-
-	while (n-- && *ucs2)	/* Copy the strings */
-		*ucs1++ = *ucs2++;
-
-	n++;
-	while (n--)		/* Pad with nulls */
-		*ucs1++ = 0;
-	return anchor;
-}
-
-/*
- * UniStrncpy_le:  Copy length limited string with pad to little-endian
- */
-static inline wchar_t *UniStrncpy_le(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	wchar_t *anchor = ucs1;
-
-	while (n-- && *ucs2)	/* Copy the strings */
-		*ucs1++ = __le16_to_cpu(*ucs2++);
-
-	n++;
-	while (n--)		/* Pad with nulls */
-		*ucs1++ = 0;
-	return anchor;
-}
-
-/*
- * UniStrstr:  Find a string in a string
- *
- * Returns:
- *     Address of first match found
- *     NULL if no matching string is found
- */
-static inline wchar_t *UniStrstr(const wchar_t *ucs1, const wchar_t *ucs2)
-{
-	const wchar_t *anchor1 = ucs1;
-	const wchar_t *anchor2 = ucs2;
-
-	while (*ucs1) {
-		if (*ucs1 == *ucs2) {
-			/* Partial match found */
-			ucs1++;
-			ucs2++;
-		} else {
-			if (!*ucs2)	/* Match found */
-				return (wchar_t *)anchor1;
-			ucs1 = ++anchor1;	/* No match */
-			ucs2 = anchor2;
-		}
-	}
-
-	if (!*ucs2)		/* Both end together */
-		return (wchar_t *)anchor1;	/* Match found */
-	return NULL;		/* No match */
-}
-
-#ifndef UNIUPR_NOUPPER
-/*
- * UniToupper:  Convert a unicode character to upper case
- */
-static inline wchar_t UniToupper(register wchar_t uc)
-{
-	register const struct UniCaseRange *rp;
-
-	if (uc < sizeof(SmbUniUpperTable)) {
-		/* Latin characters */
-		return uc + SmbUniUpperTable[uc];	/* Use base tables */
-	}
-
-	rp = SmbUniUpperRange;	/* Use range tables */
-	while (rp->start) {
-		if (uc < rp->start)	/* Before start of range */
-			return uc;	/* Uppercase = input */
-		if (uc <= rp->end)	/* In range */
-			return uc + rp->table[uc - rp->start];
-		rp++;	/* Try next range */
-	}
-	return uc;		/* Past last range */
-}
-
-/*
- * UniStrupr:  Upper case a unicode string
- */
-static inline __le16 *UniStrupr(register __le16 *upin)
-{
-	register __le16 *up;
-
-	up = upin;
-	while (*up) {		/* For all characters */
-		*up = cpu_to_le16(UniToupper(le16_to_cpu(*up)));
-		up++;
-	}
-	return upin;		/* Return input pointer */
-}
-#endif				/* UNIUPR_NOUPPER */
-
 #endif /* _CIFS_UNICODE_H */
-- 
2.41.0

