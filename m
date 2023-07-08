Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46274BEDF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjGHTMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGHTMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:12:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D089FC
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:12:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c4e0342c50dso3483463276.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688843536; x=1691435536;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxWcwQCt64OXVUnpGWZTSfPA4gPHWHeYyOn+4bzO86s=;
        b=e+tppejdoz5kN8B3C5WlD+0nrZGu/5EqfAONbG0hP/lWZ7G+LSD9YpK/YdiONHY+ET
         COyN68AHpyc5cvZcCJI9Kdj/VXVTOhzXyqaYxVOU/XE8oiqZCtvDT9Ohjc4lwpKs8uIs
         Q4SGdk/Hg/xVzMRwTNMA5Eb7fUdiGxUNFD+tTkYwspdAJA3H1WkY5sp8/o9lg62jTXI9
         vPMevfc26zzweXBMLZnrlY/VDaPVf886Cj6pjLGQXsKtCnCzJ7R7L8Gjg1qP169pUZdf
         1fQiHyVHhW2J/bG8DUWZndT612qIhsJaOJnKsT3WA5FG5hybdpqBg5J7YK8LJ6GcI8+m
         tGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688843536; x=1691435536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxWcwQCt64OXVUnpGWZTSfPA4gPHWHeYyOn+4bzO86s=;
        b=c1UV+/yxENQS/MLBsyc/qRuvICorbMJxjb9qPcXRqlIMBPPpCW239vGSzO3sc5deKb
         EV3pxBOCpEwowQIPyz2ivSKo6kTT8dbHGnthS5UO0K3IsLmcXA8Ci7/CuK3a+gmM0Tlp
         5LiK9ylhguwextOSKxR4pXZ3zv6cClaTG3lTod7nkzDepGer6UDQV7qHV+BHS3c0L6Wp
         aQ9NHMurVP/Oo9g/GrFlZFu37oC4Ig77O6+xy5URcOGfiNNclpvz2gKru+Dp/uTftepX
         Qk1Eu6pX7UUPHAUjzrRrA6xEiz0JuuG6i/KIkkaQ6tJDPn7hTtEGfX5IunodAhVVlhMT
         fUGw==
X-Gm-Message-State: ABy/qLZ3mQZ/u8mX8Ss0WWvEsgTeW2ipdO8WaR5vRJgXJFOtCy0TCy7q
        edn7W/VEzDvlmuwcrGFM4T8xwDRZBM4=
X-Google-Smtp-Source: APBJJlHhdNayqx2O2N+8ynu4MlCffNN+ZnIRARK/gUWveaZn8/1xJL36UJUekD5xd/lYzHt6QBE2wx7GXfo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6f0:5193:79db:25b3])
 (user=surenb job=sendgmr) by 2002:a5b:10e:0:b0:c39:d6f6:481f with SMTP id
 14-20020a5b010e000000b00c39d6f6481fmr73329ybx.10.1688843535891; Sat, 08 Jul
 2023 12:12:15 -0700 (PDT)
Date:   Sat,  8 Jul 2023 12:12:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230708191212.4147700-1-surenb@google.com>
Subject: [PATCH v2 1/3] mm: lock a vma before stack expansion
From:   Suren Baghdasaryan <surenb@google.com>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev,
        Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recent changes necessitating mmap_lock to be held for write while
expanding a stack, per-VMA locks should follow the same rules and be
write-locked to prevent page faults into the VMA being expanded. Add
the necessary locking.

Cc: stable@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 204ddcd52625..c66e4622a557 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1977,6 +1977,8 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		return -ENOMEM;
 	}
 
+	/* Lock the VMA before expanding to prevent concurrent page faults */
+	vma_start_write(vma);
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
 	 * is required to hold the mmap_lock in read mode.  We need the
@@ -2064,6 +2066,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		return -ENOMEM;
 	}
 
+	/* Lock the VMA before expanding to prevent concurrent page faults */
+	vma_start_write(vma);
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
 	 * is required to hold the mmap_lock in read mode.  We need the
-- 
2.41.0.390.g38632f3daf-goog

