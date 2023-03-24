Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108366C747E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCXAUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCXAT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F972D174;
        Thu, 23 Mar 2023 17:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1116292F;
        Fri, 24 Mar 2023 00:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF4C4339B;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=4rd83tdZ5NNo2vvnVsKePCSQIIPMOL6CP78Y+oTke8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmlRlA7W5p/wwSxQ6XMac/me0inaXakFPYzNL6YG+CoWtWMc/U7os7JWF9cRUozHJ
         TYvx4qJ/O6FAAIYhZzMBkmaiT3mFBxE7IpYHnYLsMHIc0OAnS2+uaU8CnbS0FbQjfq
         NZB5TM+4SIQG5kkalKO2YoCuFXt7ToBzraKaV43Ain2ECE1bAQKlc60xWEKUGHuTx8
         lxyfqgfk53YjI61sla9+9IulzO7h0DzRuNofruhQLifUBvYUsYRHoq35FFk3a4zRJb
         mZUjUnalQDWOGakEFde3WIwcpodbScLvpIY9TBAprppmKOek0AZqQZsyTqz/3tCtgK
         RHaugZziaQs/g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CADDC15403AC; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 19/19] srcu: Remove extraneous parentheses from srcu_read_lock() etc.
Date:   Thu, 23 Mar 2023 17:19:38 -0700
Message-Id: <20230324001938.3443499-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes extraneous parentheses from srcu_read_lock(),
srcu_read_lock_nmisafe(), srcu_read_unlock(), and
srcu_read_unlock_nmisafe().  Looks like someone was once a macro.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 include/linux/srcu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 41c4b26fb1c1..eb92a50a4599 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -212,7 +212,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 
 	srcu_check_nmi_safety(ssp, false);
 	retval = __srcu_read_lock(ssp);
-	srcu_lock_acquire(&(ssp)->dep_map);
+	srcu_lock_acquire(&ssp->dep_map);
 	return retval;
 }
 
@@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 
 	srcu_check_nmi_safety(ssp, true);
 	retval = __srcu_read_lock_nmisafe(ssp);
-	rcu_lock_acquire(&(ssp)->dep_map);
+	rcu_lock_acquire(&ssp->dep_map);
 	return retval;
 }
 
@@ -284,7 +284,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_nmi_safety(ssp, false);
-	srcu_lock_release(&(ssp)->dep_map);
+	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock(ssp, idx);
 }
 
@@ -300,7 +300,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_nmi_safety(ssp, true);
-	rcu_lock_release(&(ssp)->dep_map);
+	rcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_nmisafe(ssp, idx);
 }
 
-- 
2.40.0.rc2

