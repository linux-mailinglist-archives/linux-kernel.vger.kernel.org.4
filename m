Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFEB6EEA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjDYWZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjDYWY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:24:58 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636DB5FF1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:57 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76355514e03so549679739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682461496; x=1685053496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72+eO6KwavTo94Q3dwD5X6q19DNV6pOCYjiHiYVA/Vw=;
        b=Grk8BdnodSaCw+q2KEGxiYiB/BWivAhKBG3jYwZhxGLowfMkRBXpthNBz0x+pd+T3P
         6CAtDSNrOHaEJsadCy0ZB8775sPskCbqboCd8pgull+tCAZAhHrSBr2yYvnChZ429l1W
         aNLhgWELCQPxiDcM9nKlOy4UJVJqEDTGoYpug3z4DVq5egXl9vztA77qAbCwgUwqoInQ
         7ZYsWmtZ80pXz/WM7d2RuwccAsEaNdfmcMISDUD4XhhkFwyBq8TeJFRqYqN9kxZlR3KB
         5bD+ekaggIS6DwCjFeDGRUXZP6rxMkCM3/nmhEJGxgEO4NP6+N5SRHHBKImsVGhgq95e
         SMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682461496; x=1685053496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72+eO6KwavTo94Q3dwD5X6q19DNV6pOCYjiHiYVA/Vw=;
        b=CSMmm/OxKtL+S1gAsG/rjyfCZkx9GIot2TBNsp9o/sQ9idi8CIfF1RxEsWh/9ZzvMx
         aINQMGuhqWobjWUWZRuCi29zjrUmJEGr0kWeLwnPRYxqgfVfcVqR+h469qaWV98sLkOV
         B3LsP3NxPVl0qBHZoJRYZm4eicriNDfA911B6nAuGi6lWxAt2XCqPRggKwmixTPdGyhN
         Y1KNcj+MSeOIt7HTOY8XhWfL4CQIUuP5kA9cx6261lOK8w6U90vkFkQJbheSyqeubSsV
         I4oDiID8AHWaaR+2SvPXmf3wr3QqatoaB/Ld6w7CGTQue6l1SLa1AyVJD08oEunpRBhc
         xsLw==
X-Gm-Message-State: AAQBX9codZ9ky4Cj7tIhET23yAxelcQKcbiX2SBMm4iudc6pLHc+AZED
        mySTVIGGYDsofW6FSyTf20MGCtvkRRE=
X-Google-Smtp-Source: AKy350bcOPFaqZU/Q8Y4YjEKceAGvIRSYtdv5UXWCB8wrA6JhTBamchaYYBw4d9VwQnkTuRpNfmbdA==
X-Received: by 2002:a92:c809:0:b0:328:bfbd:1e87 with SMTP id v9-20020a92c809000000b00328bfbd1e87mr8356225iln.27.1682461496560;
        Tue, 25 Apr 2023 15:24:56 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 13-20020a92180d000000b003244d7f2292sm3833008ily.32.2023.04.25.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 15:24:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     catalin.marinas@arm.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/3] kmemleak: drop (age <increasing>) from leak record
Date:   Tue, 25 Apr 2023 16:24:44 -0600
Message-Id: <20230425222446.170486-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425222446.170486-1-jim.cromie@gmail.com>
References: <20230425222446.170486-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displaying age is pretty, but counter-productive; it surrenders
idempotency of the output, which breaks simple hash-based cataloging
of the records by the user.

The trouble: sequential reads, wo new leaks, get new results:

  :#> sum /sys/kernel/debug/kmemleak
  53439    74 /sys/kernel/debug/kmemleak
  :#> sum /sys/kernel/debug/kmemleak
  59066    74 /sys/kernel/debug/kmemleak

and age is why (nothing else changes):

  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67
  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67

Further, age is not an intrinsic property of the leak, its an artifact
of when it was scanned, and relative age is embedded in leak order.

While userspace could work around the always-changing output, ISTM
none could be relying upon age in any important way, and having
idempotent output is just better.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 mm/kmemleak.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a2d34226e3c8..f025c7bc845b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -355,14 +355,12 @@ static void print_unreferenced(struct seq_file *seq,
 	int i;
 	unsigned long *entries;
 	unsigned int nr_entries;
-	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
 	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
 			  object->pointer, object->size);
-	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
-			   object->comm, object->pid, object->jiffies,
-			   msecs_age / 1000, msecs_age % 1000);
+	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
+			   object->comm, object->pid, object->jiffies);
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
-- 
2.40.0

