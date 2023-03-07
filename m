Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31206AE0BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCGNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCGNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:37:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770A14EF8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:37:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r18so12162598wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5lJEnGWoR5daba7syY/YlJQMJlulw+k3BHuc1yDN1U=;
        b=HNwN9xLjHkYN2k4XJ8+FCxhbozlsuAWJRVES03TTNWLuJDi7/D9zR0blvPsClZ4aJF
         dZVBH9kFIfyJNf3aBDJqkT/ANpEmjPCvvMpjtEVRpbSzXmJKheHZkXa/xF2aCcoUksQG
         /OHuCQKOOxEDZu67yNYMjHLCbqBQ7uQNupFZKwbvHiTGsnjdtceKUahaCVtpqEa0P5BL
         yZ7RFojSHhXPz0U3y2KlOY3Vnagf+/0/imHZ/YHPIsbGd+BtzVH9Jnb3EyKFJoEkIHb6
         XMLn49DMTSr7koKc390uGmGAn0KPKhDsaY/9OjWfea4UP28n3QM7vmfL86Rfl69LBlQM
         2f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5lJEnGWoR5daba7syY/YlJQMJlulw+k3BHuc1yDN1U=;
        b=N2SMO65mOwdZzYIMHR/z830PHUrR9bIWCtAeafyJHL4bQ5So0I1E6tpbAoMOy0M9SW
         IQtoq5ms9Eg6QqrOjTpSH/T0t7VFFlk2KUaAUJTxFEfbBz3nQq7av3cND1vEfF1bckuw
         HBx3dNPGrnTuBdj4LaYkioC6kWd6PsWYj0zy4e3SmY9bX0vegoCoVDMhXpl4kaJb6l75
         ORtAwIBkVU/jSl3ogclf5620cemiaxTeyZHINA8GfAJ1ji0CoKHHT5xrWaCST3dAPpUC
         CnO5z+zNfXAYE8dKQ7J4nSQOn2w0uYv1nlgtTkov1oHUrdzcOrGvfrh0ghwfSMNFWA4c
         ITAg==
X-Gm-Message-State: AO0yUKXDbZWlrYKydulbWgVgmSB7T8THewFe5S1b4j/sNo9J8XeLXQ/u
        YPA9M/z1AI92OR2Q0WcLSYIYGg==
X-Google-Smtp-Source: AK7set8ZMrApDRZd5133PVg919iApzpcGKhJiym0d1GCCx1FzE5z2niOOu588zS7WXr0/sPqW8nwbw==
X-Received: by 2002:adf:e745:0:b0:2c5:a38f:ca3a with SMTP id c5-20020adfe745000000b002c5a38fca3amr13239879wrn.10.1678196274952;
        Tue, 07 Mar 2023 05:37:54 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:37:54 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v1 01/11] thermal/core: Relocate the traces definition in thermal directory
Date:   Tue,  7 Mar 2023 14:37:25 +0100
Message-Id: <20230307133735.90772-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The traces are exported but only local to the thermal core code. On
the other side, the traces take the thermal zone device structure as
argument, thus they have to rely on the exported thermal.h header
file. As we want to move the structure to the private thermal core
header, first we have to relocate those traces to the same place as
many drivers do.

Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Makefile                                    | 3 ++-
 drivers/thermal/cpufreq_cooling.c                           | 2 +-
 drivers/thermal/devfreq_cooling.c                           | 2 +-
 drivers/thermal/gov_fair_share.c                            | 2 +-
 drivers/thermal/gov_power_allocator.c                       | 2 +-
 drivers/thermal/gov_step_wise.c                             | 2 +-
 drivers/thermal/thermal_core.c                              | 2 +-
 drivers/thermal/thermal_helpers.c                           | 3 +--
 .../events/thermal.h => drivers/thermal/thermal_trace.h     | 6 ++++++
 .../thermal/thermal_trace_ipa.h                             | 6 ++++++
 10 files changed, 21 insertions(+), 9 deletions(-)
 rename include/trace/events/thermal.h => drivers/thermal/thermal_trace.h (97%)
 rename include/trace/events/thermal_power_allocator.h => drivers/thermal/thermal_trace_ipa.h (96%)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index eed300e83d48..058664bc3ec0 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for sensor chip drivers.
 #
