Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B916450D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLGBNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGBNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:13:20 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B726F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:13:19 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRfRf3WCGz4xVnK;
        Wed,  7 Dec 2022 09:13:18 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl1.zte.com.cn with SMTP id 2B71DF9g056980;
        Wed, 7 Dec 2022 09:13:15 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 7 Dec 2022 09:13:16 +0800 (CST)
Date:   Wed, 7 Dec 2022 09:13:16 +0800 (CST)
X-Zmail-TransId: 2b04638fe8ac20c82928
X-Mailer: Zmail v1.0
Message-ID: <202212070913161959936@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <airlied@redhat.com>
Cc:     <kraxel@redhat.com>, <gurchetansingh@chromium.org>,
        <olvaffe@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS92aXJ0aW86IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B71DF9g056980
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638FE8AE.000 by FangMail milter!
X-FangMail-Envelope: 1670375598/4NRfRf3WCGz4xVnK/638FE8AE.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638FE8AE.000/4NRfRf3WCGz4xVnK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9ff8660b50ad..7d95bc74b307 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -916,8 +916,7 @@ void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
 	cmd_p->hdr.ctx_id = cpu_to_le32(id);
 	cmd_p->nlen = cpu_to_le32(nlen);
 	cmd_p->context_init = cpu_to_le32(context_init);
-	strncpy(cmd_p->debug_name, name, sizeof(cmd_p->debug_name) - 1);
-	cmd_p->debug_name[sizeof(cmd_p->debug_name) - 1] = 0;
+	strscpy(cmd_p->debug_name, name, sizeof(cmd_p->debug_name));
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }

-- 
2.15.2
