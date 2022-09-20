Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3935BED39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiITS6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiITS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:58:15 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4C7436D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:58:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663700291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nxHRTq1Yg5oxG8+GRDFsDxq7DRLYMtQhvc5Xaz+eRBo=;
        b=GnIONQpnE3duZHvOo+5gN7TANSJ5algfnUTlz4osbwGz6JHamLMPEVM23h6esM+h9+qHKa
        bCpDoOnA4Dmx37fBZ3d+147FVKjbz/I9acSA5E2aK4bqIOFNJCgL7eoQP6jpQoccG3JKSr
        Z+2DWjvy9TxuyxxjqN1Hw/+elcqw0wk=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] kasan: initialize read-write lock in stack ring
Date:   Tue, 20 Sep 2022 20:58:07 +0200
Message-Id: <576182d194e27531e8090bad809e4136953895f4.1663700262.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Use __RW_LOCK_UNLOCKED to initialize stack_ring.lock.

Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Andrew, could you please fold this patch into:
"kasan: implement stack ring for tag-based modes".
---
 mm/kasan/tags.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 9d867cae1b7b..67a222586846 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -36,7 +36,9 @@ DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
 /* Non-zero, as initial pointer values are 0. */
 #define STACK_RING_BUSY_PTR ((void *)1)
 
-struct kasan_stack_ring stack_ring;
+struct kasan_stack_ring stack_ring = {
+	.lock = __RW_LOCK_UNLOCKED(stack_ring.lock)
+};
 
 /* kasan.stacktrace=off/on */
 static int __init early_kasan_flag_stacktrace(char *arg)
-- 
2.25.1

