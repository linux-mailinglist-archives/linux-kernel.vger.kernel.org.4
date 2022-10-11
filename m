Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F3E5FB3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKNyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJKNyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:54:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CC15FC6;
        Tue, 11 Oct 2022 06:54:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso8310882pja.5;
        Tue, 11 Oct 2022 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++qS99RmO93zbKMD8xBZUiM3/4ESYDMfDLqXJ/bo6gA=;
        b=cgs4pIdy/DRkLmn5aVKtA8ZDVxt2PWskVhJn+tHzYd3ShxyglR+mzRl/7f+qEdoK1G
         eyOAJjYDP2aPMh4r9aLyfVtrsH1rinWlbBkhTbYWP8bOnd4hBCuCko+utATMq6UqFgYm
         iJYkI7Uc/qbW6ni0uha4RCRJ8aVOc+2tRiPs6Vj6d03TxzzzEu5ZNfCkEeYUoC8xXuBt
         WQvOt6+6GJ0P4ABgtE2aDahhN5kkqtKNuIU++E4PF8j6b3AFKJQrYakh+0+dgpSQ+CZv
         bFg2DXWTEGHzkY98OaV5aDcWrKDTZsturnHKe6n1GD3jwFKtd+w8bIl5prGMalFmMviF
         urAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++qS99RmO93zbKMD8xBZUiM3/4ESYDMfDLqXJ/bo6gA=;
        b=pFiXbEf3GKQ+7pfA5wAvBrpWMcNjm84PQV/ky4LF8VJEklEuHdWCjRRsYmpbWk/uUP
         WqJPnrekZW0yQ2MFIku3efRQQXoXwQkDltjljNCPHhAmz/pDssf08DU8NZpZ2cZRSKWt
         QI6f0tovnRs2xXxuGKaWyFaxMt1ND3Qz4ljWlnCKWxNClWsIojOSJbQTITnm12whozLe
         lsN2G7xCodlrvSL8yxdyTRQw8Vto/xwdnjrP/dbeQYJCoZ3LKHhXy2jbll0AUGEdN6pn
         Y8tMSFr52mowj4estT84AAYOUGybC8AWPMXy2p4RJwxM0G/lLgQMb6AWTV2AazimEslG
         BOkA==
X-Gm-Message-State: ACrzQf2Vu9hw42e62sW+SydEXmBMaY2HDZQKiHQ57dlZvaR+fy1ns+c1
        00peWCCveWM456OwkbZS5aA=
X-Google-Smtp-Source: AMsMyM5lo/jNIkI/quSoU4v4DX9j89fDJOAWhjaXs3sThlQUdVl97SLoVQYRsiAOe9l+baw7yo+Rgg==
X-Received: by 2002:a17:90b:2741:b0:20a:ebc3:6513 with SMTP id qi1-20020a17090b274100b0020aebc36513mr27919382pjb.29.1665496490132;
        Tue, 11 Oct 2022 06:54:50 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id x20-20020a63cc14000000b0041c35462316sm8007259pgf.26.2022.10.11.06.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:54:49 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     lukasz.luba@arm.com, rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Qibo Huang <huangqibo.tech@gmail.com>
Subject: [PATCH] thermal/governors: Fix cooling device setting cooling state failure
Date:   Tue, 11 Oct 2022 21:54:41 +0800
Message-Id: <20221011135441.21166-1-huangqibo.tech@gmail.com>
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
 drivers/thermal/gov_power_allocator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2d1aeaba38a8..2bdf8d797e3c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -293,6 +293,7 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 		      struct thermal_instance *instance, u32 power)
 {
 	unsigned long state;
+	struct thermal_instance *cdev_instance;
 	int ret;
 
 	ret = cdev->ops->power2state(cdev, power, &state);
@@ -300,6 +301,10 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 		return ret;
 
 	instance->target = clamp_val(state, instance->lower, instance->upper);
+	list_for_each_entry(cdev_instance, &cdev->thermal_instances, cdev_node) {
+		if (cdev_instance->tz->id == instance->tz->id)
+			cdev_instance->target = instance->target;
+	}
 	mutex_lock(&cdev->lock);
 	__thermal_cdev_update(cdev);
 	mutex_unlock(&cdev->lock);
-- 
2.37.1

