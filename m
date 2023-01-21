Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEBF676504
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 08:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjAUHnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 02:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 02:43:21 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77F63E20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 23:43:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C8F9541EF0;
        Sat, 21 Jan 2023 07:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1674286997;
        bh=3/HH/e70fh1sArvce9tWJI5BZ4sJUWCbJ03o78bSh0Y=;
        h=From:To:Cc:Subject:Date;
        b=Jxe2YsZXl+FVkMrc9H7YYXVt9xACJevd6FMEVBHgpXEHqdlDTasGUSi+2Eu7/3qVC
         yf1ZRIGV6A4+eUI4qP6RTYSzQmFPvS9i2GAqbuudx94/lPTe8Imzus1ixC9jLsKQ+T
         VNN6EbtVcFvqVDr+2iAJtt762oicS6z0sntpYUOIxheSycn7+3E7rokapJze/GK6cr
         FCAIY+IOItdhNhflWB2399Ja02zOSRQhuezRydPEi8hozyV/pLb/nyE8E+7Mad6irq
         ovX/6LXEPqsTo1Zunc+++j4a4TFIzbIclo+lOXKvFZyWjM01YjminNP9tz9K6yCaGV
         iKobfTnt7979Q==
From:   Asahi Lina <lina@asahilina.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
Subject: [PATCH] soc: apple: rtkit: Add a private pointer to apple_rtkit_shmem
Date:   Sat, 21 Jan 2023 16:42:53 +0900
Message-Id: <20230121074253.9774-1-lina@asahilina.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows downstream consumers to keep track of private data for shmem
mappings. In particular, the Rust abstraction will use this to safely
drop data associated with a mapping when it is unmapped.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 include/linux/soc/apple/rtkit.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
index 62bfa37b5adb..1a9888a1797a 100644
--- a/include/linux/soc/apple/rtkit.h
+++ b/include/linux/soc/apple/rtkit.h
@@ -22,6 +22,7 @@
  * @size:      Size of the shared memory buffer.
  * @iova:      Device VA of shared memory buffer.
  * @is_mapped: Shared memory buffer is managed by the co-processor.
+ * @private:   Private data pointer for the parent driver.
  */
 
 struct apple_rtkit_shmem {
@@ -30,6 +31,7 @@ struct apple_rtkit_shmem {
 	size_t size;
 	dma_addr_t iova;
 	bool is_mapped;
+	void *private;
 };
 
 /*
-- 
2.35.1

