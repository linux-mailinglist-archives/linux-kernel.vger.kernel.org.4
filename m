Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5570865A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjERREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjERREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:04:06 -0400
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 10:04:00 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01297E69
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:04:00 -0700 (PDT)
X-QQ-mid: bizesmtp68t1684429433tu2oywf5
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 19 May 2023 01:03:52 +0800 (CST)
X-QQ-SSF: 01200000000000C0V000000A0000000
X-QQ-FEAT: 52Hx6s90yLUx+utHt+6bFHvQXW0WiAszRJitTBNppc4EY8DRALtcS1CtKQmqa
        TlWtRfGFRGdejKhmIK/ziEf82MHLcOCF001VkX/uXD0B++NhRtTTDurusfZESve9dnnCNgi
        U9kLGSI7H5NovK8Rgj69s+0mxS+gcgeFK5f04VREl2E2oDKb2UCJ58NxYZtirW4PjGxaWLK
        9/XKatAVxn3FMJyE0UnD0GrU3aB6SS1sWsAPGi5YpxGRrPReBfcgFn4rMltjipWtP39m5nO
        /5zvjVkwm2aRD8tQepNl9SrNYf1dckkmjtIfWrRL8Ot2aVtRUuMBqpL5kNDxD5a8dezAs1J
        vfjeSpTfnhNqZiZyu6VAHo+loFHyNWHSAgdXVSidN1akhiKr4czN4x8zk31KQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3862181891431925915
From:   Zhangjin Wu <falcon@tinylab.org>
To:     Willy Tarreau <w@1wt.eu>, Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [PATCH 2/2] tools/nolibc: riscv: Support __NR_llseek for rv32
Date:   Fri, 19 May 2023 01:03:50 +0800
Message-Id: <d1d2eabc49e9c8790470010d161ff297c172096c.1684425792.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684425792.git.falcon@tinylab.org>
References: <cover.1684425792.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no __NR_lseek for rv32, use __NR_llseek instead.

This code is based on sysdeps/unix/sysv/linux/lseek.c of glibc.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/std.h |  1 +
 tools/include/nolibc/sys.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 933bc0be7e1c..83c0b0cb9564 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -32,5 +32,6 @@ typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
 typedef   signed long        time_t;
+typedef     long long        loff_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5d624dc63a42..ab32f3c0a460 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -668,7 +668,26 @@ int link(const char *old, const char *new)
 static __attribute__((unused))
 off_t sys_lseek(int fd, off_t offset, int whence)
 {
+#ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
+#elif defined(__NR_llseek)
+	loff_t res;
+	off_t retval;
+
+	int rc = my_syscall5(__NR_llseek, fd, (long) (((uint64_t) (offset)) >> 32), (long) offset, &res, whence);
+
+	if (rc)
+		return rc;
+
+	retval = (off_t) res;
+	if (retval == res)
+		return retval;
+
+	SET_ERRNO(EOVERFLOW);
+	return (off_t) -1;
+#else
+#error Neither __NR_lseek nor __NR_llseek defined, cannot implement sys_lseek()
+#endif
 }
 
 static __attribute__((unused))
-- 
2.25.1

