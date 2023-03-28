Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C06CC14F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjC1Nol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjC1NoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:44:16 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E1BDF5;
        Tue, 28 Mar 2023 06:44:01 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id BFAA9580979;
        Tue, 28 Mar 2023 21:43:33 +0800 (CST)
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chenhuacai@kernel.org, zhangqing@loongson.cn, kernel@xen0n.name,
        mingo@redhat.com, peterz@infradead.org, xiehuan09@gmail.com,
        dinghui@sangfor.com.cn, huangcun@sangfor.com.cn,
        dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH v8 8/8] selftests/ftrace: Add funcgraph-retval test case
Date:   Tue, 28 Mar 2023 06:43:19 -0700
Message-Id: <20230328134319.2185812-9-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328134319.2185812-1-pengdonglin@sangfor.com.cn>
References: <20230328134319.2185812-1-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB8eVh5OSR5LQx8ZHk0ZHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46Aio6NT0WA1YJAQo6DzoZ
        Hi0wFDpVSlVKTUNLS0pKS0pOSkpCVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFIQk9INwY+
X-HM-Tid: 0a872875b2232eb7kusnbfaa9580979
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test case for the funcgraph-retval and funcgraph-retval-hex
trace options.

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
v8:
 - Fix issues in selftest
---
 .../ftrace/test.d/ftrace/fgraph-retval.tc     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
new file mode 100644
index 000000000000..ac6d0183e4d9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function graph print function return value
+# requires: set_graph_function options/funcgraph-retval options/funcgraph-retval-hex function_graph:tracer
+
+# Make sure that funcgraph-retval works
+
+fail() { # msg
+    echo $1
+    exit_fail
+}
+
+echo proc_reg_write > set_graph_function
+echo function_graph > current_tracer
+echo funcgraph-retval > trace_options
+
+enable_tracing
+
+set +e
+echo > /proc/interrupts
+set -e
+
+disable_tracing
+
+: "Test printing the error code in signed decimal format"
+echo nofuncgraph-retval-hex > trace_options
+count=`cat trace | grep 'proc_reg_write' | grep '= -5' | wc -l`
+if [ $count -eq 0 ]; then
+    fail "Return value can not be printed in signed decimal format"
+fi
+
+: "Test printing the error code in hexadecimal format"
+echo funcgraph-retval-hex > trace_options
+count=`cat trace | grep 'proc_reg_write' | grep 'fffffffb' | wc -l`
+if [ $count -eq 0 ]; then
+    fail "Return value can not be printed in hexadecimal format"
+fi
+
+exit 0
-- 
2.25.1

