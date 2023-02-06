Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB92768C004
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjBFO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBFO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:27:04 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240E18B;
        Mon,  6 Feb 2023 06:27:03 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v23so12286246plo.1;
        Mon, 06 Feb 2023 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E/yBVrmcgMLnFa9p4JTH7UQJDllkHgNerevwocQnYI=;
        b=XlcKu2wj65FASwrngaqudueyAfjPWj8YP+8LNpJkXxQF5jmxxUSrD8U+7kmgTsv6Ov
         SwlR5mq1qsA23yyOzjI9LnzIOPPwcA9MJXP3/Ek1kxYNdH3Qs1hYo0v+hKjTutX6deDb
         y4Ww4AdwkOfS7Co4VZRtD+GaR8Yrj2OaNfzM0q+W4P39v70ROdg01pOUk1q4aADQNL4o
         UWXelqrAscWTKS04I2gMKWrbMy0a3VozbXHtanf3Gr97zVlSf7qspThenM8x1S3Hi4r1
         nR4gIx8OW/DDAq5rkkfiUfFAEWlCbf2huw1PHrcDbMmY84tliMP8yxDmXeljErhx22Pi
         OSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5E/yBVrmcgMLnFa9p4JTH7UQJDllkHgNerevwocQnYI=;
        b=7OR7RAeV3s1sclnjaBMz+GW2DatCQ34jUpCHWt3Qf95oyI67duVpfQyu4iDj/NeYGa
         WQzmJCkX0VVBy+vFvbISYo/ITuE1tgQCf/Mc0aaPXDdtKNQoNSaMtzqHgxZnLOqJBPYA
         ew97gMwBxDLezbjEhT8X1F4wqFVjLi3XNmY6cjmgj/0hkiloycmZl/Bwa4C2iPIbrWxy
         0HY3TNSqe3BDqx8pwTOi2QdaseZUfi3P7QPUAbLq6hz5mXXIiDHK0asyWUV2vy/MnqO3
         7n8+151T/RYyY+BwK2tALoyHmL8kW10sjTkIV7vUG68JLY1FkUMXBh4btSF1GD7OyPPi
         jECg==
X-Gm-Message-State: AO0yUKXnKQ5cuVbt+qiFpLeFF+RgwkHCt3gsc2NdjBbjnAx9ygjXJu+p
        9wiKHwGyKVfmUc1ME/4v80w=
X-Google-Smtp-Source: AK7set9CHU8jc8CVb+IPNa080M3J1zKDmZJZyg+dShe+AvL4pcdK3hlvzGxC5bMEqMOvjKtECc8xGg==
X-Received: by 2002:a17:90b:3a8e:b0:219:9da5:40d3 with SMTP id om14-20020a17090b3a8e00b002199da540d3mr21173681pjb.1.1675693622988;
        Mon, 06 Feb 2023 06:27:02 -0800 (PST)
Received: from localhost.localdomain ([120.231.220.214])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090a73c300b0022bffc59164sm6375319pjk.17.2023.02.06.06.27.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:27:02 -0800 (PST)
From:   Jianeng Chen <jianengchencool@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianeng Chen <jianengchencool@gmail.com>
Subject: [PATCH] thermal/core: associate device tree node to thermal_cooling_device::device
Date:   Mon,  6 Feb 2023 22:26:17 +0800
Message-Id: <1675693577-2575-1-git-send-email-jianengchencool@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a gpio property to a cooling device node in device tree, then in
thermal driver called gpiod_get(struct device *) to request this gpio will
fail, indicate cannot find gpio in device tree, because the of node do not
associate to struct device.

Signed-off-by: Jianeng Chen <jianengchencool@gmail.com>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0675df5..4d77d8b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -905,6 +905,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = thermal_class;
+	cdev->device.of_node = np;
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
-- 
2.7.4

