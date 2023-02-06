Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E203568C674
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBFTJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBFTJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:09:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348552CFD6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QGN5AwS7ymtlTAXBWB31mdoVyfXpaWKOg13/EzoN+dM=; b=qnLDSZR71L6FiOTli7nBUzPgS0
        ltZt3cnRwEQw0dQ9NOqBmcUyZTzdmxhyN0+MSYof0ZqCfmS5YgqqVEYLFAj8SgARyPG5jErwZijZh
        HqUSKGkzzBGbwmW4nG9/18O+kLZMpAET4VbcoqlZXJddZokz+CZnyjxX5YDT5brOvsfcefz8z1YxR
        a1ubD6CCAYz9qTHRQc0IBuoRATWxZJYzJ/QM4oUzKYmHIxxMFhF8fVFlGoz6b2y2EQXgSwTjXjmAf
        bMOXnmEeuPgF9OLo/Ik+W3Ea2m9vwu6qxN8V1zu/W/5NfXOlyQvK3qM/nz/0FAPG+aa0BEgcWFD5e
        vcheZquw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP6rD-00H0tF-GW; Mon, 06 Feb 2023 19:08:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, mhocko@suse.com, vbabka@suse.cz,
        quic_pkondeti@quicinc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH 3/2] shmem: Fix W=1 build warnings with CONFIG_SHMEM=n
Date:   Mon,  6 Feb 2023 19:08:50 +0000
Message-Id: <20230206190850.4054983-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With W=1, all these functions have no prototypes so the
compiler emits warnings.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d333deddc2b9..b01249e5c827 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -33,6 +33,7 @@
 #include <linux/random.h>
 #include <linux/sched/signal.h>
 #include <linux/export.h>
+#include <linux/shmem_fs.h>
 #include <linux/swap.h>
 #include <linux/uio.h>
 #include <linux/hugetlb.h>
@@ -58,7 +59,6 @@ static struct vfsmount *shm_mnt;
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
-#include <linux/shmem_fs.h>
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/percpu_counter.h>
-- 
2.35.1

