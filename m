Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4673726A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjFTROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjFTRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:13:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E6A1726;
        Tue, 20 Jun 2023 10:13:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b52bf6e659so22620185ad.3;
        Tue, 20 Jun 2023 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281235; x=1689873235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FQVL+8eaCaxsNitQJJf0YFTeFjPE8938pH+IXJDEavY=;
        b=BgPTfp4VPb6Brq698keka1gTnQc7c/3ZzVTj6QAeTMusvfziGWN6FtMN35aBzq3IOf
         qpcwjm/C+dSzrCO7b7gXNX3jkiAg2CJ+AfrHbdKPr2yGVr71uzlUiqPPrT3eXiAqMMHD
         UTGXjYr8ev561lbNB035DKZNoK3IV0sVKWD+aK0jE095BkQhW1w5KqklPyrR8FZeRu2J
         LPOX0td7AsaSilXfGAjXjlzkuMUtKWh5Ykn9DpskMqM6QrUkDMIQgGYybQFk1WlMNMBx
         l92zcvLg/mRIIxFhkTucNSjJhivbcUwpZAwZhklapxLZJ7NEDMtrqcdqOhBVdTwL1wgD
         qdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281235; x=1689873235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQVL+8eaCaxsNitQJJf0YFTeFjPE8938pH+IXJDEavY=;
        b=G2iulcgwKoxgqkYQmIJ7n+GW39oRAnLdgWoDimBVbeN9ns4K9+Qitxjij81U26RvwR
         GjYybqFsVbdPfx8b6Dh6//Xc4CYzxScVInuisgXmihWO1W+dMxcXzlEdDWIC/kj4Xbaz
         IMvfIbx25STZ3VZKeubieNTlROy6DSRE0yuGNQD55L1AfiCB6aiqwJ0AJaLPxWaWRo2y
         /7mO5I6X5YhercSUFJyt2BhbOHD0NNx8IHWq2LRrXFr3ssBWnpSowNbw4GekBFzvF5df
         7ku9ohZkwmH5HUyEvWalG4aVQhEXvR0FzveaE5LxjvC7AaCxpw4/BSi78bieloumK0Dx
         53Rw==
X-Gm-Message-State: AC+VfDxFXQ9X9Y9d56dPjXD6GKI52EyZFh6zihL1oD4G9VetBqr5iBy5
        UEbdPfyJzm5+AYoKQAU39WDh11FMj74=
X-Google-Smtp-Source: ACHHUZ6Q7CLwOGA+Kf6Go7zWJ6Kt6nfcoeQ6H4xJ3c/74pE3v8Xa9XlNRFsjx3hxrr6J408KJ8hrng==
X-Received: by 2002:a17:902:ea01:b0:1ad:e633:ee96 with SMTP id s1-20020a170902ea0100b001ade633ee96mr8123222plg.55.1687281234782;
        Tue, 20 Jun 2023 10:13:54 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902d2cd00b001b1866f7b5csm1872888plc.138.2023.06.20.10.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:13:54 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH v2] rcu: Add necessary WRITE_ONCE()
Date:   Tue, 20 Jun 2023 17:13:46 +0000
Message-Id: <20230620171346.207076-1-mmpgouride@gmail.com>
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
Changelog:
V1 -> V2: 
  Add WRITE_ONCE in hlist_del_init to pair with READ_ONCE in
  hlist_unhashed_lockless.

 include/linux/list.h          | 9 +++++----
 include/linux/list_nulls.h    | 2 +-
 include/linux/rculist_nulls.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index ac366958ea..3a29b95bfe 100644
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
@@ -925,7 +925,8 @@ static inline void hlist_del_init(struct hlist_node *n)
 {
 	if (!hlist_unhashed(n)) {
 		__hlist_del(n);
-		INIT_HLIST_NODE(n);
+		n->next = NULL;
+		WRITE_ONCE(n->pprev, NULL);
 	}
 }
 
@@ -1026,8 +1027,8 @@ static inline void hlist_move_list(struct hlist_head *old,
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

