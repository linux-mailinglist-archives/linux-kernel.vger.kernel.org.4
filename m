Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AFE5E80C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiIWRde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiIWRdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:33:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C89A14D302;
        Fri, 23 Sep 2022 10:33:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id rt12so698646pjb.1;
        Fri, 23 Sep 2022 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RcmsQzRl+ihF1VVNpRmBrhOSsh2l+7OEJ3HKlIa4qQU=;
        b=chP6WJAGr2PPuIsrNecBqcLaY0+SHmMWrrckXnnYy9FfJxkzwls0F972JKhiawx7qh
         RuOSd5JO80tfXxiRwltW+g/uMDmdkwbXkwL3uNXwo5XeakTaAuBz4DdpPqm4RulfTsN7
         6hXrT8grt3WPqGTgzp8pd6QDxegMtIhOLygNKPzszr9lPWbjtfT7m9Zde6o/QpOaXyyT
         CcW1cW0NNSFgxWEpjGevZ1MIog+sKnCfjR6qY1W+QtAh12P0Mn6fQUCi2VsVys+ezhQa
         4/vT9fQLx9Whxbl7c3neAVkTiKVGflERZRbuDciOJNdN8l80YKLMTwAkL+WA8T79ABDH
         BToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RcmsQzRl+ihF1VVNpRmBrhOSsh2l+7OEJ3HKlIa4qQU=;
        b=HEo5hYdvG7O23vhdwX3E1KHN3PeeEvbLGFdDBZqgZ12SmnmuouuIO3N+RpLve5aWNB
         7rn0BSY3WXK0wv+Ua2ykmodWZ6VTwqcMmeumPKtvzTBm8e3VVhGFU3Cz5GIkyHtxuRQt
         UEn8+ZmYE9jEOpXl3z/ykaNGF5kzYXILy8pg4k6iOuZDTgTOsiW18Y4WEHnXeIeHq3nS
         2+CgscBZljbNGSA0Agir/kLkPaLcOBFe9wdvX8Q43atf8IX5y8p6PO0CMh9qYTbkdObx
         3T92dxNwY55JuX8sOS1Olcv21d5Iuz7ETDQJxhPPnGK31iYcVXz55/Nwl9sgE3OxhbNx
         hC8g==
X-Gm-Message-State: ACrzQf3v2IuGDGUCFOfDEd+DsAmg3mb1tjEeuAbxWz8KR5lJEp5AtNLt
        1xsOR/DtbJ4U7AlYIQKIrA4IKUJ2yEA=
X-Google-Smtp-Source: AMsMyM7rLu4btpweWbZ0rMM4U+K1DoebEMuwVCjkXK7sGacJsmBu4vTipbG5Rl0LSDp8gBJh/lV5+A==
X-Received: by 2002:a17:902:7d97:b0:178:6505:10f6 with SMTP id a23-20020a1709027d9700b00178650510f6mr9462087plm.155.1663954389602;
        Fri, 23 Sep 2022 10:33:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id x7-20020aa79ac7000000b00540d75197e5sm6547525pfp.47.2022.09.23.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:33:09 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Add MSM_INFO_GET_FLAGS
Date:   Fri, 23 Sep 2022 10:33:07 -0700
Message-Id: <20220923173307.2429872-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
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

From: Rob Clark <robdclark@chromium.org>

In some cases crosvm needs a way to query the cache flags to communicate
them to the guest kernel for guest userspace mapping.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 10 ++++++++++
 include/uapi/drm/msm_drm.h    |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 07f66412533b..66b515a956c1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -818,6 +818,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 	case MSM_INFO_GET_OFFSET:
 	case MSM_INFO_GET_IOVA:
 	case MSM_INFO_SET_IOVA:
+	case MSM_INFO_GET_FLAGS:
 		/* value returned as immediate, not pointer, so len==0: */
 		if (args->len)
 			return -EINVAL;
@@ -845,6 +846,15 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 	case MSM_INFO_SET_IOVA:
 		ret = msm_ioctl_gem_info_set_iova(dev, file, obj, args->value);
 		break;
+	case MSM_INFO_GET_FLAGS:
+		if (obj->import_attach) {
+			ret = -EINVAL;
+			break;
+		}
+		/* Hide internal kernel-only flags: */
+		args->value = to_msm_bo(obj)->flags & MSM_BO_FLAGS;
+		ret = 0;
+		break;
 	case MSM_INFO_SET_NAME:
 		/* length check should leave room for terminating null: */
 		if (args->len >= sizeof(msm_obj->name)) {
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 3c7b097c4e3d..f54b48ef6a2d 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -138,6 +138,7 @@ struct drm_msm_gem_new {
 #define MSM_INFO_SET_NAME	0x02   /* set the debug name (by pointer) */
 #define MSM_INFO_GET_NAME	0x03   /* get debug name, returned by pointer */
 #define MSM_INFO_SET_IOVA	0x04   /* set the iova, passed by value */
+#define MSM_INFO_GET_FLAGS	0x05   /* get the MSM_BO_x flags */
 
 struct drm_msm_gem_info {
 	__u32 handle;         /* in */
-- 
2.37.2

