Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAEC743091
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjF2W3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjF2W3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7835AB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688077654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgxfk7UZeray3y05yq1+nzs2/x42gYLAHbNBvbFNbko=;
        b=fcvH2sDbxcCbaUqdyNthGgHhgAvX+lxfqGrmqbOV0TshRYsrOpCuliJCs1VCqCJtsl9UN3
        IIk14BKYj9wHmLy3O7p04/wLj3Y+Ind3IauX9Xnhqg9AnBQ0Pf4BQujDOJVoeMNpr9Scn9
        zqINLvtVBfY4rDz0GETmSJgy5AN27FQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-dK5EdsJyM02396xB-X-uOg-1; Thu, 29 Jun 2023 18:27:32 -0400
X-MC-Unique: dK5EdsJyM02396xB-X-uOg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f9bd5c7fdfso6388805e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688077652; x=1690669652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgxfk7UZeray3y05yq1+nzs2/x42gYLAHbNBvbFNbko=;
        b=fOT4vxp+5nYDLXiEBa0xut87ereYHDyC/icDENMINnPQAfWxmLY5N8rPL47MJfUpr0
         bOUcATh8v9ux7m3oM4CYhQ9a5Hq/HvcpzXgWfj970/lyX8OzBmy2wY7XO2vvjHpIvCS1
         4ISWEVblqQAtwSAny3O38gxYcVATcow5hOYkoGPlG54mYsZGGJYoe6aROp9sYVjvbjea
         oh48fKiWGvlmQAGbw8JBLhCx9J6Xp7sauQQ1zO7qkq2LZcuV2cc8hi9F4nmW5HcIorLM
         39o9bGnFvqJ/TDad8Dd+jb6dYZVR35S40Iic7MvMmcD7fna5VBaBccEod6mOqXcKtc16
         OYBA==
X-Gm-Message-State: AC+VfDxBumE3SaGkMg8253B00opTMx5ZxnPR8/++sluCuhbHh8YbzHuD
        EyRReK+Zct6K4sp0W3zYfdNfjQ7S1YVeBna6HjQPGX+LxUvDLnu9wCVINUG9Gc/qp0n2cZqu1ac
        3rrisYUxkIBCND7jiczAxl36t
X-Received: by 2002:a05:600c:2204:b0:3fb:9ef2:157 with SMTP id z4-20020a05600c220400b003fb9ef20157mr439955wml.28.1688077651713;
        Thu, 29 Jun 2023 15:27:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zknnBDqjzn9f6dUOF8p9T0fijXSJgCGIALTAXk8bgUqBTq/rnqWQUi5EtyJc/uNZE8IJFUw==
X-Received: by 2002:a05:600c:2204:b0:3fb:9ef2:157 with SMTP id z4-20020a05600c220400b003fb9ef20157mr439943wml.28.1688077651494;
        Thu, 29 Jun 2023 15:27:31 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f9b2c602c0sm20503048wmh.37.2023.06.29.15.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:27:31 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v6 08/13] drm/nouveau: fence: separate fence alloc and emit
Date:   Fri, 30 Jun 2023 00:25:24 +0200
Message-ID: <20230629222651.3196-9-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629222651.3196-1-dakr@redhat.com>
References: <20230629222651.3196-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new (VM_BIND) UAPI exports DMA fences through DRM syncobjs. Hence,
in order to emit fences within DMA fence signalling critical sections
(e.g. as typically done in the DRM GPU schedulers run_job() callback) we
need to separate fence allocation and fence emitting.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c |  9 ++++-
 drivers/gpu/drm/nouveau/nouveau_bo.c    | 52 +++++++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_chan.c  |  6 ++-
 drivers/gpu/drm/nouveau/nouveau_dmem.c  |  9 +++--
 drivers/gpu/drm/nouveau/nouveau_fence.c | 16 +++-----
 drivers/gpu/drm/nouveau/nouveau_fence.h |  3 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c   |  5 ++-
 7 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index a6f2e681bde9..a34924523133 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -1122,11 +1122,18 @@ nv04_page_flip_emit(struct nouveau_channel *chan,
 	PUSH_NVSQ(push, NV_SW, NV_SW_PAGE_FLIP, 0x00000000);
 	PUSH_KICK(push);
 
-	ret = nouveau_fence_new(chan, false, pfence);
+	ret = nouveau_fence_new(pfence);
 	if (ret)
 		goto fail;
 
+	ret = nouveau_fence_emit(*pfence, chan);
+	if (ret)
+		goto fail_fence_unref;
+
 	return 0;
+
+fail_fence_unref:
+	nouveau_fence_unref(pfence);
 fail:
 	spin_lock_irqsave(&dev->event_lock, flags);
 	list_del(&s->head);
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 057bc995f19b..e9cbbf594e6f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -820,29 +820,39 @@ nouveau_bo_move_m2mf(struct ttm_buffer_object *bo, int evict,
 		mutex_lock(&cli->mutex);
 	else
 		mutex_lock_nested(&cli->mutex, SINGLE_DEPTH_NESTING);
+
 	ret = nouveau_fence_sync(nouveau_bo(bo), chan, true, ctx->interruptible);
-	if (ret == 0) {
-		ret = drm->ttm.move(chan, bo, bo->resource, new_reg);
-		if (ret == 0) {
-			ret = nouveau_fence_new(chan, false, &fence);
-			if (ret == 0) {
-				/* TODO: figure out a better solution here
-				 *
-				 * wait on the fence here explicitly as going through
-				 * ttm_bo_move_accel_cleanup somehow doesn't seem to do it.
-				 *
-				 * Without this the operation can timeout and we'll fallback to a
-				 * software copy, which might take several minutes to finish.
-				 */
-				nouveau_fence_wait(fence, false, false);
-				ret = ttm_bo_move_accel_cleanup(bo,
-								&fence->base,
-								evict, false,
-								new_reg);
-				nouveau_fence_unref(&fence);
-			}
-		}
+	if (ret)
+		goto out_unlock;
+
+	ret = drm->ttm.move(chan, bo, bo->resource, new_reg);
+	if (ret)
+		goto out_unlock;
+
+	ret = nouveau_fence_new(&fence);
+	if (ret)
+		goto out_unlock;
+
+	ret = nouveau_fence_emit(fence, chan);
+	if (ret) {
+		nouveau_fence_unref(&fence);
+		goto out_unlock;
 	}
+
+	/* TODO: figure out a better solution here
+	 *
+	 * wait on the fence here explicitly as going through
+	 * ttm_bo_move_accel_cleanup somehow doesn't seem to do it.
+	 *
+	 * Without this the operation can timeout and we'll fallback to a
+	 * software copy, which might take several minutes to finish.
+	 */
+	nouveau_fence_wait(fence, false, false);
+	ret = ttm_bo_move_accel_cleanup(bo, &fence->base, evict, false,
+					new_reg);
+	nouveau_fence_unref(&fence);
+
+out_unlock:
 	mutex_unlock(&cli->mutex);
 	return ret;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 1068abe41024..f47c0363683c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -62,9 +62,11 @@ nouveau_channel_idle(struct nouveau_channel *chan)
 		struct nouveau_fence *fence = NULL;
 		int ret;
 
-		ret = nouveau_fence_new(chan, false, &fence);
+		ret = nouveau_fence_new(&fence);
 		if (!ret) {
-			ret = nouveau_fence_wait(fence, false, false);
+			ret = nouveau_fence_emit(fence, chan);
+			if (!ret)
+				ret = nouveau_fence_wait(fence, false, false);
 			nouveau_fence_unref(&fence);
 		}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 789857faa048..4ad40e42cae1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -209,7 +209,8 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 		goto done;
 	}
 
-	nouveau_fence_new(dmem->migrate.chan, false, &fence);
+	if (!nouveau_fence_new(&fence))
+		nouveau_fence_emit(fence, dmem->migrate.chan);
 	migrate_vma_pages(&args);
 	nouveau_dmem_fence_done(&fence);
 	dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
@@ -402,7 +403,8 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 		}
 	}
 
