Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA167146C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjARGkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjARG0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D7552A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674022465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHl/4diKtyJnEE11WWdgE7GtYAgDLsei1RwmYtZIKRg=;
        b=WQ0V9+KW6VMn0ifr33bQKJq0glGdLjCYvkPabaE/d7GNcdXQ5nT1+NKBwDABRTO7v1Ev7J
        bmVNrtwFkj9BkXTcy77wUZk7N80I66VbWGLi5OOznpVCV9PDIAPg0fFezzVIIHwjYxuryf
        wksqYH568um1VSSvhkXW/UEmZSrKpdU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-mT75pktpPX-JWLRokZSLBA-1; Wed, 18 Jan 2023 01:14:24 -0500
X-MC-Unique: mT75pktpPX-JWLRokZSLBA-1
Received: by mail-ej1-f71.google.com with SMTP id dr5-20020a170907720500b00808d17c4f27so22931229ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHl/4diKtyJnEE11WWdgE7GtYAgDLsei1RwmYtZIKRg=;
        b=vo9GHiHIB/qyOvfzQXqvG+nHtOnjQKbQITdcGBrc/JRaPkf7gwlBHQSZXyG4/cwoKu
         BwiezMwv0tdfo9JnJnfWTVJwHj0j/FWwrJuYOQMM5I5ercCV8UkyXtCqDXWlbQc9u4V2
         FT0fYtwRhtCiH6yTpm6hSIGRyPEuew+3p41C7PcE4NJoLjijamRHdqi+KLoO9yL6AELD
         L86GfY4z6vSqBOmu/A7mUyzyPWpV4XE6Eu9LQcZGlGEBPjK9otbP+W/+qvIK9brr+1P/
         uMYE5+KUojoPk7tf1usJ3GjWggg48I7Q3s5h1OcGZarSx3e940RMergYuZXxDPP6ZuLU
         royQ==
X-Gm-Message-State: AFqh2kq3B6by6RvjMCfXplZsPGioQFLZ6jOVxF1ghZfoi9EpuEKWs2rA
        pJrjia/COwJf+kHtxySmb1gKAVb4rzRQv+THsKjSlZ5CJeSxp133uIAQS6K4nSIp7bpPXAFfnf+
        IlWb/iyG3xX//mzBVDdzOB/M2
X-Received: by 2002:aa7:c1ce:0:b0:49e:89e:3b36 with SMTP id d14-20020aa7c1ce000000b0049e089e3b36mr5877842edp.30.1674022462952;
        Tue, 17 Jan 2023 22:14:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsRQZOK3N/r5iyFAQ3K40aM3jSUaK6Mlg89vmZUZhLYBBDqIPzyzq48oNYdtZTi8SPf5PDyyg==
X-Received: by 2002:aa7:c1ce:0:b0:49e:89e:3b36 with SMTP id d14-20020aa7c1ce000000b0049e089e3b36mr5877825edp.30.1674022462771;
        Tue, 17 Jan 2023 22:14:22 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm14105071ejh.0.2023.01.17.22.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:14:22 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@redhat.com, christian.koenig@amd.com,
        bskeggs@redhat.com, jason@jlekstrand.net, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next 14/14] drm/nouveau: debugfs: implement DRM GPU VA debugfs
Date:   Wed, 18 Jan 2023 07:12:56 +0100
Message-Id: <20230118061256.2689-15-dakr@redhat.com>
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
2.39.0

