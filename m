Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5A610E01
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJ1J6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiJ1J5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A828248A3B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951051; x=1698487051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5sXdRpXoL8fKMHadmBmTH5z4Y4mbuNPDkZAxHvAj8lU=;
  b=j5FwVFpkYrZ3n9vmSI6ZCdaC3au/JB4T5DYCcF/mjSxonGVbkxTxK1c/
   4bHPAxswHfqRPHxswSrdejVU8QfFH/Fc2utKFAihRgN32tG/++klULaIa
   W+UBYKQruBP6xGT7T5+pu3i/SnG2q3Yk9q6ih/p6VfyEh/1f9Uhm9pFb0
   0+cDLbDd0Bx7pILg6nuXhOoMu+iCOtsIeEhDD9v85UXgO1En/lutePvIG
   p9NONOVo7YamnlxY93gDFfa4NzaYLt8bO4KGZVZ9zrBV1fB8jYXRrjl1M
   64qs8N0/6Qmpab6nRansrOwCAgl+/EDreKfVcQv0U71okhtl4l0d/6Om/
   w==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="214962251"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:57:31 +0800
IronPort-SDR: vGXVRuET5nPJyJHBCJmoE8wC+jFCqoIxLRpxW+FJRQqrB5j6rhJPCB5eUvFx07yz36MXJSIJOi
 jJSoMEHbd6ZULQErOmZ84XOugzLzArAr1217sZbT6MxFMDfdihVzSPYsRtuG//a5MmvoDUT35t
 NNOjm3VacT36wfcuxrh1xUsXkWEiNUqJrnjes8tV8CMB2875w8ryhQc8UuBwSt/0DZ500CT++L
 ha9SXdhXYFnBF2MSkY9IgQjq4jWu0uwrp6Tk2485i0KLg2fGVRw1I/Kj5LseaCbWbOogvzBg4+
 gCui2bO5/jaBns39ScFF7137
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:16:51 -0700
IronPort-SDR: 4a3jm/dhZFn5wMyUMAV1EyWsRjIEQNh/O2JDnqxF1dSwlcDKfQ7acN52XC+JsA2ujbA3HUxm5p
 oTLwlYwUaa6kIOBG6bnnLoOdMPznduPSOSUlwjQE5PefwnogLZM0j6ANBtPiT3IfNSKyXPOciy
 giQ9LLykY9cCp24zJkYFL7AF/cYAhMXl7sr5Z+caC8Z+LN93kHoKr0txHA17X237Cn1icogO8S
 I9ZRcLzDEj2BxJOlVzG+HE5gj+EUzEkrMTYQV11vTi8QjuLb825JbApiZ53i9O/A78iFs0c/RH
 XFQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:57:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHyz05fxz1Rx15
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951049; x=1669543050; bh=5sXdRpXoL8fKMHadmB
        mTH5z4Y4mbuNPDkZAxHvAj8lU=; b=i4/10uIu5RyP75V/f5ENBFGxGBQsJdPxTT
        e+kzdLy8o7BJq2hv9WGbJcPNne4tQPPnn2Acj2woZm2Xyp4Jhw3LAI8A/HAIFFwl
        NNiTQBR4Zf4diFyhwtRhDQRyV4eUz8AhcYUH6bk+kk/ew6Ih3Lw2hZlN3MeFCtWq
        yg8I5LQk6DPR8peBUxhVIrW2l/B00G4BReNrsIqnEJFmkQSIk0ZyB2BKx8Y9ZjZH
        HMMi3VYWfIYEbXeJU5BkIuewRNqpBMfAqUzDKolPa5HPPj05XT48eQ9Y3LRbuUoe
        1dKOqJ/YCh/NfdcW9YftXy/87Oq4Y/lmphJilXOocMvsDc8RgHXw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yVrgylNbT07p for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 02:57:29 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHyn26b8z1RwtC;
        Fri, 28 Oct 2022 02:57:20 -0700 (PDT)
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
Subject: [PATCH 5/6] uapi: futex: Add a futex waitv syscall
Date:   Fri, 28 Oct 2022 19:56:31 +1000
Message-Id: <20221028095632.1081262-6-alistair.francis@opensource.wdc.com>
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

This commit adds a futex waitv syscall wrapper that is exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. As the futex_waitv syscall
always expects a 64-bit time_t this can be tricky for 32-bit systems to
get correct.

In order to avoid userspace incorrectly passing the wrong timeouts let's
expose a public helper function that ensures the kernel is passed the
correct timeout struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Message-Id: <20211209235857.423773-5-alistair.francis@opensource.wdc.com>
---
 include/uapi/linux/futex_syscall.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
index bac621eb319c..f637f05a3be0 100644
--- a/include/uapi/linux/futex_syscall.h
+++ b/include/uapi/linux/futex_syscall.h
@@ -89,4 +89,31 @@ __kernel_futex_syscall_nr_requeue(volatile uint32_t *u=
addr, int op, uint32_t val
 	return -1;
 }
=20
+/**
+ * __kernel_futex_syscall_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int
+__kernel_futex_syscall_waitv(volatile struct futex_waitv *waiters, unsig=
ned long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	/* futex_waitv expects a 64-bit time_t */
+	if (sizeof(*timo) =3D=3D sizeof(struct __kernel_timespec))
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clo=
ckid);
+
+	/* If the caller supplied a 32-bit time_t, convert it to 64-bit */
+	if (timo) {
+		struct __kernel_timespec ts_new;
+
+		ts_new.tv_sec =3D timo->tv_sec;
+		ts_new.tv_nsec =3D timo->tv_nsec;
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts_new, =
clockid);
+	} else
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, NULL, clo=
ckid);
+}
+
 #endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.37.3

