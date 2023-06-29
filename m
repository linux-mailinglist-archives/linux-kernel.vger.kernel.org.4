Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B074308E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjF2W3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF2W25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2568235A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688077650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEv7G0CEYOPGW2iDjZ4bQ7xPP+mjrUkHdLemyMCnVvw=;
        b=hYG3dSrBbOS/4eRdJCvyXzkSEMQa4nTbW28hbJ6uxhUOP7cIfTVZbKKphxP9qsJ6lWQc8y
        mUTBBQ/oiUaUliMQEjWO4U6GQaOz/+f1ITJbqTRfn0WDPQsCbU26vKZn3aR0vU9wOa1t4x
        46J8vchahuHsckoZcQ4rVcVSfl1O9Zs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-KYBcrbCCOeGkfViwdwFoUQ-1; Thu, 29 Jun 2023 18:27:29 -0400
X-MC-Unique: KYBcrbCCOeGkfViwdwFoUQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa8d203eccso5402315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688077648; x=1690669648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEv7G0CEYOPGW2iDjZ4bQ7xPP+mjrUkHdLemyMCnVvw=;
        b=XGuKM0v8VlG//JHIN++WlsiEETg+X6QSSDtBG7Ew4qEtIkVhYUnl2jYXsqmyINRHqM
         F5fOVxF6zXD8ew9TzCCzLd31zHvjApj9UDEC/JGnL5CFurij7o/rinlWINI0dKORDiRx
         zARxju/PaoBcG9MTfLqCygDQPtJEJ53tU/ZlqR+xSbst2gtfaw8zo/8VlEIHhXkrcjnl
         PeWzStzlz8iQK/39MQHdQQv09e4g7fVA6eWR991A7WxnWGEJoXtjMa7ER0/PpT5JhQ0p
         GcDDMALnDUDSAwXO7J4XwiPKQhf871BrJsX2s2ci4XKdlJaUMYZ+ExYmIbZDt+t0Ovxa
         du9w==
X-Gm-Message-State: AC+VfDx7kTavMEdiH1nwYM/b2f8oUcfOAisD2rvxH/CnRX9ljSfDMBxW
        yxg8WbsJBLHaMuk/pNoqAfKcmLjL3+S71TVpr+iwnJyxyCZeRYyhxJeHhwowqK4RPJQF9UlLiN/
        IR0zLPPxb7MnMYNwzZi7ZpFFN
X-Received: by 2002:a05:600c:4f8a:b0:3fa:821e:1fb5 with SMTP id n10-20020a05600c4f8a00b003fa821e1fb5mr6128649wmq.5.1688077647922;
        Thu, 29 Jun 2023 15:27:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wpnqgs/z7hJJmbtz3VdpkoRY4cAoYdS0461hyKBm1gdSunV5Xsq2eBMdCyeRdOWG5WL3RWw==
X-Received: by 2002:a05:600c:4f8a:b0:3fa:821e:1fb5 with SMTP id n10-20020a05600c4f8a00b003fa821e1fb5mr6128628wmq.5.1688077647669;
        Thu, 29 Jun 2023 15:27:27 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id i3-20020adfdec3000000b0031411e46af3sm3704409wrn.97.2023.06.29.15.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:27:27 -0700 (PDT)
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
Subject: [PATCH drm-next v6 07/13] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Fri, 30 Jun 2023 00:25:23 +0200
Message-ID: <20230629222651.3196-8-dakr@redhat.com>
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
index 45ca4eb98f54..a48f42aaeab9 100644
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
2.41.0

