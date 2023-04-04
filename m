Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159A16D5609
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjDDB3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjDDB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EFC210A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680571699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzrmMp6+aqWo/TvsnNZiIixlQKMUKus548lCDw5p9Z4=;
        b=Zgmp8DvKxIe7f2bAFXoRTwUQNlv6Uh5/8AYJAGRL847XIkPKks/0gJR7DRVwlUOJUCJyaT
        C9Re8i1GkWlBE/wTY51Z8WNAcGLKk6JkuH6vHyCuGgSmQh1byX3Py/tUMfQe19y4ZzSStA
        Bq9J18QZpLPGOf23SQSNkpQnVygmFyw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-6aTcZizXPUKMjiWAwVQ4_w-1; Mon, 03 Apr 2023 21:28:18 -0400
X-MC-Unique: 6aTcZizXPUKMjiWAwVQ4_w-1
Received: by mail-ed1-f70.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so42921457edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzrmMp6+aqWo/TvsnNZiIixlQKMUKus548lCDw5p9Z4=;
        b=Aq22NKsxmWDHQGYMzMS6cgebV3yDHHDr6ZyG8kLDW/hzFd627za4meJkrujxtmLBmJ
         GSbmZl+ZypDD4O8VZQBr5egLlg/qbvEz5wwhtQ3cg3H+vK2P+ohs5rzLx9yrZfziGjZ+
         n2Z+BM+wyzzbm9AM4ukZhH3Um58I/4RrrMixZuq8IRW3loxlVQnXJvUuUQ+KPwRimeDN
         0XbKwYawC/HMcY4eArGPg+D7R+cYkiW8XfBNnE/GHgVo4od1FqPRoa4E0UkSyk3UkCHo
         9UxSZxxxVaxdLg7UaV7q0V+VuZwtwHsqIbE48padVr1Y4XqZe0T3Axlkgh+GAH9uorzQ
         fj/Q==
X-Gm-Message-State: AAQBX9eV6s2CAwL6FxVesDESgc+O2P+vc76T41aZcK7HG9WOo4jTxR76
        BHVPI9djdMl18gQoyypf8e6vwOtjzTztnmVqa6bSWr20n/eCpG/TT7osFTrft9DNlyESB5Z5HCU
        TyjRGGnvCBgYlWVsN8GoimhBr
X-Received: by 2002:a17:907:b12:b0:8c3:3439:24d9 with SMTP id h18-20020a1709070b1200b008c3343924d9mr549188ejl.24.1680571697341;
        Mon, 03 Apr 2023 18:28:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bOuZVfqTuVyFepzGmLZe0Dusjy763ib39Sg1Hu3aDle0xx1it+4Dx6IGT3ClEiv+jGPdjVUA==
X-Received: by 2002:a17:907:b12:b0:8c3:3439:24d9 with SMTP id h18-20020a1709070b1200b008c3343924d9mr549180ejl.24.1680571697206;
        Mon, 03 Apr 2023 18:28:17 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906384e00b00932fa67b48fsm5210797ejc.183.2023.04.03.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:28:16 -0700 (PDT)
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
Subject: [PATCH drm-next v3 08/15] drm/nouveau: bo: initialize GEM GPU VA interface
Date:   Tue,  4 Apr 2023 03:27:34 +0200
Message-Id: <20230404012741.116502-9-dakr@redhat.com>
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
2.39.2

