Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFB724FE5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbjFFWeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbjFFWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44319B0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686090762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7jCgjA/GeF+vfePBjhGpS1KJtr0QbtMbF11c3DSw0c=;
        b=M8UtupcC4WHE+4XEIod1gC4c9v0Lc+8+bPs4511w0yrca8sOqUrKsfIN4fyPdIDbCF0tJw
        MhNqL8cfd3GcufokL1bI3lUXjQ4SdonwpxO1ZxwO56KtnjChcWwitL7BaTcR85VnzAzoAV
        9QlX3XRrqFkBrXdsECt8SXmwxaDAqJg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-pwVBVrwoM_m_lJAs5E5GcQ-1; Tue, 06 Jun 2023 18:32:40 -0400
X-MC-Unique: pwVBVrwoM_m_lJAs5E5GcQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso595693166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090759; x=1688682759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7jCgjA/GeF+vfePBjhGpS1KJtr0QbtMbF11c3DSw0c=;
        b=bgKHUJZVpd0ABYVBKOF22Zjf7ZH/A7AcASi7qOfo1+j+6h+XiC2hSHgxirwygxg/76
         yGUFxquLXKoxAJn6OJxhHlVGIYqvZUuXb9cnF7cvWXUXFfoQuzhz9KUyIBsDMrzZLUmE
         eXwWBHnpExpzvB5zmDsAieAYxGQSmEjQHEPWquEDNNCoBKPOHwbt35MYJyOYZBL9KVuv
         3K6n55oZ5rZK3Czbz9mIlBcMZ/PSQ4Sr7zonaRRtKSPIri2EP7Co7JTZX2dHdc/qHq83
         nDHhwfmsneQ6Xe1Eeu9AP8iG/LJmTpPvdk8khrwlaW8rAp2p8R3btkdcPpgk1LNFaUpn
         aFcw==
X-Gm-Message-State: AC+VfDygDGGph3sjOXGUGOkKXxOWs0+Ko8+DUmFaV4cGaZbcqlqDoHpx
        8J7RNvYXpOOoNt+VzBJ1ft4Q28krYj9wPgl1GYJ84vOYoPNm8U7fo/qn6j8xfSvrvJqq7OdMVUO
        cxaFgf0/edsE+1RSBi/4dQBS0
X-Received: by 2002:a17:907:961c:b0:96f:f046:9a92 with SMTP id gb28-20020a170907961c00b0096ff0469a92mr4529863ejc.37.1686090759330;
        Tue, 06 Jun 2023 15:32:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qGlpc03YEG/CcUcMQBwrK3ZBv0I8EcaoURRio7MIi2slO/uki0F3KmJyflgj5wBFLEUnEiA==
X-Received: by 2002:a17:907:961c:b0:96f:f046:9a92 with SMTP id gb28-20020a170907961c00b0096ff0469a92mr4529834ejc.37.1686090759142;
        Tue, 06 Jun 2023 15:32:39 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709063b0900b00969e9fef151sm6051554ejf.97.2023.06.06.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:32:38 -0700 (PDT)
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
Subject: [PATCH drm-next v4 14/14] drm/nouveau: debugfs: implement DRM GPU VA debugfs
Date:   Wed,  7 Jun 2023 00:31:30 +0200
Message-Id: <20230606223130.6132-15-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606223130.6132-1-dakr@redhat.com>
References: <20230606223130.6132-1-dakr@redhat.com>
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

