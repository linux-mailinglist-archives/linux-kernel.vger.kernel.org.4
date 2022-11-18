Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1954662F252
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiKRKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiKRKR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:17:28 -0500
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332311174
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:17:26 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id DC64CBAADC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:17:24 +0000 (GMT)
Received: (qmail 3079 invoked from network); 18 Nov 2022 10:17:24 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 18 Nov 2022 10:17:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 0/2] Leave IRQs enabled for per-cpu page allocations
Date:   Fri, 18 Nov 2022 10:17:12 +0000
Message-Id: <20221118101714.19590-1-mgorman@techsingularity.net>
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

Changelog since V2
o Fix list corruption issue					(hughd)
o Tighen up locking protocol					(hughd)
o Micro-optimisations						(hughd)

Changelog since V1
o Use trylock in free_unref_page_list due to IO completion from
  softirq context						(yuzhao)

This was a standalone patch but now split in two. The main changes since
v2 are fixing the issues exposed by Hugh's shmfs stress test.

Patch 1 is a long-standing issue that is technically a bug but happened
to work because of how it was used.

Patch 2 leaves IRQs enabled for most PCP allocations with more details
in the changelog itself.

-- 
2.35.3

