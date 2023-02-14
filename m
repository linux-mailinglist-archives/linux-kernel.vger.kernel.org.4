Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E7D695D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjBNIjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjBNIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:39:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19BDE07B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:39:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso10929669wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdH7YLxEU7+x8TyQ0RXRl7vlHPOb2AyhEBJfEDpogjo=;
        b=lITFePx0X9STU/PRv8RDKM8fExAWDzy+jpqFd3F3EclEeeKm9oieIjWHpPqGQzwS22
         5EqMTMMmWcQpnYnPydUELQ4hmXI6jQ9wIU7NIhNrE2bb/Ycvjz7xP0M/5mKcSOiu7bsZ
         6TsOLG9rDvJWCE+8oAtVWbXOJzkqsZf9lgb3PVpo6EsLPiF+Fznp415kzttWXcQB9tai
         ahYWr+46hGgG5r48Qc9c2y6Vu1i4oosb0vCrvNqO2RnLrESe7zITRzK+VioTUZT/YyrW
         jWIMMlqks/G7q3WK+Hgrn7sUXrq5x2nUruqzS5Z5CdiTrfPNvvbrw17CCB6Hy9c7Lhbh
         gUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdH7YLxEU7+x8TyQ0RXRl7vlHPOb2AyhEBJfEDpogjo=;
        b=Kp968RUYLBfF8Xvl+cXcYohzy68YDk2DR/1E39veQC38n+YFjXBeP6JazX57PKH10h
         BUlQbnNRTaPKo7Njy0WbobR7mjMY6Dt/K1PYOY6gAm5KhnWDCZktyJzoMBViy9nhHeXI
         zMfovaZDWvVmLFg1QKpmtwiCYBgoofDL0MaUKSqtiV1XpOYTemb/NamIVuhnNi8oq1++
         mOQgpgywoYPersesqpSdpftduG427ZO1qX3P1cs/GdjwdB+VnILzKsjDaeEsJdIggMN0
         YeXc5C/6laghL9tnjqWATMHrHV0aQujvvbOpFzIJVXMb+JON11mt64LJaU6y/y5SGaZM
         DNLA==
X-Gm-Message-State: AO0yUKURrka7tJFEdvLGQa3FTBfLEdDqA9c3muGML4F8hglwwceLUQlx
        LmvlvTc1SnX+PXUd7+psxEbAVQ==
X-Google-Smtp-Source: AK7set8Xv+PaDkPwK7Ad72LiOBjQMRKpFOmBm3jnVG+RLVPqeMcL5mOLrs6RINnQJmrORpuEV3G7VQ==
X-Received: by 2002:a05:600c:705:b0:3d9:fb89:4e3d with SMTP id i5-20020a05600c070500b003d9fb894e3dmr1952389wmn.28.1676363939287;
        Tue, 14 Feb 2023 00:38:59 -0800 (PST)
Received: from localhost.localdomain ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003dc492e4430sm16215536wmi.28.2023.02.14.00.38.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Feb 2023 00:38:58 -0800 (PST)
From:   =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To:     jpoimboe@kernel.org, linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 25/24] x86/cpu: Expose arch_cpu_idle_dead()'s prototype definition
Date:   Tue, 14 Feb 2023 09:38:57 +0100
Message-Id: <20230214083857.50163-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676358308.git.jpoimboe@kernel.org>
References: <cover.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/cpu.h> to make sure arch_cpu_idle_dead() matches its
prototype going forward.

Inspired-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Josh, feel free to include in your v3.
---
 arch/x86/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 40d156a31676..7d27181a2518 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/prctl.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-- 
2.38.1

