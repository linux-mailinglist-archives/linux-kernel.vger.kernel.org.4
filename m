Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650AE743741
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjF3Icy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjF3Icn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:32:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA61FC1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:32:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa93d61d48so17952505e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688113960; x=1690705960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=kl/TPhm6ikHmXXieyToZuU/DsVCjRsYDu5avotvuqaFc6tZ03SeeW4FBKpCi/Mw0WK
         wYwR3smgKyTmD/+jwch8XyufhBtdkF3f7qT76g3QLFIxycHhxqlDuelvEeFLcQBDGwtt
         c99+4W37R5ubiuAV02MC9TfgLz/gSE7K7R4yhEbEZr5+7p6QH5R3OjwwnSQN3sEOn7tW
         RKj4BSD6VxbchcdMJw22xXR3zLMu8PcBAKcXWWpZR1RwCBliqolg8sKRbGtF44CNGBjW
         9CyHSusDkCPt0CnofvgfwI9NFxWhPuDzw6CUyYduupu1PMRz4yXtfiSFdQwWM5irvYAE
         GdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113960; x=1690705960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=FW+b1947Wb1HNWT7zREPjSNnmp0tSY/CUCzltgLwSkldvH+3LmgDZ3+CY+ueXbpyl3
         XY7JMmIelhZM+Ub3OKD/Zw41i2KQRyZt/3mrp3PBoiGBGfFNXRlyHdw8TUmqEZ+RbEka
         ULHiRoMafd+7/IOX4PqUi07539lK0S0e8V5zyWo6JNg3bVVPhrIsFBvC0rjgEMNVBcxD
         YqvAWdUJ6CdkUY1EMC+c8Y5QQ+r6sl61V18M0DUBSM/0DN0U11+pI4q4W7TLN8qnGYhd
         3PbLRzxAbzJlDxrorr8GD/C9566CNokG+ID9x0Nldpr0zEYU42SXyvMiV4wi/lHjNYMM
         eMhw==
X-Gm-Message-State: AC+VfDxNVjV/WRB//elcj19sCMxL2JzLBE2I399JhgI6Se7tGAt6Fqhl
        gbeWaUZXNnaVcROfCb7Uy5tC5Un1KaD/zaslaiI=
X-Google-Smtp-Source: ACHHUZ4sOZab/Xe9VR+3s2W1uRvunuBxqP1Egjt8iE/RBBaYrC98a4RA8h5p4k6wwDyYphRxgmB5tw==
X-Received: by 2002:a1c:7c05:0:b0:3f6:2ae:230e with SMTP id x5-20020a1c7c05000000b003f602ae230emr1443811wmc.3.1688113960321;
        Fri, 30 Jun 2023 01:32:40 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fa95890484sm13846402wml.20.2023.06.30.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:32:40 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 01/10] perf: Fix wrong comment about default event_idx
Date:   Fri, 30 Jun 2023 10:30:04 +0200
Message-Id: <20230630083013.102334-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630083013.102334-1-alexghiti@rivosinc.com>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
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

Since commit c719f56092ad ("perf: Fix and clean up initialization of
pmu::event_idx"), event_idx default implementation has returned 0, not
idx + 1, so fix the comment that can be misleading.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..56fe43b20966 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -442,7 +442,8 @@ struct pmu {
 
 	/*
 	 * Will return the value for perf_event_mmap_page::index for this event,
-	 * if no implementation is provided it will default to: event->hw.idx + 1.
+	 * if no implementation is provided it will default to 0 (see
+	 * perf_event_idx_default).
 	 */
 	int (*event_idx)		(struct perf_event *event); /*optional */
 
-- 
2.39.2

