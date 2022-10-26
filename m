Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189ED60E022
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiJZMBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiJZMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:01:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEF62900;
        Wed, 26 Oct 2022 05:01:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a5so27941011edb.11;
        Wed, 26 Oct 2022 05:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eCtqGBwRR52BjUb2Wh7FLafniFKggPInKgSqsTGAvt0=;
        b=leGA4qoyrfWu79SeDDY1Fpo34CYPzzjLv68Ja1abwz+SMwx1nPmuvDTz1TDqpIatxk
         3RpcqHN5wUmk14raenigd1/dCfWPgu02Mcro/BOa/EDedD2UJcYRcE+GxYpGyva10ZwX
         JODRghr9tCLi8eWJawFMZ7+PIS19+3gyxhbPzNi+qQX3XkZboKHABroQ0h7Qiwm55U3L
         H5gHn2nXTessOqFZxDrZ5TQYYscZBkEp15vI3ZXC3aNaS00JRD5aZrILQhUOY9WlR/0Z
         uSR0ZIra0x4coQA9R/cBeF1uiGWGH2QlKD1/ULE44TBzkuK6u6EmR98B7xbmkYgSmmOG
         J9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCtqGBwRR52BjUb2Wh7FLafniFKggPInKgSqsTGAvt0=;
        b=dqRp6DIv114GciQxcmjftXDvwzd5JXQt+0582PPeG2Ef+VgagT5WgxoPpjaW5HqayL
         U6iLrTkDXnJTGSHxswOGfxfqJMBPq2maUNM6QJUNGeYxoRrTWNPa+cWCT/E7+9NBdZby
         6RcRizrzYSAzL6k6unbihvQ9IZtkkXXQOM1f2LljJ5dVtD6wUuG1fvQqK/ztyUHz9l93
         +48Xzbop1YURKC9vfmlexcnWwSXmzSW/CfMDdy+NlahaeN6Qeg96VQ7qCzOk8kuuOaO5
         gjG07BmLK2uBBAxhowASdrpVS4eBw7X1Fri4qywGUmkxNkimajrXtl/2k1eIqhbk5YoN
         jRZg==
X-Gm-Message-State: ACrzQf0MZJs9bQ6fMUrXuifiVgse5mw7/xyY0LQ28ITmCjsfwGfBw6kQ
        3iT2ktSWYdtHNBlnZ3IA/Is=
X-Google-Smtp-Source: AMsMyM4S2WOpYB7baEE7G/A5nEFun1gaZ1VPWURaDzAg4GG41p/l6TvGEF3Y7ZSEwi5jJcOhKde5/w==
X-Received: by 2002:a05:6402:11ce:b0:45c:a364:2c3d with SMTP id j14-20020a05640211ce00b0045ca3642c3dmr41106701edw.204.1666785665669;
        Wed, 26 Oct 2022 05:01:05 -0700 (PDT)
Received: from felia.fritz.box (200116b826195000091b3ab8e8f9a156.dip.versatel-1u1.de. [2001:16b8:2619:5000:91b:3ab8:e8f9:a156])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b00788c622fa2csm2872760ejc.135.2022.10.26.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:01:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/1] lib: maple_tree: remove unneeded initialization in mtree_range_walk()
Date:   Wed, 26 Oct 2022 14:00:29 +0200
Message-Id: <20221026120029.12555-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
References: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the do-while loop in mtree_range_walk(), the variables next, min,
max need to be initialized. The variables last, prev_min and prev_max are
set within the loop body before they are eventually used after exiting the
loop body.

As it is a do-while loop, the loop body is executed at least once, so the
variables last, prev_min and prev_max do not need to be initialized before
the loop body.

Remove unneeded initialization of last and prev_min.

The needless initialization was reported by clang-analyzer as Dead Stores.

As the compiler already identifies these assignments as unneeded, it
optimizes the assignments away. Hence:

No functional change. No change in object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e1743803c851..fbde494444b8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2903,8 +2903,8 @@ static inline void *mtree_range_walk(struct ma_state *mas)
 	unsigned long max, min;
 	unsigned long prev_max, prev_min;
 
-	last = next = mas->node;
-	prev_min = min = mas->min;
+	next = mas->node;
+	min = mas->min;
 	max = mas->max;
 	do {
 		offset = 0;
-- 
2.17.1

