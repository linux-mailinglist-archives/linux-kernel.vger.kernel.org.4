Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FBB7401D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjF0RBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjF0RBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:01:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C5F10D5;
        Tue, 27 Jun 2023 10:01:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fb10fd9ad3so21953935e9.0;
        Tue, 27 Jun 2023 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687885272; x=1690477272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+uGhz1ZekJEDv+o6yXgK9sgLmec5ROnru0Fe+zZ8aiQ=;
        b=G/E9S1pC+gegYTlgEBMtA32SF9TYtq5yBgLX2e+59/iC0jrdp2iyi9Vmvu/qUMPNRg
         f1ExwlIa2JlBUOkTeAQk0Zfoh9L4yohYuqRKWgb6XePBAe8BlL6v5JvDitiQC86YHCjp
         YPqf7s75eBkYneBNzezTK7nvu0QN5VCXM35l40G3c6gstpSMPD0hIbWRY+DYmaYQa8zI
         UtEAVY9XGaDVlt6IkYGPDObGZrVpHDaoDPPzHJsRbnB9erQeg5oUVsk5IPGDqOXqHNw3
         GecKX2tfkk3Kea5e+ig5iIJKu766iLLOKiJQjSeRhFyRdkBjLZ1j7v5yFXo8Z8UUPnL/
         h6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885272; x=1690477272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uGhz1ZekJEDv+o6yXgK9sgLmec5ROnru0Fe+zZ8aiQ=;
        b=ZjptA0fK68AZC0a75wELezgeE3cD1mabgpstInmyknkyTjFktoVf6OOFdi6PhW+ruZ
         zCFEi6OM4TEQ+5d7+s6IfCpz2i9TJWnnDTaCj2B/hmC3o3K4+4/5hXr8VPLdrtvNFRAt
         AB61N+NXzMmp/eHQXuOOIoYCGKU1R43R/7a0VfmRsykf6SU+NP1lFLuJvwRZl6MkjKUV
         /XdJsVZJ43Ng1eQCFMv9dVldEw+0Ky8bNmfA+xPoG9B4fGtGjaBFSPVZotB44i1pUZla
         LHLRrOJPj7lAq2F9L7hc2n7ceOi6jruV7TWbp2SZnY6Bxy+r2TBTCdPqkvpPOLXRdhlH
         q0+Q==
X-Gm-Message-State: AC+VfDyV1ZFy1vjuoDuXN/rq0vSbZAtTqxT5R3pn2abUYkhIKR/x0JJR
        kjyoJqanipyEnxf7XFLGX1E=
X-Google-Smtp-Source: ACHHUZ7iuGNPU4+nlFFvwSQAqwhKvN3i5/0Ig+a69Bfy4AwbsJqAACXIJ+M2KAZSYia7jl+vER3V7Q==
X-Received: by 2002:adf:f9d0:0:b0:314:824:3788 with SMTP id w16-20020adff9d0000000b0031408243788mr89599wrr.27.1687885271693;
        Tue, 27 Jun 2023 10:01:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b0030647d1f34bsm11074801wrt.1.2023.06.27.10.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:01:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/edid: make read-only const array static
Date:   Tue, 27 Jun 2023 18:01:09 +0100
Message-Id: <20230627170109.751829-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the const array on the stack, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e0dbd9140726..39b13417b749 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3962,7 +3962,7 @@ static int drm_cvt_modes(struct drm_connector *connector,
 	struct drm_display_mode *newmode;
 	struct drm_device *dev = connector->dev;
 	const struct cvt_timing *cvt;
-	const int rates[] = { 60, 85, 75, 60, 50 };
+	static const int rates[] = { 60, 85, 75, 60, 50 };
 	const u8 empty[3] = { 0, 0, 0 };
 
 	for (i = 0; i < 4; i++) {
-- 
2.39.2

