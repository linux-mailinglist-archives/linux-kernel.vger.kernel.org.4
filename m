Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D4605361
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJSWr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJSWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B463E186D70;
        Wed, 19 Oct 2022 15:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64496B825E1;
        Wed, 19 Oct 2022 22:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0562DC4347C;
        Wed, 19 Oct 2022 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=U+1luf3mbgyTSKOMl8vtX4dFmH8rl+GKNY2TDjN1IyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMSKFGEu/uzR3N52gimUSRvlUY77ksX6bwSP5MEEbrhoYubbKoJVO455NMN69R4xj
         x9GRwiRrinWyIWvqcLaI+JhV5ZHw0Ow+vjol3spPlLV+EDFsRspfhySJYB1hNYEyDD
         aSGLKC8qpWBT4nbxwHNQOo7RmG1Z0Y+5PDZjmaBTcnkG3j3YRGb2Ycr+/iXr0GVAM8
         f3R8P+eO4JCLRSgp7mHQtfS9keccHmF/hGloP0UzUPKujvCNZbkgV3dyp0o5SzcWdJ
         GLdFjAAokYxUviKsgseded/9rmE6dJI2yUYwAvyjELLvaU6fXnXMYEQiD9ItgNieST
         uSvkQeYinB1kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AD5D05C0A04; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Subject: [PATCH rcu 5/8] slab: Explain why SLAB_DESTROY_BY_RCU reference before locking
Date:   Wed, 19 Oct 2022 15:46:56 -0700
Message-Id: <20221019224659.2499511-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
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

It is not obvious to the casual user why it is absolutely necessary to
acquire a reference to a SLAB_DESTROY_BY_RCU structure before acquiring
a lock in that structure.  Therefore, add a comment explaining this point.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: <linux-mm@kvack.org>
---
 include/linux/slab.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 90877fcde70bd..446303e385265 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -76,6 +76,12 @@
  * rcu_read_lock before reading the address, then rcu_read_unlock after
  * taking the spinlock within the structure expected at that address.
  *
+ * Note that it is not possible to acquire a lock within a structure
+ * allocated with SLAB_DESTROY_BY_RCU without first acquiring a reference
+ * as described above.  The reason is that SLAB_DESTROY_BY_RCU pages are
+ * not zeroed before being given to the slab, which means that any locks
+ * must be initialized after each and every kmem_struct_alloc().
+ *
  * Note that SLAB_TYPESAFE_BY_RCU was originally named SLAB_DESTROY_BY_RCU.
  */
 /* Defer freeing slabs to RCU */
-- 
2.31.1.189.g2e36527f23

