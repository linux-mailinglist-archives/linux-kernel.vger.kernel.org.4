Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C694B610DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJ1J6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJ1J5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:54 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A60A1B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951037; x=1698487037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ukg2qTmNSbfxQotuwWTieHEmVg4/tjCtE5mHopxUMgk=;
  b=Bh4HYT0OFrNKkLXSJ5IUXPjpJeh6oECb0XWZEHhsdQZMd34Ix/LDW0rF
   GqaSkheDbDtpldT+ctIOOOhuVxaOaaBrBjAaM/AQKFZrnQmDaEsZx0i8/
   ehreWu/jShMBNW0AV3rOwMGro/KTix9r2i6NdbqN9OZHGPUZYXHsK7gZw
   OUaxKHCFGxxEwmN8lGjVAUn1FPXmqmp2tWCWG4fItww5VZb2mlkXc4rHE
   TxkD3MZLLFhWXReYP8EXFFXjxMA6l3wmNDpQxGcEln/6yRUZnwN3S6stH
   FvBIUtuymU+2PFTaQDETohvfeBQIX0zK/kUOqnwCEmqFYiOvEJl0oFXYV
   g==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="220111900"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:57:17 +0800
IronPort-SDR: mwKR/BYshG7tOCfAN0iBQ3SHvMMXY19zr3r6YqzCNxFsbUmBzcn4FaO8n+zoZZabudYJbTV8an
 2QJZ18gE1CDyxUZRnUgLWvLTyuaGdQ7EJAWwvVu+zifACYLvabXQ7kWoVXOH9VInZnO9iLd2c7
 pKhw72YKcs42e1zOMV7vz3gsD+wXN2E7/QStXA3k/Z5Eu7yaFt1gYCcAbOjx7RyzuqWg3bNZ3J
 mbh5JD0F8puVl0A/xPguLWlK6YvoGwDbtIOoKVGDAbnEeiRSANvK00yGdm+oXqMfLA4qSrx13P
 N7Dr2wkyE9LIy7HP7VlJYWhg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:16:36 -0700
IronPort-SDR: 1BEZjGNfBcBpOk3JuX4jrv+RtACB8lwxOamt6m7C40VkIpxnglq47O2fgzHmCDcOD7xBFhjND9
 sgsQqHPdynWf5M9y9umzMBF6aZSYeCBYvqQUKHWowmyWdqSu2g21hoVSlzS1vo79NtBKy8K4lp
 Ef2uGgnIWYRgN8GqNGFXXHOqoZLOhUOoXddwh8hSZZPRCQBmUtN2R/686g9tWEgW14a8CfBXn8
 WyahYzcbrpnCfoK6v6D3aa6ADOKtegrkbuFA8Wroq0aLQwxm8a4JVAMACf3xNwQ9uWUe+9lIft
 FnU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:57:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHyd2S7Tz1SHkX
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951031; x=1669543032; bh=Ukg2qTmNSbfxQotuwW
        TieHEmVg4/tjCtE5mHopxUMgk=; b=XoCXBRwRjUVW20Iyiw7Ncz9qA6Y7jOuo8m
        w/G8osTW19FFlzpKM22INyC6m+ZqsW/n1Ch9ryyHlArDTWw5GB0zrU+ZQfljy2oX
        c9kEp9TUbpGba2sWPxxEeX04baDMcX8URqB8BANKiB3LEOlMACM6C+z8GOgLLVIa
        /V6DhcV2n/hnsi6JusbOgc3btLu+n4nNjIEykuu50qKj159tB4KpJoa3tfqyAm3D
        DqQeycQan6SOtNMyUmwhPpoAp6kasc30qw80a32RT+WEeDcCrXkj2xlvU+VWpoeK
        inkUSTGoxo1PxL6eKckIQhzvoCrVaSXMkHLfOi24JRTGYzJ3FhXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1FXjg0k1JJTW for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 02:57:11 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHyS2SsTz1RvTp;
        Fri, 28 Oct 2022 02:57:03 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, dave@stgolabs.net,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        dvhart@infradead.org, mark.rutland@arm.com, peterz@infradead.org,
        arnd@arndb.de, alistair23@gmail.com,
        linux-riscv@lists.infradead.org, mingo@redhat.com,
        alistair.francis@wdc.com, atish.patra@wdc.com
Subject: [PATCH 3/6] uapi: futex: Add a futex syscall
Date:   Fri, 28 Oct 2022 19:56:29 +1000
Message-Id: <20221028095632.1081262-4-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
References: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds two futex syscall wrappers that are exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. This has mostly been because
the overloading of one of the arguments makes it impossible to provide a
single type safe function.

Until recently the single syscall has worked fine. With the introduction
of a 64-bit time_t futex call on 32-bit architectures, this has become
more complex. The logic of handling the two possible futex syscalls is
complex and often implemented incorrectly.

This patch adds two futex syscall functions that correctly handle the
time_t complexity for userspace.

This idea is based on previous discussions:
https://lore.kernel.org/lkml/CAK8P3a3x_EyCiPDpMK54y=3DRtm-Wb08ym2TNiuAZgX=
hYrThcWTw@mail.gmail.com/

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20211209235857.423773-3-alistair.francis@opensource.wdc.com>
---
 include/uapi/linux/futex_syscall.h | 92 ++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 include/uapi/linux/futex_syscall.h

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
new file mode 100644
index 000000000000..bac621eb319c
--- /dev/null
+++ b/include/uapi/linux/futex_syscall.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Futex syscall helper functions
+ *
+ * Copyright (C) 2021 Western Digital.  All Rights Reserved.
+ *
+ * Author: Alistair Francis <alistair.francis@wdc.com>
+ */
+#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
+#define _UAPI_LINUX_FUTEX_SYSCALL_H
+
+#include <unistd.h>
+#include <errno.h>
+#include <linux/futex.h>
+#include <linux/types.h>
+#include <linux/time_types.h>
+#include <stdint.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+
+/**
+ * __kernel_futex_syscall_timeout() - __NR_futex/__NR_futex_time64 sysca=
ll wrapper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @timeout:  an absolute struct timespec
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_timeout(volatile uint32_t *uaddr, int op, uint32_=
t val,
+		      struct timespec *timeout, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2=
, val3);
+
+		if (ret =3D=3D 0 || errno !=3D ENOSYS)
+			return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts_old;
+
+		ts_old.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts_old.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op, val, &ts_old, uaddr2, val3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+/**
+ * __kernel_futex_syscall_nr_requeue() - __NR_futex/__NR_futex_time64 sy=
scall wrapper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @nr_requeue:  an op specific meaning
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_nr_requeue(volatile uint32_t *uaddr, int op, uint=
32_t val,
+			 uint32_t nr_requeue, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uad=
dr2, val3);
+
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.37.3

