Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE946606C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjAFS6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjAFS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:57:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960581132;
        Fri,  6 Jan 2023 10:57:35 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so4214015wms.0;
        Fri, 06 Jan 2023 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEkrytvYO0Kgixzwv9PuoddkSJ/AseExslie7bV/gg8=;
        b=XvlebBkmccSZ4Wtc06NfVKZ3QqG3DFsombHDUfu3iiH15+CV4RSgypDQZ7XxQNuyuq
         GcxZszQg7V8bjlbfi0hTih6O3V8h+qCeBk6vTcMsuLzY8SmW3GASRtH7fR6zsMj0C7nW
         L2xzgobhVP1kGw5wdG4RvJL9R+S/SlGln44DHpAmn719JY0gkkIWTFB2LVlmXL4cO2fy
         KFk/hRsrXX1N1uXvT/5TW/RCOQ/hYg8VFgxf52Q78K0TrgdnRmjXbv5p6zzCcHbSn6os
         aszyTUnRczp2Tu1/u30hDo1bclvZYuKNiAq9pJYAjD7i2tCYSmC92KyPLmnZaqYaxA1o
         WQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEkrytvYO0Kgixzwv9PuoddkSJ/AseExslie7bV/gg8=;
        b=5+nr8PjuZLfyPbNiG4woev9BdGYosyPhDASfljFyWObj6YaJLcePF6KnH7Gpy4Bo5k
         RjbJVOOUNyC/n4UeidVX3SPFNGxYMtGVTWWP9BoNqK+KfVkMwvsOT6fr0Sm+QvHyaZx+
         KWw+pbYqewtzRVD5KOP2nDyDOtuKeVM2Qfefpdr9lOK7Fvt157vTqf+BJrRlVANi/CUe
         ldHjnom4COP5eub+K4fOd3uYzvpH4OW6uUjQyQi+TM1T1yIWDw2WW+ArL/St4aljZO/t
         LoQA18Gs9sTvSUyS1gtFZCH3/FZUXu2myG5Y1JsmBuMj6i9btdBC2N7u25XQ2YmyKZkC
         unJQ==
X-Gm-Message-State: AFqh2kpYxkKP5zqvDrXV0MakLwaXrnFi5gyfBQ5qT84NuXKTc/3EkfmZ
        ycYXaJpJZSjxBr2fvYftX8E=
X-Google-Smtp-Source: AMrXdXssof9nprooU5Qdtkk2RP44RVZGyzbXaLx0Yy7Q3HpYsZuEx8E1Evx4wBJLinOJlyD3ft7TLg==
X-Received: by 2002:a05:600c:3ba7:b0:3d3:4dac:aa69 with SMTP id n39-20020a05600c3ba700b003d34dacaa69mr39890733wms.36.1673031453955;
        Fri, 06 Jan 2023 10:57:33 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:79e8:5b4e:615a:91cd])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003c5571c27a1sm3162773wmq.32.2023.01.06.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:57:33 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 2/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Fri,  6 Jan 2023 18:55:22 +0000
Message-Id: <20230106185526.260163-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
2.25.1

