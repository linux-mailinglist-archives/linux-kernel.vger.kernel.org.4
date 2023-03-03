Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244A76A9094
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCCFvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCCFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:51:50 -0500
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513721A24;
        Thu,  2 Mar 2023 21:51:48 -0800 (PST)
Received: by mail-pj1-f65.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so1227251pjg.4;
        Thu, 02 Mar 2023 21:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677822708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0ZvyQY9ieS7Lbprj7ePFclxZH/ro+pYY7xE0pQIPTc=;
        b=gxboLqo0WfqoWF1xe+1yXxeEGY+fD6ETUBvZ/4WYjgUNPSqnCOryXJUQZZ8jxZgD0B
         OGwyCG5c4t0iSPzyHC0xuPfZFOGIiUwsTGCNhHBHx0RvaPpG/gfJnHNUXhKo/dkEPI1J
         XHKpH4n+FnAgWb8coWo7sMEOmRwkLB0+Bwl1bHWnMTwY1snYYVtXdePylH25Tk4iJR0v
         o969R4NKZzKbXCdqRbn1rlMpS5Z5omq1PF2V7SPCUV8+awdbcpfGVKAPQJ1mvkwTYFJQ
         mCrxh6iJe1Xj8FbzjTCCCjGa2MAMQOOyBcvheT7xchtzArJCdhJ5m70Jmbj/EZzSmhdq
         XaFg==
X-Gm-Message-State: AO0yUKVryNXtcii9TwfJ1/S+yzIxVgEmRX1/6MMNRhj6nndQobfACsyi
        yftzK+v5UTm2+r3mEY54BN6Lpv3k0U8k2UvZ
X-Google-Smtp-Source: AK7set+zrwV8ACAn0414wihsIWb1KnqPSmmRV+qrKtVt89QYk57z9YX1w8FWuiLK714Lb3RxzmAxZg==
X-Received: by 2002:a17:903:8cb:b0:19e:8e73:e977 with SMTP id lk11-20020a17090308cb00b0019e8e73e977mr876969plb.67.1677822708354;
        Thu, 02 Mar 2023 21:51:48 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id jz14-20020a170903430e00b0019896d29197sm623094plb.46.2023.03.02.21.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 21:51:47 -0800 (PST)
From:   Xueqin Luo <luoxueqin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin@kylinos.cn, xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2] PM/hibernation: set the default image size for large memory
Date:   Fri,  3 Mar 2023 13:51:33 +0800
Message-Id: <20230303055133.28752-1-luoxueqin@kylinos.cn>
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

As computers have more and more memory, they can store larger and
larger images. This poses a problem. Let's take a 16GB computer as
an example. When the number of pre-allocated pages is greater than
900,000 and smaller than image_size, the duration of S4 increases
with the number of saved pages. When the number of pre-allocated
pages reaches 1.2 million, the duration of S4 increases by 8-10s.

We found that the image size is generally more than 900,000 pages,
so we set the default size of image_size for 16GB and above
computers to 1 million pages, which can reduce the running time
of S4 under certain conditions.

This is the test data for 5 hours after the computer is turned on:

Original kernel begin:

[2023-02-24 19:16:56] [   46.105423][ 2] [ T3075] PM: hibernation entry
[2023-02-24 19:16:59] [   47.632000][ 1] [ T3075] done (allocated 
959239 pages)
[2023-02-24 19:18:05] [   56.987043][ 2] [ T3075] PM: hibernation exit

Five hours later:

[2023-02-25 00:22:48] [18069.651640][ 4] [ T7590] PM: hibernation entry
[2023-02-25 01:23:59] [21671.194049][ 0] [ T8563] done (allocated 
1228878 pages)
[2023-02-25 00:24:06] [18080.639889][ 2] [ T7590] PM: hibernation exit

After 5h, you can see that the S4 takes 8s more time.

Five hours later, the modified kernel test data:

[2023-02-24 15:52:08] [18190.171183][ 7] [T11151] PM: hibernation entry
[2023-02-24 15:52:11] [18191.677021][ 7] [T11151] done (allocated 
792597 pages)
[2023-02-24 15:53:15] [18201.028488][ 2] [T11151] PM: hibernation exit

You can see that after five hours, the time has changed little compared 
to the initial test data.

Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---

v3: modify some comments

v2: add test data

 kernel/power/snapshot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..fa3950b19849 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -136,7 +136,14 @@ unsigned long image_size;
 
 void __init hibernate_image_size_init(void)
 {
-	image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	/* The totalram pages() for a computer of 16 memory size is
+	 * equal to 4032990 pages. And according to our observation,
+	 * the average image size is less than 1 million pages.
+	 */
+	if (totalram_pages() < 4032990)
+		image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	else
+		image_size = 1000000 * PAGE_SIZE;
 }
 
 /*
-- 
2.25.1

