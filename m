Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E59724FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjFFWd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbjFFWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB10D172D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686090730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2u1hP2d/8CjIhjRb+gqUMgVIAuG2+DtyciZrujYDGU=;
        b=GtsIzrwLvWYzIN3cfF91hqROZt2lZJ1aJMAK3Q2laStBYnXDHEnT0t42136hdnZkKjI7HT
        aZ6rdVTa00N9EtZ2DBUKqAbmGNZ89Fn/t248eFeg4bqaS6nDCkhEmRssx72cqRmyD4He/N
        E8v8eU+N0WxssdzPmJemQxctU+6L+eU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-6aHr6PbFMV6y5s60OLOz3Q-1; Tue, 06 Jun 2023 18:32:08 -0400
X-MC-Unique: 6aHr6PbFMV6y5s60OLOz3Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-977c8170b52so370578066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090727; x=1688682727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2u1hP2d/8CjIhjRb+gqUMgVIAuG2+DtyciZrujYDGU=;
        b=DejCQ678nefeo9W9lvEPdHySe5EoSXH5CeaR+0CbjYe+QjW/r/mYn3BzQDHC3389gc
         LiGoQjyXirccNp3ZUYrWnKEszSTFDeAe42L69M1bkLSgbQ46cEOf0Pv8dys6r5Iir5vL
         IrCLnocTbPbKS2yaRqTRq6fiPNvOEy8Pu23adsANLf+ppS6IGqKCG3ofxfry6kdqCsim
         z4CcRVuBicakj0RQ5y2tXE0ABih7BHn8guCB3YbaI0pMqnejntmj+X6MhnzkqxovCH4a
         twDaNmh3pC0lcyU7vCTmTgeaEjMBC0m/lBbtPX9DlqDuo24SsoBKNLDb0sdXIz2XLhW8
         6wIg==
X-Gm-Message-State: AC+VfDw3Y3ff1meBEpeyW5XJwwf375kWaWfTWabJnTqbYN1QHJz9uRXx
        aK0ff8yHa5ih+vNel42b33Oze6SAeE6CR4pqWeV4xoejHjwBrB+cJYHg8eU02f46Q+d1GlDIOYI
        j00y3QLmIjlb8MEerXb11KtSp
X-Received: by 2002:a17:907:9444:b0:978:70e1:f02b with SMTP id dl4-20020a170907944400b0097870e1f02bmr3019209ejc.75.1686090727630;
        Tue, 06 Jun 2023 15:32:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60EgMsVBlpBGdwrOsxpVWKELnoC+Mm9sVNrrUUkpw45lXY27cxGTST5LbhjokUCldhqWhttw==
X-Received: by 2002:a17:907:9444:b0:978:70e1:f02b with SMTP id dl4-20020a170907944400b0097870e1f02bmr3019183ejc.75.1686090727413;
        Tue, 06 Jun 2023 15:32:07 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906255300b00977cd6d2127sm4018465ejb.6.2023.06.06.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:32:07 -0700 (PDT)
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
Subject: [PATCH drm-next v4 07/14] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Wed,  7 Jun 2023 00:31:23 +0200
Message-Id: <20230606223130.6132-8-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606223130.6132-1-dakr@redhat.com>
References: <20230606223130.6132-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

