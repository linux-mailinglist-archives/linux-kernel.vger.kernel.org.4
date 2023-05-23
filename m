Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD370DF81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjEWOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjEWOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:40:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB2E9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:40:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d41763796so2950962b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684852827; x=1687444827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEbJUA2VY3P1Gw/9E3ZC2zbULYIeWfglzaOBedvnWVU=;
        b=NFeLY3SkA8AC3qhDYso7wMcli0cn4QwrTfP1yc8JJHOY+KU7eeYHu6Y5qgeh9CLKOH
         RIjeh7iU5NLc9qaleOGDBNFgmHHWAFHhCEfTd50q93OvDiKqgC4CafhCUG+QkavJWOF6
         dMJFbEQ0nrQJvt+lBesUHD0pW6muhDoZzvjx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684852827; x=1687444827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEbJUA2VY3P1Gw/9E3ZC2zbULYIeWfglzaOBedvnWVU=;
        b=DGFGs6RF8lG2+w5G/WN0w+CcI6AzPW2KWNwY+OzzWVBqMIVNG8kcoO4tj91hDDOhVN
         3BSyGh+a/AfxN6hH2e59HVohmUB1lYzvrzRRpkNfPPRxHOpTDIcP+hNKZfQwhQuYk5Dy
         WtuQNLNwBDoR+aP3N44sMKhsWDr1g4kDE9kz0G9NkA0NQ9yNG9L/ttZkdv3oCfiUbm/x
         Uq9JKYIe0DXkxBtaVMgzyeGGtU2HWJ+kJgsyiYW+uru6QMWbAnRB/svYrO/JqgDO9QyI
         nVa5FQlwd9l6u3BjUeXvgMh36Q54PvH6hQibzMEUFvoLWO/sziyiacgfYhx15LRv4+Nh
         Vkzg==
X-Gm-Message-State: AC+VfDybefhFinw4kH+Utc0nNbE953c2TJdcP3xjgR6G3UWRocjiK731
        wUfLzktJQZRregfSgSv0l4gW5g==
X-Google-Smtp-Source: ACHHUZ4teF8qs4STLyE0zOA8dYn9fz0SS7kmHOjPAUtFeNbBav3U28Ed6thHQ2NIkTRalg4X4AnOFA==
X-Received: by 2002:a05:6a00:140b:b0:63d:3339:e967 with SMTP id l11-20020a056a00140b00b0063d3339e967mr18303483pfu.19.1684852826764;
        Tue, 23 May 2023 07:40:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:ed64:17be:457a:f5e4])
        by smtp.gmail.com with ESMTPSA id a14-20020a62e20e000000b00643889e30c2sm3701402pfi.180.2023.05.23.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:40:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Only HAVE_HARDLOCKUP_DETECTOR_PERF if the PMU config is enabled
Date:   Tue, 23 May 2023 07:39:53 -0700
Message-ID: <20230523073952.1.I60217a63acc35621e13f10be16c0cd7c363caf8c@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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

If you try to enable the arm64 perf-based hardlockup detector but you
don't enable CONFIG_ARM_PMU then you'll get an error:

arch/arm64/kernel/watchdog_hld.c: In function 'arch_perf_nmi_is_available':
arch/arm64/kernel/watchdog_hld.c:35:16: error: implicit declaration of function 'arm_pmu_irq_is_nmi' [-Werror=implicit-function-declaration]
   35 |         return arm_pmu_irq_is_nmi();

It doesn't make sense to enable HAVE_HARDLOCKUP_DETECTOR_PERF if the
PMU isn't enabled. Let's add a dependency. HW_PERF_EVENTS is a synonum
for ARM_PMU and makes the most logical sense here, so add the
dependency on that.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/r/20230522114922.1052421-1-arnd@kernel.org
Fixes: 02ea35ee19d9 ("arm64: enable perf events based hard lockup detector")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This is an alternative fix to the one Arnd proposed. I think it's a
little cleaner / more correct.

I'm not sure the exact way to mark "Fixes" for things in Andrew's tree
these days. I don't think the git hash is stable? I wouldn't object to
this being squashed into the patch it's fixing.

 arch/arm64/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3eacf40da850..0b055e6cda00 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -203,7 +203,8 @@ config ARM64
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
-	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
+		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
-- 
2.40.1.698.g37aff9b760-goog

