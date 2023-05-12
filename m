Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E12700333
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbjELJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbjELJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:02:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B70D879
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:02:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f42c865534so40718045e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683882123; x=1686474123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnd8gr51X8/5uF+3rCtJjAEchITyuqH0kTrDbBmZ9i8=;
        b=BP88QC1bhM6e6lKhDv4DvB5IhPrAhRpa7/EMuvDfBK9ilVoXmFBPXJUv7eBZFXmzeA
         pnY3MuFsQG/Vi8of/R7SxCeVy84BBl6Kp1magUzy5obpB8MTplmqFtJ+UgoUCcKHR6m9
         UwYczpC1Cx+cXBzZGpkRFIRi/arSoVntIWcSkPr8Uz7fI8PTIaU1AmU3/fMWlJvtE84G
         vEGkUYx4uqolizKdU/vvmYS0xRNcR9bjpIc8poxfmhpbguk7A2Gc9CwCubqWiDgmeF5g
         3turrONwbQmgL4fwYhBq0v/Kxt48W0IjtCm8J04PJG0yCm4qXFEa4nSI1/4IOKe8BxDM
         dsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683882123; x=1686474123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnd8gr51X8/5uF+3rCtJjAEchITyuqH0kTrDbBmZ9i8=;
        b=i5W7ENkbDwYdB6F0ZM1tJxEBgbqNhS4SiviqKst39lFEL/ysb5x2JYiL+OqBAUIcuL
         K849BjmUfNlKHwixa1Cu5Lo8eAIQsWoNGXEOF8usJerVNqvq0VMPo9faK/7sb/grR06I
         GFl+m/KbKFwRDGuY8ZGc4qSm33Rbw+u057yPepQPm4L4Wq+nI6Nks5t1KdcFh7YTUa6W
         9q2zESEQPByGvmaYfFFWf2jf1GiZrMoEAr9DdGJ2ajkGCykgjGy51J8r1xGLfdZNari4
         Okyf2iIzltKVoY1O8UQPzibFUksevoOFDpsQx5PlRNMTWR9szU4FFE96gupY08443mHe
         65PA==
X-Gm-Message-State: AC+VfDyTt4+7q2AjyQUPW7CqQA8pw1IiAAQHHnp+mnbzQEwWyheiN2jQ
        iJlvxGtJMfdWT1jW6UhrWkMrhA==
X-Google-Smtp-Source: ACHHUZ6wQtyhfMD1SVoC7OKEuRXw0kePRb8pgqENummmVDOdZUd/NuSrYUFy+ElWGRaklL1BYOPKaw==
X-Received: by 2002:a05:600c:228e:b0:3f4:2174:b28a with SMTP id 14-20020a05600c228e00b003f42174b28amr15724552wmf.15.1683882122838;
        Fri, 12 May 2023 02:02:02 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bcd1a000000b003f423f5b659sm15364363wmj.10.2023.05.12.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:02:02 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 08/10] Documentation: admin-guide: Add riscv sysctl_perf_user_access
Date:   Fri, 12 May 2023 10:53:19 +0200
Message-Id: <20230512085321.13259-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
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

riscv now uses this sysctl so document its usage for this architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 4b7bfea28cd7..93cd518ca94b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -941,16 +941,32 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
 The default value is 8.
 
 
-perf_user_access (arm64 only)
-=================================
+perf_user_access (arm64 and riscv only)
+=======================================
+
+Controls user space access for reading perf event counters.
 
-Controls user space access for reading perf event counters. When set to 1,
-user space can read performance monitor counter registers directly.
+arm64
+=====
 
 The default value is 0 (access disabled).
+When set to 1, user space can read performance monitor counter registers
+directly.
 
 See Documentation/arm64/perf.rst for more information.
 
+riscv
+=====
+
+When set to 0, user access is disabled.
+
+When set to 1, user space can read performance monitor counter registers
+directly only through perf, any direct access without perf intervention will
+trigger an illegal instruction.
+
+The default value is 2, which enables legacy mode (user space has direct
+access to cycle, time and insret CSRs only). Note that this legacy value
+is deprecated and will be removed once all userspace applications are fixed.
 
 pid_max
 =======
-- 
2.37.2

