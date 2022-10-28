Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3B0610DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJ1J6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiJ1J5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:44 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF21CBA99
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951017; x=1698487017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCBe/q5YolyqbHnPs4c9IauGtcofM9sooHtix6H+SW0=;
  b=lIWCqFwqEsP9jbB6DHK0hQ8ZG9kNq9f5m1kgoNjk1eAIEOru6VEk6pc3
   OL65SV3CS2hF1IvKxSBocn1+jHy58EAK6uFabaSN8klZdht532YOKnYrY
   F0eHODM97lANgxk2FhfMwMBBdoX1tnC5H2AO9Vq+v7/9rsp5YaU20+giX
   u1iFCTu1IqkIf/Vwx3x/ZT5vTHlDXgf74jpeO0I0ys1kXSKuFtgI+kPGx
   78laN4dtV3syBMtL58WAXPvdCl7w8PUx1iVgITyTF9h7ajbkJSW1PlYzu
   INAYyu+QAyV4uz5kGlavNsQ8siTn+Cu1Wxk5+V7PueNoWD0H3lAhKo5O3
   g==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="214962167"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:56:56 +0800
IronPort-SDR: TGBftajlAQB1RTVRseCc8dyKzc/dfvmxjyWgtFQr90W+ZffjRI9fULnXRlj1fGutFb/kos9K6P
 tlm+qWYWDDVowSthRxW72WMUuUZO0ViFXReooVBwZ0rDN9CGip4oGpxKK0SfjLXowHOELKhSf5
 VEBKlFzKFIWOFZwY176PsM1pBa+GeexfigQUnndyUTG9l0Y1QrmwnjBILqtms5vepEzK+Klu7p
 Px4ITc52O+VQr811AlnG3bbDBALSUnfMsS+hpwTT3PXN8RQCyqBpMcLuJ00U2O+s+uNu/R2vxn
 Sl4w0gmF3QEZ+b+sK6MdNRUP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:16:16 -0700
IronPort-SDR: SP8zhc46vgRZU0EtI+e0VVQN7piHlDoH45Hv1qj35VvWNwEArbQ37vAJL8FWKjNUr/NOxOTsm8
 ROD8kQAAAX3gI6o5uaLgFviGnpocZzqwgCUFU9LpL+8V3vMiGDTWE/PhNi2f5a626numjRQV7D
 +kCZMM2JrnvS02j8eHd+PdiTUTGms2bbKkhZs4fQtYdEVOTP7xXf+q4BOLg0Z/CGb+mbU8SMVw
 P2q1cM8xGQiM8/qnlS/wHsKnzNvhlnvQJHnru4wkvriomv6Nq0THpbGcvh3g+SoTEZxp01yDII
 bpw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:56:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHyJ1CsLz1RwqL
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:56:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951014; x=1669543015; bh=cCBe/q5YolyqbHnPs4
        c9IauGtcofM9sooHtix6H+SW0=; b=OAa1FYOtOr8Yv6LLPxBxxoNFUhQW1PLMnJ
        KFEd1oT/7vn16T4Ox7LgvGBdS+hqd6gPwOQD+nIAb+mY8pOgCRmEUosR2o/YvVo7
        wpOApZYhSgJk5YFexLdrCigBcPzlYSH1qa+qFwQ6OpEDnM78Seta0h3nrh40sQme
        m6PJx/hKkzXwqplYVSPZZP6jZpEbq6RStVjLuI+4SJNkY8C/uphHH0wg2GWucedb
        K7fTkvTVRg6JfbnLrdL1GltYKVNnAI5+AYitDl/Pdw2Vvy69WKH6rB4ynzmNbF3H
        kXvPWTYZsbt5AnqAlvR2HFSepDgUBQm5t2SDARtsEN5IOPa9eCSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0QtzsX-_Dr1I for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 02:56:54 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHy76NpKz1Rwt8;
        Fri, 28 Oct 2022 02:56:47 -0700 (PDT)
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
Subject: [PATCH 1/6] perf bench futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 28 Oct 2022 19:56:27 +1000
Message-Id: <20221028095632.1081262-2-alistair.francis@opensource.wdc.com>
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

Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
time_t and as such don't have the SYS_futex syscall. This patch will
allow us to use the SYS_futex_time64 syscall on those platforms.

This also converts the futex calls to be y2038 safe (when built for a
5.1+ kernel).

This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
"Revert "perf bench futex: Add support for 32-bit systems with 64-bit tim=
e_t"".

The original commit was reverted as including linux/time_types.h would
fail to compile on older kernels. This commit doesn't include
linux/time_types.h to avoid this issue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Message-Id: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
---
 tools/perf/bench/futex.h | 52 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc..385d2bdfaa9f 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -8,6 +8,7 @@
 #ifndef _FUTEX_H
 #define _FUTEX_H
=20
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -28,7 +29,17 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex_syscall() - SYS_futex syscall wrapper
+ * This is copied from linux/time_types.h.
+ * We copy this here to avoid compilation failures when running
+ * on systems that don't ship with linux/time_types.h.
+ */
+struct __kernel_old_timespec {
+	__kernel_old_time_t	tv_sec;		/* seconds */
+	long			tv_nsec;	/* nanoseconds */
+};
+
+/**
+ * futex_syscall() - __NR_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -49,14 +60,49 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D syscall(__NR_futex_time64, uaddr, op | opflags, val, timeo=
ut,
+				  uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, =
val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts32;
+
+		ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op | opflags, val, ts32, uaddr2, val=
3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op | opflags, val, NULL, uaddr2, val=
3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op | opflags, val, nr_re=
queue,
+			   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op | opflags, val, nr_requeue, uaddr2=
, val3);
+#endif
 }
=20
 /**
--=20
2.37.3

