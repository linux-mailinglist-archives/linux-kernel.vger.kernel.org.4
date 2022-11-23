Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44E635B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiKWLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiKWLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:13:43 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27904116AB8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:10:28 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowAA3PjaL_31j3FZDAQ--.40765S2;
        Wed, 23 Nov 2022 19:10:04 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, vbabka@suse.cz,
        42.hyeyoo@gmail.com, vasily.averin@linux.dev,
        akpm@linux-foundation.org, shakeelb@google.com,
        vvghjk1234@gmail.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] mm/tracing: Add check for kmem_cache
Date:   Wed, 23 Nov 2022 19:10:01 +0800
Message-Id: <20221123111001.34855-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAA3PjaL_31j3FZDAQ--.40765S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw13AFy7Gw1fGrW8tFWDArb_yoWkurc_uF
        47Xan5C3yrKrnakr42yw1Uur1S93yfJw1S9rn5tryaq3yrGr45Gw1v9w1Svw4xWrnFvF12
        ya9FvrWSyrnxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5sjjDU
        UUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __kmem_cache_alloc_lru() of mm/slab.c, cachep may be NULL when error
occurs in slab_alloc().
However, trace_kmem_cache_alloc() will still use it as the parameter,
which may cause NULL poineter dereference.
Therefore, it should be better to add the check and handle the error
in the trace_kmem_cache_alloc().

Fixes: 36555751c675 ("kmemtrace: SLAB hooks.")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 include/trace/events/kmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 243073cfc29d..d99507d32ef5 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -32,8 +32,8 @@ TRACE_EVENT(kmem_cache_alloc,
 	TP_fast_assign(
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
-		__entry->bytes_req	= s->object_size;
-		__entry->bytes_alloc	= s->size;
+		__entry->bytes_req	= s ? s->object_size : 0;
+		__entry->bytes_alloc	= s ? s->size : 0;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->node		= node;
 		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
-- 
2.25.1

