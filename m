Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1316ED591
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjDXTuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjDXTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2A65FDC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:35 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pr2Bi-0006Mz-OX; Mon, 24 Apr 2023 21:49:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com
Cc:     heiko@sntech.de, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH 2/4] RISC-V: don't parse dt isa string to get rv32/rv64
Date:   Mon, 24 Apr 2023 21:49:09 +0200
Message-Id: <20230424194911.264850-3-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

When filling hwcap the kernel already expects the isa string to start with
rv32 if CONFIG_32BIT and rv64 if CONFIG_64BIT.

So when recreating the runtime isa-string we can also just go the other way
to get the correct starting point for it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/kernel/cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ebc478f0a16c..06c2f587a176 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -244,7 +244,7 @@ static void strcat_isa_ext(char *isa_str)
  */
 static const char base_riscv_exts[13] = "imafdqcbkjpvh";
 
-static char *riscv_create_isa_string(const char *isa)
+static char *riscv_create_isa_string(void)
 {
 	int maxlen = 4;
 	char *isa_str;
@@ -261,7 +261,11 @@ static char *riscv_create_isa_string(const char *isa)
 		return ERR_PTR(-ENOMEM);
 
 	/* Print the rv[64/32] part */
-	strncat(isa_str, isa, 4);
+#if IS_ENABLED(CONFIG_32BIT)
+	strncat(isa_str, "rv32", 4);
+#elif IS_ENABLED(CONFIG_64BIT)
+	strncat(isa_str, "rv64", 4);
+#endif
 
 	for (i = 0; i < sizeof(base_riscv_exts); i++) {
 		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
@@ -280,7 +284,7 @@ static void print_isa(struct seq_file *f, const char *isa)
 
 	seq_puts(f, "isa\t\t: ");
 
-	isa_str = riscv_create_isa_string(isa);
+	isa_str = riscv_create_isa_string();
 	if (!IS_ERR(isa_str)) {
 		seq_write(f, isa_str, strlen(isa_str));
 		kfree(isa_str);
-- 
2.39.0

