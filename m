Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE276369C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiKWTRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiKWTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:17:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C68C72DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:17:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k7so17491331pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0SYvGjxlp7dw6JXDykKNCVFvc4QQ+pWPp2+QDRowV4=;
        b=kCBq9GguWJ4WHhxUlYFsFQb4CIUVrgFiCSAnYUxAlbSR0oxyreDtq45d+AovRSAQ7C
         1NfMyR8KF1COiW2lb6pdV5PCD90DcINjoOox+n0IDr9+TodG62OR5Eqh4eEDGMOEt/vH
         vY7wlXqFnwJbDfamwmH7gEf/kTImVPaA332JgUZ+V87tkLSxrWl93o2BF+pYnMVjxhOh
         yveVws5/DPVjOIdLKaJ9MMvqpj0NwkgiVBHL4WqWJrVtgNaR87hIIS1+CZjiWf7VTfsW
         qKr+FFrLJtiv7/xEh3gmT2FvrrWxlJH1VtYA9yOj5yS1Q0N/PIPT6oEa5vCwIfrlpBCF
         fY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0SYvGjxlp7dw6JXDykKNCVFvc4QQ+pWPp2+QDRowV4=;
        b=NZY4MBB8X1uQyXTHHOYFJprtJrF9yc/eRfrFSymN6rCY92P/Pu8GuwAkmF+R97NMfZ
         yyPg2eyGiY9NfhhQmAFKkbil08VkfaqlBQA1S6jkCOxsXEkjeQXtmRODGZzFH9IfhTN2
         LdlPODCoopA91yg+q5yqWjzsdCpWonrqOd4BKswNQsffkXYdNPLdpUKl45PAR6YIh4pS
         sQ3rn9S+9X4PNBsctQj5xOehZ1IhnuF5j5OE612NGSS+h+Hnjd6X5mSIRBqILidyMfU4
         x4WJFysvyUnH6agHwghcTVV0HHskuycNWo3QlEwXxNkImeKn1SLQ+RLBoIUpPsB0+sIg
         JyNA==
X-Gm-Message-State: ANoB5pmAQfiAjXEItGLdizbEGUpx3AsLfSVwjwLN2xdHxA77Kjnf2g//
        sO4dyF8VAlN9y2o6zALCsUk=
X-Google-Smtp-Source: AA0mqf4aTF2t29dtAxRyWgY0LpBARMr/iVrO8UN6QfmAylGKzziqN6PcoAfC9Jx7jBo8WQd4tVD+8g==
X-Received: by 2002:a17:902:8f96:b0:189:3803:23e6 with SMTP id z22-20020a1709028f9600b00189380323e6mr7577592plo.77.1669231026347;
        Wed, 23 Nov 2022 11:17:06 -0800 (PST)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b00177fb862a87sm14920203plg.20.2022.11.23.11.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:17:05 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order (fix)
Date:   Wed, 23 Nov 2022 11:17:02 -0800
Message-Id: <20221123191703.2902079-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123191703.2902079-1-nphamcs@gmail.com>
References: <20221123191703.2902079-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment explaining the mapping check for LRU update.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7dd464b5a6a5..d9bd865047e2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1268,7 +1268,23 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	zspage = get_zspage(page);

 #ifdef CONFIG_ZPOOL
-	/* Move the zspage to front of pool's LRU */
+	/*
+	 * Move the zspage to front of pool's LRU.
+	 *
+	 * Note that this is swap-specific, so by definition there are no ongoing
+	 * accesses to the memory while the page is swapped out that would make
+	 * it "hot". A new entry is hot, then ages to the tail until it gets either
+	 * written back or swaps back in.
+	 *
+	 * Furthermore, map is also called during writeback. We must not put an
+	 * isolated page on the LRU mid-reclaim.
+	 *
+	 * As a result, only update the LRU when the page is mapped for write
+	 * when it's first instantiated.
+	 *
+	 * This is a deviation from the other backends, which perform this update
+	 * in the allocation function (zbud_alloc, z3fold_alloc).
+	 */
 	if (mm == ZS_MM_WO) {
 		if (!list_empty(&zspage->lru))
 			list_del(&zspage->lru);
--
2.30.2
