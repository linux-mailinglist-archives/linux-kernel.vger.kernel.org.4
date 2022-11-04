Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A510B618F32
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKDDjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKDDit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:38:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D79C0D;
        Thu,  3 Nov 2022 20:38:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2225277pjs.4;
        Thu, 03 Nov 2022 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTLUEyz86f0omThz6CvcZ5BTclh51H59iTgL5ZiQNn4=;
        b=ByPQtXsqQIx5ZYpazFrdOHFs0OFCPH0L+b81DwSDPD+isnGdvV3xSupNuDcy9K8Bgl
         sVT7iSe26DuT9KIKqAW1P+e2Pw/+c6smO46o3yuhWg40kO/tDAJEbhxmdw9iCfhet8QN
         g3uvPl6EUDSHKjowO7Io1lomxufEQiG1toYWH1pEymLuf+1fVXdCuhQq5nknSBe8mVKe
         rBGv5GtjqieA2v705iEIvZTyFgk4utg+9XC1QL5frT1UW9I2MWK4MQxOZ9eSAPA+FeFh
         RlTuWYZxT0/tPoaogDuW011vNHyaXDZQs650P+WOMg3GVQr6CuG8tPaCSyoiejD3cWWa
         mUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTLUEyz86f0omThz6CvcZ5BTclh51H59iTgL5ZiQNn4=;
        b=b+/7Zi7tJIHK1bzmcSdXCz38FCLq0Hma7/hrZICw2U0UXTPk/hkd6fsH91yScPR/s/
         e3/GUFbjYK9RwjFYZACOBVyIrmwGDSaUeeugoHb4U4Pc0TfLyJWW5899yPZ+UzRsQ+Sn
         YZW9zEK99dD/r0d6aGqMrFcFb0b4PjSaKSmC601UQ46AFaCyjQUOB6sn7+er9f2+q5iQ
         wS3a1eniQtvtCzW67SrRIrls84Ty1gvXdYRVS0jZJ/iJ6hkNrxs2j5J9B2lcPnv/D7ur
         +hDC6Tlt73C8dXVv+Grfn4u++jmmfExmkA8WUjawzo07wxyG+LwCiUv8d8lMqUyIJUhX
         qrSQ==
X-Gm-Message-State: ACrzQf0LJejuJ8qbFj3ysBcBY/S/2LsKQ94zO7Qykbd9SHxbrpsf0hTu
        lIUmnWrQCSLff5BbCrRL/dU=
X-Google-Smtp-Source: AMsMyM5wN4TZuGXTDyr433nntTpfgzqtVWMIPy8fD43HafqG1HYtBWAqR3XGAlQQSHK5fwo1kb6nEw==
X-Received: by 2002:a17:90a:520c:b0:212:d135:4471 with SMTP id v12-20020a17090a520c00b00212d1354471mr53048603pjh.71.1667533128091;
        Thu, 03 Nov 2022 20:38:48 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79d91000000b0056bb06ce1cfsm1545759pfq.97.2022.11.03.20.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:38:47 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v6 4/5] media: Add HEXTILE compressed format
Date:   Fri,  4 Nov 2022 11:38:09 +0800
Message-Id: <20221104033810.1324686-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104033810.1324686-1-milkfafa@gmail.com>
References: <20221104033810.1324686-1-milkfafa@gmail.com>
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

Add HEXTILE compressed format. This format is defined in Remote Framebuffer
Protocol (RFC 6143) and is used by Encoding Compression Engine present on
Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
 include/uapi/linux/videodev2.h                            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 0ff68cd8cf62..b45d8aa2e8b0 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -258,6 +258,13 @@ please make a proposal on the linux-media mailing list.
         and it is used by various multimedia hardware blocks like GPU, display
         controllers, ISP and video accelerators.
         It contains four planes for progressive video.
+    * .. _V4L2-PIX-FMT-HEXTILE:
+
+      - ``V4L2_PIX_FMT_HEXTILE``
+      - 'HXTL'
+      - Compressed format used by Nuvoton NPCM video driver. This format is
+        defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4 Hextile
+        Encoding).
 .. raw:: latex
 
     \normalsize
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index c314025d977e..bdbbba12f17c 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
 		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 01e630f2ec78..4241dd4a0bfa 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -776,6 +776,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
 #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
 #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compression */
 
 /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.34.1

