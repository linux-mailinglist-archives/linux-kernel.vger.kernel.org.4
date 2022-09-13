Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A495B67C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIMGTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiIMGSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:18:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B25725A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:18:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w2so513883pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=ZnfegtzKSTTKTaSRmFYNgNfVRx+qne9CNs5pAuC2Bc4=;
        b=apj393/gyjHBwHhO2FJlGGE521DaSBAng4Lmljozp7KWCUQwKLChqR/8ZJ7pixHV1d
         9LGVWbRVbfb9METJVbNOzg8YIYcj9PVB371YCzU0N2yArwYZasnPe+goP04Q2hRir4MV
         gD4rTiJvEK0JhYSusuC+sZGR3ASmq3g5mp1bZn+HZnw1fz26Sfiu4o40hB+Ft7HutH6I
         bqH1Bu0iY93yzAJjW5/8ewMJVhGJIv1Xdw67pKS+nVzSqWrfClig2K33jNspRDsXkaHr
         Xr1Yzw0TBQS5M0Jd6sQfounEVUf5rYVl/o0iGmD6D/Gabry5KkX+3+3ya6Vu1Vimiwkd
         3hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZnfegtzKSTTKTaSRmFYNgNfVRx+qne9CNs5pAuC2Bc4=;
        b=5kdm0nBXqjcu8YNYbEMBcbMCbmC5JFRZ71UPKwAOTDCY3kiJa7MqeiKLmphDoMaADh
         ivvjMPwEBjxekZ7+biP/8VtGuRxkpQi2jumi4B6SWwc3KN2KHY8AeEZMNK9Ucr+Jjc0a
         h/CV8uIaEOyCfYj4Ptc/YnNjEbuwWcH01GusXeLlDUKZ36Eanof/nzN1kHFeuz+p4g7N
         SfpOpK1Q1ByxVSD1y3qJw6f/ncPou2CLX+q3gl7kuij6ZpMxS31p4tvmLQkblYSIXCb6
         OLBY7VfJAhdW2uRBwVv6k4ck7sJjX+Nw4/tZeD8RkKnTa3senZKvFaRfAuf0CL0At+/z
         pWwQ==
X-Gm-Message-State: ACgBeo333APhAfHBsKKKIr/szEMwqwFoggaNZ8VxiVUwOGOjTYWoLFnm
        hWFY3Sx0tQ7KXECPwRcfTboHqQ==
X-Google-Smtp-Source: AA6agR69uTu3ksUgxhSvzWA664izt9+OmEr183NNyMUbA5CgJZDYqBSESKuk8rFd7wMr0WlLbXvUtQ==
X-Received: by 2002:a63:fb4a:0:b0:429:8605:6ebf with SMTP id w10-20020a63fb4a000000b0042986056ebfmr26149775pgj.225.1663049925060;
        Mon, 12 Sep 2022 23:18:45 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm7296332ple.62.2022.09.12.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 23:18:44 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 7/7] riscv: Add cache information in AUX vector
Date:   Tue, 13 Sep 2022 06:18:17 +0000
Message-Id: <20220913061817.22564-8-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913061817.22564-1-zong.li@sifive.com>
References: <20220913061817.22564-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

There are no standard CSR registers to provide cache information, the
way for RISC-V is to get this information from DT. sysconf syscall
could use them to get information of cache through AUX vector.

The result of 'getconf -a|grep -i cache' as follows:
LEVEL1_ICACHE_SIZE                 32768
LEVEL1_ICACHE_ASSOC                2
LEVEL1_ICACHE_LINESIZE             64
LEVEL1_DCACHE_SIZE                 32768
LEVEL1_DCACHE_ASSOC                4
LEVEL1_DCACHE_LINESIZE             64
LEVEL2_CACHE_SIZE                  524288
LEVEL2_CACHE_ASSOC                 8
LEVEL2_CACHE_LINESIZE              64
LEVEL3_CACHE_SIZE                  4194304
LEVEL3_CACHE_ASSOC                 16
LEVEL3_CACHE_LINESIZE              64
LEVEL4_CACHE_SIZE                  0
LEVEL4_CACHE_ASSOC                 0
LEVEL4_CACHE_LINESIZE              0

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/elf.h         | 4 ++++
 arch/riscv/include/uapi/asm/auxvec.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 14fc7342490b..e7acffdf21d2 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -99,6 +99,10 @@ do {								\
 		get_cache_size(2, CACHE_TYPE_UNIFIED));		\
 	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY,			\
 		get_cache_geometry(2, CACHE_TYPE_UNIFIED));	\
+	NEW_AUX_ENT(AT_L3_CACHESIZE,				\
+		get_cache_size(3, CACHE_TYPE_UNIFIED));		\
+	NEW_AUX_ENT(AT_L3_CACHEGEOMETRY,			\
+		get_cache_geometry(3, CACHE_TYPE_UNIFIED));	\
 } while (0)
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index 32c73ba1d531..fb187a33ce58 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -30,8 +30,10 @@
 #define AT_L1D_CACHEGEOMETRY	43
 #define AT_L2_CACHESIZE		44
 #define AT_L2_CACHEGEOMETRY	45
+#define AT_L3_CACHESIZE		46
+#define AT_L3_CACHEGEOMETRY	47
 
 /* entries in ARCH_DLINFO */
-#define AT_VECTOR_SIZE_ARCH	7
+#define AT_VECTOR_SIZE_ARCH	9
 
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
-- 
2.17.1

