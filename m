Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507806A7B28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCBGCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCBGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:02:40 -0500
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A3A4E5D7;
        Wed,  1 Mar 2023 22:02:02 -0800 (PST)
Received: by mail-pj1-f65.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso1728091pjr.5;
        Wed, 01 Mar 2023 22:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677736845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5BLwdsqWMRN1wSNrlTvWmfWTgDeULT8guf1qcXNMsg=;
        b=Ok2Mt8WQQQU2YkCj6RmmQh2xWe2LfMW9T5N12jhJuhJDZWz8sYiM8Smo+IgvN8ZC85
         gjMhYJD/pK1rEhWpgRZMR1ge3aZodwSoP6sedHJ+gGO7mcVWi0QvRlrhkXkc0ILSWSru
         ymzCuDjVnJ6H/Li5WpXUy1MR4swNaqVgyf2KRR7CeqyhzFoyXZb7+4wMzDu2FXPMX7LK
         TdOq5VWEySRHmGdsP2E6i7qe/8d8Pttv8vuyYytK/3rYEuwNICGBAH8SyaTRLB2f31P5
         +2VDWLqOP9LYoAcIll9lt2yxxgFZ/VKOwPUWtUaDM9B6IpBjln1HCu8ucZeJEbvnsQNT
         UsRw==
X-Gm-Message-State: AO0yUKWcbQFl7/whbLKAyU2bgRvOkJ3ZuqIxCClgENmK0mH1QRjL7pnb
        Eaoak4/58189i2P9U0RBuKY=
X-Google-Smtp-Source: AK7set9PDUqkLyYeVnh9ARO3hoVUbldEgTdTHpzuL261aQXyO8rkxEDyTnZSyXTNGTMuwleG3jSj8Q==
X-Received: by 2002:a05:6a20:918c:b0:bf:65dd:94fd with SMTP id v12-20020a056a20918c00b000bf65dd94fdmr8485155pzd.59.1677736845004;
        Wed, 01 Mar 2023 22:00:45 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7810b000000b005d72e54a7e1sm8787023pfi.215.2023.03.01.22.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 22:00:44 -0800 (PST)
From:   Xueqin Luo <luoxueqin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin@kylinos.cn, xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] PM/hibernation: set the default image size for large memory
Date:   Thu,  2 Mar 2023 14:00:33 +0800
Message-Id: <20230302060033.15661-1-luoxueqin@kylinos.cn>
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

