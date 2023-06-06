Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F145724FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbjFFWdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbjFFWdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B38B1982
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686090745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c36xFgwQHAoO1A1GCpabxO1lgFTUT+xWChVASPsKB44=;
        b=FA/fJ0fCdNS2ScfvBb4a9NJPBcSxPkTTrgMTe9EbntPBYCg9VBT4Q1qTO8+gst3iAe0j/f
        oqqWflxZHmb/ORWul24fXPXZ46j/o/b3rPoaPh43Lm8Hgr1i9q3qtLwNgVry2xC1amB7LU
        lKLJbQOSdnQsKS7g7YSgT9XpEVmHpYE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-0zRC2ssRN9SHbnGUPu6gXg-1; Tue, 06 Jun 2023 18:32:21 -0400
X-MC-Unique: 0zRC2ssRN9SHbnGUPu6gXg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355c9028so515856566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090740; x=1688682740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c36xFgwQHAoO1A1GCpabxO1lgFTUT+xWChVASPsKB44=;
        b=UqA23qEMVPYbi5JGFGFCDYMNuNTCz3eZwPl2vxXaSFDo/UFVbFN1lh5+a8zKBpMcf9
         pgN6eYIJS2haDfMETJEttTTsNoHT+4MrpBVFmXjhGqsWnVtELF+9SprBV+eYwC007Svv
         vAaZWfWAPgKmG04bFarXlo8d9/ThzyMflEEpuNtAVwlWZOe3gqu1uIjMNytlOTYAwggh
         weweOQMPsyINyjCuMlSjHyTbRcjGQ4nXELraXBsbIz2UKpuG1z7vaDCN07kbWnO8lR2z
         Cn/8EAi8m6e8tx87SLgIYLjB2B7wQ+kjm5R1FrJpwBhQwZQpWgq/xkI1Z2zlSC1Gteev
         N3+Q==
X-Gm-Message-State: AC+VfDzO8OS8pwvoH3+s1A3uNuNpGp9kS+rZX0Oo62/8AUTF0LVsgVu4
        3jpaIMBprKwZGe3JhuLQxp7cVPIQW6WpCXLy8rTvvn2oNbRXJUnYb92EwkS24/6g2RT7n7c5yZt
        ycMngJd/lsqsCSi/TR7iorFB3
X-Received: by 2002:a17:907:d1a:b0:974:419d:7847 with SMTP id gn26-20020a1709070d1a00b00974419d7847mr3616084ejc.71.1686090740771;
        Tue, 06 Jun 2023 15:32:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4c77MVfNEYeE8GhdIDJycSs/OSi0sKY1h3c6R7iuE+ANA00tKPgkq6qTOt3RlMI31QUCDJhQ==
X-Received: by 2002:a17:907:d1a:b0:974:419d:7847 with SMTP id gn26-20020a1709070d1a00b00974419d7847mr3616072ejc.71.1686090740566;
        Tue, 06 Jun 2023 15:32:20 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id bg11-20020a170906a04b00b0094f282fc29asm6060829ejb.207.2023.06.06.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:32:20 -0700 (PDT)
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
Subject: [PATCH drm-next v4 10/14] drm/nouveau: fence: fail to emit when fence context is killed
Date:   Wed,  7 Jun 2023 00:31:26 +0200
Message-Id: <20230606223130.6132-11-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606223130.6132-1-dakr@redhat.com>
References: <20230606223130.6132-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

