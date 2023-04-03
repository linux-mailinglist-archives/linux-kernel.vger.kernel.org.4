Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD676D4D38
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjDCQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjDCQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:08:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020C2D60
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:07:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so33062653pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680538069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKnixP5n5+Zn1kJb+6YOX01TVCjG+8+3f8j/QO7AJFw=;
        b=V3H8+AJ3GOgAjkJY76fFg82MzOHHzyoqvXzhkD0EA7jIuN/54d114thC7Lp5rUh3df
         wuqbdE7S3EoWtBXIJzbwKuURS9rtPuCUII8rYExUQARSLuAmoH5c9tZwWQqVml44/Jcv
         bVrswAJ5dvfrmfWGEZFcpxH2epzsk4bNBPv/L9o8r/BbowC4B2QNg44Z37DMWGCinVor
         Y6dtHL6P7q79JM+rTw0uFo3kdfK59xFw1xCY5if0r6F2Jehvoxpl6G7OmCahTYDE63WH
         sPiacw/SeSrMJjXgy34t1+UEe0TAWb822+2bpwWSvnonrgJzOfIdjlaot5um10ycTwVx
         AhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKnixP5n5+Zn1kJb+6YOX01TVCjG+8+3f8j/QO7AJFw=;
        b=sjAcvB1AZ/bbmjfGcaDSKkIQC7ov4WHLhr7lrCVOCLUN2V/jkffdK4TLAzqZBvWQ8+
         9UYCkSjoKoQdCr+YjAviNi6zH+qYYU18912JcSG7A33wVYO+X5AFCj92PFUQCnN/sZfP
         DM4DF0KUUFrbS9ge1hTfn9LPUg3gpDWi8i+uoF+yWJ+oNg7m7sDfG7S5x/mbfd0TdEBB
         Hmrx1+ktkJxKXoDeBoVZmdD46TLVOQueJobMvquoaLF+SA01KrQURGhvnUDTCD23TCHG
         Z9EJybBe3x5wZR1lOcl/gcp4XWzvgVeDeumBeyQJCN99EJ1JFfA0FGLxhv583IZ42C2G
         xBxA==
X-Gm-Message-State: AO0yUKWEPVLwJ26o/pQaQAw8EL/BceQ5mLGWgbc8FgC/K9PZsNKrsPYD
        roOz4EXTVjVGi20Z6sgANKg=
X-Google-Smtp-Source: AK7set/GZdIC5QOn9o/FcyqqFSgG9/q68k+OzsO743dI9WPlbAYjMWr8JeyWGWCnZBheZsYC1QwmSg==
X-Received: by 2002:a05:6a20:c129:b0:cd:1808:87c7 with SMTP id bh41-20020a056a20c12900b000cd180887c7mr30076046pzb.15.1680538069342;
        Mon, 03 Apr 2023 09:07:49 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7858f000000b0062d8c855ee9sm3423190pfn.149.2023.04.03.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:07:40 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/vblank: Simplify drm_dev_has_vblank()
Date:   Mon,  3 Apr 2023 09:07:35 -0700
Message-Id: <20230403160735.1211468-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Rob Clark <robdclark@chromium.org>

What does vblank have to do with num_crtcs?  Well, this was technically
correct, but you'd have to go look at where num_crtcs is initialized to
understand why.  Lets just replace it with the simpler and more obvious
check.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 877e2067534f..ad34c235d853 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -575,7 +575,7 @@ EXPORT_SYMBOL(drm_vblank_init);
  */
 bool drm_dev_has_vblank(const struct drm_device *dev)
 {
-	return dev->num_crtcs != 0;
+	return !!dev->vblank;
 }
 EXPORT_SYMBOL(drm_dev_has_vblank);
 
-- 
2.39.2

