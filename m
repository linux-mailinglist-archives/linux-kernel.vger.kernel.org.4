Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36AD725CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjFGLYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjFGLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:24:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB90A1707
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:24:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-652d1d3e040so3661241b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686137067; x=1688729067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaLF8SuXqZ+eem5Z+p2tHoPzcT4Es5+ktuLMhNLEyaQ=;
        b=WCsZ22y+8czgBOQ9DxhWSAUqumehO6PNurNynJB4BmToYu6snCtWQL+exdFzufbLlX
         bvoB8jqEWvGls4utETB1quXhAdc5ateJtVPpVG4Q4BIe4sjEz3iOxrJttLa/Zed52lyX
         8/1RJJw8nfPLIXTmTbjyLBm+goVaPkeavhGj9qTnaJr3G5/hC2Usy66pUFkgIdsprF6B
         yG2k9rXQs/q4qVOPjcxFPmhS2y77EH+DgMcSW1alU7l/U05q8ySYu3r4bmnQyCGJDC2t
         yGUlrc0mC09c4EFcq8rMqJAnUmIh2YhnVaxFWt49+zt5a143SHm+N31hZyAvF8C/BM5R
         +50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137067; x=1688729067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaLF8SuXqZ+eem5Z+p2tHoPzcT4Es5+ktuLMhNLEyaQ=;
        b=Bta+ORg/sjQaCCFRPiVRbyJ8U6pfOrrbeQ7tqYkGwDTvzJU6tSbSBff/gDun4H+/cv
         aKSSMJYL1pkb9RWKnqOUO8YM1ZnvO7AmVbToAqwKkAGmy2ZqqfJ9Djv+QFLiY94Eizho
         F77c2TA91jBdsXIGpavi3knYnPytu/yftruBIx6GPyu/bV38kbq+Mry4Nuc8XFGLNEGz
         hMQAgoGjqfey01MBkz/OeT9E5jLC0iSniqsJhKTOH06VNfth6/E0MDmvezLE6C6Q/daH
         Liuln45kHKj6N8HnflclwUSg6aJHIJWUfLwvgh1getCclHo8OKoA/F3Yp9jQYpBn9T5X
         6Obg==
X-Gm-Message-State: AC+VfDzALkdmYvIKJMt8qD3Zp+d7zNA9H4EVu6Few2M4m7i9ZYXQ7i4Q
        4yXFV+6DLptF8HU8JC6kN15WsQ==
X-Google-Smtp-Source: ACHHUZ7bgZCFwzNHwgERU+x+RNj4ugM3cQipIuaTgbdgLN9TtiyCfdPlPvQ9Awpx6wOuhAxwXgYNLQ==
X-Received: by 2002:a05:6a21:3706:b0:10e:96b5:45fa with SMTP id yl6-20020a056a21370600b0010e96b545famr1341134pzb.43.1686137067317;
        Wed, 07 Jun 2023 04:24:27 -0700 (PDT)
Received: from kerodi.Dlink ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709026b0a00b001b2069072ccsm6228322plk.18.2023.06.07.04.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:24:26 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 -next 1/2] RISC-V: ACPI : Fix for usage of pointers in different address space
Date:   Wed,  7 Jun 2023 16:54:16 +0530
Message-Id: <20230607112417.782085-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607112417.782085-1-sunilvl@ventanamicro.com>
References: <20230607112417.782085-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch specific __acpi_map_table can be wrapper around either
early_memremap or early_ioremap. But early_memremap
routine works with normal pointers whereas __acpi_map_table expects
pointers in iomem address space. This causes kernel test bot to fail
while using the sparse tool. Fix the issue by using early_ioremap and
similar fix done for __acpi_unmap_table.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305201427.I7QhPjNW-lkp@intel.com/
Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index df5a45a2eb93..5ee03ebab80e 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -204,7 +204,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 	if (!size)
 		return NULL;
 
-	return early_memremap(phys, size);
+	return early_ioremap(phys, size);
 }
 
 void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
@@ -212,7 +212,7 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 	if (!map || !size)
 		return;
 
-	early_memunmap(map, size);
+	early_iounmap(map, size);
 }
 
 void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
-- 
2.34.1

