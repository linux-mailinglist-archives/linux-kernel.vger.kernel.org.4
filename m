Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2873C266
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjFWVQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjFWVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:16:00 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00B295E;
        Fri, 23 Jun 2023 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W1WB9Wb0BvRRcBkbSVITYF4i4Xscr+EN0kvgwOJ6wOs=;
  b=WmG/JpBrM0La8Q7SPsscDO+9vwp6o00kURhYuE4MeUme0ls/EvAKTJhY
   mp+BcN1WhFW8+h7eRAujDv59DBrIbAx6oxgu581730TSsqjI0R/hG8vwc
   R2wBhiJozXLBTfyUjGNSc07qmFKw/jr6X7BSNFOgHP2+n6nDAix+z1p0U
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686181"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:14 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/26] media: staging: imgu: use array_size
Date:   Fri, 23 Jun 2023 23:14:54 +0200
Message-Id: <20230623211457.102544-24-Julia.Lawall@inria.fr>
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
 drivers/staging/media/ipu3/ipu3-mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
index cb9bf5fb29a5..9c4adb815c94 100644
--- a/drivers/staging/media/ipu3/ipu3-mmu.c
+++ b/drivers/staging/media/ipu3/ipu3-mmu.c
@@ -464,7 +464,7 @@ struct imgu_mmu_info *imgu_mmu_init(struct device *parent, void __iomem *base)
 	 * Allocate the array of L2PT CPU pointers, initialized to zero,
 	 * which means the dummy L2PT allocated above.
 	 */
-	mmu->l2pts = vzalloc(IPU3_PT_PTES * sizeof(*mmu->l2pts));
+	mmu->l2pts = vzalloc(array_size(IPU3_PT_PTES, sizeof(*mmu->l2pts)));
 	if (!mmu->l2pts)
 		goto fail_l2pt;
 

