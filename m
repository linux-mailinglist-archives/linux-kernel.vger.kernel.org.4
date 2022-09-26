Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7524E5EAC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIZQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIZQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:31:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C122814FC;
        Mon, 26 Sep 2022 08:20:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id rt12so6629515pjb.1;
        Mon, 26 Sep 2022 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8u1pzMh4CC2fFXVfb1fmA18CvbUEdQSOPnIjgSzvs5o=;
        b=h7ABseHFWvCS7qZvb0/dMRPK6s2Z/2zSuwvUmuXYyyUUscVwH7QcxPtumMTcKG+Fbz
         12y+tjvrFoiRSnI0rCkho17VVGH0mZJDbjUZH+x4pnPXrxwMNeWdN97jfWYPuFJ23zdM
         x+sJpqsjFJ+kzfmoR92naLqXNxapvvHznbE9UKIiTTt0kDUp+zkTOucCDBjYr0QPhpjH
         grn6z+0xdE22knNd95tQfCUvnn0peOwhYHDI30A9HcQ59RYbZ/p+oXQWuaxwqTCA+CU/
         OSIDmBT5zGOq+6ziGHjqcl/w29DiZbVZejExi5oQFPNUnnp9DFAmql0ahhKyIRbNpeO8
         pKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8u1pzMh4CC2fFXVfb1fmA18CvbUEdQSOPnIjgSzvs5o=;
        b=wPePrlpV1oferTKyooiahELHcpOEFp4yuO+EnzpqC7BVKp/FWZtxdZEle1vcouk2TU
         vUWtfERkLmPby26nPZk3aLRL+fmPRDZ2NLo5UJsC0SqqEUJGP1cxzBL4iQRYrD7tHzGc
         lHMP5eh/OY2WUex3gGODGhQKvKB8U8eibs0hTTQvsj/e6Xa/H8tw6VmPao3a0L8n1gSf
         4Bgkmsp89bhCBkuhYS0kK/uwQaJlLVdjyqyKTnU6Mikz+7JNs+ck2HIynNUymY1+Py16
         hyJ6JLo7aY09Z6B8gpZAnuv0JdgcqwyMMGFks1yiUNBd86WrpKdnDs4dk3jCoO6voZNh
         Cv3g==
X-Gm-Message-State: ACrzQf0R9RAPE9L9y4HjawfFTHyhXSfOJQ+/y2pseJ7c3i8JiFEBYFRA
        29OkOpPj8Fzqy6A3X8rbXOs=
X-Google-Smtp-Source: AMsMyM7UyUKBJEzElZcgwj6IszQGguAV9q66JFfV1eCPXOxaL3/m5aa6RzWKchbQg8brGJrMm9FPQw==
X-Received: by 2002:a17:90b:3b90:b0:202:80ac:467c with SMTP id pc16-20020a17090b3b9000b0020280ac467cmr35864193pjb.17.1664205638979;
        Mon, 26 Sep 2022 08:20:38 -0700 (PDT)
Received: from localhost.localdomain ([49.67.2.53])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b001755e4278a6sm11265882plk.261.2022.09.26.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:20:38 -0700 (PDT)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, bobwxc@email.cn, hughd@google.com,
        rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH] Documentation/mm: modify page_referenced to folio_referenced
Date:   Mon, 26 Sep 2022 23:20:32 +0800
Message-Id: <20220926152032.74621-1-vernon2gm@gmail.com>
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

Since commit b3ac04132c4b ("mm/rmap: Turn page_referenced() into
folio_referenced()") the page_referenced function name was modified,
so fix it up to use the correct one.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 Documentation/mm/unevictable-lru.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index b280367d6a44..4a0e158aa9ce 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -197,7 +197,7 @@ unevictable list for the memory cgroup and node being scanned.
 There may be situations where a page is mapped into a VM_LOCKED VMA, but the
 page is not marked as PG_mlocked.  Such pages will make it all the way to
 shrink_active_list() or shrink_page_list() where they will be detected when
-vmscan walks the reverse map in page_referenced() or try_to_unmap().  The page
+vmscan walks the reverse map in folio_referenced() or try_to_unmap().  The page
 is culled to the unevictable list when it is released by the shrinker.
 
 To "cull" an unevictable page, vmscan simply puts the page back on the LRU list
@@ -267,7 +267,7 @@ the LRU.  Such pages can be "noticed" by memory management in several places:
  (4) in the fault path and when a VM_LOCKED stack segment is expanded; or
 
  (5) as mentioned above, in vmscan:shrink_page_list() when attempting to
-     reclaim a page in a VM_LOCKED VMA by page_referenced() or try_to_unmap().
+     reclaim a page in a VM_LOCKED VMA by folio_referenced() or try_to_unmap().
 
 mlocked pages become unlocked and rescued from the unevictable list when:
 
@@ -547,7 +547,7 @@ vmscan's shrink_inactive_list() and shrink_page_list() also divert obviously
 unevictable pages found on the inactive lists to the appropriate memory cgroup
 and node unevictable list.
 
-rmap's page_referenced_one(), called via vmscan's shrink_active_list() or
+rmap's folio_referenced_one(), called via vmscan's shrink_active_list() or
 shrink_page_list(), and rmap's try_to_unmap_one() called via shrink_page_list(),
 check for (3) pages still mapped into VM_LOCKED VMAs, and call mlock_vma_page()
 to correct them.  Such pages are culled to the unevictable list when released
-- 
2.25.1

