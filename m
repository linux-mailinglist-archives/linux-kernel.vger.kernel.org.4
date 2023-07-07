Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8570074B81C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjGGUiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjGGUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:37:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B241FEB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:37:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313f1085ac2so2332332f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688762271; x=1691354271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUcFRaFpRqekh1XutoF5FSJVV/l/MywjnadXba/M7Ls=;
        b=N6kGPoHEYocK0GLv1K4DMPcmhTN9rJUEJYHQDBpPnfUl7IyxvK6/Ta+cmCpT9vbujb
         T8ySrUdHyECVCmx17VBkSNP2xyH84fTiKPMpFn/JRSzACYvPlQnUpN3eEvAWTuEek4NE
         Z3lzcFeqAnlPOyN6Or0QhPdZaxYXvknAIfZUBMVtEqMYAt/Qs6sRoRCd+XYxvpTa97Tq
         SWA4fCtMO3gUqH5BCbR1BpSspfdsaT7hzX57Lf8ZTNmZJjw+T9GNI/fcPgmMCsJNoeTM
         K0VryCKVNLk0E6BTgEOa5sU7t3oDtI/hGZOfeLzup+iHj1SR3LVw/uUfP3dgODdRdBrB
         g2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762271; x=1691354271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUcFRaFpRqekh1XutoF5FSJVV/l/MywjnadXba/M7Ls=;
        b=gFyo2TlzNs8gW1Sv71+RdUExk5y2VIbR+EK1bGw/kvXMTEwxiU8x6e0eOWP93D6+BS
         74d+vENRs6RJsY5A4sjyS/1OCeTHbmyOrKRR98UuqDKw4h0pam7KEEtuD8XRNImYHw3B
         vcmL2UAk2QAyrR/kFxDbN282jza6QKYdLb2yGXwpbj27l77ibYddvtNlwnR7bhU5jn7C
         aMaLoMr7F5qY+Xg/Bo/qagADOoTi+85mY2Wz7acqzepOCtbXO/3fvF7assNNxV0RJ2cg
         iQFctsF1eNRgVK0HP2abNpZPoaXnG1ovA53FqYk6cwmUSaFbcuIej28dWMHpl30zSuzg
         M1Ug==
X-Gm-Message-State: ABy/qLZoITu5JADOYUgrzbAFdHzWf5A5CVGdCW3s0JKYhgI7sBAn8ecd
        LaqKZ64RQqkENBeWfymY6uJOyQ==
X-Google-Smtp-Source: APBJJlGUPPMDg0BAP/ewPfJ5t0eKHzjC40OAub6ONAm9mN5qz2r2Pjv2SffMR8kpntYaWX+Ue7TP8A==
X-Received: by 2002:adf:ee03:0:b0:314:15b7:1fb4 with SMTP id y3-20020adfee03000000b0031415b71fb4mr4868023wrn.52.1688762271183;
        Fri, 07 Jul 2023 13:37:51 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b003143be36d99sm5260674wrp.58.2023.07.07.13.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 13:37:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 1/4] thermal/core: Hardening the self-encapsulation
Date:   Fri,  7 Jul 2023 22:37:28 +0200
Message-Id: <20230707203731.848188-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707203731.848188-1-daniel.lezcano@linaro.org>
References: <20230707203731.848188-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
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
index 17c1bbed734d..2f58eb9854ff 100644
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
index c3ae44659b81..ba2ae5be0c23 100644
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

