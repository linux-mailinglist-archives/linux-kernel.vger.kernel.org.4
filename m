Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F802708456
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjEROzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjEROz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543F12C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6060964FEA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78B9C433A8;
        Thu, 18 May 2023 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421723;
        bh=gd5sfN1vi5rnkiQ19By4Dp4+vXMweeEIcbPWx+T5fUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wd9pVuNpeORTZeUWFooKRKOhtKiYy2P4Iy15dgHOCmPUcEBWxt7y65eWb0DpU0asI
         Cb7lv16vcydmnX2oabt3denMAA6RLDEjvx+3eeSFPbxXfG15DVxwkUdGMY+rJU6vvL
         cIvJAk//TVwEZURnsbwhZxGFqRmaHkVVFrNuuVsxqqIlsl5G6f2d4JdBEPkxlbHowj
         6rOUp2M3CwlNIiLr/yXyaW50PSmd77qULBnDnNPhnBeag3/eZKsNcoMlxeg+AbM5NH
         5TQ22DG+2vQ8ulnrVcV+7LVvNur62iVg+J3zbzk068bAgbqXd0KroTQxUwrjLbRemq
         Cjkg/4SBwENlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 268F4CE18F6; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 09/15] tools/nolibc: use standard __asm__ statements
Date:   Thu, 18 May 2023 07:55:15 -0700
Message-Id: <20230518145521.3806117-9-paulmck@kernel.org>
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

Most of the code was migrated to C99-conformant __asm__ statements
before. It seems string.h was missed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h                | 4 ++--
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index fffdaf6ff467..0c2e06c7c477 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -90,7 +90,7 @@ void *memset(void *dst, int b, size_t len)
 
 	while (len--) {
 		/* prevent gcc from recognizing memset() here */
-		asm volatile("");
+		__asm__ volatile("");
 		*(p++) = b;
 	}
 	return dst;
@@ -139,7 +139,7 @@ size_t strlen(const char *str)
 	size_t len;
 
 	for (len = 0; str[len]; len++)
-		asm("");
+		__asm__("");
 	return len;
 }
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 888da60eb5ba..e692be98973a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -984,7 +984,7 @@ int main(int argc, char **argv, char **envp)
 #else
 		else if (ioperm(0x501, 1, 1) == 0)
 #endif
-			asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
+			__asm__ volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
 		/* if it does nothing, fall back to the regular panic */
 #endif
 	}
-- 
2.40.1