-
+CFLAGS_thermal_core.o		:= -I$(src)
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o
 thermal_sys-y			+= thermal_trip.o thermal_helpers.o
@@ -16,6 +16,7 @@ thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
 thermal_sys-$(CONFIG_THERMAL_ACPI)		+= thermal_acpi.o
 
 # governors
+CFLAGS_gov_power_allocator.o			:= -I$(src)
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= gov_fair_share.o
 thermal_sys-$(CONFIG_THERMAL_GOV_BANG_BANG)	+= gov_bang_bang.o
 thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)	+= gov_step_wise.o
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9f8b438fcf8f..65ef08b30334 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -23,7 +23,7 @@
 #include <linux/thermal.h>
 #include <linux/units.h>
 
-#include <trace/events/thermal.h>
+#include "thermal_trace.h"
 
 /*
  * Cooling state <-> CPUFreq frequency
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 24b474925cd6..262e62ab6cf2 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -20,7 +20,7 @@
 #include <linux/thermal.h>
 #include <linux/units.h>
 
-#include <trace/events/thermal.h>
+#include "thermal_trace.h"
 
 #define SCALE_ERROR_MITIGATION	100
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index aad7d5fe3a14..1ce5692151f5 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/thermal.h>
-#include <trace/events/thermal.h>
+#include "thermal_trace.h" 
 
 #include "thermal_core.h"
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0eaf1527d3e3..3df2d440d73d 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -12,7 +12,7 @@
 #include <linux/thermal.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/thermal_power_allocator.h>
+#include "thermal_trace_ipa.h" 
 
 #include "thermal_core.h"
 
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 31235e169c5a..f69c83e2992d 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -12,7 +12,7 @@
 
 #include <linux/thermal.h>
 #include <linux/minmax.h>
-#include <trace/events/thermal.h>
+#include "thermal_trace.h" 
 
 #include "thermal_core.h"
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 46dedfe061df..cec72c6673a5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -22,7 +22,7 @@
 #include <linux/suspend.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/thermal.h>
+#include "thermal_trace.h"
 
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 9558339f5633..c41b1a5700a5 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -19,9 +19,8 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 
-#include <trace/events/thermal.h>
-
 #include "thermal_core.h"
+#include "thermal_trace.h"
 
 int get_tz_trend(struct thermal_zone_device *tz, int trip)
 {
diff --git a/include/trace/events/thermal.h b/drivers/thermal/thermal_trace.h
similarity index 97%
rename from include/trace/events/thermal.h
rename to drivers/thermal/thermal_trace.h
index e58bf3072f32..459c8ce6cf3b 100644
--- a/include/trace/events/thermal.h
+++ b/drivers/thermal/thermal_trace.h
@@ -195,5 +195,11 @@ TRACE_EVENT(thermal_power_devfreq_limit,
 #endif /* CONFIG_DEVFREQ_THERMAL */
 #endif /* _TRACE_THERMAL_H */
 
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE thermal_trace
+
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/thermal_power_allocator.h b/drivers/thermal/thermal_trace_ipa.h
similarity index 96%
rename from include/trace/events/thermal_power_allocator.h
rename to drivers/thermal/thermal_trace_ipa.h
index 1c8fb95544f9..84568db5421b 100644
--- a/include/trace/events/thermal_power_allocator.h
+++ b/drivers/thermal/thermal_trace_ipa.h
@@ -84,5 +84,11 @@ TRACE_EVENT(thermal_power_allocator_pid,
 );
 #endif /* _TRACE_THERMAL_POWER_ALLOCATOR_H */
 
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE thermal_trace_ipa
+
 /* This part must be outside protection */
 #include <trace/define_trace.h>
-- 
2.34.1

