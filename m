Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECA64CC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiLNOaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbiLNOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:30:47 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533F2252A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:30:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CAFB44203C;
        Wed, 14 Dec 2022 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1671028241; bh=l+loTAS240QxDlt5drk5S5kcxptCa1dPnxhdg+DTW3U=;
        h=From:To:Cc:Subject:Date;
        b=IJBCeFCQH+TjndfqhW2YKGwN35jxyrebppxh1BAD9aW1t6mE8Rlk+WsJsPvbVKc9W
         WE0gZdAqDHMTYTcbzTuM9MPy3ZnAggFrY0Rx9RVFnYwyM++hyM2fx4dYFk9WYBiTUL
         oIynwVHHTREcP2MX0cFkmNgYMvEk4sodUvLvrDzDZlCsGtYamqRD4usFnCgEWwK0O4
         Vzwpg1uD9V9DWG7hkGcug+H64jkIbWiAcBt7FTiwXAPXOVa4LrAQ64L5noO5Lxt/h7
         xvxOcr536nEQmKA85VB1Jwc8qb7MZFsuGpqqeoMrwxv6lkA3xzk2FS8NmCOdTMJ31T
         4OifBSZLzDcSA==
From:   Hector Martin <marcan@marcan.st>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] nvmem: core: Fix race in nvmem_register()
Date:   Wed, 14 Dec 2022 23:29:53 +0900
Message-Id: <20221214142952.9372-1-marcan@marcan.st>
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

nvmem_register() currently registers the device before adding the nvmem
cells, which creates a race window where consumers may find the nvmem
device (and not get PROBE_DEFERred), but then fail to find the cells and
error out.

Move device registration to the end of nvmem_register(), to close the
race.

Observed when the stars line up on Apple Silicon machines with the (not
yet upstream, but trivial) spmi nvmem driver and the macsmc-rtc client:

[    0.487375] macsmc-rtc macsmc-rtc: error -ENOENT: Failed to get rtc_offset NVMEM cell

Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvmem/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..d255feca5e17 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -837,20 +837,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)

 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);

-	rval = device_register(&nvmem->dev);
-	if (rval)
-		goto err_put_device;
-
 	if (nvmem->nkeepout) {
 		rval = nvmem_validate_keepouts(nvmem);
 		if (rval)
-			goto err_device_del;
+			return ERR_PTR(rval);
 	}

 	if (config->compat) {
 		rval = nvmem_sysfs_setup_compat(nvmem, config);
 		if (rval)
-			goto err_device_del;
+			return ERR_PTR(rval);
 	}

 	if (config->cells) {
@@ -867,19 +863,21 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;

+	rval = device_register(&nvmem->dev);
+	if (rval)
+		goto err_put_device;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);

 	return nvmem;

+err_put_device:
+	put_device(&nvmem->dev);
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
 err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
-err_device_del:
-	device_del(&nvmem->dev);
-err_put_device:
-	put_device(&nvmem->dev);

 	return ERR_PTR(rval);
 }
--
2.35.1

