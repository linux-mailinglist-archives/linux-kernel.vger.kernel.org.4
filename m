Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9973C26D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjFWVRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjFWVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:16:40 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0FB30DE;
        Fri, 23 Jun 2023 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zjTOkHzHNJN2JwbbSn0B3jYr0f7hFN0oZZoh6lbquOQ=;
  b=FPVhggARCWGLgx/uc1XplQBbZp4QfJ3ScSLfue5dgqmPlrnQ4BiqzZpN
   IQ21XgRjNNOHEfdPKTVuJdURuqERB5NCaGfeDpyZ+YpyMYSfpq+KUPiuU
   +vQ3rGawBQbmwNRu052NXLgEaJzd/RusbfLOqx+1C3Tv2tUHQBsR4S4Tk
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686190"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:15 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/26] comedi: use array_size
Date:   Fri, 23 Jun 2023 23:14:57 +0200
Message-Id: <20230623211457.102544-27-Julia.Lawall@inria.fr>
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
    size_t e1,e2;
    expression COUNT;
    identifier alloc = {vmalloc,vzalloc,kvmalloc,kvzalloc};
@@

(
      alloc(
-           (e1) * (e2)
+           array_size(e1, e2)
      ,...)
|
      alloc(
-           (e1) * (COUNT)
+           array_size(COUNT, e1)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/comedi/comedi_buf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 393966c09740..32ad3e6e1ce8 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -89,7 +89,7 @@ comedi_buf_map_alloc(struct comedi_device *dev, enum dma_data_direction dma_dir,
 		bm->dma_hw_dev = get_device(dev->hw_dev);
 	}
 
-	bm->page_list = vzalloc(sizeof(*buf) * n_pages);
+	bm->page_list = vzalloc(array_size(n_pages, sizeof(*buf)));
 	if (!bm->page_list)
 		goto err;
 
@@ -169,7 +169,7 @@ static void __comedi_buf_alloc(struct comedi_device *dev,
 		buf = &bm->page_list[0];
 		async->prealloc_buf = buf->virt_addr;
 	} else {
-		pages = vmalloc(sizeof(struct page *) * n_pages);
+		pages = vmalloc(array_size(n_pages, sizeof(struct page *)));
 		if (!pages)
 			return;
 

