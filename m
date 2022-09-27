Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460DD5EBF10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiI0JzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI0JzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292D18B0F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2386B61651
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24960C433C1;
        Tue, 27 Sep 2022 09:54:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OV7kzjlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664272495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeX6PtKX2kvtDn5QR53N8cO3UL8mdPEGc350E+XJONg=;
        b=OV7kzjlNBGJtCVX7VYMAW3E7czOFyKt0eAj+4UPoDYvhn8xBRqCkqSi7KFSss+q/7pVjv1
        XM9qB+i0XgJrV1TK4iUHtO3mbTD2Ayru2zqE9j1KeqEAm86jVyX7RgLub9+Wqrfs7JQ5Qg
        JBe19JGzN8TQnJSiUaXEwHYJGLQNFV0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 76a23efb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Sep 2022 09:54:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] utsname: contribute changes to RNG
Date:   Tue, 27 Sep 2022 11:53:54 +0200
Message-Id: <20220927095354.1564465-1-Jason@zx2c4.com>
In-Reply-To: <20220927094039.1563219-1-Jason@zx2c4.com>
References: <20220927094039.1563219-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some small machines with little entropy, a quasi-unique hostname is
sometimes a relevant factor. I've seen, for example, 8 character
alpha-numeric serial numbers. In addition, the time at which the hostname
is set is usually a decent measurement of how long early boot took. So,
call add_device_randomness() on new hostnames, which feeds its arguments
to the RNG in addition to a fresh cycle counter.

Low cost hooks like this never hurt and can only ever help, and since
this costs basically nothing for an operation that is never a fast path,
this is an overall easy win.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 kernel/sys.c            | 2 ++
 kernel/utsname_sysctl.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index b911fa6d81ab..b4b40ccf0949 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -25,6 +25,7 @@
 #include <linux/times.h>
 #include <linux/posix-timers.h>
 #include <linux/security.h>
+#include <linux/random.h>
 #include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/signal.h>
@@ -1366,6 +1367,7 @@ SYSCALL_DEFINE2(sethostname, char __user *, name, int, len)
 	if (!copy_from_user(tmp, name, len)) {
 		struct new_utsname *u;
 
+		add_device_randomness(tmp, len);
 		down_write(&uts_sem);
 		u = utsname();
 		memcpy(u->nodename, tmp, len);
diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 4ca61d49885b..de16bcf14b03 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/random.h>
 #include <linux/sysctl.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
@@ -57,6 +58,7 @@ static int proc_do_uts_string(struct ctl_table *table, int write,
 		 * theoretically be incorrect if there are two parallel writes
 		 * at non-zero offsets to the same sysctl.
 		 */
+		add_device_randomness(tmp_data, sizeof(tmp_data));
 		down_write(&uts_sem);
 		memcpy(get_uts(table), tmp_data, sizeof(tmp_data));
 		up_write(&uts_sem);
-- 
2.37.3

