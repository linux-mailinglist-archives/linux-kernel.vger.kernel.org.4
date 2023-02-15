Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A390E697F79
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBOPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBOPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:24:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E486A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v23so20579503plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676474669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr8xw0GpgSDinfISjaWLMj9pTWMR4/E0MtCDDZjeQGc=;
        b=W9zKzHISha0iYW/fT1pEEv3c0rpU7JwDYPQqj5Akevx4weqg5i6aiGnqqnQoAB6sNL
         9HN+vOpU5Hy6HvbWyAlxSHfCP2/0FaxcOL6NC7aJfvpF6axDLBki7tSl6RSQKT9NxUUW
         ki7COyGU4H5z1EaEwwYDNKXJDrAstXSTb4PH9en1C+htebAMcr5DxxKAyWk7n8ZP6p46
         BzZb5k31PveTQfRF7eqxggtZeDvzTTtS8Vi71Jl9hQDH5vnIulvSl7/HUczeBhArpIv0
         uJT01WDmpsNnKlqQMP/L6ijRF60B2MzUPcPnGRNBB4twji16iGLuI1Eb+8CSBsl9CcvP
         pzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676474669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lr8xw0GpgSDinfISjaWLMj9pTWMR4/E0MtCDDZjeQGc=;
        b=5ERBT9Fc2xeCNkjj5OorNC0xJIbtJwTla3fZz6AEovZsmxAoxAux89Ydo2FvmJPuEV
         QxG+euciGfaIq1LoPcWJOf2Brjf/AO4SizPN8DRN2fM0CahyB/0KPNXqESDB7VA8EHQr
         21510lC/XAiFhdwshFSR/+xFFXFVhMpfnuGHj95rI35EzIRjM8MG7r2ygCnANj5vdMlO
         mCArS0j/fr0flIuGr85ADgTFt327UAmJR0UoHVIbDjUU4Tx9S889g3i/+vD15OxLEe+4
         K6QkcL6uPF5Ngyk8cuLDiEOTaJDZrG8zONllp2quTCLPbGurlBvtkS2b1FGK6oVPGsFT
         hDlA==
X-Gm-Message-State: AO0yUKXlbr8xNx11lMj8Ik7T1xbnZv3k18HXdBo5uxo96uuJUH/Fv6uJ
        ho8aDgIPc+wYEhbJBibwLtl+sw==
X-Google-Smtp-Source: AK7set+RUAUcoLYSoBP/GpqNloklYT61Pcwdm3S6pccP6ySG9Lt6wUWax8Gho7oJN897Iy82IushWw==
X-Received: by 2002:a17:903:41cc:b0:19a:9269:7d1 with SMTP id u12-20020a17090341cc00b0019a926907d1mr2937874ple.4.1676474669132;
        Wed, 15 Feb 2023 07:24:29 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id jh12-20020a170903328c00b0019682e27995sm6176997plb.223.2023.02.15.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:24:28 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/2] mm: page_alloc: skip memoryless nodes entirely
Date:   Wed, 15 Feb 2023 23:24:11 +0800
Message-Id: <20230215152412.13368-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In find_next_best_node(), We skipped the memoryless nodes
when building the zonelists of other normal nodes (N_NORMAL),
but did not skip the memoryless node itself when building
the zonelist. This will cause it to be traversed at runtime.

For example, say we have node0 and node1, node0 is memoryless
node, then the fallback order of node0 and node1 as follows:

[    0.153005] Fallback order for Node 0: 0 1
[    0.153564] Fallback order for Node 1: 1

After this patch, we skip memoryless node0 entirely, then
the fallback order of node0 and node1 as follows:

[    0.155236] Fallback order for Node 0: 1
[    0.155806] Fallback order for Node 1: 1

So it becomes completely invisible, which will reduce runtime
overhead.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/page_alloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..f0b17dd71bec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6377,8 +6377,11 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 	int min_val = INT_MAX;
 	int best_node = NUMA_NO_NODE;
 
-	/* Use the local node if we haven't already */
-	if (!node_isset(node, *used_node_mask)) {
+	/*
+	 * Use the local node if we haven't already. But for memoryless local
+	 * node, we should skip it and fallback to other nodes.
+	 */
+	if (!node_isset(node, *used_node_mask) && node_state(node, N_MEMORY)) {
 		node_set(node, *used_node_mask);
 		return node;
 	}
-- 
2.20.1

