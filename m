Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE18E6E2ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDODcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDODcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442119BF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 20:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D271B63869
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52C6C433D2;
        Sat, 15 Apr 2023 03:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681529531;
        bh=+XWziO2ua4unQE9zKFAr0FfsCxROiRZNlP1PEGcC0V4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwTyhhqBaHhovdgbtGcm2bJ6ADe6+zG/8hZF+KwfzHV9UhcaXoTBUvq/WrD+Em6eQ
         F2MyBPLt/BvcmaWeoFkU8CTWH19xDu35N03OrdsVKObBMcbc/WNfxuCrifnqtmp5Dz
         AlaCvGVLRhXZTloldkBT5LFZ0WQVTIMltu4lhd4/mwjX5hPWV3Ra5A4gpY65ALjsHc
         ByiB8zEIvlHLApbU9KjIioeuwc45HvDtZVO+iZQTjgyZw3wajBYcUh8dQ6pMIdB99E
         n8FXPuAkutINB3TChQ7S9lp5W1LeV/VmevI2DwizELzZDEmimaoPbfvOruyR+q9emN
         7UpN8v8nGInSQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, willy@infradead.org, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Sat, 15 Apr 2023 03:31:59 +0000
Message-Id: <20230415033159.4249-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415033159.4249-1-sj@kernel.org>
References: <20230415033159.4249-1-sj@kernel.org>
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

The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
similar example code snippet, and commit da82af04352b ("doc: Update and
wordsmith rculist_nulls.rst") has broken it.  Apply the change to
SLAB_TYPESAFE_BY_RCU example code snippet, too.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/slab.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b18e56c6f06c..6acf1b7c6551 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -53,16 +53,18 @@
  * stays valid, the trick to using this is relying on an independent
  * object validation pass. Something like:
  *
+ * begin:
  *  rcu_read_lock();
- * again:
  *  obj = lockless_lookup(key);
  *  if (obj) {
  *    if (!try_get_ref(obj)) // might fail for free objects
- *      goto again;
+ *      rcu_read_unlock();
+ *      goto begin;
  *
  *    if (obj->key != key) { // not the object we expected
  *      put_ref(obj);
- *      goto again;
+ *      rcu_read_unlock();
+ *      goto begin;
  *    }
  *  }
  *  rcu_read_unlock();
-- 
2.25.1

