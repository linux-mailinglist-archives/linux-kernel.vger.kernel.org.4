Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655785BFB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiIUJi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIUJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:38:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34174915C8;
        Wed, 21 Sep 2022 02:38:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f193so5409573pgc.0;
        Wed, 21 Sep 2022 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KFVO8fVW480r7sdNg7zIhF6BeTKJDflqx7N33XmrmLw=;
        b=B0O+peQ9GPse538cFMImXkVVEgzI2N7S9OOXM4GtJtRUoLvGHJiILpx7V0yLqj5aGo
         TLH9++W5VKpgGvOPslIbS1a1TwqhF9K1w5wtZqnj2hpqCgxCaJ3Q2o9sstIfci3wP94f
         gUWrK44ALw4vwC5HpHi3ehM2WQsv4RaxGM9pRQ5TrLq1Pq+y8v9FgMJZvRb6fP0e63mA
         Dkr83m0zm8lGC/ES04KGH0K7UpG3T5a419tJnBrE5a+Q05psm8eCGXBGrOJp6H6GS3zC
         DeGD99OQeMjQLHPp+hmp2MsBBkEyvC+rfSzgei9sHp+9kwqBLffiL0TPhH/Ql7nthi7n
         m5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KFVO8fVW480r7sdNg7zIhF6BeTKJDflqx7N33XmrmLw=;
        b=vMsdpLh7XcRIqnfdth/cLU5v4Pan4prm9hrOTAtmXirtc0HN/9MXHl8c3iXQKN/RA7
         vWhUh9lcGPWZb9EeCS+NZKo3pEq3i0dMpZqefr7hxFVA0eZsDceS0DdFpZKiTInvIneY
         n111ZOp0d5O23dM2OXcQcZYFXE5aScUf8Z8J9Yr5b5gKV0SsS+MbYPoJuj70MiEFD7jG
         GV7na9rEbHFBLB02tFgwZQbodLp8gMWuYIgT9J6a1RpvSPyWhNoZE57PH2dhzcUsgQl/
         EnpT85Lix4hjNvJ2dCB3j6MfskAM6RRbabZJzPTlxG2LCmfN8GAEeZMCnRJ86aAqaVu6
         o+Fg==
X-Gm-Message-State: ACrzQf1b327t+LOkvEVe/TlZvZ4TPqmFhqUBJDtEJvmyKAroQS5MTGlu
        vQGeXO0c5G6fG244SI2ZWXE=
X-Google-Smtp-Source: AMsMyM41zgqidZsHKEdDqXihhnAlvXs3uPB1yM86uJY+Yx5+rcaq6pf9HawGCWNswtCxNp2KBfKnJA==
X-Received: by 2002:a63:7843:0:b0:42b:4e77:a508 with SMTP id t64-20020a637843000000b0042b4e77a508mr23518088pgc.449.1663753134634;
        Wed, 21 Sep 2022 02:38:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b00176ea6ce0efsm1522926plr.109.2022.09.21.02.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:38:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        james.clark@arm.com, alexandre.truong@arm.com,
        blakejones@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf machine: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:38:48 +0000
Message-Id: <20220921093848.230966-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/util/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2a16cae28407..5d0f817cef63 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1198,7 +1198,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	kmap = map__kmap(map);
 
-	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
+	strscpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
 	maps__insert(machine__kernel_maps(machine), map);
 
@@ -1287,7 +1287,7 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 			.pgoff = pgoff,
 		};
 
-		strlcpy(xm.name, ENTRY_TRAMPOLINE_NAME, KMAP_NAME_LEN);
+		strscpy(xm.name, ENTRY_TRAMPOLINE_NAME, KMAP_NAME_LEN);
 
 		if (machine__create_extra_kernel_map(machine, kernel, &xm) < 0)
 			return -1;
@@ -1892,7 +1892,7 @@ int machine__process_mmap2_event(struct machine *machine,
 			.pgoff = event->mmap2.pgoff,
 		};
 
-		strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
+		strscpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
 		ret = machine__process_kernel_mmap_event(machine, &xm, bid);
 		if (ret < 0)
 			goto out_problem;
@@ -1949,7 +1949,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 			.pgoff = event->mmap.pgoff,
 		};
 
-		strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
+		strscpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
 		ret = machine__process_kernel_mmap_event(machine, &xm, NULL);
 		if (ret < 0)
 			goto out_problem;
-- 
2.25.1
