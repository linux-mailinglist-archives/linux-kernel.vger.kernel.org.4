Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3765EDFA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjAEN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjAENz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441BA50052
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:53:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m18so90017420eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RMA+soBb7ISYDgZGukscenX9Gq6ESDTcYuOQgtCRPU=;
        b=TAPmw+y/LoYpb8ERNgeVU5ZMhp1Kwg8BHj2s0Y4AnMlt3Bc/0dOXyGT8zINdnQ9j0i
         NvbW19vYhExGrXXhLMNxY3AUU5G5Bb5Cmpsh8Y7LeALcZIAksx1LKuQkgkYWFwTz2wCf
         49Hp+W8zgpRvfHxLCNczX752pmUENDL/H0VfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RMA+soBb7ISYDgZGukscenX9Gq6ESDTcYuOQgtCRPU=;
        b=MESg1BEHmJlrbTe+QFeJybYwlnx8OTBXo2woIKtA0wAJ1VWBAFrx3cgCgTbzmsLox3
         DtIWZ9KOtxq34k5ulDMnT9B7vwQe9vnwDqpJKt11s2AUFjigUJ8Yawq+gh3L5oWJ+4hR
         pRfgBN247c5hKa5o7C8fKUaGQt6TzGarLCl4OA1dNp/HVYQclbQ4EtCfD8sqAyGfbKBd
         djmaNKVPWaA4mKY52ohDVW9iVkOHTNeplpZezaj8eFlFx78a/ygslbl5/1c4FWpoMYj5
         IbvkWtXTMCHrWVaHkOHTMZaJnlhfOdpLTXrz7jbq544tL3uL8rc2VOJz4K0/WkAKIO8z
         r3gg==
X-Gm-Message-State: AFqh2kq31t4ZYtWFvM7a/wGYyi5oaSQDIFzNnl43p8izK5Zh90fp+uiH
        0+fOSUxJMbTyCDF2jZgHq4nweg==
X-Google-Smtp-Source: AMrXdXsyYjuYxWDGZ8yq+j5dtkgQZmpKpDtKSS02rAx1JeeFm46IK193HbeiefW02MvKifEVlWzoMg==
X-Received: by 2002:a17:907:cb14:b0:849:ea61:511e with SMTP id um20-20020a170907cb1400b00849ea61511emr43083613ejc.44.1672926798876;
        Thu, 05 Jan 2023 05:53:18 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16459084ejy.127.2023.01.05.05.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:53:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 14:52:56 +0100
Subject: [PATCH v2 5/7] media: uvcvideo: Refactor
 power_line_frequency_controls_limited
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v2-5-2ba6c660d6f5@chromium.org>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=DwtzhBtzoWhod5MLtGXm+KQO/xP0T/ezlf1lPZGLRkA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjttZEDva4TTVOKcDo4v43+ndHUK9dLIrDPT8n8aMs
 sBoKU0yJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bWRAAKCRDRN9E+zzrEiFhqEA
 CNBJb3H3POfgL7x1Njja/ruBSNtRUZ63U4RjdkjqJdnXrhJf9IfvwW04yCfhEGxmJII79tyXeSbQ1k
 BQbO+u+voKO/yqHqMnPtxCdVI60r59UhgsuXlQO8ABYps2ve3vBXE46k4VAhfKaCyUvVQZOu4S9oRz
 IBFZJxh3p7zACo1I+/j6eme5T3QzL6j0vrHpOjhMYcCBk3tOBQpaSFkW7N0Aaqw5JKrwM4uctRYCEw
 wGFHfyMlxt4oqG/bA7Hsz0IB3YRaqSc5NWzAms1NDehNktfJ/gEM1f6TIHjvWQanzCigx5sARqYTzt
 OW9MLR5PtyMEIfqUrPEu7uP99XJuj1Wg4v0OcDa4burHjvwiO7ZY0uwh5RyAYlwveKnOwj+TXGwKEs
 XB6tbYJ+rKgN7317tJYMFuLwS02FqBFO/kDapEZXwqfcC43QlOeyAwjUc8BesWEOr7UucejoDpBe9o
 3EDb20tonKSP3cohDVPzNfJQZeB/Q8XTh7BK6A/utB7fFQACa6NZDhqsgf7Lf6ZJ0x3bXcigwPg+oA
 7JcNx90g58tJ0H12HDG6uyimozdPPPuoUtyKf2g67S10WQffIM9a4XvkDuRa/FNJrfaaZXGvJzmJv4
 UwpA3aBhYMazx29R75Nz8nGbOgpzl5hTz80yhnhwuRohHxLJ2mIBfKr6GD4A==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the control mapping to uvc_ctrl.c. This way we do not have
references to UVC controls or V4L2 controls in uvc_driver.c

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 13 +++++++++++++
 drivers/media/usb/uvc/uvc_driver.c | 18 ------------------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9af64f7a23d3..f559a1ac6e3c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -723,6 +723,19 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
+};
+
 static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
 	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
 	.entity		= UVC_GUID_UVC_PROCESSING,
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e659670ea2d8..37d2b08bc8b2 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2378,24 +2378,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
-static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
-	{ 1, "50 Hz" },
-	{ 2, "60 Hz" },
-};
-
-static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls_limited,
-	.menu_mask	=
-		GENMASK(ARRAY_SIZE(power_line_frequency_controls_limited) - 1, 0),
-};
-
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
 	.mappings = (const struct uvc_control_mapping *[]) {
 		&uvc_ctrl_power_line_mapping_limited,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a8eec43cd860..1b2d9f327583 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -747,6 +747,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
 void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
+extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
