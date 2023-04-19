Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046896E8561
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjDSW5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjDSW5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:08 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A701F113
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52160f75920so239009a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945026; x=1684537026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4TtHmnmxTTT3fwHdqQt/qizkftz4ebAquvrklnKCnk=;
        b=Mhapfz67dud/UPYR/b2X8gVw2yIFMGkiX9WzO2I8lOvtUkKjVGclmVzUHesl1qROMi
         uxsGqYpJWpSjdakU/B06nIplczCqDKXZ92yevVbeoNxLSa13ncLI+TFY595u8TEVWFZv
         allcMlzSiJtUFfs1zHgHW75GQu9ntw/w2Os7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945026; x=1684537026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4TtHmnmxTTT3fwHdqQt/qizkftz4ebAquvrklnKCnk=;
        b=QfbhA7Fwadjv+80uJXQNjRBmcRkiOIL0EnBPd3ViJtpTaKjSzr4lpPXeEX0GSsG8bC
         0wrij7yS2jbl8uIh5KLDXEmo+jvoJF4xES2tU+tElUeCuOJ5MtRO3k9PrQ0mbShWfWel
         d4KxS2Q0V6q944+lef4yMuNiHR9jjz0NkiUXZeES/caiZdMnsVyVKe5alNgh7zwSn3fy
         0sCuieOLXZ3cM9juLjb0G3cTSiRsu1ynS6zZEex5KRGd4VSUaAhd7wq+FAGVeN/rbOol
         uxrrLv9iB1Q4Y8kG69h5aRnGxdD7v+8sp5QKsqSUsk9bmm882KsCVNPFNnBo7qr5Eh7Z
         q2JQ==
X-Gm-Message-State: AAQBX9enbaNRfvf0d02It9VP5A7wPjM6wR2UMCzcRjii5CI6nDni9Izj
        ZK7Q7sc4vXewRlE7zrJ6OW7x8g==
X-Google-Smtp-Source: AKy350b31hKFXuPuDEwurP1haUg/kmKABno9CTcx0NTyRaIS7gBQqk+Fl95MtSp5XkH6F/eDr8jp1Q==
X-Received: by 2002:a17:90a:72c8:b0:246:9bad:2354 with SMTP id l8-20020a17090a72c800b002469bad2354mr4196693pjk.43.1681945025926;
        Wed, 19 Apr 2023 15:57:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/10] arm64: smp: Assign and setup an IPI as NMI
Date:   Wed, 19 Apr 2023 15:55:57 -0700
Message-ID: <20230419155341.v8.3.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Assign an unused IPI which can be turned as NMI using ipi_nmi framework.
Also, invoke corresponding dynamic IPI setup/teardown APIs.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v8:
- dynamic_ipi_setup() and dynamic_ipi_teardown() no longer take cpu param

 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4e8327264255..94ff063527c6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -43,6 +43,7 @@
 #include <asm/daifflags.h>
 #include <asm/kvm_mmu.h>
 #include <asm/mmu_context.h>
+#include <asm/nmi.h>
 #include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/smp_plat.h>
@@ -938,6 +939,8 @@ static void ipi_setup(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		enable_percpu_irq(ipi_irq_base + i, 0);
+
+	dynamic_ipi_setup();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -950,6 +953,8 @@ static void ipi_teardown(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
+
+	dynamic_ipi_teardown();
 }
 #endif
 
@@ -971,6 +976,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
 	}
 
+	if (n > nr_ipi)
+		set_smp_dynamic_ipi(ipi_base + nr_ipi);
+
 	ipi_irq_base = ipi_base;
 
 	/* Setup the boot CPU immediately */
-- 
2.40.0.634.g4ca3ef3211-goog

