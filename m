Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5016B5EA9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiIZPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiIZPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03007EC553
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B2160DC4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378C0C433C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664199977;
        bh=1Wj9e8M73jZ6TMWEthyXpbz5ogXvoI6l/KBtTwQjVYU=;
        h=From:To:Subject:Date:From;
        b=ft++TT7UExAZQB2nNoHuIPW6RYuu2ScYeny+Pionp787uM6qQ0WAs06CT0EF3JSYw
         UnKIufH5Yj9E7tJCMIuiwZVQ8+rH/b4xB/VtuOHRIux7kUWz4kR7KuLHe8U9BifOyJ
         xO4IDbusJHsI1Zkjz6dx58GYHIk9KNC5UQY+jCzYPWQxhzrVmOS5+LknvVtifPdEgi
         lGDsyvs1CvGTlPPEC5NlbUS5x5FThQokOWKe5MNQDccgj4gqYcabMJfg5zhFlMH3F/
         x+405LGdr49dyeBaj6KJEoQ3K5GPwnNNrwcDQD5CAB4Lmvmaj/FL/PFbz6JlJF/zFy
         NccIe189x8UtQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs: Use simplified API for p2p dist calc
Date:   Mon, 26 Sep 2022 16:46:13 +0300
Message-Id: <20220926134614.592875-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the simplified API that calculates distance between two devices.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index ef28f3b37b93..99b1d6ce26ae 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1689,7 +1689,7 @@ static int hl_dmabuf_attach(struct dma_buf *dmabuf,
 	hl_dmabuf = dmabuf->priv;
 	hdev = hl_dmabuf->ctx->hdev;
 
-	rc = pci_p2pdma_distance_many(hdev->pdev, &attachment->dev, 1, true);
+	rc = pci_p2pdma_distance(hdev->pdev, attachment->dev, true);
 
 	if (rc < 0)
 		attachment->peer2peer = false;
-- 
2.25.1

