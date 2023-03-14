Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93766B8D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCNIWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCNIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:22:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66E1ABCB;
        Tue, 14 Mar 2023 01:20:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j2so13446840wrh.9;
        Tue, 14 Mar 2023 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678782052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1NYMBiRuz7vfmt2Wpyeig2UyQ+79mH3kKnB3rm+kmQY=;
        b=n0GhsvE/3f+lSCHHtQcsmKLzTCo8UCOPV8n4FQL86IpRQzqFX9+9853Jg4KV6qlztJ
         OginLJoBPA0BpKvlFk+CIpJ/pAGmMMcBizLl+eKSjGrTtPSZ1xm7oYYBZd7M6fRc4+De
         5+mE6V1nXwSFgagI6IAiY9pYzLWtixvRtqISh7ORqmL9Gjk/LVERrQ6RT8Dm2qjryEyq
         kCRON/bfHwCYzESFJ7fWgT5Tgjw29o+MD1pNu/OX4WwtLZp8M3y8HSqMfnNdHp9Qv+Os
         5SxRaHpi2oMMrHwgLEh9YCdEYaHFgarLakuigRqkaHBrvROFteSqgTVoQNSBDiosGtm1
         HDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NYMBiRuz7vfmt2Wpyeig2UyQ+79mH3kKnB3rm+kmQY=;
        b=tAW1foK5xz+CfRH32eTw7fNApZNV0Ka4AIO7KD/QHTy+amJGJkeHkx+ZGoY3x+JqRa
         8vxqSAxRx6nJ2HQeo+gXjxUeuOjY78G7HFEm2EmpbpTwdK5IuPKjg6XpwOSagXYGqzCx
         oAuQBm/70kr2vUAZ8j32zB7Gyfe/fGVqwxDcu2k8Wbwnqw9sfdNmW9sYmJee+gTR6Cr7
         zFo8oEt4B20QqmAx7Zytq9+/EUPhm3Jow95cCeCBe+4HKkPk8qSg+w8KKAZ+E70PA0Wm
         OEAgbY1FJIjyFJkuqD1e4PUnbeoJSvK7m9fQhnyxy3mQJ9nRhp+tAzmbNuPTGOYAgYn2
         vtEQ==
X-Gm-Message-State: AO0yUKVQngIaR9IPo3fygJQEUFDjFWCut8sRM1LytXj/J8YTY3nOK7Hq
        Pvk/V+nIgf82xIPdjom3AKg=
X-Google-Smtp-Source: AK7set9PVFdLcKIPrfyDAWsSHFrgTZUfxU2m79g3kogwCE0yFQts0BNhT2cvYR6MhXj0pQOEi14JvA==
X-Received: by 2002:a5d:4209:0:b0:2c5:519f:307a with SMTP id n9-20020a5d4209000000b002c5519f307amr10246437wrq.30.1678782052616;
        Tue, 14 Mar 2023 01:20:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e25-20020a5d5959000000b002c8ed82c56csm1366019wri.116.2023.03.14.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:20:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/msm/dp: Fix spelling mistake "Capabiity" -> "Capability"
Date:   Tue, 14 Mar 2023 08:20:50 +0000
Message-Id: <20230314082050.26331-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a drm_dbg_dp message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 5a4817ac086f..42427129acea 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -1090,7 +1090,7 @@ int dp_link_process_request(struct dp_link *dp_link)
 	} else if (dp_link_read_psr_error_status(link)) {
 		DRM_ERROR("PSR IRQ_HPD received\n");
 	} else if (dp_link_psr_capability_changed(link)) {
-		drm_dbg_dp(link->drm_dev, "PSR Capabiity changed");
+		drm_dbg_dp(link->drm_dev, "PSR Capability changed");
 	} else {
 		ret = dp_link_process_link_status_update(link);
 		if (!ret) {
-- 
2.30.2

