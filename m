Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D945FB387
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJKNin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJKNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:38:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77615AC70;
        Tue, 11 Oct 2022 06:38:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f140so13558899pfa.1;
        Tue, 11 Oct 2022 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzzPUzUPLy0h+4fYu8F878Wbdxnodxshq8BiiqN94SI=;
        b=j+OKWawPNOYLcaoUHOwfp/7w50cmIfVKS3ortzGoErB9yh9hYO9dveKWZNq8ZANlcY
         WfA8yt8VFRA5hPyeSo4+hkUT5LR2tFj8UEVgC1fqYlSn/jeGibnQfOghFnktYkNyyTcH
         OnRk2LvUoflAUsZfpNT/3HnasIU1V0fIU58Ggp6pXrs/EFitWqk8ZVLPITgq/zTbNq02
         QC1QzEecGLaCRBtjdbw44W9tQPdoT8EAOHUxm3R4lfHCsQ60PEuabqyTTWI9IZk2b2B4
         tBq3WNHslX0zzcHfudqSQScRMIXPhRu+OCw19as4+kY+7SgUOVt67ZnklZ9b2ri/N89Q
         Mb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzzPUzUPLy0h+4fYu8F878Wbdxnodxshq8BiiqN94SI=;
        b=sJ5KCQyAQYvR+5iZlTuKGmdf7+YxAyzWNV4kWCfU/+vb3yIsPRjTS5rx+G0h0Kwt1S
         0EaiCFH6v5SSY2FMtnk+mlydmNGhD9ysoriOJpuHUIYoTEbiWOaMfcwAoDhBuZzvpjkB
         L+dMA7PX9zvEJS+HFhBvlnyzhgxYLjVn6MiZ8feVgkJfBzjqJmguX3Jy29dD1yZW8DS3
         t8771rj0fSQOsPmPsC3vdeJTDXajrcVdMxFiVCG1Y1HbyNmJacemD7Nrog67bvzoXVa6
         PDVCJHUrrEybTK6xuBxQgGij+SW7eqwNkMeTL1t2cjvStv3eAfrpJvmuaebZq3TpOeOy
         KzGQ==
X-Gm-Message-State: ACrzQf1sVxFyJM/YPm/g5BB9V597bY7/nHc/+sD3wE8nhn+EpLlVIAPz
        8CGpRuVcXxSubSGGm+U7c3M=
X-Google-Smtp-Source: AMsMyM5TUij05cN2J0JPTX7D3irn7Y28ZuTNVrFNg+gezWu7sg90bbaSvJoIjlSgCBtj7mQwnitvtA==
X-Received: by 2002:a63:3104:0:b0:459:a367:95ad with SMTP id x4-20020a633104000000b00459a36795admr21666533pgx.112.1665495515411;
        Tue, 11 Oct 2022 06:38:35 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id f11-20020aa7968b000000b0053e93aa8fb9sm8984951pfk.71.2022.10.11.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:38:34 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Qibo Huang <huangqibo.tech@gmail.com>
Subject: [PATCH 2/2] thermal/governors: Fix cooling device setting cooling state failure
Date:   Tue, 11 Oct 2022 21:38:22 +0800
Message-Id: <20221011133822.20213-1-huangqibo.tech@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Because the __thermal_cdev_update function traverses the
cooling_device->thermal_instances list to obtain the maximum
target state, and then the cooling device sets the maximum
cooling state. However, the power_actor_set_power function
only updates the target value of thermal_zone->thermal_instances
to the target state, and does not update the target value of
cooling_device->thermal_instances, resulting in the target
being 0 all the time.

Signed-off-by: Qibo Huang <huangqibo.tech@gmail.com>
---
 drivers/thermal/gov_power_allocator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2d1aeaba38a8..1db697d93fa2 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -293,6 +293,7 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 		      struct thermal_instance *instance, u32 power)
 {
 	unsigned long state;
+	struct thermal_instance *cdev_instance;
 	int ret;
 
 	ret = cdev->ops->power2state(cdev, power, &state);
@@ -300,6 +301,11 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 		return ret;
 
 	instance->target = clamp_val(state, instance->lower, instance->upper);
+	list_for_each_entry(cdev_instance, &cdev->thermal_instances, cdev_node){
+		if(cdev_instance->tz->id == instance->tz->id){
+			cdev_instance->target = state;
+		}
+	}
 	mutex_lock(&cdev->lock);
 	__thermal_cdev_update(cdev);
 	mutex_unlock(&cdev->lock);
-- 
2.37.1

