Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713965FA05C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJJOn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJJOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:43:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB676C137;
        Mon, 10 Oct 2022 07:43:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c24so10586538plo.3;
        Mon, 10 Oct 2022 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrd95k6GPbOHhAfvdiaYVtqkHMeXbzfYwCg/In6/c7g=;
        b=QlbmWFjn8z5Cs1v7eYZPoWGJxvACjjfV/96oGtazZXVGRdUk9fsHKigxuNPLwomO55
         J+NXvzmrxOYzkRPbBh5vrn3kwcmxCFyNdvXk8mGOLe3oYbqyCkkuZsProB0gsN+vHyGT
         N8A0OOg2i5cfqc8i9aFeEMr6qxdV/Aee3OSadXupwO0Yjj+GBd2X97Q5MXmwae+mTO7/
         f4XQlNw+Uc/FJ3b9jTAu/+A5u5gJbVqxbqbmpcD4qhNIV5WJNVup7mYkCcAawsym2mew
         OUGG4BuKfTLFZGd8lsI16ky+JAY6ipl8MMZ9nQDLO6OVzQQGRUYiS2NNFlb3uyGRVY1V
         K1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nrd95k6GPbOHhAfvdiaYVtqkHMeXbzfYwCg/In6/c7g=;
        b=badv7wEebnSTjiIzRe7tDnxvW2dOXeaz/yfZ16K+aASEaSA31y+koCzJzCp5ZUlpDn
         alq0cFwOX806cVOewB7BwQDr8YSyWLJZLRbPruopmWEHV6SvIvMsJKr9rnVtKwehihGr
         fKg+e39dftqrD1yXNQbAIZx6Md8uIxjQqfqcWYEG0NNhXptHAWbYLU7POTov7AHF14dY
         SjB+VTEF4+yptMFM42cd3xRrT4q+4gmC8htrA0RsDoyUBcn889yOZWPQpM5ZeE8KZ6t7
         SCUHvG3+U/jeURbKQsAFnoE2lIDy6lY3i+lJj6DDRZk0eL4iakw4NfstbWGDzJWVA8ym
         MYFQ==
X-Gm-Message-State: ACrzQf10OkqbI0GlSw7AuoZH6BgQZfmdOVqNQnu/gh42alfQ7QKB11oI
        LrGzPw9ZavRNimjVy4F3sic=
X-Google-Smtp-Source: AMsMyM7c9/OUUEj2Qpcm3zY0WKWkTDc2G4V1VIUrfZnTmr1afP2recxfW4QgvrcmxI6bdUASl8P13A==
X-Received: by 2002:a17:90a:a512:b0:209:9b31:5f2f with SMTP id a18-20020a17090aa51200b002099b315f2fmr21920791pjq.146.1665413030479;
        Mon, 10 Oct 2022 07:43:50 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id pg12-20020a17090b1e0c00b0020087d7e778sm9198078pjb.37.2022.10.10.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 07:43:50 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Qibo Huang <huangqibo.tech@gmail.com>
Subject: [PATCH] thermal/governors: Fix cooling device setting cooling state failure
Date:   Mon, 10 Oct 2022 22:43:41 +0800
Message-Id: <20221010144341.16738-1-huangqibo.tech@gmail.com>
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
index 2d1aeaba38a8..8a6a08906dd4 100644
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
+			cdev_instance->target = state;
+	}
 	mutex_lock(&cdev->lock);
 	__thermal_cdev_update(cdev);
 	mutex_unlock(&cdev->lock);
-- 
2.37.1

