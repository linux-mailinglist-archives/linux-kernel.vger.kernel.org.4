Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734A97360DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjFTAo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFTAot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA83198B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687221817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7jCgjA/GeF+vfePBjhGpS1KJtr0QbtMbF11c3DSw0c=;
        b=XDPWRI5r/YxqMw77LpKpVWDNaDMJgODj8tNPjnF3U8n9cy7rJtdGB2UmL62p5GILdNu8Dl
        z6UYQzk1nPz0QzWPI3kAwYCu7cUEAoHNLK76xaQISXuThkchMfooirv1QdZdZrMyCWB/MF
        QuinLSqfmX25Gj6bzJeNy3TGihFQOK0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-KE7eDRiZOQiA_GZV1nt3Tw-1; Mon, 19 Jun 2023 20:43:36 -0400
X-MC-Unique: KE7eDRiZOQiA_GZV1nt3Tw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50ddef368e4so2270170a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221815; x=1689813815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7jCgjA/GeF+vfePBjhGpS1KJtr0QbtMbF11c3DSw0c=;
        b=jTJ3tJ2NNWLSAdQr37wD0xlVPgMl74U0gCnNd2jy0sTShGnsJoWicaogDYIEjMzqRU
         kNmF6+ur/3o/v1boWbbcVAtPJHtbSv6TnEi9jpw3BsyeB4qF7Jf9Fqtp1AVUzQ1KxgKD
         GkUimR3GL4Ha7POcme/CmqP+yknuR7cI5oJQXkWz4MQaFT7caYbSkoEK36nTNR12FJ4f
         hbtDUAeTUZ4bcje/gGjnK3Du9kaCajlFgK/uRcy5gVLtt8HOUMo0Gp719RcpNHv1ynsx
         y6rJMdEJhu/omf9t0SrggLoIjN8gUiPim8MrGpu+oKrHpxEWUq730Xik46l1if5ttbcb
         XeYA==
X-Gm-Message-State: AC+VfDzk3Zpn3WXAd2ZLx5ykBwahy0CVtyc6IswCR+frSQ4eCohasDM+
        L4xAFS34lRXVIktc+/m7ZXD/jROBaSet47aswFFRgMzZhz1KSIhBsbM4fnI4JtNyWn4NYQxc2LG
        U4toaKfjrBaTBqArcSOaryKK6
X-Received: by 2002:a17:907:16a2:b0:977:4b68:bf2 with SMTP id hc34-20020a17090716a200b009774b680bf2mr9258848ejc.54.1687221815351;
        Mon, 19 Jun 2023 17:43:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5q+6yQrxXHN5sb4rpMGvKSpAc2GEIwMGMC//JzmRysYg1+0tvGxqivxz5K0CNgMJjmvWb+Bw==
X-Received: by 2002:a17:907:16a2:b0:977:4b68:bf2 with SMTP id hc34-20020a17090716a200b009774b680bf2mr9258842ejc.54.1687221815070;
        Mon, 19 Jun 2023 17:43:35 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id bk6-20020a170906b0c600b0098748422178sm393480ejb.56.2023.06.19.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:43:34 -0700 (PDT)
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
Subject: [PATCH drm-next v5 14/14] drm/nouveau: debugfs: implement DRM GPU VA debugfs
Date:   Tue, 20 Jun 2023 02:42:17 +0200
Message-Id: <20230620004217.4700-15-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620004217.4700-1-dakr@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
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

Provide the driver indirection iterating over all DRM GPU VA spaces to
enable the common 'gpuvas' debugfs file for dumping DRM GPU VA spaces.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 99d022a91afc..053f703f2f68 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -203,6 +203,44 @@ nouveau_debugfs_pstate_open(struct inode *inode, struct file *file)
 	return single_open(file, nouveau_debugfs_pstate_get, inode->i_private);
 }
 
+static void
+nouveau_debugfs_gpuva_regions(struct seq_file *m, struct nouveau_uvmm *uvmm)
+{
+	MA_STATE(mas, &uvmm->region_mt, 0, 0);
+	struct nouveau_uvma_region *reg;
+
+	seq_puts  (m, " VA regions  | start              | range              | end                \n");
+	seq_puts  (m, "----------------------------------------------------------------------------\n");
+	mas_for_each(&mas, reg, ULONG_MAX)
+		seq_printf(m, "             | 0x%016llx | 0x%016llx | 0x%016llx\n",
+			   reg->va.addr, reg->va.range, reg->va.addr + reg->va.range);
+}
+
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
+		seq_puts(m, "\n");
+		nouveau_debugfs_gpuva_regions(m, uvmm);
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
@@ -214,6 +252,7 @@ static const struct file_operations nouveau_pstate_fops = {
 static struct drm_info_list nouveau_debugfs_list[] = {
 	{ "vbios.rom",  nouveau_debugfs_vbios_image, 0, NULL },
 	{ "strap_peek", nouveau_debugfs_strap_peek, 0, NULL },
+	DRM_DEBUGFS_GPUVA_INFO(nouveau_debugfs_gpuva, NULL),
 };
 #define NOUVEAU_DEBUGFS_ENTRIES ARRAY_SIZE(nouveau_debugfs_list)
 
-- 
2.40.1

