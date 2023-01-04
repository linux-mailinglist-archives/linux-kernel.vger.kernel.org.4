Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05E65CF78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjADJXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjADJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:23:01 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797BC4C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:22:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 17FB73FB17;
        Wed,  4 Jan 2023 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672824177; bh=a/im3KZyFNA2CosMlHGYViz9KJgGel1xGdkiZFIsEhA=;
        h=From:To:Cc:Subject:Date;
        b=q3ykqFnW9CcCW+jYax8JWGulJzj5jwpSKtNbVmhM2gB/sINfo4SHaVatgZ5+WJbB7
         nkMZmKC9DdF7GD1FOIA4HoizeIe1+HB+A+uJRSKXgk0JnM0CXFnIrqEMLg6feUAO83
         6Z87SFZhOXjhRyD9JJTMgmYZL2tU13mtlb86oCH8pQfoJukFPa/MT4PIf4LDfdV/5D
         yfJ5nanF9GH0FR8j5vHD75UF8ri3lWu9gTLr8zym2dh6pElE8f4gBvOAD9KsyQ1rA2
         u3dhKx7Ot9W9Hx9gmi80r83tiryUB+ocHHPohO9lEiziNL9bAOoDYYBTsJPIGnYRnY
         7/Mpx3E1xgw9g==
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] nvme-apple: Add NVME_QUIRK_IDENTIFY_CNS quirk to fix regression
Date:   Wed,  4 Jan 2023 18:21:49 +0900
Message-Id: <20230104092148.15578-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
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

From the get-go, this driver and the ANS syslog have been complaining
about namespace identification. In 6.2-rc1, commit 811f4de0344d ("nvme:
avoid fallback to sequential scan due to transient issues") regressed
the driver by no longer allowing fallback to sequential namespace scans,
leaving us with no namespaces.

It turns out that the real problem is that this controller claiming
NVMe 1.1 compat is treating the CNS field as a binary field, as in NVMe
1.0. This already has a quirk, NVME_QUIRK_IDENTIFY_CNS, so set it for
the controller to fix all this nonsense (including other errors
triggered by other CNS commands).

Fixes: 811f4de0344d ("nvme: avoid fallback to sequential scan due to transient issues")
Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index e17d3a8a0107..e13a992b6096 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1553,7 +1553,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	}

 	ret = nvme_init_ctrl(&anv->ctrl, anv->dev, &nvme_ctrl_ops,
-			     NVME_QUIRK_SKIP_CID_GEN);
+			     NVME_QUIRK_SKIP_CID_GEN | NVME_QUIRK_IDENTIFY_CNS);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to initialize nvme_ctrl");
 		goto put_dev;
--
2.35.1

