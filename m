Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91E6741C72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjF1XZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjF1XY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:24:56 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9FB10F5;
        Wed, 28 Jun 2023 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uYHr8obitC+VeIBiWPNFHqMDq0inX4yZdZ6+HtY42uE=; b=ELhYnYtORlexQU3+WSrteaVppV
        UqrLRHcSqlkSp8fOAv9KpNRNvsd+owKwA3G13r2FRBEmk1JajthnkMKzEVQr85G8UQL4DP3BwE3Bd
        jHwSpZtkvqmSme9jFiPCzmXKlqraBBL6kHlp2heqaa2F98mNdGzr1yIQ2tH5ek9NFbOut9sahUapF
        e58rjjqJR0YAe6Hk1fvumc1HCI+D/7Nun8V/FMmD8ysanXPlld36p5KrHaZdXVcE7E5QkTa3bq+uR
        a6mxB8EbHr+LMPglfnazfQZFVzdpvUvP+fTtS1JRVA98f9ZnaA/I2Egyf16+cbZhmVd+QRVvPOXb/
        uewjqBaw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1qEeWa-00GXy3-RT; Wed, 28 Jun 2023 23:24:35 +0000
From:   linux@treblig.org
To:     sfrench@samba.org, linkinjeon@kernel.org, tom@talpey.com,
        linux-cifs@vger.kernel.org
Cc:     krisman@collabora.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2 2/4] fs/smb: Swing unicode common code from smb->NLS
Date:   Thu, 29 Jun 2023 00:24:15 +0100
Message-ID: <20230628232417.120844-3-linux@treblig.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628232417.120844-1-linux@treblig.org>
References: <20230628232417.120844-1-linux@treblig.org>
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

Swing most of the inline functions and unicode tables into nls
from the copy in smb/server.  This is UCS-2 rather than most
of the rest of the code in NLS, but it currently seems like the
best place for it.

The actual unicode.c implementations vary much more between server
and client so they're unmoved.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/nls/Kconfig                                |   8 +
 fs/nls/Makefile                               |   1 +
 .../server/uniupr.h => nls/nls_ucs2_utils.c}  |  31 +-
 fs/nls/nls_ucs2_utils.h                       | 297 ++++++++++++++++++
 fs/smb/server/Kconfig                         |   1 +
 fs/smb/server/unicode.c                       |   1 -
 fs/smb/server/unicode.h                       | 277 +---------------
 7 files changed, 329 insertions(+), 287 deletions(-)
 rename fs/{smb/server/uniupr.h => nls/nls_ucs2_utils.c} (90%)
 create mode 100644 fs/nls/nls_ucs2_utils.h

diff --git a/fs/nls/Kconfig b/fs/nls/Kconfig
index c7857e36adbb..a0d0e2f7ec83 100644
--- a/fs/nls/Kconfig
+++ b/fs/nls/Kconfig
@@ -617,4 +617,12 @@ config NLS_UTF8
 	  input/output character sets. Say Y here for the UTF-8 encoding of
 	  the Unicode/ISO9646 universal character set.
 
+config NLS_UCS2_UTILS
+	tristate "NLS UCS-2 UTILS"
+	help
+	  Set of older UCS-2 conversion utilities and tables used by some
+	  filesystems including SMB/CIFS.  This includes upper case conversion
+	  tables. This will automatically be selected when the filesystem
+	  that uses it is selected.
+
 endif # NLS
diff --git a/fs/nls/Makefile b/fs/nls/Makefile
index ac54db297128..5062c699d041 100644
--- a/fs/nls/Makefile
+++ b/fs/nls/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_NLS_MAC_INUIT)     += mac-inuit.o
 obj-$(CONFIG_NLS_MAC_ROMANIAN)  += mac-romanian.o
 obj-$(CONFIG_NLS_MAC_ROMAN)     += mac-roman.o
 obj-$(CONFIG_NLS_MAC_TURKISH)   += mac-turkish.o
+obj-$(CONFIG_NLS_UCS2_UTILS)		+= nls_ucs2_utils.o
diff --git a/fs/smb/server/uniupr.h b/fs/nls/nls_ucs2_utils.c
similarity index 90%
rename from fs/smb/server/uniupr.h
rename to fs/nls/nls_ucs2_utils.c
index d09c585f20c9..ce18c0185898 100644
--- a/fs/smb/server/uniupr.h
+++ b/fs/nls/nls_ucs2_utils.c
@@ -1,19 +1,25 @@
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
+#include "nls_ucs2_utils.h"
+
+MODULE_LICENSE("GPL");
 
-#ifndef UNIUPR_NOUPPER
 /*
  * Latin upper case
  */
