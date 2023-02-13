Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2D7694B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjBMPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBMPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:45:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ADF193E5;
        Mon, 13 Feb 2023 07:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A1E6118C;
        Mon, 13 Feb 2023 15:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4F9C433EF;
        Mon, 13 Feb 2023 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676303101;
        bh=3TCnaksRiCFT0Z0YvJMH4En9wOOliKkX6mIfVxch1/U=;
        h=From:To:Cc:Subject:Date:From;
        b=oYFoV1C5N4+99kOQgjte+Mu1C4C1loYygKcOeGLooD+7IDAvMRWOffEe4OTZYtGYX
         PzZnFN6/AMPLYvxYrnkkazkkqLSskGo7Xl0mSO1FNKJBPdlUiTRfGSVf3v+nWoOtk6
         U8Oxds2TR89PHDtjOqGDuNyYVD0oQmmEAHBlRT9NdcEIePxQgazWKnu8H2qZSODwKp
         qFYxSU8p3IXWX1Jok49Y+3glLsUuIunphcHLOe1nGWgJn9d3bhCQcmrf1SWhHIV1tw
         sqW5rA9NWOHKgiKYunURqRH8yq0cCpQ7ryVTEQAxzekI3XXNKXQilk2Tqb+SkUtbvG
         IwoAiICoybG2g==
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
Subject: [PATCH v3] docs/mm: Physical Memory: add example of interleaving nodes
Date:   Mon, 13 Feb 2023 17:44:47 +0200
Message-Id: <20230213154447.1631847-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Add an example of memory layout with interleaving nodes where even memory
banks belong to node 0 and odd memory banks belong to node 1

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---

v3:
* Fix typos and wording (Matthew) 

v2: https://lore.kernel.org/all/20230212095445.1311627-1-rppt@kernel.org
* Wording update (Bagas)
* Add forgotten Suggested-by

v1: https://lore.kernel.org/all/20230211102207.1267058-1-rppt@kernel.org
 Documentation/mm/physical_memory.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 3f3c02aa6e6e..863ddcd0b291 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -114,6 +114,25 @@ RAM equally split between two nodes, there will be ``ZONE_DMA32``,
   |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
   +---------+----------+-----------+ +------------+-------------+
 
+
+Memory banks may belong to interleaving nodes. In the example below an x86
+machine has 16 Gbytes of RAM in 4 memory banks, even banks belong to node 0
+and odd banks belong to node 1::
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
+In this case node 0 will span from 0 to 12 Gbytes and node 1 will span from
+4 to 16 Gbytes.
+
 .. _nodes:
 
 Nodes

base-commit: e076f253283c3e55a128fa9665c0e6cd8146948d
-- 
2.35.1

