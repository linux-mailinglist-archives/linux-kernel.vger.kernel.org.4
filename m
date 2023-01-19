Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DCC674712
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjASXTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjASXTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:19:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182A366AE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:17:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3326743pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoPT1qZTZAiwXdlOT9grX8TQ8vUdaTmpWhI7QC60cXs=;
        b=awbv6pu4ENIEU6blOT7ognTpQESQ7PK3rksK/Li2rhuFEXMIgQPIVEQJgFOhFvQZMM
         z1qM4WyqdoS2qycGh4iuFu9CzCkCDEfCbVYcbnocOQ7X1mUJgZVJhmNsgz3AlsXZgPUB
         RX97qZm5KkyND7oXpFMe0e2zN0iJX9R+1xiaDmDggFxLobRLz1OMtHlXQkYCe1wVVC5R
         KpQzyTJyUjkfG++QAB7DBxJVT/mrBUa9OaNpwR4qPXrRx41TB4YSI7k8VM5lQxsLN+O5
         M99Y6PF0ogupxXhew39KKeCyvLrEVzlAYA2tabdXeE7cqz/2SrRlENPKajqHTlez5Hwt
         udUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoPT1qZTZAiwXdlOT9grX8TQ8vUdaTmpWhI7QC60cXs=;
        b=RnA940hKgBwG3eBu1NELIJxBfdutcY5rXeU6F3djJg2zQ9OEX+6OqM+gWPSxlJDF1m
         AKD3CykKMcSHEahcld6Iv6lCtun+VZQAnCrSnb07zxbPMvqXtc10RnJX3lHvNUOS9UZm
         bJXMbBrHvfVWQubmaODFin1ImDu5OTHhx7jI61YU4AOCeW3GSxZOvj+X8qPZSugJQmA5
         3IreIkPJhCgV7XGa7ek+0CKm4eVYQKPiqVWP9lALvO1mm80OIZeSPikbPlPgsKl3Tcd/
         zDAYZIsHyOaSR6hHRDKaLoqP5rKqW6CmjHPOSj9czOvbF6kJZaYH9PI61ToYCCnaBkPV
         jZpQ==
X-Gm-Message-State: AFqh2kpMX5YiKVWZ5YAf6QfkkS606ov8s7Eu6vxFrbHTypLiO/4we19a
        gbCaXjXfXpI4GBj0KrVnvJw=
X-Google-Smtp-Source: AMrXdXsVdDw+YB0Zgvq034UW+xelPx2PPY4N5TAKF0D/Jclal3YFKMREgNQamm7c8VfVvfM/mVcIug==
X-Received: by 2002:a17:903:200b:b0:194:ab2a:b74a with SMTP id s11-20020a170903200b00b00194ab2ab74amr11069280pla.38.1674170250390;
        Thu, 19 Jan 2023 15:17:30 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b00188fce6e8absm22498801plh.280.2023.01.19.15.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:17:29 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/rockchip: Drop unbalanced obj unref
Date:   Thu, 19 Jan 2023 15:17:34 -0800
Message-Id: <20230119231734.2884543-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

In the error path, rockchip_drm_gem_object_mmap() is dropping an obj
reference that it doesn't own.

Fixes: 41315b793e13 ("drm/rockchip: use drm_gem_mmap helpers")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 6edb7c52cb3d..19b46c00dcbf 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -262,9 +262,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	else
 		ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
 
-	if (ret)
-		drm_gem_vm_close(vma);
-
 	return ret;
 }
 
-- 
2.38.1

