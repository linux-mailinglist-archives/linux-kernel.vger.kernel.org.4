Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A776713343
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjE0ISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjE0ISV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:18:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11054F3;
        Sat, 27 May 2023 01:18:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b02750ca0dso395215ad.0;
        Sat, 27 May 2023 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685175499; x=1687767499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgkyIFrBxuAzRVAXPfklB2pDA1O52uIPOrfTaBhFKGs=;
        b=qm+e8b0zkHNbENDDxLnIF6iBScBalvdL1g9zQnlk0PvyTH800CgFL/iRVnhFVqPOs6
         oBaQdJOsEvfYm5pY7XuXn7P1wonU6aeCERZDFy94mQYYGqFp61yFoWHgoAg22uKCN1DV
         MeMl6WBLU8cUacWqUeDBLq9WRYdR6drlC89VW2PXskhq2PZbFtnAn+5nvUpStUF+hzpJ
         DVjlWLnYZaJTMWs6q7vX1L8qinpHo/H/xhsI4HsUbENWAuIs4KiOL9zQ+lBYDvrmi8KD
         CYCk5dlWGxE2McweClOUal1k2r0jHEODWDgeP6sjWiR09GFNNiwuka8F0Gtdj4WT6Vzr
         iOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685175499; x=1687767499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgkyIFrBxuAzRVAXPfklB2pDA1O52uIPOrfTaBhFKGs=;
        b=L5TH+4+u5XLIRfa9sfrdswbFFnRZ5ywJYv4THj+ec+PTEeVy2q46WA8JtrS5f9y+PI
         LWydD/L0BySavPv5j7N03p4ETQDQtDujiF9hAb/7pFyKEDFnuHWXQVlBkYjqhuefRVGB
         CM19uPJpyd2GSXpdYgDhJz0craOR1ypoT5yFj73s2JyEds/iIsm9kDhvAj/NgzNhJdtu
         0ytj0CpyG5HGgv4zggDh2Hg7StLcY76wJ9nrOhf8RF36sW5zILdN1pcNrkxrOEmI9bqq
         Ue0T6R1i7rFL8/kNW4xjcHciNnNV/+TjrUrJmg0kMbs7/e4IYTfYymKoQGIvHNmNcLIw
         VRlA==
X-Gm-Message-State: AC+VfDwgAtd5Uor72dFTXrM+xOIDLtlv+Ls1LvF2+0OdvHv7BVxbfrj5
        ZWUF40gDtSlvA3MC7qPAoao=
X-Google-Smtp-Source: ACHHUZ6Qrp4DcfEEkrmjiuOnMT+CTIIsQl6FsMr5hpxiqSImvCBsDbCfQCxS1x82Mq3I3BFFmbia1Q==
X-Received: by 2002:a17:902:e752:b0:1ae:8595:14b with SMTP id p18-20020a170902e75200b001ae8595014bmr5638597plf.6.1685175499229;
        Sat, 27 May 2023 01:18:19 -0700 (PDT)
Received: from ubuntu.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001ae6e270d8bsm4395490plg.131.2023.05.27.01.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 01:18:18 -0700 (PDT)
From:   Min Li <lm0963hack@gmail.com>
To:     inki.dae@samsung.com
Cc:     sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@gmail.com, daniel@ffwll.ch, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
Date:   Fri, 26 May 2023 21:01:31 +0800
Message-Id: <20230526130131.16521-1-lm0963hack@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it is async, runqueue_node is freed in g2d_runqueue_worker on another
worker thread. So in extreme cases, if g2d_runqueue_worker runs first, and
then executes the following if statement, there will be use-after-free.

Signed-off-by: Min Li <lm0963hack@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index ec784e58da5c..414e585ec7dd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 	/* Let the runqueue know that there is work to do. */
 	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
 
-	if (runqueue_node->async)
+	if (req->async)
 		goto out;
 
 	wait_for_completion(&runqueue_node->complete);
-- 
2.34.1

