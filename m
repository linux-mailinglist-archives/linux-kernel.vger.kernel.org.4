Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2586F7170A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjE3WYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjE3WYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:24:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A04BE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:24:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d341bdedcso3693229b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685485481; x=1688077481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/1SowEewql6UJanqoqPfCeIbhtfTWUbi0a35Y9vIrs=;
        b=WnGpKbOV8lvKv65POyTi6fFpPciJnn2J218zZF6h2JBge30QnWdNUvnzUrtIt8UgnZ
         2eW1iZOQ2Tt2wXfrF2sy9wyLOHpdabbOEbVJDs3E75P65V7vvOuV1Ux5MwkFcjkLY7Xz
         Bu7uKz5n+vefnTqjV1nadY4GfOrsQ0Uw+HjVXvDl4I0StS513zWcuXQq5eVL+/MlwMXu
         8F2l0wObfSk2UsB5Dk9tPoBRFXwVKzqv8ZWdz8aH6tf7AsfQAloacKm3lmKE+Xj2uWJv
         Govc/74/GHTR45rriTat2bDrmCYoFbabV+xQ/5N+eZDgjJPHDFFE+TLtd0w9u57QaQJX
         anMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485481; x=1688077481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/1SowEewql6UJanqoqPfCeIbhtfTWUbi0a35Y9vIrs=;
        b=Wi4vTEZqfoUospKaG69FJmR3EjGWeXsdkmZxIyQrmMpJH478qxc4/mo7ZZHhXclpEJ
         izadwWMA6T9lE4peiJLS/2hZMVTO3yZ2Eg8qAgBGqxJ7Lma70g3F2Bimd7wQ04jgCoXN
         BQJGxc56MWCTok3Rhl5RVo7nyJs8Likg99niCTFRwL32+2vheCVDMYH81aD1y1nJ5/ES
         OwCllHzYwnpwFE8+TwriiJlEDaUfXA6qZjNbKowh04ENONpZGqnB14yeiP+QubQa7Faw
         xjTcDooOs45Tr1HIKpDX1YmegThv29PfuP3K4HzG1DRS5jNOAt32Ph115ANxA4rcD4V1
         20jA==
X-Gm-Message-State: AC+VfDzx+vXr5A+Qa9m/vnyTdOoPIQfJYBEFxIrJWMKLhK+Ucjp2AX/r
        13xEEis4Em29RxaHNT7uPik=
X-Google-Smtp-Source: ACHHUZ7o0vAxUBMoiek8AqoGTNtUZ009NsT2LcERUfQxIOYsAOkRZBMLNu4fP80xpI5LAqDbmuIFpQ==
X-Received: by 2002:a17:902:e74f:b0:1b0:2658:db00 with SMTP id p15-20020a170902e74f00b001b02658db00mr4629006plf.31.1685485481413;
        Tue, 30 May 2023 15:24:41 -0700 (PDT)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001a212a93295sm1719203plg.189.2023.05.30.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:24:41 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@meta.com
Subject: [PATCH] zswap: do not shrink if cgroup may not zswap
Date:   Tue, 30 May 2023 15:24:40 -0700
Message-Id: <20230530222440.2777700-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKEwX=PrqV+cCGmdTcFPMqP-48Y=abQTkSOUzJnOWWpc4rR4cA@mail.gmail.com>
References: <CAKEwX=PrqV+cCGmdTcFPMqP-48Y=abQTkSOUzJnOWWpc4rR4cA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before storing a page, zswap first checks if the number of stored pages
exceeds the limit specified by memory.zswap.max, for each cgroup in the
hierarchy. If this limit is reached or exceeded, then zswap shrinking is
triggered and short-circuits the store attempt.

However, since the zswap's LRU is not memcg-aware, this can create the
following pathological behavior: the cgroup whose zswap limit is
reached will evict pages from other cgroups continually, without
lowering its own zswap usage. This means the shrinking will continue
until the need for swap ceases or the pool becomes empty.

As a result of this, we observe a disproportionate amount of zswap
writeback and a perpetually small zswap pool in our experiments, even
though the pool limit is never hit.

This patch fixes the issue by rejecting zswap store attempt without
shrinking the pool when obj_cgroup_may_zswap() returns false.

Fixes: f4840ccfca25 ("zswap: memcg accounting")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..cff93643a6ab 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1174,9 +1174,14 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		goto reject;
 	}
 
+	/*
+	 * XXX: zswap reclaim does not work with cgroups yet. Without a
+	 * cgroup-aware entry LRU, we will push out entries system-wide based on
+	 * local cgroup limits.
+	 */
 	objcg = get_obj_cgroup_from_page(page);
 	if (objcg && !obj_cgroup_may_zswap(objcg))
-		goto shrink;
+		goto reject;
 
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
-- 
2.34.1

