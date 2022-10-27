Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAD60F351
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiJ0JLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiJ0JKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5D2D1FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5023762245
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC741C4314E;
        Thu, 27 Oct 2022 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861828;
        bh=c9GWqwITW/Ec76TO4vaKC32ouj33G3nwcnNIKBnDo1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qv4ysXdD0S4JZhKZhqSTXAwA5Sev2/KyXvDQUJZ6C/SU5cSiltZnb2XdI6vlKtY/9
         A0RZi4gT0m/eN87JOITfz5kpsyuzvx0Yls/6Q/ruxJeTCizKZBDAyZWIpmFFhGjugB
         SVcQnqpEsi0cvNzSK+xf3R64hcWkAFVD759CUjBD8VZQscbb3sCfnAZioSRyX3V0e1
         5NDX5WO+qh/2g1HIFOr6PUYt91Ojj8hU/zSB1y3YYvclr8QgoVaNaH0yrkFMtlGo9/
         Pwvj0BKGQGZReCJxlP0K4syGd/Ht4E+NtnMKiOU+/jYbsQYY75C6yB6Llw3oKQKLVz
         gPbhxHIECE/4A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 12/15] habanalabs: zero ts registration buff when allocated
Date:   Thu, 27 Oct 2022 12:10:04 +0300
Message-Id: <20221027091007.664797-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

To avoid memory corruption in kernel memory while using timestamp
registration nodes, zero the kernel buff memory when its allocated.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 99b1d6ce26ae..541e1b6a2176 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2109,7 +2109,7 @@ static int hl_ts_alloc_buf(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args)
 
 	/* Allocate the internal kernel buffer */
 	size = num_elements * sizeof(struct hl_user_pending_interrupt);
-	p = vmalloc(size);
+	p = vzalloc(size);
 	if (!p)
 		goto free_user_buff;
 
-- 
2.25.1

