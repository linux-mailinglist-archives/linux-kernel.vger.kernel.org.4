Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68D15B388B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIINDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiIINDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:03:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28F97EEA;
        Fri,  9 Sep 2022 06:03:17 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MPGKj1B1XzmVDV;
        Fri,  9 Sep 2022 20:59:37 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 21:03:15 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 21:03:14 +0800
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
        <linux-modules@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 4/8] kallsyms: Improve the performance of kallsyms_lookup_name()
Date:   Fri, 9 Sep 2022 21:00:12 +0800
Message-ID: <20220909130016.727-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220909130016.727-1-thunder.leizhen@huawei.com>
References: <20220909130016.727-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, to search for a symbol, we need to expand the symbols in
'kallsyms_names' one by one, and then use the expanded string for
comparison. This is very slow.

In fact, we can first compress the name being looked up and then use
it for comparison when traversing 'kallsyms_names'.

This requires CONFIG_KALLSYMS_ALL=y.

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
After : min=7106, max=  564822, cnt=131392, avg= 247965
After : min=6971, max=  557676, cnt=131393, avg= 248350
Before: min= 682, max=23045734, cnt=131392, avg=6966802
Before: min= 647, max=17676731, cnt=131392, avg=6965314

The average time consumed is only 3.56% and the maximum time consumed is
only 2.76% of the time consumed before optimization.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kallsyms.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 9dd4774b6c6edf6..e1cd7305aa5f548 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -87,6 +87,72 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 	return off;
 }
 
+static int kallsyms_name_to_tokens(const char *name, char *buf)
+{
+	int i, j, k, n;
+	int len, token_len;
+	const char *token;
+	unsigned char token_idx[KSYM_NAME_LEN];
+	unsigned char token_bak[KSYM_NAME_LEN];
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ALL))
+		return 0;
+
+	/*
+	 * n, number of tokens in the string name.
+	 * token_idx[i], the start index of the ith token.
+	 * token_idx[n] is used to calculate the length of the last token.
+	 */
+	n = strlen(name);
+	if (n >= KSYM_NAME_LEN)
+		return 0;
+	for (i = 0; i <= n; i++)
+		token_idx[i] = (unsigned char)i;
+
+	/*
+	 * For tokens whose token_len >= 2, a larger index value indicates
+	 * a higher occurrence frequency. See scripts/kallsyms.c
+	 */
+	for (i = 255; i >= 0; i--) {
+		token = &kallsyms_token_table[kallsyms_token_index[i]];
+		token_len = strlen(token);
+		if (token_len <= 1)
+			continue;
+
+		/*
+		 * Find and merge two tokens into one.
+		 *
+		 *                |<-- new_token -->|
+		 *                | token1 | token2 |
+		 * token_idx[]:   j       j+1      j+2
+		 *
+		 */
+		for (j = 0; j < n - 1; j++) {
+			len = token_idx[j + 2] - token_idx[j];
+			if (len == token_len &&
+			    !strncmp(name + token_idx[j], token, len)) {
+				token_bak[token_idx[j]] = (unsigned char)i;
+				for (k = j + 1; k < n; k++)
+					token_idx[k] = token_idx[k + 1];
+				n--;
+			}
+		}
+	}
+
+	for (j = 0; j < n; j++) {
+		len = token_idx[j + 1] - token_idx[j];
+		if (len <= 1) {
+			buf[j] = name[token_idx[j]];
+			continue;
+		}
+
+		buf[j] = token_bak[token_idx[j]];
+	}
+	buf[n] = 0;
+
+	return n;
+}
+
 /*
  * Get symbol type information. This is encoded as a single char at the
  * beginning of the symbol name.
@@ -191,11 +257,29 @@ unsigned long kallsyms_lookup_name(const char *name)
 {
 	char namebuf[KSYM_NAME_LEN];
 	unsigned int i, off;
+	int len;
 
 	/* Skip the search for empty string. */
 	if (!*name)
 		return 0;
 
+	len = kallsyms_name_to_tokens(name, namebuf);
+	if (!len)
+		goto slow_path;
+
+	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
+		if (kallsyms_names[off] == len + 1 &&
+		    !memcmp(&kallsyms_names[off + 2], namebuf, len)) {
+			return kallsyms_sym_address(i);
+		}
+
+		off += kallsyms_names[off] + 1;
+	}
+
+	if (!IS_ENABLED(CONFIG_LTO_CLANG))
+		goto module_lookup;
+
+slow_path:
 	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
 		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 
@@ -205,6 +289,8 @@ unsigned long kallsyms_lookup_name(const char *name)
 		if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
 	}
+
+module_lookup:
 	return module_kallsyms_lookup_name(name);
 }
 
-- 
2.25.1

