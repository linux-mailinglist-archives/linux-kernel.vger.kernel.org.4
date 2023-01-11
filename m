Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFF66568C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjAKIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjAKIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:52:50 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C371054A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so11171509plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymU4BRjSxrJhQL9DkjeeGrHUVG3DM8ZWjHKpQC1Y2Y0=;
        b=bFcukNq+D/b3ltetYdCgFtoSvKiJroUkbRgkIw6ahhoIUwyeqiIpCEPsBLopzwgmkf
         0sD9QkBsFBrRFK7O637OjsIkdD34SrPuukjHJ1d0WtulZHAparow0YX+6Zi9GkvzvxPU
         mq7h8rpMSHOHEJmaI6xG4uqx4JIRnwaQSEKuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymU4BRjSxrJhQL9DkjeeGrHUVG3DM8ZWjHKpQC1Y2Y0=;
        b=yzvzX7m6ILONddpvoiBfBeJax4M27TvBJIv1OaaR1vAVUCeh4D9p+fOKEfE44dPjrS
         48+eole849KVIJHKck4Oxa8vnc7mQ7EHgrWcNhnVyRC7+d2Am0gJxrmGe4dbvWZZKgnx
         Xfiq8upZIs+4FgN8x7WuFjXwadb/QKkGEMCi22PjlLPUIJNZHw8ZWPqjCBotYkV/R3ya
         C5UnKi3nxCrcmyRR/+jVRvoCK1H8dXOFlnGS1l2VT23URT04O/Efw8bDZJ7siNGUq/Gf
         SC/tlRIu7c1pN+byeaX4e3Qs48PhTLWn8YDMGoD7UMNDcr24vdsOqplulZSaV2drkJ2R
         KV5w==
X-Gm-Message-State: AFqh2krSnkyaN0P5nTi/Up4+mMFJ4gIIVuZINAX8ArcKjYX2h6VL1H7I
        Ch7Xyr/N6EksUNCS713wsGcYMQ==
X-Google-Smtp-Source: AMrXdXsB6chUTybxsqhARKcbbZSOOrjGaMSYW18Y/R/jRnRuuEqa9fVyErkuiLO6kJDtPe7UGXjpXQ==
X-Received: by 2002:a17:902:ba93:b0:191:282:5d72 with SMTP id k19-20020a170902ba9300b0019102825d72mr1496801pls.51.1673427166313;
        Wed, 11 Jan 2023 00:52:46 -0800 (PST)
Received: from yunkec1.tok.corp.google.com ([2401:fa00:8f:203:c84:581:fd3a:b32b])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm9566612plb.22.2023.01.11.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:52:46 -0800 (PST)
From:   Yunke Cao <yunkec@chromium.org>
Date:   Wed, 11 Jan 2023 17:52:39 +0900
Subject: [PATCH RFC 2/3] media: uvcvideo: remove entity privacy control in the uvc
 video node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230111-uvc_privacy_subdev-v1-2-f859ac9a01e3@chromium.org>
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
In-Reply-To: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Yunke Cao <yunkec@chromium.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-4d321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For privacy_gpio, do not expose V4L2_CID_PRIVACY to userspace as a control
of the video node.

Signed-off-by: Yunke Cao <yunkec@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index c95a2229f4fa..77c5ff19add8 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -348,14 +348,6 @@ static const struct uvc_control_info uvc_ctrls[] = {
 				| UVC_CTRL_FLAG_RESTORE
 				| UVC_CTRL_FLAG_AUTO_UPDATE,
 	},
-	{
-		.entity		= UVC_GUID_EXT_GPIO_CONTROLLER,
-		.selector	= UVC_CT_PRIVACY_CONTROL,
-		.index		= 0,
-		.size		= 1,
-		.flags		= UVC_CTRL_FLAG_GET_CUR
-				| UVC_CTRL_FLAG_AUTO_UPDATE,
-	},
 };
 
 static const u32 uvc_control_classes[] = {
@@ -710,15 +702,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
 		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
 	},
-	{
-		.id		= V4L2_CID_PRIVACY,
-		.entity		= UVC_GUID_EXT_GPIO_CONTROLLER,
-		.selector	= UVC_CT_PRIVACY_CONTROL,
-		.size		= 1,
-		.offset		= 0,
-		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
-		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
-	},
 };
 
 static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {

-- 
b4 0.11.0-dev-4d321
