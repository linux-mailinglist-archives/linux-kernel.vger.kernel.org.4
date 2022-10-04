Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1B5F44D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJDNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJDNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FEF43E4C;
        Tue,  4 Oct 2022 06:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7993F61473;
        Tue,  4 Oct 2022 13:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C62BC433C1;
        Tue,  4 Oct 2022 13:53:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lN96TlCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664891596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGGvRd9tx9SOklVRx77pjHpfXoIfU4l8Se6V+1IEj4w=;
        b=lN96TlCUjwqIARh+3+8S4FtTR0Y8hi2fiAJCYpFALenUt9rWeBGo70OIjdQKAIJlblOQDF
        egJBF5Dxvg33Xgq+sCqH6km4i1Ws0eog1pK5s+87Z/38mHQxs7F/bompuFYKwf+i9+zu+v
        PpdTgthe2J0INsJPOcKZ0fYuCGEshVA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6a6110bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 4 Oct 2022 13:53:15 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] alpha: remove osf_{readv,writev}
Date:   Tue,  4 Oct 2022 15:53:01 +0200
Message-Id: <20221004135301.1420873-1-Jason@zx2c4.com>
In-Reply-To: <CAHk-=wjwvBc3VQMNtUVUrMBVoMPSPu26OuatZ_+1gZ2m-PmmRA@mail.gmail.com>
References: <CAHk-=wjwvBc3VQMNtUVUrMBVoMPSPu26OuatZ_+1gZ2m-PmmRA@mail.gmail.com>
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

As of 987f20a9dcce ("a.out: Remove the a.out implementation"),
sys_osf_{readv,writev} is now the same as sys_{readv,writev}. So remove
the osf indirection, and point the syscall table directly at the generic
functions, as is done on other platforms.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Only compiled and QEMU-booted with no userspace, but seems simple
enough?

 arch/alpha/kernel/osf_sys.c            | 12 ------------
 arch/alpha/kernel/syscalls/syscall.tbl |  4 ++--
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index b3ad8c44c971..6c6c4337e201 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1278,18 +1278,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	return addr;
 }
 
-SYSCALL_DEFINE3(osf_readv, unsigned long, fd,
-		const struct iovec __user *, vector, unsigned long, count)
-{
-	return sys_readv(fd, vector, count);
-}
-
-SYSCALL_DEFINE3(osf_writev, unsigned long, fd,
-		const struct iovec __user *, vector, unsigned long, count)
-{
-	return sys_writev(fd, vector, count);
-}
-
 SYSCALL_DEFINE2(osf_getpriority, int, which, int, who)
 {
 	int prio = sys_getpriority(which, who);
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 3515bc4f16a4..8ebacf37a8cf 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -125,8 +125,8 @@
 116	common	osf_gettimeofday		sys_osf_gettimeofday
 117	common	osf_getrusage			sys_osf_getrusage
 118	common	getsockopt			sys_getsockopt
-120	common	readv				sys_osf_readv
-121	common	writev				sys_osf_writev
+120	common	readv				sys_readv
+121	common	writev				sys_writev
 122	common	osf_settimeofday		sys_osf_settimeofday
 123	common	fchown				sys_fchown
 124	common	fchmod				sys_fchmod
-- 
2.37.3

