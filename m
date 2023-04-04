Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB96D5611
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjDDB33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjDDB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04D22126
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680571703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKPAKixRboWIVKksjdDd3XWLOGimpIv4cn51ku79o4E=;
        b=hL8BzSEEr9vCGsD6ptm/Ycc/PzCaMWKVPHF7uOPkzlQCjYGo/h7PWYhRQqUxnN5UVly0OT
        izRkqWQrAm4+xYqrh5zbtdbu2YM/qxeXvjmB0XGrK0JP8FCjcMA/nhLq+Yv4aTXmUcNM90
        lbGk7KRUPRbX0cWyflHU2ok2z4hhIlo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-v2M6SWBrPgKnu3Doz6jxpQ-1; Mon, 03 Apr 2023 21:28:22 -0400
X-MC-Unique: v2M6SWBrPgKnu3Doz6jxpQ-1
Received: by mail-ed1-f69.google.com with SMTP id r19-20020a50aad3000000b005002e950cd3so44132030edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKPAKixRboWIVKksjdDd3XWLOGimpIv4cn51ku79o4E=;
        b=TZ4+vq2s4a5Da5sTjbmOvjbWI0Dw5AL1n1Gkh3eetv6E/fNeOZZLjMjqdCn1+xH6+R
         nDfQ0JNquzAk4x0SKDNvQMQMTgyuGvD/VkUtcGuQV7rDbkmTpXmU7fXSUgvjlx7YabXw
         rt+XiUjL2pg3kLP6zVITt40eqgaXkJen8ZHXi0GGR/154Faq4l+2uqLGwiPStCGta56D
         +yo2EDEO3l3CsKWqoYD7sUR3GZk2sZ3iC7Pqx3kiJQAOjIhVvhfQMbEQgEuifFf8DC7X
         JqJu6LzobD/ZcG91qAZd2Mmd9OwjUT1hRRFsC3EQESJ+TBgzv+BFDG4rpi22kl3rCbkz
         AIPA==
X-Gm-Message-State: AAQBX9cmB9Z0ZzdbH0eB6NlBIxKbdpdg4XQAsDDljxYZGecrp4MbvvhR
        45aK/hFHOqV4kRVJAgF9irO3PYDQ4D4a2XKLGEKKwF4vZmtL9ELR8B7BCtRdUArFJTeQucgf1Na
        b5uyMdHYco7RFQHl+f9vZqW87
X-Received: by 2002:a17:906:7c53:b0:8b1:7de3:cfaa with SMTP id g19-20020a1709067c5300b008b17de3cfaamr521665ejp.3.1680571701402;
        Mon, 03 Apr 2023 18:28:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKXBvsLQ358FMlkWLT8DWUxHFmzB6npPtP7ouGx4sEp9lwAApjiFx7erZVjm6I+QFHrVymVw==
X-Received: by 2002:a17:906:7c53:b0:8b1:7de3:cfaa with SMTP id g19-20020a1709067c5300b008b17de3cfaamr521648ejp.3.1680571701165;
        Mon, 03 Apr 2023 18:28:21 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090643ca00b0092f38a6d082sm5159990ejn.209.2023.04.03.18.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:28:20 -0700 (PDT)
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
Subject: [PATCH drm-next v3 09/15] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Tue,  4 Apr 2023 03:27:35 +0200
Message-Id: <20230404012741.116502-10-dakr@redhat.com>
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
index 08689ced4f6a..4369c8dc8b5b 100644
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
2.39.2

