Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359E4612117
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ2Hrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2Hre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:47:34 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5C0DB8C0D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=K2PKa
        fCEYXHMfQ1Jc/mijsgMNFcp0Mg3fqjNMpvECbI=; b=FMEoRNbDFET3f1Gmh/iC8
        MzOuoi8D2ngIRNibx9WNxR2+HU20n3rDX9YrLVjNmg6aQuahtKhAmMHSnU0ZlekO
        Jz2V1pTeS3Zxa2UGvA3LmLtNkRq9+jA9BCGLWUokmpm/a+PasfqRar473kYDQf5X
        5enOQWFq/D+ycL3OPXITG0=
Received: from localhost.localdomain (unknown [111.206.145.21])
        by smtp3 (Coremail) with SMTP id G9xpCgDH1S1w2lxjInYWpQ--.13602S2;
        Sat, 29 Oct 2022 15:46:56 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     nouveau@lists.freedesktop.org
Cc:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org, daniel@ffwll.ch,
        Julia.Lawall@inria.fr, linux-kernel@vger.kernel.org,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] drm/nouveau/mmu: fix use-after-free bug in nvkm_vmm_pfn_map
Date:   Sat, 29 Oct 2022 15:46:54 +0800
Message-Id: <20221029074654.203153-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDH1S1w2lxjInYWpQ--.13602S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1xAr1UXF4kZr4fAw17trb_yoWDGrb_uF
        1rXrnxWr95CryDWws8ZF43AFy2gan7ZFs2q3WSy3sxtasrXrsxWr9xZrn5W3s8AF1xKFyD
        G3WkXr1FqrnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKVbytUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQhCpU1aEDXIgKgAAsP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it failed in kzalloc, vma will be freed in nvkm_vmm_node_merge.
The later use of vma will casue use after free.

Reported-by: Zheng Wang <hackerzheng666@gmail.com>
Reported-by: Zhuorao Yang <alex000young@gmail.com>

Fix it by returning to upper caller as soon as error occurs.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index ae793f400ba1..04befd28f80b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1272,8 +1272,7 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u64 addr, u64 size, u64 *pfn)
 						       page -
 						       vmm->func->page, map);
 			if (WARN_ON(!tmp)) {
-				ret = -ENOMEM;
-				goto next;
+				return -ENOMEM;
 			}
 
 			if ((tmp->mapped = map))
-- 
2.25.1

