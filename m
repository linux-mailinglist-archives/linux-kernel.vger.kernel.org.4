Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406E7360D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjFTAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFTAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0010C2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687221798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c36xFgwQHAoO1A1GCpabxO1lgFTUT+xWChVASPsKB44=;
        b=SZgTK4et74me/SU8QEBlX/U2KwcvDRDbfGi2PEOf0F9zfgauojVsYplUJ+c0ZhnfnnxTek
        gQPH6SqYb2BW97gAImVHhunO3kJyDhbhcJxTTyZ9QAyXfs+n90IAjCv85rNaRDoDWBwf+l
        LP/gtyG0815oQoDLssn74QlNyQSHV+U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7DV09ebwOAifzqOHxtBIAw-1; Mon, 19 Jun 2023 20:43:15 -0400
X-MC-Unique: 7DV09ebwOAifzqOHxtBIAw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9715654aba1so419496566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221794; x=1689813794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c36xFgwQHAoO1A1GCpabxO1lgFTUT+xWChVASPsKB44=;
        b=ZvI2KJLWV3fWYs96qiExxujVYwSFmwij5eROhLO+vlAjIJCP9N+x21HLI5IVt1CHFO
         aTF4gzb+U/h0mKRJ+kEJ5DoXX7N/aY4aofWfSqBgn51N13T3CakvR074tQkiVEqd9Lnj
         A71oRoNtfpYdLmEsUrCEXUY/Ekul0zlqw9WBD9vgJxDv0kk0vTBXquB+ak+2jOE7uryR
         4wLCCBGFwQDmCVMfZSpbqXAWHMKwves+Kshp31Re0l60E1FuLMAoJKtmjNeKCNxNEa09
         WCp57zBTphhkdE4toHtZZ65cbitoDSLvShf5nCBzjHhE7LnlFU6ppBamkWA3s4N18In+
         hPeA==
X-Gm-Message-State: AC+VfDyFLMfeeFqe3LbcYWP5g3X5WHNlgPaRlON04CmfMfa+T77JMh+3
        osQRm98zoTLk/jUHPQ2zc84SjqOY+pPtKAq2iVfnH0ue3vkhGVDhbDTBK8cRoROnOM5XAmokszh
        qeLfya0kkFwFqXd0LrsJpb/4+
X-Received: by 2002:a17:907:1c0b:b0:987:4b4a:916b with SMTP id nc11-20020a1709071c0b00b009874b4a916bmr8546402ejc.24.1687221794629;
        Mon, 19 Jun 2023 17:43:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OvFPLVF40MGTxJIagtjtNVYW06w8dtjb7fvvD70Aoy/WisUVPQOpjflQ4lf0O6wzzqws8SQ==
X-Received: by 2002:a17:907:1c0b:b0:987:4b4a:916b with SMTP id nc11-20020a1709071c0b00b009874b4a916bmr8546386ejc.24.1687221794505;
        Mon, 19 Jun 2023 17:43:14 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906481700b00987258cf1f7sm382025ejq.154.2023.06.19.17.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:43:13 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v5 10/14] drm/nouveau: fence: fail to emit when fence context is killed
Date:   Tue, 20 Jun 2023 02:42:13 +0200
Message-Id: <20230620004217.4700-11-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620004217.4700-1-dakr@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
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
2.40.1

