Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E03743088
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjF2W27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjF2W2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE083598
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688077646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJWbnZRk37PbyOPLbQx6TkJaNwAsU77I+1I9gnkS+kQ=;
        b=itVS9kKswsZozTIJSiCxUrJCjNUzyOZjtY59wPxgv849BVdMFEEcyXgjUSi++hgPOf2GZW
        +fiEFz3ZNeU9DkwBX154PdvYIqIwVAV5NUyOD6mM/YwYyd9zMVfURrVOouooADHDfgszPe
        cKew5guGtaGTEV8hUg3X1u7NXDantRQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Vr6KfM3wPQamCKOqX0aq4Q-1; Thu, 29 Jun 2023 18:27:25 -0400
X-MC-Unique: Vr6KfM3wPQamCKOqX0aq4Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31290e36b6aso609291f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688077644; x=1690669644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJWbnZRk37PbyOPLbQx6TkJaNwAsU77I+1I9gnkS+kQ=;
        b=T+cQZ7q9Jo+FGLZJwWCWCdxxG8TjZ8hlMFQIRilHBzB+qWYfSUQ2yZ41KoZB+c3nic
         9NWwGpFa0LWcWKEn0mXDvtBWQ8jh8eJKJH/hFGkFglT0NBegyGgYVXWqAA60lPnnAkya
         Wem3T8iHGge6M6CRpY2M6bIJWpBqtbjd60aoP+Aw+rFdD1BJ01sZrldKa+ysBn0cmlhn
         WnGSoAo4cMqSzlwp+BfnwBJiLfyjYQWzMlM7NULzUgvax5R5xEunObipK71wAuiaHtTe
         mMvt4JEK9qhm/fWXuGzIxLsVXw4SZAq5r5TlFiqxKeS+i00qsTtUM+QJPIffF7ApxB55
         xObA==
X-Gm-Message-State: ABy/qLbk04ssIZGQmes/d3MZwScHX+pqolgF6ftSb+OQISdJO2JPYGoI
        x0oPklfGSn1P2C61OZK1AvezibJaXde7G2p7M29WN01XbAIgZ4nJjCOlqM139FjLCF/SaQj5ZOw
        KIcSzHPwo8oeo5oSes28kZcfx
X-Received: by 2002:adf:df04:0:b0:313:eeb3:c57a with SMTP id y4-20020adfdf04000000b00313eeb3c57amr712057wrl.15.1688077643960;
        Thu, 29 Jun 2023 15:27:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7GyWmtfFzWGI2T6+X0GNR2UPFhGUrcAEJPnjYpUD/fKQGW/GRkOsPdyF5/34TvCU73KOwJQ==
X-Received: by 2002:adf:df04:0:b0:313:eeb3:c57a with SMTP id y4-20020adfdf04000000b00313eeb3c57amr712036wrl.15.1688077643775;
        Thu, 29 Jun 2023 15:27:23 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b0030e56a9ff25sm16660739wrt.31.2023.06.29.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:27:23 -0700 (PDT)
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
Subject: [PATCH drm-next v6 06/13] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Fri, 30 Jun 2023 00:25:22 +0200
Message-ID: <20230629222651.3196-7-dakr@redhat.com>
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

Initialize the GEM's DRM GPU VA manager interface in preparation for the
(u)vmm implementation, provided by subsequent commits, to make use of it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 7724fe63067d..057bc995f19b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -215,11 +215,14 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 	nvbo = kzalloc(sizeof(struct nouveau_bo), GFP_KERNEL);
 	if (!nvbo)
 		return ERR_PTR(-ENOMEM);
+
 	INIT_LIST_HEAD(&nvbo->head);
 	INIT_LIST_HEAD(&nvbo->entry);
 	INIT_LIST_HEAD(&nvbo->vma_list);
 	nvbo->bo.bdev = &drm->ttm.bdev;
 
+	drm_gem_gpuva_init(&nvbo->bo.base);
+
 	/* This is confusing, and doesn't actually mean we want an uncached
 	 * mapping, but is what NOUVEAU_GEM_DOMAIN_COHERENT gets translated
 	 * into in nouveau_gem_new().
-- 
2.41.0

