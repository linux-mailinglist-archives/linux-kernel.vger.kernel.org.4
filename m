Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F55FB9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJKRuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:50:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52EB70
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:50:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a67so11857352edf.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EixwyBKn7iBL+poJU/p3WD3TAxyLefj9KcUIHMqhAqI=;
        b=ka+z7kKogude0U+qRksQQDsj/nQoVPIZBahfe3f17eJYR+HShhmyB1HMjLesqtxqdO
         h49qYEYUIBUdo/w77xu0G9BIjwE+cNOKDTf7mVtoqrb7rHkLVcgl/8krirO0eEzE19u7
         eU/77LZPoyHmmbtmCi1rmnw9vwjNhXLh4RkvMWxV7FGA553eR3Gt62rDbEkkOzqEMkjU
         itDQes/EVSPAmMRQUtXkDxzCkX9YkqtCmluO1YKUEE3EwY9r77n6glfnl2f7ysnzdGCG
         wgRYdeEV6r1EeKd5S77rxnffvgWssKOGdH3xj3GlAdWIsGqqEZQKUlDSNzf9gOHlsiEz
         oe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EixwyBKn7iBL+poJU/p3WD3TAxyLefj9KcUIHMqhAqI=;
        b=6bPkTAN0p0gPR7lSc/2J0rO/9m2gFKyUr4iBy1ogMIGlDHKu2AdCCnUP7Z/eR5tR6T
         KedGe9SJauR/iNzoqHts+GJtiMMjpJfKYNXRhCP1ACKe0VoWsCyP8JEaEIymi4fEPPa6
         0K+89gBkGijUUa427vds5X0ydO9GbEdF/yCSr5BJ5/pmRLUWudq3MicgfIhLegEwM9rt
         MYxwK4qBR1BECxKAHpBlLClONq47h3MHD2cVQTyDzcLYVe+qYPJKW/ip1JoziGEl72Ej
         v6uHwKL9gfn2zWep0kVTKmurW6TAQK5aic3SaolXSHMIquWskzUWk4yO8SD9KZKS5IbT
         Nptg==
X-Gm-Message-State: ACrzQf2Nep2+dhLy4HIxixbqrEL9ZEQtAmdqfKXCKYiNE+ZKGYBoQP6o
        2l17Pm/anrJ3peyEMzS3OHEiRQ==
X-Google-Smtp-Source: AMsMyM6e+0lvFn2+Tk9pBogs5ha/l9c+HybhYzGWNPwzC22vN0c8k01iCb2fo5xiEzEu3CYE1uquYg==
X-Received: by 2002:a05:6402:1e8e:b0:459:f7cd:7c09 with SMTP id f14-20020a0564021e8e00b00459f7cd7c09mr23509240edf.405.1665510632963;
        Tue, 11 Oct 2022 10:50:32 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id bl3-20020a170906c24300b007838e332d78sm35575ejb.128.2022.10.11.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:50:32 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] x86: Fix /proc/cpuinfo cpumask warning
Date:   Tue, 11 Oct 2022 19:50:31 +0200
Message-Id: <20221011175031.1782748-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upcoming cpumask changes will start issuing warnings[*] when cpu
indices equal to nr_cpu_ids are passed to cpumask_next* functions.
Ensure we don't generate a warning when reading /proc/cpuinfo by
validating the cpu index before calling cpumask_next().

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/cpu/proc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..584ae6cb5b87 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -153,9 +153,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	*pos = cpumask_next(*pos - 1, cpu_online_mask);
-	if ((*pos) < nr_cpu_ids)
-		return &cpu_data(*pos);
+	if (*pos < nr_cpu_ids) {
+		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+		if (*pos < nr_cpu_ids)
+			return &cpu_data(*pos);
+	}
+
 	return NULL;
 }
 
-- 
2.37.3

