Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD576FBD1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjEICXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEICXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:23:32 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 466E793FE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B7r1H
        xceD8xEK8s87PGYO33d2ZP2EMjWFu6ZqdrIJYA=; b=ewLVubx1vuM7+F2HbEh6V
        RjjOdHi/nSWdQ/2WLQC1kQqlhrdBUjn+AS3iO1Cl3P/qjYbHFc1y3zO0hmmzArbF
        9Cgc7Vdcq6whuRQIhEFyDje45wz+lPNhG/xh+qV7TeztGbge+JIrrPhZ+2HwAu3b
        l6ArpdN92sy3RAwZeyJsIw=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wBXf4dSrllkqHhsBQ--.30265S3;
        Tue, 09 May 2023 10:22:13 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     ajones@ventanamicro.com
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhangfei@nj.iscas.ac.cn
Subject: [PATCH 2/2] riscv: Optimize memset
Date:   Tue,  9 May 2023 10:22:06 +0800
Message-Id: <20230509022207.3700-2-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509022207.3700-1-zhang_fei_0403@163.com>
References: <20230505-9ec599a36801972451e8b17f@orel>
 <20230509022207.3700-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXf4dSrllkqHhsBQ--.30265S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryxZw13AF1kGw15JFW7twb_yoWDZwc_Jr
        WxCa97JFyDJFZ3Za9rtw15Kry8uFZ8KrykGF1Dtw1UG3WFkr13trWYqry5Ar18XwsrGay3
        G3ZrJrWrXr1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeYNt3UUUUU==
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/1tbiWxZql2I0Z8wmqwAAsA
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangfei <zhangfei@nj.iscas.ac.cn>

This patch has been optimized for memset data sizes less than 16 bytes.
Compared to byte by byte storage, significant performance improvement has been achieved.

Signed-off-by: Fei Zhang <zhangfei@nj.iscas.ac.cn>
---
 arch/riscv/lib/memset.S | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
index e613c5c27998..6113a2696e79 100644
--- a/arch/riscv/lib/memset.S
+++ b/arch/riscv/lib/memset.S
@@ -106,9 +106,36 @@ WEAK(memset)
 	beqz	a2, 6f
 	add	a3, t0, a2
 5:
-	sb	a1, 0(t0)
-	addi	t0, t0, 1
-	bltu	t0, a3, 5b
+       sb      a1,  0(t0)
+       sb      a1, -1(a3)
+       li      a4, 2
+       bgeu    a4, a2, 6f
+
+       sb 	a1,  1(t0)
+       sb 	a1,  2(t0)
+       sb 	a1, -2(a3)
+       sb 	a1, -3(a3)
+       li 	a4, 6
+       bgeu 	a4, a2, 6f
+
+       sb 	a1,  3(t0)
+       sb 	a1, -4(a3)
+       li 	a4, 8
+       bgeu    a4, a2, 6f
+
+       sb 	a1,  4(t0)
+       sb 	a1, -5(a3)
+       li 	a4, 10
+       bgeu 	a4, a2, 6f
+
+       sb 	a1,  5(t0)
+       sb 	a1,  6(t0)
+       sb 	a1, -6(a3)
+       sb 	a1, -7(a3)
+       li 	a4, 14
+       bgeu 	a4, a2, 6f
+
+       sb 	a1, 7(t0)
 6:
 	ret
 END(__memset)
-- 
2.33.0

