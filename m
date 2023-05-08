Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274986FA36F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjEHJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjEHJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:35:46 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398EFD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:35:42 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 3489XOjT032670;
        Mon, 8 May 2023 17:33:24 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 8 May 2023 17:33:19 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH 0/2] Optimization of CMA allocation and reclaiming
Date:   Mon, 8 May 2023 17:33:01 +0800
Message-ID: <1683538383-19685-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 3489XOjT032670
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

These two commits help to solve bellowing OOM issue which all free pages are
composed of CMA.

04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
	......
041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0

Zhaoyang Huang (2):
  mm: optimization on page allocation when CMA enabled
  mm: skip CMA pages when they are not available

 mm/page_alloc.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 mm/vmscan.c     | 15 +++++++++++++--
 2 files changed, 53 insertions(+), 8 deletions(-)

-- 
1.9.1

