Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFB652A58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiLUANg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiLUAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:12:50 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B8201AC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3b102317668so160931177b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XaREnfCRyQU3ad5Wd1iK/L1d7XHMzN1hNI71g9W9Aqc=;
        b=K59wK9Xmrz3Bi5vvMVhN1G0pDO7CebJ60f+DjHwvBqntIUvRaRf11KCBF3IsW1uuCm
         LmdCEuyR6sl4QvqXqpqJlFmXBaasCbZ9nmXW6MTluImHgbKMWTiBxrs1SJxF+2QwuG8Y
         n3lT/WRDW8kZrenttBA6PiXNPTJQt4eM3DyDoOliigATORAsfTFpRCXSul0pGuAI9MlF
         xvpQD3dmjMzt8YndE3tmefxjvQ2G/DucE0e/w5OXs/Vyk/ThipPMV2jWTndUm75lJJeN
         Y5SOmz71wirINtVmmU6GITMwX4RwAhx/qeWMh267Z+OXa2GTQYBVO7aJK80W77QZ+2mh
         Zn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaREnfCRyQU3ad5Wd1iK/L1d7XHMzN1hNI71g9W9Aqc=;
        b=Nnz/KOgZ+1tJNMTPj2GK25bCczu3tpBcIXUl7ft4Wxh0LUqv1GJVexrHDzFS9teHXV
         2TS4XxJS1uA6t+hk357b1ozkwNeTsKZImBEUeJ94c5K7wcIe8rysDT4W5hK/doZF1Wud
         5jLqW5BgEDzcqiIsu/YnojNow3ucyjIlwyqm8tKiE3FEhrlSy8s734YZFSrm/7wX9r4b
         1VDUGLcsdO9C3D+hKNogwFGYW0fRSkdz1LTNs0u3t9lIWf2qNf5wD9SZ9mASfS8vKplc
         KrTvJeOWivoCJSn6RzFEoOjebsl5peoD7EhmInc4iYqFgFPY4k1H/dgb4IdlyxWvbREU
         QJIw==
X-Gm-Message-State: AFqh2kp6VpLQ6jIvZxtW2OPocxZwheeFAJGSaPW5sPTs20cU/QT3E/Yb
        CQQWlQPL+t/wkuCZArkduzOyOYDxkbQ=
X-Google-Smtp-Source: AMrXdXur6oRo558EHTCVqmu2nmkUYNqNZaoP17m0xPtqeSBL8ltbKO3K5SoD9CmsnhBaHILyzV33vTOZCRs=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a589:30f2:2daa:4ab7])
 (user=yuzhao job=sendgmr) by 2002:a0d:cbd7:0:b0:388:7d2:575d with SMTP id
 n206-20020a0dcbd7000000b0038807d2575dmr768501ywd.21.1671581566428; Tue, 20
 Dec 2022 16:12:46 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:12:08 -0700
In-Reply-To: <20221221001207.1376119-1-yuzhao@google.com>
Message-Id: <20221221001207.1376119-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20221221001207.1376119-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 8/8] mm: multi-gen LRU: simplify
 arch_has_hw_pte_young() check
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
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
Change-Id: I414310f1cf642d305a16045518517f09ce0eda23
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 308c3c16d81d..88948f4c8d18 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4430,7 +4430,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!force_scan && !(arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))) {
+	if (!arch_has_hw_pte_young() || !get_cap(LRU_GEN_MM_WALK)) {
 		success = iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

