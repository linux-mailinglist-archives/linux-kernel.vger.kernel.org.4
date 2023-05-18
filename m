Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F010708BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjERWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjERWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D08E6E;
        Thu, 18 May 2023 15:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96DFB65290;
        Thu, 18 May 2023 22:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D96CC4339C;
        Thu, 18 May 2023 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684449621;
        bh=mYcPMMrN9V5gypfz26UfLD+vMchASHDokjM0vkhV+Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucL2a7MgZPPqtpXsUTgCswQPPRnexmjCSgdKfPjcP9HjKQ6yaF9WpZbAaPDPjRry9
         3uskc28qepqVcPcSg1/M6GwpDedvHESb98wt74Sc+YnspeuSz6Yrmxws30HPnO5JjU
         XeOTyqZqf7wyLLYouBMz2jaJogzjHzMsmpq86e1WDoOii2tmUpLux40hFMBQaZKbYI
         Yw+ze0IEjJfdpQYuqXX4HaY/DxINFLsl2Xn7PC18tHnClFpWIvbj2voBBQKBpDOMiA
         iV6xC4AZkXsJmSzoczNly6SzZXlp7oWaiDzHmxbOY1+I5BkiuyXXxDMTKHuRuWD8/l
         0T3wu7dtCsPOQ==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release' in insert function
Date:   Thu, 18 May 2023 22:40:08 +0000
Message-Id: <20230518224008.2468-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518224008.2468-1-sj@kernel.org>
References: <20230518224008.2468-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document says we can avoid extra smp_rmb() in lockless_lookup() and
extra _release() in insert function when hlist_nulls is used.  However,
the example code snippet for the insert function is still using the
extra _release().  Drop it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 5cd6f3f8810f..463270273d89 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -191,7 +191,7 @@ scan the list again without harm.
   obj = kmem_cache_alloc(cachep);
   lock_chain(); // typically a spin_lock()
   obj->key = key;
-  atomic_set_release(&obj->refcnt, 1); // key before refcnt
+  atomic_set(&obj->refcnt, 1);
   /*
    * insert obj in RCU way (readers might be traversing chain)
    */
-- 
2.25.1

