Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F7673B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjASOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:04:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9826B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:04:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k16so1624371wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GC/mI6lQCD2v+9Dq5VgRk4R+zYjXPgjV01+G3TFhd9g=;
        b=XtK71Opt18vNIARTivzkJYj2xOJEeq/DrEEoTVl6Za7cfOLg3bma08hATH9TDvqnIc
         upybtOXxL6DwFWG+no4XduzSAeo4eUPKO2YgdpjBqA/tCjMVKMCqc8gsLuu1oWWarnxs
         zl6QA5XxQNB6YAn92JHG2ZwkfvLN2Up6SF4yXa/tOCr65ZB2Y4WLDch/AaVo3mWz0zGR
         chrKM6Nqmx+k8yWtlPtkgHq3nZMKIoOOSA3GgLeuoOLK+PV6pnF1nEPnE99sVumOdTfE
         lvNZc+OkFvRtOf1gCCM4NwIIAKtHdBCizFv7iMoMQCSeBf2WZH49T8jLBxVUmgHkw2Wc
         usDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GC/mI6lQCD2v+9Dq5VgRk4R+zYjXPgjV01+G3TFhd9g=;
        b=vum/RbuHr/id5BwAy3m2BP26dN8cXPoV1K/XVwDCvFwfk5/LrWtFU+TipKpeGreXt3
         sRyMVdj3aMgJl/M+VDqQpJpHJ6G78pEYbGj6LrLH5a1QctZMuOsU5avdViMNC+EKsv9E
         O+FJlDUp9DWjw1uadteHrHuDQrK6M6Ndjn2hMJfqZSfp0jUyk9A1QsOwo69bc72z1D//
         BG/xNDDStEZTpWeXfsfKMZuHyyvyZWlveojQEft19vd6kQag3o0/nw7bDPdvEJk0wdje
         LEaAXoglSWGMgI04CbYqEpeIqgCvaX+v0E4KgSz0gZZJ6iE9W3vF927WjZ8ZfqzYZAPc
         oKYg==
X-Gm-Message-State: AFqh2kprWtigM9m4N3QRZ1BV0KkYdVmRxU4ukBMg6B7hoWVCg0/y9j4e
        itlSjYCw54SQ7xOjxi3AnIQlIA==
X-Google-Smtp-Source: AMrXdXuWis8blSafsPb72kBGK3EbYI5GmdrOkUP0B97wcEjYaSB4sVVMVS1V6QZNDRtHZ5oo+R8xxQ==
X-Received: by 2002:a05:600c:2255:b0:3da:f950:8168 with SMTP id a21-20020a05600c225500b003daf9508168mr9983502wmm.35.1674137055705;
        Thu, 19 Jan 2023 06:04:15 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id az9-20020a05600c600900b003b3307fb98fsm5273206wmb.24.2023.01.19.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:04:15 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 19 Jan 2023 15:04:12 +0100
Subject: [PATCH] drm/panel: vtdr6130: fix unused ret in
 visionox_vtdr6130_bl_update_status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230119-topic-sm8550-vtdr6130-fixup-v1-1-82c4fb008138@linaro.org>
X-B4-Tracking: v=1; b=H4sIANxNyWMC/x2NQQqDMBBFryKz7kASSdBepXSRxEkdsDEkKoJ49
 w5dvsfn/QsaVaYGz+6CSgc3XrOAfnQQZ58/hDwJg1GmV1qPuK2FI7bvYK3CY5uq073CxOdeMAVj
 kxtc8HYEKQTfCEP1Oc7SyPuyiCyVZP2/fL3v+wcSkV3rggAAAA==
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Richard Acayan <mailingradian@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel test robot <lkp@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:
panel-visionox-vtdr6130.c:249:12: warning: 'ret' is used uninitialized [-Wuninitialized]

Fixes: 9402cde9347e ("drm/panel: vtdr6130: Use 16-bit brightness function")
Reported-by: Daniel Vetter <daniel@ffwll.ch>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index 1092075b31a5..bb0dfd86ea67 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -243,13 +243,8 @@ static int visionox_vtdr6130_bl_update_status(struct backlight_device *bl)
 {
 	struct mipi_dsi_device *dsi = bl_get_data(bl);
 	u16 brightness = backlight_get_brightness(bl);
-	int ret;
 
-	mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 }
 
 static const struct backlight_ops visionox_vtdr6130_bl_ops = {

---
base-commit: 43bde505d66a41c2ad706d603e97b2c8aa2fbe4a
change-id: 20230119-topic-sm8550-vtdr6130-fixup-fb25f686ba59

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
