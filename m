Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794E6A8F64
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 03:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCCCsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 21:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:48:02 -0500
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AE9EE4;
        Thu,  2 Mar 2023 18:48:01 -0800 (PST)
Received: by mail-pl1-f193.google.com with SMTP id p20so1279327plw.13;
        Thu, 02 Mar 2023 18:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677811681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnpynidftFFkBECkxZccWZ1LMjJJyuwajRKOI+QdZmM=;
        b=m9o9QQH6emoTTRucGBOqfqe8zfrIew/9xd4a1smyCj60h3DAxLxdwz651XMUSV4v/g
         y5pgOQyIKSjEdcjpjFN/QSUgNCtR8VKRbLUxnvStjbZp1RN+lcnTrDmJhV6PhzyV991d
         J5gzGGbEx/FN0HKY2wU6V8QtbKoaW5/GyolNiGCXJUr6pCIlz5ucMHIko8PeeB8XKLCd
         SO4kjRywhEp5YiXuxD/AwKm8NWZJ9trK1+YdlBu8PLs8N4C8nSWtbKnFslh6AM3jrSaK
         jxnnFwyTv9tcPXC8fz2o+bQ5NVDrE98k/oMFtoLnvSluYNatI77pwHlTD0dsMVXY5NBP
         EPwg==
X-Gm-Message-State: AO0yUKWhV8CuEjVVLQGtVQftsW0uX6G0LRfIhEed4Qwtv5ZSENhRWfyg
        vVmzelo+W3WZGd6/m/+v0ro=
X-Google-Smtp-Source: AK7set+RXjeuMXL2sZI9VnRn4tj3yitEu6r6oOY/Sciud9lPFKTvgomWZoSyRdTckPrnAhi3H2zpJA==
X-Received: by 2002:a17:90a:1a53:b0:234:b4a7:2abd with SMTP id 19-20020a17090a1a5300b00234b4a72abdmr35348pjl.12.1677811681022;
        Thu, 02 Mar 2023 18:48:01 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id cq18-20020a17090af99200b002348bfd3799sm2241767pjb.39.2023.03.02.18.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 18:48:00 -0800 (PST)
From:   Xueqin Luo <luoxueqin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin@kylinos.cn, xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2] PM/hibernation: set the default image size for large memory
Date:   Fri,  3 Mar 2023 10:47:55 +0800
Message-Id: <20230303024755.27491-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xueqin Luo <luoxueqin@kylinos.cn>

We found that the larger the memory, the larger the image saved by the
S4, so that the S4 took longer and longer. However, through observation,
we found that the image size is generally more than 900,000 pages, so
we changed the image_size of a computer with 16GB or more memory to 1
million pages. Let it release more unnecessary pages to reduce S4 run
time.

This is the test data for 5 hours after the computer is turned on:

Original kernel begin:

[2023-02-24 19:16:56] [   46.105423][ 2] [ T3075] PM: hibernation entry
[2023-02-24 19:18:05] [   56.987043][ 2] [ T3075] PM: hibernation exit

5 hours later:

[2023-02-25 00:22:48] [18069.651640][ 4] [ T7590] PM: hibernation entry
[2023-02-25 00:24:06] [18080.639889][ 2] [ T7590] PM: hibernation exit

After 5h, you can see that the S4 takes 8s more time.

The modified kernel begin:

[2023-02-24 10:47:04] [  166.309041][ 7] [ T6943] PM: hibernation entry
[2023-02-24 10:48:14] [  180.382188][ 3] [ T6943] PM: hibernation exit

5 hours later:

[2023-02-24 15:52:08] [18190.171183][ 7] [T11151] PM: hibernation entry
[2023-02-24 15:53:15] [18201.028488][ 2] [T11151] PM: hibernation exit

You can see that after 5 hours, the time doesn't change much.

Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/snapshot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..de91d6916359 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -136,7 +136,14 @@ unsigned long image_size;
 
 void __init hibernate_image_size_init(void)
 {
-	image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	/* The totalram pages() for a computer of 16 memory size is
+	 * equal to 4032990 pages. And according to our observation,
+	 * the average image size is 1000000 pages.
+	 */
+	if (totalram_pages() < 4032990)
+		image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	else
+		image_size = 1000000 * PAGE_SIZE;
 }
 
 /*
-- 
2.25.1

