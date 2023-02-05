Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742F68B064
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBEOyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBEOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:54:05 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A41CC14;
        Sun,  5 Feb 2023 06:54:04 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id s8so4505112pgg.11;
        Sun, 05 Feb 2023 06:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E/yBVrmcgMLnFa9p4JTH7UQJDllkHgNerevwocQnYI=;
        b=Y/sW9RQ6NnmHzLF1nOonVthPkLHSwWX1W/rI0+GMkuIbqApMKAsRqHRASrC2jZdZmL
         s2BaEGXhqpQz6imGdZkBUa2TXebuQE7FLC+JdRf2AZdqlFyZ5ElZXPq4KktdOtt6XQQm
         jcleQyVnrdVNb7CBePitrYNFMMuERyokS/IWo1GuyG1eUB/SvPCc7N6CGd97xbcclHbJ
         Lu45Pyf3R4SyBf2SnpWenMOhfbcuPYB3uJd/g+GnygOpItCQerZbmEqKzje49iBGbALD
         Iz6+91zzcnLR5zVl9/UXH5752wPHbPJKZJDtb+aXgHhs8k6J+Qmzhx/9EgPH+nsBYuqo
         PKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5E/yBVrmcgMLnFa9p4JTH7UQJDllkHgNerevwocQnYI=;
        b=s/KICevCf8sqkZkLNZXuhmilf3PW8Q9EKHyEu1eZAgS+wgq3nAWbqHeTam7omc/gOd
         URNg5Q2kBoRsWFZpLs4VcPuE8Q/mwOgbgAIhy7xNMN/q850n0k68GU61v7GjDg06PhZ8
         7jl5cJ8fNMqY/yQW/4NLIrW6UXZgHzFvUTTK9M6g0H6IyDNCwYoCTJMbQyoBQEQLfW4Q
         p7norj6lxjGZpMrByy3kcsUGfF3KhlIcp080LvNn8OH5rF05++UMwpZ6D8wegur6oyAj
         Lhu+fr1fqqD99BFVxtlX5rKvHa33QG2IOlcmIJDJ7/R/oLOzL3fv2pZw0P3izIZgQHdR
         lDtQ==
X-Gm-Message-State: AO0yUKUK1Ap7jXjaUGbvt99Rs8C49CSy9G/Gy6d4rSlLqEM8GsHpxjDx
        OvIhVoWPEWaK9clZYXRcT04C6H4Fz3tjAIM4kO2PpQ==
X-Google-Smtp-Source: AK7set+YqenHAV22Fxt9ez+uk6TSKJiwvPYdHpU0Z0Gp+tPrGoZvVp3YJgyZPBFwe9bTFPuW4G6+GA==
X-Received: by 2002:a62:1541:0:b0:590:70e0:c6a9 with SMTP id 62-20020a621541000000b0059070e0c6a9mr15422435pfv.32.1675608843474;
        Sun, 05 Feb 2023 06:54:03 -0800 (PST)
Received: from localhost.localdomain ([120.231.220.214])
        by smtp.gmail.com with ESMTPSA id h21-20020aa796d5000000b0056bb36c047asm5238126pfq.105.2023.02.05.06.54.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2023 06:54:03 -0800 (PST)
From:   Jianeng Chen <jianengchencool@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        Jianeng Chen <jianengchencool@gmail.com>
Subject: [PATCH] thermal/core: associate device tree node to thermal_cooling_device::device
Date:   Sun,  5 Feb 2023 22:52:25 +0800
Message-Id: <1675608745-2451-1-git-send-email-jianengchencool@gmail.com>
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

