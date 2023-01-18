Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E1670EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjARAnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjARAl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D143BDAC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4d952e13250so175023447b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jALjY0Bdqm1/YesVsEUhs8/Cxbw0KA6q73WmJmcfOK4=;
        b=pX6C/v257+Os4JnZfLWjhxBV0VioyPSdesGvFKMhRi/HOpAYPq96hFce0IJgNobb3f
         2RH/XPSAGyC+3a1jFn0o95RyFf0afCup5DSBmmLZgA3+4x68ZEm3/AiWKPt2dO0SAhs2
         qEKm8jYZbPrYzG4alAYJzfZyA0nxYmHbvumNSkV7f4z7yu3jhN0NtanMPAdCj1/USyGx
         1L4h4tnaeAl/KcXQN6xJTx54BEZhW+49QSN0vQbi0KCGhohYKV9fc+dlLROGMatZSamc
         sO4MmeMwltJif26xvMx8YoX5Nz26pJPF/BhFL5LC2OwAz51Arhjn3iwQbHW7fR73j/xa
         eO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jALjY0Bdqm1/YesVsEUhs8/Cxbw0KA6q73WmJmcfOK4=;
        b=2zfzQrIwHkfyDaemaMz4dcyYpoc267DCNRVe0PJsTC61wvjYXCBCBaBBxUVxWIEEZ4
         oLFGMkXUn7Rqg7DbvCV3fWTvLHQ5Y70RCoiqzTjs9q2p9v/FaLaW5gxDvbXNymEFKXdg
         ic7kYtiwtPa1WhTSxmFke+rmBq9aR8wxI9aiCBnjK0Xm0d9ps9zIdrVQgz5u+lULyq3d
         NaOS0VNLaRwOBckhBlj9F8ui/R0WYsqttvQtbdtg133MlSwTpqbPYQL+Sil7X6M2jizu
         MTEWmAodTLtUcebWbiaLYmbguKm2WEJ090ztbpXvJRE5cYMn9Jf/dCXl6W0vpx/6rWtd
         VCgg==
X-Gm-Message-State: AFqh2kroAdO1jFMfnzayaA6fbVwPNXt9ZJXIrhRu9XpXP92ZPyxuLchG
        dQ3HMTKqDEpvg8bJ9vKF/e+Q6igr5hbZNQ==
X-Google-Smtp-Source: AMrXdXtzbC2enjCfumzv2Oq91nq399MVoLbi+AK4XxL/JTK6ADZ9ziefgILXVLLfQa1YAb/fYw2dRvsw1q4h+w==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a5b:eca:0:b0:7b9:dda1:dd24 with SMTP id
 a10-20020a5b0eca000000b007b9dda1dd24mr542766ybs.339.1674001122864; Tue, 17
 Jan 2023 16:18:42 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:21 +0000
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-2-talumbau@google.com>
Subject: [PATCH mm-unstable v1 1/7] mm: multi-gen LRU: section for working set protection
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
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

Add a section for working set protection in the code and the design
doc. The admin doc already contains its usage.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 Documentation/mm/multigen_lru.rst | 15 +++++++++++++++
 mm/vmscan.c                       |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/mm/multigen_lru.rst b/Documentation/mm/multigen_lru.rst
index d8f721f98868..6e1483e70fdc 100644
--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -141,6 +141,21 @@ loop has detected outlying refaults from the tier this page is in. To
 this end, the feedback loop uses the first tier as the baseline, for
 the reason stated earlier.
 
+Working set protection
+----------------------
+Each generation is timestamped at birth. If ``lru_gen_min_ttl`` is
+set, an ``lruvec`` is protected from the eviction when its oldest
+generation was born within ``lru_gen_min_ttl`` milliseconds. In other
+words, it prevents the working set of ``lru_gen_min_ttl`` milliseconds
+from getting evicted. The OOM killer is triggered if this working set
+cannot be kept in memory.
+
+This time-based approach has the following advantages:
+
+1. It is easier to configure because it is agnostic to applications
+   and memory sizes.
+2. It is more reliable because it is directly wired to the OOM killer.
+
 Summary
 -------
 The multi-gen LRU can be disassembled into the following parts:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 394ff4962cbc..a741765896b6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4475,6 +4475,10 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	return true;
 }
 
+/******************************************************************************
+ *                          working set protection
+ ******************************************************************************/
+
 static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int gen, type, zone;
-- 
2.39.0.314.g84b9a713c41-goog

