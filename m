Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE57F6BD0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCPNUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCPNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:20:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA731C0803
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:19:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l12so1504476wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678972760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXNicKwHPUURyALO36PEegj/jGCRXjX7/YBezTaryXs=;
        b=67doldxYgYKlU/XZ0kZu3+NOAqQ/2WbnP4mwdaTGI0McuaMhRPDAE/s74Wq3t6tF/V
         J0nRxluNtH5jyXjG6gwranylrEnecoP/DUWgaO9JZ4gg6xFffDGE08IwIc2KOUXaspal
         HHuTUIg4II4i6Oa5sRMFXG0qwnNOZQwEH5YClaHtl1ekxMRL+d17IM5dSSKvN8etH4o4
         Gryhf8z+9DXYE61ol4wGcZdxrAPW2qatjZ5Q8iOQkHFCUmxFt43/+ApFfD1rBG+HZP3t
         j+M2PnF2oTfQycLOuf/WXwZevaBF66GgvGXiPTY9lyNMUBSV3fX9CsUSbPa1JK7AlIvp
         vKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXNicKwHPUURyALO36PEegj/jGCRXjX7/YBezTaryXs=;
        b=yrx8mJNUc9+fkBJ8kREkaWFHaUzshiJKiOnk4nOqUpUSvMcvSNdzax6fHqs8PAxS9Y
         64BB5FJk9Mc4A1XxWIDFR+xDO9sLjCLoqL2Ry0QI0iUS3RDywAuKD/AavVglQept6pv9
         v6XT1ZfkBwGPT2L6g4cZA0WvMJERMsGaDJcE9rA4VZIVYbTGbedq6dxBiioDW4yBfaDi
         4LQiaeQTfzttu12hT6rajxSklGwp8++Jb4hRCGaTXRIjIm3cc86FAQaMcEktmC9rFl7U
         4fHze9yyMAF9RW3drJZuEsCLMaqsw5bIFZmghPE16Jh/M/K/fMt6lWP+FhvTp0HR66Fw
         dNZA==
X-Gm-Message-State: AO0yUKXrRA7CF4GbKM7QYcOpGRs28SiGuLEx7ZM+9ueg4ULYUt20WblN
        72+Fds1KZP6FRO/2viYHLM8U7w==
X-Google-Smtp-Source: AK7set9ckwc+gnRj+k56d+SvgcefBu0ajEjl4o1f/HxCl/7FMrq5djA9ftFJ5OFMO4WJD/IRBsDEKA==
X-Received: by 2002:a5d:49cc:0:b0:2c7:57e:633e with SMTP id t12-20020a5d49cc000000b002c7057e633emr4666191wrs.49.1678972760162;
        Thu, 16 Mar 2023 06:19:20 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (238.174.185.81.rev.sfr.net. [81.185.174.238])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d5485000000b002c5a1bd5280sm7210070wrv.95.2023.03.16.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:19:20 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v8 2/4] mm: Introduce memblock_isolate_memory
Date:   Thu, 16 Mar 2023 14:17:09 +0100
Message-Id: <20230316131711.1284451-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230316131711.1284451-1-alexghiti@rivosinc.com>
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function allows to split a region in memblock.memory and will be
useful when setting up the linear mapping with STRICT_KERNEL_RWX: it
allows to isolate the kernel text/rodata and then avoid to map those
regions with a PUD/P4D/PGD.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Anup Patel <anup@brainfault.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..2f7ef97c0da7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -125,6 +125,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_isolate_memory(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 25fd0626a9e7..e8c651a37012 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -805,6 +805,26 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
 	return 0;
 }
 
+/**
+ * memblock_isolate_memory - isolate given range in memblock.memory
+ * @base: base of range to isolate
+ * @size: size of range to isolate
+ *
+ * Isolates the given range in memblock.memory so that it does not share any
+ * region with other ranges.
+ *
+ * Return:
+ * 0 on success, -errno on failure.
+ */
+
+int __init_memblock memblock_isolate_memory(phys_addr_t base, phys_addr_t size)
+{
+	int start_rgn, end_rgn;
+
+	return memblock_isolate_range(&memblock.memory, base, size,
+				      &start_rgn, &end_rgn);
+}
+
 static int __init_memblock memblock_remove_range(struct memblock_type *type,
 					  phys_addr_t base, phys_addr_t size)
 {
-- 
2.37.2

