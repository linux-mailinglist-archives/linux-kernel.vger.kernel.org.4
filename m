Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E890E6F3989
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjEAVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAVCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:02:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9BE1BDC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:02:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-642f5394651so528577b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682974967; x=1685566967;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fctEC41u76rTML4CTTx2jHE+S5zx89fZLmwJsiIL5So=;
        b=gg6yVxNsBS5x4HtlfKW+Oxy+TgP/Op/y9K/EVFxOQfNO52SSvoDUOn8N6xzYKeEfko
         vGLAVc8SOZP5ecmjgvNQ73oT3hEfuH4gdCcoq3iP1jAzcYe3Csi1mVG9F+8uXLKs8RSt
         +6+51X+rhf4ZAeVr5XOxmEtsG+7SZZz9Zgw70ccJubeB1Z62q2Nb+jbrZkOzzik+HSb2
         DmWrnvOhIvsWqFWRWr8e0aXOqF7alJb1XW2wS5CQDUbX4hMcUCkgfmrX5ghL2eP97NK/
         u7h42xhr5BUHkwH68wK9RFNhvluEjf5jdIJb7vFyec5n1J7vn/KVdjIjzNryxfjRXwIx
         X7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974967; x=1685566967;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fctEC41u76rTML4CTTx2jHE+S5zx89fZLmwJsiIL5So=;
        b=daMP15FdEYs4w4AZeLm6mvH7riqbQmnkXeVDY96KTQEpec7ciZQvJUoTTx4YFam6ol
         qdOQQ2jflKWO8/1x+jjHiQ6uWR5Mkqguq23gmf8INsUVIf05zB7vrFF9fCwmdI3afpOs
         dFmnhySWw7kkjhLJjC4e5E79nJE+XMDwnO8H/oqKhJweZRO3zsZVN0j7j09Nw6MnLtxl
         CAGDoysgzaFk3Xvy50RgzBV+/WdxVH8m5avzilynRBBuXCokxp0F829ScUAYUF+cU9x7
         wF9fTd4mYH/MyLAZlqgkGKSUeCno5lNvXah8d+WJQ/qG/lsjiZG+vL8WurbbBw/ZZ3ki
         C8Ag==
X-Gm-Message-State: AC+VfDxKZ1o5YZ27IMc7kqJMQGS2E2j9LU9WGGJv6OeMwVWy4hwsl1jb
        6kkQ/NNk0Xkr1j+ElvnX3hbuzw==
X-Google-Smtp-Source: ACHHUZ4Ou1HmHNgzOMSKxKB0s/OG17wi9Y6JHqnnmaYaJhcqoFkGF9PKAJGiOBUpRXnSdrb0GO4XXg==
X-Received: by 2002:a05:6a00:1515:b0:63d:2aac:7b88 with SMTP id q21-20020a056a00151500b0063d2aac7b88mr23713638pfu.25.1682974967051;
        Mon, 01 May 2023 14:02:47 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:1f1:1360:eb9b:387])
        by smtp.gmail.com with ESMTPSA id i12-20020a056a00224c00b0063d670ad850sm20899151pfu.92.2023.05.01.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:02:46 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 01 May 2023 14:05:21 -0700
Subject: [PATCH RFC v2 1/2] RISC-V: Detect the Ssqosid extension
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230430-riscv-cbqri-rfc-v2-v2-1-8e3725c4a473@baylibre.com>
References: <20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com>
In-Reply-To: <20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682975186; l=2210;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=HJmdwjdD3oLAOaRVmOzd9g/qKji+rF7c3nA/VaibzyY=;
 b=ABdeu5blg0kipm7ff+tcUDspwu9/Irg+HwQba+62HXEonmYZL76N4bgM+Fsa4Ab/8OoFAS9k2
 HPZVbMh27zGA7a1Hz2eau+u3sSuY3Bohb2Wx6PMWXeBvQksg/b7W95y
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kornel Dulęba <mindal@semihalf.com>

Detect the Ssqosid extension (Supervisor-mode Quality of Service ID) as
defined in the CBQRI (Capacity and Bandwidth QoS Register Interface)
specification.

Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[dfustini: rebase from v6.0 to v6.3]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpu.c        | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 9af793970855..6dd717030723 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -44,6 +44,8 @@
 #define RISCV_ISA_EXT_ZIHINTPAUSE	32
 #define RISCV_ISA_EXT_SVNAPOT		33
 #define RISCV_ISA_EXT_ZICBOZ		34
+#define RISCV_ISA_EXT_SSQOSID		35
+
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3df38052dcbd..29c4d458377a 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -186,6 +186,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 52585e088873..c824698b2031 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -229,6 +229,7 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				/* sorted alphabetically */
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("ssqosid", RISCV_ISA_EXT_SSQOSID);
 				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);

-- 
2.34.1

