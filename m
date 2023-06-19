Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5A7350C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFSJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjFSJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:46:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A57139;
        Mon, 19 Jun 2023 02:46:36 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39cf00a2ad2so2207435b6e.1;
        Mon, 19 Jun 2023 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687167996; x=1689759996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0M5oLj5cn7ynWhyyJDuHHDTH0wICAdKxkhUJt5kJHc=;
        b=MdoPbAPSwR7b7ZHnU7rPQrji/p86DMxxBOcQdwaafeW0mO7IwusX0RyrZcOUa8IJ0r
         144wiZzZzDuVvGgQSGUPg45+ybM0VNfKq2PPj2asjI0ZK9j6xH67FfUm3E1QiaN1/N+j
         Tt1pDol1V2yQbtgYzroimkXOshqmHtG/MJfjpp4ix9YRmro2Jh6/uYafKUG7/lQNTWcs
         rtFhBq2t4vmkAoMDdv9ofYpV5phkYek49Lu6hpujLWI4/bBibTaTHmJ4OEZSapg/sasJ
         kxvh2Rp8DZSiJoDCXXgrDWWlRBNAbGw9yqGUv0oL8aqiUZP1uYyTNDsaXspPmgToJLah
         kEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687167996; x=1689759996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0M5oLj5cn7ynWhyyJDuHHDTH0wICAdKxkhUJt5kJHc=;
        b=LoAWlDX2fNVjaJ1w/plsqn0nmbZgCzKXTIcFKeIWUVgdhOBOdu4gu07Z9crxvslqTw
         drxJJQrCUEGCPNQuD0ne6Ml4uYfFqEMbe/a/t0vUHrNaZ1o60GawN19FIiyVQiqDlc1d
         Y3UDwWBJbKwYvWbDPMYMNJVxjJyTSoq1MUVZNHVKQGiapj1JwQgnEUDW9l0Z4iiKkX7e
         O3LmdEQmjsblgl3yOrDsgWbmBo2R0Eqe5GGr16+pW7QyvtLaQesJK4ePptxL4WDTOONR
         ILuOzjq2CDUnAzvVeu3s73BLy4RV5LDujUNL2pd0sWCHARNVzgx8qpJBU54g9Q3xrBIL
         ffxg==
X-Gm-Message-State: AC+VfDyEhyCZxUcsv6qaXZ3e5dsmrvIZcUh64uerL3BUNpl9neW97lQi
        z1uE4adnOEjWEgBnB1JOsJGEknYmuxUKsA==
X-Google-Smtp-Source: ACHHUZ7NKvrtqJyOCIepwrTN3r5GDaBAf9XRFhjuDilngZYdxFCkMdZ4M7palGvv4uT87P+uwtllrw==
X-Received: by 2002:a05:6808:2795:b0:39c:cd8b:61f5 with SMTP id es21-20020a056808279500b0039ccd8b61f5mr6786643oib.13.1687167996133;
        Mon, 19 Jun 2023 02:46:36 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090a72c300b0025930e50e28sm5274582pjk.41.2023.06.19.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:46:35 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH] rcu: Add necessary WRITE_ONCE()
Date:   Mon, 19 Jun 2023 09:46:24 +0000
Message-Id: <20230619094624.205990-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit c54a2744497d("list: Add hlist_unhashed_lockless()") and
commit 860c8802ace1("rcu: Use WRITE_ONCE() for assignments to
->pprev for hlist_nulls") added various WRITE_ONCE() to pair with
the READ_ONCE() in hlist_unhashed_lockless(), but there are still
some places where WRITE_ONCE() was not added, this commit adds that.

Also add WRITE_ONCE() to pair with the READ_ONCE() in hlist_empty().

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 include/linux/list.h          | 6 +++---
 include/linux/list_nulls.h    | 2 +-
 include/linux/rculist_nulls.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index ac366958ea..ef2d895d3c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -912,7 +912,7 @@ static inline void hlist_del(struct hlist_node *n)
 {
 	__hlist_del(n);
 	n->next = LIST_POISON1;
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
@@ -1026,8 +1026,8 @@ static inline void hlist_move_list(struct hlist_head *old,
 {
 	new->first = old->first;
 	if (new->first)
-		new->first->pprev = &new->first;
-	old->first = NULL;
+		WRITE_ONCE(new->first->pprev, &new->first);
+	WRITE_ONCE(old->first, NULL);
 }
 
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index fa6e8471bd..b63b0589fa 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -95,7 +95,7 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
 
 	n->next = first;
 	WRITE_ONCE(n->pprev, &h->first);
-	h->first = n;
+	WRITE_ONCE(h->first, n);
 	if (!is_a_nulls(first))
 		WRITE_ONCE(first->pprev, &n->next);
 }
diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index ba4c00dd80..c65121655b 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -138,7 +138,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 
 	if (last) {
 		n->next = last->next;
-		n->pprev = &last->next;
+		WRITE_ONCE(n->pprev, &last->next);
 		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
 	} else {
 		hlist_nulls_add_head_rcu(n, h);
-- 
2.34.1

