Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420A4712323
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbjEZJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEZJLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40B119
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685092257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pfhQPnMMVxGy9HVpRogR5S0+kfWfaO5hPxVfZgqeerw=;
        b=c8ymukndlLvA6dMOPxz0HuQkb5OuWEH9cxLtbpKqs6UtBl6ZtcCM64ZnezLVRAew+eaqta
        G6GJ78zzTxIymHVSHeJYZFx6+ZDwSMhGLSoL9EEB1k5in8/cc6dFCi76Y/KcFxe5dudTJb
        EbB2qsBs0mCLq6sT1i8lcbRp7BCERb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-artPWZ4NP5ShqXZaIgiFoA-1; Fri, 26 May 2023 05:10:55 -0400
X-MC-Unique: artPWZ4NP5ShqXZaIgiFoA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5fde052b6so999205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685092254; x=1687684254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfhQPnMMVxGy9HVpRogR5S0+kfWfaO5hPxVfZgqeerw=;
        b=dyXvhNmlq3zQEmWhuK2p9GFCq5WPevSyWswjMx+admVvfjIBjXRMLVCblPh/CpbZr8
         zS32jzXgoFcmARaXTya9AXBSQ7KKek9CDkgkaWrL1yfFgy2tj5Ibu7uPjawNXPulAA4m
         TM32NxjAQQw/Q/cGcTfu3NyhNaMhVpfjJOasPsMHQfQ7Nim0H0SRvEEQYjMhepbgJbmY
         fibRi4nC1BmeOj40VTo4WMpJUqVeEmVQF21Lv3G4VFR7f+ilKmMBL/vcc78+5OJeBaJ4
         lZG4RwCtjz2hfqgyLy1LG34NZ8oAvIUBNlfaLxeD/sO/zwQ+pbpDSpMTyiS4/MjA7NiJ
         AECQ==
X-Gm-Message-State: AC+VfDyilhL3z5QgJ9yyixJXqXPWhawC6j3QycX0DLt4LKI+i8GNWwZH
        VBHVfVI5rza6TIDLDp3kV7f4v5bK/sZGRDTkYinFKiGm7vbPdoOu0aED2xRhxEsvDk+2eyvZUoD
        L/c/VtOJz4JoKm+VYpBGFLsP61QJ76nO+9ripM70uO0O/M54y5qugQFQKveDG42chNPSMg290yh
        nbfPmHTKs=
X-Received: by 2002:a5d:4089:0:b0:305:ed26:856e with SMTP id o9-20020a5d4089000000b00305ed26856emr726549wrp.4.1685092254097;
        Fri, 26 May 2023 02:10:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7saa/44Q0pwfx5BthoXdKEazE+VPecBiWDTDxgSxJeja34PRg2BVqeRTUB/dal6RLuLcQ8aA==
X-Received: by 2002:a5d:4089:0:b0:305:ed26:856e with SMTP id o9-20020a5d4089000000b00305ed26856emr726532wrp.4.1685092253802;
        Fri, 26 May 2023 02:10:53 -0700 (PDT)
Received: from kherbst.pingu (ip1f1032e8.dynamic.kabel-deutschland.de. [31.16.50.232])
        by smtp.gmail.com with ESMTPSA id z16-20020adfe550000000b003063a92bbf5sm4474553wrm.70.2023.05.26.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 02:10:53 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2] drm/nouveau: bring back blit subchannel for pre nv50 GPUs
Date:   Fri, 26 May 2023 11:10:52 +0200
Message-Id: <20230526091052.2169044-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1ba6113a90a0 removed a lot of the kernel GPU channel, but method 0x128
was important as otherwise the GPU spams us with `CACHE_ERROR` messages.

We use the blit subchannel inside our vblank handling, so we should keep
at least this part.

v2: Only do it for NV11+ GPUs

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/201
Fixes: 4a16dd9d18a0 ("drm/nouveau/kms: switch to drm fbdev helpers")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c |  1 +
 drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c  | 20 +++++++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

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
index cc7c5b4a05fd..9512f1c2f871 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -369,15 +369,29 @@ nouveau_accel_gr_init(struct nouveau_drm *drm)
 		ret = nvif_object_ctor(&drm->channel->user, "drmNvsw",
 				       NVDRM_NVSW, nouveau_abi16_swclass(drm),
 				       NULL, 0, &drm->channel->nvsw);
+
+		if (ret == 0 && device->info.chipset >= 0x11) {
+			ret = nvif_object_ctor(&drm->channel->user, "drmBlit",
+					       0x005f, 0x009f,
+					       NULL, 0, &drm->channel->blit);
+		}
+
 		if (ret == 0) {
 			struct nvif_push *push = drm->channel->chan.push;
-			ret = PUSH_WAIT(push, 2);
-			if (ret == 0)
+			ret = PUSH_WAIT(push, 8);
+			if (ret == 0) {
+				if (device->info.chipset >= 0x11) {
+					PUSH_NVSQ(push, NV05F, 0x0000, drm->channel->blit.handle);
+					PUSH_NVSQ(push, NV09F, 0x0120, 0,
+							       0x0124, 1,
+							       0x0128, 2);
+				}
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

