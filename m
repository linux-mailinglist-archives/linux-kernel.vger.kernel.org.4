Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1633062FCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiKRSZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiKRSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:25:12 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8539BA0A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 4so5311045pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awQN/ZCJSxJ2Bey51fZL37YCVo4g2Qf+pzYIcGHdiWA=;
        b=XHyzobnKe+oOaTjXSZzBJ1qS4nD4Q+36AJReyTdqnyvQbIRh0qPu4d+50B1ntmMX1z
         9D55pqnESb27MCIbC8engqlryb+LhkQQxOGgVxDN95uxG6ebO/zB9CHKuBZJhKT6IHYD
         Cksw1RnIxRkMOjeEWGKU6N/jv0/d8f8ZQC+ZzdTSF29Ols5t9pxDZe4VFtM2b0IdL1WF
         YdqOBimS4bedY5ugdRKIB+KWN4OeGWgdORHmG5y/niC+nJmS59fujKKFpWTEtrmiGarj
         Whfn9Z69Q1Glv6N29+tbeWYSEy5RSTwZz5mg7pNQRE5xmfmayOptcVZzZ2uDdPNEX5pc
         10uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awQN/ZCJSxJ2Bey51fZL37YCVo4g2Qf+pzYIcGHdiWA=;
        b=phPJgjquYmRxinlA8XUU2+l+2jarYalLnYhWpdzosz3p7hem7vKv8x81m2sN3aHy9T
         WSo0jW8jtM9yDj8CPLD3BNg/rQausvJZCxoCeTpy9mcvLoZjxWrTbYZ8trdjKzRLXVI9
         2U80f/p2BTh2/DkDYo8aSaMLmxDyeG6hVzSfpcjV/cH738vSjjoYU4WQ8HOFynxDxYU8
         SI0wguSPtMySD9safm6lHKtMRd+SySfZ8RjIPVyPZNUBd0Othxa83eAmGO99Ghq8HEVn
         A3YGrLh+QRph3GE2zKn3LBXNHaplAO4EELsnubtLZmc3Mym3m01CK/uAl+L967oqqzaz
         zzbA==
X-Gm-Message-State: ANoB5pldUphs9pfTok7Nd7Ky+UMVScai9E/hhPx3UYg+xnCia3/bXhV+
        d2BPSBIVrPZM5MIIy2P8T2z7Iz8oPtmWqQ==
X-Google-Smtp-Source: AA0mqf4Bs4qzn/BWLkoOuMQUMhuLNrB0ijILrtse/uEoJswaJEQJp49VIRhy4MKCa+bzXqsbgm7HFQ==
X-Received: by 2002:a17:902:b613:b0:188:f570:7bd6 with SMTP id b19-20020a170902b61300b00188f5707bd6mr692050pls.97.1668795855932;
        Fri, 18 Nov 2022 10:24:15 -0800 (PST)
Received: from localhost (fwdproxy-prn-011.fbsv.net. [2a03:2880:ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0017f49b41c12sm4051234plh.173.2022.11.18.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:24:15 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v5 5/6] zsmalloc: Add zpool_ops field to zs_pool to store evict handlers
Date:   Fri, 18 Nov 2022 10:24:06 -0800
Message-Id: <20221118182407.82548-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221118182407.82548-1-nphamcs@gmail.com>
References: <20221118182407.82548-1-nphamcs@gmail.com>
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

This adds a new field to zs_pool to store evict handlers for writeback,
analogous to the zbud allocator.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9e7b54324181..3ff86f57d08c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -242,6 +242,8 @@ struct zs_pool {
 #ifdef CONFIG_ZPOOL
 	/* List tracking the zspages in LRU order by most recently added object */
 	struct list_head lru;
+	struct zpool *zpool;
+	const struct zpool_ops *zpool_ops;
 #endif

 #ifdef CONFIG_ZSMALLOC_STAT
@@ -394,7 +396,14 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
 	 * different contexts and its caller must provide a valid
 	 * gfp mask.
 	 */
-	return zs_create_pool(name);
+	struct zs_pool *pool = zs_create_pool(name);
+
+	if (pool) {
+		pool->zpool = zpool;
+		pool->zpool_ops = zpool_ops;
+	}
+
+	return pool;
 }

 static void zs_zpool_destroy(void *pool)
--
2.30.2
