Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAD6A5EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjB1Sm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjB1Smz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:42:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB710C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:42:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02135B80EAB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6273AC433D2;
        Tue, 28 Feb 2023 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677609771;
        bh=bxf6Na4275DAjaKN9Sr8BVZGW0gjDgYTE05rVuIhWwo=;
        h=From:To:Cc:Subject:Date:From;
        b=fsrpFMka4rEhDNttlbTgKspj87wKZKL1+GEijCxidZ09ngGHpa2+x+se6dC+QQgX6
         fzKhXvYZuB5pOYUYalaQPQ5/49LTwfGl8eBVr/Br6E5sTNqM/ErsTlPRtpEwvGWyOc
         G4nq7wdtH+7FwJ1YICBYnQ09jhSTBt2KNXPyuhI/KjJ8HzOZNLatqJFSlT4ZGJtwS+
         FMYOnlz3Hv2d0mCH2we/Aljk7NVKHs+JbsKtkgNQtgN9QhPWqje8KPPOyauFKDxpPA
         DUuAeRS+SKqtfrMWmdzze3dAjDxRLYQVb4oO50CJkUyn93lZFG+QL+1lBat3aWZQBy
         JS9bHptI/iQpQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] lib/test_string.c: Make definition less dense
Date:   Tue, 28 Feb 2023 19:42:44 +0100
Message-Id: <20230228184245.1585775-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
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

From: Björn Töpel <bjorn@rivosinc.com>

Checkpatch seems to have trouble making sense of the situation when
struct definitions, variable definitions, and __initconst marking is
done in one go.

Let's be nicer to checkpatch, and move the struct definition out,
which removes the error.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 lib/test_string.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/test_string.c b/lib/test_string.c
index c5cb92fb710e..550229084c41 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -179,15 +179,17 @@ static __init int strnchr_selftest(void)
 	return 0;
 }
 
+struct strspn_test {
+	const char str[16];
+	const char accept[16];
+	const char reject[16];
+	unsigned int a;
+	unsigned int r;
+};
+
 static __init int strspn_selftest(void)
 {
-	static const struct strspn_test {
-		const char str[16];
-		const char accept[16];
-		const char reject[16];
-		unsigned a;
-		unsigned r;
-	} tests[] __initconst = {
+	static const struct strspn_test tests[] __initconst = {
 		{ "foobar", "", "", 0, 6 },
 		{ "abba", "abc", "ABBA", 4, 4 },
 		{ "abba", "a", "b", 1, 1 },

base-commit: ae3419fbac845b4d3f3a9fae4cc80c68d82cdf6e
-- 
2.37.2

