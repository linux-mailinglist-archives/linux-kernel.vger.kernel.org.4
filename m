Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55656E7849
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjDSLL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjDSLLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DD413C37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a9253d4551so516025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902625; x=1684494625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hp9NpznKrrhFUn5kY4plzR5MQ6NWWu6XSocDBe3Nh8=;
        b=bSlEbec9/6HF6hffS50ZidbvyeHeOIIlvjS3fkxYt9p2ccPaMCloBmttbuqqmsN+pP
         DQKv+mly9xKqQ4DR+95+zT4hxj70m32RkOVien5/iCyTKT/aF057uciiXJCz04ujXg4j
         9UYRl+7MZAmd5jQbkwrSe4SmKcvX1AYAsUQJbwA/7i+dCzahPypNFubuZwsTbBHpKRkV
         nM3OfcozCj/et54NEGR796BoVTOz7l/50j92hxQPhew31E9fQbhqC9Tiv0CFffEHVVLL
         qGT+FuApfG1S8zPBFa1RInxm7TqmigulH7DtfZowilsJGVx+WXKTVPZlCDvlmAvfTUZP
         uFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902625; x=1684494625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hp9NpznKrrhFUn5kY4plzR5MQ6NWWu6XSocDBe3Nh8=;
        b=Sq2Ai6P+lBtchZElmGLbQYt+KQRdvyQ7HERTUJyNyILJaqGz/nbIDPRIaeI3eWkBuy
         7wed4jpAzZZIDnm3AvafH86g6Q2+dXk5FGsqd/Hn0N5DLN8wTkUS5EX5ReVi/Zu3QnPV
         3cnqjHKdFRwc4aKKTEBYm3oqDInfOkYM+xPOAT1BZrFof8CK/kF2th2or8hsBgU3hIX2
         z5gu7deyT4efI0wmbkbu3ApND5tR87duDjI0QJiuYHeJ+6AbFkFXDlr28Xqq73h1gLI/
         WWIp79FKp/s8g6QJsM/gcxdByg9G1AsRUzWPPsZzfgptkzMdQ/0J4UKqn7H8CVxuXJTv
         1sMQ==
X-Gm-Message-State: AAQBX9fy2lA5/mqFB4Y/abrbnn6HPmR6JiezdkjmjK2Wrj+O3uUwga4j
        11lFo9v+WhzCltoF7QkcCreHRA==
X-Google-Smtp-Source: AKy350ai+UBLN/89dPos+Z6tfCAIHn5xTLWvbGJuKVAtD1FBL63oRuudBwAa0ym8BXor3JGzI2co3w==
X-Received: by 2002:a17:902:ee4d:b0:1a6:9f09:866d with SMTP id 13-20020a170902ee4d00b001a69f09866dmr5126919plo.61.1681902624856;
        Wed, 19 Apr 2023 04:10:24 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:24 -0700 (PDT)
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
Subject: [RFC PATCH 10/21] RISC-V: QoS: make CONFIG_RISCV_ISA_SSQOSID select resctrl
Date:   Wed, 19 Apr 2023 04:11:00 -0700
Message-Id: <20230419111111.477118-11-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_RISCV_ISA_SSQOSID select the config options for resctrl:
ARCH_HAS_CPU_RESCTRL and RESCTRL_FS

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9d4c8c505191..683349c2e809 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -401,6 +401,9 @@ config RISCV_ISA_C
 config RISCV_ISA_SSQOSID
 	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
 	default y
+	select ARCH_HAS_CPU_RESCTRL
+	select RESCTRL_FS
+	select MISC_FILESYSTEMS
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).
-- 
2.34.1