-	nouveau_fence_new(chunk->drm->dmem->migrate.chan, false, &fence);
+	if (!nouveau_fence_new(&fence))
+		nouveau_fence_emit(fence, chunk->drm->dmem->migrate.chan);
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	nouveau_dmem_fence_done(&fence);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
@@ -675,7 +677,8 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
 		addr += PAGE_SIZE;
 	}
 
-	nouveau_fence_new(drm->dmem->migrate.chan, false, &fence);
+	if (!nouveau_fence_new(&fence))
+		nouveau_fence_emit(fence, chunk->drm->dmem->migrate.chan);
 	migrate_vma_pages(args);
 	nouveau_dmem_fence_done(&fence);
 	nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index ee5e9d40c166..e946408f945b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -210,6 +210,9 @@ nouveau_fence_emit(struct nouveau_fence *fence, struct nouveau_channel *chan)
 	struct nouveau_fence_priv *priv = (void*)chan->drm->fence;
 	int ret;
 
+	if (unlikely(!chan->fence))
+		return -ENODEV;
+
 	fence->channel  = chan;
 	fence->timeout  = jiffies + (15 * HZ);
 
@@ -396,25 +399,16 @@ nouveau_fence_unref(struct nouveau_fence **pfence)
 }
 
 int
-nouveau_fence_new(struct nouveau_channel *chan, bool sysmem,
-		  struct nouveau_fence **pfence)
+nouveau_fence_new(struct nouveau_fence **pfence)
 {
 	struct nouveau_fence *fence;
-	int ret = 0;
-
-	if (unlikely(!chan->fence))
-		return -ENODEV;
 
 	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
 	if (!fence)
 		return -ENOMEM;
 
-	ret = nouveau_fence_emit(fence, chan);
-	if (ret)
-		nouveau_fence_unref(&fence);
-
 	*pfence = fence;
-	return ret;
+	return 0;
 }
 
 static const char *nouveau_fence_get_get_driver_name(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.h b/drivers/gpu/drm/nouveau/nouveau_fence.h
index 0ca2bc85adf6..7c73c7c9834a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.h
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.h
@@ -17,8 +17,7 @@ struct nouveau_fence {
 	unsigned long timeout;
 };
 
-int  nouveau_fence_new(struct nouveau_channel *, bool sysmem,
-		       struct nouveau_fence **);
+int  nouveau_fence_new(struct nouveau_fence **);
 void nouveau_fence_unref(struct nouveau_fence **);
 
 int  nouveau_fence_emit(struct nouveau_fence *, struct nouveau_channel *);
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index a48f42aaeab9..9c8d1b911a01 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -873,8 +873,11 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 		}
 	}
 
-	ret = nouveau_fence_new(chan, false, &fence);
+	ret = nouveau_fence_new(&fence);
+	if (!ret)
+		ret = nouveau_fence_emit(fence, chan);
 	if (ret) {
+		nouveau_fence_unref(&fence);
 		NV_PRINTK(err, cli, "error fencing pushbuf: %d\n", ret);
 		WIND_RING(chan);
 		goto out;
-- 
2.41.0

