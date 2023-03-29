Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929486CD671
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC2Jac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2Jaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:30:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8731E19A4;
        Wed, 29 Mar 2023 02:30:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so5572757wms.5;
        Wed, 29 Mar 2023 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680082228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lEaDc8be8FkWi1HX0iSofPQaKiEa8pAZUfrsxxjcSw=;
        b=FCR79EhyW0vJpHBYVKlPW8vXWhRAihkRSI0u4tf7VDEIDF7RSF3B2bJXqAywT69v72
         meKdvUnF+HCW5+Bqf/2fqch6RTAdmaRS8grsaLPzlZ/RbhskfugKDh7RtxikBZmCQQGF
         Z6DaRvzRiaDxk3OSWzx/ArjH9MqFrNhMiiIeOiEgQ7XI7VmML6U5HqK6/F4ZPg43Q2fD
         gSMO+OWlcHYoGlBwUpXakZ/yUVg1C1SJWkSt0Txi+jHvcAEGMXsT2BJwybKYUAbqHlXN
         EAh+UxqQCU1/CzGu1fGjNRBu7r0QGULKp/iDtEtAAVkPqDmVe9tA9rNEeypYzinW8MJk
         Bi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lEaDc8be8FkWi1HX0iSofPQaKiEa8pAZUfrsxxjcSw=;
        b=2cu5oXdlQ4ABJiO7bkXjHUo6T1k8er/kyuPrxy7oMqHjAtdFucfl8l1lvb6X3GXB7B
         Lw1tvME25Ic3QAqWPIgy+C1hPYoxJiZsg2dFd9jWxXQggEqx2SamvUgtUfmU86oufnf5
         rs3rWj7LXKcFiAdbR2GdRRvuShgXT9RPn7nVak95qnaIjAGjBWXMRVsapRBy+GNo8pwq
         3WPHXAsIbou27O67J56JB6yyN3ff8tzreXGKaKzqbmg6JXQjcX8mby81TY16Fxz9C8H+
         +y/yywe/K8PtNgs+DUGgwun7q3OXIUtu/nxoo0Z8O+va6jTZX5g+WkftyMbqC1pHaOLW
         6pfw==
X-Gm-Message-State: AO0yUKXYxiOpQ8RUHJSD9VANMvIa0axiUytWyTUUTkoKdqulqZKpWLsP
        4HA8T3Dc2/+i2cSQLQsMlOc=
X-Google-Smtp-Source: AK7set8icXlaIt2CvY3lleghHnnb5TGOj1bkw4TJVx7xOyJ8D/nA/R6NaqroGfmG6xJJgjVkcL3yJg==
X-Received: by 2002:a1c:4c0d:0:b0:3eb:2e32:72c3 with SMTP id z13-20020a1c4c0d000000b003eb2e3272c3mr15711230wmf.22.1680082227927;
        Wed, 29 Mar 2023 02:30:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c224d00b003edef091b17sm1573356wmm.37.2023.03.29.02.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:30:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/msm/mdss: Fix spelling mistake "Unuspported" -> "Unsupported"
Date:   Wed, 29 Mar 2023 10:30:26 +0100
Message-Id: <20230329093026.418847-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index c15d1e2dc718..7cb301854e64 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -274,7 +274,7 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 		msm_mdss_setup_ubwc_dec_40(msm_mdss);
 		break;
 	default:
-		dev_err(msm_mdss->dev, "Unuspported UBWC decoder version %x\n",
+		dev_err(msm_mdss->dev, "Unsupported UBWC decoder version %x\n",
 			msm_mdss->mdss_data->ubwc_dec_version);
 		dev_err(msm_mdss->dev, "HW_REV: 0x%x\n",
 			readl_relaxed(msm_mdss->mmio + HW_REV));
-- 
2.30.2

