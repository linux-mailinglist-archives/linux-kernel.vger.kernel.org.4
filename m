Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51469AD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBQNuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBQNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6717164
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676641732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nuqfhAPXoP8eMSRnoJXE/EUnRUmH5Dpmadrq5ZDJBI4=;
        b=YD8FDFYCv9WovaOETyPPQ04XLY971aR/whh80U4Hd0uhZNPI9PARMeYwD6Bd6UWBcYi91W
        VBCMG54Kc11V8vp2IDH09QtbXyCZQf2C24l2ZKiBnZwJp1XmEqUIdMJSbWJDZ9m4KPNtYD
        dFNOpUwsEPxuzEyTftzE0aDtleSwmuE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-IqCugGyDM0yXVBfd7lREhg-1; Fri, 17 Feb 2023 08:48:51 -0500
X-MC-Unique: IqCugGyDM0yXVBfd7lREhg-1
Received: by mail-ed1-f71.google.com with SMTP id cn9-20020a0564020ca900b004a25d8d7593so1229655edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuqfhAPXoP8eMSRnoJXE/EUnRUmH5Dpmadrq5ZDJBI4=;
        b=sw0Q4luYdiXVnFhsWWe3ipoXSiwo3y/Kv8THGFK7Er7ZQHECj1zwxaf5/RQTOVAGRc
         aug8Co/GD0bgk2Gmw/dqTXomUojxZ3LtFEMIF14qub/F39PupU7sXKPP+SBWIY8X/ofZ
         n+0ytjDvCYmf3qCihgF871AlUzp0rY7mQmBrKAc2B0uTUBz0r0CS1W8brGKb+6daOTKD
         ogeq85vlGThtLyLv72qFKW3ePEzkCdhTYAq9qUvdF2xiykD9im6gwtMKZlTaJULgjTrN
         T6YwaoXHqKB5EKUiTr4roMLzqe3B7frIsk6OclRudVj+yspwVQJ8VcrY40SMsfRKmcNn
         i0SA==
X-Gm-Message-State: AO0yUKWBZo0ORugkk8kvufKJp9aGoYE6kcSMlvNTQigH9Df6pdAhaY44
        6sQWaVzFQ+RQLriPCLLL8Jn80VGE6BYKeHLHmFYtEIpkzG4D28QnDh8qsAzDOxZwcTvuCl1QF3s
        gygb43Ov/BcpClRXqZuVjThgp
X-Received: by 2002:a17:906:5012:b0:87d:9447:f7fb with SMTP id s18-20020a170906501200b0087d9447f7fbmr444211ejj.38.1676641730481;
        Fri, 17 Feb 2023 05:48:50 -0800 (PST)
X-Google-Smtp-Source: AK7set89k4Od4Os7LWbT0Iek0fo+d31O5+Il7AqZlhgERwv5aHbfx3F8XejW0D6aFl2/IjkHLHgKFg==
X-Received: by 2002:a17:906:5012:b0:87d:9447:f7fb with SMTP id s18-20020a170906501200b0087d9447f7fbmr444186ejj.38.1676641730324;
        Fri, 17 Feb 2023 05:48:50 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090614d700b008b155de0984sm2180964ejc.170.2023.02.17.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:48:49 -0800 (PST)
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
Subject: [PATCH drm-next v2 12/16] drm/nouveau: chan: provide nouveau_channel_kill()
Date:   Fri, 17 Feb 2023 14:48:16 +0100
Message-Id: <20230217134820.14672-7-dakr@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217134422.14116-1-dakr@redhat.com>
References: <20230217134422.14116-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
2.39.1

