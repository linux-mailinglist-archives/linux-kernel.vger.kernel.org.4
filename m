Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB46252BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiKKEne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiKKEnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:43:16 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C536BDDA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:42:56 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1322d768ba7so4385501fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSr+LP3yV4OOZhD9NcYiTnkoNf9zOkOMx7sbT8NwJMQ=;
        b=EszwmvSgBsLo5au5Ol02Ed/IoaPq7iPdKrytiZj6Ucn91sWHFOpGKMYlMzshaC+j6q
         Z9WICNiRQGeucG6yMpxx3M3g4rv2BAkABuTIy/v+XePpDw9+4TCbk5RUQ6QipZ2DbzGK
         /zDyLPTVmlB8N0czRKK67hO0Z5O3iYLbOm7/eAldssQQhnFtSLcI/N3lnItLTvWeeY1I
         dnZJq/hr6IppN3IQGySZ0LKh9DREEX52BfvxeKwWgwsr4FaAIQlhfeOFmKQjZJE2jXuc
         6RkcJ5yVHUfdb6RKlTTB2y0S4NPJzkkOCiNKPDon7R0Ky6uZUE7tBVuBd5omdYndpxCN
         g/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSr+LP3yV4OOZhD9NcYiTnkoNf9zOkOMx7sbT8NwJMQ=;
        b=vmvuifwbmJdXXjiaBNxDvJTKWTV+0Y/aQdefWvtwPjoV5NHSrazRDPCpvCB9ZI4BD5
         /Yri3Z+IueiX3N2G/guN3x9MVXN/xNDPCbu9ORvv4yFGUVKfnEJuLwfQ6l3sTGvPfzbQ
         yihe3kL0MPxshkV/Farq6WPXl4CzOhLNsIuXcfSf7s3BArepmGk+Vj/5QW2qg08D2eIz
         /Bhx67y8wGdFaoed3/sfjYmpczW98scEwowMn1O/jXGh2ygjSGMWWHn0TW5MKqPPjxp3
         tajD9EgOmf0shrZRFuuEPTBFkpl55gXqbDzDleM28ALCYhPZjm9x3e1epuAuseBgvk6X
         5isQ==
X-Gm-Message-State: ACrzQf18zI+RYM+jEXcMoyyIj0lg682srfXsbKqhw+G6TXpbkj31LTVK
        Ksoe7IOkFtZiHBZvEye9/6+sSw==
X-Google-Smtp-Source: AMsMyM7E/xFTeC7gRif0vGIlVkquafuqvQbuudYs11qdAfCksU0FyfFcA4mFdJB7FuPEyGVzV2Z1vA==
X-Received: by 2002:a05:6870:be03:b0:13b:5fff:1d84 with SMTP id ny3-20020a056870be0300b0013b5fff1d84mr2906288oab.190.1668141774762;
        Thu, 10 Nov 2022 20:42:54 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870350e00b0013d9bd4ad2esm787353oah.12.2022.11.10.20.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:42:54 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/9] RISC-V: Detect AIA CSRs from ISA string
Date:   Fri, 11 Nov 2022 10:12:00 +0530
Message-Id: <20221111044207.1478350-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111044207.1478350-1-apatel@ventanamicro.com>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two extension names for AIA ISA support: Smaia (M-mode AIA CSRs)
and Ssaia (S-mode AIA CSRs).

We extend the ISA string parsing to detect Smaia and Ssaia extensions.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/hwcap.h | 8 ++++++++
 arch/riscv/kernel/cpu.c        | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b22525290073..06314220284f 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -59,9 +59,17 @@ enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_ZIHINTPAUSE,
 	RISCV_ISA_EXT_SSTC,
 	RISCV_ISA_EXT_SVINVAL,
+	RISCV_ISA_EXT_SSAIA,
+	RISCV_ISA_EXT_SMAIA,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
+#ifdef CONFIG_RISCV_M_MODE
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#else
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#endif
+
 /*
  * This enum represents the logical ID for each RISC-V ISA extension static
  * keys. We can use static key to optimize code path if some ISA extensions
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 852ecccd8920..3c84680c2289 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -138,6 +138,8 @@ device_initcall(riscv_cpuinfo_init);
  *    extensions by an underscore.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 694267d1fe81..e6d750d088ab 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -205,6 +205,8 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
 				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
+				SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SMAIA);
+				SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SSAIA);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.34.1

