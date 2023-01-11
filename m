Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC26652E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 05:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjAKEit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 23:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjAKEi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 23:38:29 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F78643B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 20:38:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A9EC6422CC;
        Wed, 11 Jan 2023 04:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673411907; bh=Q3CUKLEywf+vR4+nGROpaJQqVS2PQmhEl5Il4+LejRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QY5tqf60SZHxFaNdFYSzNvp4IdFLjD4OU8BawnpwU74nj7igN5fSFDF1+fcojF39A
         sOVlpJT9RhW6yM4BHm02nodGm1dFnVtmoqCnFikp1F9d/8cT3SuUqKczh83l09wMoo
         Zz+ydkC/lTC43zhbi3SjksPhqde146WnH3Ge1L59zI7Cg8TeHT4GQTiqLfm70xYxh7
         LVdvZPRhSF4FctliGqXRgKXSjYPgtSRKMkB+ouZ2NiQ/4azKsNZx88fxEu31eKkYae
         js5/uMv+MwTL1AyrKdtdx76z3wHbPDiWP65rW7ZcORH+fhFmpmvHqNkiBHju5CgmAS
         FS6P8dLLiUcuA==
From:   Hector Martin <marcan@marcan.st>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 1/2] nvme-apple: Do not try to shut down the controller twice
Date:   Wed, 11 Jan 2023 13:36:13 +0900
Message-Id: <20230111043614.27087-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111043614.27087-1-marcan@marcan.st>
References: <20230111043614.27087-1-marcan@marcan.st>
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

The blamed commit stopped explicitly disabling the controller when we do
a controlled shutdown, but apple_nvme_reset_work was only checking for
the disable bit before deciding to issue another disable. Check for the
shutdown state too, to avoid breakage.

This issue does not affect nvme-pci, since it only issues controller
shutdowns when the system is actually shutting down anyway.

Fixes: c76b8308e4c9 ("nvme-apple: fix controller shutdown in apple_nvme_disable")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index e13a992b6096..1961376447dc 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1023,7 +1023,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (anv->ctrl.ctrl_config & NVME_CC_ENABLE)
+	if (anv->ctrl.ctrl_config & NVME_CC_ENABLE &&
+	    !(anv->ctrl.ctrl_config & NVME_CC_SHN_MASK))
 		apple_nvme_disable(anv, false);
 
 	/* RTKit must be shut down cleanly for the (soft)-reset to work */
-- 
2.35.1

