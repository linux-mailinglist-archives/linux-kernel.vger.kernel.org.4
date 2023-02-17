Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C08169AD26
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjBQNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBQNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42386928D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676641749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGtWB8otfeqdskrUgWVgT1wxpbtVBJjmwPhyWCdCJZU=;
        b=bKy9DeJRI9nCuaWqjOPAWwpttrO1DDKXDahOuDT5wMeLVNXpgOLrvKGaVG48TCvwzXWSeo
        kwORv4kUvLg6HOSofUGRF+4qbi2IhOndTI6+7GWz9HcaqhLj1BDDzclLM1Ig+aMYW+hgrh
        kYHDxmAIOHHnjoLkl6OKRC80iv9aO/I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-cN5NGqpqMb2HFgHuaXdISQ-1; Fri, 17 Feb 2023 08:49:07 -0500
X-MC-Unique: cN5NGqpqMb2HFgHuaXdISQ-1
Received: by mail-ed1-f72.google.com with SMTP id d9-20020a056402400900b004ad062fee5eso1742280eda.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGtWB8otfeqdskrUgWVgT1wxpbtVBJjmwPhyWCdCJZU=;
        b=drnnfB5/sm6PO0zPkzvjCyv1NEWYCn/forZ7vglMWfCx+IgZYTWIP1StB/qFJYGewF
         XUCvLoiSumf4yOfeWVH2yNYYX8m07h58pgdepRLb03F0GLFJIXqjaZQ9pMPrIdDsTgFU
         bPX5SK5MLNW7Jjozxe83wTmE6WzbwCESEkG8M6UwbnmwWk5zAKVV1j9f1NAh4LMWX4Gs
         XaVuJEaqYo9AVo9Ib5UfsFQDqqUqvKdPz7NDrzWjelYRxc2WYTC7ghYu4L4cZeTCyj/s
         T0blB1pfe7aTphJaGW1NufZHRIfkXDUnV9KkovckuvJnPH2VvfhIosxZFjYaoumhrel/
         RKYw==
X-Gm-Message-State: AO0yUKWiwt2pfDs8Y0Ub0CM7vJxIHRk3/5WUn4RI3Sk/dgGg61wGTGKz
        p6vSrX/9cmZYhMKhxgWwZjCwdPTwvVJ1MEFT7lR0A/ZBjBlkiPBbh5+UYfNx7A3Z6lIqiqyyfqC
        6G3uhEvQHAWQeO1ckqEA+Al24
X-Received: by 2002:a17:907:a508:b0:8af:54d0:181d with SMTP id vr8-20020a170907a50800b008af54d0181dmr10190318ejc.35.1676641746801;
        Fri, 17 Feb 2023 05:49:06 -0800 (PST)
X-Google-Smtp-Source: AK7set9vd30xGC9ziQLVSo9CH8dMbfP5K/22/ulKcpKmlY9Tzn88e5jN0KhVGuEzFC+li22riHt+gQ==
X-Received: by 2002:a17:907:a508:b0:8af:54d0:181d with SMTP id vr8-20020a170907a50800b008af54d0181dmr10190298ejc.35.1676641746605;
        Fri, 17 Feb 2023 05:49:06 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id v26-20020a1709060b5a00b008b1787ce722sm1516323ejg.152.2023.02.17.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:49:06 -0800 (PST)
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
Subject: [PATCH drm-next v2 16/16] drm/nouveau: debugfs: implement DRM GPU VA debugfs
Date:   Fri, 17 Feb 2023 14:48:20 +0100
Message-Id: <20230217134820.14672-11-dakr@redhat.com>
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

Provide the driver indirection iterating over all DRM GPU VA spaces to
enable the common 'gpuvas' debugfs file for dumping DRM GPU VA spaces.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 2a36d1ca8fda..7f6ccc5d1d86 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -202,6 +202,29 @@ nouveau_debugfs_pstate_open(struct inode *inode, struct file *file)
 	return single_open(file, nouveau_debugfs_pstate_get, inode->i_private);
 }
 
+static int
+nouveau_debugfs_gpuva(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct nouveau_drm *drm = nouveau_drm(node->minor->dev);
+	struct nouveau_cli *cli;
+
+	mutex_lock(&drm->clients_lock);
+	list_for_each_entry(cli, &drm->clients, head) {
+		struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(cli);
+
+		if (!uvmm)
+			continue;
+
+		nouveau_uvmm_lock(uvmm);
+		drm_debugfs_gpuva_info(m, &uvmm->umgr);
+		nouveau_uvmm_unlock(uvmm);
+	}
+	mutex_unlock(&drm->clients_lock);
+
+	return 0;
+}
+
 static const struct file_operations nouveau_pstate_fops = {
 	.owner = THIS_MODULE,
 	.open = nouveau_debugfs_pstate_open,
@@ -213,6 +236,7 @@ static const struct file_operations nouveau_pstate_fops = {
 static struct drm_info_list nouveau_debugfs_list[] = {
 	{ "vbios.rom",  nouveau_debugfs_vbios_image, 0, NULL },
 	{ "strap_peek", nouveau_debugfs_strap_peek, 0, NULL },
+	DRM_DEBUGFS_GPUVA_INFO(nouveau_debugfs_gpuva, NULL),
 };
 #define NOUVEAU_DEBUGFS_ENTRIES ARRAY_SIZE(nouveau_debugfs_list)
 
-- 
2.39.1

