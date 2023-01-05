Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8374465E199
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjAEAc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbjAEAcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D374FD4B;
        Wed,  4 Jan 2023 16:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7DE1B81984;
        Thu,  5 Jan 2023 00:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C873C433D2;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=1LNPYk/plPXNlFnuovvyogqzxOAutR+ylSGMQGrM1D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuMQrHBuIxpBgtrUUXClaJUz1+I0XHg5q1K8LW8f174CvCiBYmhc82InfC5Bep0HG
         +7cVbPY2f8Bd2FRy+LIH+QSycwHU6l/ubgHBHPRm5X/E6Cae99Tp0TcrJNT+n0eLWj
         Pu4IeQCarw+MwFgRuFLx+7vK1wtmyfDEPchyYRKaoZpQXFQ6E+C/qNBsmh5dxoJZTR
         FNX7eKLreEDxu0Vd126iVhfh90XRfs2uQKv0Qc09TuwAoyBYsUNBz6Wjx+c5VqVY9x
         Ymm3/DMbSCIFXhLdnbwhYJViz3dSwyfCqRPguHsTetC8Q2aKKtxDHvnW3SFcQlMnUm
         /S4hAUcXY/6yQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4CD785C149B; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH rcu 5/9] rcu: Add srcu_down_read() and srcu_up_read()
Date:   Wed,  4 Jan 2023 16:28:49 -0800
Message-Id: <20230105002853.1769401-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pair of matching srcu_read_lock() and srcu_read_unlock() invocations
must take place within the same context, for example, within the same
task.  Otherwise, lockdep complains, as is the right thing to do for
most use cases.

However, there are use cases involving asynchronous I/O where the
SRCU reader needs to begin on one task and end on another.  This commit
therefore supplies the semaphore-like srcu_down_read() and srcu_up_read(),
which act like srcu_read_lock() and srcu_read_unlock(), but permitting
srcu_up_read() to be invoked in a different context than was the matching
srcu_down_read().

Neither srcu_down_read() nor srcu_up_read() may be invoked from an
NMI handler.

Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/srcu.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 9b9d0bbf1d3cf..74796cd7e7a9d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -214,6 +214,34 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 	return retval;
 }
 
+/**
+ * srcu_down_read - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter a semaphore-like SRCU read-side critical section.  Note that
+ * SRCU read-side critical sections may be nested.  However, it is
+ * illegal to call anything that waits on an SRCU grace period for the
+ * same srcu_struct, whether directly or indirectly.  Please note that
+ * one way to indirectly wait on an SRCU grace period is to acquire
+ * a mutex that is held elsewhere while calling synchronize_srcu() or
+ * synchronize_srcu_expedited().  But if you want lockdep to help you
+ * keep this stuff straight, you should instead use srcu_read_lock().
+ *
+ * The semaphore-like nature of srcu_down_read() means that the matching
+ * srcu_up_read() can be invoked from some other context, for example,
+ * from some other task or from an irq handler.  However, neither
+ * srcu_down_read() nor srcu_up_read() may be invoked from an NMI handler.
+ *
+ * Calls to srcu_down_read() may be nested, similar to the manner in
+ * which calls to down_read() may be nested.
+ */
+static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
+{
+	WARN_ON_ONCE(in_nmi());
+	srcu_check_nmi_safety(ssp, false);
+	return __srcu_read_lock(ssp);
+}
+
 /**
  * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
@@ -254,6 +282,23 @@ srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
 	__srcu_read_unlock(ssp, idx);
 }
 
+/**
+ * srcu_up_read - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock().
+ *
+ * Exit an SRCU read-side critical section, but not necessarily from
+ * the same context as the maching srcu_down_read().
+ */
+static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
+	__releases(ssp)
+{
+	WARN_ON_ONCE(idx & ~0x1);
+	WARN_ON_ONCE(in_nmi());
+	srcu_check_nmi_safety(ssp, false);
+	__srcu_read_unlock(ssp, idx);
+}
+
 /**
  * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
  *
-- 
2.31.1.189.g2e36527f23

