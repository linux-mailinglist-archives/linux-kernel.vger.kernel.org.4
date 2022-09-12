Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C155B63C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiILWfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILWfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:35:00 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B400418B02
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:34:59 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-127ba06d03fso27333893fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JV7ELz4kPbM5zN+d1pRguKa83wMKNN5UKfm4nAD4taw=;
        b=kCcu/2IKnox3u9+zK7lOqIRhYf9kr9vm3wsCj6PU5aFX4J98EbdN3EDa3TwpJ7UOjG
         LrnkokkVHZ/HdP4mvJQ2zl1TorLnQAk/Lic9RGmM4+aEMy8t3Xqsv7q8wWAZIxh2/FZD
         0z1+iOprlAiRrxc97dK6joWlmaz2nQNuCZN3oAHD0U8Dc1rt88vQ7gNJW/clEROtn1dK
         CD8gBneUBtutD/k+d5MAGVg+hS3oWiIdHQfRYIBIi1dFinQQ9zcv7eyoc5ckeVBfgJVg
         RbTcdNEaepR3KjIAZKGQrbYJDGgluBGDuKWchI8Ikd5THNJP7cFUPP5chxAU4/kooJ4S
         RvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JV7ELz4kPbM5zN+d1pRguKa83wMKNN5UKfm4nAD4taw=;
        b=bQx5+iX9xk3SJYY8DMFD2lz9jc2/uCSO1jtM35ZQNAQ8tiep7T+9RUAXXean+kw4Pn
         0EEOSWQ7aS1qzrT3drS+F4xKP9qGk0VlVmxEy0N8KfZqTe1U/daPHk6uaHc1+IziherM
         Ngnpn4LTYTVRQIbEYc+Gyl5EX5onGKRkYtHlfr2Ulkc/OOb8npGXC6yH5/QE/cqswU0c
         OVYcjnAaqd0V/7O0XbHpG7J6kz1ZuSoSSyQeIcZmalkClY0rFFE6VuiGk4LwnsHWJYVz
         lS8J/rcD7FzURvirGT6x4cuMIcs5grkTsa5dSzTwb5F9sPcPGhVwVCdMRXOQfSc4mkNz
         Sk/Q==
X-Gm-Message-State: ACgBeo2TP5isePkxq78CdimUTMurAQTLkYn6/enZf4DX1ldQTcw+hlE0
        yQB55n2ENAWDd+8eTWWRci8=
X-Google-Smtp-Source: AA6agR7JuQ8AmkzZbiUb9JdfEksEYlWBob/c8uwbXZHDEDVTUf++BgJE+mLxqMRCQ2uPr3LIKZ0eAg==
X-Received: by 2002:aca:1810:0:b0:34f:b8d6:7999 with SMTP id h16-20020aca1810000000b0034fb8d67999mr230929oih.231.1663022098970;
        Mon, 12 Sep 2022 15:34:58 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:36b6:6fa1:2fec:e29b])
        by smtp.gmail.com with ESMTPSA id ep15-20020a056870a98f00b00127ebb410a4sm6016444oab.11.2022.09.12.15.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:34:58 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix memory leak in hpd_rx_irq_create_workqueue()
Date:   Mon, 12 Sep 2022 19:34:32 -0300
Message-Id: <20220912223433.630364-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

If construction of the array of work queues to handle hpd_rx_irq offload
work fails, we need to unwind. Destroy all the created workqueues and
the allocated memory for the hpd_rx_irq_offload_work_queue struct array.

Fixes: 8e794421bc98 ("drm/amd/display: Fork thread to offload work of hpd_rx_irq")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5140d9c2bf3b..6a2e455c5466 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1295,13 +1295,21 @@ static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct
 
 		if (hpd_rx_offload_wq[i].wq == NULL) {
 			DRM_ERROR("create amdgpu_dm_hpd_rx_offload_wq fail!");
-			return NULL;
+			goto out_err;
 		}
 
 		spin_lock_init(&hpd_rx_offload_wq[i].offload_lock);
 	}
 
 	return hpd_rx_offload_wq;
+
+out_err:
+	for (i = 0; i < max_caps; i++) {
+		if (hpd_rx_offload_wq[i].wq)
+			destroy_workqueue(hpd_rx_offload_wq[i].wq);
+	}
+	kfree(hpd_rx_offload_wq);
+	return NULL;
 }
 
 struct amdgpu_stutter_quirk {
-- 
2.34.1

