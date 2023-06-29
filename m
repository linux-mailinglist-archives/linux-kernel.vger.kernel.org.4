Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936AF742981
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjF2PYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjF2PYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:24:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4822961;
        Thu, 29 Jun 2023 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688052244; x=1719588244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vFwKj/X1T0Mik3UGZNrcERWLJ/HF06IVw/0PejdyHC0=;
  b=PbiCzo7bnTknV+mEPfyF3nK82HHEYuJAPvThMJOAG7vPlgP0blSD3M6i
   W3JrACIRi5MQVeTMiYgq119NVn44v1FzgjKUFsWc4HfCpPopc3yw6UutL
   e7n5yQECEdL0zn+WcAT1em7NbPdsj7EFdBo8JFVqcUQdTV9YNmH0trNxQ
   RAWYHbBZ1j9q8I67okbSY0Ts3PaWcOBjgVSmJhVu1pn4+oVz1qBOosGW8
   gaKrh07Abqh0qMQ/DOuFXC8twf4rtww5RN8N6Wt9k9snXoV78RYgOQ6I/
   eebrn7ZUE+pF/4wQAK74iW0cu/Gl5sDtGSrUppnKQ+1qYJq7qOpCqo3HZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="346920631"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="346920631"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830573840"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="830573840"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2023 08:24:00 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 3/4] net: add flag to indicate NAPI/GRO is running right now
Date:   Thu, 29 Jun 2023 17:23:04 +0200
Message-ID: <20230629152305.905962-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629152305.905962-1-aleksander.lobakin@intel.com>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there's no easy way to check if a NAPI polling cycle is
running and on which CPU, although this might come very handy in
several cases.
Commit 8c48eea3adf3 ("page_pool: allow caching from safely localized
NAPI") added napi_struct::list_owner, BUT it's set when the NAPI is
*scheduled*. `->list_owner == smp_processor_id()` doesn't mean we're
inside the corresponding polling loop.
Introduce new NAPI state flag, NAPI{,F}_STATE_RUNNING. Set it right
before calling to ->poll() and clear after all napi_gro_flush() and
gro_normal_list() are done. They are run in the same context and, in
fact, are part of the receive routine.
When `packets == budget`, napi_complete_done() is not called, so in
that case it's safe to clear the flag after ->poll() ends. Otherwise,
however, napi_complete_done() can lead to reenabling interrupts and
scheduling the NAPI already on another CPU. In that case, clear the
flag in napi_complete_done() itself.
The main usecase for the flag is as follows:

	if (test_bit(NAPI_STATE_RUNNING, &n->state) &&
	    READ_ONCE(n->list_owner) == smp_processor_id())
		/* you're inside n->poll() or the following GRO
		 * processing context
		 */

IOW, when the condition is true, feel free to use resources protected
by this NAPI, such as page_pools covered by it, percpu NAPI caches etc.
Just make sure interrupts are enabled.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..db3aea863ea9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -389,6 +389,7 @@ enum {
 	NAPI_STATE_PREFER_BUSY_POLL,	/* prefer busy-polling over softirq processing*/
 	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
+	NAPI_STATE_RUNNING,		/* This NAPI or GRO is running on ::list_owner */
 };
 
 enum {
@@ -402,6 +403,7 @@ enum {
 	NAPIF_STATE_PREFER_BUSY_POLL	= BIT(NAPI_STATE_PREFER_BUSY_POLL),
 	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
+	NAPIF_STATE_RUNNING		= BIT(NAPI_STATE_RUNNING),
 };
 
 enum gro_result {
diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..7f0d23c9e25e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6039,7 +6039,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 
 		new = val & ~(NAPIF_STATE_MISSED | NAPIF_STATE_SCHED |
 			      NAPIF_STATE_SCHED_THREADED |
-			      NAPIF_STATE_PREFER_BUSY_POLL);
+			      NAPIF_STATE_PREFER_BUSY_POLL |
+			      NAPIF_STATE_RUNNING);
 
 		/* If STATE_MISSED was set, leave STATE_SCHED set,
 		 * because we will call napi->poll() one more time.
@@ -6128,6 +6129,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool
 	/* All we really want here is to re-enable device interrupts.
 	 * Ideally, a new ndo_busy_poll_stop() could avoid another round.
 	 */
+	set_bit(NAPI_STATE_RUNNING, &napi->state);
 	rc = napi->poll(napi, budget);
 	/* We can't gro_normal_list() here, because napi->poll() might have
 	 * rearmed the napi (napi_complete_done()) in which case it could
@@ -6135,8 +6137,10 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool
 	 */
 	trace_napi_poll(napi, rc, budget);
 	netpoll_poll_unlock(have_poll_lock);
-	if (rc == budget)
+	if (rc == budget) {
 		__busy_poll_stop(napi, skip_schedule);
+		clear_bit(NAPI_STATE_RUNNING, &napi->state);
+	}
 	local_bh_enable();
 }
 
@@ -6186,9 +6190,11 @@ void napi_busy_loop(unsigned int napi_id,
 			have_poll_lock = netpoll_poll_lock(napi);
 			napi_poll = napi->poll;
 		}
+		set_bit(NAPI_STATE_RUNNING, &napi->state);
 		work = napi_poll(napi, budget);
 		trace_napi_poll(napi, work, budget);
 		gro_normal_list(napi);
+		clear_bit(NAPI_STATE_RUNNING, &napi->state);
 count:
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
@@ -6457,6 +6463,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	 */
 	work = 0;
 	if (test_bit(NAPI_STATE_SCHED, &n->state)) {
+		set_bit(NAPI_STATE_RUNNING, &n->state);
 		work = n->poll(n, weight);
 		trace_napi_poll(n, work, weight);
 	}
@@ -6466,7 +6473,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 				n->poll, work, weight);
 
 	if (likely(work < weight))
-		return work;
+		goto out;
 
 	/* Drivers must not modify the NAPI state if they
 	 * consume the entire weight.  In such cases this code
@@ -6475,7 +6482,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	 */
 	if (unlikely(napi_disable_pending(n))) {
 		napi_complete(n);
-		return work;
+		goto out;
 	}
 
 	/* The NAPI context has more processing work, but busy-polling
@@ -6488,7 +6495,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 			 */
 			napi_schedule(n);
 		}
-		return work;
+		goto out;
 	}
 
 	if (n->gro_bitmask) {
@@ -6506,11 +6513,15 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	if (unlikely(!list_empty(&n->poll_list))) {
 		pr_warn_once("%s: Budget exhausted after napi rescheduled\n",
 			     n->dev ? n->dev->name : "backlog");
-		return work;
+		goto out;
 	}
 
 	*repoll = true;
 
+out:
+	if (READ_ONCE(n->list_owner) == smp_processor_id())
+		clear_bit(NAPI_STATE_RUNNING, &n->state);
+
 	return work;
 }
 
-- 
2.41.0

