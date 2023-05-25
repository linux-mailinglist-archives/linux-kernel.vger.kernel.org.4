Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A210D710DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbjEYOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbjEYOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:02:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA0E5D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so2842195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023322; x=1687615322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j7DEK4Cs605GdbFytd8yvP1DYwQA/vZtllLhSrFvtw=;
        b=TVdRlvGXq5UJzCs8zBpNYE7Mo3z4zAUQ3wD/Fscb1Hvi2iqfbNiVxtVrKKDSj27kW2
         jMYPMcyINK/v7Ot3JUABFDPzISMCNJDrEyK80OstgthKDIn2nrWVPdYMYkXDDiBG/uVM
         9/6uj9o9+iLU0xV7AkGvcnZjSkUx2dTuihku91BF7EZ/AiTKxulDni2P/xE0bzJOafqn
         C71itLZLEwBmPfXFV6EeLnJmZxJlXQo9az2N+kPtkw6T4AXU/ydkxmBK8fIJf+hWq9oC
         c5GoUA448WKOqv/Cegx1AtzLO+OyV7QklXU9926pCJgZnlhTGXk/dsDBzPuYkXKGyo0r
         YTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023322; x=1687615322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j7DEK4Cs605GdbFytd8yvP1DYwQA/vZtllLhSrFvtw=;
        b=er8vNsRhA1IoleEzk4GsDZXhj5hx/5H+de3A0bZKE3u/uOoWCA0p9X/f1+UiKLWuFE
         zjkt+r2OfARocZLTSLuItYuroFMvWbIADTSJ0bWEZeZiWtGq47lWlTr3U/MQN8NGIuLs
         W8aHjFWHoo9IV7BBLHD3gajLxW+yVidHonDiZsG2p8GPwJKscKjO/kExPHfmdD7r0sl7
         Qeo/n3fIdpTCF7Ut8M0TrYPSVYEaWja5SV5dsqkkvi9toBo8tyUuSg2j19kT4yOkWVGJ
         Vq2FOdscZxPoa87YQDoFuO+pZoTpeB3BNy8v5UXHPiY2xdSlQv008Yw9BdLbm3odBlgP
         Fqqw==
X-Gm-Message-State: AC+VfDyFqbANnF2gw5wJKKGT6y6R85XBo9YREUKKZKsokBGZKSF5zW8F
        Tn7MCq4SOey26AExQZCO6XaqdQ==
X-Google-Smtp-Source: ACHHUZ5LM5Z8W7aWw6DA+W4MrQBidpOgqN1Z5sdkDoOLagy8R3yj/V83aSDwf8MPE4AeXpn0XWknrQ==
X-Received: by 2002:adf:dcce:0:b0:307:8c47:a266 with SMTP id x14-20020adfdcce000000b003078c47a266mr2567631wrm.61.1685023322111;
        Thu, 25 May 2023 07:02:02 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:02:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/8] thermal/core: Hardening the self-encapsulation
Date:   Thu, 25 May 2023 16:01:29 +0200
Message-Id: <20230525140135.3589917-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal private header has leaked all around the drivers which
interacted with the core internals. The thermal zone structure which
was part of the exported header led also to a leakage of the fields
into the different drivers, making very difficult to improve the core
code without having to change the drivers.

Now we fixed how the thermal drivers were interacting with the thermal
zones (actually fixed how they should not interact). The thermal zone
structure has been moved to the private thermal core header. This
header has been removed from the different drivers and must belong to
the core code only. In order to prevent this private header to be
included again in the drivers, make explicit only the core code can
include this header by defining a THERMAL_CORE_SUBSYS macro. The
private header will contain a check against this macro.

The Tegra SoCtherm driver needs to access thermal_core.h to have the
get_thermal_instance() function definition. It is the only one
remaining driver which need to access the thermal_core.h header, so
the check will emit a warning at compilation time.

Thierry Reding is reworking the driver to get rid of this function [1]
and thus when the changes will be merged, the compilation warning will
be converted to a compilation error, closing definitively the door to
the drivers willing to play with the thermal zone device internals.

No functional changes intended.

[1] https://lore.kernel.org/all/20230414125721.1043589-1-thierry.reding@gmail.com/

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_bang_bang.c       | 1 +
 drivers/thermal/gov_fair_share.c      | 1 +
 drivers/thermal/gov_power_allocator.c | 1 +
 drivers/thermal/gov_step_wise.c       | 1 +
 drivers/thermal/gov_user_space.c      | 1 +
 drivers/thermal/thermal_acpi.c        | 1 +
 drivers/thermal/thermal_core.c        | 1 +
 drivers/thermal/thermal_core.h        | 4 ++++
 drivers/thermal/thermal_helpers.c     | 1 +
 drivers/thermal/thermal_hwmon.c       | 1 +
 drivers/thermal/thermal_netlink.c     | 1 +
 drivers/thermal/thermal_of.c          | 1 +
 drivers/thermal/thermal_sysfs.c       | 1 +
 drivers/thermal/thermal_trip.c        | 1 +
 14 files changed, 17 insertions(+)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 1b121066521f..752c627075ba 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -11,6 +11,7 @@
 
 #include <linux/thermal.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 static int thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 03c2daeb6ee8..108cb5074594 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 #include "thermal_trace.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /**
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 8642f1096b91..d1c6ad92e5b4 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -14,6 +14,7 @@
 #define CREATE_TRACE_POINTS
 #include "thermal_trace_ipa.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 #define INVALID_TRIP -1
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 1050fb4d94c2..1c844004afe5 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -14,6 +14,7 @@
 #include <linux/minmax.h>
 #include "thermal_trace.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /*
diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 8bc1c22aaf03..8883c9ca930f 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 static int user_space_bind(struct thermal_zone_device *tz)
diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
index 0e5698818f69..556c9f0cc40d 100644
--- a/drivers/thermal/thermal_acpi.c
+++ b/drivers/thermal/thermal_acpi.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/units.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /*
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 842f678c1c3e..6bca97e27d59 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -24,6 +24,7 @@
 #define CREATE_TRACE_POINTS
 #include "thermal_trace.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 3d4a787c6b28..84ada34ff079 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -14,6 +14,10 @@
 
 #include "thermal_netlink.h"
 
+#ifndef THERMAL_CORE_SUBSYS
+#warning This header can only be included by the thermal core code
+#endif
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index cfba0965a22d..164c4627949e 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 #include "thermal_trace.h"
 
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index fbe55509e307..3401258e55c6 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -17,6 +17,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_hwmon.h"
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /* hwmon sys I/F */
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 08bc46c3ec7b..f3ac6432bf5f 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -11,6 +11,7 @@
 #include <net/genetlink.h>
 #include <uapi/linux/thermal.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 static const struct genl_multicast_group thermal_genl_mcgrps[] = {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6fb14e521197..0f2aca2d1dea 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /***   functions parsing device tree nodes   ***/
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 6c20c9f90a05..ccda2579ae82 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/jiffies.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /* sys I/F for thermal zone */
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 907f3a4d7bc8..61d927c35776 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -7,6 +7,7 @@
  *
  * Thermal trips handling
  */
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 int __for_each_thermal_trip(struct thermal_zone_device *tz,
-- 
2.34.1

