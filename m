Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3715EB329
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiIZVb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIZVbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:31:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB27391D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E9AB81133
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A9EC433C1;
        Mon, 26 Sep 2022 21:31:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZejhL1fX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664227905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLbf48vjMlZ56ruPBS9/QkT83yj7vuavaEds8C6XntY=;
        b=ZejhL1fXQ/v8Qg/iK+oOm7uXWm2BzU4H34s3VE+vjpIghtIo61Co1OU/kvkIwXpZREMKNi
        w0qUJE8VoDmqFEd+4H/uXVHWsfgPOwG54ULNfvRuZ0U3LI/7o/szg3J9bALMa3Z/z6j9gs
        80hQNP19vXnYYd6MKvG+WW8jNxloAuY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0b02cf89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 21:31:44 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 2/2] kfence: use better stack hash seed
Date:   Mon, 26 Sep 2022 23:31:30 +0200
Message-Id: <20220926213130.1508261-2-Jason@zx2c4.com>
In-Reply-To: <20220926213130.1508261-1-Jason@zx2c4.com>
References: <20220926213130.1508261-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of the prior commit, the RNG will have incorporated both a cycle
counter value and RDRAND, in addition to various other environmental
noise. Therefore, using get_random_u32() will supply a stronger seed
than simply using random_get_entropy(). N.B.: random_get_entropy()
should be considered an internal API of random.c and not generally
consumed.

Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 mm/kfence/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c252081b11df..239b1b4b094f 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -864,7 +864,7 @@ static void kfence_init_enable(void)
 
 void __init kfence_init(void)
 {
-	stack_hash_seed = (u32)random_get_entropy();
+	stack_hash_seed = get_random_u32();
 
 	/* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
 	if (!kfence_sample_interval)
-- 
2.37.3

