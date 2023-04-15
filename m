Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8A6E2DF8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjDOAiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDOAiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E68728A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 682F164B49
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 00:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645CEC4339E;
        Sat, 15 Apr 2023 00:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681519087;
        bh=W5jwPfe3GbEvKKWR+zzbHPFAxqpHbCJnsJu/eHhmiUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQRUhO4Bt8p+Np1+9FS1Nj59CKTjCe8d9cnYKb6XZIsxMJUvxQhlHqae65OBMzA8i
         YWxisIEN6YNPNQvLj6G37HMUZTY7tRxwBN1uF82A6lMjKhJePduP9R17bWwzMCe/BE
         ptkG6Y51I5W+H9FPwRHsxkrSAvMw09GqeW33UPuxkSS+B5VJ6IdKDS4eojDfI/B6SR
         7df4wPUhmy89w/FJ6JElwUCRboQriSjJ7HfIn9SM/8d/nDocjPX+R/58DPU4z+n9eV
         nRbK/ZxHc96n67ElviO+PHvWU86xxYfwHjoj4sC7/bQPCaqKOBp6h9gAOLHigyhV2B
         U4VN8mBVyqrOQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Sat, 15 Apr 2023 00:37:53 +0000
Message-Id: <20230415003754.1852-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415003754.1852-1-sj@kernel.org>
References: <20230415003754.1852-1-sj@kernel.org>
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
 include/linux/slab.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b18e56c6f06c..a2fd57322c9c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -53,15 +53,16 @@
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
+ *      goto begin;
  *
  *    if (obj->key != key) { // not the object we expected
  *      put_ref(obj);
+ *      rcu_read_unlock();
  *      goto again;
  *    }
  *  }
-- 
2.25.1

