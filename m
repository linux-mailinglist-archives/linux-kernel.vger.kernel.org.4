Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F967B3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjAYNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjAYNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:45:14 -0500
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F2A59245
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:44:48 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 370A11C405F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:44:47 +0000 (GMT)
Received: (qmail 20032 invoked from network); 25 Jan 2023 13:44:46 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 25 Jan 2023 13:44:46 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 0/4] Fix excessive CPU usage during compaction
Date:   Wed, 25 Jan 2023 13:44:30 +0000
Message-Id: <20230125134434.18017-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7efc3b726103 ("mm/compaction: fix set skip in fast_find_migrateblock")
fixed a problem where pageblocks found by fast_find_migrateblock() were
ignored. Unfortunately there were numerous bug reports complaining about high
CPU usage and massive stalls once 6.1 was released. Due to the severity,
the patch was reverted by Vlastimil as a short-term fix[1] to -stable and
is currently sitting in the Andrew's git branch mm/mm-hotfixes-unstable.

The underlying problem for each of the bugs is suspected to be the
repeated scanning of the same pageblocks. This series should guarantee
forward progress even with commit 7efc3b726103. More information is in
the changelog for patch 4.

If this series is accepted and merged after the revert of 7efc3b726103
then a "revert of the revert" will be needed.

[1] http://lore.kernel.org/r/20230113173345.9692-1-vbabka@suse.cz

 mm/compaction.c | 73 +++++++++++++++++++++++++++++++------------------
 mm/internal.h   |  6 +++-
 2 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.35.3

Mel Gorman (4):
  mm, compaction: Rename compact_control->rescan to finish_pageblock
  mm, compaction: Check if a page has been captured before draining PCP
    pages
  mm, compaction: Finish scanning the current pageblock if requested
  mm, compaction: Finish pageblocks on complete migration failure

 mm/compaction.c | 73 +++++++++++++++++++++++++++++++------------------
 mm/internal.h   |  6 +++-
 2 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.35.3

