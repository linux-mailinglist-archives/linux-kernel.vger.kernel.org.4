Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DDC671462
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjARGjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjARG0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:26:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90154B1D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674022448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arClRUS1jAAdkcFM0OKNg8mvWVVAlTJxmoO3YVnMeNE=;
        b=de5o+O8XzWS6UEtcJITBWs4ALTPB9mUEsC+0Kz7QdMLhUJKKf0p6nkt8HuQ/8RIKj66uoG
        PCLJ7IfFq1cXPkjbeiy+gdKOdJYwE6J8S3pQEhPV+4dhr4hLCF3ghFKXLepiFhPupXL1/p
        R139ABrrgx192ROkaSREp8OWPSd4VvA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-g8JOfnjwOp6Haaz-Kbp5KQ-1; Wed, 18 Jan 2023 01:14:06 -0500
X-MC-Unique: g8JOfnjwOp6Haaz-Kbp5KQ-1
Received: by mail-ed1-f72.google.com with SMTP id h18-20020a05640250d200b0049e0e9382c2so6048183edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arClRUS1jAAdkcFM0OKNg8mvWVVAlTJxmoO3YVnMeNE=;
        b=CRNSg8UkU1L2BBERA7KLlA13RPuImue39FYMnbYWPMzhtMYBE1iRmw6+BjSGCRtD8c
         yZ5xDcWbGfESuo8Us+kE7kJ4p9ey/shfq5KFVZqFmQBq5k32Qj5mchQby07p12lyON3M
         G2K1tLfj8sjxmcJPCe3wMo7wnXhERK/H1oN/A/KZS+NmF4+LOyyicVZgZNhGYvPUNmH3
         +udmYw+7kFfLgyb/Xqz4o1U2x0d0s0EhoA5vPFoT6FSSLLSddH3eCjivdXir/26Zo3hg
         Rd+RLRePso89p1b+n4UGDQwSn+e001sI+J6uVcQa+jGatgq884m9jywe/nRfvDopkumU
         Rk+A==
X-Gm-Message-State: AFqh2koeWNvl4c0J4u7eEjP0AvK6/D0QecfdKGQpFPIFmB/6gjap4lev
        PflSDj4HkQY64ki58Jh1AZpnrybvBtmjXyk4nqO3OzELHRQa8BFiS7Ep05F1NW1z4yK6Vw4eaRK
        Tum/jreYq/Rb9cm0iVEnMidkG
X-Received: by 2002:a17:906:d971:b0:870:7e7d:97a7 with SMTP id rp17-20020a170906d97100b008707e7d97a7mr5281477ejb.72.1674022445708;
        Tue, 17 Jan 2023 22:14:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvpsASk83uq4IIpUYeM6NlUZGHTvMFacGsEyh3xonT5oiC/C+OajcLwYQPPr8OmFy9NfpFhjQ==
X-Received: by 2002:a17:906:d971:b0:870:7e7d:97a7 with SMTP id rp17-20020a170906d97100b008707e7d97a7mr5281469ejb.72.1674022445535;
        Tue, 17 Jan 2023 22:14:05 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090631d600b00779cde476e4sm14066480ejf.62.2023.01.17.22.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:14:05 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@redhat.com, christian.koenig@amd.com,
        bskeggs@redhat.com, jason@jlekstrand.net, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next 10/14] drm/nouveau: chan: provide nouveau_channel_kill()
Date:   Wed, 18 Jan 2023 07:12:52 +0100
Message-Id: <20230118061256.2689-11-dakr@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061256.2689-1-dakr@redhat.com>
References: <20230118061256.2689-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
index 1068abe41024..6f47e997d9cf 100644
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
2.39.0

