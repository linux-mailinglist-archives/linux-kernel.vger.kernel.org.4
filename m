Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9759D65CFF1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjADJva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjADJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:50:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7234C13DE3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:50:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jn22so35336496plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXu4eopB6IErZbHfllRnsHuODa6KsYR3AQ1R//XwFrg=;
        b=dm6bFou26k5Xmbtzuh722dWOfKUCn9EjjmCxyrgJvZjxV2+tAP3w1l8CH30ZhYSTwT
         pOr2GSaM1kD6Yv6FyCeGUD/MbuzxodJzZUO3RYWoWCqG0qAWn+iHlVN5Ws4iqFy+Xyxp
         s0q77LwOoJhfmdgUXuyKg1n/uuBI5DX5FJehdpD5myz9Qt/TpjolqhKYlyz3WjmqSx1a
         RYtVFyzvNyJhjxx76C5yj2oJsoqbNSZis5HKpmjVGL0JTN+7XpCXR3oimnCOnbvWGABx
         TVOiUGqoEO5uRmZX2egBR1l4kHUWU0jj0poJhrRLTfd4iGxBsuORw+gdabmrDATcvP/I
         UEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXu4eopB6IErZbHfllRnsHuODa6KsYR3AQ1R//XwFrg=;
        b=WNwNX8jrcwT3KayPswpetpAdNLjkITcGJmgGj8lbrmPSSbbaT7DJclnouLk1cUy4b3
         /BJ/I/EjxhojxLcvMamLc8F5UWPRLi7vf6lqsvtilg/XTN3eJqbJxTrSfbn0tc+YGDKM
         JcRCr/KgfMd4p3j170Kr/YTM9pq/G+/dwrb89MZe5f6a+mTvnGAe+a62UICGSgRFXmza
         Nk0Y+Rkn5+oph1HjqPtJ1fAaGNd4U77f3BW1bF5on+ftNmFsvRr4G9tXLe7pD0hHEzuq
         mKRmh2UPS+Wpm6/KevVunToeZPzlKd25BZHz6/JQU1oVq8+jpATQULIP17waFNuT4u21
         9CDA==
X-Gm-Message-State: AFqh2kp7mLK9l4+BHWm8atGW4/klFNhICfAwgNj7VN+SByB87JPf14cZ
        mC4zEk2dq1QZLtk2naRP2tc=
X-Google-Smtp-Source: AMrXdXvf7gKzJJJmVg20ucN67VJRlaqLHtOTMTvKJn4Yt3aDPjPBGu9ug2hb2tFrhpD62w4PJsonkw==
X-Received: by 2002:a17:90b:4c0f:b0:225:eb4b:222f with SMTP id na15-20020a17090b4c0f00b00225eb4b222fmr33844364pjb.45.1672825855885;
        Wed, 04 Jan 2023 01:50:55 -0800 (PST)
Received: from localhost.localdomain ([118.235.15.65])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b002260c751b00sm13102610pjf.23.2023.01.04.01.50.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Jan 2023 01:50:55 -0800 (PST)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] [PATCH] memblock: Fix return sizeless candidate on __memblock_find_range_top_down.
Date:   Wed,  4 Jan 2023 18:50:49 +0900
Message-Id: <20230104095049.59043-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__memblock_find_range_top_down can return start address of free region
which sizeless then user speicified.
To prevent the above case, add size check on candidate free region.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..710e2ef8d67d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -262,7 +262,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
 			continue;
 
 		cand = round_down(this_end - size, align);
-		if (cand >= this_start)
+		if (cand >= this_start && this_end - cand >= size)
 			return cand;
 	}
 
-- 
2.35.1

