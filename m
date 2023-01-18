Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7D670EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjARAmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjARAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:31 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969273C2A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:47 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id b26-20020a056602331a00b00704cb50e151so2296979ioz.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHUtkzMGrelI8/KMRDpB6ws41Nm9DHo0hzRSbvA1rX4=;
        b=P+dHdTcobETbrT/4Y9RoKNBSMMjBesxNPv628wUhtHtBS5jrH92q0UFgzkKx+jBUcE
         llP4mUbT+FnTKRZni0V7IXBtUy27FnrRbybdJiuJGP3RMYCF0bcFrjXKYSaYVIKZ9ogS
         JzaV1tqb30YMpASHxaQjO19PI+kv5ars13oppxhnN5j89apHzpCwj1YEkNza+2OxNiBd
         7wrcI6tDL6HoGMsQhpsvQW1y7sIhZuHlVtRlKspdAzoE9g6JCgUaAY9kTFMCcr2R5rYn
         jHMYQPorKFLfa+/ENOJni+bMaYbS740iYvYX5M5Qs6/0kiF87294eU0cXrKq7j8h0545
         H4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHUtkzMGrelI8/KMRDpB6ws41Nm9DHo0hzRSbvA1rX4=;
        b=pcXbyxDibhAFapuF765LVr+wDwHmzt2pWsiY3+F1hdGMMhfqf1AU/+f+f1+o6W6NW1
         Fl+TA/LAmQDXJWq1O0i2/hEr8vWFuI4N3MvbusS5TDRIOJm9Ovf6conr0e2e6roueraN
         MUxmQnOc8HL2rZ6vzlvmfw9DcKpNinpNup+48QPqCx1wDdSNlKbbL/ZAmhx0bS0isuo4
         AoVBWx/wz2vz46Y9o1ZVxTw1VSE/syqM2Vp6SuO49r/XxXPBxzLElvNTZZkDyj8L+wqX
         gTN0U6HTTOFspJrfDhudYtCv35hpHN/Ndfd5kCzsEnfibfsL/07dJ9MBhSKqPQiKW1VS
         57yQ==
X-Gm-Message-State: AFqh2kqOn77q0TIq/mt9AQf7EVINLL+TUH4wO+VcUG3tqEE0nWKOq5pu
        przTBIP2aInm0IDSs27H8EjnbXCHk5OpaA==
X-Google-Smtp-Source: AMrXdXvO3k5QPMoTA/WF9Jnxii9iK6RJnQpbjnESwHDAurHbqkPa1FvBFeVLCq6wyGOChzX4emiW+HqkB7neJg==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a05:6638:3b06:b0:38a:adeb:d4d1 with SMTP
 id bb6-20020a0566383b0600b0038aadebd4d1mr562363jab.81.1674001127016; Tue, 17
 Jan 2023 16:18:47 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:25 +0000
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-6-talumbau@google.com>
Subject: [PATCH mm-unstable v1 5/7] mm: multi-gen LRU: improve lru_gen_exit_memcg()
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

Add warnings and poison ->next.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 mm/vmscan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 796d4ca65e97..c2e6ad53447b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6168,12 +6168,17 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 	int i;
 	int nid;
 
+	VM_WARN_ON_ONCE(!list_empty(&memcg->mm_list.fifo));
+
 	for_each_node(nid) {
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
 
+		VM_WARN_ON_ONCE(lruvec->mm_state.nr_walkers);
 		VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
 					   sizeof(lruvec->lrugen.nr_pages)));
 
+		lruvec->lrugen.list.next = LIST_POISON1;
+
 		for (i = 0; i < NR_BLOOM_FILTERS; i++) {
 			bitmap_free(lruvec->mm_state.filters[i]);
 			lruvec->mm_state.filters[i] = NULL;
-- 
2.39.0.314.g84b9a713c41-goog

