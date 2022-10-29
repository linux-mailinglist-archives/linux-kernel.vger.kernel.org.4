Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1C6124F0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 20:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ2StD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2StB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:49:01 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E24523F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:49:00 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so9776889fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57RVFwJZ3iFyz/7pgcHKldBgiU0NMfJt4GoVXyg5tyw=;
        b=UmpE5fSWtp7oajWqEDBMnGKOSdYRlUjlCvONnEviqRMM5dChgSO3aEmhSQGMMCfW8A
         LdZyzL9YMoDOcDj6QecWqPEvDvATZKmXz79TjnZYp5sRJLvf0CqmxBdu6uqLTbW3CKZt
         Q1jdYGLgsrcVQsYvOQU0Qhkk/HGLQ4Udygmv3tx7Y1rNs+t9EtZGU9L5Q5w5iZUVgaoF
         PmP/cqOnpuPN5pW2helMx730eN6h2emtYVBqiq/bltkJNoeKp2YQ3dN/N9pVW6mbfhtn
         SN1hBQcEYqQA6WQgH1n9LXmZLoS9UB8uNWlV1YLLtr/4U/LA6tJhIOvGwZDgHU3IQsg1
         NJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57RVFwJZ3iFyz/7pgcHKldBgiU0NMfJt4GoVXyg5tyw=;
        b=GtmwCTtw0f6QGlcn+KrnrGI3YLvpnwXwOmOgpg5JqyriZF5vHMbCQ2xgFG0ijsdz28
         8U4mMrRQwqkLuqI+yVqz5FiZL4fXJyx2cJXeYi63ydbJ5SR5AQLowxEW4UvFvPdxKjya
         B5TyBPDQ/o9EvriBIJDHnBL5E7epTIPFqcOXUmZ0xqRHEcCvb8y+7UnTHg4hcFstKdyZ
         c6T/Vw96i4Ec/cZABPXMfpX/3u0pxtu17ijjP8SylznJeOQW/8Ac3ZnjWag6uRDMiFFa
         I42Mv5x5v6TMmcoCP8Jz7PM4a++pkCOT7jzevKHlYhz3MDhZfpwxmB6MM1vDMhqtKY9i
         UIkw==
X-Gm-Message-State: ACrzQf3b2lHxwkbNCOLtnWO2f2HK77JuhImIAivD16SGZzcrsLIWUO0y
        e0LVD6QDTnsGjs6v28VZzcfQF/ZlUtXdwD/Q
X-Google-Smtp-Source: AMsMyM6gxp24dY1reFhIf12V9j7++47EFrSvA6JaTa/RQdLSoSvclTEVkuhzvfrgvmZmhqIDRpLyYw==
X-Received: by 2002:a05:6870:9627:b0:136:c323:2ad8 with SMTP id d39-20020a056870962700b00136c3232ad8mr12328976oaq.259.1667069339786;
        Sat, 29 Oct 2022 11:48:59 -0700 (PDT)
Received: from antonio-Lenovo-Legion-5-15IMH05H.multilaserwifi.com.br ([45.163.246.1])
        by smtp.googlemail.com with ESMTPSA id q11-20020a4a6c0b000000b0049602fb9b4csm741898ooc.46.2022.10.29.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:48:59 -0700 (PDT)
From:   antoniospg <antoniospg100@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     antoniospg <antoniospg100@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH] drm/nouveau: Adding support to control backlight using bl_power for nva3.
Date:   Sat, 29 Oct 2022 15:48:50 -0300
Message-Id: <20221029184851.25340-1-antoniospg100@gmail.com>
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

Test plan:

* Turn off:
echo 1 > /sys/class/backlight/nv_backlight/bl_power

* Turn on:
echo 0 > /sys/class/backlight/nv_backlight/bl_power

Signed-off-by: antoniospg <antoniospg100@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index a2141d3d9b1d..855d0ce9f7fa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -263,7 +263,16 @@ nva3_set_intensity(struct backlight_device *bd)
 	u32 div, val;
 
 	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
-	val = (bd->props.brightness * div) / 100;
+
+	switch (bd->props.power) {
+	case FB_BLANK_UNBLANK:
+		val = (bd->props.brightness * div) / 100;
+		break;
+	default:
+		val = 0;
+		break;
+	}
+
 	if (div) {
 		nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
 			  val |
-- 
2.25.1

