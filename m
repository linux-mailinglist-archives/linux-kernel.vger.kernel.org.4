Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358C65E158
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjAEAKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjAEAJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:09:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC343A1C;
        Wed,  4 Jan 2023 16:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E396188D;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7A4C433D2;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=PS7RJ6ca0uDsIciwHIe/Mb/Re+MAuOv96kNuEUv2OMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoS72ule2hem61lv95M9JtiH09qkzU0Hj+5layKP/VVObizNp1Qa758AhEzAY+c2H
         4ci22oFx051LnFLTWeEMlh62giV84SNZwwxe/9AQ48PJjgmLeL3A1udcDgovMaMQs3
         jokz193nPTkox7VXTabjpZyxqgUCB+BK+uJTuXSBOZWW0wD/d/qAihab4tCepYrx12
         cO52GjTe/8nByNjeAMAKT5mYFiRokf8sxZFWhlTmbiG1VBrSh+zkGZbyf4Mi87AzBZ
         zV/qn3Zz4cwczFI6Zc/LOWyKcMPqzk7sDoQqCPhYe/istlvax/utbJfbzkVrjYlHON
         l4RS4Q0QPW49g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C36105C05CA; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/15] doc: Further updates to RCU's lockdep.rst
Date:   Wed,  4 Jan 2023 16:09:41 -0800
Message-Id: <20230105000955.1767218-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
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

This commit wordsmiths RCU's lockdep.rst.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/lockdep.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
index 9308f1bdba05d..2749f43ec1b03 100644
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -69,9 +69,8 @@ checking of rcu_dereference() primitives:
 		value of the pointer itself, for example, against NULL.
 
 The rcu_dereference_check() check expression can be any boolean
-expression, but would normally include a lockdep expression.  However,
-any boolean expression can be used.  For a moderately ornate example,
-consider the following::
+expression, but would normally include a lockdep expression.  For a
+moderately ornate example, consider the following::
 
 	file = rcu_dereference_check(fdt->fd[fd],
 				     lockdep_is_held(&files->file_lock) ||
@@ -97,10 +96,10 @@ code, it could instead be written as follows::
 					 atomic_read(&files->count) == 1);
 
 This would verify cases #2 and #3 above, and furthermore lockdep would
-complain if this was used in an RCU read-side critical section unless one
-of these two cases held.  Because rcu_dereference_protected() omits all
-barriers and compiler constraints, it generates better code than do the
-other flavors of rcu_dereference().  On the other hand, it is illegal
+complain even if this was used in an RCU read-side critical section unless
+one of these two cases held.  Because rcu_dereference_protected() omits
+all barriers and compiler constraints, it generates better code than do
+the other flavors of rcu_dereference().  On the other hand, it is illegal
 to use rcu_dereference_protected() if either the RCU-protected pointer
 or the RCU-protected data that it points to can change concurrently.
 
-- 
2.31.1.189.g2e36527f23

