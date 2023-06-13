Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5C72DAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbjFMH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbjFMH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:26:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7EAA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:26:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3ce6607cbso16667165ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686641210; x=1689233210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCTKwSM7nGfTgkpcwxuzbHKvrUHLJBGdS4r/wN5pXSo=;
        b=LiWdB17E+jMG963EaRHIWlzJpAIjHvEvA6bk4BXb1N4r3YKPeO+SP2mkQPkR4PCnaz
         B6lk/eSWsSCcR7gIE0oL4Ngx0J5MrheuIJ1xyaQslocVd5ouF+kzNKZexYWLSd6q9J68
         F5zIYtwYDGwrxB3ONyRFmJeIk7hWu3hzwrP3WffN7Dm4NOOeA3sNh9hjiGq2XOxmPFar
         ox0DLtxWHQDYLJFpcwamhFWtbh5XvtJQw9eiLbNyCcnrWLcQ4czn/Igkn9AmyAdnGzrR
         4zNKIN8CJi7WJykqGqKHN5z9UxsgzEboK4ErLZYhiQSQbYBrU7Gq53w84BCT0soat3tP
         iYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641210; x=1689233210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCTKwSM7nGfTgkpcwxuzbHKvrUHLJBGdS4r/wN5pXSo=;
        b=KUsaZ/aqJ3pdPrQnAnGEEBqwhkF6BuK0Ca8zRKcVzGLjiEZ36zJret9ye9jk8Neax9
         +oTPwVQHFbnmOm+UNhsdPcM5KYmq6VAmdos3/f/d+Zwi84MLTgTlq9JGMpPPHgaqnINd
         sV0H+k7S/A3QsyrVnlXUjZBQrnY7p3T35AJXMu4kKGr8w2Zk0Eo/TkomP07VImwLZh0g
         xswEFI6e6veKlHvi0htPGrMKxBd6OEwWR5H0m/Wks6NwxLhqSBaDcTIk4P4+giv9X3s+
         +6Gq+ja/SmFcuLnVpKmdSIozfJC/9C6M2/DI7d5n6CnKPamaA+XM+woFV+XSYSte0iM3
         pK5w==
X-Gm-Message-State: AC+VfDz1KPErOQKlkie3009LdEROgTzsRw4GvEeFYq4ZOpvxqixPnGv1
        IIfwm1hi+Lmvy7mHxcgT1j8N87zH3d4UFpbY8oEdjnoElF00O6T0XNLTbjwu9sCBZ+bZqdmDqE5
        4MJ+4lg1sAY1WFh9EaaKrvn2anUZkGwlSmHXUXh+uuFgY4C9kZtWESdCzQ6oPWZdLABvIXtMMf6
        Cu8v44PLNwhw==
X-Google-Smtp-Source: ACHHUZ7/bXnQVjLPpiyc3uSEjDr+FSZ/NtFlYA34O9DkwBHezk4wWVKKyVZtaCb/wBtFIl1nnjSLDQ==
X-Received: by 2002:a17:902:708a:b0:1b2:fa8:d9c9 with SMTP id z10-20020a170902708a00b001b20fa8d9c9mr8467088plk.49.1686641210024;
        Tue, 13 Jun 2023 00:26:50 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001ab0d815dbbsm9446677pll.23.2023.06.13.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:26:49 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, jszhang@kernel.org,
        conor.dooley@microchip.com, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com,
        Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH] RISC-V: Support 32_PCREL relocation type in kernel module
Date:   Tue, 13 Jun 2023 15:26:44 +0800
Message-Id: <20230613072644.10487-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/kernel/module.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7c651d55fcbd..f52d8e3d4b63 100644
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

