Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4B66E70E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjAQTdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjAQT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:26:29 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082047429
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:34:18 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 7FEC926F670;
        Tue, 17 Jan 2023 19:25:02 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 17 Jan 2023 19:25:00 +0100
Subject: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=j@jannau.net;
 h=from:subject:message-id; bh=qtyorAlxkkMT/6LLYB1Bf2sjPkpsduWNqrw5l5ng7OU=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuRjz//une7jdPHspxsXz4QpX9JqNW8ofLKt7PmpS3uFL4W2
 pp5J6ChlYRDjYJAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjCRp1MZ/kd5BHDxrL5lGKkQLbzupt
 leg5POL7XC/xQ81XglfsEjewojw7qzBjVf5V6eXtwT5vDAJuO4wuKne1/GtrmEbnK+e63+PgcA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a functional revert of c76b8308e4c9 ("nvme-apple: fix controller
shutdown in apple_nvme_disable").

The commit broke suspend/resume since apple_nvme_reset_work() tries to
disable the controller on resume. This does not work for the apple NVMe
controller since register access only works while the co-processor
firmware is running.

Disabling the NVMe controller in the shutdown path is also required
for shutting the co-processor down. The original code was appropriate
for this hardware. Add a comment to prevent a similar breaking changes
in the future.

Fixes: c76b8308e4c9 ("nvme-apple: fix controller shutdown in apple_nvme_disable")
Reported-by: Janne Grunau <j@jannau.net>
Link: https://lore.kernel.org/all/20230110174745.GA3576@jannau.net/
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/host/apple.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index bf1c60edb7f9..2a1f11b30615 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -829,7 +829,13 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 			apple_nvme_remove_cq(anv);
 		}
 
-		nvme_disable_ctrl(&anv->ctrl, shutdown);
+		/*
+		 * Always reset the NVMe controller on shutdown. The reset is
+		 * required to shutdown the co-processor cleanly.
+		 */
+		if (shutdown)
+			nvme_disable_ctrl(&anv->ctrl, shutdown);
+		nvme_disable_ctrl(&anv->ctrl, false);
 	}
 
 	WRITE_ONCE(anv->ioq.enabled, false);

-- 
2.38.2
