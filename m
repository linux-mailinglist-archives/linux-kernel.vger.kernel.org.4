Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F37973FEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjF0Op3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjF0Ooy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:44:54 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E1730F9;
        Tue, 27 Jun 2023 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EVWsKZHA5sOX60HufObe+UOCTdtjhEjhk52tD7khaXk=;
  b=YiBhSF6iFx9Y7bUlk/oeZ9e9XBU2wtUjxdXzeaWAa04130mi7xMLwQ7/
   D5clOwTGrRgCVQj0YszXht1xsutUj8JN6X+TOWF432vl0LvK2epGu++PW
   JSpcR1yhL2M21hPKmCNNbg74dczchrf+cqRoFMmR/AbJ/HrTa9At4AYdg
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936319"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:51 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Veerasenareddy Burru <vburru@marvell.com>
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/24] octeon_ep: use vmalloc_array and vcalloc
Date:   Tue, 27 Jun 2023 16:43:17 +0200
Message-Id: <20230627144339.144478-3-Julia.Lawall@inria.fr>
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

 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -158,7 +158,7 @@ static int octep_setup_oq(struct octep_d
 		goto desc_dma_alloc_err;
 	}
 
-	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
+	oq->buff_info = vcalloc(oq->max_count, OCTEP_OQ_RECVBUF_SIZE);
 	if (unlikely(!oq->buff_info)) {
 		dev_err(&oct->pdev->dev,
 			"Failed to allocate buffer info for OQ-%d\n", q_no);

