Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1B5FF95E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJOJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJOJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:11:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F3B43E69;
        Sat, 15 Oct 2022 02:11:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so10924764wrh.5;
        Sat, 15 Oct 2022 02:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwDRWhuz0BJiGbbs2x32oEMpmFQowI9FSHz7BYExUko=;
        b=Z2pFUW9dxgGpgVvDLQ91sUAFj0Fjn5R5THehqsw5y5SS4v0X0YQCvHxrA9IPpoEKGf
         T0+dvfZ0dXvlHKwA+Ip6HLFT0KXmS5cuOX2R7pYLrlagRyBJHUBNAp1sIGg72xyqoLHW
         yW42g01BBqlT7VSJFK1hYNcq10ED1GrmkxBaZHn6QXY9fpXo0t1yMc8UjhPD4pBCHzNH
         +9izQswZ+G7fOSJa19LQIL25JRht0rzrCmkxBYltWp0bcIIBsItYXCw9D69/tq+pffoO
         AdrHhSlk1Pl9rDDxuMVf0rtm4IEVGaXlX0hMYMCLR8wXSomPyTwKgS+4IZxWrXnv+PFl
         2GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwDRWhuz0BJiGbbs2x32oEMpmFQowI9FSHz7BYExUko=;
        b=JyZfs4kQCf3B26O4dmbjA1PPAJTjzlvImw8voCOVHpeRKxvXv5cO0OhF7LkuQHbbzF
         P1Ycph2Jw7m7W7Ee3e6Y+15t6Fxw4gHzNdEukrPcaCFoUU95xJugJVNZCYav3GKT9bQE
         mdaZz2JnJuJsN3e2oGGrarfGQoIwZJzyF4JwkjubvCJH6MQ2toHXipFzMBsMqW3uhNih
         n+rnNjh3RPT0CBRe+C9IVGiiVBqHlB5B9fXzfZ9Oe4/CmXpV8yoxlf3RoZF7tiZ4hqBS
         f9bTyDsGliE0hF8pvEaHXBxlEP1Ft4+aKTjNP9nCzoXNHC14CWK5qo1i53OH4SVxEZF0
         pNZw==
X-Gm-Message-State: ACrzQf1bh5zJxKlxhOZloiNA0AO9oN8CExK7suHfqyk0mX/IsYRpHlW+
        srXT3aLAWgAtbBT3pNPHJxtQJ9DkdECQKLap
X-Google-Smtp-Source: AMsMyM5yULnmMcL+iMQqj8+o77+Nw3b7C6GhWEW9N+62pZMZMpXz47/N7y1Am5DylvT8w5/bceeDlA==
X-Received: by 2002:a05:6000:144c:b0:230:816f:3167 with SMTP id v12-20020a056000144c00b00230816f3167mr1005565wrx.532.1665825069896;
        Sat, 15 Oct 2022 02:11:09 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003b435c41103sm11219552wmb.0.2022.10.15.02.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 02:11:09 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     ezequiel@vanguardiasur.com.ar, benjamin.gaignard@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: Unify YCbCr/YUV terms in format descriptions
Date:   Sat, 15 Oct 2022 11:11:05 +0200
Message-Id: <20221015091105.2472706-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Format descriptions use YCbCr and YUV terms interchangeably. Let's unify
them so they all use YUV. While YCbCr is actually correct term here, YUV
is shorter and thus it also fixes too long description of P010 tiled
format.

Fixes: 3c8e19d3d3f9 ("media: Add P010 tiled format")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 34 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e6fd355a2e92..de83714f0d40 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1347,23 +1347,23 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
-	case V4L2_PIX_FMT_NV12:		descr = "Y/CbCr 4:2:0"; break;
-	case V4L2_PIX_FMT_NV21:		descr = "Y/CrCb 4:2:0"; break;
-	case V4L2_PIX_FMT_NV16:		descr = "Y/CbCr 4:2:2"; break;
-	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
-	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
-	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
-	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; break;
-	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
-	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
-	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
-	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/CbCr 4:2:0 (4x4 Linear)"; break;
-	case V4L2_PIX_FMT_NV12M:	descr = "Y/CbCr 4:2:0 (N-C)"; break;
-	case V4L2_PIX_FMT_NV21M:	descr = "Y/CrCb 4:2:0 (N-C)"; break;
-	case V4L2_PIX_FMT_NV16M:	descr = "Y/CbCr 4:2:2 (N-C)"; break;
-	case V4L2_PIX_FMT_NV61M:	descr = "Y/CrCb 4:2:2 (N-C)"; break;
-	case V4L2_PIX_FMT_NV12MT:	descr = "Y/CbCr 4:2:0 (64x32 MB, N-C)"; break;
-	case V4L2_PIX_FMT_NV12MT_16X16:	descr = "Y/CbCr 4:2:0 (16x16 MB, N-C)"; break;
+	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
+	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
+	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
+	case V4L2_PIX_FMT_NV61:		descr = "Y/VU 4:2:2"; break;
+	case V4L2_PIX_FMT_NV24:		descr = "Y/UV 4:4:4"; break;
+	case V4L2_PIX_FMT_NV42:		descr = "Y/VU 4:4:4"; break;
+	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/UV 4:2:0"; break;
+	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
+	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
+	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
+	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/UV 4:2:0 (4x4 Linear)"; break;
+	case V4L2_PIX_FMT_NV12M:	descr = "Y/UV 4:2:0 (N-C)"; break;
+	case V4L2_PIX_FMT_NV21M:	descr = "Y/VU 4:2:0 (N-C)"; break;
+	case V4L2_PIX_FMT_NV16M:	descr = "Y/UV 4:2:2 (N-C)"; break;
+	case V4L2_PIX_FMT_NV61M:	descr = "Y/VU 4:2:2 (N-C)"; break;
+	case V4L2_PIX_FMT_NV12MT:	descr = "Y/UV 4:2:0 (64x32 MB, N-C)"; break;
+	case V4L2_PIX_FMT_NV12MT_16X16:	descr = "Y/UV 4:2:0 (16x16 MB, N-C)"; break;
 	case V4L2_PIX_FMT_YUV420M:	descr = "Planar YUV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YVU420M:	descr = "Planar YVU 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV422M:	descr = "Planar YUV 4:2:2 (N-C)"; break;
-- 
2.38.0

