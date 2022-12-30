Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A596595B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiL3H20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiL3H2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:21 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09F5018E08
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BZVBV
        RQVrTSn4BzI4JujaZV4qktmUeRF9eHZ5CKmHQM=; b=gJadKLaWCNs+R5dJcOlvU
        pXAWaVns4xKQJLjAOu+DCzyNHH7dhJ3pj3HBpKS6uyqCsb9Hz5V5ts2/uazefHoT
        t+TzH+ipfiNnAwWJ/KJaRUX3DCOcCdjr1SyFCyCIczbjTBIXcwvMrD8tlF5jnqtg
        Ercxuwa3ZpPBCNZF8HhgUQ=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp16 (Coremail) with SMTP id MNxpCgCnzzsVk65jw+eMDQ--.25047S2;
        Fri, 30 Dec 2022 15:28:21 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     bskeggs@redhat.com
Cc:     kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        hackerzheng666@gmail.com, alex000young@gmail.com,
        security@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] drm/nouveau/mmu: fix Use after Free bug in nvkm_vmm_node_split
Date:   Fri, 30 Dec 2022 15:27:58 +0800
Message-Id: <20221230072758.443644-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: MNxpCgCnzzsVk65jw+eMDQ--.25047S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF15Gr48ur17XrW5WryxGrg_yoW8JF4rpF
        45uryYvryxuF4Ut340vFy8ur90kan2yFWIk34YvasIvwnxZ3y0vFW5AryUGryrZw4xWw1a
        qr4DGr1fWry5ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbCbxTnU2BbEN8pBAAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a function call chain.
nvkm_vmm_pfn_map->nvkm_vmm_pfn_split_merge->nvkm_vmm_node_split
If nvkm_vma_tail return NULL in nvkm_vmm_node_split, it will
finally invoke nvkm_vmm_node_merge->nvkm_vmm_node_delete, which
will free the vma. However, nvkm_vmm_pfn_map didn't notice that.
It goes into next label and UAF happens.

Fix it by returning the return-value of nvkm_vmm_node_merge
instead of NULL.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index ae793f400ba1..84d6fc87b2e8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -937,8 +937,8 @@ nvkm_vmm_node_split(struct nvkm_vmm *vmm,
 	if (vma->size != size) {
 		struct nvkm_vma *tmp;
 		if (!(tmp = nvkm_vma_tail(vma, vma->size - size))) {
-			nvkm_vmm_node_merge(vmm, prev, vma, NULL, vma->size);
-			return NULL;
+			tmp = nvkm_vmm_node_merge(vmm, prev, vma, NULL, vma->size);
+			return tmp;
 		}
 		tmp->part = true;
 		nvkm_vmm_node_insert(vmm, tmp);
-- 
2.25.1

