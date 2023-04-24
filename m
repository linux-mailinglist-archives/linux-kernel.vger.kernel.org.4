Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB46ED594
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjDXTuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjDXTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80B472A0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:39 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pr2Bi-0006Mz-8I; Mon, 24 Apr 2023 21:49:26 +0200
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
Subject: [PATCH 1/4] RISC-V: create ISA string separately - not as part of cpuinfo
Date:   Mon, 24 Apr 2023 21:49:08 +0200
Message-Id: <20230424194911.264850-2-heiko.stuebner@vrull.eu>
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

The isa string is a very central part of the RISC-V architecture, so will
be needed in other places as well.

So in a first step decouple the generation of the runtime isa-string from
/proc/cpuinfo - its current only user.

The resulting string should not differ from the previously generated one.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/kernel/cpu.c | 70 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3df38052dcbd..ebc478f0a16c 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -193,10 +193,33 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
-static void print_isa_ext(struct seq_file *f)
+static int strlen_isa_ext(void)
 {
 	struct riscv_isa_ext_data *edata;
-	int i = 0, arr_sz;
+	int ext_len = 0, i, arr_sz;
+
+	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
+
+	/* No extension support available */
+	if (arr_sz <= 0)
+		return 0;
+
+	for (i = 0; i <= arr_sz; i++) {
+		edata = &isa_ext_arr[i];
+		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
+			continue;
+
+		/* string length + underscore */
+		ext_len += strlen(edata->uprop) + 1;
+	}
+
+	return ext_len;
+}
+
+static void strcat_isa_ext(char *isa_str)
+{
+	struct riscv_isa_ext_data *edata;
+	int i, arr_sz;
 
 	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
 
@@ -208,7 +231,8 @@ static void print_isa_ext(struct seq_file *f)
 		edata = &isa_ext_arr[i];
 		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
 			continue;
-		seq_printf(f, "_%s", edata->uprop);
+		strcat(isa_str, "_");
+		strcat(isa_str, edata->uprop);
 	}
 }
 
@@ -220,19 +244,49 @@ static void print_isa_ext(struct seq_file *f)
  */
 static const char base_riscv_exts[13] = "imafdqcbkjpvh";
 
-static void print_isa(struct seq_file *f, const char *isa)
+static char *riscv_create_isa_string(const char *isa)
 {
+	int maxlen = 4;
+	char *isa_str;
 	int i;
 
-	seq_puts(f, "isa\t\t: ");
+	/* calculate the needed string length */
+	for (i = 0; i < sizeof(base_riscv_exts); i++)
+		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
+			maxlen++;
+	maxlen += strlen_isa_ext();
+
+	isa_str = kzalloc(maxlen, GFP_KERNEL);
+	if (!isa_str)
+		return ERR_PTR(-ENOMEM);
+
 	/* Print the rv[64/32] part */
-	seq_write(f, isa, 4);
+	strncat(isa_str, isa, 4);
+
 	for (i = 0; i < sizeof(base_riscv_exts); i++) {
 		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
 			/* Print only enabled the base ISA extensions */
-			seq_write(f, &base_riscv_exts[i], 1);
+			strncat(isa_str, &base_riscv_exts[i], 1);
+	}
+
+	strcat_isa_ext(isa_str);
+
+	return isa_str;
+}
+
+static void print_isa(struct seq_file *f, const char *isa)
+{
+	char *isa_str;
+
+	seq_puts(f, "isa\t\t: ");
+
+	isa_str = riscv_create_isa_string(isa);
+	if (!IS_ERR(isa_str)) {
+		seq_write(f, isa_str, strlen(isa_str));
+		kfree(isa_str);
+	} else {
+		seq_puts(f, "unknown");
 	}
-	print_isa_ext(f);
 	seq_puts(f, "\n");
 }
 
-- 
2.39.0

