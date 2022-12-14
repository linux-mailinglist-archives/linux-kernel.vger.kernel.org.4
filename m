Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233164C5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiLNJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237752AbiLNJ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:27:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A6F1D648;
        Wed, 14 Dec 2022 01:27:34 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 82so1615104pgc.0;
        Wed, 14 Dec 2022 01:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/uLvTJmmBzuds9Az0fvihrnUknv2MS6FQWlRinADjY=;
        b=Xc7Aw+e3WI6qp/eJxVFeHPJhPyxAmfIvPUnKDh5B15XKFHr0Pfq4efdEqjCMJT0gPL
         UA9KG3U5S7MVLlvwHlpT1LvnKMkRV57gq6i3WFULyjbqp9mPb/Cf3kSbNObOnOLDESgh
         hQVe5rBJUST+ttJnd6LGy8yUVoGUHiyewoDHGsO8GpSBIK70JnnmwKJrHr+eK6vu74hI
         wH/Gl/O1v0x6VkEn7eqCmbNuizi2QQVWLuEYOkgSQfRU4umTecoIx4aejaHSwLTmp/Pn
         FXaHqpX7hcS+ywx7kAVbSN0rABFE6P8UbeKCon8iix3BVpFYhtQUo/aB1qW0VXHPsZQb
         PBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/uLvTJmmBzuds9Az0fvihrnUknv2MS6FQWlRinADjY=;
        b=dhx5YUE9P2WwBs2rJ7p4IlWqIiUJbwksRbOoPWJ02LGWo2edy1prXBmb82s4orlo8R
         17ugSteq2HHMuiapPvT75sCYRjMZW84Wkl8F9LeAQ2OlSV41lLl3YK1mmZ1iih/5xGB2
         YvyXt6qjrn+8Q6Gi1bzk+dN0I+rXBDcuBI0qhHwv9X2nW16NvDs6Dt5Exb/LdZZ+I1XE
         l6afeZYQW7dfgoPal2OxWrXS0s+JlvwR2NfA+P99tqQJN6rvWl04rlEKWedbl1vkYEml
         vTdcFSSxmzIUqvmqYMumGu+WN8VA+j4YU6vQEAYvX88myrb3p9uFnQJR+Q+5qSpaUjmf
         xQYg==
X-Gm-Message-State: ANoB5pk1yFI7E8hlsifqLJ1r7gs0p9fYw0rjwoKHVursNxvwXl1h89CB
        HccHKDC09JdwtZGm08JOB/o=
X-Google-Smtp-Source: AA0mqf4v0xkpJREBw5ozMubrsIyFRAves3U8tUVkd0+5EMAmKWDlHBDmxuW+XcG7VAlZ0w+3ZlgF4w==
X-Received: by 2002:a62:870d:0:b0:576:f02e:d0ef with SMTP id i13-20020a62870d000000b00576f02ed0efmr22903084pfe.4.1671010054037;
        Wed, 14 Dec 2022 01:27:34 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t123-20020a628181000000b00576145a9bd0sm9003312pfd.127.2022.12.14.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:27:33 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v8 4/7] media: v4l: Add HEXTILE compressed format
Date:   Wed, 14 Dec 2022 17:26:33 +0800
Message-Id: <20221214092636.810883-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214092636.810883-1-milkfafa@gmail.com>
References: <20221214092636.810883-1-milkfafa@gmail.com>
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

Add HEXTILE compressed format which is defined in Remote Framebuffer
Protocol (RFC 6143, chapter 7.7.4 Hextile Encoding) and is used by
Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
 include/uapi/linux/videodev2.h                            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 73cd99828010..e6ee0eebe691 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -275,6 +275,13 @@ please make a proposal on the linux-media mailing list.
 
         Decoder's implementation can be found here,
         `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
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
index 8e0a0ff62a70..a0e387335139 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1494,6 +1494,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1befd181a4cc..1ce21cc4fbf1 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -778,6 +778,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
 #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 #define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compressed */
 
 /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.34.1

