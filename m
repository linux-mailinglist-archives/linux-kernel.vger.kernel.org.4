Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29E5FB3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJKNsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJKNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:47:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C299FD7;
        Tue, 11 Oct 2022 06:47:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so13210460pjf.5;
        Tue, 11 Oct 2022 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++qS99RmO93zbKMD8xBZUiM3/4ESYDMfDLqXJ/bo6gA=;
        b=kkFXzqMohnFGvAS7BDadVRo9ha6mLY44pWJ4qcRNJkWwDeR2XLBuKsAZMP5IXlC++9
         rLxn47QJ8h1V5K6X9+kW8mQD825II8c717x/MhpNXLj43M+u016h2Oe36DG+vU1K99jc
         bwl0Mlwvg0xw837s7y0CER8llg1FfJdCbwGumlk8ERaU/yTpBswiGgAL9yZu1NBQdC4U
         SGzUMS0/CQFU/4KHMpMSExMsWdgOCb+DWNWKQ4iMz8ba49CRVsQDXi3VBICUabPoIi9v
         qMHxDqIdRazjTj5NQplIDsdszX9P5ca9MQJdj9vJleksIxERNA1ktMCHxy+CYvXjifsc
         OvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++qS99RmO93zbKMD8xBZUiM3/4ESYDMfDLqXJ/bo6gA=;
        b=JBtK5n09ZM62LVWXNAeRGOzOq/JyDNqGSlQcYAfZj7UZDggboINxHZADvKAepJtCi5
         DAkwafePajYDkrj9JOzKlmUCjfKO1SI4QTp9ea7Uwvvt+UupJbJLULtfyQBv20E0Z4CR
         74FnZUs+u4C/aUFOXi/9HDLT0dyhaEgMFr3tfJi6LbbrruvRHtUgeF8GVNzO8yfN22si
         p7orTu40mCYEoYRvSDAr4/3wgLspb8waDdR1+EMeqolcOKUZgQtkeNHkP7RrtabD+B7l
         lRR+2PniTt/lxMb/XbXJHIcVA/dc8hkMTg5lHMyyETfc7T/ZRZUCNrpDdXxSxMu5dA6O
         QLoA==
X-Gm-Message-State: ACrzQf0hRY74Ak4zTPs16fkvQeNU76prynz3NzfV5UGF4fY8/anu6Wgi
        1mDgsivzR6Y2ONL4EeIZDrgvPuW71y7lyg==
X-Google-Smtp-Source: AMsMyM5I4xwfAJviazev9qy9oL2UWXm8813IF9wNOrBXVx43HSeEYDmaIZ2UDWr9zwLntNanhdbaxg==
X-Received: by 2002:a17:902:b212:b0:182:2f05:8aad with SMTP id t18-20020a170902b21200b001822f058aadmr11610678plr.88.1665496077787;
        Tue, 11 Oct 2022 06:47:57 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001837463f654sm1938484plg.251.2022.10.11.06.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:47:57 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Qibo Huang <huangqibo.tech@gmail.com>
Subject: [PATCH] thermal/governors: Fix cooling device setting cooling state failure
Date:   Tue, 11 Oct 2022 21:47:50 +0800
Message-Id: <20221011134750.20980-1-huangqibo.tech@gmail.com>
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

