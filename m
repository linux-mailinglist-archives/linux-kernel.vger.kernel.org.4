Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1003C6FE986
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjEKBfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjEKBfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:35:21 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F9C33A96
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cR7+2
        t+0b0AcTv+1gS1SNzk+cirj2d8JCGOUBrY8OuU=; b=N6U+GLfJwnELRIvyHdX0i
        Ihhsnlk5QG0LKMS7AFckJNdKB2ihMBEcViphfplKRfJk1FcCo+YGyLG656lWdX8d
        4A0yhhEJruIqLzG+DLl4w75gtTvzgdZMjNEJm19CmMoaeU9+/Oq0h1K3/ptlrrKh
        wacwv/XM7B9VJ0d4wgkcDc=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wAHa+BFRlxkpawlBg--.7119S2;
        Thu, 11 May 2023 09:35:01 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     zhang_fei_0403@163.com
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhangfei@nj.iscas.ac.cn
Subject: [PATCH v2 2/2] RISC-V: lib: Optimize memset performance
Date:   Thu, 11 May 2023 09:34:53 +0800
Message-Id: <20230511013453.3275-1-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511012604.3222-1-zhang_fei_0403@163.com>
References: <20230511012604.3222-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHa+BFRlxkpawlBg--.7119S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17ur4rJr1fuF1rArW8Zwb_yoW8GrW5pr
        4rCFs3Kr15trn3Wr9xtw1qqr45GayfKw15Grsrtw1kJrsrWa1jv34rX3y5WFy7Gryvyrs3
        Zr42yr18WF1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRVOJrUUUUU=
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/xtbCfA9sl2DcJgt+CAAAsv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangfei <zhangfei@nj.iscas.ac.cn>

Optimized performance when the data size is less than 16 bytes.
Compared to byte by byte storage, significant performance improvement has been achieved.
It allows storage instructions to be executed in parallel and reduces the number of jumps.
Additional checks can avoid redundant stores.

Signed-off-by: Fei Zhang <zhangfei@nj.iscas.ac.cn>
---
 arch/riscv/lib/memset.S | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
index e613c5c27998..452764bc9900 100644
--- a/arch/riscv/lib/memset.S
+++ b/arch/riscv/lib/memset.S
@@ -106,9 +106,43 @@ WEAK(memset)
 	beqz	a2, 6f
 	add	a3, t0, a2
 5:
-	sb	a1, 0(t0)
-	addi	t0, t0, 1
-	bltu	t0, a3, 5b
+       /* fill head and tail with minimal branching */
+       sb      a1,  0(t0)
+       sb      a1, -1(a3)
+       li 	a4, 2
+       bgeu 	a4, a2, 6f
+
+       sb 	a1,  1(t0)
+       sb 	a1,  2(t0)
+       sb 	a1, -2(a3)
+       sb 	a1, -3(a3)
+       li 	a4, 6
+       bgeu 	a4, a2, 6f
+
+       /* 
+        * Adding additional detection to avoid 
+        * redundant stores can lead 
+        * to better performance
+        */
+       sb 	a1,  3(t0)
+       sb 	a1, -4(a3)
+       li 	a4, 8
+       bgeu 	a4, a2, 6f
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
+       /* store the last byte */
+       sb 	a1,  7(t0)
 6:
 	ret
 END(__memset)
-- 
2.33.0

