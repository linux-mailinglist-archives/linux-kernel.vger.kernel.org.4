Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B015647D98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLIGNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLIGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:13:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F538750B8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 22:13:43 -0800 (PST)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NT10M1rVGzJqGs;
        Fri,  9 Dec 2022 14:12:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 9 Dec
 2022 14:13:40 +0800
From:   Li Lingfeng <lilingfeng3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bingjingc@synology.com>,
        <ebiggers@google.com>, <james.smart@broadcom.com>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <lilingfeng3@huawei.com>
Subject: [PATCH-next] lib: parser: optimize match_NUMER apis to use local array
Date:   Fri, 9 Dec 2022 14:34:34 +0800
Message-ID: <20221209063434.1566682-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory will be allocated to store substring_t in match_strdup(), which means
the caller of match_strdup() may need to be scheduled out to wait for reclaiming
memory.

Introducing a helper which use local array to store substring_t to remove the
restriction.

Link: https://lore.kernel.org/all/20221104023938.2346986-5-yukuai1@huaweicloud.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 lib/parser.c | 56 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/lib/parser.c b/lib/parser.c
index bcb23484100e..d4f4c81ff653 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -11,6 +11,30 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+/*
+ * max size needed by diffrent bases to express U64
+ * HEX: "0xFFFFFFFFFFFFFFFF" --> 18
+ * DEC: "18446744073709551615" --> 20
+ * OCT: "01777777777777777777777" --> 23
+ * pick the max one to define U64_MAX_SIZE
+ */
+#define U64_MAX_SIZE 23
+
+static int match_strdup_local(const substring_t *s, char *buf)
+{
+	size_t len = s->to - s->from;
+
+	if (!s->from)
+		return -EINVAL;
+
+	if (len > U64_MAX_SIZE)
+		return -ERANGE;
+
+	memcpy(buf, s->from, len);
+	buf[len] = '\0';
+	return 0;
+}
+
 /**
  * match_one - Determines if a string matches a simple pattern
  * @s: the string to examine for presence of the pattern
@@ -129,15 +153,13 @@ EXPORT_SYMBOL(match_token);
 static int match_number(substring_t *s, int *result, int base)
 {
 	char *endp;
-	char *buf;
+	char buf[U64_MAX_SIZE + 1];
 	int ret;
 	long val;
 
-	buf = match_strdup(s);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = 0;
+	ret = match_strdup_local(s, buf);
+	if (ret)
+		return ret;
 	val = simple_strtol(buf, &endp, base);
 	if (endp == buf)
 		ret = -EINVAL;
@@ -145,7 +167,6 @@ static int match_number(substring_t *s, int *result, int base)
 		ret = -ERANGE;
 	else
 		*result = (int) val;
-	kfree(buf);
 	return ret;
 }
 
@@ -163,18 +184,16 @@ static int match_number(substring_t *s, int *result, int base)
  */
 static int match_u64int(substring_t *s, u64 *result, int base)
 {
-	char *buf;
+	char buf[U64_MAX_SIZE + 1];
 	int ret;
 	u64 val;
 
-	buf = match_strdup(s);
-	if (!buf)
-		return -ENOMEM;
-
+	ret = match_strdup_local(s, buf);
+	if (ret)
+		return ret;
 	ret = kstrtoull(buf, base, &val);
 	if (!ret)
 		*result = val;
-	kfree(buf);
 	return ret;
 }
 
@@ -207,12 +226,13 @@ EXPORT_SYMBOL(match_int);
 int match_uint(substring_t *s, unsigned int *result)
 {
 	int err = -ENOMEM;
-	char *buf = match_strdup(s);
+	char buf[U64_MAX_SIZE + 1];
 
-	if (buf) {
-		err = kstrtouint(buf, 10, result);
-		kfree(buf);
-	}
+	err = match_strdup_local(s, buf);
+	if (err)
+		return err;
+
+	err = kstrtouint(buf, 10, result);
 	return err;
 }
 EXPORT_SYMBOL(match_uint);
-- 
2.31.1

