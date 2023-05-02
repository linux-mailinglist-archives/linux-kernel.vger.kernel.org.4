Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A014D6F3F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjEBIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjEBIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:45:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B004EFE;
        Tue,  2 May 2023 01:45:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24e24b0193fso587708a91.2;
        Tue, 02 May 2023 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683017101; x=1685609101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcZ40MWQA/sGwhBagN40H0eAtoEJbkk8k3AmGaDhT2I=;
        b=WacQuyDm6AMnSVP/fc0mgO2v5BwCnq7jSJBTbBY1OVHLNvXz+6zsltHaRPdwq/DTEV
         p5UHYb004be+I7nVLG29Njq4VJxoj3TEwjKCEY2gUL++45Ds6iPmra8zPx0nuDd7ylRB
         9amTb2Uo+128b3Bnrze4tFY2D6JXXGuwSKEytW6iPRBHZqZqLOFlrBaqDayvm1c1zGEV
         kKsjF86WvuO79O3NX6cbGIqYTHZ0Odx7TUtsg49LXHhck8EHaL+n4DhKW1otE7645Vqx
         poEqn5tA5QQZcyCVoocCRuYUdlZlZfO1z+02rZgpiLD6MiJ/qi3o7DZ354J/at4N07ki
         w+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683017101; x=1685609101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcZ40MWQA/sGwhBagN40H0eAtoEJbkk8k3AmGaDhT2I=;
        b=L3KyumJsIGc++OIgJrcpPXU6XVq2Y0NytEWbTaDHIt53ZBUCSFDc4XbRL5DeUPbHCd
         9V84IBbnlomKNGRiWDAvpCoWz+fqvArK6NRzQ+JnlrsOKtWNJpQR2/D9ij2xAf6NZNTn
         OW5J8pyeulviGe1k4Z6bmuer7kaBGmNNmJXsQKi/wZeSRTtvIkgPVjLZHknuLwrSBQv3
         LM+5UWW8djqE222mIbkG10JSS2Feayj8aM7cKeO6GUlOj9K6v5sXJFj399Wu0xn6SFUQ
         QczMcuJbTHM1Gr/5rUWhiC/W7+nQtEWNdLpEg9hoB87UMbjj/iw8q5HrhAvu89rDDNQd
         Gbzg==
X-Gm-Message-State: AC+VfDyoQnwojuDhpMEQKdIAkRGGD+O+Iz+BckEMlsAzmRJyVsMM7gOt
        k44RlxXPstAc9rEHHkQ5cAQ=
X-Google-Smtp-Source: ACHHUZ7wiGMopCOJEt8+gDeuslrhBE260Jbk1ZporvCEzEw9R+3/l1i/BxnLdb1cPoZ7cTvG1lKimw==
X-Received: by 2002:a17:90a:ad94:b0:24e:1575:149 with SMTP id s20-20020a17090aad9400b0024e15750149mr3542235pjq.48.1683017100931;
        Tue, 02 May 2023 01:45:00 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a520a00b0023fcece8067sm7059039pjh.2.2023.05.02.01.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 01:45:00 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v12 4/7] media: v4l: Add HEXTILE compressed format
Date:   Tue,  2 May 2023 16:44:27 +0800
Message-Id: <20230502084430.234182-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502084430.234182-1-milkfafa@gmail.com>
References: <20230502084430.234182-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 58f6ae25b2e7..ac52485252d9 100644
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
index a858acea6547..b67a83e9dd65 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1506,6 +1506,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index aee75eb9e686..04aa5f808893 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -800,6 +800,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
 #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 #define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compressed */
 
 /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.34.1

