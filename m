Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687E469AD16
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBQNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjBQNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B736BDF9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676641714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfAnd4OS8K7FlDcC4KqE1N+eZSmvaMlTDnF99DGXOtY=;
        b=GpSXW1z8hugOXE7CU/IzKYUotWPWSII1X3LScVpHZz5O2rAJcT7oIcHU5APj+7ZOrGatkC
        CU9JeT/qKLG8knjrVs505f6wFCPdnVD/bLEQm7G2DezHPacWxyrIveFV4UZSeOYCB8Nooo
        Wd17KAWYpbL7BcBWPpoMqa581y/RPj4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-NApthtffPT2PrHhBYo3DOg-1; Fri, 17 Feb 2023 08:48:33 -0500
X-MC-Unique: NApthtffPT2PrHhBYo3DOg-1
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b004acbf564d75so1094861edw.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfAnd4OS8K7FlDcC4KqE1N+eZSmvaMlTDnF99DGXOtY=;
        b=X2ZjsZpBte1P0OmV/VPsdoe0aZH7Mw+UHkUfzngBJGoBWwls/394DoyP0wuHXDUt3j
         R9t+joqRI5vUpeAZ0VFJSO4Qu/QT2VrEhnXsgFuvWz5JD2qW+o9n9tvRg5rVP6mNSzeV
         f9bIrZirrPzaxlw9Nd00TfqAPuiIsJFZS8Fkme/fevtL2zzG2T289setAVmKrXOeLvuD
         1kADzYeLNHT5WdwCYwtKRzSfbYl3wflwIHnEHa7iiZWGiKeNvTNt8xBDaxDyokyc8QjR
         9hbBdXULLf7lPHmfV3fgWOnWeLA3nllEzzBZ0Aowc/gsaLmnhOIkF1oKJMj5HIMys0Lh
         Dc7A==
X-Gm-Message-State: AO0yUKVJD4qnmfiD9Ldb8TjjBYBGAC/qPTtKxD71jqlywsgJPyEbYp7f
        MWoDuhM4U6cnxQeI6tB+RaNvkLC9DVFJwAhgSiCqtugTUAExaneCOgu5mBIUA2Z67a3aw0RKe33
        8JFIzc6qADQJMgjCx/EfV0R0J
X-Received: by 2002:a17:907:212d:b0:882:2027:c8e2 with SMTP id qo13-20020a170907212d00b008822027c8e2mr103434ejb.56.1676641712433;
        Fri, 17 Feb 2023 05:48:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9pimoemSkJ2kQZQvRKaPf0MC6QFTSypVsludSNFNxOV7/3olSpQeL9Z0Z58W/+NW3BXT3ovA==
X-Received: by 2002:a17:907:212d:b0:882:2027:c8e2 with SMTP id qo13-20020a170907212d00b008822027c8e2mr103423ejb.56.1676641712215;
        Fri, 17 Feb 2023 05:48:32 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id qn20-20020a170907211400b007a9c3831409sm2145357ejb.137.2023.02.17.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:48:31 -0800 (PST)
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
Subject: [PATCH drm-next v2 08/16] drm/nouveau: get vmm via nouveau_cli_vmm()
Date:   Fri, 17 Feb 2023 14:48:12 +0100
Message-Id: <20230217134820.14672-3-dakr@redhat.com>
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

Provide a getter function for the client's current vmm context. Since
we'll add a new (u)vmm context for UMD bindings in subsequent commits,
this will keep the code clean.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c   | 2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h  | 9 +++++++++
 drivers/gpu/drm/nouveau/nouveau_gem.c  | 6 +++---
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 288eebc70a67..f3039c1f87c9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -204,7 +204,7 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 	struct nouveau_drm *drm = cli->drm;
 	struct nouveau_bo *nvbo;
 	struct nvif_mmu *mmu = &cli->mmu;
-	struct nvif_vmm *vmm = cli->svm.cli ? &cli->svm.vmm : &cli->vmm.vmm;
+	struct nvif_vmm *vmm = &nouveau_cli_vmm(cli)->vmm;
 	int i, pi = -1;
 
 	if (!*size) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index e648ecd0c1a0..1068abe41024 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -148,7 +148,7 @@ nouveau_channel_prep(struct nouveau_drm *drm, struct nvif_device *device,
 
 	chan->device = device;
 	chan->drm = drm;
-	chan->vmm = cli->svm.cli ? &cli->svm : &cli->vmm;
+	chan->vmm = nouveau_cli_vmm(cli);
 	atomic_set(&chan->killed, 0);
 
 	/* allocate memory for dma push buffer */
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index b5de312a523f..81350e685b50 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -112,6 +112,15 @@ struct nouveau_cli_work {
 	struct dma_fence_cb cb;
 };
 
+static inline struct nouveau_vmm *
+nouveau_cli_vmm(struct nouveau_cli *cli)
+{
+	if (cli->svm.cli)
+		return &cli->svm;
+
+	return &cli->vmm;
+}
+
 void nouveau_cli_work_queue(struct nouveau_cli *, struct dma_fence *,
 			    struct nouveau_cli_work *);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index f77e44958037..08689ced4f6a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -103,7 +103,7 @@ nouveau_gem_object_open(struct drm_gem_object *gem, struct drm_file *file_priv)
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
 	struct nouveau_drm *drm = nouveau_bdev(nvbo->bo.bdev);
 	struct device *dev = drm->dev->dev;
-	struct nouveau_vmm *vmm = cli->svm.cli ? &cli->svm : &cli->vmm;
+	struct nouveau_vmm *vmm = nouveau_cli_vmm(cli);
 	struct nouveau_vma *vma;
 	int ret;
 
@@ -180,7 +180,7 @@ nouveau_gem_object_close(struct drm_gem_object *gem, struct drm_file *file_priv)
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
 	struct nouveau_drm *drm = nouveau_bdev(nvbo->bo.bdev);
 	struct device *dev = drm->dev->dev;
-	struct nouveau_vmm *vmm = cli->svm.cli ? &cli->svm : & cli->vmm;
+	struct nouveau_vmm *vmm = nouveau_cli_vmm(cli);
 	struct nouveau_vma *vma;
 	int ret;
 
@@ -269,7 +269,7 @@ nouveau_gem_info(struct drm_file *file_priv, struct drm_gem_object *gem,
 {
 	struct nouveau_cli *cli = nouveau_cli(file_priv);
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
-	struct nouveau_vmm *vmm = cli->svm.cli ? &cli->svm : &cli->vmm;
+	struct nouveau_vmm *vmm = nouveau_cli_vmm(cli);
 	struct nouveau_vma *vma;
 
 	if (is_power_of_2(nvbo->valid_domains))
-- 
2.39.1

