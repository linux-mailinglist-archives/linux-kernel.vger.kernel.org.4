Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DC56EE0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjDYLF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjDYLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:05:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D8D5274
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b51fd2972so4490485b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420725; x=1685012725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbfbbaLnwggAnVA/1PFT1FKqIqdpa+HBvRwKLORRmx0=;
        b=dbWbkQGy3nNzhViZrEF6fUxfhCZhZmBLAdPktMKRE1TiYj24j72g4Puy0zdi+y8XT1
         DiLmC7D29lchjUmmx5U/el8fzTjcpw203C+wn75F0MpuOiHTjzeg9qR0VYGne5tZaLCU
         VOArCMokzKIJJrpymvjcT9FTiSFVBaDocGKjOjv9uXBJ+0xTuNzpOHOI38d4mIJ9I4eY
         N14r28mhfEKFrDUC7pN63CmSKZ+x+KOhaA2VzuL0l4cfdSpchBCnO4Pte9TUjJyplyOD
         R3CAw5mJLOua/Itqmy0gyQXn8SsfPhwANMc0OCIU8gXQi5Og665GwkiOzbBbtC+7NE6N
         hW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420725; x=1685012725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbfbbaLnwggAnVA/1PFT1FKqIqdpa+HBvRwKLORRmx0=;
        b=ZA1zV9DcmO3rJbTnu9OyPZHsFEzECuOlHlw4Q7HXU2ChoThU+GScCEknCUmGczTxGH
         zEiqReVB90tXFUy+/9TtdE7gg5Ij4HD6yt23s/mUHnpVpaeI1Nlohq21dDB6ldNKa4HL
         YWJQkhdqGeR4yUAhqnhtJuqZXMhxPyVjSKMuBHiA2ggDRfjh3wPhhhlCc1psBGqIt6Ou
         /HVf4z5+z2IiKW0OFu6BbOaCg6/As6vo1PDicZwvFZDtXlxqkEhVbkcICxWirc4ZBIQi
         ZxP089Z8n1UDA1bWNpToyALDK9TJy9rPnVPCo1GfV1r7d5AjMk+2bukkZMy2yS538Gso
         84iA==
X-Gm-Message-State: AAQBX9eZ/Sh4vxtA5Pc70bYlfyQEQWn4p8k1ZcThnkekJOD+7RZb/qAQ
        iNFw71+wG6Hnec3ELHrbHS60mGuHILAqYY0ptRg=
X-Google-Smtp-Source: AKy350apZYw0ShKd+pOlwm9yI8O9XpP6TEbh9OYbEEw8pPhwQf2gVwHZCjxcylFAf2ptDhYcPfDy0g==
X-Received: by 2002:a05:6a00:1582:b0:63d:3ddb:5f3f with SMTP id u2-20020a056a00158200b0063d3ddb5f3fmr24871172pfk.0.1682420725070;
        Tue, 25 Apr 2023 04:05:25 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:24 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 0/9] fix, rework and clean up for maple tree
Date:   Tue, 25 Apr 2023 19:05:02 +0800
Message-Id: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that Liam R. Howlett's v2 patch set[1] has been merged. Merging v3
will have conflicts, so I included the extra parts of v3 relative to v2 into my
patch set. In this way, v3 can be ignored.

I made some changes to [4/9] from Liam R. Howlett, because it was not fully
fixed before, causing the test to fail.

Refactored mtree_alloc_range/rrange() to fix bugs and improve maintainability.
This makes the three functions mas_fill_gap(), mas_rev_alloc() and mas_alloc()
no longer used. But I did not delete them, because maple tree is still under
development. This refactoring is worth discussing. And I don't understand why
these three functions are needed because there are functions similar to them.

[1]: https://lore.kernel.org/lkml/20230421135559.2163923-1-Liam.Howlett@oracle.com/

Liam R. Howlett (1):
  maple_tree: Update mtree_alloc_rrange() and mtree_alloc_range()
    testing

Peng Zhang (8):
  maple_tree: Fix allocation when min is equal to max in
    mas_empty_area/_area_rev()
  maple_tree: Make maple state reusable after mas_empty_area()
  maple_tree: Modify the allocation method of mtree_alloc_range/rrange()
  maple_tree: Remove an if statement that cannot be true
  maple_tree: Remove a confusing check
  maple_tree: Delete redundant code in mas_next_node()
  maple_tree: Remove the redundant check of mas->offset in
    mas_empty_area/area_rev()
  maple_tree: Move declaration of mas_empty_area_rev() to a better place

 include/linux/maple_tree.h | 12 ++---
 lib/maple_tree.c           | 89 +++++++++++---------------------------
 lib/test_maple_tree.c      | 30 +++++++++----
 3 files changed, 53 insertions(+), 78 deletions(-)

-- 
2.20.1

