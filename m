Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C2740AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjF1ISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjF1INQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:13:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38F4216
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:09:06 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7835ae70e46so129663039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687939745; x=1690531745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59hIQrKJpHgwfOvQPS9O30uYvhiNepA8VuOZQbvyanA=;
        b=SFKtD3tNp47O7hLGtkWAqB6u3Fy07A6aGlUVdRw4nLkac9JrqDgtqTaFExV7WL/rlm
         Nb2al5xJWdRJhPCSsjbva5j5lsb0FkU4gsLJbXZZfVv5JLHBhHtHB/7eqmrdxEl5o9Gz
         31su8Z81XwyzWy3pK7Hm/WOzDCGWASLbqRmpqZLLjPu7zq+nZ5uOsGVPTGb79uhRPKfV
         6FSeqwcMxQlgGHJkV3XI49+qtuAnpmbnesmyALdxBdp3kO5PuD44dkdKgj6gwoF+EBPm
         5jW5QcX1qQo5mn1URGuTRFYFmeOLnCDbi2R1XsNYTJVO7WbEvRKah8fA7koBXTZ1iAYr
         Vh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939745; x=1690531745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59hIQrKJpHgwfOvQPS9O30uYvhiNepA8VuOZQbvyanA=;
        b=ZGXl1WOWAKFkf9tDUvx9Sl84aj8EU1BJc7vFk2EaNK55M2GdFXQExKoJxWISTi3l/b
         pAr7NZ3GVZelbzTwWD8efLa5etX+LjmDoQwgiSpFr67sFBGNRVnheM9Synh5yilrFDUL
         +hbg1RTyjDDSkH9GimebE4agKFXxobVLV0pZ3DGVA2Cex5tqlSGhYQYpxpXeqeA8D+rO
         vHwvQ5OmITnf4czJmbuOqY7AoXVUFlQvIBkqZWQLPoGkbbjuzmDVPRx2BDDf5m7Z2TSt
         MDfspDnbMtiT7xAyHOhrgcRIz1PuX8oEgV4iP7T0ONuW/Qps/b4gky8fKp8nlTndEtd2
         dhmA==
X-Gm-Message-State: AC+VfDxqDrUNn8RIo6aOIfzV4fDCc8ZtboGTv0rIRItZqwhEZxp9uaNl
        yBi9Vd0qhpvPPyXICOmhJ1KyTQA6d5LNdc9jzcsBzw==
X-Google-Smtp-Source: ACHHUZ7sSZA2dWtV3MSXiHZSsyyjPBx3Gzn28IS91FEiYfJ0YdxogMtvUD6PcjFRg/YjdoP0oDZayw==
X-Received: by 2002:a05:6a20:a108:b0:12c:1193:a563 with SMTP id q8-20020a056a20a10800b0012c1193a563mr1398950pzk.58.1687937828517;
        Wed, 28 Jun 2023 00:37:08 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b8021fbcd2sm4836988plb.280.2023.06.28.00.37.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jun 2023 00:37:08 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 0/4] Optimize the fast path of mas_store()
Date:   Wed, 28 Jun 2023 15:36:53 +0800
Message-Id: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fast paths for mas_wr_append() and mas_wr_slot_store() respectively.
The newly added fast path of mas_wr_append() is used in fork() and how
much it benefits fork() depends on how many VMAs are duplicated.

Thanks Liam for the review.

Changes since v3:
 - Revise the commit log of [4/4]

v1: https://lore.kernel.org/lkml/20230602075353.5917-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230609120347.63936-1-zhangpeng.00@bytedance.com/
v3: https://lore.kernel.org/lkml/20230615084301.97701-1-zhangpeng.00@bytedance.com/

Peng Zhang (4):
  maple_tree: add test for mas_wr_modify() fast path
  maple_tree: add test for expanding range in RCU mode
  maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
  maple_tree: add a fast path case in mas_wr_slot_store()

 lib/maple_tree.c                 | 69 +++++++++++++++++++----------
 lib/test_maple_tree.c            | 65 +++++++++++++++++++++++++++
 tools/testing/radix-tree/maple.c | 75 ++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 23 deletions(-)

-- 
2.20.1

