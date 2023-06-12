Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F42172D0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjFLUrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjFLUqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA202127
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D954B62B2F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43409C433A0;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=thHRx3gNkEts77+ULbTuRFI/XccuwcFtR++swDbxeA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IIyRNxNo1pgSe1Dn8b4snZ4lkloc99dpMH5LjxJD09XIZhMLinvsM6aCNqRkPudK9
         iDAHvmG/6AKVDvCEEaoOihPjy7/15YbJKo4UJZPLk7qLz+EiR8cQPCqWNhs9VJNq+M
         DyC7HuB7mg4tENGb/XCHuiAB+yKXtEqsEZQWHFlX5zivcdMriGnVO38bKHjKAsLIx+
         e79wp1RiRUOc06c36NOCJQ2nwemqKeTseG/dIYgsTkeYKnFuEGNW2iSm/HGVqP5Jbi
         a0JhheIZMYY77d+ZPR6ysl8Z43aBXyTMPusrR4QclpuA9gvqlDq7ydPOiWtvdQmID4
         wFvHN6MFlWm0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4267CE3A22; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 05/53] tools/nolibc: add wrapper for memfd_create
Date:   Mon, 12 Jun 2023 13:44:26 -0700
Message-Id: <20230612204514.292087-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
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

This is useful for users and will also be used by a future testcase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5d624dc63a42..bea9760dbd16 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1365,6 +1365,29 @@ ssize_t write(int fd, const void *buf, size_t count)
 	return ret;
 }
 
+
+/*
+ * int memfd_create(const char *name, unsigned int flags);
+ */
+
+static __attribute__((unused))
+int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return my_syscall2(__NR_memfd_create, name, flags);
+}
+
+static __attribute__((unused))
+int memfd_create(const char *name, unsigned int flags)
+{
+	ssize_t ret = sys_memfd_create(name, flags);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
-- 
2.40.1

