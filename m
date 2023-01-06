Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B828366040A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjAFQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjAFQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:12:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9EE35927
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF1FACE1D41
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93289C433EF;
        Fri,  6 Jan 2023 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673021549;
        bh=VVqoRkUDwnsCIlYEoiqptxZQONeF/KwdyouDY3AymiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=R7mi1oekbqGue9wYgiHJm224AXmui6dnEfJSRFh1ULEJtO7EUWn8+YA7bqh41Z8RH
         1GQorgYPL5mqv8EjYc5yIPihjDLq+8Lui48HhgSE6F4Fta8vgANOUsJJmUyS0ky1oA
         C1JzuVo+8RvqdILCmM0riVmzE7/srsvJSapkVLaqsK8oc5BjZr/XEvMLq45oYKwroA
         YQyg0Eaa607TFSrV+ALJQMa/o7FOCNP4XjdYDDx4jIj0jWcwRRNDIQip33MpGqmUOE
         EHwDNlnsyho1FKz2ZBdfEBPsL5iRXXX3hQvQ25djwITr8GqNlW4kXmV9uE1p7Oqxov
         lpsQPOBOaE/4Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Myrtle Shah <gatecat@ds0.me>
Subject: [PATCH] riscv: fix -Wundef warning for CONFIG_RISCV_BOOT_SPINWAIT
Date:   Sat,  7 Jan 2023 01:12:13 +0900
Message-Id: <20230106161213.2374093-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 80b6093b55e3 ("kbuild: add -Wundef to KBUILD_CPPFLAGS
for W=1 builds"), building with W=1 detects misuse of #if.

  $ make W=1 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- arch/riscv/kernel/
    [snip]
    AS      arch/riscv/kernel/head.o
  arch/riscv/kernel/head.S:329:5: warning: "CONFIG_RISCV_BOOT_SPINWAIT" is not defined, evaluates to 0 [-Wundef]
    329 | #if CONFIG_RISCV_BOOT_SPINWAIT
        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~

CONFIG_RISCV_BOOT_SPINWAIT is a bool option. #ifdef should be used.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b865046e4dbb..4bf6c449d78b 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -326,7 +326,7 @@ clear_bss_done:
 	call soc_early_init
 	tail start_kernel
 
-#if CONFIG_RISCV_BOOT_SPINWAIT
+#ifdef CONFIG_RISCV_BOOT_SPINWAIT
 .Lsecondary_start:
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
-- 
2.34.1

