Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE419743095
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjF2W3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF2W3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0668C35AF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688077658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pp7pCNssCFdX07s9SqyoLBjaIvnkOQtt7NO/vv36Sc=;
        b=XW3sD7BI1xYF/dME6RfUk9chTtu1ZDKYq2GnVa6ymGhvQLdqIMbnKelQ537IvVis6LwuYX
        Braduh370NQ5hu93aVcL45tYRi7jMh28aVXzyp5HAsQkr3P/ktydOtsMU5vOF3gPtWr0Cb
        ECBpErNfn3gjVtM/TiOYWQ93vlpYVMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ylnnXsNbP4e1nfZYLWmbTA-1; Thu, 29 Jun 2023 18:27:36 -0400
X-MC-Unique: ylnnXsNbP4e1nfZYLWmbTA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313f376d2adso1511554f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688077655; x=1690669655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pp7pCNssCFdX07s9SqyoLBjaIvnkOQtt7NO/vv36Sc=;
        b=LPhojg01FPn9UT8v3sS6+Te2anozMleWnQL6dpU36+3xW6hqxc+Lh14Y3rYgMkZb8e
         9roQREfvLhnn4AbaR6Y1fWPqsa7HAIb8OUzKBQXhzzFXgsiP79AdtLJq1fj8Ia7TeQPB
         D/qNLWQNPkH1kmS04w6XkNscrlEpZTs0PkMwM48OW7RNpAJ0Of9wXEoOGmKFi/zaXlOd
         jmEVlf08ApyY3R/SrXqqvatqFGhTphkCsnsZcNAwZSK3gycOH7ibV5mtOUQLTupDLBNu
         og+bDssX1aDqtdnmKklwYErSRWYtG2FOMlbMCYwX9mvtPHiRvRp3JqdiLNN/2vNXBiD4
         wWmg==
X-Gm-Message-State: ABy/qLZJ7WDs8zYc8F7SzXfcToxLrWxfUKU1Rrnqgd0LxVPvBB/GAHhx
        8R/nrBDfct8Onte4qGaUhbIIQ2M/Ppd2CzIH8PxL57K1omfNOY1LlPJ4gz8DPTDQ1DfRtAWnHfh
        mJ4B/HkBYbxsUNgiEOIgHHpgv
X-Received: by 2002:a5d:525c:0:b0:313:f61c:42bd with SMTP id k28-20020a5d525c000000b00313f61c42bdmr750851wrc.59.1688077655559;
        Thu, 29 Jun 2023 15:27:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmqOL6OvZYLEHImUuHmBKbH1ljfnPJQLh9s5Ol4fUmQzA+pAg2LS4yxPJw5oYwNr77kuWmwA==
X-Received: by 2002:a5d:525c:0:b0:313:f61c:42bd with SMTP id k28-20020a5d525c000000b00313f61c42bdmr750845wrc.59.1688077655340;
        Thu, 29 Jun 2023 15:27:35 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d5682000000b00313ec7dd652sm13949454wrv.44.2023.06.29.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:27:34 -0700 (PDT)
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
Subject: [PATCH drm-next v6 09/13] drm/nouveau: fence: fail to emit when fence context is killed
Date:   Fri, 30 Jun 2023 00:25:25 +0200
Message-ID: <20230629222651.3196-10-dakr@redhat.com>
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

The new VM_BIND UAPI implementation introduced in subsequent commits
will allow asynchronous jobs processing push buffers and emitting
fences.

If a fence context is killed, e.g. due to a channel fault, jobs which
are already queued for execution might still emit new fences. In such a
case a job would hang forever.

To fix that, fail to emit a new fence on a killed fence context with
-ENODEV to unblock the job.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 7 +++++++
 drivers/gpu/drm/nouveau/nouveau_fence.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index e946408f945b..77c739a55b19 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -96,6 +96,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 		if (nouveau_fence_signal(fence))
 			nvif_event_block(&fctx->event);
 	}
+	fctx->killed = 1;
 	spin_unlock_irqrestore(&fctx->lock, flags);
 }
 
@@ -229,6 +230,12 @@ nouveau_fence_emit(struct nouveau_fence *fence, struct nouveau_channel *chan)
 		dma_fence_get(&fence->base);
 		spin_lock_irq(&fctx->lock);
 
+		if (unlikely(fctx->killed)) {
+			spin_unlock_irq(&fctx->lock);
+			dma_fence_put(&fence->base);
+			return -ENODEV;
+		}
+
 		if (nouveau_fence_update(chan, fctx))
 			nvif_event_block(&fctx->event);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.h b/drivers/gpu/drm/nouveau/nouveau_fence.h
index 7c73c7c9834a..2c72d96ef17d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.h
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.h
@@ -44,7 +44,7 @@ struct nouveau_fence_chan {
 	char name[32];
 
 	struct nvif_event event;
-	int notify_ref, dead;
+	int notify_ref, dead, killed;
 };
 
 struct nouveau_fence_priv {
-- 
2.41.0

