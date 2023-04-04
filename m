Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911AC6D5A03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjDDHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjDDHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:51:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B531739
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:51:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q19so28699677wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680594713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eHql4WTN7nTnO54YwymmcHpD/uil9JTue50IFNnQxg=;
        b=Ou5K8S/Iw2hdb/VMPMb0sZf7Pm0Bn8pCm+9VFVq02Ps67bpwxOO1x781n4tNZqY0Wu
         rkPk2p/LvEw7LntN9e4NYrjBLc2GrUXI7E8cmPJDGo/pKjRoyF3psxbU33+RhIs5rimj
         vn1ul8ctxVd10CTS7p0pXTTChuLbQsgBCbq9fzJ4wO0TCCmcP3FkgBdjH3IsRFdQ7F80
         PekohjtmCtrebl8R5UTgpdBffsXWGqJb57wPxZASXcaCDJTrseLn097uRehiW1gFiWoQ
         T8jiX3mPV1CgsBlgQmaYliYCZBcg8TwfH9ga+GQr/7ql9aQoW4w22b3yzF0C8MH/gMnx
         k3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680594713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eHql4WTN7nTnO54YwymmcHpD/uil9JTue50IFNnQxg=;
        b=WNfRBUdaRkqYuxpv1dJ23dYL/8gOYNFMdrH4RF0iQhFZEy57iRzbrEQe/NHp+Rnexh
         qiys86fLkP9bPjkuBTQ2dR9JkhpG7UazSDXa/pB/FqxbqKPvl4bazAuk7xYMMwOO979Q
         BJpjdUVXu662H5k0P3IFsdYPvho0nuN0dzSCSoMgnM7N0a7gVCpADAd87gd9kwj6HFmr
         P4i+WtMhlrGQ0R/5V2S9FzGmQTvrgz+F2noV46NZBhbMqwTAmBvsduSxRxFZDIWRjb5m
         1eCIDYABrq2Yi68y5crPDxj/D8psk3Etdf+hLH67MKqfKF4FtDH2o9WnewrccCPOLSjl
         YVMQ==
X-Gm-Message-State: AAQBX9fyBsSL95Ch7BOuIImgiqzNxyl5uLx6ghTWPFXgPpcyif/hZ0Mk
        NwpWrJJlzU4qldoCEIWuAYbFqw==
X-Google-Smtp-Source: AKy350asUsJa/X7X/Yc+hA/MLWDEPB3vHQxoVFv0EJuSrvEc2HQFhdjrA7/3FGqcDS9/b9HRB1d2VQ==
X-Received: by 2002:adf:ed81:0:b0:2e6:ba1a:8d8 with SMTP id c1-20020adfed81000000b002e6ba1a08d8mr945588wro.41.1680594712681;
        Tue, 04 Apr 2023 00:51:52 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9754:a4ba:a0f5:8937])
        by smtp.gmail.com with ESMTPSA id r13-20020adff10d000000b002e45f6ffe63sm11591561wro.26.2023.04.04.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 00:51:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 2/3] thermal/of: Unexport unused OF functions
Date:   Tue,  4 Apr 2023 09:51:36 +0200
Message-Id: <20230404075138.2914680-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404075138.2914680-1-daniel.lezcano@linaro.org>
References: <20230404075138.2914680-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions thermal_of_zone_register() and
thermal_of_zone_unregister() are no longer needed from the drivers as
the devm_ variant is always used.

Make them static in the C file and remove their declaration from thermal.h

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
   V2:
     - No changes
---
 drivers/thermal/thermal_of.c |  8 +++-----
 include/linux/thermal.h      | 17 -----------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index ff4d12ef51bc..6fb14e521197 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -439,7 +439,7 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
  *
  * @tz: a pointer to the thermal zone structure
  */
-void thermal_of_zone_unregister(struct thermal_zone_device *tz)
+static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
 	struct thermal_trip *trips = tz->trips;
 	struct thermal_zone_params *tzp = tz->tzp;
@@ -451,7 +451,6 @@ void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 	kfree(tzp);
 	kfree(ops);
 }
-EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
 
 /**
  * thermal_of_zone_register - Register a thermal zone with device node
@@ -473,8 +472,8 @@ EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
  *	- ENOMEM: if one structure can not be allocated
  *	- Other negative errors are returned by the underlying called functions
  */
-struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-						     const struct thermal_zone_device_ops *ops)
+static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+							    const struct thermal_zone_device_ops *ops)
 {
 	struct thermal_zone_device *tz;
 	struct thermal_trip *trips;
@@ -550,7 +549,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(thermal_of_zone_register);
 
 static void devm_thermal_of_zone_release(struct device *dev, void *res)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 204116dd97bf..d26b8e2e404e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -266,25 +266,12 @@ struct thermal_zone_params {
 
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
-struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-						     const struct thermal_zone_device_ops *ops);
-
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
 							  const struct thermal_zone_device_ops *ops);
 
-void thermal_of_zone_unregister(struct thermal_zone_device *tz);
-
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
-void thermal_of_zone_unregister(struct thermal_zone_device *tz);
-
 #else
-static inline
-struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-						     const struct thermal_zone_device_ops *ops)
-{
-	return ERR_PTR(-ENOTSUPP);
-}
 
 static inline
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
@@ -293,10 +280,6 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
-{
-}
-
 static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
-- 
2.34.1

