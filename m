Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D07743DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjF3Okj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjF3Oka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:40:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4653AAD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso3292461e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1688136025; x=1690728025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v3MtXxbIi9CkWhq0qdzoruMHr5eKjgstWlIhBmdOPg=;
        b=Y+fs485ZRswLUAJU3sgZvDsMrlqFIlnbx4zfJCKttLjFDY1pqMFhpKFJwU4dqh1JRl
         QlfmSEN8KRL5GJyLcWBxyd1mD1Cy96k2RA7AnPoY0piwC6kSzZoJmgAR40gLSjy6z6DA
         k/rQgeY6DrBwu+QFx/NywdREEMUSeGQFqxf6tj3aJyguvyt9yqbtCa0TGTLQ+fz1nXk9
         IMpDB/lRypHBpk6iPpyrXzA/N3DGovO9ov2c0K7DEl9u4eJemZxaIfDorp9dYS23U5iU
         TZmRqwf61HRXjqc4T5o3cPFVQRQ8Y7X3gvMyhRE7/TO7ut+VnhQEeHrN/FHrK1Cxx8Hz
         lOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136025; x=1690728025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v3MtXxbIi9CkWhq0qdzoruMHr5eKjgstWlIhBmdOPg=;
        b=QaAvcc/qlgk5VJ0GVS18un3ZjnnGQX6P3W1ikmUQBS3/DG61kPKWz7KH7bR5ImSwsW
         /EBlyV8uAs3FXy07Ne+Vybjx0bmQg6l2TtviOp/d4jcH/x8kT+LMb17anj6az4ViWbpp
         rNTQ2IDocJ47rtq+a1v4+bL4gJHc6EbN7GhSO351c7ilwY++CSEyF3eBaJYE6QXTOQVP
         qcgVhObwBRJo/tDwZ/2wzhaOVjlZQnf6Xla7+jb3uxsnV4TpiPuZB+93dTQtANpAmW0j
         qV9q3l+fdnzYzSasPZw6wtnnOV4gs5UO+aqIxjqvQvefXGKo+4MG3rP7yEmjTrzlrR3U
         EMMA==
X-Gm-Message-State: ABy/qLYfmjyo2JjVfU5+Y9KovTnsS8YA/+TE9hTjRg5lkItN/ok4n4lb
        jYrRcq5I6o0bMWx0WU3Ak6Z3cA==
X-Google-Smtp-Source: APBJJlE4jASW+KjZ+d/WKrIUL9kQA541uUhAf+TfgyMfdxiroxUgVP9ET45dNgRcafBouHYVUK7Y0w==
X-Received: by 2002:a05:6512:ea0:b0:4f8:6882:ae9d with SMTP id bi32-20020a0565120ea000b004f86882ae9dmr2984390lfb.69.1688136025539;
        Fri, 30 Jun 2023 07:40:25 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512024700b004f85d80ca64sm2750402lfo.221.2023.06.30.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:40:25 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, upstream@semihalf.com, amstan@chromium.org,
        ribalda@chromium.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [RFC PATCH 1/3] media: Add 10, 12, and 16 bit RGB formats
Date:   Fri, 30 Jun 2023 16:40:04 +0200
Message-ID: <20230630144006.1513270-2-pan@semihalf.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630144006.1513270-1-pan@semihalf.com>
References: <20230630144006.1513270-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the RGB30U, RGB30L, RGB36U, RGB36L, and RGB48 pixel formats.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 5 +++++
 include/uapi/linux/videodev2.h       | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index a858acea6547..5ee616704225 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1300,6 +1300,11 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_ARGB2101010:	descr = "32-bit ARGB 2-10-10-10"; break;
 	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
 	case V4L2_PIX_FMT_ABGR64_12:	descr = "12-bit Depth BGRA"; break;
+	case V4L2_PIX_FMT_RGB30U:	descr = "30-bit RXGXBX-10-10-10"; break;
+	case V4L2_PIX_FMT_RGB30L:	descr = "30-bit XRXGXB-10-10-10"; break;
+	case V4L2_PIX_FMT_RGB36U:	descr = "36-bit RXGXBX-12-12-12"; break;
+	case V4L2_PIX_FMT_RGB36L:	descr = "36-bit XRXGXB-12-12-12"; break;
+	case V4L2_PIX_FMT_RGB48:	descr = "48-bit RGB-16-16-16"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index aee75eb9e686..3568819eabeb 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -583,6 +583,11 @@ struct v4l2_pix_format {
 /* RGB formats (6 or 8 bytes per pixel) */
 #define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
 #define V4L2_PIX_FMT_ABGR64_12   v4l2_fourcc('B', '4', '1', '2') /* 64  BGRA 12-bit per component */
+#define V4L2_PIX_FMT_RGB30U  v4l2_fourcc('R', '3', '0', 'U') /* 30  RXGXBX-10-10-10 */
+#define V4L2_PIX_FMT_RGB30L  v4l2_fourcc('R', '3', '0', 'L') /* 30  XRXGXB-10-10-10 */
+#define V4L2_PIX_FMT_RGB36U  v4l2_fourcc('R', '3', '6', 'U') /* 36  RXGXBX-12-12-12 */
+#define V4L2_PIX_FMT_RGB36L  v4l2_fourcc('R', '3', '6', 'L') /* 36  XRXGXB-12-12-12 */
+#define V4L2_PIX_FMT_RGB48   v4l2_fourcc('R', 'G', 'B', '6') /* 48  RGB-16-16-16    */
 
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
-- 
2.41.0.255.g8b1d071c50-goog

