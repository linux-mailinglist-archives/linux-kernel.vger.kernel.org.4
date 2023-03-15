Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787116BAB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjCOJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjCOJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:06:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610AE76174;
        Wed, 15 Mar 2023 02:05:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso1161332pjb.0;
        Wed, 15 Mar 2023 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678871124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugYL4TNtZvwrVkLduJBp9Mq9b8UJmnrNVU/4mmVcPg0=;
        b=RwYVOEKud4H6FfMOxVCyC7xeqK63iZXfuB7LiwcmKzNjZvLojhRlIgnoIK7pcdnv4G
         xt31v1sDDk1UqkRWo4OBlJGOQ6XemZAuHfsNZBOdTGsK8/BIIixccCm0KpsR1HbaSNo8
         zX/pljBKEo+XPpGyi1WY3UqFBzu5uCEDeDcMAYq1syaA8lA9cBDB3q6XAB91Df1lR+7H
         rPajgmAZ7uk5/KDCA1nQjWRUq/truKiAWCuX6OEBYY7L+vkzqTr8Jp5x11hz/0fm3gTK
         ucORaHf8rp4hyqSAxnztPqMQW4ilt8OrfVXDTBjf6qB2D+ZZ2Tcnln3NtdZcuttsUe+R
         37aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugYL4TNtZvwrVkLduJBp9Mq9b8UJmnrNVU/4mmVcPg0=;
        b=h2z4KjHLlTQ97/IbmQNlEOrwFcZ7hKLHMFpAslC5SQGamls8WilrHSEOmPgq0YP/Kj
         IaQs8N3389R0/xR/DPz7vt3HURaiZZtx95k6GYERt1febuzbtfNVkxCsIdmK3VEkY5g5
         ekbNbOKN2Gcgh0UfTGZJdZF/81pzaA8/Er3TN/VweJNmW/boPnw2dBxCyNenp6T2LWig
         p+qSdG4E8VsU0IMnD3dpIPH5Ud4GtjiXPA8CgyIb89oWpad29eta7+8YPTWxN8fKiMht
         9vBxWB4106ohAY0TO/nmoBLtVe3iVolfK3UdkzQOHopZfhLNGLdhH51mTB6e25QknsO+
         9mHg==
X-Gm-Message-State: AO0yUKXh50tweZrdoZ27ymk6pwRHKVEIxopS8t0btb4vPnacJbh92mKv
        V6ceYYd04L6h161KIhy/9tk=
X-Google-Smtp-Source: AK7set9XMoP5ypO0me4udx1ZPpoo3BETNGUFYvDOvil4trx5wm/3hqbffm4zvy4f71yn3y7FbxpyaQ==
X-Received: by 2002:a05:6a20:4b0f:b0:d3:5c72:8fb4 with SMTP id fp15-20020a056a204b0f00b000d35c728fb4mr11757239pzb.60.1678871124369;
        Wed, 15 Mar 2023 02:05:24 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b005d6999eec90sm3006884pfh.120.2023.03.15.02.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 02:05:23 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     dilinger@queued.net
Cc:     deller@gmx.de, linux-geode@lists.infradead.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] fbdev: lxfb: Fix potential divide by zero
Date:   Wed, 15 Mar 2023 09:05:18 +0000
Message-Id: <20230315090518.1037674-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

var->pixclock can be assigned to zero by user. Without proper
check, divide by zero would occur in lx_set_clock.

Error out if var->pixclock is zero.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/video/fbdev/geode/lxfb_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/geode/lxfb_core.c b/drivers/video/fbdev/geode/lxfb_core.c
index 8130e9eee2b4..556d8b1a9e06 100644
--- a/drivers/video/fbdev/geode/lxfb_core.c
+++ b/drivers/video/fbdev/geode/lxfb_core.c
@@ -235,6 +235,9 @@ static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
 
 static int lxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (var->xres > 1920 || var->yres > 1440)
 		return -EINVAL;
 
-- 
2.25.1

