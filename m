Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE037360CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjFTAoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTAnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A5510D9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687221787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15bsZMHgn8HdtpEj/sQfVUEhkE1KgujwGvKHw17TRpw=;
        b=BSkOG74UiFmj46MUeuSCAKbV2MMl4JlGNBmFgM4whRNtol86OFOmGeq+3t/P48gNFpP4Kd
        Pp7L8+9WNBbjDHP59AruOt/TWVrwR3GqkrlOfSnAMzLGPcfjt5xdhJ5k+vwNbTin1rU61q
        LEDyrd9nBjs4+nqhsQpfwx5NlOKyjCM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-p2ZSn9e_OxCaTFrGGI47VQ-1; Mon, 19 Jun 2023 20:43:05 -0400
X-MC-Unique: p2ZSn9e_OxCaTFrGGI47VQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51a45552177so1960876a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221784; x=1689813784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15bsZMHgn8HdtpEj/sQfVUEhkE1KgujwGvKHw17TRpw=;
        b=OdXi74MTxehCTuTF8Sa/IbQOrGsz6xjDhYaqgCr3jVCu8UsctRBF2C+dO46LtE9OCr
         UL0HN8KBesiZY4KOwxOmGfTJYaz4gY+5ursix2zibOlL8q8KKgAPanTyxe8oGjfZPFv1
         mIv9V5Oh9kxO4vvpaqDTw6CbMxJ0kdIz+CYTfQ86kCHVIDNKXQ4bg66649yktKRZVSUI
         UhwqVqQ+CHHx/yvnjOGAPx+QOFRwjnnSZNyJKVoP6CYlmYCbZHmiwq+NqgMyyhsv5yf/
         yNj4Q6Af0Ka8mizmn3xeyXSEGnBnFrpR1ao9G17nG5g4DJWKSgovh9EfJViIU4PuxeIg
         klag==
X-Gm-Message-State: AC+VfDxAiX0NPYXPD4ah/ef1wxdBz8Kg7MlgFsUr2zim+WzPfTFJHoy3
        i4y8jsaVl+J9RIPEFGYIxgQBCuLBJ3lMaWuHezw9XggkfwuvOxU2uF7EJ1+G9bODvdshaWAhgu5
        UdGWUR6qxyenvF1dTpOqpUINT
X-Received: by 2002:a17:907:94c6:b0:97a:588f:766 with SMTP id dn6-20020a17090794c600b0097a588f0766mr10489575ejc.42.1687221784469;
        Mon, 19 Jun 2023 17:43:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7c9FPA9PfjnZ4NBX+L5X8JmjHfzdjLxD7tdsztb6oh+Z4IO34dObfIqPL2WWN4l2JkXpNgzg==
X-Received: by 2002:a17:907:94c6:b0:97a:588f:766 with SMTP id dn6-20020a17090794c600b0097a588f0766mr10489556ejc.42.1687221784330;
        Mon, 19 Jun 2023 17:43:04 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id me16-20020a170906aed000b0098669cc16b2sm389552ejb.83.2023.06.19.17.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:43:03 -0700 (PDT)
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
Subject: [PATCH drm-next v5 08/14] drm/nouveau: move usercopy helpers to nouveau_drv.h
Date:   Tue, 20 Jun 2023 02:42:11 +0200
Message-Id: <20230620004217.4700-9-dakr@redhat.com>
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
2.40.1

