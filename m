Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4D611DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJ1WtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJ1WtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:49:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2432A1EA55A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:48:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g24so6050763plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8LWoRkfSMU+CJ60Tm7wanIclajGSfZYvjPsATtyTB9c=;
        b=kEf8pkaqDLyKKPRro1RzlspOqf9bDj9K9tXuJIfimPasVBVuSbh3nXFfHuKj3Ygv/e
         Cb2woLyV/0T4hlBWtL+deoHGD9VfD6aKyLYcAQxvNFDXlnQhUFE87y+LQpwOsBtmz5z0
         nYqVpW7KVwrtYp/ANLZ6FHgmzrBkDHxNW5lig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LWoRkfSMU+CJ60Tm7wanIclajGSfZYvjPsATtyTB9c=;
        b=dO1RqJX+lDwxwzt16vp+9PAhYna04k4cZXH5Gej9QZ67oRwCw/D1YfqX1UFxqT1cdq
         mX6noxIrsvXk/zHyound2sqBaHFHG9zWHmx6Vcbh/l+bkqC5kB1jZ0o729oVsq9HdSPW
         tOn7NE6BKQCUCdQZsB6+YgGGD/a8zDn7qSKAc0Z+0gwO8asAzewpeOe+l7QySdYlx/8B
         5X5F7DfTWZVBqVeBYgf6WH13VMbIiannpmD4K+0jfBlacgNEzt0W3Rl7RQ4uGMy+Biyk
         ltvbk+vQI+79vQHD55JEMtDcTEZdLyHgFZ6qzhBLAtWkaSd00sremUVSOOqqD3WowHzg
         ATNg==
X-Gm-Message-State: ACrzQf2ejmE7J9bqrum6DV8ntJaPgQo//EP7pfumoPxSpq7aotcRbgDy
        0+efIZN7CYI9bPl6sOTtZ7djREmG6Z2gYg==
X-Google-Smtp-Source: AMsMyM55Sd5sOvrhwfrL/VW2HDZO143InZb28UjVPt6odCwiOqgaUH7lbfeXhLdju9NuiBJ7Ch77ng==
X-Received: by 2002:a17:90a:c78a:b0:212:e56b:2b17 with SMTP id gn10-20020a17090ac78a00b00212e56b2b17mr1623176pjb.51.1666997300703;
        Fri, 28 Oct 2022 15:48:20 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id 1-20020a17090a0e8100b002009db534d1sm3010415pjx.24.2022.10.28.15.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:48:20 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui <Xinhui.Pan@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] drm/amdgpu: Move racy global PMU list into device
Date:   Fri, 28 Oct 2022 15:48:12 -0700
Message-Id: <20221028224813.1466450-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are multiple amdgpu devices, this list processing can be racy.

We're really treating this like a per-device list, so make that explicit
and remove the global list.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 12 +++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0e6ddf05c23c..e968b7f2417c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1063,6 +1063,10 @@ struct amdgpu_device {
 	struct work_struct		reset_work;
 
 	bool                            job_hang;
+
+#if IS_ENABLED(CONFIG_PERF_EVENTS)
+	struct list_head pmu_list;
+#endif
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 71ee361d0972..24f2055a2f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -23,6 +23,7 @@
 
 #include <linux/perf_event.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include "amdgpu.h"
 #include "amdgpu_pmu.h"
 
@@ -72,9 +73,6 @@ static ssize_t amdgpu_pmu_event_show(struct device *dev,
 			amdgpu_pmu_attr->event_str, amdgpu_pmu_attr->type);
 }
 
-static LIST_HEAD(amdgpu_pmu_list);
-
-
 struct amdgpu_pmu_attr {
 	const char *name;
 	const char *config;
@@ -558,7 +556,7 @@ static int init_pmu_entry_by_type_and_add(struct amdgpu_pmu_entry *pmu_entry,
 		pr_info("Detected AMDGPU %d Perf Events.\n", total_num_events);
 
 
-	list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
+	list_add_tail(&pmu_entry->entry, &pmu_entry->adev->pmu_list);
 
 	return 0;
 err_register:
@@ -579,9 +577,7 @@ void amdgpu_pmu_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_pmu_entry *pe, *temp;
 
-	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
-		if (pe->adev != adev)
-			continue;
+	list_for_each_entry_safe(pe, temp, &adev->pmu_list, entry) {
 		list_del(&pe->entry);
 		perf_pmu_unregister(&pe->pmu);
 		kfree(pe->pmu.attr_groups);
@@ -623,6 +619,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 	int ret = 0;
 	struct amdgpu_pmu_entry *pmu_entry, *pmu_entry_df;
 
+	INIT_LIST_HEAD(&adev->pmu_list);
+
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 		pmu_entry_df = create_pmu_entry(adev, AMDGPU_PMU_PERF_TYPE_DF,
-- 
2.38.1.273.g43a17bfeac-goog

