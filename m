Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0552702CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbjEOMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjEOMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DEE8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684154685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cZmYTRAn7NU2pb19zTAYR+mb+ybNs5nlZD8A2O1lVGg=;
        b=BRSQKWoM4VoSkINoJvkv0cehlO7dpZoGXR7QbFiIWktbScCtzesdit3Uja1fLpaBOhj8Ek
        TPWdUbII/bambe/q+eyBeST30/8S8XSxqBKtndLOWDMjGuHQhUI/zfyv7xa4OAFWOjlj67
        zoeXyViTOKisLn76OrSHVRLkdirJitE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-spG2B6z5MNKc3u8f5NSdxA-1; Mon, 15 May 2023 08:44:43 -0400
X-MC-Unique: spG2B6z5MNKc3u8f5NSdxA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f4b96aa44aso8295205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684154682; x=1686746682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZmYTRAn7NU2pb19zTAYR+mb+ybNs5nlZD8A2O1lVGg=;
        b=HUhCoju+C7ggmsd8QCqasztQgUK8WZHiqQ39N+lGc86UrdtP2ZBg/rVtZE+SgQZkOC
         o08+Fb6/cB+mJuYBWbuhD4k7uq7ioveMMrJWnuSQhr7SF78ALwNE/6FPay904+mPxCsR
         ei5HK7OVJLpMCddNTOuMGBRrEoy8UH01R++CTw8JbSFhHUfbxMX5I73iiYcvcgBkPuer
         gAryFtbO+dHoLvrcVD6+TXd5Z7aBCrbC8NBJlsazlCW+LtyhMIKyxinZv+xV9c7531R5
         asSCfkm/VjPLn7Gka/wml5cS43qFObiAmBSXjUJUMCQOpyeaWbY4a4yTGcZqO2pEBzHK
         f9wA==
X-Gm-Message-State: AC+VfDyxoNVSTcdoUQfAdXuIU7J/BPLaIAEgpLTeu2lALaJOmlRTBGMp
        +0dmGR4v5hkFtYbNrzTmKxqiS1oMuMJIXwN6Le1Ud7Ty0ZNDgmcrSV1tKxvc2jPYzF9cJHiXac8
        g0bud+xf3oRaW/XvBxbX30da+sQDrLtSFFFPAnmcvjLeu1Dn0bnJpFUZgE9pWdKP3rqHFOwYPAk
        zl3Qm3uD4=
X-Received: by 2002:a05:600c:35cf:b0:3f4:f204:4968 with SMTP id r15-20020a05600c35cf00b003f4f2044968mr8731457wmq.1.1684154682270;
        Mon, 15 May 2023 05:44:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76ly2s9BWGl+80vve46j05skeM6iSlOiqEvBV8GMj96bvOhN4iMHwcgu7nH9/0EeHx5tw9DQ==
X-Received: by 2002:a05:600c:35cf:b0:3f4:f204:4968 with SMTP id r15-20020a05600c35cf00b003f4f2044968mr8731434wmq.1.1684154681806;
        Mon, 15 May 2023 05:44:41 -0700 (PDT)
Received: from kherbst.pingu (ip1f1032e8.dynamic.kabel-deutschland.de. [31.16.50.232])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003f43f82001asm17024977wmi.31.2023.05.15.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:44:41 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>
Subject: [PATCH] drm/nouveau: bring back blit subchannel for pre nv50 GPUs
Date:   Mon, 15 May 2023 14:44:39 +0200
Message-Id: <20230515124439.257585-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1ba6113a90a0 removed a lot of the kernel GPU channel, but method 0x128
was important as otherwise the GPU spams us with `CACHE_ERROR` messages.

We use the blit subchannel inside our vblank handling, so we should keep
at least this part.

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/201
Fixes: 4a16dd9d18a0 ("drm/nouveau/kms: switch to drm fbdev helpers")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c |  1 +
 drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c  | 19 ++++++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index e648ecd0c1a0..3dfbc374478e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -90,6 +90,7 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		if (cli)
 			nouveau_svmm_part(chan->vmm->svmm, chan->inst);
 
+		nvif_object_dtor(&chan->blit);
 		nvif_object_dtor(&chan->nvsw);
 		nvif_object_dtor(&chan->gart);
 		nvif_object_dtor(&chan->vram);
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index e06a8ffed31a..bad7466bd0d5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -53,6 +53,7 @@ struct nouveau_channel {
 	u32 user_put;
 
 	struct nvif_object user;
+	struct nvif_object blit;
 
 	struct nvif_event kill;
 	atomic_t killed;
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index cc7c5b4a05fd..59e040a93a41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -369,15 +369,28 @@ nouveau_accel_gr_init(struct nouveau_drm *drm)
 		ret = nvif_object_ctor(&drm->channel->user, "drmNvsw",
 				       NVDRM_NVSW, nouveau_abi16_swclass(drm),
 				       NULL, 0, &drm->channel->nvsw);
+
+		if (ret == 0) {
+			u32 blit_class = device->info.chipset >= 0x11 ? 0x009f : 0x005f;
+			ret = nvif_object_ctor(&drm->channel->user, "drmBlit",
+					       0x005f, blit_class,
+					       NULL, 0, &drm->channel->blit);
+		}
+
 		if (ret == 0) {
 			struct nvif_push *push = drm->channel->chan.push;
-			ret = PUSH_WAIT(push, 2);
-			if (ret == 0)
+			ret = PUSH_WAIT(push, 8);
+			if (ret == 0) {
+				PUSH_NVSQ(push, NV05F, 0x0000, drm->channel->blit.handle);
+				PUSH_NVSQ(push, NV09F, 0x0120, 0,
+						       0x0124, 1,
+						       0x0128, 2);
 				PUSH_NVSQ(push, NV_SW, 0x0000, drm->channel->nvsw.handle);
+			}
 		}
 
 		if (ret) {
-			NV_ERROR(drm, "failed to allocate sw class, %d\n", ret);
+			NV_ERROR(drm, "failed to allocate sw or blit class, %d\n", ret);
 			nouveau_accel_gr_fini(drm);
 			return;
 		}
-- 
2.40.1

