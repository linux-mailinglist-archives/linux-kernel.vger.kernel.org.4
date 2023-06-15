Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8614E73107A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbjFOHXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbjFOHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:23:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD941A2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:23:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6668208bd4eso852194b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686813787; x=1689405787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXQ+dIDtCVIjIX+MeG8QhKXJbzz55cnjcb5uSiAVAyQ=;
        b=k9WZ8msNpIYvfOvB7mgrS2d8l3ehr3luCbbs/hRi+0oksVCFFP8y4/1gvWSn6tniL0
         DYxkcw4rToALfY945jPpry0SmAn74Hnh/+o61BtlnbUiEIjRbxR3csI+j8nBtsw1TLX3
         0B5q3WjoTPQSYAry8HdWq5QiGw2+ysrteZHz2yzv7zOnwXM5RyHj8gjUbKVs6crGaLUF
         J3qle+4RmgQ5QF9dZbil7/o1YU0kyzqVULc6+AXlo+ZgU4EVOzGIihdfRhPaRWz8gztn
         Lqa+NRcjymq09KDAMmCBOhSCUzi5xDxkQ4g+6kr/d53jI2hqomDYTxfJXn2x8KeU9WER
         CnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686813787; x=1689405787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXQ+dIDtCVIjIX+MeG8QhKXJbzz55cnjcb5uSiAVAyQ=;
        b=PTRyHVlv8rWlFNbgHMBbksOpdz6aUWLcOIzBqjurEXB55JmA1JnFRv5f2vh+Mv3ahF
         Wuuq+Eo0H9gVs9yFL4ex+uRr4Vt6bcm1l2PqbLfVvS9/28g4nq10igvnt+MTcmqAL6lW
         cGD9j4qnbRK8dak0hVRrWu0KuIsnLGU2SfbQDZYo+pXnMl+JpvLOBJdaTK8htXjLCRFa
         8y6FkAWKYnJpTydMUKvy7D4uFUSQcXyNfSYSvQFdtbss5J7lH+k3auRIevxlmsX0Yja3
         bRqXxx6XsDqDW2o+RSL3VpK2eBm7zMbZ646QNE0aAv2RZuekWGa5aFmlC2j85J0YQHAS
         pv+g==
X-Gm-Message-State: AC+VfDwDuQ8u8VeHSWiv36KWoWtz3Sk9sRVy3wann9y2DOsudnQR4f71
        9oBFaKvFTAKk2fWJJXsu3q/VtKLK8PIujprzsngF+1cAlQaoqMnM9pQ2W6ESeSQiUE9DeiBSvdN
        qmm2+X3304ds7Eqqed/V4qk/GDOE7hdilP6oaNS3lStttXB0EgpBGTpAal/8wjV3XPUMKAus2lG
        ApZaRVze5row==
X-Google-Smtp-Source: ACHHUZ5w/6Zh7eSyl8NNQwcHfx2tXqXt97Hs6Lh3limWYTSd80JJE5xoWAZwMDR7QMh10WT+LIey2Q==
X-Received: by 2002:a05:6a00:1492:b0:655:89f1:2db8 with SMTP id v18-20020a056a00149200b0065589f12db8mr5741966pfu.16.1686813787279;
        Thu, 15 Jun 2023 00:23:07 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i17-20020a635411000000b0053423447a12sm5123697pgb.73.2023.06.15.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:23:06 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, jszhang@kernel.org,
        ajones@ventanamicro.com, conor.dooley@microchip.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com,
        Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel module
Date:   Thu, 15 Jun 2023 15:23:02 +0800
Message-Id: <20230615072302.25638-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the 'unsupported relocation type' error caused by
enabling the -fasynchronous-unwind-tables flag,
which generates relocation types that are not supported.

Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
---
Changed in v2:
- add commit message.

 arch/riscv/kernel/module.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7c651d55fcbd..65be0360a494 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -310,6 +310,15 @@ static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_pcrel_32_rela(struct module *me, u32 *location,
+				       Elf_Addr v)
+{
+	ptrdiff_t offset = (void *)v - (void *)location;
+
+	*location = (*location & 0xffff0000) | (offset & 0xffff);
+	return 0;
+}
+
 static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_RISCV_32]			= apply_r_riscv_32_rela,
@@ -335,6 +344,7 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_SUB16]			= apply_r_riscv_sub16_rela,
 	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
 	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
+	[R_RISCV_32_PCREL]		= apply_r_riscv_pcrel_32_rela,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.40.1

