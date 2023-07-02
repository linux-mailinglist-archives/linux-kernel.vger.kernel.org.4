Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F04745250
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGBUez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGBUew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:34:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447BE4D;
        Sun,  2 Jul 2023 13:34:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so1880841f8f.3;
        Sun, 02 Jul 2023 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688330090; x=1690922090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID8kESIcXo+JBd9ohyZe9IZLbyTyjD8SbfRbMI5qFEo=;
        b=BAuhXWyxUV9jb2UkRQTf9DPJNkmILjxCO5NWyiVZ/O2FX1ngphoU4v2czSJDx8AItf
         lvxD8Lxu1jXc22ZXwp5l8kNG9BwtcfNp0yltgOOqN7jdtr0PNWgFiCsbCt3zl+jjnqdf
         Tx4BxoJM357CkqkNVVkHnv/04rd2KR41O2XYeJwJRzs/KrSyqiNCBaA/ayPqzHRPYsPG
         dG/v8xp2+K9hQGRuw3+5hXcZFm66D368KDRr6KVqwDy990c8d0HwleuPNP04BtzfGmna
         ZaWZCg8Bp3ZTCVq23Z6WvP2z9DbpSb4nJO+QmnbYP2mEa4UvckUsRIP4bljz2xOoQhjD
         wXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688330090; x=1690922090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID8kESIcXo+JBd9ohyZe9IZLbyTyjD8SbfRbMI5qFEo=;
        b=NMXqsMT7iVM57B1jKJO9+TAcl7BIQhAHqYs3gaF1d9zhL2XDpKmh10znesxTYhlp+1
         q1lvwn9hFy3nsVfbiWqkV/mU6Cb7HAtNg3QCRT0hGWmMPtziFvMSjIdyEDVeKdCUXFdw
         t6cCugRqpL7pPZa1LcW0P3SoyzTYFwG8/zRzgURDuiDWTh+ouS6hwpYaGMbGvR6Kh3tG
         8hoduAWonrfvy/9XFjy4U9I/bYgHTdkjUt7+ado/5U35xIrGFcUjrGSiw02Oa1U63o/R
         H+KIfLo6Oc/WcoRhtG//zg57l82vUpR2DovcGmun1ivFgMvtaXplJpImDELNjmJf9ue1
         c/fw==
X-Gm-Message-State: ABy/qLYp08y+0l0hhsbGVWJcegzd3rEJu1H21o2ZxMCksw+L1vMpWkEY
        gTNHvvxH1/m+1utolsszCF8=
X-Google-Smtp-Source: APBJJlF/U8GeITsUI1y3/TsqaILmZuxoWDfflBDvjfxNDCBS2XuisYyt26PsVfIBN97jJ0wEbKaJhg==
X-Received: by 2002:adf:fc08:0:b0:314:824:378c with SMTP id i8-20020adffc08000000b003140824378cmr6798565wrr.20.1688330089839;
        Sun, 02 Jul 2023 13:34:49 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b4ae:ae48:2e1b:1dcd])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm24000478wrv.74.2023.07.02.13.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:34:49 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v10 1/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Sun,  2 Jul 2023 21:34:24 +0100
Message-Id: <20230702203429.237615-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v9 -> v10
* Included TB tag from Conor

v8 -> v9
* Included RB tag from Geert

v7 -> v8
* No change

v6 -> v7
* No change

v5 -> v6
* No change

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
2.34.1

