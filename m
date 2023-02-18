Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32969B8A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBRIKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:10:40 -0500
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F42B2B2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:10:38 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id TIIkp7w6pOJaFTIIlpYfjR; Sat, 18 Feb 2023 09:10:36 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Feb 2023 09:10:36 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: Reorder fields in 'struct virtqueue'
Date:   Sat, 18 Feb 2023 09:10:31 +0100
Message-Id: <8f3d2e49270a2158717e15008e7ed7228196ba02.1676707807.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct virtqueue'
from 72 to 68 bytes.

It saves a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct virtqueue {
	struct list_head           list;                 /*     0    16 */
	void                       (*callback)(struct virtqueue *); /*    16     8 */
	const char  *              name;                 /*    24     8 */
	struct virtio_device *     vdev;                 /*    32     8 */
	unsigned int               index;                /*    40     4 */
	unsigned int               num_free;             /*    44     4 */
	unsigned int               num_max;              /*    48     4 */

	/* XXX 4 bytes hole, try to pack */

	void *                     priv;                 /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	bool                       reset;                /*    64     1 */

	/* size: 72, cachelines: 2, members: 9 */
	/* sum members: 61, holes: 1, sum holes: 4 */
	/* padding: 7 */
	/* last cacheline: 8 bytes */
};

After:
=====
struct virtqueue {
	struct list_head           list;                 /*     0    16 */
	void                       (*callback)(struct virtqueue *); /*    16     8 */
	const char  *              name;                 /*    24     8 */
	struct virtio_device *     vdev;                 /*    32     8 */
	unsigned int               index;                /*    40     4 */
	unsigned int               num_free;             /*    44     4 */
	unsigned int               num_max;              /*    48     4 */
	bool                       reset;                /*    52     1 */

	/* XXX 3 bytes hole, try to pack */

	void *                     priv;                 /*    56     8 */

	/* size: 64, cachelines: 1, members: 9 */
	/* sum members: 61, holes: 1, sum holes: 3 */
};
---
 include/linux/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 6ac2655500dc..9439ae898310 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -35,8 +35,8 @@ struct virtqueue {
 	unsigned int index;
 	unsigned int num_free;
 	unsigned int num_max;
-	void *priv;
 	bool reset;
+	void *priv;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.34.1

