Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012206874C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBBE6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjBBE5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:57:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392F7449E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:57:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so4494961pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 20:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEXNGmvImDiIabX0ha1Bsn0g9dYiCmRV9oIQI3tuzTE=;
        b=ESpEpRiNOlnHvH9iNu/RZlLGQnQ96XRBURzcxRZVB28y7PlIkfsK/EAyAPBMfbFPd5
         BHhZKgH7VX7HQwhFASIBKcWbVepGgF1zn88RUpIUIVWkNJKcLSuTVxk8t1Fqj9H6WPG7
         NxDmDF731XI7VUDgqABnlgaIORhRosSMgWIMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEXNGmvImDiIabX0ha1Bsn0g9dYiCmRV9oIQI3tuzTE=;
        b=wZbekZzutYVWiydE5GBS/MrDGDQXDplGhQy92s4NIxHqq2NTPfR+woI5gGrjbWG/Pr
         iJ5zA8D528tTlJjjq8ozoE3o6MwrtCp6SjJnJ4MiugETk5l0UC5K/4WE+UwMiesa38EK
         ZJ2n4sKVCGraDRAh/pmIPx+7DDVXexmj/9wTY5kQ3LvL9tKfR6GuUqR86tYWoj1UTeYV
         rB7y9xO22zADpc512eZ+EinKb1jQtDSl9ImV3yaTQBoealB1Bxj2wmX4hpo5Qq/aycLG
         E2Z/SIxc7de2AuAge2w7nQEHQb1oYIaT4hBxus6vZ1AFSi5bAbqKFYsBC8PjZcLrWqb4
         9J7Q==
X-Gm-Message-State: AO0yUKXTQBgOJXb3kNe3CemtjXXFuYmBWdslXY4Y48Dpbc7Vq2XQJiBa
        mXLkudrQcL+j5j681TZzruKaQxi/8dfrmsJe
X-Google-Smtp-Source: AK7set8WyD5ReUIueqrJ73xdpvTR1OAyoDOAo/QkEW005hwgtutfWFDZBrKjjW302/sUWzEzjRRm+Q==
X-Received: by 2002:a17:903:11cd:b0:196:704e:2c9a with SMTP id q13-20020a17090311cd00b00196704e2c9amr5774070plh.22.1675313858323;
        Wed, 01 Feb 2023 20:57:38 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:68a6:9bbd:a36a:4d1f])
        by smtp.gmail.com with ESMTPSA id ba2-20020a170902720200b00186a437f4d7sm3667203plb.147.2023.02.01.20.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 20:57:37 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v2] drm/mediatek: dp: Only trigger DRM HPD events if bridge is attached
Date:   Thu,  2 Feb 2023 12:57:34 +0800
Message-Id: <20230202045734.2773503-1-wenst@chromium.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek DisplayPort interface bridge driver starts its interrupts
as soon as its probed. However when the interrupts trigger the bridge
might not have been attached to a DRM device. As drm_helper_hpd_irq_event()
does not check whether the passed in drm_device is valid or not, a NULL
pointer passed in results in a kernel NULL pointer dereference in it.

Check whether the bridge is attached and only trigger an HPD event if
it is.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Guillaume Ranquet <granquet@baylibre.com>
---
Changes since v1
- Dropped prerequisite-patch-ids
- Added Guillaume's Reviewed-by

This applies on top of mediatek-drm-next.

 drivers/gpu/drm/mediatek/mtk_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 1f94fcc144d3..a82f53e1a146 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1823,7 +1823,8 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);
 
 	if (status & MTK_DP_THREAD_CABLE_STATE_CHG) {
-		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
+		if (mtk_dp->bridge.dev)
+			drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
 
 		if (!mtk_dp->train_info.cable_plugged_in) {
 			mtk_dp_disable_sdp_aui(mtk_dp);
-- 
2.39.1.456.gfc5497dd1b-goog

