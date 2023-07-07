Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E898E74B81A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGGUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjGGUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:37:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FD61994
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:37:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso24659505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688762272; x=1691354272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENiHDLKPPvczr4GZmNOm/QgQFFHwqrusGb71Hi0udCM=;
        b=QRM1NdL5OjilaPqxpxhrU6X8Mx+3XPL6jpnjHvu1SzNH+A+LKcgTv+eBljOPwJbRuc
         ty5vJO+njHunKpZ2HMJaNOx0kofqqHOm7b/aGEorWJPegsVB4GV0XkHUzl+dnyIMzS2l
         T/vvOorn4HVl1oQGP00+wRAAWbhursb/emOMKdOOA6RRnxaMYzky1+QjsM5Wo5x3luMT
         cJuwY5GUPdAr0GbwNuxfvtiVrNdr3TYuZJI5xnmmnrKqCnZ6curv8JbRgeqdYV16Tpl6
         urXWb1Sr1z1NuleNJHvaoQJzEgnGCx5NoI2nb3umHw+DACVhvuerjyTceBqSp+v2hq+h
         /b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762272; x=1691354272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENiHDLKPPvczr4GZmNOm/QgQFFHwqrusGb71Hi0udCM=;
        b=dCEt+UObBOmz47UOdacivWdVCzT8lp8sUeCfe6ZaZnsNpLYoQsOH3pFFkHH8aBwbLq
         CSqsAilNl4peJtrtlvUESL7tABYbPnnOT+dE/aI69ZUrAAHtfNul5F+/DXtQtGtstOVY
         yn7Hgi/450xiWpA/bRRfun86h9tqY6W5KenmXIxZgfffBPCvMec+iLYCzP3TyZtUVX0G
         msER7DEp0TWr+htL1KVb/71IafELXJanHCLfiTUnvvdd4HgPLkQ1bbxy5NzR0RVw4wWY
         2akaH2cF8Hje93KemcZdexEGvzYIbnI9yfEOl5aFhrX0hlU/Q1+X2N9hguETgIj9lxFs
         81DQ==
X-Gm-Message-State: ABy/qLblVhVb7gO57HBa4BzX1a28QD7vwbqHxyeaSlb9Ycx9TYTwWLkD
        fLlEQj99jddH1vjq5o0dsBItrA==
X-Google-Smtp-Source: APBJJlEgGWfZgDLVlNwF5NENKVslAufAZE0vPYQus65Hvw2yBnMg7f21XXWxnJgkalSla75e2TIf4w==
X-Received: by 2002:a05:600c:2054:b0:3fb:fea1:affa with SMTP id p20-20020a05600c205400b003fbfea1affamr2638785wmg.37.1688762272030;
        Fri, 07 Jul 2023 13:37:52 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b003143be36d99sm5260674wrp.58.2023.07.07.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 13:37:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 2/4] thermal/core: Reorder the headers inclusion
Date:   Fri,  7 Jul 2023 22:37:29 +0200
Message-Id: <20230707203731.848188-3-daniel.lezcano@linaro.org>
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

The next changes will move the thermal device structure inside the
thermal core code. Consequently, the traces must be included after
thermal_core.h as this one contains the thermal zone device structure
definition the traces need.

Reorder the inclusions.

No functional changes intended.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_power_allocator.c | 6 +++---
 drivers/thermal/thermal_core.c        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d1c6ad92e5b4..6056ed15460b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -11,12 +11,12 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-#define CREATE_TRACE_POINTS
-#include "thermal_trace_ipa.h"
-
 #define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
+#define CREATE_TRACE_POINTS
+#include "thermal_trace_ipa.h" 
+
 #define INVALID_TRIP -1
 
 #define FRAC_BITS 10
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6bca97e27d59..afcd4197babd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -21,13 +21,13 @@
 #include <linux/of.h>
 #include <linux/suspend.h>
 
-#define CREATE_TRACE_POINTS
-#include "thermal_trace.h"
-
 #define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
 
+#define CREATE_TRACE_POINTS
+#include "thermal_trace.h"
+
 static DEFINE_IDA(thermal_tz_ida);
 static DEFINE_IDA(thermal_cdev_ida);
 
-- 
2.34.1

