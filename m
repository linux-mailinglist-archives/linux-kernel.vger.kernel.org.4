Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668236E7830
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjDSLKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjDSLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:10:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D637E13C23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24782fdb652so1397575a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902609; x=1684494609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOmhE21FgoLvBz4/9K8B1nYj/1N6YhDVDpnvXhhmMHI=;
        b=MCc3RKujUUOi8hHvnbPZFeUjt8Qd74fXOJWfbDL8OnevMgMRtLCwWwwiC8fo+YtseC
         Z5CdLbzGTCTc4FrEZwKeoFosFYCULmjriRg7z6nNiNBZZHcqQYlcVxtc/8J/iXL6FnGM
         Ak1bog8/XCv67o576rPkqx6VVqQB2wiWJUaX4SuFrHLX9Y0r9Nriqgke9p5gwyKw4+mb
         6ggfeHji4wYa2rfl88PSkZkxOMDnEFJ8zEx21rVh0Pi1oTVIcQlQYajwFvO958MKvKTP
         oex460ebviHF9yAeC9yopjk8xV4Lw4HLQclBLRYFseX4PFAQ3a+cloav1If/fEXDS+8S
         AqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902609; x=1684494609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOmhE21FgoLvBz4/9K8B1nYj/1N6YhDVDpnvXhhmMHI=;
        b=fSKoGvq95gs0eu5Wno4FprZo8y5QE6HFOOcRmpqvpBYYiPbLWwEOmNcx0uj6U6oh5k
         QsDRBk1phhnP3ofvijryGEWl5rK3g63D5yzjl/ItgpuzEVk5P66I2wVyvOcf0OjFP7BP
         BW0ik2M6IRzHmpe02kBMcKCZgUiyqqWrn9URoi3YPDQVI5Tc8rVOnCMxq7xVlhZI4Fr+
         93upC86N4wTRMqU3daxqMYu5sKABYr1UW9oWTSNsDLV0+r850ExPGwWrzPSEWxAUvJIs
         rjxEFNDDbdjq7c8Ci4bwV5zDg/HIEoCdFO7G1Szz/EhKRvCX9Pe4NORfRRkVmh3+XGvy
         AqcQ==
X-Gm-Message-State: AAQBX9cDGEJs1hQMSWnlqsuTXhMjbDno2n8EARoy4feHlD66Q+CID2ld
        /b3mch+7AyJCZ0iuBmV75E7mOA==
X-Google-Smtp-Source: AKy350aog1v27ScFai211i+05TpdB/RC9uovpGnFFaweBZPoBKDGxR8qKvX3uA8bKz6iyCPjFywS4Q==
X-Received: by 2002:a17:90b:3901:b0:247:193b:ce84 with SMTP id ob1-20020a17090b390100b00247193bce84mr2501295pjb.15.1681902609085;
        Wed, 19 Apr 2023 04:10:09 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:08 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 01/21] RISC-V: Detect the Ssqosid extension
Date:   Wed, 19 Apr 2023 04:10:51 -0700
Message-Id: <20230419111111.477118-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ssqosid is the Supervisor QoS ID extension defined in the RISC-V CBQRI
(Capacity and Bandwidth QoS Register Interface) specification.

Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[dfustini: rebase from v6.0 to v6.3]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Note:
- A version of this patch rebased on riscv/for-next was already
  submitted as an RFC to linux-riscv [1] with Message-ID:
    20230410043646.3138446-1-dfustini@baylibre.com
- This patch is included in this RFC series so as to provide a cohesive
  demonstration in one series.

[1] https://lore.kernel.org/lkml/20230410043646.3138446-1-dfustini@baylibre.com/

 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpu.c        | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e3021b2590de..255c5c4d0a24 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -42,6 +42,8 @@
 #define RISCV_ISA_EXT_ZBB		30
 #define RISCV_ISA_EXT_ZICBOM		31
 #define RISCV_ISA_EXT_ZIHINTPAUSE	32
+#define RISCV_ISA_EXT_SSQOSID		35
+
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 8400f0cc9704..d1441872f173 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -189,6 +189,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 59d58ee0f68d..80317d2d3975 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -222,6 +222,7 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				/* sorted alphabetically */
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("ssqosid", RISCV_ISA_EXT_SSQOSID);
 				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
-- 
2.34.1

