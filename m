Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F350B677FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjAWPhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjAWPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:37:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76C1713;
        Mon, 23 Jan 2023 07:37:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so14763597pjq.0;
        Mon, 23 Jan 2023 07:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqm/b4+IUdS1MqzQZf17cD89gtcHvfXYnuA2GMItHy8=;
        b=BeoLm0GehG2RTvXfpa3TJlY/SMshWzp1bpns58/nwqsEifYxf7ekkD81AfXJagIOB+
         UwAIUci/GqYTsUdXnuChLkVGcn4T3p+5uaKqwcLNqvnWDcMrSJANvtyZBCbtN2jWDxf5
         xPZJKPW9mL/HwXGKP1o6XJmkUxIkmAUXgz3uArCcSb3MCMl9GJ96KThvVJTuhP8c7mwi
         KGxfbUstxf/dJP4hjJttF8HclYAjm1Fh54CnnMfMaNXpNjc3okJlYaBi6GcVQ23E2OFA
         seXpNS0ZQYAJ/7latTNsL3P9YxlsQLnB6SXm1OyZuvUJQyK1ZWD1h3fdozu7KQjgIOt/
         7Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqm/b4+IUdS1MqzQZf17cD89gtcHvfXYnuA2GMItHy8=;
        b=gdXK/dQERksXnjWeR+oYVPgnylkdpNajhJS7jBgzy20zTXIDeqsi8jZAbCdDmqgAH2
         vAtKEYDM+XMF4lziwZFbTu1AzV9AMpxvhD3WdsUl8vX0tMlUYcy4PwRXao0a9mWvVDHc
         GnOaEYoQ3MFrxQNXMi6FoVefhotQcf+Dbv+dGzcjTZIFaBb70DLrhwkiTwaYrOefIE+/
         o5aiM5Ojmye3MjghzmSI+y+63Cp+/9hLaIE4lMeF6rL7PKnJ7fTmS2tppSGOKQwj2lAO
         g+AXz2Ep3TDx+9SegvTxGIxJiYo2GrMNQ4yNmu4efYD0VeaVVi66vKnjjF/+OlFrXlkf
         w8sA==
X-Gm-Message-State: AFqh2koe4YgWD7qN4h9yD8kZzZSJI+cnsbVcGtsXiaKr7HF8Lnil2oMN
        Wka6JILc9WXwbWJiqAE6cFHuewBgHe0=
X-Google-Smtp-Source: AMrXdXse4poj4j7/kfYLEJ+8471w5Y524fdoIV5ZbcJvP4IGR3j2MuWF5o0LGi9ty84jgW5rm9vbvg==
X-Received: by 2002:a17:902:e403:b0:194:3dd0:e332 with SMTP id m3-20020a170902e40300b001943dd0e332mr21920673ple.69.1674488262052;
        Mon, 23 Jan 2023 07:37:42 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0018963b8e131sm10333712plx.290.2023.01.23.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:37:41 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PM / devfreq: Fix build issues with devfreq disabled
Date:   Mon, 23 Jan 2023 07:37:45 -0800
Message-Id: <20230123153745.3185032-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

The existing no-op shims for when PM_DEVFREQ (or an individual governor)
only do half the job.  The governor specific config/tuning structs need
to be available to avoid compile errors in drivers using devfreq.

Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Assuming this doesn't conflict with anything else landing via another
tree, an a-b to land this via drm/msm-next would let us un-break builds.
(And also start removing "select DEVFREQ_GOV_SIMPLE_ONDEMAND"s added in
various places to try to work around this issue.)

 include/linux/devfreq.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 4dc7cda4fd46..7fd704bb8f3d 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -273,8 +273,8 @@ void devm_devfreq_unregister_notifier(struct device *dev,
 struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
 struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 				const char *phandle_name, int index);
+#endif /* CONFIG_PM_DEVFREQ */
 
-#if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
  * struct devfreq_simple_ondemand_data - ``void *data`` fed to struct devfreq
  *	and devfreq_add_device
@@ -292,9 +292,7 @@ struct devfreq_simple_ondemand_data {
 	unsigned int upthreshold;
 	unsigned int downdifferential;
 };
-#endif
 
-#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
 enum devfreq_parent_dev_type {
 	DEVFREQ_PARENT_DEV,
 	CPUFREQ_PARENT_DEV,
@@ -337,9 +335,8 @@ struct devfreq_passive_data {
 	struct notifier_block nb;
 	struct list_head cpu_data_list;
 };
-#endif
 
-#else /* !CONFIG_PM_DEVFREQ */
+#if !defined(CONFIG_PM_DEVFREQ)
 static inline struct devfreq *devfreq_add_device(struct device *dev,
 					struct devfreq_dev_profile *profile,
 					const char *governor_name,
-- 
2.38.1

