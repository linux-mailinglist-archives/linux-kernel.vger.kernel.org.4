Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B001D66E70C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjAQTeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjAQT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:26:29 -0500
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 10:34:19 PST
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99F2113E2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:34:18 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id F0B5B26F671;
        Tue, 17 Jan 2023 19:25:02 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 17 Jan 2023 19:25:01 +0100
Subject: [PATCH v2 2/2] nvme-apple: Only reset the controller when RTKit is running
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230114-apple-nvme-suspend-fixes-v6.2-v2-2-9157bf633dba@jannau.net>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net>
In-Reply-To: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=j@jannau.net;
 h=from:subject:message-id; bh=u2Uiv1bFso8EeQe26njgU/kTCYTgJ/N9RudVytjdmsU=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuRjz//K7P3Rc/S+5fOiFZ0c4hcrs/1V1n16zHbtrIGKb0w1
 r/zJjlIWBjEOBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABMpcmBkeMTZ9OH5v9lqSRceHORvM4
 4Q9zFbz9UsNGFlye/3Jg998hj++7Hea4k33LTUPu655PbvoTG930vEfwQnzVLgzrJcpPmXCQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe controller register access hangs indefinitely when the co-processor
is not running. A missed reset is preferable over a hanging thread since
it could be recoverable.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/host/apple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 2a1f11b30615..3258fd7efaf9 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -991,11 +991,11 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (anv->ctrl.ctrl_config & NVME_CC_ENABLE)
-		apple_nvme_disable(anv, false);
-
 	/* RTKit must be shut down cleanly for the (soft)-reset to work */
 	if (apple_rtkit_is_running(anv->rtk)) {
+		/* reset the controller if it is enabled */
+		if (anv->ctrl.ctrl_config & NVME_CC_ENABLE)
+			apple_nvme_disable(anv, false);
 		dev_dbg(anv->dev, "Trying to shut down RTKit before reset.");
 		ret = apple_rtkit_shutdown(anv->rtk);
 		if (ret)

-- 
2.38.2
