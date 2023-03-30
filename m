Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A536E6D1026
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjC3Umt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjC3Umq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:42:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6394DBEC;
        Thu, 30 Mar 2023 13:42:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so12625615wms.1;
        Thu, 30 Mar 2023 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680208962; x=1682800962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7kxFEuDvqvRsu/15YqHcVl/pTqu+171A8GL2tXTVtE=;
        b=nekpz3TVzSg19iWdmhaU8wFQz//KdLZ1tLIPifgqOIKPBqc56TEbYZERbamq6zeqB4
         J4TfE3JyeVi/m2nUGwDC4Yt4CvqDziYoQOyLMRqfAVAnghdVKplKpnoZbENB9yXg1e9Q
         nnAqSqUde+6lVADQKlLsZG0Y6JD6iIVhuxrLevzxmilHaAZyMhXA7Oe5VBO6RJJtA8W1
         dySWTg3pC8j05fis10Y4YjGBsNnxL62+yLk1emP0SLIopZoMDylYMGs3+ujxtb0ojaU+
         0JODgnX27CODaQ4Lir72dZmoEJeCFgLjjKFgYxPSXwefHo5F7oy2nH+EV/unujA2EQjK
         0DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208962; x=1682800962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7kxFEuDvqvRsu/15YqHcVl/pTqu+171A8GL2tXTVtE=;
        b=1cVL3IwR50LppMW4T3fiZnt8sdMgON5MxlTTcrAcdeKIvm8+uzzX4yWPRmmmYikuMm
         qchgNjbQcEES99bLVUGLxeoNJMsO5KwDLy6D4xbR94QrFmDg1a+a/fAdu5VnPjPDmAc2
         OgiLE5FAiwgH/RfLVQiWY0xhd8lvGVB+yCPuWFiVg0Rr+2Xq9UZnmqzZOqKO82GznMy1
         j9My21e/YkmBA/yxdlkalTuSygnf82JmKZIRfBbh08Qg5znW1GfdftfG0aGr3V2MU7UM
         jdrzVPo8vuKxOV4qjACATwqoM0Q+0KaomjUCe/VqRi0sNp+AnEkeeJ3BSPo5Wd7NI4Th
         MMUw==
X-Gm-Message-State: AAQBX9eAa69T03YnLOHlSjBHyCOV8ZragAfLprTmHIQxqAmUylw9FKwO
        XG3IRxN1Fq9ckIgHmx5JMeE=
X-Google-Smtp-Source: AKy350YExm3QsmDb5bKqs2Q8NH9RSHthiIzr4tXraGH9J/z7WwEbDgWlW7+6BcMnPHzhbkypOpBl1g==
X-Received: by 2002:a05:600c:220c:b0:3ee:3fd7:5f85 with SMTP id z12-20020a05600c220c00b003ee3fd75f85mr5007343wml.11.1680208961876;
        Thu, 30 Mar 2023 13:42:41 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:30f2:5b7:ab32:c3f])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4b0c000000b002cfed482e9asm297981wrq.61.2023.03.30.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:42:41 -0700 (PDT)
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
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 2/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Thu, 30 Mar 2023 21:42:13 +0100
Message-Id: <20230330204217.47666-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
2.25.1

