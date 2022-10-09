Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8A55F8C46
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJIQWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJIQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:22:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B6275E8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:22:38 -0700 (PDT)
X-QQ-mid: bizesmtp63t1665332548tes0qihh
Received: from localhost.localdomain ( [58.247.70.42])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 00:22:27 +0800 (CST)
X-QQ-SSF: 01100000002000G0Z000B00A0000000
X-QQ-FEAT: lJ9dImo9Gpf3qGfbbuHdLhphkStRzvkHM9DXOuUIZfz36X3NYtmefNP6oLQqq
        wNuMooggk9A2IuyJ1zXGo7vuKqhCkZGh7mhUYYEdGlOCGKx28tzZOFFl08XlnnJ1TTzln8p
        l1dr9FuZFm+uUDWJdUIEfSWodW5dugGvDsM+o6jZgv8n8sfDeKYW5mmyAJMrtk3PX3TB0Xe
        dVyRoc7/SH6g703CLELjDr9mHT5C2gBSzY3sFlSCFo4PvqrBpv3X74b9ehbOUax28PP6NFD
        Gwzv0Sao995Mk+n7+UlToHzZHhbDWH9q79ydy7/6E+00IS7xgEJGbf6qoPmyZ2eV2F/QbVX
        s0t+HX4KIJcpxa5T/KQxUqNhfGZ+T3A5ncbVFuvIqo9H1RK1Cb7Pff0XqrjqA==
X-QQ-GoodBg: 0
From:   Soha Jin <soha@lohu.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, Soha Jin <soha@lohu.info>
Subject: [PATCH 1/3] string: add match_string_nocase() for case-insensitive match
Date:   Mon, 10 Oct 2022 00:21:53 +0800
Message-Id: <20221009162155.1318-2-soha@lohu.info>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009162155.1318-1-soha@lohu.info>
References: <20221009162155.1318-1-soha@lohu.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to make a case-insensitive comparison with strings, like
checking compatible devices in fwnode properties, so this commit abstracts
match_string to __match_string with a compare function. The original
match_string will call __match_string with strcmp, and the new
match_string_nocase will call it with strcasecmp.

Signed-off-by: Soha Jin <soha@lohu.info>
---
 include/linux/string.h | 31 ++++++++++++++++++++++++++++++-
 lib/string_helpers.c   | 10 ++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index cf7607b32102..fcfa67f598f5 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -183,9 +183,38 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
-int match_string(const char * const *array, size_t n, const char *string);
+int __match_string(const char * const *array, size_t n, const char *string,
+		   int (*cmp)(const char *, const char *));
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 
+/**
+ * match_string - matches given string in an array
+ * @_a:	array of strings
+ * @_n:	number of strings in the array
+ * @_s:	string to match with
+ *
+ * Helper for __match_string(). Look for a string in an array of strings up to
+ * the n-th element in the array with a case-sensitive compare.
+ *
+ * Return:
+ * index of a @string in the @array if matches, or %-EINVAL otherwise.
+ */
+#define match_string(_a, _n, _s) __match_string(_a, _n, _s, strcmp)
+
+/**
+ * match_string_nocase - matches given string in an array
+ * @_a:	array of strings
+ * @_n:	number of strings in the array
+ * @_s:	string to match with
+ *
+ * Helper for __match_string(). Look for a string in an array of strings up to
+ * the n-th element in the array with a case-insensitive compare.
+ *
+ * Return:
+ * index of a @string in the @array if matches, or %-EINVAL otherwise.
+ */
+#define match_string_nocase(_a, _n, _s) __match_string(_a, _n, _s, strcasecmp)
+
 /**
  * sysfs_match_string - matches given string in an array
  * @_a: array of strings
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 230020a2e076..52949adfdfe4 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -910,10 +910,11 @@ bool sysfs_streq(const char *s1, const char *s2)
 EXPORT_SYMBOL(sysfs_streq);
 
 /**
- * match_string - matches given string in an array
+ * __match_string - matches given string in an array
  * @array:	array of strings
  * @n:		number of strings in the array or -1 for NULL terminated arrays
  * @string:	string to match with
+ * @cmp:	compare function
  *
  * This routine will look for a string in an array of strings up to the
  * n-th element in the array or until the first NULL element.
@@ -926,7 +927,8 @@ EXPORT_SYMBOL(sysfs_streq);
  * Return:
  * index of a @string in the @array if matches, or %-EINVAL otherwise.
  */
-int match_string(const char * const *array, size_t n, const char *string)
+int __match_string(const char * const *array, size_t n, const char *string,
+		   int (*cmp)(const char *, const char *))
 {
 	int index;
 	const char *item;
@@ -935,13 +937,13 @@ int match_string(const char * const *array, size_t n, const char *string)
 		item = array[index];
 		if (!item)
 			break;
-		if (!strcmp(item, string))
+		if (!cmp(item, string))
 			return index;
 	}
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(match_string);
+EXPORT_SYMBOL(__match_string);
 
 /**
  * __sysfs_match_string - matches given string in an array
-- 
2.30.2

