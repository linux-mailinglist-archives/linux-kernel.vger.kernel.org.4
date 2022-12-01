Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9C63FAB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiLAWkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiLAWkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:40:01 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EA5C4CC5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:52 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id i7-20020a056e021b0700b003033a763270so2046217ilv.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf2mk5xivjN9zWbWWQQFqtvwZGiYn802bc7GbPor4PM=;
        b=i2B3oY+SMRNmEpbZRQCeIbFih6YbvqEnPTFZiN9hVG5t3QOQzoSe+l/KIXrLMGbnNL
         29n9Ia2rDjkSsgbQQ/MxxZuRuAoKqL5eMjD+VlKWwofiK+FR8WEosx0Vd3XcGP7E22+q
         rRIKj1c4MUALlRfm8ECdcukwv7QN74na1G4XdxIZtXZwyL6E89lFK/BVd/HFKxpIQGfW
         ODkb+jcop4TEfW1KOsWqFtRUGakKyAvfCvdFTIoVnw49on8vW4fQhWoPmFnYCCKyQrSv
         8Es0dQQ7c95B5PCBVozQHX2vu0f7iPSQ999hnj8darcm+YBVb07+s3aJwL5X/RYCLX8l
         0G/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf2mk5xivjN9zWbWWQQFqtvwZGiYn802bc7GbPor4PM=;
        b=Oh4mSAJJPcTVKGSHwupjzVzswTRAU2TMZCtf760GwZMggpTSXDVVQV0dBLRXhc020e
         UTEQzRE1rkzrYshtAB8FoIbG8m/ObtF4+zdpVQ1SdQ862S/4Olob8xsMB2S4KYQaA8Lx
         QwTYWrFudtSm9Gll3Bu8MY4Ri78loRLndB2o6MO7z+XhPTb3OAJkZ/lAGqXFgOsPqW+2
         g4pLyKoqPyYeG3OD6DHoCe8m8jDlpt12dAQ4FEothbq2yx2elDXevxL8lKDDoGT67OWh
         tNrBmJ7og6/T8yVzroLdNwqQFNdAaq8wlh5K3DOEz7QytQO7r4A7VGZFKjg6cv6iLHEQ
         7HuA==
X-Gm-Message-State: ANoB5pm3uVAdNic7dPQZcq2qygClXle9QDrWnCkQ6/6jiZ2r7regicJb
        0clwz1hpzC89Wy9XLma2/kxgZqP02lY=
X-Google-Smtp-Source: AA0mqf4WbXEse5Izu5KRISp7nUEqmxo/6ym38RNrOlKYkM8tNbyDlcq5pn65NFJqlpq+5g+VfbZ7eK8zPJs=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a5e:aa07:0:b0:6bc:5d7b:2b9f with SMTP id
 s7-20020a5eaa07000000b006bc5d7b2b9fmr28153947ioe.38.1669934392148; Thu, 01
 Dec 2022 14:39:52 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:24 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 8/8] mm: multi-gen LRU: simplify
 arch_has_hw_pte_young() check
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scanning page tables when hardware does not set the accessed bit has
no real use cases.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 39724e7ae837..5994592c55fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4412,7 +4412,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!force_scan && !(arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))) {
+	if (!arch_has_hw_pte_young() || !get_cap(LRU_GEN_MM_WALK)) {
 		success = iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

