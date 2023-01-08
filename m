Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C516619AB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjAHVFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjAHVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:05:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4910FD2
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:05:20 -0800 (PST)
Received: from workpc.. (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD0AF6602D58;
        Sun,  8 Jan 2023 21:05:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673211919;
        bh=JyCBBj57CG4UEcAgh5XlzQP+feZackRuTqvxuLO6FXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMFI6j7Z/T6DFKbnAwdQfrut6aKsVYXV2dofNiQFb8CHb2TvhtrF1RAT5Owkh21pd
         zFZwfVhTuPc6d6HtY8XCp/H/+BTNs7tgh+E23b0tqHSJ6kL8jirWu4CNCT5WxDvdrs
         N2sn8QQL/Ubbe12w4IqmdkfmLO79q119DJM2U9aeP0Yo1GHqLX883ISRdB42EUHssP
         MFHguzwQ92PPxqBQpymOxN5duVcrhdZGZZ47MyvBylI+5uWlmLBTKbr0Uwem1o7Y78
         wNtTABMZM+yXa+R8rqLut5ih+fT5pOLzkbGP8PMS0IrDSIsyuAiJQflAJSXyfEbL50
         pmUs+CKgmjl7Q==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v10 02/11] drm/panfrost: Don't sync rpm suspension after mmu flushing
Date:   Mon,  9 Jan 2023 00:04:36 +0300
Message-Id: <20230108210445.3948344-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep warns about potential circular locking dependency of devfreq
with the fs_reclaim caused by immediate device suspension when mapping is
released by shrinker. Fix it by doing the suspension asynchronously.

Reviewed-by: Steven Price <steven.price@arm.com>
Fixes: ec7eba47da86 ("drm/panfrost: Rework page table flushing and runtime PM interaction ")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4e83a1891f3e..666a5e53fe19 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -282,7 +282,7 @@ static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
 	if (pm_runtime_active(pfdev->dev))
 		mmu_hw_do_operation(pfdev, mmu, iova, size, AS_COMMAND_FLUSH_PT);
 
-	pm_runtime_put_sync_autosuspend(pfdev->dev);
+	pm_runtime_put_autosuspend(pfdev->dev);
 }
 
 static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
-- 
2.38.1

