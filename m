Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1773A4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjFVPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjFVPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F1E75
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687447225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GMA8wGndW1W3qKjciAhlPaH569xG8UzR5aTyG8RbL8A=;
        b=cHFcmLEBlty9JjwmgRO0OtBC9USxDgIL4yHrEIlhsArSeAFFwiag+AIwYlM/D/8FvR74oN
        DhksVPo+PLkgpeoB8VpMnAGuQDC811bbZOL4j2elitPYCK6RGa0b/gAOojcz8+pLHFLOQC
        PXlMU0s6trmRxFxq7OmJb4LlH5Nxya8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-t34ytYsHPmKAG7dgdJZmLQ-1; Thu, 22 Jun 2023 11:20:23 -0400
X-MC-Unique: t34ytYsHPmKAG7dgdJZmLQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76248f3057bso97349685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447222; x=1690039222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMA8wGndW1W3qKjciAhlPaH569xG8UzR5aTyG8RbL8A=;
        b=TuWQQ+vMMHAI9gFzB7OjOR91SRVq1lIdp3e6LMWibURu6IpbDm1Gk8GcLbBa1SiwWi
         luIJ+iRczXFQxQCRDbDLuyHFHiu1ylBMFwPm0QwLOdzTRhb2AbLq+mFETbuqLFjcSLB8
         9ktlHt8Cf0kwVwSzh9ya6vxe1DZo11smxFhohYY98YucaOjMzCZranDVWcPbGEhUhlwA
         3DcwHxzDM1mxZF7dOI++wmFkxS8jFOS1QCeRMFuoqgwz27h+hzzzcqwRXTBBenVR94BR
         Ex/0ZMOPHdBKeYjyFS06f4MiqXAm7UmE9Twp1/kpBLcR7kVe06L5nY6MegTvErAbHD29
         WGCQ==
X-Gm-Message-State: AC+VfDzSf5CzfMCnTDlSKZZGT4wPUKEdZtTBH4tp57J+R+NM6AJTV6yG
        h8Ssgc1DMEDO2jQ/gptA5mEJPqROzjOi3VVN2qcZzfAUI+b4ExFjaCKtRHs3HP0D4h/spFaqbuj
        gE7TBhbS//5Go0WQMFw8A5JODxkTPUgUsygbcfX/lhUDPRqrZqE2QdVtCaG1n9HBu5UYUaAbsjS
        XGoWy8pJE=
X-Received: by 2002:a05:622a:1b8c:b0:3fd:def0:57fb with SMTP id bp12-20020a05622a1b8c00b003fddef057fbmr22153329qtb.6.1687447221716;
        Thu, 22 Jun 2023 08:20:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bOzGejNL9heS5tg9yZzKLbqW+z4bcegBQgxfOE33k3iRU6uDJF1Thh4gS9a3ffxTuKXKluQ==
X-Received: by 2002:a05:622a:1b8c:b0:3fd:def0:57fb with SMTP id bp12-20020a05622a1b8c00b003fddef057fbmr22153311qtb.6.1687447221348;
        Thu, 22 Jun 2023 08:20:21 -0700 (PDT)
Received: from kherbst.pingu (ip5f5a301e.dynamic.kabel-deutschland.de. [95.90.48.30])
        by smtp.gmail.com with ESMTPSA id bp20-20020a05622a1b9400b003ff251b17c8sm3701072qtb.10.2023.06.22.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:20:20 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        nouveau@lists.freedesktop.org, stable@vger.kernel.org
Subject: [PATCH v2] drm/nouveau/gr: enable memory loads on helper invocation on all channels
Date:   Thu, 22 Jun 2023 17:20:17 +0200
Message-ID: <20230622152017.2512101-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a lurking bug where Fragment Shader Helper Invocations can't load
from memory. But this is actually required in OpenGL and is causing random
hangs or failures in random shaders.

It is unknown how widespread this issue is, but shaders hitting this can
end up with infinite loops.

We enable those only on all Kepler and newer GPUs where we use our own
Firmware.

Nvidia's firmware provides a way to set a kernelspace controlled list of
mmio registers in the gr space from push buffers via MME macros.

v2: drop code for gm200 and newer.

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: nouveau@lists.freedesktop.org
Cc: stable@vger.kernel.org
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |  4 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  | 10 ++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |  1 +
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
index 00dbeda7e346..de161e7a04aa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
@@ -117,6 +117,7 @@ void gk104_grctx_generate_r418800(struct gf100_gr *);
 
 extern const struct gf100_grctx_func gk110_grctx;
 void gk110_grctx_generate_r419eb0(struct gf100_gr *);
+void gk110_grctx_generate_r419f78(struct gf100_gr *);
 
 extern const struct gf100_grctx_func gk110b_grctx;
 extern const struct gf100_grctx_func gk208_grctx;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
index 94233d0119df..52a234b1ef01 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
@@ -906,7 +906,9 @@ static void
 gk104_grctx_generate_r419f78(struct gf100_gr *gr)
 {
 	struct nvkm_device *device = gr->base.engine.subdev.device;
-	nvkm_mask(device, 0x419f78, 0x00000001, 0x00000000);
+
+	/* bit 3 set disables loads in fp helper invocations, we need it enabled */
+	nvkm_mask(device, 0x419f78, 0x00000009, 0x00000000);
 }
 
 void
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
index 4391458e1fb2..3acdd9eeb74a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
@@ -820,6 +820,15 @@ gk110_grctx_generate_r419eb0(struct gf100_gr *gr)
 	nvkm_mask(device, 0x419eb0, 0x00001000, 0x00001000);
 }
 
+void
+gk110_grctx_generate_r419f78(struct gf100_gr *gr)
+{
+	struct nvkm_device *device = gr->base.engine.subdev.device;
+
+	/* bit 3 set disables loads in fp helper invocations, we need it enabled */
+	nvkm_mask(device, 0x419f78, 0x00000008, 0x00000000);
+}
+
 const struct gf100_grctx_func
 gk110_grctx = {
 	.main  = gf100_grctx_generate_main,
@@ -854,4 +863,5 @@ gk110_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
index 7b9a34f9ec3c..5597e87624ac 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
@@ -103,4 +103,5 @@ gk110b_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
index c78d07a8bb7d..612656496541 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
@@ -568,4 +568,5 @@ gk208_grctx = {
 	.dist_skip_table = gf117_grctx_generate_dist_skip_table,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
index beac66eb2a80..9906974ac3f0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
@@ -988,4 +988,5 @@ gm107_grctx = {
 	.r406500 = gm107_grctx_generate_r406500,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r419e00 = gm107_grctx_generate_r419e00,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
-- 
2.41.0

