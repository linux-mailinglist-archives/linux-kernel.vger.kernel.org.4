Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08172D0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjFLUr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjFLUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8281BE8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C60C62953
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B93CC433EF;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=zEjOj9DdUomfDLsrKXBstSrS7dzFFqc89ym3/GOXT1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LE1LcIYwMJvI71eAa4GoeB4kWpGGfgWaTbiAYVXU0qUoCLzO5MmgqhfKK7P2GCkGC
         btl1nZaTARSST2jONdpLc4gyzl0eUp+GU+Bs6A04MhrE11HlApUNBKRYiCiH0J+etB
         dQ6SYNKsnA/8IKz+AsgVaDo8/NHDJqe5B1M7PVoW/xyA23SZ50QvTlDxbl1a5R+nCa
         YSOluy0GD5XhknNvzSU9rzNX0ydf4jSe/qv0wjeeDRXD8EtZzbjcZTlZbhFBLqOOJQ
         1xfrhDRt/REVx1PmbXambLE7+1qCS9RI0uJmi3FYgVK0BgERrdYSqcmZtxwJrD3HO/
         lvsDqhtAqjGtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AA609CE09E7; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 01/53] tools/nolibc: tests: use volatile to force stack smashing
Date:   Mon, 12 Jun 2023 13:44:22 -0700
Message-Id: <20230612204514.292087-1-paulmck@kernel.org>
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

Use a volatile pointer to write outside the buffer so the compiler can't
optimize it away.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/lkml/c0584807-511c-4496-b062-1263ea38f349@p183/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 21bacc928bf7..47013b78972e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -667,17 +667,13 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
-#if defined(__clang__)
-__attribute__((optnone))
-#elif defined(__GNUC__)
-__attribute__((optimize("O0")))
-#endif
 static int smash_stack(void)
 {
 	char buf[100];
+	volatile char *ptr = buf;
 
 	for (size_t i = 0; i < 200; i++)
-		buf[i] = 'P';
+		ptr[i] = 'P';
 
 	return 1;
 }
-- 
2.40.1

