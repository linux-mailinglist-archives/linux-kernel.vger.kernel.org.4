Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F569AD18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBQNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBQNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:49:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F2C6C013
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676641719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s63r6ewLpHy8dX6pfqzPL7Kskgx+EPYod2Ty9Ts4erk=;
        b=gmOGNouJuIR1YvO5H/bsds32Cl4TgmIpjJr9527PefFMq+tVL8E+aPEcFp+nYNPpfCNNWS
        CJesaA223aI958D2ldpURde1ibn+PyFW0pqJwS/AiZPKJRsqcw3YuVqPfb8Iyx/RB4+BEv
        UCdrntiXBRPvN560dEohEPh7RUkLS4U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-Wg97RsO2OtSzfbJ7IEte-w-1; Fri, 17 Feb 2023 08:48:38 -0500
X-MC-Unique: Wg97RsO2OtSzfbJ7IEte-w-1
Received: by mail-ed1-f72.google.com with SMTP id q12-20020a056402518c00b004ace822b750so1950481edd.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s63r6ewLpHy8dX6pfqzPL7Kskgx+EPYod2Ty9Ts4erk=;
        b=8OTD+DDSu1Orva9ZKwX0DpnZTMXf3RLljvB61fuVupA3DMTkxIF1pcMf5p1euLmG+Z
         RyqTaCsBlr+bQ80QOnzma4fugY93BrUc5tgXj4wZRXEFOfTn0zNSW182ouzzkIMK9Lyt
         rZxGNUJ2ZqCJMs59EbzFaTERSm4ytfGKLDjeUCuojXc6hqN1MbQS6DamBqOrQro42J21
         J0nI7kc7js6M02sNIG6EpjSfGf5AGuaokLStIriT1JCsAb476+DwgDA5cS5gNIZ69C94
         GJz9PQ7/NNQEX8SykxS2WdtJDmPCtmf0apxH6+Vouh76adqv3QOmFAZFEXjMiRraaZMe
         Icmg==
X-Gm-Message-State: AO0yUKVI0XDwmkRyqn4HvL1ELKwTrhCqcddes23Y1Zj4M7K5c/iAXPuP
        /iZpSAcT5rzXTjXMOJ/uGPi5wrbxdku/ViS6bU1r77BOmm4vI2WAW0SSHNFArzxk1oI1xWLazTt
        tXGLbasHZPFZDCkygStqlfHWF
X-Received: by 2002:a17:906:9750:b0:8b3:946d:51c8 with SMTP id o16-20020a170906975000b008b3946d51c8mr1973103ejy.29.1676641717143;
        Fri, 17 Feb 2023 05:48:37 -0800 (PST)
X-Google-Smtp-Source: AK7set8Vb+Eh70SMrWH0gbi9pDuylvuAxYJRJaM1j4o+Rm2VHpNfcVf+Ka0ZZS+k/kpmT6aZ0ke53A==
X-Received: by 2002:a17:906:9750:b0:8b3:946d:51c8 with SMTP id o16-20020a170906975000b008b3946d51c8mr1973082ejy.29.1676641717002;
        Fri, 17 Feb 2023 05:48:37 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id a15-20020a509b4f000000b004acc7202074sm2288777edj.16.2023.02.17.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:48:36 -0800 (PST)
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
Subject: [PATCH drm-next v2 09/16] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Fri, 17 Feb 2023 14:48:13 +0100
Message-Id: <20230217134820.14672-4-dakr@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217134422.14116-1-dakr@redhat.com>
References: <20230217134422.14116-1-dakr@redhat.com>
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

Initialize the GEM's DRM GPU VA manager interface in preparation for the
(u)vmm implementation, provided by subsequent commits, to make use of it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index f3039c1f87c9..bf6984c8754c 100644
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
2.39.1

