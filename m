Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABA688C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBCB1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBCB06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:26:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7226E12070;
        Thu,  2 Feb 2023 17:26:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D52EB828E3;
        Fri,  3 Feb 2023 01:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA63C433D2;
        Fri,  3 Feb 2023 01:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675387614;
        bh=BeDxNw/tbCXEvqvBC4QZZK3yzQcUhswiYl5f9/R3DnU=;
        h=Date:From:To:Cc:Subject:From;
        b=fgjB/OX/yNDmVt8S9/mAB1WYIfH8CuP9RCrtSbH3soSX4Kuz2IJ9bbMmLxxNalu4S
         DtdEgK36CFsj58PLna91BETx2B5TO4eJ6od4DJC2r5cxMQJ9G8DUEjjHtSSU1CpVql
         /FfRN8XVncaUoqHOYNJss3kfPAFP8RXEXHFkNf2oRwyi0YspICLPJhFn8m97hr6fgH
         Nb+48MtQKRxTRrU+SVb1M4GBqfClIq+UNBWj9YFpj7fQ03W0CM60Rp3/1OsmiQUuT2
         Ar03yAWEbnWMNlnm3HgiY2Sz2HD1ImFMxOtKe1O1PZPiNVdaco9hTp0/Kr3ot4sloI
         dWPogeww9QBXQ==
Date:   Thu, 2 Feb 2023 19:27:10 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/vmwgfx: Replace one-element array with
 flexible-array member
Message-ID: <Y9xi7nFWRV3S9gCg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct vmw_view.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/254
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
index 4ea32b01efc0..0f696ccaddc6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
@@ -70,7 +70,7 @@ struct vmw_view {
 	unsigned view_id;              /* Immutable */
 	u32 cmd_size;                  /* Immutable */
 	bool committed;                /* Protected by binding_mutex */
-	u32 cmd[1];                    /* Immutable */
+	u32 cmd[];		       /* Immutable */
 };
 
 static int vmw_view_create(struct vmw_resource *res);
-- 
2.34.1

