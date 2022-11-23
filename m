Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF6636294
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbiKWO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbiKWO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D9634E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EBADB8201C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DB3C433D7;
        Wed, 23 Nov 2022 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215495;
        bh=5jxaYMiu4ozkhB4fDUDBApe2T/jh7jSelB/YFfvZn64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbVAF/EuyJTb5kE0t2LUt+2GaWCNKNXdwAEOR0juma/lTnErFo6v9Yigbr5c/7b+a
         A9TLqyM3iaphnG0i3IsHxqSGwZ6t1It570pFioQ9rRov6jwvN4tLlZ4SoCckuotrnB
         i8igL0xbEDf0RRFE2fo5aBWTPwtZdegmvCjflPNpBfnGNpkp9bnLb2G19cOCYpQ57t
         g78eKwZn0/DUHkVVKDU4UQFwe6NUz3hyDf5NOVnvhHT5KmvzL3vYUzJwqAYUfyq7Rr
         KaBHU+L8OZIUZ/yduv4y2s+A48fMBMMUtMkffZIILW3s9Kl52HEX3FH3DsMjt8EVHO
         dsJEj4io0RnhA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 8/8] habanalabs: fix VA range calculation
Date:   Wed, 23 Nov 2022 16:58:01 +0200
Message-Id: <20221123145801.542029-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123145801.542029-1-ogabbay@kernel.org>
References: <20221123145801.542029-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Current implementation is fixing the page size to PAGE_SIZE whereas the
input page size may be different.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 541e1b6a2176..7c5c18be294a 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2508,24 +2508,20 @@ static int va_range_init(struct hl_device *hdev, struct hl_va_range **va_ranges,
 
 	/*
 	 * PAGE_SIZE alignment
-	 * it is the callers responsibility to align the addresses if the
+	 * it is the caller's responsibility to align the addresses if the
 	 * page size is not a power of 2
 	 */
 
 	if (is_power_of_2(page_size)) {
-		if (start & (PAGE_SIZE - 1)) {
-			start &= PAGE_MASK;
-			start += PAGE_SIZE;
-		}
+		start = round_up(start, page_size);
 
 		/*
 		 * The end of the range is inclusive, hence we need to align it
 		 * to the end of the last full page in the range. For example if
 		 * end = 0x3ff5 with page size 0x1000, we need to align it to
-		 * 0x2fff. The remainig 0xff5 bytes do not form a full page.
+		 * 0x2fff. The remaining 0xff5 bytes do not form a full page.
 		 */
-		if ((end + 1) & (PAGE_SIZE - 1))
-			end = ((end + 1) & PAGE_MASK) - 1;
+		end = round_down(end + 1, page_size) - 1;
 	}
 
 	if (start >= end) {
-- 
2.25.1