-signed char SmbUniUpperTable[512] = {
+signed char NlsUniUpperTable[512] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 000-00f */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 010-01f */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 020-02f */
@@ -51,6 +57,7 @@ signed char SmbUniUpperTable[512] = {
 	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e0-1ef */
 	0, 0, -1, -2, 0, -1, 0, 0, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1f0-1ff */
 };
+EXPORT_SYMBOL_GPL(NlsUniUpperTable);
 
 /* Upper case range - Greek */
 static signed char UniCaseRangeU03a0[47] = {
@@ -126,7 +133,7 @@ static signed char UniCaseRangeUff40[27] = {
 /*
  * Upper Case Range
  */
-const struct UniCaseRange SmbUniUpperRange[] = {
+const struct UniCaseRange NlsUniUpperRange[] = {
 	{0x03a0, 0x03ce, UniCaseRangeU03a0},
 	{0x0430, 0x045f, UniCaseRangeU0430},
 	{0x0490, 0x04cc, UniCaseRangeU0490},
@@ -134,6 +141,4 @@ const struct UniCaseRange SmbUniUpperRange[] = {
 	{0xff40, 0xff5a, UniCaseRangeUff40},
 	{0}
 };
-#endif
-
-#endif /* __KSMBD_UNIUPR_H */
+EXPORT_SYMBOL_GPL(NlsUniUpperRange);
diff --git a/fs/nls/nls_ucs2_utils.h b/fs/nls/nls_ucs2_utils.h
new file mode 100644
index 000000000000..3500596ea993
--- /dev/null
+++ b/fs/nls/nls_ucs2_utils.h
@@ -0,0 +1,297 @@
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
+#ifndef _NLS_UCS2_UTILS_H
+#define _NLS_UCS2_UTILS_H
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
+extern signed char NlsUniUpperTable[512];
+extern const struct UniCaseRange NlsUniUpperRange[];
+#endif				/* UNIUPR_NOUPPER */
+
+/*
+ * UniStrcat:  Concatenate the second string to the first
+ *
+ * Returns:
+ *     Address of the first string
+ */
+static inline wchar_t *UniStrcat(wchar_t *ucs1, const wchar_t *ucs2)
+{
+	wchar_t *anchor = ucs1;	/* save a pointer to start of ucs1 */
+
+	while (*ucs1++)
+	/*NULL*/;	/* To end of first string */
+	ucs1--;			/* Return to the null */
+	while ((*ucs1++ = *ucs2++))
+	/*NULL*/;	/* copy string 2 over */
+	return anchor;
+}
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
+	if (uc < sizeof(NlsUniUpperTable)) {
+		/* Latin characters */
+		return uc + NlsUniUpperTable[uc];	/* Use base tables */
+	}
+
+	rp = NlsUniUpperRange;	/* Use range tables */
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
+#endif /* _NLS_UCS2_UTILS_H */
diff --git a/fs/smb/server/Kconfig b/fs/smb/server/Kconfig
index 7055cb5d2880..793151ddd60e 100644
--- a/fs/smb/server/Kconfig
+++ b/fs/smb/server/Kconfig
@@ -5,6 +5,7 @@ config SMB_SERVER
 	depends on FILE_LOCKING
 	select NLS
 	select NLS_UTF8
+	select NLS_UCS2_UTILS
 	select CRYPTO
 	select CRYPTO_MD5
 	select CRYPTO_HMAC
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
index b48c7b11b9c7..28c7c736f7bb 100644
--- a/fs/smb/server/unicode.h
+++ b/fs/smb/server/unicode.h
@@ -18,42 +18,14 @@
  *     This is a compressed table of upper and lower case conversion.
  *
  */
-#ifndef _CIFS_UNICODE_H
-#define _CIFS_UNICODE_H
+#ifndef _SMB_UNICODE_H
+#define _SMB_UNICODE_H
 
 #include <asm/byteorder.h>
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
+#include "../../nls/nls_ucs2_utils.h"
 
 #ifdef __KERNEL__
 int smb_strtoUTF16(__le16 *to, const char *from, int len,
@@ -66,245 +38,4 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
 #endif
 
-/*
- * UniStrcat:  Concatenate the second string to the first
- *
- * Returns:
- *     Address of the first string
- */
-static inline wchar_t *UniStrcat(wchar_t *ucs1, const wchar_t *ucs2)
-{
-	wchar_t *anchor = ucs1;	/* save a pointer to start of ucs1 */
-
-	while (*ucs1++)
-	/*NULL*/;	/* To end of first string */
-	ucs1--;			/* Return to the null */
-	while ((*ucs1++ = *ucs2++))
-	/*NULL*/;	/* copy string 2 over */
-	return anchor;
-}
-
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
-#endif /* _CIFS_UNICODE_H */
+#endif /* _SMB_UNICODE_H */
-- 
2.41.0

