Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE266B36B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCJGjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:39:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7081A7F037
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 22:39:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso4929603ybi.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 22:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678430360;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uLEOf97Xcxe+idb9j43TbpyCGCu1DdozmCjBlybGEn0=;
        b=GtwM2EdlA4ehep+DcS/mVf6iahVW5PU5kUGpRLeTDCFwmGAks1UukIZrkwmitMR5N4
         pHiLMiddhHaSMUxCa1oQp+jL/D5xiCMRzK29mS7Hf2zx0Q9DVyeu4052Kxn2aZy/Jxb7
         HpxdE2h5krayCuAkvEUPqs8FkPQgJsClGEuaH1WZrZiRmnQtjgCBFVOhOS0r0gCImDud
         g90ZQyRH/SgbAtZEmnpbslZ1JhC/ZejHmroLF7KBbp+TB2pYWmZc/yOytpP29klk0TTv
         yu5PZCuhA2U2hqrey+ljUPwPr9p/qQjGMKh06LLZyuM8PCKe4BaL4oUuAtABOOQB2ari
         ed5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678430360;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLEOf97Xcxe+idb9j43TbpyCGCu1DdozmCjBlybGEn0=;
        b=gqEfV9mQX6TOu1z57IF2PqoRH7jCejy7+ECGLMCT8exCODNbgLuyHwmeF4vitkKCNg
         8wYqgda+odSdhPbVbOFEF5DradedOt02OS6skQXx4xPaij/ryr6JMMI+vuQzj6TewOKp
         IXsV7HOf5C16WfnL4x/n7FcZD+POaJxyyCdQCAVITz0XIlFL5eN4lCcWqHXEAL8hdA8E
         Cy9AH60Tb22Lw1WY66MU304av8bThpOz/3DaddH1t5FQgv5zUkVa6PiaN/4Z5qBevjOj
         UntI4Na8SUrO9MTxFLg8zOaf6hcUb9Ivyq89zixPtOJi2Hvyta3yVBIUVXAZtFFFQH22
         Bcow==
X-Gm-Message-State: AO0yUKXDxBZi2WZYWuiwNbWxlJB0OcJaKD67vSLv5FSNWcK3pe8PQVbw
        RtZoWAMxBDhL+1VVVGleH1KonBh5QtuYzLo=
X-Google-Smtp-Source: AK7set9lWWd7FEtVovPBRfs0EtlhKEus2Tr4Xst+bTDGT+Xv+XGL3GsmSkvhgntdlqkdKL+5PbCof7F4V3L0z7g=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:1274:2857:8749:6af3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:151:b0:afa:d8b5:8e82 with SMTP
 id p17-20020a056902015100b00afad8b58e82mr12849163ybh.6.1678430360695; Thu, 09
 Mar 2023 22:39:20 -0800 (PST)
Date:   Thu,  9 Mar 2023 22:39:09 -0800
Message-Id: <20230310063910.2474472-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1] drm/mipi-dsi: Set the fwnode for mipi_dsi_device
From:   Saravana Kannan <saravanak@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
detection more robust"), fw_devlink prints an error when consumer
devices don't have their fwnode set. This used to be ignored silently.

Set the fwnode mipi_dsi_device so fw_devlink can find them and properly
track their dependencies.

This fixes errors like this:
[    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device link with regulator-lcd-1v8
[    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device link with backlight-dsi

Reported-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Link: https://lore.kernel.org/lkml/2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm/
Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index b41aaf2bb9f1..7923cc21b78e 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 		return dsi;
 	}
 
-	dsi->dev.of_node = info->node;
+	device_set_node(&dsi->dev, of_fwnode_handle(info->node));
 	dsi->channel = info->channel;
 	strlcpy(dsi->name, info->type, sizeof(dsi->name));
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

