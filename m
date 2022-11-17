Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60EC62DB07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiKQMgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiKQMg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:36:28 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025DEBF7A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:36:28 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668688586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z4MrYjbKsvS7dc79yNLvhFfNXfIiOrVHTG1RytCGWi8=;
        b=MeiXQZPs4gKo+k8/Zk6OM1T7WFblVklgTWM8O3lMNnYHzT+s9xXZLpThAe2U87J05vIuXa
        1VzXaI5q6S0EZRITeCkrJmzBFAnE+TkKPcPA1R6eJ98wN1sqT+09VCmJdSTMRuD90jN+sT
        bejmmRgCaulNBGeHc75fzEA+hRjKWPE=
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] mtd: lpddr: Added literal suffix
Date:   Thu, 17 Nov 2022 15:36:25 +0300
Message-Id: <20221117123625.117161-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of an arithmetic expression
1 << lpddr->qinfo->DevSizeShift is subject to overflow
due to a failure to cast operands to a larger data
type before perfoming arithmetic

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/mtd/lpddr/lpddr_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index ee063baed136..360b2af8340b 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -61,7 +61,7 @@ struct mtd_info *lpddr_cmdset(struct map_info *map)
 		mtd->_point = lpddr_point;
 		mtd->_unpoint = lpddr_unpoint;
 	}
-	mtd->size = 1 << lpddr->qinfo->DevSizeShift;
+	mtd->size = 1UL << lpddr->qinfo->DevSizeShift;
 	mtd->erasesize = 1 << lpddr->qinfo->UniformBlockSizeShift;
 	mtd->writesize = 1 << lpddr->qinfo->BufSizeShift;
 
-- 
2.25.1

