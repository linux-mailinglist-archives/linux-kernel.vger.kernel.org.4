Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45755E796B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiIWLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiIWLWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:22:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E9137923;
        Fri, 23 Sep 2022 04:21:57 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYqRD3gTXzbncp;
        Fri, 23 Sep 2022 19:19:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 19:21:55 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 19:21:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 05/10] kallsyms: Improve the performance of kallsyms_lookup_name()
Date:   Fri, 23 Sep 2022 19:20:28 +0800
Message-ID: <20220923112033.1958-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220923112033.1958-1-thunder.leizhen@huawei.com>
References: <20220923112033.1958-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, to search for a symbol, we need to expand the symbols in
'kallsyms_names' one by one, and then use the expanded string for
comparison. This process can be optimized.

And now scripts/kallsyms no longer compresses the symbol types, each
symbol type always occupies one byte. So we can first compress the
searched symbol and then make a quick comparison based on the compressed
length and content. In this way, for entries with mismatched lengths,
there is no need to expand and compare strings. And for those matching
lengths, there's no need to expand the symbol. This saves a lot of time.
According to my test results, the average performance of
kallsyms_lookup_name() can be improved by 20 to 30 times.

The pseudo code of the test case is as follows:
static int stat_find_name(...)
{
	start = sched_clock();
	(void)kallsyms_lookup_name(name);
	end = sched_clock();
	//Update min, max, cnt, sum
}

/*
 * Traverse all symbols in sequence and collect statistics on the time
 * taken by kallsyms_lookup_name() to lookup each symbol.
 */
kallsyms_on_each_symbol(stat_find_name, NULL);

The test results are as follows (twice):
After : min=5250, max=  726560, avg= 302132
After : min=5320, max=  726850, avg= 301978
Before: min=170,  max=15949190, avg=7553906
Before: min=160,  max=15877280, avg=7517784

The average time consumed is only 4.01% and the maximum time consumed is
only 4.57% of the time consumed before optimization.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kallsyms.c | 124 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3e7e2c2ad2f75ef..dcf5bdc7309a6cc 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -87,6 +87,86 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 	return off;
 }
 
+static unsigned char *find_token(unsigned char *str, int len,
+				 const unsigned char *token)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++) {
+		if (str[i] == token[0] && str[i+1] == token[1])
+			return &str[i];
+	}
+	return NULL;
+}
+
+static int kallsyms_compress_symbol_name(const char *name, char *buf, size_t size)
+{
+	int i, j, n, len;
+	unsigned char *p1, *p2;
+	const unsigned char *token;
+
+	len = strscpy(buf, name, size);
+	if (WARN_ON_ONCE(len <= 0))
+		return 0;
+
+	/*
+	 * For each entry in kallsyms_best_token_table[], the storage
+	 * format is:
+	 * 1. For tokens that cannot be used to compress characters, the value
+	 *    at [j] is 0, and the value at [j+1] is the number of consecutive
+	 *    tokens with this feature.
+	 * 2. For each token: the larger the token value, the higher the
+	 *    frequency, and the lower the index.
+	 *
+	 *  -------------------------------
+	 * |  j  |   [j]  [j+1]  |  token  |
+	 *  -----|---------------|---------|
+	 * |  0  |   ??    ??	 |   255   |
+	 * |  2  |   ??    ??    |   254   |
+	 * | ... |   ??    ??    |   ...   |
+	 * | n-2 |   ??    ??    |    x    |
+	 * |  n  |   00    len   |   x-1   |
+	 * | n+2 |   ??    ??    | x-1-len |
+	 *      above '??' is non-zero
+	 */
+	for (i = 255, j = 0; i >= 0; i--, j += 2) {
+		if (!kallsyms_best_token_table[j]) {
+			i -= kallsyms_best_token_table[j + 1];
+			if (i < 0)
+				break;
+			j += 2;
+		}
+		token = &kallsyms_best_token_table[j];
+
+		p1 = buf;
+
+		/* find the token on the symbol */
+		p2 = find_token(p1, len, token);
+		if (!p2)
+			continue;
+
+		n = len;
+
+		do {
+			*p2 = i;
+			p2++;
+			n -= (p2 - p1);
+			memmove(p2, p2 + 1, n);
+			p1 = p2;
+			len--;
+
+			if (n < 2)
+				break;
+
+			/* find the token on the symbol */
+			p2 = find_token(p1, n, token);
+
+		} while (p2);
+	}
+
+	return len;
+}
+
 /*
  * Get symbol type information. This is encoded as a single char at the
  * beginning of the symbol name.
@@ -186,26 +266,62 @@ static bool cleanup_symbol_name(char *s)
 	return false;
 }
 
+static int kallsyms_lookup_compressed_name(unsigned char *namebuf, int len,
+					   unsigned long *addr)
+{
+	unsigned int i, off;
+	unsigned int name_len;
+	const unsigned char *name;
+
+	for (i = 0, off = 0; len && i < kallsyms_num_syms; i++) {
+		/*
+		 * For each symbol entry, the storage format is:
+		 *  ----------------------------
+		 * | len(1) | type(1) | name(x) |
+		 *  ----------------------------
+		 *
+		 * Number of bytes in parentheses, and: len = 1 + x
+		 */
+		name_len = kallsyms_names[off] - 1;
+		name = &kallsyms_names[off + 2];
+		off += name_len + 2;
+
+		if (name_len != len)
+			continue;
+
+		if (!memcmp(name, namebuf, len)) {
+			*addr = kallsyms_sym_address(i);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
 	char namebuf[KSYM_NAME_LEN];
-	unsigned long i;
+	unsigned long i, addr;
 	unsigned int off;
+	int ret, len;
 
 	/* Skip the search for empty string. */
 	if (!*name)
 		return 0;
 
+	len = kallsyms_compress_symbol_name(name, namebuf, ARRAY_SIZE(namebuf));
+	ret = kallsyms_lookup_compressed_name(namebuf, len, &addr);
+	if (!ret)
+		return addr;
+
 	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
 		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 
-		if (strcmp(namebuf, name) == 0)
-			return kallsyms_sym_address(i);
-
 		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
 	}
+
 	return module_kallsyms_lookup_name(name);
 }
 
-- 
2.25.1

