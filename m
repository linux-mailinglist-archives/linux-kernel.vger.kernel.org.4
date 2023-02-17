Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0F469AD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBQNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBQNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:50:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E0E6C026
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676641724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qV+blR6Tkr/sKsOr7dEvAgWdCXkrbGqs9gehh/nqNIE=;
        b=PVafClIyLLIR4LgNXgrgs4JEjSaambexZ7quQE+X5NcyJIjUt1g5Tjz3U5YDYr0Ti8AW8Q
        Q5phyfqqn4pEzFUb5qKypZ6Uwn1eDwlMvs9Qwm0wQ4jtLl5Vn/3fGt15IUnGxUUVOQVaGs
        9eU0Sb85e5ATkEoeSslQFVmVbnOfvBg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-oVArtSvdPSKs_bnFnoVC_g-1; Fri, 17 Feb 2023 08:48:42 -0500
X-MC-Unique: oVArtSvdPSKs_bnFnoVC_g-1
Received: by mail-ed1-f71.google.com with SMTP id ee29-20020a056402291d00b0049ec3a108beso1653275edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV+blR6Tkr/sKsOr7dEvAgWdCXkrbGqs9gehh/nqNIE=;
        b=okzy/bMvZmt0dDMBbrb4owOadwjWEFZqkLxfSQ31gZuCHe8m0/dcQ6zmUw6/pj4sBG
         7DgTKjPoA88FjlvZKT3UC9BMzHx0FsjhcrFW3Cksx0H4Jj4el4KWn0xqU+Zo8W9mjnL7
         eQbx6m2BfDdA4ZGJRLFIZnj9HZeo5PukL4jAt1GUusDOagi8IaPbu0J6Nf0CY40FAl4V
         /8biGajAENuYAlTjf1UcgpZ/184HZI0rfNYiMhrzpjmdiuH5ihNIaJ/chhF0XOC/N0gF
         akSt667jfYhsp76ReXRGX9QV7dMiyqAElMeecFsg9p3Nkjra+X2D3AmmXXOBCB5YLi73
         +m0Q==
X-Gm-Message-State: AO0yUKWtu+CliNe3GAEh7FMVe1RGAKfGZY7XEdqB48U8eoxWpu+AYvbM
        RPvGm6rgs+J5eu0eWqSA3R7454nKPe3r+5VL7V1foEV8Z3I1QsRglSRj+LqZVZSVvRgb/mRdwGa
        Oy6RwqnUlNqqQFtUrdC2d75P/
X-Received: by 2002:a05:6402:457:b0:4ad:7640:ff47 with SMTP id p23-20020a056402045700b004ad7640ff47mr3317196edw.13.1676641721926;
        Fri, 17 Feb 2023 05:48:41 -0800 (PST)
X-Google-Smtp-Source: AK7set8TQtlKkchdYFDpX6esHsmxmbuVnZmBvwTb0vwG2PSeRr7Qepshcx1saI0cWGGhV/p6T+nLUA==
X-Received: by 2002:a05:6402:457:b0:4ad:7640:ff47 with SMTP id p23-20020a056402045700b004ad7640ff47mr3317181edw.13.1676641721700;
        Fri, 17 Feb 2023 05:48:41 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id v22-20020a509556000000b004a23558f01fsm2348675eda.43.2023.02.17.05.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:48:40 -0800 (PST)
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
Subject: [PATCH drm-next v2 10/16] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Fri, 17 Feb 2023 14:48:14 +0100
Message-Id: <20230217134820.14672-5-dakr@redhat.com>
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
2.39.1

