Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6769637E45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKXRXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKXRWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:22:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540FB5C0CF;
        Thu, 24 Nov 2022 09:22:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id t4so1743154wmj.5;
        Thu, 24 Nov 2022 09:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGTeIsZb6dwV09Jxzafi+tDu+2zt3FcJZOZJD63Nq5c=;
        b=A8LwDLViXjTFC1n697iLKxetZVRA1pt1BHLBlG57fgEUyDIx3T36ft5hVIQ4PWKzmP
         SEWBgibKQyMivuFK3DxZaAUP+1xQfM5MQm5PUNzOwwhy6pinBh7c1A0N00k+eca3HU40
         doCckp/rLWs5W8eYAuB/1QNLKN/T2K5t5LgTEMO5dl+cSkBD6azgc26KjPazGrTu7tBe
         UsuuPUnMpPH8o+flRy/pS+igcqSvnvLnemkQvzO0njGh16HP33hXmD6NolW8/jx5CwlA
         9zZE/8pwDgITjGWh7k23C+uldZMkh2eXjUJ6lumuOfiz8TNIFPPedzTKOpaKWlvQq5nQ
         +MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGTeIsZb6dwV09Jxzafi+tDu+2zt3FcJZOZJD63Nq5c=;
        b=Sf6gnxly9SDTUEJDO4DKYvP8gkO+j+2f8IovApg9YuYOKc0xKyDiDMq1IghpGC+023
         VRmN4jEWgtWyyVcUlrx6KGKDN4AU/5papyomvP9MrfcidXsW3FDD062t/EsWLKERLGpk
         u8gl4DdNHxOIwQYagfc3D2HLRyylLwZJGcPGr2liI1fbvaDOU+8WrKusWEoU4BB02p0n
         X5Bn4t+aMuVCVoEfw0JssB1vTPRHjnAeHcrNN6vgmaIK99bz4lkxDpThoO0otQb92rsg
         xjrG4zR7zSTl7wuAySNlhuv4VTY6y3I3iRJc94+tUxSv7l9Qwi2zJRLTt5g/0waPYs2L
         geag==
X-Gm-Message-State: ANoB5pl/xeBQwaZ6L8arMcmuNI2A4G2wpimq9Wk38izb16K2ZEVtSkPF
        QFMS6t5FtfUUCKAXdo1aMKU=
X-Google-Smtp-Source: AA0mqf4/eGyD9maTGYn7KxarvFxZbqpMMQXISgDYXlp/nDaqQuuYHzBHEsZXJQoOOkcvNv2BBWShUw==
X-Received: by 2002:a05:600c:3108:b0:3cf:8058:43b8 with SMTP id g8-20020a05600c310800b003cf805843b8mr12220757wmo.95.1669310559371;
        Thu, 24 Nov 2022 09:22:39 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:89ee:3f5d:1c99:35d8])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003c64c186206sm2698086wmn.16.2022.11.24.09.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:22:38 -0800 (PST)
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
Subject: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce ALTERNATIVE_3() macro
Date:   Thu, 24 Nov 2022 17:22:01 +0000
Message-Id: <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Introduce ALTERNATIVE_3() macro.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/alternative-macros.h | 94 +++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index ec2f3f1b836f..1caf4306b3d6 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -69,6 +69,34 @@
 				   new_c_2, vendor_id_2, errata_id_2,	\
 					IS_ENABLED(CONFIG_k_2)
 
+.macro __ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
+				  new_c_2, vendor_id_2, errata_id_2, enable_2, \
+				  new_c_3, vendor_id_3, errata_id_3, enable_3
+886 :
+	.option push
+	.option norvc
+	.option norelax
+	\old_c
+	.option pop
+887 :
+	ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
+	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
+	ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
+.endm
+
+#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2,			\
+				  new_c_3, vendor_id_3, errata_id_3,	\
+					CONFIG_k_3)			\
+	__ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					IS_ENABLED(CONFIG_k_1),		\
+				   new_c_2, vendor_id_2, errata_id_2,	\
+					IS_ENABLED(CONFIG_k_2),		\
+				   new_c_3, vendor_id_3, errata_id_3,	\
+					IS_ENABLED(CONFIG_k_3)
+
 #else /* !__ASSEMBLY__ */
 
 #include <asm/asm.h>
@@ -135,6 +163,36 @@
 				   new_c_2, vendor_id_2, errata_id_2,	\
 					IS_ENABLED(CONFIG_k_2))
 
+#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					enable_1,			\
+				   new_c_2, vendor_id_2, errata_id_2,	\
+					enable_2,			\
+				   new_c_3, vendor_id_3, errata_id_3,	\
+					enable_3)			\
+	"886 :\n"							\
+	".option push\n"						\
+	".option norvc\n"						\
+	".option norelax\n"						\
+	old_c "\n"							\
+	".option pop\n"							\
+	"887 :\n"							\
+	ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)	\
+	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)	\
+	ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
+
+#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2,			\
+				  new_c_3, vendor_id_3, errata_id_3,	\
+					CONFIG_k_3)			\
+	__ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					IS_ENABLED(CONFIG_k_1),		\
+				   new_c_2, vendor_id_2, errata_id_2,	\
+					IS_ENABLED(CONFIG_k_2),	\
+				   new_c_3, vendor_id_3, errata_id_3,	\
+					IS_ENABLED(CONFIG_k_3))
+
 #endif /* __ASSEMBLY__ */
 
 #else /* CONFIG_RISCV_ALTERNATIVE */
@@ -153,6 +211,14 @@
 					CONFIG_k_2)			\
        __ALTERNATIVE_CFG old_c
 
+#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2,			\
+				  new_c_3, vendor_id_3, errata_id_3,	\
+					CONFIG_k_3)			\
+       __ALTERNATIVE_CFG old_c
+
 #else /* !__ASSEMBLY__ */
 
 #define __ALTERNATIVE_CFG(old_c)  \
@@ -167,6 +233,14 @@
 					CONFIG_k_2) \
        __ALTERNATIVE_CFG(old_c)
 
+#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
+					CONFIG_k_1,			\
+				  new_c_2, vendor_id_2, errata_id_2,	\
+					CONFIG_k_2,			\
+				  new_c_3, vendor_id_3, errata_id_3,	\
+					CONFIG_k_3) \
+       __ALTERNATIVE_CFG(old_c)
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_RISCV_ALTERNATIVE */
 
@@ -202,4 +276,24 @@
 					new_content_2, vendor_id_2,	\
 					    errata_id_2, CONFIG_k_2)
 
+/*
+ * A vendor wants to replace an old_content, but another vendor has used
+ * ALTERNATIVE_2() to patch its customized content at the same location. In
+ * this case, this vendor can create a new macro ALTERNATIVE_3() based
+ * on the following sample code and then replace ALTERNATIVE_2() with
+ * ALTERNATIVE_3() to append its customized content.
+ */
+#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1,		\
+					errata_id_1, CONFIG_k_1,	\
+				   new_content_2, vendor_id_2,		\
+					errata_id_2, CONFIG_k_2,	\
+				   new_content_3, vendor_id_3,		\
+					errata_id_3, CONFIG_k_3)	\
+	_ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1,	\
+					    errata_id_1, CONFIG_k_1,	\
+					new_content_2, vendor_id_2,	\
+					    errata_id_2, CONFIG_k_2,	\
+					new_content_3, vendor_id_3,	\
+					    errata_id_3, CONFIG_k_3)
+
 #endif
-- 
2.25.1

