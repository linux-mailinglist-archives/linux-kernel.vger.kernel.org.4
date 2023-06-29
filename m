Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A49742982
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjF2PYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjF2PYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:24:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852033584;
        Thu, 29 Jun 2023 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688052247; x=1719588247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DoG27UNRr5H+5NVUUD3zG36LMPgB99hxtFjecm2IJwk=;
  b=h0H92upFCQGhYvF2XNhavYVb/YFW9l+huTqby4ouBNd3Sy//e8cuj4BT
   W2mgcfLdSCULHjyE2fYzRg2dajaQtVqKHVHHHbFHIVtwYGARSR9EBxmXp
   3URrT6sM2asf91Zc5Z645o1cMdNeSrg641YLRhS3DtG/Vefd3iAvxHnFx
   MuvWHFExsBP5HoSyedcSte5mip5vSABZIri8cvxtwqMEZuUBjvu4Jok3m
   UgTdlWCZ1jzJB/vOHOfVpD8sk5GPZ2rnR1vUGcAebCG6CmdA0gqlhEdRY
   9MQvhT+hH1zATOUPDRe1fYrmcjLDUQRooexHj0OJOUPqkcdolGNBc+ziH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="346920658"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="346920658"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830573882"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="830573882"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2023 08:24:04 -0700
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
Subject: [PATCH RFC net-next 4/4] net: skbuff: always recycle PP pages directly when inside a NAPI loop
Date:   Thu, 29 Jun 2023 17:23:05 +0200
Message-ID: <20230629152305.905962-5-aleksander.lobakin@intel.com>
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

Commit 8c48eea3adf3 ("page_pool: allow caching from safely localized
NAPI") allowed direct recycling of skb pages to their PP for some cases,
but unfortunately missed a couple other majors.
For example, %XDP_DROP in skb mode. The netstack just calls kfree_skb(),
which unconditionally passes `false` as @napi_safe. Thus, all pages go
through ptr_ring and locks, although most of times we're actually inside
the NAPI polling this PP is linked with, so that it would be perfectly
safe to recycle pages directly.
Let's address such. If @napi_safe is true, we're fine, don't change
anything for this path. But if it's false, test the introduced
%NAPI_STATE_RUNNING. There's good probability it will be set and, if
->list_owner is our current CPU, we're good to use direct recycling,
even though @napi_safe is false.
For the mentioned xdp-drop-skb-mode case, the improvement I got is
3-4% in Mpps. As for page_pool stats, recycle_ring is now 0 and
alloc_slow counter doesn't change most of times, which means the
MM layer is not even called to allocate any new pages.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4b7d00d5b5d7..931c83d7b251 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -893,7 +893,8 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
 	 * no possible race.
 	 */
 	napi = READ_ONCE(pp->p.napi);
-	allow_direct = napi_safe && napi &&
+	allow_direct = napi &&
+		(napi_safe || test_bit(NAPI_STATE_RUNNING, &napi->state)) &&
 		READ_ONCE(napi->list_owner) == smp_processor_id();
 
 	/* Driver set this to memory recycling info. Reset it on recycle.
-- 
2.41.0

