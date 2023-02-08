Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541168FB0D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBHXUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBHXUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:20:11 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1343EB53
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:20:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52bfc97f630so2707147b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 15:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCoda6GVlJUCMEgaP5lPaK+3ESTiE3x/X85Mx974aXU=;
        b=BOhMexM+VCdHXQh/QVZbzJHyumhrxhqyTt2CuvMH7lTp68/z+gaP3Wu9xOqUmMi+JB
         mrrdzAIQS5IgMvvLESeevC/Ab3TlUwMbewpdRZ/zUx0Y82FQXKYzOeTxkST4GZDbMs54
         bdNJm//D6to89ZuTxojonQAVWRuv9Z7ksH+y2Fkng+GggZovQ2CXp0Y+ob3G7vpvkpA+
         DrNYqfDijWuCk8YdtgwZLUAXZiEqzXoPKXNelEj9fobF8XJ5dYblWPSyuKdeL0KI17O4
         zb1jvbx9k1b9/14wdpulwjMcLCrsI5irymeM9A3/uL7UAA8qiFOsUvys67q2yh38HKl1
         cHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCoda6GVlJUCMEgaP5lPaK+3ESTiE3x/X85Mx974aXU=;
        b=yhEC9m0jZmABdGtnJrNkjWOBWLIbFQX6g0tqp4EeUTkPTXTHqOK1UuR4ZDUegYB9c8
         18HtKtJIyGl2O4p+DWg2keFTD/1TnVEIQ0DEwYU6GpbdE7bdB+rntEYh7+23buUgo+eL
         hso2uzoHYXXt5sUtlvIZro0CTlVDg4sHZY1JHllA9kh4aDzVq6dCbaZA/2knQ3Guxhnb
         AJmguABViHjjETVSIxih8myNNkTc/d3BO/kIuhUSlr1tRiyMbeeSnKcn1/v+4idgHMMq
         fKgxUzx2P+t2fQXh3m5IGT7viJGFN5lz8WitYk5OwEmD2qzVOEWxSPsMjJ685Dxw3DFo
         c6uQ==
X-Gm-Message-State: AO0yUKXCRlX3vVbv4NDbs0Hq6m4zbevbKDwm0/RwC3QszyXb69HP2Xle
        tDhTD7hQS++faVB33bigId7D0o2r4Z70NP+hVXo0Ug==
X-Google-Smtp-Source: AK7set/42Lq6W0kYDD0CkT7h1nmhW62J2WaSTP+TeY8dH0u9K20cQW4TZ3bI5L0bGpIY9ILamFJb+DNqD2WEeUFn24UATA==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:32e8:a89:521e:3f2e])
 (user=isaacmanjarres job=sendgmr) by 2002:a05:6902:101:b0:893:5f24:71b0 with
 SMTP id o1-20020a056902010100b008935f2471b0mr1029072ybh.163.1675898409119;
 Wed, 08 Feb 2023 15:20:09 -0800 (PST)
Date:   Wed,  8 Feb 2023 15:20:00 -0800
In-Reply-To: <20230208232001.2052777-1-isaacmanjarres@google.com>
Mime-Version: 1.0
References: <20230208232001.2052777-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230208232001.2052777-2-isaacmanjarres@google.com>
Subject: [PATCH v2 1/1] of: reserved_mem: Have kmemleak ignore dynamically
 allocated reserved mem
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Saravana Kannan <saravanak@google.com>, linux-mm@kvack.org,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>
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

Currently, kmemleak ignores dynamically allocated reserved memory
regions that don't have a kernel mapping. However, regions that do
retain a kernel mapping (e.g. CMA regions) do get scanned by kmemleak.

This is not ideal for two reasons:

1. kmemleak works by scanning memory regions for pointers to
allocated objects to determine if those objects have been leaked
or not. However, reserved memory regions can be used between drivers
and peripherals for DMA transfers, and thus, would not contain pointers
to allocated objects, making it unnecessary for kmemleak to scan
these reserved memory regions.

2. When CONFIG_DEBUG_PAGEALLOC is enabled, along with kmemleak, the
CMA reserved memory regions are unmapped from the kernel's address
space when they are freed to buddy at boot. These CMA reserved regions
are still tracked by kmemleak, however, and when kmemleak attempts to
scan them, a crash will happen, as accessing the CMA region will result
in a page-fault, since the regions are unmapped.

Thus, use kmemleak_ignore_phys() for all dynamically allocated reserved
memory regions, instead of those that do not have a kernel mapping
associated with them.

Cc: <stable@vger.kernel.org>    # 5.15+
Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 65f3b02a0e4e..f90975e00446 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -48,9 +48,10 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 		err = memblock_mark_nomap(base, size);
 		if (err)
 			memblock_phys_free(base, size);
-		kmemleak_ignore_phys(base);
 	}
 
+	kmemleak_ignore_phys(base);
+
 	return err;
 }
 
-- 
2.39.1.581.gbfd45094c4-goog

