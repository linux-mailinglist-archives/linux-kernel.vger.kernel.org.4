Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0556B6B5D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjCLUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCLUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:43:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96323B86F;
        Sun, 12 Mar 2023 13:42:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so661190pjv.5;
        Sun, 12 Mar 2023 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LG2BAueGKKjRd5oOzkHW01KAXz7hJtO0YTeAZX7ebQ=;
        b=o6Q8Q10OxuBDZmjDEuj2Y0nzd08O4SmkNr7icIu4A9ga7782yiqyFRevK97HPgKyFZ
         6qkbvhSNrBGhQpxnDY402WtIbd1G4UBrLLETBRvCoEjPwmhVWuVcznthcpwUo92+mojw
         4uwJLnWSzukpVg2j87ZJnFnMfMDvRNPgUJexVJ2GzpCshxiyhRxT3MkZEt7+m3lP3A8e
         RUJJeZCTmHckq7flx6Olfmh7eNr9szbof0gd1O1WuP1T46bdjxQTZSmHKvy3HzWR59Lu
         /kA3/Aqul4HsLTsD321WiqJQNTo2DI/NP6YT3RLZ5NH1HCuw1vPP7jOOmqLnLZP7A5/6
         uylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LG2BAueGKKjRd5oOzkHW01KAXz7hJtO0YTeAZX7ebQ=;
        b=7L5enfPPv1H8z1RpEekA3MJsXeFzjTEVRwjXi65UdQkKJNARJTtj/+YAH6XtPpEqPH
         U879BZxcd1Brc6bpQKpOubvZYdimfFw8XYqb6UXSxiKyMllcEBWcQGaYiGst13ATa3dz
         vEw+vNAATbYug+C4+51lE8sNJROfmO9MIKVMOLU7EnGCwnb7iYUQg96Lc+LDdHd69x6y
         WUo0KaBuIcsqQMWx57lQjs36Q35K04h2kOMoHM2Yy8WrkuRoMES6Q5mpmvrpcajwtOiu
         HxKD41LEKVMHEc6cktXjLIaWEx01PaCMl0HjS8G1lUkP0mVbFWlnt1cNQ7HPcPPE7lJD
         r+Bw==
X-Gm-Message-State: AO0yUKWjmtD54SO9b6mFOeKUuvpWZf9JNmYDW/zVBjiyE095Sn4AIIdG
        d5byLr8PIrQvFAdRZymq4lo=
X-Google-Smtp-Source: AK7set9HqHg61quU96CXyCxA74hP/mhbXO2z8J3uqAl4XHL/YO/JW0G0ml5eubnXv6Zs7wdSTVStgw==
X-Received: by 2002:a17:902:ea0e:b0:19c:d663:a31b with SMTP id s14-20020a170902ea0e00b0019cd663a31bmr38298904plg.24.1678653764503;
        Sun, 12 Mar 2023 13:42:44 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id kv12-20020a17090328cc00b0019bd934434esm3269700plb.53.2023.03.12.13.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:44 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/13] PM / QoS: Decouple request alloc from dev_pm_qos_mtx
Date:   Sun, 12 Mar 2023 13:41:37 -0700
Message-Id: <20230312204150.1353517-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Similar to the previous patch, move the allocation out from under
dev_pm_qos_mtx, by speculatively doing the allocation and handle
any race after acquiring dev_pm_qos_mtx by freeing the redundant
allocation.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/qos.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index f3e0c6b65635..9cba334b3729 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -922,12 +922,16 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
  */
 int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 {
+	struct dev_pm_qos_request *req = NULL;
 	int ret;
 
 	ret = dev_pm_qos_constraints_ensure_allocated(dev);
 	if (ret)
 		return ret;
 
+	if (!dev->power.qos->latency_tolerance_req)
+		req = kzalloc(sizeof(*req), GFP_KERNEL);
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (!dev->power.qos->latency_tolerance_req) {
@@ -940,7 +944,6 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 				ret = -EINVAL;
 			goto out;
 		}
-		req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req) {
 			ret = -ENOMEM;
 			goto out;
@@ -952,6 +955,13 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 		}
 		dev->power.qos->latency_tolerance_req = req;
 	} else {
+		/*
+		 * If we raced with another thread to allocate the request,
+		 * simply free the redundant allocation and move on.
+		 */
+		if (req)
+			kfree(req);
+
 		if (val < 0) {
 			__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
 			ret = 0;
-- 
2.39.2

