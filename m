Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9ED702B93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbjEOLgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbjEOLeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:34:00 -0400
Received: from outbound-smtp16.blacknight.com (outbound-smtp16.blacknight.com [46.22.139.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DEC1AE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:33:58 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 7EF451C4508
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:33:56 +0100 (IST)
Received: (qmail 25051 invoked from network); 15 May 2023 11:33:56 -0000
Received: from unknown (HELO localhost.localdomain) (mgorman@techsingularity.net@[193.118.249.27])
  by 81.17.254.9 with ESMTPA; 15 May 2023 11:33:56 -0000
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
Subject: [PATCH 0/4] Follow-up "Fix excessive CPU usage during compaction"
Date:   Mon, 15 May 2023 12:33:40 +0100
Message-Id: <20230515113344.6869-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series "Fix excessive CPU usage during compaction" [1] attempted to
fix a bug [2] but Vlastimil noted that the fix was incomplete [3]. While
the series was merged, fast_find_migrateblock was still disabled. This
series should fix the corner cases and allow 95e7a450b819 ("Revert
"mm/compaction: fix set skip in fast_find_migrateblock"") to be safely
reverted. Details on how many pageblocks are rescanned are in the
changelog of the last patch.

[1] https://lore.kernel.org/r/20230125134434.18017-1-mgorman@techsingularity.net
[2] https://bugzilla.suse.com/show_bug.cgi?id=1206848
[3] https://lore.kernel.org/r/a55cf026-a2f9-ef01-9a4c-398693e048ea@suse.cz

 mm/compaction.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.35.3

