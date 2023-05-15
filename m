Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DD6702DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbjEONSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbjEONS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:18:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C01FC8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24e4f674356so11420545a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156705; x=1686748705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcNyimDvnaaT/gjMmsV9BzD4TQpwv2NWZ5Achi/UK8A=;
        b=ZKZcZT2zw19wdGqbjikAC7Txxw+CFKfqWspbmBxqSFsJq8guoBzlwATVffAM2KtJGd
         HTnl1AHsRF3ErBtpgZ0Ebg/B1sgIZ+yf8EM+BPmw0zOU97zBzU53eTLcTGTYV4bSg/Df
         A/Q++eAMydfW47rELMrzNSawdmTLXMYgxfmQzAu+QhfpYeAYRPcXO1HGiJLbQAkppyAn
         w1ZkP8SGHNqM9RtZvKC/sI87xaxt8E/FGqKSvc4UXyj17lJY3ACeUmEZnweVXZ+BkW8N
         UIlMgqftYs9xHsE4ZNvV1HHu+qO9l/abMH6tWffzTAltg7TvC3Xle9+Dw+aX3YMsKgTd
         kUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156705; x=1686748705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcNyimDvnaaT/gjMmsV9BzD4TQpwv2NWZ5Achi/UK8A=;
        b=ewg63C1aHCWUlhKtyrzIbvYOVkia7ugaMR4du3NK+ZVmhcwHxRPLlXgATEW2FyfEZS
         LTA0VhNqR206sSGD/bVJolUJ7L8R7uOLk+YLwhFgDMcG1k5L9NfEzGYhs6/BMtYcOreT
         kEB9YTgu6Zgz62WU9IkwQB5hpIT53NzZ7zb49o7QlcweMOk8k3lwggjjEBBtmCXJ+1be
         /33eKwVHfCaJ9cZBf/z6jHO77wYKgpIlHcDLaGy/r0I7hnTf/opkPrUqMFiHX/pGgroP
         Q356q2e+s+VkSZ75sy5WvHHnYCWl8/28XRSolca1QVCbaGpqyzmTPJ0vZ18U4459k/3T
         lfjg==
X-Gm-Message-State: AC+VfDz2igMTlqwwtcoa1psaH+m+nxAYtGgtP5v1oPSjTL4SJn2ZQOvU
        kBLKUYZkOmLBgSR5fSRp2DmdKmFM2pbw3W4OkQ4=
X-Google-Smtp-Source: ACHHUZ7fa7SFUWLXtJ9qoePmtNgSliFzGOeoRzmRWpbPhEYQRH5ra5v5t4GtFzdfqodaJkKTWwWtRA==
X-Received: by 2002:a17:90b:fd6:b0:250:132a:5d93 with SMTP id gd22-20020a17090b0fd600b00250132a5d93mr31379541pjb.49.1684156704822;
        Mon, 15 May 2023 06:18:24 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:24 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 00/10] Clean ups for maple tree
Date:   Mon, 15 May 2023 21:17:47 +0800
Message-Id: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clean ups, mainly to make the code of maple tree more concise.
This patchset has passed the self-test.

0001-0002 - These two patches are collected from [1]
0005-0010 - Make mas_wr_modify() and its subfunctions clearer. Make the store
            operation of maple tree more efficient in some cases

[1] https://lore.kernel.org/lkml/20230510061049.53977-1-zhangpeng.00@bytedance.com/

Peng Zhang (10):
  maple_tree: Drop the test code for mtree_alloc_{range,rrange}()
  maple_tree: Drop mtree_alloc_{range,rrange}() and related functions.
  maple_tree: Remove __must_hold() which does not work
  maple_tree: Simplify mas_is_span_wr()
  maple_tree: Make the code symmetrical in mas_wr_extend_null()
  maple_tree: Wrap the replace operation with an inline function.
  maple_tree: Add mas_wr_new_end() to calculate new_end accurately
  maple_tree: Add comments and some minor cleanups to mas_wr_append()
  maple_tree: Rework mas_wr_slot_store() to be cleaner and more
    efficient.
  maple_tree: Simplify and clean up mas_wr_node_store()

 include/linux/maple_tree.h |   7 -
 lib/maple_tree.c           | 500 ++++++++++++-------------------------
 lib/test_maple_tree.c      | 389 -----------------------------
 3 files changed, 162 insertions(+), 734 deletions(-)

-- 
2.20.1

