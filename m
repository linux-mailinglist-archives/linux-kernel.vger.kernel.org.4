Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2295D6C2729
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCUBPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjCUBOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B8A25B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1126190D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF668C433AC;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=itvMBi7pFpfn0c4qRiVR8pvpX/hmzHY5DmYgarYKaSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8BJx1+AEBiHc0wfeKuAUlx3OngTqlX0g/MaHyny/AlE1iY2Dp1PKx1gxo3l9RoZV
         aHGvhbJo5yMZPISC/y2wU6A7gT1T2BKXVBLJf+5OIk3SpQGJjaUcyyt5fbvc0SlZxw
         iolVyajuIqPUIUXo2s8wO7IrFGruD29UKDtuxeBaT3+zvrh+D45Gc0AS7++6nxuHos
         f64IWQD5xLoVDfSIGHDm7n3QdYUr+YmVkWwEqlcXQ7O5HuBEhiU7rLXa5tALj3gO0h
         Dg99tU6yWh1CIz799dnj/WWr96vTHEjQThXJu8XEvW7xS48eY4mc6tR3RK7i8wmNpz
         0yNGHH/uc+vSw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F358A15403A2; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 10/14] tools/nolibc: Include linux/fcntl.h and remove duplicate code
Date:   Mon, 20 Mar 2023 18:11:33 -0700
Message-Id: <20230321011137.51837-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Include linux/fcntl.h for O_* and AT_*. asm/fcntl.h is included
by linux/fcntl.h, so it can be safely removed.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h   | 2 +-
 tools/include/nolibc/types.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 115579e7f1db..41cad6d6137e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -11,7 +11,6 @@
 #include "std.h"
 
 /* system includes */
-#include <asm/fcntl.h>   // for O_*
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
@@ -20,6 +19,7 @@
 #include <linux/loop.h>
 #include <linux/time.h>
 #include <linux/auxvec.h>
+#include <linux/fcntl.h> // for O_* and AT_*
 
 #include "arch.h"
 #include "errno.h"
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 47a0997d2d74..10823e5ac44b 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -81,11 +81,6 @@
 #define MAXPATHLEN     (PATH_MAX)
 #endif
 
-/* Special FD used by all the *at functions */
-#ifndef AT_FDCWD
-#define AT_FDCWD       (-100)
-#endif
-
 /* whence values for lseek() */
 #define SEEK_SET       0
 #define SEEK_CUR       1
-- 
2.40.0.rc2

