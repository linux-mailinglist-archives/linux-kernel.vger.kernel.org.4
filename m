Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD606671486
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjARGth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjARGZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3753E5F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674022441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuIA/967bi8fJ2s/oMp21AWFew5v50JdzBzuNFK8Osw=;
        b=Jh1dLKQ9HMPoV5wpxDiPQJgBRG0NvqRjypxBuRBiJsGEIDPZ/jPxFCv6RuJUFgKuQA2Kvv
        OIp6yAv/EuQqM5GNNreeYpDXQ7X0mPyb+SLyz18V50p1NP3Q247UM+V4t5RvWKGkB0XyDO
        H8n6iRJ0NTOKSa4CQGrVV+yaJbeJH0A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-VnT9C7ReN-WoAJBfXxtZJg-1; Wed, 18 Jan 2023 01:13:58 -0500
X-MC-Unique: VnT9C7ReN-WoAJBfXxtZJg-1
Received: by mail-ej1-f71.google.com with SMTP id hq7-20020a1709073f0700b0086fe36ed3d0so5823269ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuIA/967bi8fJ2s/oMp21AWFew5v50JdzBzuNFK8Osw=;
        b=Ibzeyra/MMkEU7X+KbPnyywo9XhVnhVHbQESp3sCb9L3EpcWCsuz7FgUzJpFWjTz/D
         4Euj21uEL7TAzaZlQpJ4rv5g5lBwBIjwqlpVSxJ6PubBX5wsD+6GTZtGRdlbqrfW+91u
         1+fqnf+CV8NToI7S6G2j++oCaVWRPzFjo5gxXUwONvUGaZ8AOKWNBmThNpSAM2A8tdgu
         RLOGZPXRVae5h8Bb71GYPoLqaVk4b+O05itS5jTU/mzhOJESO/9wmEx5mqwjE+8lyQS3
         ODI+k5dt2p2vp/kPKeOMvDYUWBzVvLFVK5zAT3WlN+ZR5PPZ3DlJfEtVtHoWmkyX/v9m
         rGtA==
X-Gm-Message-State: AFqh2koQAcyX/I6oGS99ADpNOg0lwWlvCfZ9QOmsIMNyovI5y7p6vseD
        jQZTcNtRgHp3ou72PEufkWv6TeX7J7wyALxr2BDd95nWdXDNwFlgOuDDcLkXDnBdEciNUTqYz9A
        l8ZvzA486Apz3HDewYYhVvz4w
X-Received: by 2002:a17:906:549:b0:84d:3822:a14e with SMTP id k9-20020a170906054900b0084d3822a14emr5532745eja.64.1674022437317;
        Tue, 17 Jan 2023 22:13:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv86GpSfYd+wwTGTqkBFiIhaFIdaUkZl6RvjU2Bnz8b7FM4BmyUqqqu3yOGXwZAwyOl/axmZQ==
X-Received: by 2002:a17:906:549:b0:84d:3822:a14e with SMTP id k9-20020a170906054900b0084d3822a14emr5532728eja.64.1674022437107;
        Tue, 17 Jan 2023 22:13:57 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906300b00b008675df83251sm7184811ejz.34.2023.01.17.22.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:13:56 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@redhat.com, christian.koenig@amd.com,
        bskeggs@redhat.com, jason@jlekstrand.net, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next 08/14] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Wed, 18 Jan 2023 07:12:50 +0100
Message-Id: <20230118061256.2689-9-dakr@redhat.com>
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

Move the usercopy helpers to a common driver header file to make it
usable for the new API added in subsequent commits.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_gem.c | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 81350e685b50..20a7f31b9082 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -130,6 +130,32 @@ nouveau_cli(struct drm_file *fpriv)
 	return fpriv ? fpriv->driver_priv : NULL;
 }
 
+static inline void
+u_free(void *addr)
+{
+	kvfree(addr);
+}
+
+static inline void *
+u_memcpya(uint64_t user, unsigned nmemb, unsigned size)
+{
+	void *mem;
+	void __user *userptr = (void __force __user *)(uintptr_t)user;
+
+	size *= nmemb;
+
+	mem = kvmalloc(size, GFP_KERNEL);
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(mem, userptr, size)) {
+		u_free(mem);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return mem;
+}
+
 #include <nvif/object.h>
 #include <nvif/parent.h>
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 48e6ba00ec27..5dad2d0dd5cb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -613,32 +613,6 @@ nouveau_gem_pushbuf_validate(struct nouveau_channel *chan,
 	return 0;
 }
 
-static inline void
-u_free(void *addr)
-{
-	kvfree(addr);
-}
-
-static inline void *
-u_memcpya(uint64_t user, unsigned nmemb, unsigned size)
-{
-	void *mem;
-	void __user *userptr = (void __force __user *)(uintptr_t)user;
-
-	size *= nmemb;
-
-	mem = kvmalloc(size, GFP_KERNEL);
-	if (!mem)
-		return ERR_PTR(-ENOMEM);
-
-	if (copy_from_user(mem, userptr, size)) {
-		u_free(mem);
-		return ERR_PTR(-EFAULT);
-	}
-
-	return mem;
-}
-
 static int
 nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 				struct drm_nouveau_gem_pushbuf *req,
-- 
2.39.0

