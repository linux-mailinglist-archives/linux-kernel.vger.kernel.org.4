Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74402660855
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjAFUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAFUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:33:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253D5AC40;
        Fri,  6 Jan 2023 12:33:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA97161F46;
        Fri,  6 Jan 2023 20:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD775C433EF;
        Fri,  6 Jan 2023 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673037215;
        bh=70eLmqi50DwC4nGrPC6/BhJbdlKVrPt5HYhMfBWpJBc=;
        h=From:To:Cc:Subject:Date:From;
        b=UfFy2UIysVqCxWrNKjf2Jr8Hf6TtCep7aeD7mCO4w6TSdgK/anVbepYZjzWj+HtsT
         8u+UnX/hBhFxGZ+OF4GB2Kq6td4lFIXgcWX4brSuw/vmUFoOeiSh6ZMMqyQHUFOeZ/
         zzWrjqZBrRu1ujLDeVwLko5/4E4LNoFpth8IZQIYXYWCLiGa175VU8YIr9F0h51ATG
         S583TMR0011jHZ+wV3E3GmmxR7CJDmeRHGW3IFD/+10n6aDdg8uldIJX+OcXlGch6F
         dXnSFDryDTI5C6R8fGOU/AgJmR6cf7PXqZrYEsAnVLIedRtNKhOCWkPXlyOQbAnC5w
         CbVBv3EkdEdPw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] include/linux/mm: fix release_pages_arg kernel doc comment
Date:   Fri,  6 Jan 2023 20:33:31 +0000
Message-Id: <20230106203331.127532-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 449c796768c9 ("mm: teach release_pages() to take an array of
encoded page pointers too") added the kernel doc comment for
release_pages() on top of 'union release_pages_arg', so making 'make
htmldocs' complains as below:

    ./include/linux/mm.h:1268: warning: cannot understand function prototype: 'typedef union '

The kernel doc comment for the function is already on top of the
function's definition in mm/swap.c, and the new comment is actually not
for the function but indeed release_pages_arg.  Fixing the comment to
reflect the intent would be one option.  But, kernel doc cannot parse
the union as below due to the attribute.

    ./include/linux/mm.h:1272: error: Cannot parse struct or union!

Modify the comment to reflect the intent but do not mark it as a kernel
doc comment.

Fixes: 449c796768c9 ("mm: teach release_pages() to take an array of encoded page pointers too")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/mm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2bf261cdbef..3df8815f6d51 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1297,10 +1297,10 @@ static inline void folio_put_refs(struct folio *folio, int refs)
 		__folio_put(folio);
 }
 
-/**
- * release_pages - release an array of pages or folios
+/*
+ * union release_pages_arg - an array of pages or folios
  *
- * This just releases a simple array of multiple pages, and
+ * release_pages() releases a simple array of multiple pages, and
  * accepts various different forms of said page array: either
  * a regular old boring array of pages, an array of folios, or
  * an array of encoded page pointers.
-- 
2.25.1

