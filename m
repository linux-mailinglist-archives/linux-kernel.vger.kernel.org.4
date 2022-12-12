Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D205649E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiLLLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiLLLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:55:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81789C35;
        Mon, 12 Dec 2022 03:55:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg10so5078607wmb.1;
        Mon, 12 Dec 2022 03:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpXOFyKc/JZvQOWHQWc0AJS8A/69Ui8DKNz8njSVnfU=;
        b=BJ0Dsjc/SFk5h+zyozkC2I4LnZ37r72za6ZXGBwb7D1To2ZeM1nYZW2wsXUMBJYio0
         9homQsaxjhwiwUhxzP8KE2uzxGw5O9e4OEaHc23dKcqN3QDZ3b1RypX523NtbTssg/YI
         aY6ZHSZNKbzbs58UdBwvr5TMENriTjcjLTor/MD/otq+Goe63ci4c71cQUjZpqWbvjUC
         mZLEmw/tuooCxGDmrDL7p32eX7U4DeY+pIW9sk+GT7x8V2yZCH41vUX8zqds1aseOAaf
         UbCC22tz3LtgBwzlaiw/x78gfnk8JnGI4ALNgAGhpjJEuyxrYNFvRpV6R9QuVjJR5zPG
         Lh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpXOFyKc/JZvQOWHQWc0AJS8A/69Ui8DKNz8njSVnfU=;
        b=MOEm9gW+Yf7zJ1js02xZeADWRY5DpX9lhdOGbbvCQcisihuxY9CQdaRh2YLjgs6nkB
         kKIcGpvLqnoQOYW95BWL+0qSi6rf5AXsY1pEy0EcXvi7gKL7E/f3Nq7QjvC3tR1RKtH4
         5Rd9kBJUhm+HYdwh5t5/NoqfWpR4Z7AxNLAvQk54IEZwmf6q5dfu4arUvEr3bZ2vKvBp
         9Shbkg2DZdNyagtxfBB3sgb61tESiYf1OOR2JwGkC7U85wtjpDGkQ65XPlt9QU6H3ROo
         bwBkrx7XzVROoAD6xELyjdVoJ4rMXHOhWZhGEo14HLD/LLaFRIiCXutXTxbisx6NlGoh
         tqdw==
X-Gm-Message-State: ANoB5pn81+8I6iVxpISvyCaeaxUnk3HwdwcXALBXj8cCjE8p1dkZLx2n
        Vb7Rm7b0/PomLQaMmqFQNvE=
X-Google-Smtp-Source: AA0mqf7qYn9J61IyJLyX4K5SxOQpe03ZYZQLW5WHgLCT7YNjAC0PhK9oniKbi712c+6s3Y3Nju7v1Q==
X-Received: by 2002:a1c:cc1a:0:b0:3cf:5583:8b3f with SMTP id h26-20020a1ccc1a000000b003cf55838b3fmr12615303wmb.20.1670846130885;
        Mon, 12 Dec 2022 03:55:30 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1484:ef11:b25c:4612])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003b4cba4ef71sm9793820wmq.41.2022.12.12.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:55:30 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce ALTERNATIVE_3() macro
Date:   Mon, 12 Dec 2022 11:55:00 +0000
Message-Id: <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

A vendor wants to replace an old_content, but another vendor has used
ALTERNATIVE_2() to patch its customized content at the same location.
In this case, this vendor can use macro ALTERNATIVE_3() and then replace
ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.

While at it update comment above ALTERNATIVE_2() macro and make it generic
so that the comment holds good for any new addition of ALTERNATIVE_X()
macros.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5
* Rebased the patch on top of Andrew's series (now in Palmers for next-branch)
* Updated comment for ALTERNATIVE_x() as suggested by Heiko

RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/alternative-macros.h | 46 ++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 7226e2462584..a5b4691520da 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -50,8 +50,17 @@
 	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
 .endm
 
+.macro ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,	\
+				new_c_2, vendor_id_2, errata_id_2, enable_2,	\
+				new_c_3, vendor_id_3, errata_id_3, enable_3
+       ALTERNATIVE_CFG_2 \old_c, \new_c_1, \vendor_id_1, \errata_id_1, \enable_1,	\
+                                 \new_c_2, \vendor_id_2, \errata_id_2, \enable_2
+       ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
+.endm
+
 #define __ALTERNATIVE_CFG(...)		ALTERNATIVE_CFG __VA_ARGS__
 #define __ALTERNATIVE_CFG_2(...)	ALTERNATIVE_CFG_2 __VA_ARGS__
+#define __ALTERNATIVE_CFG_3(...)	ALTERNATIVE_CFG_3 __VA_ARGS__
 
 #else /* !__ASSEMBLY__ */
 
@@ -98,6 +107,13 @@
 	__ALTERNATIVE_CFG(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1)	\
 	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
 
+#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,	\
+				   new_c_2, vendor_id_2, errata_id_2, enable_2,	\
+				   new_c_3, vendor_id_3, errata_id_3, enable_3)	\
+	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,	\
+                                   new_c_2, vendor_id_2, errata_id_2, enable_2)	\
+	ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
+
 #endif /* __ASSEMBLY__ */
 
 #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k)	\
@@ -108,6 +124,13 @@
 	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),	\
 				   new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2))
 
+#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, CONFIG_k_1,		\
+				  new_c_2, vendor_id_2, errata_id_2, CONFIG_k_2,		\
+				  new_c_3, vendor_id_3, errata_id_3, CONFIG_k_3)		\
+	__ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),	\
+				   new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2),	\
+				   new_c_3, vendor_id_3, errata_id_3, IS_ENABLED(CONFIG_k_3))
+
 #else /* CONFIG_RISCV_ALTERNATIVE */
 #ifdef __ASSEMBLY__
 
@@ -152,15 +175,28 @@
 	_ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
 
 /*
- * A vendor wants to replace an old_content, but another vendor has used
- * ALTERNATIVE() to patch its customized content at the same location. In
- * this case, this vendor can create a new macro ALTERNATIVE_2() based
- * on the following sample code and then replace ALTERNATIVE() with
- * ALTERNATIVE_2() to append its customized content.
+ * ALTERNATIVE_x macros allow providing multiple replacement options
+ * for an ALTERNATIVE code section. This is helpful if multiple
+ * implementation variants for the same functionality exist for
+ * different cpu cores.
+ *
+ * Usage:
+ *   ALTERNATIVE_x(old_content,
+ *      new_content1, vendor_id1, errata_id1, CONFIG_k1,
+ *      new_content2, vendor_id2, errata_id2, CONFIG_k2,
+ *      ...
+ *      new_contentx, vendor_idx, errata_idx, CONFIG_kx)
  */
 #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,		\
 				   new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)		\
 	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,	\
 					new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)
 
+#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,		\
+				   new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,		\
+				   new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)		\
+       _ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,	\
+                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,	\
+                                       new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)
+
 #endif
-- 
2.25.1

