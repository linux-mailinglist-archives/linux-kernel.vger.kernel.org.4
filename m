Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301273FED6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjF0OqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjF0OpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:45:20 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4E2D4F;
        Tue, 27 Jun 2023 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7AP+04mjhCGwoi8mZXHhSk+FSTzVi3y4B9SmymBm1U=;
  b=B5JvCzRENXTsKMxGoAGWDZconALS+TZ6d+BIM/Uj91ZMG/CjYrbSuZL5
   cSjibfgl5W8ZARbYN8LLgUzgR9uC5N26eP6fq0BIhiA8Mq6iI72EjX8U/
   LFjRMPW39Gxgve/rAjVifL1QL73pzu3CjjBc+AmlLQyO6/m7A4vyxOp/P
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936327"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:52 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/24] virtio-mem: use vmalloc_array and vcalloc
Date:   Tue, 27 Jun 2023 16:43:23 +0200
Message-Id: <20230627144339.144478-9-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vmalloc_array and vcalloc to protect against
multiplication overflows.

The changes were done using the following Coccinelle
semantic patch:

// <smpl>
@initialize:ocaml@
@@

let rename alloc =
  match alloc with
    "vmalloc" -> "vmalloc_array"
  | "vzalloc" -> "vcalloc"
  | _ -> failwith "unknown"

@@
    size_t e1,e2;
    constant C1, C2;
    expression E1, E2, COUNT, x1, x2, x3;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
    fresh identifier realloc = script:ocaml(alloc) { rename alloc };
@@

(
      alloc(x1*x2*x3)
|
      alloc(C1 * C2)
|
      alloc((sizeof(t)) * (COUNT), ...)
|
-     alloc((e1) * (e2))
+     realloc(e1, e2)
|
-     alloc((e1) * (COUNT))
+     realloc(COUNT, e1)
|
-     alloc((E1) * (E2))
+     realloc(E1, E2)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
v2: Use vmalloc_array and vcalloc instead of array_size.
This also leaves a multiplication of a constant by a sizeof
as is.  Two patches are thus dropped from the series.

 drivers/virtio/virtio_mem.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -u -p a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -399,7 +399,7 @@ static int virtio_mem_bbm_bb_states_prep
 	if (vm->bbm.bb_states && old_pages == new_pages)
 		return 0;
 
-	new_array = vzalloc(new_pages * PAGE_SIZE);
+	new_array = vcalloc(new_pages, PAGE_SIZE);
 	if (!new_array)
 		return -ENOMEM;
 
@@ -465,7 +465,7 @@ static int virtio_mem_sbm_mb_states_prep
 	if (vm->sbm.mb_states && old_pages == new_pages)
 		return 0;
 
-	new_array = vzalloc(new_pages * PAGE_SIZE);
+	new_array = vcalloc(new_pages, PAGE_SIZE);
 	if (!new_array)
 		return -ENOMEM;
 
@@ -588,7 +588,7 @@ static int virtio_mem_sbm_sb_states_prep
 	if (vm->sbm.sb_states && old_pages == new_pages)
 		return 0;
 
-	new_bitmap = vzalloc(new_pages * PAGE_SIZE);
+	new_bitmap = vcalloc(new_pages, PAGE_SIZE);
 	if (!new_bitmap)
 		return -ENOMEM;
 

