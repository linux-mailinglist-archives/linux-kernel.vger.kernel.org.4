Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3096D561A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjDDBaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjDDB33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED81FC4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680571715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFDnwLdkC+a84lmheZyyv02Y7sEGNyBLjO5UYHqgwOc=;
        b=RkrfMZjUnVt71py2jam34nXnQWqJEQMQFbjfDw8wE99w2AVhru8aGvz5yxdSuyhmEFAHi+
        QpoDmHMlB/sUCTZfVeI4RKf7C6JUOxbJHOT1nf7ZLJ82ZSehBPR/uZVJF4IP8VOXwQ+JBV
        Wu6UQPbPMT283Sq6a4fAj9qmKGK2hew=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-z1mnrVkCM2OzFnge8hSjRg-1; Mon, 03 Apr 2023 21:28:33 -0400
X-MC-Unique: z1mnrVkCM2OzFnge8hSjRg-1
Received: by mail-ed1-f71.google.com with SMTP id t26-20020a50d71a000000b005003c5087caso43213927edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFDnwLdkC+a84lmheZyyv02Y7sEGNyBLjO5UYHqgwOc=;
        b=zdakXcqsde5ODeXJplDVHo1AOAucntNaVqZ+9/oUTwIkUDoVtL4EG3PISGaIqjLMzD
         nUd6ccaN6unod3nazs+XxrnugC541YcE0rxmi5+6GJlZ7G+F/lltJ8I8x6yr/qHwJK2V
         erZsCX1YT00NEXW4b2Rp2hH5iS1ogwGMZpkRVNEkOibJoNkB41Qcj9VP9nbqEAW/yI9W
         vs9zzs2FlIcQ+wjTWUf+2Uao69ANJrocClTOhzcRlrRgS1ElEjJTWRwUtnR7Tts4+t7i
         3/v7YuHzC9n8tzN+P7vXCkzgtm8R7vUMV93Q/NdrnR+aV83SYUZc8Y+Tn3yIs9Z+APG9
         29Sw==
X-Gm-Message-State: AAQBX9fO+kvCTPm4YA6JW6EQekrMM/4jctph2GRZWPywQXnCW9l5iErL
        PxYeXYn+//jgeaBu9AirPGsm0WVwQQWYcLKcJYdAp5jYhjz8G5gsr1XKDT+5mClmM8i3QYONu7m
        QkgBvZ6B2h3+YJcBEKItMM64d
X-Received: by 2002:a17:907:3f22:b0:931:86cf:9556 with SMTP id hq34-20020a1709073f2200b0093186cf9556mr754089ejc.23.1680571712721;
        Mon, 03 Apr 2023 18:28:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350bTvpbIk/GmxFlxt18RFwL9YdKIZ4Q77ktCoQzFycA8gGsVYWiQjvWZuLDin9qz3iy+Fs1c5A==
X-Received: by 2002:a17:907:3f22:b0:931:86cf:9556 with SMTP id hq34-20020a1709073f2200b0093186cf9556mr754076ejc.23.1680571712535;
        Mon, 03 Apr 2023 18:28:32 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id n6-20020a5099c6000000b004aee4e2a56esm5318778edb.0.2023.04.03.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:28:32 -0700 (PDT)
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
Subject: [PATCH drm-next v3 12/15] drm/nouveau: chan: provide nouveau_channel_kill()
Date:   Tue,  4 Apr 2023 03:27:38 +0200
Message-Id: <20230404012741.116502-13-dakr@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404012741.116502-1-dakr@redhat.com>
References: <20230404012741.116502-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new VM_BIND UAPI implementation introduced in subsequent commits
will allow asynchronous jobs processing push buffers and emitting fences.

If a job times out, we need a way to recover from this situation. For
now, simply kill the channel to unblock all hung up jobs and signal
userspace that the device is dead on the next EXEC or VM_BIND ioctl.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 14 +++++++++++---
 drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index f47c0363683c..a975f8b0e0e5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -40,6 +40,14 @@ MODULE_PARM_DESC(vram_pushbuf, "Create DMA push buffers in VRAM");
 int nouveau_vram_pushbuf;
 module_param_named(vram_pushbuf, nouveau_vram_pushbuf, int, 0400);
 
+void
+nouveau_channel_kill(struct nouveau_channel *chan)
+{
+	atomic_set(&chan->killed, 1);
+	if (chan->fence)
+		nouveau_fence_context_kill(chan->fence, -ENODEV);
+}
+
 static int
 nouveau_channel_killed(struct nvif_event *event, void *repv, u32 repc)
 {
@@ -47,9 +55,9 @@ nouveau_channel_killed(struct nvif_event *event, void *repv, u32 repc)
 	struct nouveau_cli *cli = (void *)chan->user.client;
 
 	NV_PRINTK(warn, cli, "channel %d killed!\n", chan->chid);
-	atomic_set(&chan->killed, 1);
-	if (chan->fence)
-		nouveau_fence_context_kill(chan->fence, -ENODEV);
+
+	if (unlikely(!atomic_read(&chan->killed)))
+		nouveau_channel_kill(chan);
 
 	return NVIF_EVENT_DROP;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index e06a8ffed31a..e483f4a254da 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -65,6 +65,7 @@ int  nouveau_channel_new(struct nouveau_drm *, struct nvif_device *, bool priv,
 			 u32 vram, u32 gart, struct nouveau_channel **);
 void nouveau_channel_del(struct nouveau_channel **);
 int  nouveau_channel_idle(struct nouveau_channel *);
+void nouveau_channel_kill(struct nouveau_channel *);
 
 extern int nouveau_vram_pushbuf;
 
-- 
2.39.2

