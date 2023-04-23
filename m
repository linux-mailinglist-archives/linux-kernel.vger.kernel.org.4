Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D86EBD15
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 06:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjDWEre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 00:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWErc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 00:47:32 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F03199A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 21:47:30 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b95c3b869dcso9934097276.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682225250; x=1684817250;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5D3feF4PSSkQcO2AaQ2Qdwn6n+8ejKfwGR371I/nVE8=;
        b=OsvSozEgu2GbNBizVFQdIkrStd8lwIkOI6yM11vnuZorInZvUG3O+O48DbL0qku65S
         WirI+g6wL1j+Fwjaq2xBqp5EbEQ7IZWpNAKU3urgZxxhXFposElUjSIEGNyd9JdN2AtE
         hRpEMOw27q5OjX8kf4YPwHI41urHDD0x2cxmxn9S1hhScpx4yYGVAYIRC50JWXmvxUnZ
         RVA3EW3Oq7Nn5L6lZ4gy/4Ygglq0T6PMYZieudrfY/OjAVNpD1s5bkWF8LVN3Olx1BeR
         8MjZQIj7cJ622HgnFNqTww1I35wNp3S9vGHw5wsptIF/uN8kjL4YztG/hCIMUopAccD9
         3xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682225250; x=1684817250;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D3feF4PSSkQcO2AaQ2Qdwn6n+8ejKfwGR371I/nVE8=;
        b=AU9QShC7Ru6TwyLDS0D+zS5ZEbAzhtl6nQryguxHfwd6+FRnmWK9pUr8inq7nH/5tL
         WH6K2LnZZHyj46h5WjTlkTKsEXn3rU829D8mYbS+BXh3jZEUORP1OvI6CO5t+ewiNhlg
         7U4EHz9oNq4UMl783jdoJ+bdiyQZnr1GUXgRSTIrdd6fmsQQjLNi0+8oqJI7Ooqn3uOp
         bEAND+yCWFPT5Sb66Sfqd5zvCxUsnds61h5RoeWgA8JU0Serjs79wpZlrDFHKWImLIeC
         45UHWC/D0tD9tpA1hP9SV/BO8wjWN1IKqtQRFTbufwW0IvLI69uO/CxAH/EErLOT5OSg
         xgBg==
X-Gm-Message-State: AAQBX9eAcOrysW/lVojD+njktd+T6aDkUo7QRxshcYDcn/exvCdwCw9m
        oc5MTlKqk6sMLCtaxFf+lqaL5w==
X-Google-Smtp-Source: AKy350bD+eVu16bIy5Bp7eNcb9NeaVxoOCKJu7qHcQIXSMztOqAWfAd0g2KxnRTKfQBinxo8RRCy5Q==
X-Received: by 2002:a81:8301:0:b0:552:c30d:2243 with SMTP id t1-20020a818301000000b00552c30d2243mr6717824ywf.11.1682225249939;
        Sat, 22 Apr 2023 21:47:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u185-20020a8184c2000000b0054640a352f2sm2056704ywf.20.2023.04.22.21.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 21:47:29 -0700 (PDT)
Date:   Sat, 22 Apr 2023 21:47:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next] mm/khugepaged: fix conflicting mods to
 collapse_file()
Message-ID: <b6c881-c352-bb91-85a8-febeb09dfd71@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inserting Ivan Orlov's syzbot fix commit 2ce0bdfebc74
("mm: khugepaged: fix kernel BUG in hpage_collapse_scan_file()")
ahead of Jiaqi Yan's and David Stevens's commits
12904d953364 ("mm/khugepaged: recover from poisoned file-backed memory")
cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
ac492b9c70ca ("mm/khugepaged: skip shmem with userfaultfd")
(all of which restructure collapse_file()) did not work out well.

xfstests generic/086 on huge tmpfs (with accelerated khugepaged) freezes
(if not on the first attempt, then the 2nd or 3rd) in find_lock_entries()
while doing drop_caches: the file's xarray seems to have been corrupted,
with find_get_entry() returning nonsense which makes no progress.

Bisection led to ac492b9c70ca; and diff against earlier working linux-next
suggested that it's probably down to an errant xas_store(), which does not
belong with the later changes (and nor does the positioning of warnings).
The later changes look as if they fix the syzbot issue independently.

Remove most of what's left of 2ce0bdfebc74: just leave one WARN_ON_ONCE
(xas_error) after the final xas_store() of the multi-index entry.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/khugepaged.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1941,16 +1941,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					result = SCAN_FAIL;
 					goto xa_locked;
 				}
-				xas_store(&xas, hpage);
-				if (xas_error(&xas)) {
-					/* revert shmem_charge performed
-					 * in the previous condition
-					 */
-					mapping->nrpages--;
-					shmem_uncharge(mapping->host, 1);
-					result = SCAN_STORE_FAILED;
-					goto xa_locked;
-				}
 				nr_none++;
 				continue;
 			}
@@ -2105,13 +2095,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * Accumulate the pages that are being collapsed.
 		 */
 		list_add_tail(&page->lru, &pagelist);
-
-		/*
-		 * We can't get an ENOMEM here (because the allocation happened
-		 * before) but let's check for errors (XArray implementation
-		 * can be changed in the future)
-		 */
-		WARN_ON_ONCE(xas_error(&xas));
 		continue;
 out_unlock:
 		unlock_page(page);
@@ -2134,11 +2117,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	/* Here we can't get an ENOMEM (because entries were
-	 * previously allocated) But let's check for errors
-	 * (XArray implementation can be changed in the future)
-	 */
-	WARN_ON_ONCE(xas_error(&xas));
 xa_locked:
 	xas_unlock_irq(&xas);
 xa_unlocked:
@@ -2259,6 +2237,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	/* Join all the small entries into a single multi-index entry. */
 	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	xas_store(&xas, hpage);
+	WARN_ON_ONCE(xas_error(&xas));
 	xas_unlock_irq(&xas);
 
 	/*
