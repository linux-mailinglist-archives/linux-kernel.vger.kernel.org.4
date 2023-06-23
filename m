Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166573C252
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjFWVPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFWVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:15:19 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44810F1;
        Fri, 23 Jun 2023 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TRxy0AuF5FOCiYvvmf3tnTeoM1gUmxAEjlXeC+Ek4Q=;
  b=VcpH1Vz0lqQVGPsxzochEoOjLBSc7ukpvC0FInUkitVeye74rVXmkSmp
   1zR87l1hIw+Bcv7BD6j6LRDjNKx1pb8Z8uiDSlyxpiroLgRzEW8mz11z+
   x0vo0RpBsnP8Y82mxqlPr9vofLYNF8zqIvipC0saNwk8j8BrYh7KafGGo
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686169"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:12 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/26] ionic: use array_size
Date:   Fri, 23 Jun 2023 23:14:42 +0200
Message-Id: <20230623211457.102544-12-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 957027e546b3..f2e2c6853536 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -560,7 +560,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 	new->q.dev = dev;
 	new->flags = flags;
 
-	new->q.info = vzalloc(num_descs * sizeof(*new->q.info));
+	new->q.info = vzalloc(array_size(num_descs, sizeof(*new->q.info)));
 	if (!new->q.info) {
 		netdev_err(lif->netdev, "Cannot allocate queue info\n");
 		err = -ENOMEM;
@@ -581,7 +581,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 	if (err)
 		goto err_out;
 
-	new->cq.info = vzalloc(num_descs * sizeof(*new->cq.info));
+	new->cq.info = vzalloc(array_size(num_descs, sizeof(*new->cq.info)));
 	if (!new->cq.info) {
 		netdev_err(lif->netdev, "Cannot allocate completion queue info\n");
 		err = -ENOMEM;

