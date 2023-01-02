Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BA65B25E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjABMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjABMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:50:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0F15FE5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE4160EBD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D89C433EF;
        Mon,  2 Jan 2023 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672663813;
        bh=J83fkE2BSX1IZ8EPpp2Ze1Betbt1ngFYzvqYU3Slg3I=;
        h=From:To:Cc:Subject:Date:From;
        b=PPDBfr5Q0Btm6wpX2S6XhgndtWGV2Os9tV79H12FEylL9hFMqxL/zQdrOq1trGWLm
         gRAVcY+mq9vRNuQaNrvCwpsKhvii6iyB4/kanb9voWAZ/1luK0OPaXkduDz5w0vOL8
         Iyz5rKy4DnfgPaP+N8tmZS/bXFNOk0uku9LY9/I/QZ0WKAatCKwzSXOwn+jQgWs9eP
         sYPvVIeTIyUL6tlBfN06U7dZC7FLK59eCIdbuV0Wq+YFpEEQreYutZqohZqkaArG0b
         xoXau46gBd+zEKGd9QsTuNP9V2nrrcnJ+gcw97PEGEWH7QBzG+j2BaZAMlUQTp4nH5
         Cvx01y0dOvB0Q==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        masahiroy@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] RISC-V: define RUNTIME_DISCARD_EXIT
Date:   Mon,  2 Jan 2023 12:49:37 +0000
Message-Id: <20230102124936.1363533-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=conor.dooley@microchip.com; h=from:subject; bh=J5y6smCcDKVWS6LKYLyNRzrIDBkYbbewNOPjlfn0gJc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMmbLt0LWGd/VLlihUrL4xtTzjL+7Jc0k9//YUHQ145tCy9P uvnLpaOUhUGMg0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATWf+dkeFnypYXJ+QmBx5POfhfMT JEdPad6Ksn/s1V4p1ux+z62nojI8O01LyQm9krn5g+7WHW0VcNeCJ746XGuSP/MwXm9r37fZwZAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Masahiro noted:
> arch/riscv/kernel/vmlinux.lds.S clearly says:
> /* we have to discard exit text and such at runtime, not link time */
> [...]
> so riscv should define RUNTIME_DISCARD_EXIT like x86, arm64.

As things stand, no ill comes of this - but if "DISCARDS" was to be
re-ordered in the linker script, linking would fail.
Do as suggested by Masahiro and define RUNTIME_DISCARD_EXIT.

Link: https://lore.kernel.org/all/CAK7LNAT39aZEw=0209ovYZ2kxtOaA2a51=XD9=LqYHjkTOEK4g@mail.gmail.com/
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 4e6c88aa4d87..07c19f2a288c 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -5,6 +5,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	4
+#define RUNTIME_DISCARD_EXIT
 
 #ifdef CONFIG_XIP_KERNEL
 #include "vmlinux-xip.lds.S"
-- 
2.39.0

