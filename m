Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDD7360D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFTAoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFTAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C7910F8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687221801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GODPjGDP/v7EDtsYhu3OhDhbf8tl4sgje/Azf5bvXY=;
        b=C1BBDqgdvksfySrXNTxEfQeCbQqTFsk88D1Bf8fPM0L4EzRw8KqPt4wdISo94HguQ7057s
        PTfAoTVg+X1TfDgDex/Snqa6YkFvDftjmc8SlLiZ9mgzpLl7y5l47niInv0126ldS9pr9v
        8wf7NOlxw1UpG0aJ1ikMw39snCN1bi4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-F-aCexA5MOGy03bd3CvrmQ-1; Mon, 19 Jun 2023 20:43:20 -0400
X-MC-Unique: F-aCexA5MOGy03bd3CvrmQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-95847b4b4e7so321607566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221799; x=1689813799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GODPjGDP/v7EDtsYhu3OhDhbf8tl4sgje/Azf5bvXY=;
        b=ijRjSCQLoM2HuQM8WLIj7y7Y2kpIUaEIogK4ttvYiyD636Jtywo2YhcVhxrgK9Qa2A
         k7RLBf7rFsjotcnJkvJkkRMB2aNur4t4X+1/VPiv9vQeilFfzgtipHnhO2d1AyalofXu
         9GsmwMkdA6lxR4MbrGFFF/7UjwOcodTqmRv0zl5B0JAcG/o4+8xgP8E2hvKRcNiuzfwJ
         fpJ/Eal7RjrQ9cnCSSWi3qTl80vjmnd72BwczEOeBLFJuP5zGD/KQd/Zbo77JXvDA6ah
         qBEyo0Zqn/E49zzHgcmVaIFdKbFSDo5yHIYzWX56dUxb1DlvdgDcigB5AcISr/s/XszO
         57gQ==
X-Gm-Message-State: AC+VfDztK9SJW4PftYFHo95HndwRcaEa51uRjZNRx3goIO+tGmJ2kzcH
        xE2YC4BL74oOeNpvoRxC+W3QpCwu9QKnPCbfknONpbfNykwwdhTplfIS6vD/s8e0Kdz/71ys1lO
        BQct9hh6IFjz5ssvTuKwU0OuZ
X-Received: by 2002:a17:907:9495:b0:982:a065:331d with SMTP id dm21-20020a170907949500b00982a065331dmr9791775ejc.60.1687221799663;
        Mon, 19 Jun 2023 17:43:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65fHuJnAW0DqDalRe8IFameBpvYe1u3W5keeHpov/NpqxjPQb0EmGROEVydntX30L57FauPQ==
X-Received: by 2002:a17:907:9495:b0:982:a065:331d with SMTP id dm21-20020a170907949500b00982a065331dmr9791756ejc.60.1687221799456;
        Mon, 19 Jun 2023 17:43:19 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id rh8-20020a17090720e800b0098282bb8effsm375959ejb.196.2023.06.19.17.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:43:18 -0700 (PDT)
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
Subject: [PATCH drm-next v5 11/14] drm/nouveau: chan: provide nouveau_channel_kill()
Date:   Tue, 20 Jun 2023 02:42:14 +0200
Message-Id: <20230620004217.4700-12-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620004217.4700-1-dakr@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
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
2.40.1

