Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEFF637E40
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKXRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiKXRWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:22:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6AC5F86B;
        Thu, 24 Nov 2022 09:22:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s5so3388092wru.1;
        Thu, 24 Nov 2022 09:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf4MkbDtYqPHkzp1NQggOVlfAtAYmGWu5F6jTUCxlB8=;
        b=qYafnLysxGBAXMN4EjaffIZ65qJZh+y5w1H1fYwJARO8HEQdUwBlR1K0NUxbEqLcMq
         VbJ/DpIJwHYlfO2p/BdkFL3/ulkBdcTj5mODYt0ZQKAvS6srKRc1A82jXkYC9g4M7epZ
         0fbTKvJSfjSwFfWdbL5y1Cmw5HaQqg+ANmz7X8DlqXaRD/vfHruQLAIwWQE+d7vGSYWT
         cH/x18lKJYMlsWozqfjUGaMv3UdipMKGJIozGN21DcGb1Hj8NMZ2+Q1N6KjdQwN0XHPE
         U333xrUw7VTwFUkFK2pi/ftm6G12v9S0odXONtKjTRTtH5M9QOkjmpHG0Z1N1X8KsbWl
         j6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kf4MkbDtYqPHkzp1NQggOVlfAtAYmGWu5F6jTUCxlB8=;
        b=swfHWPracJqXmFFG0M5UUB1WKfoPo6OXQeIl67UyCqBR/NNLnzSSQmFv/WufzateIP
         e+HDDvpiZjKjOTNrFx1K7NtUHSC3hpOqowFQOA3oXsrjVlS4FwxzDOx4GJR2NhhBTluC
         WBXW09OK5yfPho1irDJ+ig/TtzJvk8nac2T++0tcTA2LqiNoBgg91XWCWRjF5non3gok
         qO8Owo8tRKOo9jW15akVNRmj/V/0U/lVXAFUcq8PJTJ7gK6IhSZOQo36JMQpgoB/9Ms9
         6AClkQ6HJTlQ8huiSOLtctawdn1tAC8/2RTeuE3vB1Ws05k+Injy0Gn2UOmJzIGkvXDO
         L1jQ==
X-Gm-Message-State: ANoB5pkRutLUFnQ16YyfkbrSVqXdundVxzSkt25TwgbDu3nfyU3i06tk
        LAZ+NbGjDV4avYcjDpRJrOk=
X-Google-Smtp-Source: AA0mqf53uMvA9midyy+RxAuGlfEqI9h3gmkfBfuFydND+Sko1oOZNqSfyk3uBDaUm8F2FOuZHmJJGg==
X-Received: by 2002:adf:fdc7:0:b0:241:d7ab:db8f with SMTP id i7-20020adffdc7000000b00241d7abdb8fmr12173981wrs.285.1669310563686;
        Thu, 24 Nov 2022 09:22:43 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:89ee:3f5d:1c99:35d8])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003c64c186206sm2698086wmn.16.2022.11.24.09.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:22:43 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH DO NOT REVIEW v4 4/7] riscv: errata: andes: Fix auipc-jalr addresses in patched alternatives
Date:   Thu, 24 Nov 2022 17:22:04 +0000
Message-Id: <20221124172207.153718-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch is added just for building purpose, as patch [0] will export
this in its next version.

https://patchwork.kernel.org/project/linux-riscv/patch/20221110164924.529386-6-heiko@sntech.de/

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, as Heiko will be exporting riscv_alternative_fix_auipc_jalr() function
so that it can be used other erratas Ive just included for compilation.
---
 arch/riscv/errata/andes/errata.c | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index ec3e052ca8c7..4061ad4983bc 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -13,9 +13,80 @@
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/errata_list.h>
+#include <asm/parse_asm.h>
 #include <asm/patch.h>
+#include <asm/sbi.h>
 #include <asm/vendorid_list.h>
 
+/* Copy of Heiko's code from patch [0]
+ * [0] https://patchwork.kernel.org/project/linux-riscv/patch/20221110164924.529386-6-heiko@sntech.de/
+ */
+DECLARE_INSN(jalr, MATCH_JALR, MASK_JALR)
+DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
+
+static inline bool is_auipc_jalr_pair(long insn1, long insn2)
+{
+	return is_auipc_insn(insn1) && is_jalr_insn(insn2);
+}
+
+#define JALR_SIGN_MASK		BIT(I_IMM_SIGN_OPOFF - I_IMM_11_0_OPOFF)
+#define JALR_OFFSET_MASK	I_IMM_11_0_MASK
+#define AUIPC_OFFSET_MASK	U_IMM_31_12_MASK
+#define AUIPC_PAD		(0x00001000)
+#define JALR_SHIFT		I_IMM_11_0_OPOFF
+
+#define to_jalr_imm(offset)						\
+	((offset & I_IMM_11_0_MASK) << I_IMM_11_0_OPOFF)
+
+#define to_auipc_imm(offset)						\
+	((offset & JALR_SIGN_MASK) ?					\
+	((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) :			\
+	(offset & AUIPC_OFFSET_MASK))
+
+static void riscv_alternative_fix_auipc_jalr(unsigned int *alt_ptr,
+					     unsigned int len, int patch_offset)
+{
+	int num_instr = len / sizeof(u32);
+	unsigned int call[2];
+	int i;
+	int imm1;
+	u32 rd1;
+
+	for (i = 0; i < num_instr; i++) {
+		/* is there a further instruction? */
+		if (i + 1 >= num_instr)
+			continue;
+
+		if (!is_auipc_jalr_pair(*(alt_ptr + i), *(alt_ptr + i + 1)))
+			continue;
+
+		/* call will use ra register */
+		rd1 = EXTRACT_RD_REG(*(alt_ptr + i));
+		if (rd1 != 1)
+			continue;
+
+		/* get and adjust new target address */
+		imm1 = EXTRACT_UTYPE_IMM(*(alt_ptr + i));
+		imm1 += EXTRACT_ITYPE_IMM(*(alt_ptr + i + 1));
+		imm1 -= patch_offset;
+
+		/* pick the original auipc + jalr */
+		call[0] = *(alt_ptr + i);
+		call[1] = *(alt_ptr + i + 1);
+
+		/* drop the old IMMs */
+		call[0] &= ~(U_IMM_31_12_MASK);
+		call[1] &= ~(I_IMM_11_0_MASK << I_IMM_11_0_OPOFF);
+
+		/* add the adapted IMMs */
+		call[0] |= to_auipc_imm(imm1);
+		call[1] |= to_jalr_imm(imm1);
+
+		/* patch the call place again */
+		patch_text_nosync(alt_ptr + i, call, 8);
+	}
+}
+
 static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
 {
 	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
-- 
2.25.1

