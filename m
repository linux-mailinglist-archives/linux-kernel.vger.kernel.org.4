Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3469B37B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBQUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBQUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:07:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790EA5F82A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:07:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q8-20020a25f408000000b00944353b6a81so1948373ybd.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U1nM6W22xHjS3Bc4zx0z84OyKRX34ntnrDpqWA7KxXE=;
        b=Rq55dr4IlqUaOCip4zZ6Bfk+GkgFZxk6avpazKoRSLojShtX34gYkNdC8/5SbhTzhE
         4MZAJbUgib1m72WWVl4DX98FY0VipeLo3JbjLgwWqrnyMvf9E8/cpyyb+UHevXrKil5B
         OFSI6s5GRiEmESPGK5Mym34edcC6jcPzHNGj9fKb3z0Q7JKQU9Rk8bq9XGX0asjVIqMa
         3Y/ftanfYZzyuJsazVqATYvrwQPpNp1pqC4h5bnBaoOIGcluscjTPWhlqmghiYk7hTCP
         5m0zMNIOVvgn5s9wb7XSLLz9wIs2SItRvq6ibRdib84zXFWqaukJHmJ0yNIZQNG6iYPd
         AAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1nM6W22xHjS3Bc4zx0z84OyKRX34ntnrDpqWA7KxXE=;
        b=AScwCHt7BV0dRmjUNAv13nNEe8kDnxIicmEbEhGoxoW5HE+UfRFLO1wL444q0Q8wDy
         6mxI0wztbmSqmI6nsb6/D880A0fUVurvrzKqBQRHrJIVcHgtwuG2Irp4PIFCmnEhpZ/I
         JWP6NyJJqVwFpmeGu89RAVM9P6e3Sey0ARCQ/uRzJqCF3zpbnoFIxbCqb1fqvOdY1Rlg
         U2ayMFulv8YE2XJ/YEYuS0fQxqr3f9nYFI15Y8HAbZCHW5rGCoUSK6gGDqdv8c7evGJ4
         2DTNVKflKlUVOxOM3CbsKcuHt874pR4LAlxWmHyM20KKSuepyfXjKBH3iCSMNpk7bGph
         /0gA==
X-Gm-Message-State: AO0yUKVTw2M21aPTPzpGqetZBhkobU1BK6W34VpgxexjPcK/5UwsndtE
        z9ZQ2Yjse0eWp9Bb4x08Pac1wrQxhw8EOYJ5wpbu1Q==
X-Google-Smtp-Source: AK7set+IwRI9hRSSzsNSYknwwsteTFcswm8J6ufEohRY3jA3I/YoGe5TdkvTwxTX1AFimUbEPQLZIEhxMkSJ9cDiYtvt1Q==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:723d:63ac:5b97:6d54])
 (user=isaacmanjarres job=sendgmr) by 2002:a5b:d45:0:b0:8f2:9e6:47a4 with SMTP
 id f5-20020a5b0d45000000b008f209e647a4mr264475ybr.7.1676664460718; Fri, 17
 Feb 2023 12:07:40 -0800 (PST)
Date:   Fri, 17 Feb 2023 12:07:30 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217200731.285514-1-isaacmanjarres@google.com>
Subject: [PATCH 5.15] of: reserved_mem: Have kmemleak ignore dynamically
 allocated reserved mem
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Saravana Kannan <saravanak@google.com>, linux-mm@kvack.org,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        "Kirill A . Shutemov" <kirill.shtuemov@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>, stable@vger.kernel.org,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ce4d9a1ea35ac5429e822c4106cb2859d5c71f3e upstream.

Patch series "Fix kmemleak crashes when scanning CMA regions", v2.

When trying to boot a device with an ARM64 kernel with the following
config options enabled:

CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_DEBUG_KMEMLEAK=y

a crash is encountered when kmemleak starts to scan the list of gray
or allocated objects that it maintains. Upon closer inspection, it was
observed that these page-faults always occurred when kmemleak attempted
to scan a CMA region.

At the moment, kmemleak is made aware of CMA regions that are specified
through the devicetree to be dynamically allocated within a range of
addresses. However, kmemleak should not need to scan CMA regions or any
reserved memory region, as those regions can be used for DMA transfers
between drivers and peripherals, and thus wouldn't contain anything
useful for kmemleak.

Additionally, since CMA regions are unmapped from the kernel's address
space when they are freed to the buddy allocator at boot when
CONFIG_DEBUG_PAGEALLOC is enabled, kmemleak shouldn't attempt to access
those memory regions, as that will trigger a crash. Thus, kmemleak
should ignore all dynamically allocated reserved memory regions.

This patch (of 1):

Currently, kmemleak ignores dynamically allocated reserved memory regions
that don't have a kernel mapping.  However, regions that do retain a
kernel mapping (e.g.  CMA regions) do get scanned by kmemleak.

This is not ideal for two reasons:

1  kmemleak works by scanning memory regions for pointers to allocated
   objects to determine if those objects have been leaked or not.
   However, reserved memory regions can be used between drivers and
   peripherals for DMA transfers, and thus, would not contain pointers to
   allocated objects, making it unnecessary for kmemleak to scan these
   reserved memory regions.

2  When CONFIG_DEBUG_PAGEALLOC is enabled, along with kmemleak, the
   CMA reserved memory regions are unmapped from the kernel's address
   space when they are freed to buddy at boot.  These CMA reserved regions
   are still tracked by kmemleak, however, and when kmemleak attempts to
   scan them, a crash will happen, as accessing the CMA region will result
   in a page-fault, since the regions are unmapped.

Thus, use kmemleak_ignore_phys() for all dynamically allocated reserved
memory regions, instead of those that do not have a kernel mapping
associated with them.

Link: https://lkml.kernel.org/r/20230208232001.2052777-1-isaacmanjarres@google.com
Link: https://lkml.kernel.org/r/20230208232001.2052777-2-isaacmanjarres@google.com
Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Kirill A. Shutemov <kirill.shtuemov@linux.intel.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9da8835ba5a5..9e949ddcb146 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -47,9 +47,10 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 		err = memblock_mark_nomap(base, size);
 		if (err)
 			memblock_free(base, size);
-		kmemleak_ignore_phys(base);
 	}
 
+	kmemleak_ignore_phys(base);
+
 	return err;
 }
 
-- 
2.39.2.637.g21b0678d19-goog

