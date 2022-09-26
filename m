Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39665EA6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiIZNLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiIZNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:11:12 -0400
X-Greylist: delayed 928 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 04:40:25 PDT
Received: from ssh249.corpemail.net (ssh249.corpemail.net [210.51.61.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4621C45AF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:40:23 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id VMO00020;
        Mon, 26 Sep 2022 19:13:20 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.12; Mon, 26 Sep 2022 19:13:21 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtio_ring: Drop unnecessary initialization of detach_buf_packed
Date:   Mon, 26 Sep 2022 06:29:46 -0400
Message-ID: <20220926102946.3097-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202292619132013c121f72e694547bc8f0020f2011671
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is initialized but it is only used after its assignment.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8974c34b40fd..abac0a3de440 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1544,7 +1544,7 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 static void detach_buf_packed(struct vring_virtqueue *vq,
 			      unsigned int id, void **ctx)
 {
-	struct vring_desc_state_packed *state = NULL;
+	struct vring_desc_state_packed *state;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 
-- 
2.27.0

