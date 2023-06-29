Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5432374297B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF2PYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjF2PX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:23:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1632D4E;
        Thu, 29 Jun 2023 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688052238; x=1719588238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VzjkOhOXv+HmibhXRaAGBTDw64W/2tLIdcg3hf/qhFQ=;
  b=jQmBEq5++85J8Z/786TkVo6Ng86TsL0oJQFSt7/ifYQuSkiC4TMDydBi
   0cxvzMrxlfWXoEEB9MC0f4FLPPdzNf8/137WCQVNEuPhnxt7L+hGlIjV/
   GiIjoTjiHDNqNbwMnK487Tt41c/XMPPFoQcklTnwXfbst7zBo5kNCLHD+
   r0BEg/Xmf4tqSBatc43hSDu6RsMZE582CGXVgtJZCDLsxH85XDWE4m6fQ
   DwvZASKNkuwkbkLHiGWAxQltmCDm600HwuOuhMLPeVeGlclxw6DYUiwqo
   2aTGP/y/eVvVCbJLrgYxWP9Cs9XR4GK8NxUN0sgPvL35SRHZrGUWjgW+g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="346920562"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="346920562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830573763"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="830573763"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2023 08:23:50 -0700
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
Subject: [PATCH RFC net-next 0/4] net: page_pool: a couple assorted optimizations
Date:   Thu, 29 Jun 2023 17:23:01 +0200
Message-ID: <20230629152305.905962-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
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

Here's spin off the IAVF PP series[0], with 2 runtime (hotpath) and 1
compile-time optimizations. They're based and tested on top of the
hybrid PP allocation series[1], but don't require it to work and
in general independent of it and each other.

Per-patch breakdown:
 #1: already was on the lists, but this time it's done the other way, the
     one that Alex Duyck proposed during the review of the previous series.
     Slightly reduce amount of C preprocessing by stopping including
     <net/page_pool.h> to <linux/skbuff.h> (which is included in the
     half of the kernel sources). Especially useful with the abovementioned
     series applied, as it makes page_pool.h heavier;
 #2: don't call to DMA sync externals when they won't do anything anyway
     by doing some heuristics a bit earlier (when allocating a new page),
     also was on the lists;
 #3: new, prereq to #4. Add NAPI state flag, which would indicate
     napi->poll() is running right now, so that napi->list_owner would
     point to the CPU where it's being run, not just scheduled;
 #4: new. In addition to recycling skb PP pages directly when @napi_safe
     is set, check for the flag from #3, which will mean the same if
     ->list_owner is pointing to us. This allows to use direct recycling
     anytime we're inside a NAPI polling loop or GRO stuff going right
     after it, covering way more cases than is right now.

(complete tree with [1] + this + [0] is available here: [2])

[0] https://lore.kernel.org/netdev/20230530150035.1943669-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20230629120226.14854-1-linyunsheng@huawei.com
[2] https://github.com/alobakin/linux/commits/iavf-pp-frag

Alexander Lobakin (4):
  net: skbuff: don't include <net/page_pool.h> to <linux/skbuff.h>
  net: page_pool: avoid calling no-op externals when possible
  net: add flag to indicate NAPI/GRO is running right now
  net: skbuff: always recycle PP pages directly when inside a NAPI loop

 drivers/net/ethernet/engleder/tsnep_main.c    |  1 +
 drivers/net/ethernet/freescale/fec_main.c     |  1 +
 .../marvell/octeontx2/nic/otx2_common.c       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  1 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 include/linux/netdevice.h                     |  2 +
 include/linux/skbuff.h                        |  3 +-
 include/net/page_pool.h                       |  5 +-
 net/core/dev.c                                | 23 +++++--
 net/core/page_pool.c                          | 62 +++++++------------
 net/core/skbuff.c                             | 29 +++++++++
 13 files changed, 83 insertions(+), 48 deletions(-)

---
Really curious about #3. Implementing the idea correctly (this or other
way) potentially unblocks a lot more interesting stuff (besides #4).
-- 
2.41.0

