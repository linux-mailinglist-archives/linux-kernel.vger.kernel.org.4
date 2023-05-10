Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2166FE2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEJQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjEJQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EEB9C;
        Wed, 10 May 2023 09:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E92F63F2F;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFD6C433EF;
        Wed, 10 May 2023 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737913;
        bh=w0ne2UEEwb1HXO/hog3r2ij7PcPs9e+mZYY78+weSf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4I+TNIM/LFj0At87OTvDGe8F5jYXUYn3932b/WhEKaSwLLJdqJclULahRC58qInM
         G8Qns7WhbE1BHPRwTj/PI+S86sIp/Q1bS+us7JGUMvep2l0JLsg3ls0C4pcDphzv5N
         4OVCT+Tf974fkEOcl+fU8awmV0wtt/X6c7p0N9/PVF85nvGLRh7VT5T0CUYqQmI64p
         7X8Sd5+Xl5ijfAXbNWvul8RiB0rfQgaAe/RiOhgsV7RUnQBTDx/xR/9mXxB+jK61c5
         gbZmFZhon1pUyNPZNNXp4chw8+dZuc+Fpwz9uEBhqm9otPb3STjn6fr1wvkkuZRxjE
         dOsnidVPjUMOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8856CCE126E; Wed, 10 May 2023 09:58:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 1/8] srcu: Remove extraneous parentheses from srcu_read_lock() etc.
Date:   Wed, 10 May 2023 09:58:25 -0700
Message-Id: <20230510165832.2187453-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
References: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes extraneous parentheses from srcu_read_lock(),
srcu_read_lock_nmisafe(), srcu_read_unlock(), and
srcu_read_unlock_nmisafe().  Looks like someone was once a macro.

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.40.1

