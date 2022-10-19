Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B210460536B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiJSWwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJSWvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142218E706;
        Wed, 19 Oct 2022 15:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03065619DA;
        Wed, 19 Oct 2022 22:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1870AC43147;
        Wed, 19 Oct 2022 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219907;
        bh=wIrUnsZvsb76w0mrU4ByciwxrnTRBZTUwIx2ZrTZP6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DplQmogbLIlmDKw7nrrkuSAqXJXVs56ONOkM2rhX3C0kvLWKXYoh/417+tAnrpZEH
         /XuVKaH1KLnf6KdOFX2VmVHU1OPwbqZJCUsalOicFa/EQfbFMh8v5UCoAdMzeCxLB/
         IusxzzT3D5rqNr95x3L8lhNofkrHcbYbX19fPfMGLU6vnB6hspmzVYOQLX+0TvgiIv
         OihWC3yew5drgwauQAe4qmjLQ7JdAXWeAfPm2HOu21tWurXsguQLGSqEm53bOZvrlR
         8GTuYwQmOpX2OfLBnKqcqwJHtCXXMYGDFHTPXKQVq1kMk25UIle0wLQ/PrWeIhE/5e
         z62Ggq6tADgvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 844165C0B8F; Wed, 19 Oct 2022 15:51:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/14] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Wed, 19 Oct 2022 15:51:38 -0700
Message-Id: <20221019225144.2500095-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

call_rcu() changes to save power will slow down the percpu refcounter's
"per-CPU to atomic switch" path. The primitive uses RCU when switching to
atomic mode. The enqueued async callback wakes up waiters waiting in the
percpu_ref_switch_waitq. Due to this, per-CPU refcount users will slow down,
such as blk_pre_runtime_suspend().

Use the call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e5c5315da2741..65c58a029297d 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu_flush(&ref->data->rcu,
+		       percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
-- 
2.31.1.189.g2e36527f23

