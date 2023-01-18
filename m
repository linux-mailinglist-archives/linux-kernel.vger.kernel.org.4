Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0667145F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjARGiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjARGZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BE2E0C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674022436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqctRI7P01D+Q/Vr3L/m1m3KsR2bbveGpuxATunwrRo=;
        b=KOhmbhiJpPZeXhYtvPZo1qHNnBziQWpN/gtciB6/ViR+djbNf2Ne8SHkvUzHHJrwOViHik
        HBqT0hgBInOJkOfUhpAGsLRifye6M+u0jmTP199+UlzYUBev13KqummzeslhOwcdwQARck
        0ZJ2T6FbY8CpkDZA4j3MM73k10ZTKLQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-NKNBTIm1MoOU6KleVxyOTw-1; Wed, 18 Jan 2023 01:13:54 -0500
X-MC-Unique: NKNBTIm1MoOU6KleVxyOTw-1
Received: by mail-ej1-f69.google.com with SMTP id du14-20020a17090772ce00b0087108bbcfa6so4963794ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqctRI7P01D+Q/Vr3L/m1m3KsR2bbveGpuxATunwrRo=;
        b=tXLWtfwC7StDGgZ1GbVdQvaa8zwrhmlR5WUrGbQZyKnsjNHWnHhLlBU4VH4aaNTaKN
         Y0DmUNIrVNmVs3h4Z6BqvDrSm/3ZqcElIGAYcuvAyR0wIdsA2LZi6iagK78v8o+ry/2i
         lnZKGgfZANgyp0b2kR56wkoAt8JhrGZ1keMGyFOr98aIMuzSgizXKCe8HaA0vNy2dTO+
         DbPyvU8+luTAqJO0rBWAASunBexDx4+6S/A7JjNon/z8/8SzH/H+7JLikidvb8/NJNbF
         lWvXy9dA+qQdQS0NEHmqmsWtWeRAJ3+we0Xs0vVbHuOWAB2CE6yfyVUhWSBMeDy1c7Y4
         dwtQ==
X-Gm-Message-State: AFqh2kpSy6LCUxTnWbSP9Spvvp4LQo6eOiurlpsutNAKZ5V2zyRiSvvp
        SoYQerBjIOEBhV+q+FY3CWvUi2vGQ4Q9KDzSdvgGZbLxyf+V9XxTVHdMAkZcZHl1ZjTgrMppMu8
        lQ3BAYyqGOrnJW7BtRpIt8Mvs
X-Received: by 2002:a05:6402:401d:b0:49b:5a1c:9cb5 with SMTP id d29-20020a056402401d00b0049b5a1c9cb5mr6136305eda.16.1674022433100;
        Tue, 17 Jan 2023 22:13:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsMRQNeLN0f7U0iSpRPj/7pTZ3JgTXp3PTis3EaCSPjKRlhbStTsVCJPYygyXG1jLnP6DuINw==
X-Received: by 2002:a05:6402:401d:b0:49b:5a1c:9cb5 with SMTP id d29-20020a056402401d00b0049b5a1c9cb5mr6136300eda.16.1674022432934;
        Tue, 17 Jan 2023 22:13:52 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id p11-20020a05640243cb00b0049e19136c22sm3039222edc.95.2023.01.17.22.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:13:52 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@redhat.com, christian.koenig@amd.com,
        bskeggs@redhat.com, jason@jlekstrand.net, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next 07/14] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Wed, 18 Jan 2023 07:12:49 +0100
Message-Id: <20230118061256.2689-8-dakr@redhat.com>
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

Initialize the GEM's DRM GPU VA manager interface in preparation for the
(u)vmm implementation, provided by subsequent commits, to make use of it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index d2b32a47e480..4cdeda7fe2df 100644
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
2.39.0

