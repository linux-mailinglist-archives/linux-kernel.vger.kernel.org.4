Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A86E5C09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjDRIbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjDRIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:31:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414021BE2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:31:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so13077435wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681806667; x=1684398667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pcig8VWar3G5dNsmApdG18M9MAPyuIPGXofGInx53Fg=;
        b=g2S5d/HeWPAdNYl1qFPhx4O40BSCwl4YAIagip7ReJgv5xvJxihhXrqU30Om/BdWz7
         JpwAAgQEmgcUJwQ2Di7nd4DsQisg2IwZKnjKKEpo9iBw05gsmZx3b3Ul+gf0gcRAAWD+
         hllfvyXiUam1WzRcE03xIl1r+BgeZgW3Hmz7Vyre+84wYFggP9KOs76KuJhu7RDQzjUK
         XFs7NRm3pTCg4QaMC/pzunrEGHDUHtCZd52iYTnOFo8woc5oiNuRsYVrc+7LR/IXzb9e
         CIZWpLxncyrrwn+lMZy6rhU2N7xUZLltFBzCgBwlwDFqnTRHj1pmfU4CQ+WyRmSJv9Dx
         VZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806667; x=1684398667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pcig8VWar3G5dNsmApdG18M9MAPyuIPGXofGInx53Fg=;
        b=k+Iue0gJBacLbP13csvUWtunbfYCqcIarkeCfh5f1CIC4Uv9mn4pgprKVJCSGFgFB3
         81wtC+o+fjiUM14Xx8AvEc5gvZu8PE6Te26bSAM3LteSS14FRmHrNPP5/yVSmxKLVqcl
         Mc+aRKpI+qM8BSKp3ZbayzWgJwqP+T/MqG4yRKT84ASanLQfkCTJ22OMRRtAs508AIW0
         hv5yX+34L2Y/s8EyLgHMDtozltEu9hrNSQkIb9+Fhbp/+w7d3QSgKbYupAmejgN1yhQP
         b+2lE9VFhuzhHqxVqAXquw1Dh1zbbgDnVX89w61PFrxjtPdXKFqJxjw7KLxeGLucoJgW
         OMZA==
X-Gm-Message-State: AAQBX9f9AaiVbA3TDScPabpZman3no66Jmc5rM3nyJYKwtgPz+XeQ3WF
        VxHCs18FJY8/JVXWckLJtqWQYw==
X-Google-Smtp-Source: AKy350ZrzCLPJOpvmcPDApu6vy1EK6sWJSgztBmGgVwAYOxV/ZvwxvZ0PaW8EsaEU1vbzMW4btLIsQ==
X-Received: by 2002:a05:600c:253:b0:3f1:733d:f3c0 with SMTP id 19-20020a05600c025300b003f1733df3c0mr4622805wmj.14.1681806667613;
        Tue, 18 Apr 2023 01:31:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c25b:18d5:815a:e12b])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003f1738d0d13sm1805978wms.1.2023.04.18.01.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:31:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Subject: [PATCH v1 1/3] thermal/core: Hardening the self-encapsulation
Date:   Tue, 18 Apr 2023 10:30:53 +0200
Message-Id: <20230418083055.3611721-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418083055.3611721-1-daniel.lezcano@linaro.org>
References: <20230418083055.3611721-1-daniel.lezcano@linaro.org>
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
index 3d3067804df2..bfc9adf882d6 100644
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
index 5eacbcd10a40..feb02c48beba 100644
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
index 33c5be929ad5..40faabb59183 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /***   functions parsing device tree nodes   ***/
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 7ad1e40397e3..7fb24d1e2fad 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/jiffies.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /* sys I/F for thermal zone */
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index e1539e1d96e6..a12980a8bac5 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -7,6 +7,7 @@
  *
  * Thermal trips handling
  */
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 static const char * const trip_types[] = {
-- 
2.34.1

