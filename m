Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E55B47C8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIJRum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIJRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:50:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1800303F8;
        Sat, 10 Sep 2022 10:50:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso2665494wma.1;
        Sat, 10 Sep 2022 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bTW0f8SBzm5P1sArHECp6CqlKNFqaNycgKPMDOk99yk=;
        b=JaFiZNv2CzRiz7KsyvbzgZ6haMdzKOnfvuusFTAgyszlPsad1bChM28cudQzJ1D4HQ
         dHXkKt21uO/HZ5FBfZfsTYUVMEreA1U8bQzljdQ6QO1hiWNNIxSNeWmBPcY1DIg0Wp+0
         3siLgASb8gCp41JQFqQ4hwnKWxqww4T103uYg68Uj7zE44yWqRvreJ3gAHpsVazM9RkZ
         yHs4a8qENZ45i3gj5wOFtqcvJd5Xj9jh/wTn4rIJy65JLvabeXdmRW9Ar75VazOOJyfp
         wgjUGgtg6Su6So8WGGjECuIQU5Em/mykuHLbQ9DaB7LGZDtG3OQmCVD6ejIm2cad91dD
         sOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bTW0f8SBzm5P1sArHECp6CqlKNFqaNycgKPMDOk99yk=;
        b=iGYsF5SRK9/aiXV6SHK7UvIwOK7GgQqhlxTdOvxr1Fw4oudhu+OCP2iiPKh2PKzjVK
         SLES0oTTcsJWPKbqWN9CElgyfwnT55ATj3Zjp9vfQZUhS7peBZzcy9ek0cMsx1Ur0c4I
         PIZZL/9AqzSF5LkYPv7FkN/5/zjklTZPJ/EPUf5vtN+K768q0o8vW4DIMHm37IQLMdls
         QTDDu4epRLf3OHks5KFdc61gfMjFvZHxN6Ae2coUgSJORzXTpIsA4x6JoR5SWixp4/8l
         zFO/s1slPk4TY8zEPfQDLmqxzcvNp8iCBKUmSWftxz5pCoJkO4ES1dzNLqZVwhhI6NHL
         hT7g==
X-Gm-Message-State: ACgBeo063lznxopXQKHI7wxNAeAeyyp0w9lKKDC2N6UgNGXs5l2/Nsyw
        fsglZoffJshELwJ7qs/up5SpEx8wB/z7qg==
X-Google-Smtp-Source: AA6agR5xTg7tMHgB7v3m2n+V1m/EiQSqmu//lN9+qJjzrIuoJDS7YDE+v8xte+XY2SkiWPb5dP2IFg==
X-Received: by 2002:a05:600c:4f4f:b0:3a5:a530:4fd7 with SMTP id m15-20020a05600c4f4f00b003a5a5304fd7mr9161667wmq.36.1662832234926;
        Sat, 10 Sep 2022 10:50:34 -0700 (PDT)
Received: from nz.home (host81-129-83-151.range81-129.btcentralplus.com. [81.129.83.151])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600002a100b00228d183f9c2sm3384957wry.89.2022.09.10.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 10:50:34 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id 6B5D16B65C6E1; Sat, 10 Sep 2022 18:50:33 +0100 (BST)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyich@gmail.com>,
        =?UTF-8?q?=C3=89meric=20Maschino?= <emeric.maschino@gmail.com>,
        linux-ia64@vger.kernel.org,
        matoro <matoro_mailinglist_kernel@matoro.tk>
Subject: [PATCH v3] ia64: fix clock_getres(CLOCK_MONOTONIC) to report ITC frequency
Date:   Sat, 10 Sep 2022 18:50:19 +0100
Message-Id: <20220910175019.3871273-1-slyich@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820151438.d55718d341df99d5747caebb@linux-foundation.org>
References: <20220820151438.d55718d341df99d5747caebb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clock_gettime(CLOCK_MONOTONIC, &tp) is very precise on ia64 as it uses
ITC (similar to rdtsc on x86). It's not quite a hrtimer as it is a few
times slower than 1ns. Usually 2-3ns.

clock_getres(CLOCK_MONOTONIC, &res) never reflected that fact and
reported 0.04s precision (1/HZ value).

In https://bugs.gentoo.org/596382 gstreamer's test suite failed loudly
when it noticed precision discrepancy.

Before the change:

    clock_getres(CLOCK_MONOTONIC, &res) reported 250Hz precision.

After the change:

    clock_getres(CLOCK_MONOTONIC, &res) reports ITC (400Mhz) precision.

The patch is based on matoro's fix. I added a bit of explanation why we
need to special-case arch-specific clock_getres().

CC: Émeric Maschino <emeric.maschino@gmail.com>
CC: linux-ia64@vger.kernel.org
CC: Andrew Morton <akpm@linux-foundation.org>
CC: matoro <matoro_mailinglist_kernel@matoro.tk>
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
Change since v2:
- Moved matoro to CC
Change since v1:
- No code or in-code comment change
- CCed Émeric
- Added matoro's S-O-B the way matoro comfortable with
- Fixed Subject typo s/clock_getre/clock_getres/
 arch/ia64/kernel/sys_ia64.c           | 26 ++++++++++++++++++++++++++
 arch/ia64/kernel/syscalls/syscall.tbl |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index e14db25146c2..d5d47eb4608e 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -166,3 +166,29 @@ ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, u
 		force_successful_syscall_return();
 	return addr;
 }
+
+asmlinkage long
+ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *tp)
+{
+	/*
+	 * ia64's clock_gettime() syscall is implemented as a vdso call
+	 * fsys_clock_gettime(). Currently it handles only
+	 * CLOCK_REALTIME and CLOCK_MONOTONIC. Both are based on
+	 * 'ar.itc' counter which gets incremented at a constant
+	 * frequency. It's usually 400MHz, ~2.5x times slower than CPU
+	 * clock frequency. Which is almost a 1ns hrtimer, but not quite.
+	 *
+	 * Let's special-case these timers to report correct precision
+	 * based on ITC frequency and not HZ frequency for supported
+	 * clocks.
+	 */
+	switch (which_clock) {
+		case CLOCK_REALTIME:
+		case CLOCK_MONOTONIC:
+			s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
+			struct timespec64 rtn_tp = ns_to_timespec64(tick_ns);
+			return put_timespec64(&rtn_tp, tp);
+	}
+
+	return sys_clock_getres(which_clock, tp);
+}
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 78b1d03e86e1..72c929d9902b 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -240,7 +240,7 @@
 228	common	timer_delete			sys_timer_delete
 229	common	clock_settime			sys_clock_settime
 230	common	clock_gettime			sys_clock_gettime
-231	common	clock_getres			sys_clock_getres
+231	common	clock_getres			ia64_clock_getres
 232	common	clock_nanosleep			sys_clock_nanosleep
 233	common	fstatfs64			sys_fstatfs64
 234	common	statfs64			sys_statfs64
-- 
2.37.2

