Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FBD6A9A53
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCCPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCCPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:13:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31E5FEA0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677856343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F7FkEvK0Cc1dzOzn0YRJDUmEaZBxKLaS3v89bxlha2c=;
        b=hdpaDeL5kgQlXUUJPMPWJQz7mtpA4gLjwOmzXnF1S8oIoXxTxHfoz5LNT2PkeGWWC7ZbkF
        ThnWq8FldxjLZScNcUpRxbECe5/N8TQzh/5lR+XOflvSAhXRuziobLkrD8ia15Zv5kB54G
        v5sO7N1avd50jSZmAu+MemRKl9N+OE4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-Lh8hMD5fPzGTPW26sBMoPg-1; Fri, 03 Mar 2023 10:12:21 -0500
X-MC-Unique: Lh8hMD5fPzGTPW26sBMoPg-1
Received: by mail-qk1-f198.google.com with SMTP id x5-20020a05620a01e500b007428997e800so1535128qkn.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7FkEvK0Cc1dzOzn0YRJDUmEaZBxKLaS3v89bxlha2c=;
        b=uBRQbK7XJJvjTqgaQvmtcbw+eQYpiSpP4BwbiROQYUvmI6fxwS/0Dx1kRrd08AErtR
         fNVQKG+sCrXEGfifwdthaQBzhAYCdZx/0gpVoW9SL+sy2+x9ZIMSSogsAjPM/6v8MD0q
         Cm4fGqMwtkoNabfRrplehEboskkChYseoxHh0vyZ9QtFhlmI8V54E8xo2+pIejUtu3VG
         Fc5wTS3RGA3R8wRj6N16tLyNDR+OHiNcgNikz4C5AAiW4CwUGCdSzu/hHMaNNDhtrv7f
         F2b4qh58zYeRRT6Ulh3A5TtacVPDLggZiHdByXSGxiOV5HacOk7N77IPPbYkhhbYuacD
         kQBg==
X-Gm-Message-State: AO0yUKXMO+L9QHplOhLtl+Lk7Vp5hHcIjrBFcsA5UH4eVj1COWS0FRyM
        ayQhDlgnbZBWpnyOe4WH9vtEucbAptMoRhvAcp4a4Z17BZlIHI3Lwreawt/wTkd5mAw4nB5scMe
        XM6DRFyGUDkYhC0Guk+inS1im
X-Received: by 2002:a0c:cd0c:0:b0:57d:747b:1f7 with SMTP id b12-20020a0ccd0c000000b0057d747b01f7mr2618899qvm.1.1677856340555;
        Fri, 03 Mar 2023 07:12:20 -0800 (PST)
X-Google-Smtp-Source: AK7set/5iR+fOMQqaavx8iLd6HqfCnXGvTdB8MZxV2fvLYSnkvkmhcx2GhWHSJ4arBfU1SMRD+yTkw==
X-Received: by 2002:a0c:cd0c:0:b0:57d:747b:1f7 with SMTP id b12-20020a0ccd0c000000b0057d747b01f7mr2618870qvm.1.1677856340293;
        Fri, 03 Mar 2023 07:12:20 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id c133-20020ae9ed8b000000b0074280fc7bd8sm1891317qkg.60.2023.03.03.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:12:19 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Stevens <stevensd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, peterx@redhat.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zach O'Keefe <zokeefe@google.com>
Subject: [PATCH] mm/khugepaged: Cleanup memcg uncharge for failure path
Date:   Fri,  3 Mar 2023 10:12:18 -0500
Message-Id: <20230303151218.311015-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit memcg uncharging is not needed when the memcg accounting has the
same lifespan of the page/folio.  That becomes the case for khugepaged
after Yang & Zach's recent rework so the hpage will be allocated for each
collapse rather than being cached.

Cleanup the explicit memcg uncharge in khugepaged failure path and leave
that for put_page().

Suggested-by: Zach O'Keefe <zokeefe@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/khugepaged.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 941d1c7ea910..dd5a7d9bc593 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1230,10 +1230,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 out_up_write:
 	mmap_write_unlock(mm);
 out_nolock:
-	if (hpage) {
-		mem_cgroup_uncharge(page_folio(hpage));
+	if (hpage)
 		put_page(hpage);
-	}
 	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
 	return result;
 }
@@ -2250,10 +2248,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		unlock_page(hpage);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	if (hpage) {
-		mem_cgroup_uncharge(page_folio(hpage));
+	if (hpage)
 		put_page(hpage);
-	}
 
 	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
 	return result;
-- 
2.39.1

