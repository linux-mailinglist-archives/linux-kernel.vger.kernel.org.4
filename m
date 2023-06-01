Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16771F4E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFAVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjFAVhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9B1AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:37:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-65299178ac5so448090b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655434; x=1688247434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFbc1DnTsptgPHbVgbrtLnQoZRYq2p52Sq+V7Mil0Po=;
        b=Y+IRG40LZKw0u4RWejoPo9t2VThioi9WMya6GxurCgZXecIGTCiWNYFwet6YeXaBL1
         s6e2+jx6ksC3geJ2joOYMSft3G8UQ2LyzodMjp70BrhkADj72DmV4KOC7eg1PWGkJS7W
         bhnuM4cF9tMcOEK2gfzpuj7nrcaJZqp/6IeD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655434; x=1688247434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFbc1DnTsptgPHbVgbrtLnQoZRYq2p52Sq+V7Mil0Po=;
        b=IsOzw/PaQQwrkSNSPE3hnBHZKDwrzySeEAfNk5663Fqw8a7//kRDh1qxgGLTyXHETw
         7uuzNVwNgAhICHWdLvlCCIFEKzvZ6kWjjfcAt+3farAgRCX55eleucI9k6cY9cMkpgD5
         zDKpPOxh0oDTvdZmtlS/vlm38vY3r4wZnQEZO2DL0ynSc+IXXDYXnTLmvGFROjs5K2K2
         DQ4X2gVe3jHNgmQTng0zRfGOcYzLzOdJGbkKBsfKPC/kLnHBta9j/4Xi8/hMR401vMkC
         LzIbEkdSokWEihWSLIkGhAJMUqhrvvfj2Uej1puFV2e56d96aTBlSlDnpSzchl/sqtSp
         cDpw==
X-Gm-Message-State: AC+VfDzooTBsOdEyPBYwX2IEidBR5mAOaoX1Ng6lgnys7mQhNNsUoVE9
        jgnOz/2iaC7xxIMYICoWGI/baA==
X-Google-Smtp-Source: ACHHUZ6rVQO/ue/4i8mO1Mux6x0NhxVI4bfPrl/BtKSwVXR51RsA4b7YL68gkPubx0VgpaYp2gyoBg==
X-Received: by 2002:a05:6a00:c89:b0:652:7b99:df30 with SMTP id a9-20020a056a000c8900b006527b99df30mr1613289pfv.25.1685655434352;
        Thu, 01 Jun 2023 14:37:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/7] arm64: smp: Assign and setup the debug IPI
Date:   Thu,  1 Jun 2023 14:31:48 -0700
Message-ID: <20230601143109.v9.4.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
References: <20230601213440.2488667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

All current arm64 interrupt controllers have at least 8
IPIs. Currently we are only using 7 of them on arm64. Let's use the
8th one as a debug IPI. This uses the new "debug IPI" infrastructure
which will try to allocate this IPI as an NMI/pseudo NMI if possible.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I could imagine that people object to using up the last free IPI on
interrupt controllers with only 8 IPIs. However, it shouldn't be a big
deal. If we later need an extra IPI, it shouldn't be too hard to
combine some of the existing ones. Presumably we could just get rid of
the "crash stop" IPI and have the normal "stop" IPI do the crash if
"waiting_for_crash_ipi" is non-zero

Changes in v9:
- Add a warning if we don't have enough IPIs for the NMI IPI
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
- Update commit description

Changes in v8:
- debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param

 arch/arm64/kernel/smp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index edd63894d61e..db019b49d3bd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -53,6 +53,8 @@
 
 #include <trace/events/ipi.h>
 
+#include "ipi_debug.h"
+
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
@@ -935,6 +937,8 @@ static void ipi_setup(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		enable_percpu_irq(ipi_irq_base + i, 0);
+
+	debug_ipi_setup();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -947,6 +951,8 @@ static void ipi_teardown(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
+
+	debug_ipi_teardown();
 }
 #endif
 
@@ -968,6 +974,11 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
 	}
 
+	if (n > nr_ipi)
+		set_smp_debug_ipi(ipi_base + nr_ipi);
+	else
+		WARN(1, "Not enough IPIs for NMI IPI\n");
+
 	ipi_irq_base = ipi_base;
 
 	/* Setup the boot CPU immediately */
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

