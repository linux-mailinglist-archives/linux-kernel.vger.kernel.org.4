Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED224693217
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBKPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKPsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:48:51 -0500
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003A189
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:48:50 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676130528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ePdADAGgNuPhLaxQ+Eg7zNcrIY+/1S9vDM4BoYe1IWA=;
        b=cC/ddxCba3RAt94MdNKxpHZPcZSo+8WDw42zWSx0QdpqnM68nYU/jrWKT0Dv/inhCpGFdW
        Mm0N1iMbRaIiLzTlMswWc6yU+xDSL7GmRWw4HEYjjSsPsC3+4EfDaRU84/WxNYbd0/T5FW
        2hBVMM/PnFecuTOdwoBPJSapfoRS4mE=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] lib/stackdepot: fix for "annotate racy pool_index accesses"
Date:   Sat, 11 Feb 2023 16:48:42 +0100
Message-Id: <95cf53f0da2c112aa2cc54456cbcd6975c3ff343.1676129911.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Change the remaning reference to pool_index in stack_depot_fetch to
pool_index_cached.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This change can be squashed into "lib/stackdepot: annotate racy pool_index
accesses".
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index ec772e78af39..036da8e295d1 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -470,7 +470,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 
 	if (parts.pool_index > pool_index_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-			parts.pool_index, pool_index, handle);
+			parts.pool_index, pool_index_cached, handle);
 		return 0;
 	}
 	pool = stack_pools[parts.pool_index];
-- 
2.25.1

