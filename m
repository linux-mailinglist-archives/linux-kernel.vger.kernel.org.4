Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40C73C258
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFWVP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjFWVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:15:23 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342D1993;
        Fri, 23 Jun 2023 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=42OKv4WqZGQxlnFHmnIuYt+rtnNJuJHuQ6K07YbNUj8=;
  b=GXBNYgmL2uYfs6qFigazu5bHqzJHBpCz8l880MNXwd+9eRslqwZ3OOsI
   Mg6LYxvrebz27/FhrAyaK87WAa+UpTYqEiIKSJflTdI9YiVVutKzyTKHQ
   OMrvn1ry8QKjC8losr/ymVYFeWIWjK52PpQAd1FD2UAhzi/Qrd3wzTeZP
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686173"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:12 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/26] habanalabs: use array_size
Date:   Fri, 23 Jun 2023 23:14:46 +0200
Message-Id: <20230623211457.102544-16-Julia.Lawall@inria.fr>
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
 drivers/accel/habanalabs/common/device.c     |    3 ++-
 drivers/accel/habanalabs/common/state_dump.c |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index fabfc501ef54..8e2edefa6d3c 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2572,7 +2572,8 @@ static void hl_capture_user_mappings(struct hl_device *hdev, bool is_pmmu)
 	 */
 	vfree(pgf_info->user_mappings);
 	pgf_info->user_mappings =
-			vzalloc(pgf_info->num_of_user_mappings * sizeof(struct hl_user_mapping));
+			vzalloc(array_size(pgf_info->num_of_user_mappings,
+					   sizeof(struct hl_user_mapping)));
 	if (!pgf_info->user_mappings) {
 		pgf_info->num_of_user_mappings = 0;
 		goto finish;
diff --git a/drivers/accel/habanalabs/common/state_dump.c b/drivers/accel/habanalabs/common/state_dump.c
index 3a9931f24259..324cb7c9bc26 100644
--- a/drivers/accel/habanalabs/common/state_dump.c
+++ b/drivers/accel/habanalabs/common/state_dump.c
@@ -272,7 +272,7 @@ static u32 *hl_state_dump_read_sync_objects(struct hl_device *hdev, u32 index)
 	base_addr = sds->props[SP_SYNC_OBJ_BASE_ADDR] +
 			sds->props[SP_NEXT_SYNC_OBJ_ADDR] * index;
 
-	sync_objects = vmalloc(sds->props[SP_SYNC_OBJ_AMOUNT] * sizeof(u32));
+	sync_objects = vmalloc(array_size(sds->props[SP_SYNC_OBJ_AMOUNT], sizeof(u32)));
 	if (!sync_objects)
 		return NULL;
 
@@ -453,8 +453,8 @@ hl_state_dump_alloc_read_sm_block_monitors(struct hl_device *hdev, u32 index)
 	s64 base_addr; /* Base addr can be negative */
 	int i;
 
-	monitors = vmalloc(sds->props[SP_MONITORS_AMOUNT] *
-			   sizeof(struct hl_mon_state_dump));
+	monitors = vmalloc(array_size(sds->props[SP_MONITORS_AMOUNT],
+				      sizeof(struct hl_mon_state_dump)));
 	if (!monitors)
 		return NULL;
 

