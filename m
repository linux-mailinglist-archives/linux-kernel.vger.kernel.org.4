Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BCD73C25E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjFWVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjFWVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:15:32 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048726B9;
        Fri, 23 Jun 2023 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1b2qOiijM2SOFY49y/T4nNKOOzZTttGdtrLG5Lh64bI=;
  b=uyu8z8wzWEtEgebrWGzG9i5oWEcHT9BaIjP0Cs8YqJ4Dnb9025dIo99d
   UntoRq5hk/R+vCjtxjxaQzUluEwwNY91uXDdnCSwbykFbM7jOIMaPWqbb
   mmDU8w2Ro+9cTiPSvq7ACpxLUR8sUeZ+2YhiHhuPAojA3G8yl102Og3hU
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686176"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:13 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/26] net: enetc: use array_size
Date:   Fri, 23 Jun 2023 23:14:49 +0200
Message-Id: <20230623211457.102544-19-Julia.Lawall@inria.fr>
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
 drivers/net/ethernet/freescale/enetc/enetc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9e1b2536e9a9..7231f8ea1ba4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1790,7 +1790,7 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
 	res->bd_count = bd_count;
 	res->bd_size = sizeof(union enetc_tx_bd);
 
-	res->tx_swbd = vzalloc(bd_count * sizeof(*res->tx_swbd));
+	res->tx_swbd = vzalloc(array_size(bd_count, sizeof(*res->tx_swbd)));
 	if (!res->tx_swbd)
 		return -ENOMEM;
 
@@ -1878,7 +1878,7 @@ static int enetc_alloc_rx_resource(struct enetc_bdr_resource *res,
 	if (extended)
 		res->bd_size *= 2;
 
-	res->rx_swbd = vzalloc(bd_count * sizeof(struct enetc_rx_swbd));
+	res->rx_swbd = vzalloc(array_size(bd_count, sizeof(struct enetc_rx_swbd)));
 	if (!res->rx_swbd)
 		return -ENOMEM;
 

