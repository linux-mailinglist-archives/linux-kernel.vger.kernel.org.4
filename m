Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646F672A15
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjARVMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjARVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:12:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76E611EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:11:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g10so130171wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv1QMfQ8+R0tx+YAwMOp8de+sCeOb8qyTorZfg+2pN8=;
        b=k3WuuZ1FdgzBGZGuHPHyrzGbvPMvuhO1xbq16DV12VumlZUanpXElBkLHbk1HgCpb4
         aFrLqQWwlzFyRm+M+Qx/60pZpfyzcU0Y4FXOUMT69WH+Zyfmy7JzETS8/6KQjLjMjya4
         XZAIpvHFciPB4c64lEGldGgwAGcTX+/fOYWm/dljxxi85sIixRnIOqPsG3WrcOOoVR8+
         b1kZyGVe0UQszOg9JNtyyJl3bjU0T9gvIlH8mHfrQxrbVtqUvo9/n8AbRRFS2AM7VrIG
         SvDBw4S1ziev2Ikm8/45YhUS3pVxs/mjU/97pm22BoPfUgpOqpbEq4t/Dct6t3aM5ncu
         i0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv1QMfQ8+R0tx+YAwMOp8de+sCeOb8qyTorZfg+2pN8=;
        b=SzBSY5GCtDPIQ0knD6geDsgYA+up+H/p0bIItXg6PI46pG00MNzn4b2mmSad4qEs6U
         k6qBj4VX+kU3Atohnk9UxsRrPv/Ietfc0/tH1EC6KKDxDAeneZI84H3MuujyqNbTM0YA
         LYkOtgU/owHV5w/Q0cBDBNYcJFIrCmkz2I/8MBXB+0oDN9BxqBfhGjoIMGM+RdBBi1YO
         v2NI+cSWRs7FsHmZDF72Flels+cZ7AknQe8h8dzptGTNWoBdysQB8RAyhx2ZsiM98EK8
         feryTk7aOgGkXLFBpYpt+CUoKxQ/mNdlISj5BwIqHK9EI3/YFfJmLp7slcAx/a4qtOJz
         nEEg==
X-Gm-Message-State: AFqh2krHEQ+JIcgWHJ7oK0mp9d08omRo6iNYPSqypaR9WY3BKOyCm3SL
        BnSmziP4CmXcbjdZ5+t9rUDqOA==
X-Google-Smtp-Source: AMrXdXsEvlgbTfqcuT8KLgSDAeX2MN7ugFlNao+aYYexAw78OZuOQXHneHaCwyZiAyaTwhPm0eA5AA==
X-Received: by 2002:a05:600c:4f8d:b0:3d3:3d1b:6354 with SMTP id n13-20020a05600c4f8d00b003d33d1b6354mr4129660wmq.3.1674076293181;
        Wed, 18 Jan 2023 13:11:33 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003d99da8d30asm3198835wmc.46.2023.01.18.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:11:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Date:   Wed, 18 Jan 2023 22:11:21 +0100
Message-Id: <20230118211123.111493-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118211123.111493-1-daniel.lezcano@linaro.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the thermal framework fails to initialize, the mutex can be used by
the different functions registering a thermal zone anyway. We should
not destroy the mutexes as other components may use them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fad0c4a07d16..ea78c93277be 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1602,7 +1602,7 @@ static int __init thermal_init(void)
 
 	result = thermal_netlink_init();
 	if (result)
-		goto error;
+		return result;
 
 	result = thermal_register_governors();
 	if (result)
@@ -1623,9 +1623,7 @@ static int __init thermal_init(void)
 	thermal_unregister_governors();
 unregister_netlink:
 	thermal_netlink_exit();
-error:
-	mutex_destroy(&thermal_list_lock);
-	mutex_destroy(&thermal_governor_lock);
+
 	return result;
 }
 postcore_initcall(thermal_init);
-- 
2.34.1

