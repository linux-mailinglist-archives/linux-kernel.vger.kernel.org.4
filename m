Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D063D7360D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFTAoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFTAny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A110D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687221781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2u1hP2d/8CjIhjRb+gqUMgVIAuG2+DtyciZrujYDGU=;
        b=Jxf/rqP7DF1uwzUDV95lE+uUpfeiRmbYXuq/IdkoTjKB/FzEapoljy3q8zcE0kMCBwgpRR
        EM+Wjj4Ad9rCWcMAAS+2cpWGVKF+BGOqMu8tDs9+zKAFxRFWyuKXfJqgJggw1UaqVH1+hy
        J0VfZgpUQGWUSPzTGA2HklAohJF/lVs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-2VZFD8SCNP6luCd7aPOsZg-1; Mon, 19 Jun 2023 20:43:00 -0400
X-MC-Unique: 2VZFD8SCNP6luCd7aPOsZg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51a5b073299so664806a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221779; x=1689813779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2u1hP2d/8CjIhjRb+gqUMgVIAuG2+DtyciZrujYDGU=;
        b=I8b/FeuYUuqjeHsojGs6sFBc/wUrtKuQS9hBVTYu6tnKP8+kR4OrD6WX8haLL0xavs
         xTt1HXnUTKzHMqqQYbzeIA9pzT7O7osJoQyjKoexxDm3qgpMBAerCFq3oc3AkGuldHu+
         KYQPf5uZYKPSnTwtB+0M+zafmQ0/pFd6KPoNRc4TKGqULxDX0sXSzti4h+Vsob63J4co
         y+DnDFMvnAFbi/+hkM1SJa9X4moVSJIpgHsGjmxZ9on+0VZOOBCFiRrft+ZygpC9f0/U
         NBIPUmQ+u0iHsBx9YbgvdT2Awj2TRwSrx9709ofnR4QcrDqRywDTng0e6OXoj8HUV+jt
         9JvA==
X-Gm-Message-State: AC+VfDxhoLrsS8bxi66LGxBLtyFbgaAEsmql28y2Dsf8d8Ng5zIZ9WrD
        foacEPScSMe0UGSwEBtjUf5Ea0aSMo17kw2I2da5n+Z3JUw/3RIyJRD4EMUUsNEgqIL8Hz78e7I
        JL8RlbJkMPiIhVXFFedRZMLHd
X-Received: by 2002:aa7:cd45:0:b0:514:994c:2982 with SMTP id v5-20020aa7cd45000000b00514994c2982mr6151179edw.40.1687221779429;
        Mon, 19 Jun 2023 17:42:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65FSvnjaoggF9h58zTqyT2DOkL9H5Vbq5o8fo2niPqP1lOxX39BSK0TAWF98v1OjzcZEYMlQ==
X-Received: by 2002:aa7:cd45:0:b0:514:994c:2982 with SMTP id v5-20020aa7cd45000000b00514994c2982mr6151166edw.40.1687221779253;
        Mon, 19 Jun 2023 17:42:59 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id d8-20020a056402078800b005187a42b44fsm310743edy.58.2023.06.19.17.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:42:58 -0700 (PDT)
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
Subject: [PATCH drm-next v5 07/14] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Tue, 20 Jun 2023 02:42:10 +0200
Message-Id: <20230620004217.4700-8-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620004217.4700-1-dakr@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.40.1

