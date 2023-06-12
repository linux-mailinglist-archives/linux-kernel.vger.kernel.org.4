Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328E172D117
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbjFLUvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbjFLUsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43811994
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E295562F21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24D3C4339B;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=0qJdSevT2VoXww6IrwA93sMpGwJeGq5YXuzo0c9WoWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cynU8Xf5FJnDfOAnabitMNyvFJkhhcCXHGbcwxntjMwhbsKshbGgNoH6S6n1gP6xl
         2CEU0PsJNg2qXIAHRRyrtYLFch/0YwNigLS/6IjQdmdi6kb6mWC/41AhG+zTD6iTe3
         Ixc7CdRDTH/5abH3RDFKoY9KTjzhmGOU3s12ZqYkfwBmu3/MuUSz+C7rAeOF7L0oKP
         w2eT32B/0NNyTloYi7f+oCv2VvLfqylDGnY0SJJCpEUZR8BAjeiYoLEMhkXzq+I+kx
         TS4EoDAoBI8M3vdVmpC5t5XvPaWiUcfvoK5Kt369lCYpNE2VVIxAB6d+s77KPcTXj2
         QEy8hQ149y68g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D42B3CE3A5C; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 19/53] selftests/nolibc: reduce syscalls during space padding
Date:   Mon, 12 Jun 2023 13:44:40 -0700
Message-Id: <20230612204514.292087-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Previously each space character used for alignment during test execution
was written in a single write() call.
This would make the output from strace fairly unreadable.
Coalesce all spaces into a single call to write().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0e2ee513b273..d5d4dea63cd6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -111,19 +111,26 @@ const char *errorname(int err)
 	}
 }
 
+static void putcharn(char c, size_t n)
+{
+	char buf[64];
+
+	memset(buf, c, n);
+	buf[n] = '\0';
+	fputs(buf, stdout);
+}
+
 static int pad_spc(int llen, int cnt, const char *fmt, ...)
 {
 	va_list args;
-	int len;
 	int ret;
 
-	for (len = 0; len < cnt - llen; len++)
-		putchar(' ');
+	putcharn(' ', cnt - llen);
 
 	va_start(args, fmt);
 	ret = vfprintf(stdout, fmt, args);
 	va_end(args);
-	return ret < 0 ? ret : ret + len;
+	return ret < 0 ? ret : ret + cnt - llen;
 }
 
 /* The tests below are intended to be used by the macroes, which evaluate
-- 
2.40.1

