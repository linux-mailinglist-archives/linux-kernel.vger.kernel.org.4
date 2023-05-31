Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3A7180C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjEaM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbjEaM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:57:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE364E73;
        Wed, 31 May 2023 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sPtANn0zarNtlbKH0iiqTXeEp2bE0I2NjDJy6q2Trwk=; b=GXv8A+lfpPiEGozgarOo0bJBk0
        vZ0kuwyTdXvfMvaz1OJtVddz1RV1XvwdjmxKT/EbfVACzFfzaqUrUs7na2iqOQoJY/bXEM383UoPq
        V3bgYWsQp0f0kuxMeKtKAAPQGAVMnkw72oRSqPi4uiTWCNRU4YqkiAkf/zC7fSbQbnju3w9VHtTQ7
        14W2IwhgcSOj/itloOYpAtD8swcIVkwVfIsOowvzaYgyAZEY/qZBwHHTXgbKlWkEer5BFLFqMan3g
        cCbg8PczNxJS7yJuDOjQ0TO+/MEdmKOjHp9NdE3+kUHjKIISo4XKWkz1n0lfC0xMYC3OIbj7ryVsB
        E3s8ZvZA==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LNl-00HRdJ-2S;
        Wed, 31 May 2023 12:56:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 14/24] init: clear root_wait on all invalid root= strings
Date:   Wed, 31 May 2023 14:55:25 +0200
Message-Id: <20230531125535.676098-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531125535.676098-1-hch@lst.de>
References: <20230531125535.676098-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of only clearing root_wait in devt_from_partuuid when the UUID
format was invalid, do that in parse_root_device for all strings that
failed to parse.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index f1953aeb321978..0b36a5f39ee8e2 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -112,14 +112,14 @@ static int devt_from_partuuid(const char *uuid_str, dev_t *devt)
 
 		/* Explicitly fail on poor PARTUUID syntax. */
 		if (sscanf(slash + 1, "PARTNROFF=%d%c", &offset, &c) != 1)
-			goto clear_root_wait;
+			goto out_invalid;
 		cmp.len = slash - uuid_str;
 	} else {
 		cmp.len = strlen(uuid_str);
 	}
 
 	if (!cmp.len)
-		goto clear_root_wait;
+		goto out_invalid;
 
 	dev = class_find_device(&block_class, NULL, &cmp, &match_dev_by_uuid);
 	if (!dev)
@@ -139,12 +139,9 @@ static int devt_from_partuuid(const char *uuid_str, dev_t *devt)
 	put_device(dev);
 	return 0;
 
-clear_root_wait:
+out_invalid:
 	pr_err("VFS: PARTUUID= is invalid.\n"
 	       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
-	if (root_wait)
-		pr_err("Disabling rootwait; root= is invalid.\n");
-	root_wait = 0;
 	return -EINVAL;
 }
 
@@ -611,6 +608,7 @@ static void __init wait_for_root(char *root_device_name)
 
 static dev_t __init parse_root_device(char *root_device_name)
 {
+	int error;
 	dev_t dev;
 
 	if (!strncmp(root_device_name, "mtd", 3) ||
@@ -623,8 +621,14 @@ static dev_t __init parse_root_device(char *root_device_name)
 	if (strcmp(root_device_name, "/dev/ram") == 0)
 		return Root_RAM0;
 
-	if (early_lookup_bdev(root_device_name, &dev))
+	error = early_lookup_bdev(root_device_name, &dev);
+	if (error) {
+		if (error == -EINVAL && root_wait) {
+			pr_err("Disabling rootwait; root= is invalid.\n");
+			root_wait = 0;
+		}
 		return 0;
+	}
 	return dev;
 }
 
-- 
2.39.2

