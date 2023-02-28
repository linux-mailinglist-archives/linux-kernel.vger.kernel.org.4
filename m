Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3142E6A5EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjB1Sm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjB1Sm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:42:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07364136
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:42:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF299B80EAC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2CEC433EF;
        Tue, 28 Feb 2023 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677609773;
        bh=pidVvllSN1IUSrHAwpFFAwnr0Xfr4NblI3c7HbGX5aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oc+8db52928eVh7Pnnftzyj4a4Sy5e1N4sO8tPy8jVCHNx3zmiRCl0acwKxQojVWK
         MwtTQu99w1ZoQYaKfMOKZ7FHiP15oeYEpSQgLJdcxo/w1HwJnfodd+x0sHxkjV1QvT
         3Pn+a52xCWNhRI3dMAnPw/ojXTXLRcDd2OD+sZqexcWQ1l8C7OsBFy4Ldh1Kr34w0c
         2ZAl9oTcK6NjsmAjFKqLCGgh1HiM5p2LROt6xUtrlxa/e1cFXx4ek8E5AEb8D0g9U1
         vif7EekWWmAE+yp2rRmezZQmwR5yEAmx2gm1K4w5wP1PlbRAmWzRAT+UYDlPmvOqxz
         pmZ4hjWQqOb0A==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v2 2/2] lib/test_string.c: Add strncmp() tests
Date:   Tue, 28 Feb 2023 19:42:45 +0100
Message-Id: <20230228184245.1585775-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230228184245.1585775-1-bjorn@kernel.org>
References: <20230228184245.1585775-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The RISC-V strncmp() fails on some inputs, see the linked thread for
more details. It turns out there were no strncmp() calls in the self
tests, this adds one.

Link: https://lore.kernel.org/all/2801162.88bMQJbFj6@diego/
Reported-by: Heiko Stübner <heiko@sntech.de>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---

v1->v2: Added two more tests (pos/neg). (Andy)
        Minor code style issues. (Andy)
        Fixed checkpatch errors.

---
lib/test_string.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/lib/test_string.c b/lib/test_string.c
index 550229084c41..b95037eb138b 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -209,6 +209,44 @@ static __init int strspn_selftest(void)
 	return 0;
 }
 
+struct strncmp_test {
+	const char *str_a;
+	const char *str_b;
+	unsigned long count;
+	unsigned long max_off;
+	int retval;
+};
+
+static __init int strncmp_selftest(void)
+{
+	size_t i;
+	static const struct strncmp_test tests[] __initconst = {
+		{ "/dev/vda", "/dev/", 5, 4, 0 },
+		{ "/dev/vda", "/dev/vdb", 5, 4, 0 },
+		{ "00000000---11111", "00000000---11112", 12, 4, 0 },
+		{ "ABC", "AB", 3, 0, 67 },
+		{ "ABA", "ABZ", 3, 0, -25 },
+		{ "ABC", "ABC", 3, 0, 0 },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		const struct strncmp_test *s = tests + i;
+		size_t off;
+
+		for (off = 0; off <= s->max_off; off++) {
+			int res = strncmp(s->str_a + off, s->str_b + off, s->count - off);
+
+			if (res == 0 && s->retval != 0)
+				return 0x1000 + 0x100*off + 0x10*i + 0x0;
+			if (res > 0 && s->retval <= 0)
+				return 0x1000 + 0x100*off + 0x10*i + 0x1;
+			if (res < 0 && s->retval >= 0)
+				return 0x1000 + 0x100*off + 0x10*i + 0x2;
+		}
+	}
+	return 0;
+}
+
 static __exit void string_selftest_remove(void)
 {
 }
@@ -247,6 +285,11 @@ static __init int string_selftest_init(void)
 	if (subtest)
 		goto fail;
 
+	test = 7;
+	subtest = strncmp_selftest();
+	if (subtest)
+		goto fail;
+
 	pr_info("String selftests succeeded\n");
 	return 0;
 fail:
-- 
2.37.2

