Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EFA6C8F0E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCYPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCYPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:45:41 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2743EC6E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:45:39 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32PFjQQQ008047;
        Sat, 25 Mar 2023 16:45:26 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/8] tools/nolibc: add helpers for wait() signal exits
Date:   Sat, 25 Mar 2023 16:45:10 +0100
Message-Id: <20230325154516.7995-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230325154516.7995-1-w@1wt.eu>
References: <20230325154516.7995-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

These are useful for users and will also be used in an upcoming
testcase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 10823e5ac44b..aedd7d9e3f64 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -97,6 +97,8 @@
 /* Macros used on waitpid()'s return status */
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)
+#define WTERMSIG(status)    ((status) & 0x7f)
+#define WIFSIGNALED(status) ((status) - 1 < 0xff)
 
 /* waitpid() flags */
 #define WNOHANG      1
-- 
2.17.5

