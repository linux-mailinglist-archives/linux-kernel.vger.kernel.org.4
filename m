Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF41A6921A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjBJPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjBJPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:10:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F2F3B3D4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u10so4039211wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0+nb49xfCO7TD3Kw+7mvNnwEcPqxWc5InnfsnZGnCRs=;
        b=Vf9PtwnuqpDb3fAhMflYECBHkp7KeCBtEl+u5e4CZLHluK63I/51FVapv1/EYp0ODv
         3uWlEYgRD3tR9ihgjZQfL/UVF5+xyBQGahpE7piBa8f43rmOk0/darZ3iAzh2B2oY4ZQ
         3RPyTj8KdeMSAyQ8vWWXCoYqF3is9+RVtHZ4u4EZBWoXNW8FtbjIKEtW6+3re5e1b2Di
         otYjLP/0wDcw5aFb6COJfdCqg4FIpd4Z0v6fH3tzScbp2Q8bxDFaTaL1K4y+mBoVL7l6
         5Sa4wW7fvZ2ZAvFcDoZ5e19Aj/I+hzAvrSOHnm2G/I0SRw7rjqiBxI/m01u1liOdLTNt
         Rf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+nb49xfCO7TD3Kw+7mvNnwEcPqxWc5InnfsnZGnCRs=;
        b=VKwNiXQ3ENi9ck6zzDl7smYr1Svdw0mR5iFjhjNHJNtU8tuatiBS/+/40xtvu5ndFM
         rpNzWODQ1L0U3F8C16fv8MRaVYDhtUChZ6V0yeomHG+nT6AG95O05ckBvautqYMVgkeD
         5UKpaY59WwXOGhape3IdMJeW52H+V2l5OTuictD9JhirjDMCULg40abf1XWMw8+l8fe7
         fW18nlAfk6LH8Q9UeY0ai07oBGTkBtD4P/ITYToQQdDMyzfP5t6YTm2Len3PUsfOsMVR
         2IiJkPpP6bFa5Xw5B6k4cCE7F3paCFZue9hcN/AwGFyGAeWmgNg92lXsd+CGhw9Hk7L7
         gtrw==
X-Gm-Message-State: AO0yUKUE16DG2so/3Vbzq2uv92Qo+hLZwzmF3eS/TWyIOQl/+oeUrQOm
        OaWpZ3T7xDQqOVB6fEpV9Xll5Q==
X-Google-Smtp-Source: AK7set8PgXQAjv0wyRo2U+xZEUpv6yGnZQRS3itBN5CqTvpSKRQOJRUkgpMti9J7JmvAwsTjZBymag==
X-Received: by 2002:a05:600c:a692:b0:3df:d86d:797a with SMTP id ip18-20020a05600ca69200b003dfd86d797amr14892869wmb.25.1676041813610;
        Fri, 10 Feb 2023 07:10:13 -0800 (PST)
Received: from linaro.org ([2a00:23c5:680a:d01:61c3:70d8:6500:e102])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003db0ee277b2sm8587771wmq.5.2023.02.10.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:10:12 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, yabinc@google.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 1/3] coresight: Update timeout functions to allow return of test register value
Date:   Fri, 10 Feb 2023 15:10:06 +0000
Message-Id: <20230210151008.4587-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230210151008.4587-1-mike.leach@linaro.org>
References: <20230210151008.4587-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current coresight_timeout function spins on a bit on a test register,
till bit value achieved or timeout hit.

Add another function to return the full value of the register being
tested.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 50 +++++++++++++++-----
 include/linux/coresight.h                    | 10 +++-
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d3bf82c0de1d..c4db111ab32b 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1456,32 +1456,37 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 }
 
 /**
- * coresight_timeout - loop until a bit has changed to a specific register
- *			state.
+ * coresight_timeout_retval - loop until a bit has changed to a specific register
+ *			      state. Return final register value
  * @csa: coresight device access for the device
  * @offset: Offset of the register from the base of the device.
  * @position: the position of the bit of interest.
  * @value: the value the bit should have.
+ * @rval:  the last read value of the register being tested.
  *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */
-int coresight_timeout(struct csdev_access *csa, u32 offset,
-		      int position, int value)
+int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
+			     int position, int value, u32 *rval)
 {
-	int i;
-	u32 val;
+	int i, rc = -EAGAIN;
+	u32 val = 0;
 
 	for (i = TIMEOUT_US; i > 0; i--) {
 		val = csdev_access_read32(csa, offset);
 		/* waiting on the bit to go from 0 to 1 */
 		if (value) {
-			if (val & BIT(position))
-				return 0;
+			if (val & BIT(position)) {
+				rc = 0;
+				goto return_rval;
+			}
 		/* waiting on the bit to go from 1 to 0 */
 		} else {
-			if (!(val & BIT(position)))
-				return 0;
+			if (!(val & BIT(position))) {
+				rc = 0;
+				goto return_rval;
+			}
 		}
 
 		/*
@@ -1493,7 +1498,30 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
 			udelay(1);
 	}
 
-	return -EAGAIN;
+return_rval:
+	*rval = val;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(coresight_timeout_retval);
+
+/**
+ * coresight_timeout - loop until a bit has changed to a specific register
+ *		       state
+ * @csa: coresight device access for the device
+ * @offset: Offset of the register from the base of the device.
+ * @position: the position of the bit of interest.
+ * @value: the value the bit should have.
+ *
+ * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
+ * TIMEOUT_US has elapsed, which ever happens first.
+ */
+int coresight_timeout(struct csdev_access *csa, u32 offset,
+		      int position, int value)
+{
+	u32 rval = 0;
+
+	return coresight_timeout_retval(csa, offset, position, value, &rval);
 }
 EXPORT_SYMBOL_GPL(coresight_timeout);
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f19a47b9bb5a..6b6b45ef6971 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -500,7 +500,8 @@ extern int coresight_enable(struct coresight_device *csdev);
 extern void coresight_disable(struct coresight_device *csdev);
 extern int coresight_timeout(struct csdev_access *csa, u32 offset,
 			     int position, int value);
-
+extern int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
+				    int position, int value, u32 *rval);
 extern int coresight_claim_device(struct coresight_device *csdev);
 extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
 
@@ -536,6 +537,13 @@ static inline int coresight_timeout(struct csdev_access *csa, u32 offset,
 	return 1;
 }
 
+static inline int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
+					   int position, int value, u32 *rval)
+{
+	*rval = 0;
+	return 1;
+}
+
 static inline int coresight_claim_device_unlocked(struct coresight_device *csdev)
 {
 	return -EINVAL;
-- 
2.17.1

