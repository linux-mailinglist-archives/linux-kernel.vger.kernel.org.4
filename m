Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81974692FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjBKKW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBKKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:22:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76093C7AC;
        Sat, 11 Feb 2023 02:22:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88877B80C9D;
        Sat, 11 Feb 2023 10:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07F6C433EF;
        Sat, 11 Feb 2023 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676110941;
        bh=wXl+v2cYHgUVOYrT8Nhyj05SgXbb90sDCK2do+1O72Q=;
        h=From:To:Cc:Subject:Date:From;
        b=WM04XY0XXQsO1ywofpTxfKKq89jA+kGnAq4tcROhzX22g6f0Yjs5U8EnRWSbn2Fti
         RdsT9zw/0eHyTYOBaQTPjlfe2WImhhFK+1AbeUKh6vux1yc/nFPpU79zdOwojCXdiA
         kgTU8m0vPpq20rvBFzNHzeFLmKETbdRV5RuCokBRuk+/shoL5xGsSoF+iAe/YQBVc5
         3rUMb5YNF2fRM2SvkwvQ4b91ETFGgFK+xs8w+xutGzrpJdrWUIkS5Tt72UlQqRVx91
         um9nL4Lj+lfPl7Lf5n1RpBh2gvadE2Sen3P6fHp6LDOTyQN7SjQU+JEQLx+uf23GRF
         AfjTO/9qv8SKQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] docs/mm: Physical Memory: add example of interleaving nodes
Date:   Sat, 11 Feb 2023 12:22:07 +0200
Message-Id: <20230211102207.1267058-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Add an example of memory layout with interleaving nodes where even memory
banks belong to node 0 and odd memory banks belong to node 1

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---

As per Michal's request add an example of interleaving nodes.
This is based on Jon's docs-next of Wednesday.

 Documentation/mm/physical_memory.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 3f3c02aa6e6e..eb9a7a6d3216 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -114,6 +114,25 @@ RAM equally split between two nodes, there will be ``ZONE_DMA32``,
   |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
   +---------+----------+-----------+ +------------+-------------+
 
+
+Note, that memory banks may belong to interleaving nodes. In the example
+below an x86 machine has 16Gbytes or RAM in 4 memory banks, even banks
+belong to node 0 and odd banks belong to node 1::
+
+
+  0              4G              8G             12G            16G
+  +-------------+ +-------------+ +-------------+ +-------------+
+  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
+  +-------------+ +-------------+ +-------------+ +-------------+
+
+  0   16M      4G
+  +-----+-------+ +-------------+ +-------------+ +-------------+
+  | DMA | DMA32 | |    NORMAL   | |    NORMAL   | |    NORMAL   |
+  +-----+-------+ +-------------+ +-------------+ +-------------+
+
+In such case node 0 will span from 0 to 12 Gbytes and node 1 will span from
+4 Gbytes to 16 Gbytes.
+
 .. _nodes:
 
 Nodes

base-commit: e076f253283c3e55a128fa9665c0e6cd8146948d
-- 
2.35.1

