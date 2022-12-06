Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B372643DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiLFHz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLFHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:55:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A04014019;
        Mon,  5 Dec 2022 23:55:25 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f9so12677017pgf.7;
        Mon, 05 Dec 2022 23:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+m1uoCSNZiNORNnWeYA/gOGOdLV8fKAWwqiFnQ4JGO4=;
        b=FLYjs2BsV+r65aZM3AJb2KO8o01qTTcxiXypSxBwse82Ge2U8dGdI5gwwrNj8KB6zO
         Vg3bwEuvpm2rok9Zr22M5HWzhrr//eVcFAt6p7YGtICttZPnajxCmYf/Ui63XHiiaS75
         vqseQZ/25z4WZlVG4yEYuAgmpOabbz6ZizTTBaA3AByXlp/YxcXF2IRa5pg24/shxCYD
         ZbY5gosvJBuIlzlsU9I0xKFzQfAF9Q0K/l+PdtPFNCHxXmyY4uudoiszGeRfhQsca0tW
         vXHomb3+0Un+BkjnH9GQjqxW9i5Wdcq9bTwyS0QT8EseISs88Dy+273WAs1hePzG72rH
         zjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+m1uoCSNZiNORNnWeYA/gOGOdLV8fKAWwqiFnQ4JGO4=;
        b=BbPgftm6JXJlap8NNajxtA9Ydw0dWBseMhPhlmWCG2/GgoysJPygTI/mT+GmFcg7sq
         qBQhvmsscLvsG46ihlWueE7V/yQlOrmMXqv3+KIZtP/p7QuOBTvdgCKCvzYRgQPicGAD
         9Q/HKiAWOb0bQOMgng/6NcdhkdINAv5Nwqu2k0iUG5cydanCGPgJu8ClUfFq9zWYQHa2
         qn2kvVx9vBOxERRWNE/HcxdLyNzK1Q5XE7XjQ3fk+broY75ZUsu7IRYhWCXUldcpt61w
         1jH+YQB2OFaNrHpBorsUMdnBO5MJc4dWtfS7R+dVyjmBTJagrhErD8bTDhXg0oRenqJ9
         wIow==
X-Gm-Message-State: ANoB5pmGCUT63/XPOn4aoM1AWVsu7ugnh/ISUZTw/iLS7sXAL6xEJNe0
        ZeYxT6TnpfOiGkDrAKWN4r4=
X-Google-Smtp-Source: AA0mqf5dzvkZeVIdPTS9qvKDt87TQ2d5a756QKQdk8c0187z5gzzHU9yhowfHZF4VanVQG1f9UxM2w==
X-Received: by 2002:a05:6a00:27ab:b0:56c:71a4:efe with SMTP id bd43-20020a056a0027ab00b0056c71a40efemr72801167pfb.84.1670313324560;
        Mon, 05 Dec 2022 23:55:24 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i14-20020a17090332ce00b00189422a6b8bsm11951284plr.91.2022.12.05.23.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 23:55:23 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/msm/dpu: Fix memory leak in msm_mdss_parse_data_bus_icc_path
Date:   Tue,  6 Dec 2022 11:55:12 +0400
Message-Id: <20221206075512.812389-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_icc_get() alloc resources for path1, we should release it when not
need anymore. Early return when IS_ERR_OR_NULL(path0) may leak path1.
Add icc_put(path1) in the error path to fix this.

Fixes: b9364eed9232 ("drm/msm/dpu: Move min BW request and full BW disable back to mdss")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e13c5c12b775..a38fa9a9a3d6 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -49,8 +49,10 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
 	struct icc_path *path0 = of_icc_get(dev, "mdp0-mem");
 	struct icc_path *path1 = of_icc_get(dev, "mdp1-mem");
 
-	if (IS_ERR_OR_NULL(path0))
+	if (IS_ERR_OR_NULL(path0)) {
+		icc_put(path1);
 		return PTR_ERR_OR_ZERO(path0);
+	}
 
 	msm_mdss->path[0] = path0;
 	msm_mdss->num_paths = 1;
-- 
2.25.1

