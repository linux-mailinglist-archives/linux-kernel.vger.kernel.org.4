Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB36EC5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDXGBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 02:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjDXGAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:00:11 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3704B40D5;
        Sun, 23 Apr 2023 22:59:51 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1a920d484bdso33953665ad.1;
        Sun, 23 Apr 2023 22:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682315960; x=1684907960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZ2SfSlApMPG0JQkvL0AAuqyfaSDxsc4TPleUHWHX54=;
        b=Bj6IflHqWM9RygSi8UEGI2g9c7+Bkd+8Rr6BnN5FQZTlu7Cm7QGxH8OUXtuMF+b9QP
         39pt2qNTKyntQp4nS019DULMorprdQI03RM2/qW1jnrnLEF8By3JujbAj7/+x+P++LV7
         uIwAnpbv5Uyl0OxaZ4SuKrALRb11325ebp0ds1/Y8tk32OFQ20hVSkqrvr5u4VtTGjbs
         BwiNJF/zpnkav+MxSu+POcNM1DhXNP+4cMa5lMeEemwqz8EhhhWNl2rHHdQSO4Wuycvk
         X6vR3zOtWQSRkQ0SzDaGhRx1l+0pkES3bJsjl5gzvYclJVv50J85BJHzZhZsUnwZ05iU
         cD6Q==
X-Gm-Message-State: AAQBX9f2gDZAGX8jEsHAWmcb4pXCA6o0DUq3myTOakKdWclum77hiiYJ
        OV7ZuMMhQKdL59+ZQzGbRd8=
X-Google-Smtp-Source: AKy350bZL1arZEunooIRRXsnKZi0bPLlYztinlCxzZ/LrCosNr+NxtGmjW+3SAzNg1ES3iuKdejZ3A==
X-Received: by 2002:a17:903:30c3:b0:1a6:f1f3:e475 with SMTP id s3-20020a17090330c300b001a6f1f3e475mr10319987plc.55.1682315960069;
        Sun, 23 Apr 2023 22:59:20 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902d64700b001a979121444sm850808plh.207.2023.04.23.22.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 22:59:19 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     daniel@ffwll.ch, airlied@gmail.com, sumit.semwal@linaro.org,
        Hawking.Zhang@amd.com, Julia.Lawall@inria.fr,
        dri-devel@lists.freedesktop.org
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH] drm:amd:amdgpu: Fix missing bo unlock in failure path
Date:   Sun, 23 Apr 2023 22:59:10 -0700
Message-Id: <20230424055910.15683-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warning - inconsistent handling of buffer object reserve
and unreserve.

Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 278416acf060..5de44d7e92de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4686,8 +4686,10 @@ static int gfx_v8_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, &ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v8_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
-- 
2.34.1

