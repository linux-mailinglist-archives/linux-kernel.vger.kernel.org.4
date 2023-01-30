Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC96818D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbjA3SYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbjA3SXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:23:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F44589C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 88so11871066pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Civb8WSgZLaGjy3GsEK+VfCJoO5XDczMEZxaUDDoy9s=;
        b=PSgeKdehYrE+PafjRwikFSIdgqSVP/6Dwf+FS0bio9ay+kO8Iq/DP55UzLxJ/0teml
         mvq507l+RrqXXtGjCegq0g7TLBJjmbSWhdM5dgwY0v649xk++pdojRYRpi6srgODCEX8
         Uo9mPJiNfw2KG4leBHKApLZ0vCIAGbEaAh8W/xor1x+Q+a1Lfuh10l47pj75siTlDsbn
         eb7CTrsgaQM3o3V7ixmkkhz+3jXqGMGxOBTq3bjtqGeqQ2LRHByk7Bu5QeGzR6FsK4b9
         YFzRilzo9k2a2ZEB3Su60FmyHlwt8/pzExTf+irfPULv2+5xGuGMe/aasN/pJ2aP1S95
         itrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Civb8WSgZLaGjy3GsEK+VfCJoO5XDczMEZxaUDDoy9s=;
        b=th2GL9d+qi9agNuaDTks8eYQdenMU55Np6DHhlYHJFHznROrNBUh1uY9o+I4VyxCSu
         G22zhMALVkLBR4J5FxObA4OJa+F46eic1ocsWyqa3PgKPhrrZuu+pstDMmU6pEz/Z+EX
         NM65ApF+YeokPmGTvjRGfeNt2bI40GMMiJUyM5M219byZcOGgclD54rxYjw3VDWOl5lk
         toRuE4hC1c2hKs7weG544qZP1iW18cjyoXdcKgDRLFglcdClhn1RmZa2/jcrZcKYhHrO
         R4Ip5OYOrlR5m6QUaDls3h/n60UtiI/QdgveRweTYsx1Edo7pyD84Cnw8nSKi4YEMUpc
         +GKA==
X-Gm-Message-State: AO0yUKVNRFBuiJ0jYYWxIJ/u0uDcGc9kgIUBM1xBFJlVbbHFeejrreQt
        U8aoyybFViZj/+hWM43LV37R3Q==
X-Google-Smtp-Source: AK7set9oTDzJ0fET5I+XJ+M/whs8igubsgt819w38WChwLx4JRHaYMGFAZJAVm6ZNdmVCQgnm72BVg==
X-Received: by 2002:a17:90b:3e81:b0:22c:b70d:45fb with SMTP id rj1-20020a17090b3e8100b0022cb70d45fbmr3191564pjb.23.1675102995734;
        Mon, 30 Jan 2023 10:23:15 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:15 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 09/24] ACPI: OSL: Make should_use_kmap() 0 for RISC-V.
Date:   Mon, 30 Jan 2023 23:52:10 +0530
Message-Id: <20230130182225.2471414-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, if the tables are larger than 4K,
acpi_map() will fail.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..f725813d0cce 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -276,7 +276,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 	return NULL;
 }
 
-#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
+#if defined(CONFIG_IA64) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 /* ioremap will take care of cache attributes */
 #define should_use_kmap(pfn)   0
 #else
-- 
2.38.0

