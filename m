Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800A16C1572
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjCTOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjCTOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:46:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C79D302;
        Mon, 20 Mar 2023 07:45:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so8146731pjl.4;
        Mon, 20 Mar 2023 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LG2BAueGKKjRd5oOzkHW01KAXz7hJtO0YTeAZX7ebQ=;
        b=JYMfuqbtpiJILVkp0uoqa+oBsFme/4zOTzeVWYi3j3wR1ZQJWuMq7gV27NVroQ4Cof
         DvrYwJDRdr8vjUe7AoOTjec4wKPvjzpSGWLEwjaFkMJH0s8z+PQvoCMmcpojocLE7ybO
         oo+/Hl2TVSIoCQa+s4zQECFi1GZGH4VbTC86Yqlf91CDneoARc4TOJ4Z2guCXmZDIpSu
         /196tgzmV3xQEvnInxfSyu1LNUDP3vSbz96LAF3Eqc21Kvo8zow4uMY7aNpcZ4+NT4Yg
         MDg9DNeVPHKmg+hxMcvtXfab3OuON64cpe+DAyLDIvSqDWJdJRf7qPJfP/BVFmTravPm
         rQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LG2BAueGKKjRd5oOzkHW01KAXz7hJtO0YTeAZX7ebQ=;
        b=UrNvbjjWzYc5ua1kh5fogAC/kGvNkeEO/mH/8s/RbZZnP5042J0uXChEEoknNxGfyL
         UH0zwFqJX5eCROH24/M7uqIub0l6hBYTbUytYna8balEm6JVHnQ11PrV41dFdzSDCIY8
         R0ra9MXwCNmEKUHi231Ff/MMMmnYXA+w2Ohl9AtMfi+iYijV0rdbnsbLxlnJonftPWBi
         vNQy1B4vI7N7juWymju54QnKUyavLrZlede47FenT4ZvGXRY5U0MPlL2eMJLgFKBylXX
         pyBojVIwStxyzXRLswXcxcsIJ/XrVDiYBLfNkJTLVGORmOWVQmZBb6I7HPruWKnV38Jb
         IesA==
X-Gm-Message-State: AO0yUKWBbmQ1kD6WIYSIHf1CX+ZiTOVHuCM010AlE4lYEfCYVXjrExMj
        dF4i+Z6WxaAITxPJYwZc1Uw=
X-Google-Smtp-Source: AK7set8ZMssF9rVaP9Q2tyqSeIvwgvafCYLFB4nuIVnqISbFD6NVpbGZbgq3RCYIRz5Qz1iGPiJ1mg==
X-Received: by 2002:a17:902:c40a:b0:1a1:b9e0:fa1c with SMTP id k10-20020a170902c40a00b001a1b9e0fa1cmr10839593plk.0.1679323509573;
        Mon, 20 Mar 2023 07:45:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id io7-20020a17090312c700b001a1ca6dc38csm2920651plb.118.2023.03.20.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:45:09 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 18/23] PM / QoS: Decouple request alloc from dev_pm_qos_mtx
Date:   Mon, 20 Mar 2023 07:43:40 -0700
Message-Id: <20230320144356.803762-19-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
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

