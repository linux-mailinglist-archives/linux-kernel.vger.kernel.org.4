Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96654741F43
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 06:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjF2Ebu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 00:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjF2Ebr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 00:31:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7661FE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:31:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bd77424c886so280590276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688013105; x=1690605105;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z3smH8SQO2wh8AZ/tEvfhS/BICA37Ii8kaU3dG+Uuo=;
        b=bbjxfVxsRx2mupCwEXHDjFVj2n5Txwdqkw7E1M+mboYtsr47GWsQtvHBxx+Ec0rllY
         YKoVHhnetGKgbAvXMg/sOkN7eJk0YAt570U6ZlfyqyZlMA5Kn4GML5Y89EoW3ZsM9/Kp
         kAl/iH8yqdCbUJtcy7MvxVi9yq4aU5UMRrsgMk1XlAA8Z1bpcC5rW2cfJTjfP7jARDwY
         YCuiB9rM/Y/t1EgkEP2nhi8vG5xHXynMImoh0E/WF5bcB31LTK7tZs1UafbVVhjgOqgN
         +Zua8Gx7RDK571uBCTwiCpDX6As9jJt1z8ZpBFPNpMsqvPYi9iWfBwz89FTJyRLUrdrr
         vxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688013105; x=1690605105;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z3smH8SQO2wh8AZ/tEvfhS/BICA37Ii8kaU3dG+Uuo=;
        b=YV9os7tIm3SylnKOvUuWOcz5aYsYi4sQyClOy0/WzZzZq9bJksUciUZSpjvXuXa6XD
         UlTNs4uJGKcqPQQa2ur5S3FHkwBapQW4Qf7gxV9aCyotcqFkv6bVgqK4I44q44dzlcmN
         DqVQLcrHmO/yj8ug74aLZl8L2RTFTu2ldH4ho9JHbgdqBELV1e1/u6p3WmX3PR2ShERy
         +F586WZ2pUeTVmSL+6qNBAJinBeOpMheS9QXJpcFq7ricCJmtjoobECdpjN/J8R5MWWx
         +I3INDDqQN6sI0w1yv0LpHAPnnvkfAQ7/OAzVcxiX+yy4oq9E+IrLuPjshmPBDLTn5+m
         6FXw==
X-Gm-Message-State: AC+VfDzQBXsGu/IQDpO6AqiNNJoxm2sbQTiG0+R4kNbJJFKtKQmJ7VPZ
        eEUsWeQceyGlMF5JTZnpwPprUw==
X-Google-Smtp-Source: ACHHUZ4EVD+2CjOf5QXl5EbRGAgOpPEe1F0AFrSkRRhfxSjfgcG8pZbY7ACf6AweRR0B41j5ZrrypA==
X-Received: by 2002:a25:bf8b:0:b0:c2c:c280:83be with SMTP id l11-20020a25bf8b000000b00c2cc28083bemr8954521ybk.8.1688013104949;
        Wed, 28 Jun 2023 21:31:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k81-20020a252454000000b00bad03cb9325sm2389365ybk.32.2023.06.28.21.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 21:31:44 -0700 (PDT)
Date:   Wed, 28 Jun 2023 21:31:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Stevens <stevensd@chromium.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH hotfix] mm/khugepaged: fix regression in collapse_file()
In-Reply-To: <CAHk-=wj8b6joppjpYW=pi2r2LJgKHQKDwB9NkDmbsQAzWgf4AA@mail.gmail.com>
Message-ID: <ee572217-204b-45d4-64f1-f6822fc6c35@google.com>
References: <20230607053135.2087354-1-stevensd@google.com> <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com> <CAD=HUj4vVbyHiT7vPmRorS+v9t2+N46ak=Xrew2cFf5+utC=tQ@mail.gmail.com> <8ef3ee-ba41-8e9e-4453-73736ff27783@google.com> <df5819aa-c79-6b10-4ce1-a45af118c0f3@google.com>
 <CAHk-=wj8b6joppjpYW=pi2r2LJgKHQKDwB9NkDmbsQAzWgf4AA@mail.gmail.com>
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

There is no xas_pause(&xas) in collapse_file()'s main loop, at the points
where it does xas_unlock_irq(&xas) and then continues.

That would explain why, once two weeks ago and twice yesterday, I have
hit the VM_BUG_ON_PAGE(page != xas_load(&xas), page) since "mm/khugepaged:
fix iteration in collapse_file" removed the xas_set(&xas, index) just
before it: xas.xa_node could be left pointing to a stale node, if there
was concurrent activity on the file which transformed its xarray.

I tried inserting xas_pause()s, but then even bootup crashed on that
VM_BUG_ON_PAGE(): there appears to be a subtle "nextness" implicit in
xas_pause().

xas_next() and xas_pause() are good for use in simple loops, but not in
this one: xas_set() worked well until now, so use xas_set(&xas, index)
explicitly at the head of the loop; and change that VM_BUG_ON_PAGE() not
to need its own xas_set(), and not to interfere with the xa_state (which
would probably stop the crashes from xas_pause(), but I trust that less).

The user-visible effects of this bug (if VM_BUG_ONs are configured out)
would be data loss and data leak - potentially - though in practice I
expect it is more likely that a subsequent check (e.g. on mapping or on
nr_none) would notice an inconsistency, and just abandon the collapse.

Link: https://lore.kernel.org/linux-mm/f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com/
Fixes: c8a8f3b4a95a ("mm/khugepaged: fix iteration in collapse_file")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/khugepaged.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 3beb4ad2ee5e..78c8d5d8b628 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1937,9 +1937,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 	} while (1);
 
-	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
-		page = xas_next(&xas);
+		xas_set(&xas, index);
+		page = xas_load(&xas);
 
 		VM_BUG_ON(index != xas.xa_index);
 		if (is_shmem) {
@@ -1954,7 +1954,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 						result = SCAN_TRUNCATED;
 						goto xa_locked;
 					}
-					xas_set(&xas, index + 1);
 				}
 				if (!shmem_charge(mapping->host, 1)) {
 					result = SCAN_FAIL;
@@ -2090,7 +2089,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 		xas_lock_irq(&xas);
 
-		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
+		VM_BUG_ON_PAGE(page != xa_load(xas.xa, index), page);
 
 		/*
 		 * We control three references to the page:
-- 
2.35.3
