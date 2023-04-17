Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494AF6E4F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDQRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjDQRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDDAF2C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35CC56103E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55B4C433D2;
        Mon, 17 Apr 2023 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681752767;
        bh=HHLa39ETA/u3pWI5BL6sseaRF5jWhnYjA/pmy+XNmas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzjfofkQ+pPoF44cYauKQrtJKclwDdX4CpSvOCuVuJT+h12RpH2N42m6iz5Cq8D5Z
         9p+gTbRcDwF4FSF4jSwBJwI7+2QS/nzO3nEXhVb6Thi3LlJku/EwgVcECSZuRe7Ddl
         NthKPqW80SkXjBNT2hXuLvUyA4mS+LgRC/MachFhcEgajUP0exf/X0+PwJ5V69sJrz
         sRYa7ngGRmX3N04NuLePX9INExZaGB++Z57ocFPrMZM4/yZIWfz029dGD7lVqwa+q4
         ZftOqD4ytBsZcutFWN8cFSrp2Tn/FAOnrSHsdeyaLPPmLd1DAea9dfrfWCfhR2MUgg
         Z+FKOP2mO56BA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, vbabka@suse.cz, willy@infradead.org,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Mon, 17 Apr 2023 17:32:38 +0000
Message-Id: <20230417173238.22237-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417173238.22237-1-sj@kernel.org>
References: <20230417173238.22237-1-sj@kernel.org>
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

The SLAB_TYPESAFE_BY_RCU example code snippet uses a single RCU
read-side critical section for retries.
'Documentation/RCU/rculist_nulls.rst' has similar example code snippet,
and commit da82af04352b ("doc: Update and wordsmith rculist_nulls.rst")
has broken it up.  Apply the change to SLAB_TYPESAFE_BY_RCU example code
snippet, too.

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

