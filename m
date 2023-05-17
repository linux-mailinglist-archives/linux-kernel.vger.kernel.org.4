Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739F470636F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjEQI7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjEQI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3704EC9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-25345ca8748so314393a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313926; x=1686905926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3VYFX4gN8A4+At0+49J9ZIglBWE8IjNo2KkSLdFPCQ=;
        b=XPhv43rI0nh8/+jtGffT9p76SQOck8PZDUnIxRHnZMsE3Qep1humOo9QC7H7DEwyUg
         uQnSEMjFhsDTRY0o1npR4s4RCq6NIBM5ytk8H88EDvEQ7g3fFBmsC1LS6sCnB//Jw+2o
         EFERMFhvd8WEA9ErQnKZexTVzcXuTWZw6cjl3cd8JlSdYHydM3B5uWN8lI7jtb61um7s
         0U5BygfKb0Bv4RVj3coa1KUSqizyDN/yPDA0JMchhB6FuvePorKAaAl34KrVonVa30fo
         xt1Qz89NOCa0khCKydqOHY0yiQ1tSVa4iePs8XniWmYGwLeFcAovUT/t51B8tyKlivuk
         MNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313926; x=1686905926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3VYFX4gN8A4+At0+49J9ZIglBWE8IjNo2KkSLdFPCQ=;
        b=i7mMVNNV7r1+A1N53W/LjBho9knr8BWDfzWGYzRvvkSy4FPDfh91PlguicpZtTsHEl
         tQCf3acNbisIL7hvwQKRQa+KYDSVfc/ld9zsW6aCFQSPh+eKvG1unnGoDYSE54UyXGBM
         YPncK+ZLrHfNOjSJGnm/nUFi2pIj4KfrT/g59tqnz2/UNlfttO5BnK+Gwel1QmItc1fV
         1b1U+uiJct8ZJX1jpJDuJMG9mRDufVWfj7JEz/fx0Px5Cb8gVXZq9QOif2RnE1BdEy+g
         reVVBh8v5VySlnY4rmzUOOCbrzAFGVJMEECa0ZSZmJKRz4mCRhcCrrzbEgaPHtWIO3rC
         0vAA==
X-Gm-Message-State: AC+VfDwhQocq5Xm2JrMBNFJXjOFu9PESO8tScnu9KOVd/YgdIINxXBw7
        cg8dX2XkDGxuxz1BiQHHu/Lq8Q==
X-Google-Smtp-Source: ACHHUZ5OzFpipbAy1h25i/uNcKOZM0aG6gCIXztvd1dpil9APougs7VAsPCF+lIev/xq+KbbqcB5HQ==
X-Received: by 2002:a17:90a:608f:b0:24e:3b69:a87f with SMTP id z15-20020a17090a608f00b0024e3b69a87fmr38040800pji.25.1684313926526;
        Wed, 17 May 2023 01:58:46 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.58.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:58:46 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 00/10] Clean ups for maple tree
Date:   Wed, 17 May 2023 16:57:59 +0800
Message-Id: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
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

Some clean ups, mainly to make the code of maple tree more concise.
This patchset has passed the self-test.

0006-0009 - Make mas_wr_modify() and its subfunctions clearer. Make the
            store operation of maple tree more efficient in some cases.

Thanks Liam and Matthew.

Changes since v1:
 - Rework mtree_alloc_{range,rrange}() instead of removing it. [01/10]
 - Fix the arguments to __must_hold() instead of removing it. [03/10]
 - Keep the fast path. Expand the compact code. [04/10]
 - Drop "maple_tree: Wrap the replace operation with an inline
   function.". [v1 06/10]
 - Remove some comments. [07/10] [08/10]
 - Avoid modifying wr_mas->offset_end in mas_wr_modify(). [09/10]
 - Add a patch to relocate mas_empty_area_rev(). [10/10]

Peng Zhang (10):
  maple_tree: Rework mtree_alloc_{range,rrange}()
  maple_tree: Drop mas_{rev_}alloc() and mas_fill_gap()
  maple_tree: Fix the arguments to __must_hold()
  maple_tree: Simplify mas_is_span_wr()
  maple_tree: Make the code symmetrical in mas_wr_extend_null()
  maple_tree: Add mas_wr_new_end() to calculate new_end accurately
  maple_tree: Add comments and some minor cleanups to mas_wr_append()
  maple_tree: Rework mas_wr_slot_store() to be cleaner and more
    efficient.
  maple_tree: Simplify and clean up mas_wr_node_store()
  maple_tree: Relocate the declaration of mas_empty_area_rev().

 include/linux/maple_tree.h |  12 +-
 lib/maple_tree.c           | 455 +++++++++++++------------------------
 2 files changed, 160 insertions(+), 307 deletions(-)

-- 
2.20.1

