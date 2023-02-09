Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4569094D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBIMxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBIMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:53:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B5E387;
        Thu,  9 Feb 2023 04:53:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13so1344747wmr.4;
        Thu, 09 Feb 2023 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0h7PVwX7xOWVpu8EJbubLGeuc2859Qjp2vbcmTCnktc=;
        b=fbnHjjgQI3X7zo0eXFOg5iKisI9B4oh8x8/1bKMPzb8ZMzuB3Mj6Hzyc8BxBl2sThs
         BcZM8fyPY0WexE7gv/xmhq+ltHvewwaZNonHfp4NdDRRZDZfzHhSaqWMI7FmJ31mzSQ0
         3W724Yt0qFOA+KgHgrujZvpA0/U3vUMYzEmkYhqLsEXOdHW/Xj0kkVcPOs1/Bczf5ZX/
         5DC9wLJv5BvfP45faMQ+/jBHfeEdJNxiHLZMt7MP5CCxNzE25yiZ18Nxnl5AAzSkWtoM
         pVJnuIp8bI+8Diot6gTt1nbAUp6dLqsfkHyw2rHC7VsxcEJsd81YezxgnkdvsktZN68n
         081A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h7PVwX7xOWVpu8EJbubLGeuc2859Qjp2vbcmTCnktc=;
        b=JZsC/AacNYxwH8iL3oeAMoc+Dw1qwP9RHfparBbMhmm3llf1fPK4ssl2GMnrDbltv+
         m/Evzroz0M+bAN83cVab8Pdo8oXykZzdcS9TgZLWKBCClUTiDBAaT0nz6PUNfvQkfDOG
         kPgOuNvQSspghYM+9Zjg4QC4UM2FOPe/C+gLkUf3jKREnN9PxObb3A0CRoA52TZao034
         hv0TuCGQq4Jz3YbE/d3s3tD606tyRiGb7HVVz/10CJh3+GlaPu6bykvAAq+VLasgOFTO
         cJX6hykVGXao2a/xBimZrbPbKkZp+p5M4kES8bWpjPNqqYh1Pi5D5q1HMfYZiy4r8QAW
         ru6w==
X-Gm-Message-State: AO0yUKWdseBg6FRH01Q21zZ3Y7vY8zsU+1t1uAOxC9KJHoGnIjkM7Nul
        U19pbC1d6ZVLPahN5xCMJ5s=
X-Google-Smtp-Source: AK7set/e2dVQryskil9JvOXwCVkJylpvCnVrdI6FrmQzPl4/BLKQd9oGbNtLBKUjWNQWYnRrE1z8IQ==
X-Received: by 2002:a05:600c:164a:b0:3df:1673:90b6 with SMTP id o10-20020a05600c164a00b003df167390b6mr9442829wmn.39.1675947211990;
        Thu, 09 Feb 2023 04:53:31 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003e01493b136sm5128690wms.43.2023.02.09.04.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:53:31 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistakes of function name in error message
Date:   Thu,  9 Feb 2023 12:53:30 +0000
Message-Id: <20230209125330.1433481-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The function name is being reported as dc_link_contruct when it is
actually dc_link_construct_phy. Fix this by using %s and the __func__
for the function name.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 13a766273755..3fc93fc593fb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -452,7 +452,7 @@ static bool dc_link_construct_phy(struct dc_link *link,
 	link->psr_settings.psr_vtotal_control_support = false;
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
-	DC_LOG_DC("BIOS object table - dc_link_contruct finished successfully.\n");
+	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
 	return true;
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
@@ -469,7 +469,7 @@ static bool dc_link_construct_phy(struct dc_link *link,
 		link->hpd_gpio = NULL;
 	}
 
-	DC_LOG_DC("BIOS object table - dc_link_contruct failed.\n");
+	DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
 	return false;
 }
 
-- 
2.30.2

