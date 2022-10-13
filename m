Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1525FE5B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJMWzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJMWz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:55:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D8EB1DE6;
        Thu, 13 Oct 2022 15:55:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fw14so3302398pjb.3;
        Thu, 13 Oct 2022 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3O30/nl6pZCQT2a2Baeof1BC5ax2UChSGPY/GTCY8A=;
        b=SeQLSPqc2/YQ5vhmURpGxCnRKh4YUw5BIN/UHXTmSTFBpDGIN/UqaqBDt6pMvjuhc/
         j2k309PB1WiJaLcgGJw0B2k357k7sU81p9/kKp6HWYR0WsIrciIyoWz6FiWaIjOhYpmC
         zw5NfalFvdad7ehlApMsdc3zw7uDtU0rXa7Rqe0PlHt8vzbW5hGAFR0Jpd3PAtF3BVh2
         7ZHFQd44XtijZYU5yZmnglgziHtJA6kMwzbYr14Qx8jL0Q+t8liFJDFxfghNAxWG+I8M
         TuyzvlRLcp8Hmr/DK46CYysmJpTARRggYYWF3bfXcO6i7UP5EPMcLY+JtsSmxsFdoUI7
         vqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3O30/nl6pZCQT2a2Baeof1BC5ax2UChSGPY/GTCY8A=;
        b=t7A/bYpizeDi+ucK2wtUoh1EVwyFP29bGURcEg/yZZVKqXU+V/eZz/23moTFr3QdUN
         Wc2QBnLJBLSXZHe8hhyieisIXQN8S3Kuurxj3w6LO8z89VaZTxXT7OYUkjovg584gW+j
         +tf0vB5TnPH2Aa0TftZAgzAasGhkaGi8e6fKQoWsvZWGahQ8T5ArCq3eL66fkGO/8D//
         d2AiendKgbwvm+En8/3n7RrvgSCNx0Xjn5PEhaYq4ObdfcUA29M+eMjBjehbWvLlcm54
         TeL9DZ3HUwtOjqhjeDrADz5zvjGmJ0W9ctJSIQ5ZDHM+CdDCOLino/Tt47jub4kUngdM
         l+/Q==
X-Gm-Message-State: ACrzQf2Ui+pKfCuvXLCJaj1MAo91mwR69vTr6sFac8mLp0Uel7VmI9s7
        CTQOq5UKuLvdnNIMZO35vrw=
X-Google-Smtp-Source: AMsMyM4NeJVCQzzcm8W75BjX0XeEL04t0hlo0bW+dZBuuOehbjB/kLxpHcNbIXA8Wid599NWqdBeZQ==
X-Received: by 2002:a17:903:40cb:b0:17f:6e08:6eac with SMTP id t11-20020a17090340cb00b0017f6e086eacmr1993232pld.80.1665701717785;
        Thu, 13 Oct 2022 15:55:17 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n123-20020a622781000000b0053b723a74f7sm226564pfn.90.2022.10.13.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:55:17 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/msm/a6xx: Skip snapshotting unused GMU buffers
Date:   Thu, 13 Oct 2022 15:55:14 -0700
Message-Id: <20221013225520.371226-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221013225520.371226-1-robdclark@gmail.com>
References: <20221013225520.371226-1-robdclark@gmail.com>
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

Some buffers are unused on certain sub-generations of a6xx.  So just
skip them.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 730355f9e2d4..b0124d0f286c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -813,6 +813,9 @@ static struct msm_gpu_state_bo *a6xx_snapshot_gmu_bo(
 {
 	struct msm_gpu_state_bo *snapshot;
 
+	if (!bo->size)
+		return NULL;
+
 	snapshot = state_kcalloc(a6xx_state, 1, sizeof(*snapshot));
 	if (!snapshot)
 		return NULL;
-- 
2.37.3

