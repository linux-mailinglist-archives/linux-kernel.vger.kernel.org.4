Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E366B029
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjAOJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjAOJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:40:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0832BC156
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:40:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9455960C73
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 09:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21937C433F0;
        Sun, 15 Jan 2023 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673775633;
        bh=RlGlfXOqT9FY8HDlxtYKGOJbb3f6aiHTxMdcG8g+F6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uc+SluZirIyxte0KTVtJ/A7wvov+cN7mb1j0btYryx/gSkl4++bNIj3YJJHq9JxSK
         yHjMNRvjHqiau9/OKkKyEzFXSqRV7T8U4TEIosQVoMnx6LjlDDmyDnychP2lhSPPhF
         UBSbDpOFHef+b2MC0kJUPp/3l2H46zpaAkheF/OD5zXAjZFx12yUMdc4oeX7sq4Hb3
         +qwBr1CYLaFjNdnlSU5kCN3s5hObxZuoZBMZqmNHGrjl8Z95OgoI9aTxna1AB6XybT
         oZ2wohhsNtvvds1QyQUAmcE9oXNWPgiU0Fl8ESYWq/SEJN9RpqAYWZNXWcl2hlrQtQ
         yRBE/uRyInv5g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/5] habanalabs: bugs fixes in timestamps buff alloc
Date:   Sun, 15 Jan 2023 11:40:23 +0200
Message-Id: <20230115094026.289766-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115094026.289766-1-ogabbay@kernel.org>
References: <20230115094026.289766-1-ogabbay@kernel.org>
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

From: farah kassabri <fkassabri@habana.ai>

use argument instead of fixed GFP value for allocation
in Timestamps buffers alloc function.
change data type of size to size_t.

Fixes: 9158bf69e74f ("habanalabs: Timestamps buffers registration")
Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 56283dd874e1..e6474d38afc4 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -2170,12 +2170,13 @@ static int hl_ts_mmap(struct hl_mmap_mem_buf *buf, struct vm_area_struct *vma, v
 static int hl_ts_alloc_buf(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args)
 {
 	struct hl_ts_buff *ts_buff = NULL;
-	u32 size, num_elements;
+	u32 num_elements;
+	size_t size;
 	void *p;
 
 	num_elements = *(u32 *)args;
 
-	ts_buff = kzalloc(sizeof(*ts_buff), GFP_KERNEL);
+	ts_buff = kzalloc(sizeof(*ts_buff), gfp);
 	if (!ts_buff)
 		return -ENOMEM;
 
-- 
2.25.1

