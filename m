Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DF708451
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjEROzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjEROz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91E122
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F130C60A52
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0D2C433EF;
        Thu, 18 May 2023 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421723;
        bh=zEjOj9DdUomfDLsrKXBstSrS7dzFFqc89ym3/GOXT1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIsBFX1Ny4utAyZupY3cQkO1912mk5kGP8McWNn0wWQ5MZfhMjlqqWp9cbSjb/b9X
         ZGddSdguSWXri82msb/vYmIN41QT+rUWkpzXSeh39cEtlzyqsvGFPtvNTkob6D1Ffh
         GksLBct27kof6Z4L3OuODpwv8qTQBZ7cw4F5HwRZWLuQhuVcUkLfP8T0UsUJDk/8MM
         lZ1ieYteZKYcysCtVUol/xdkyWAp3+jpDxq4VmjnqDMh47HkMllMZO8XuSP2GFcfzC
         aKzsp9k8XWx2JwODedpezVzeYhntrLUyjOhZCqhE30SfGCDGcUpruk+01gQqX+g2BT
         d5lboSAWpLuBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 12F7ECE0CC3; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 01/15] tools/nolibc: tests: use volatile to force stack smashing
Date:   Thu, 18 May 2023 07:55:07 -0700
Message-Id: <20230518145521.3806117-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

