Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFA6936C4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 10:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBLJzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 04:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 04:55:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB51024C;
        Sun, 12 Feb 2023 01:55:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47D960B50;
        Sun, 12 Feb 2023 09:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F95C433EF;
        Sun, 12 Feb 2023 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676195699;
        bh=VlJr4rZihpfcfqoU6zpWd33xnk4loe0lCeIMnSn8rvo=;
        h=From:To:Cc:Subject:Date:From;
        b=dfK5ZC7vMkNsPz+v77KRRdJ8E6ysa55bt2yVD1d5zP6J+QtDRXt47k6f59+HOUZKR
         fxKr3niqZzYzXQSByxqo6K7jnMJWyMbWVd0woLXmQdUIhXu6r5zmWadN1NOpNAr2P9
         //5+wYaMMGHca8Hdsp717dUj/VnKnDd4wWBw1mtMSfVxPHwyQFdbKkPLVJeDextKO1
         Cvb0tfqYmcFPuLgAIrgeWkN9wvdXaKRE9mwvTl6hPhqOpOUW8YoVKqETtp6qoaFv5+
         uypxIUhJ1SnMK9xmRqtfmZ1S+a1vkQ5SJyc1PwlEycLTM1bwRfKkpYQzz3wbPQ9Jcg
         rn+N4y2MZ0tNA==
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
Subject: [PATCH v2] docs/mm: Physical Memory: add example of interleaving nodes
Date:   Sun, 12 Feb 2023 11:54:45 +0200
Message-Id: <20230212095445.1311627-1-rppt@kernel.org>
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

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---

v2:
* Wording update (Bagas)
* Add forgotten Suggested-by

v1: https://lore.kernel.org/all/20230211102207.1267058-1-rppt@kernel.org

 Documentation/mm/physical_memory.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 3f3c02aa6e6e..d14b785fd938 100644
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
+4 to 16 Gbytes.
+
 .. _nodes:
 
 Nodes

base-commit: e076f253283c3e55a128fa9665c0e6cd8146948d
-- 
2.35.1

