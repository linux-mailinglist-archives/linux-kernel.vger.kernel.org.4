Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB773FED0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjF0OqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjF0OpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:45:25 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950363584;
        Tue, 27 Jun 2023 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YkMaWxPDeWDuwTCFlcObNyyTEnApvX0G2Mje4w+fbtU=;
  b=lPX+7nYe2ZOHxz0U8/dk+DhD+wLKHgnLzJkbNkPJLIr3SePpUVgi6Skq
   Q+SJxt7nzTKIib54VI3UqWgjp2Ujv3MeddOvxrKuRUlHb7MKhVf12NvxB
   vTBapNghDQqBLKxRS6/K9ORo/2D4ZInye6vH9tidIFBk5UrzVe7gTYA8t
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936332"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:52 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/24] ionic: use vmalloc_array and vcalloc
Date:   Tue, 27 Jun 2023 16:43:26 +0200
Message-Id: <20230627144339.144478-12-Julia.Lawall@inria.fr>
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

 drivers/net/ethernet/pensando/ionic/ionic_lif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -561,7 +561,7 @@ static int ionic_qcq_alloc(struct ionic_
 	new->q.dev = dev;
 	new->flags = flags;
 
-	new->q.info = vzalloc(num_descs * sizeof(*new->q.info));
+	new->q.info = vcalloc(num_descs, sizeof(*new->q.info));
 	if (!new->q.info) {
 		netdev_err(lif->netdev, "Cannot allocate queue info\n");
 		err = -ENOMEM;
@@ -582,7 +582,7 @@ static int ionic_qcq_alloc(struct ionic_
 	if (err)
 		goto err_out;
 
-	new->cq.info = vzalloc(num_descs * sizeof(*new->cq.info));
+	new->cq.info = vcalloc(num_descs, sizeof(*new->cq.info));
 	if (!new->cq.info) {
 		netdev_err(lif->netdev, "Cannot allocate completion queue info\n");
 		err = -ENOMEM;

