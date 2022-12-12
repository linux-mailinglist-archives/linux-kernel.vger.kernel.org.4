Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA64649E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiLLLzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiLLLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:55:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90641F599;
        Mon, 12 Dec 2022 03:55:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4942687wmh.0;
        Mon, 12 Dec 2022 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORVxgTEs6JpzOw6GBN9FhxtQ86wPto0+KjD/hzl5+jc=;
        b=FhUIaooykKXtLBANwPAkCAIuxGKX2dKoYk3gCD5ZA0y3/EFZdEdTjn8HhzvpzthRg6
         qN9LHky8jlcgciO/gPa79iLFZWkW/aoXcW9Yx+eZ1c97tTNaKV9ZHl9hw+dtlEp+S1u1
         NN/RncC3w3ETjog4XIgSCNpoNJjLzfTNnzqPog3hTycCYsbfL++b4+ub5hPmqJDOW/r3
         2WDmyDff9uSuRzrn5JJ7P4AMqs5pElbIR6FRRPODehzq/8yFM4sOTfgxZvDZpGLBeIQ8
         gIvOH4P4BXdIMTNaC4op/XgEyf8V4tfFUOdFCXrce4LPlT2Khb6VpklTLtLEBSBDE6Hf
         PkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORVxgTEs6JpzOw6GBN9FhxtQ86wPto0+KjD/hzl5+jc=;
        b=wQZZSkqzmUQhWILcCxjDoC7H9IOXXuMLbrzri1cyflKUL7pV7fiMxnQNFF5CJSDGtS
         KA7/uI4Nv6IIJqds+bdxcAlktvWdOgGTeE0M4nvBoB4+anLJKBCgb6z1GZ6p48gjdVvP
         7hV/Oxxe+q7TKJePu7D6I2Y0OFdMdoG4bW9HcgQ5MontIFbdvE+V5ZUhwh4zTE3QUDfQ
         dF39+KdnDcQwIRzBMyy+OkS+peOipmDcAzthveG/lS8A4a3XOFgj3vm4edIX80vZbaJI
         Wsvb4PBjEVJ8/N7Vkb/rHlBJp51XWnjC71uxqXH6h0Dawemu/WvmFRnQ5qn0qEn6SMVm
         7VQw==
X-Gm-Message-State: ANoB5pnhhBKAcFmoDo8lpWhFPuz5yN6CIz3AyUZZyeIhQ47/u2fhuEQ1
        m/gKp/mmuW2oKLcI4IJH7BQ=
X-Google-Smtp-Source: AA0mqf55PhJ6NtCNpEMUlsz4dl16CkPXK2qmYSKBVunL6TyfYUkcG/BLYguDKslRg3csPq/Cl6K6mQ==
X-Received: by 2002:a05:600c:3c96:b0:3cf:8d51:1622 with SMTP id bg22-20020a05600c3c9600b003cf8d511622mr12247840wmb.1.1670846132114;
        Mon, 12 Dec 2022 03:55:32 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1484:ef11:b25c:4612])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003b4cba4ef71sm9793820wmq.41.2022.12.12.03.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:55:31 -0800 (PST)
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
Subject: [PATCH v5 2/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Mon, 12 Dec 2022 11:55:01 +0000
Message-Id: <20221212115505.36770-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add Andes Technology to the vendors list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v4 -> v5
* Included RB tags

RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/vendorid_list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index cb89af3f0704..e55407ace0c3 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -5,6 +5,7 @@
 #ifndef ASM_VENDOR_LIST_H
 #define ASM_VENDOR_LIST_H
 
+#define ANDESTECH_VENDOR_ID	0x31e
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
-- 
2.25.1

