Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB54705370
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjEPQUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEPQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:20:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9767A93;
        Tue, 16 May 2023 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684254000; x=1715790000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hr9PkdJvHGtuKIHhlA6m9sGNlu3p1iusY1YTwCd+hfs=;
  b=YVaWHP2sb5WXVGzsWT1aQwde1MdrBP0CPOTpTUF+E7nZmKQdaAX8E2Ee
   eZ5S4hayQ+6S12uITO8b7US/6o0+j9iElZ6OsryanBhR9tslxvPagov/Z
   0F/ZfiRiTXPclhqaoHVFzlCmDno0NHhQ/mzS2GTkAxuTSb0g1bwSqMue8
   X7QICntq789TKtnVLkHnqta4x5BiI8+n5VEWMCm7r0xokdKSr5CehHHjW
   VOt55cnAKN7qM8CKoTb6xrNBdepLz/QOJn4SAiy4La34HhfJLLjzA9V35
   XmgXHowYiSW0mNP/urZhV1g1cZuFzWQPPnEOE/W4Qu+VUiNo5ExOEZ64s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="340896492"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="340896492"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 09:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="701414028"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="701414028"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2023 09:19:56 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/11] net: intel: start The Great Code Dedup + Page Pool for iavf
Date:   Tue, 16 May 2023 18:18:30 +0200
Message-Id: <20230516161841.37138-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a two-shot: introduce Intel Ethernet common library (libie) and
switch iavf to Page Pool. Details in the commit messages; here's the
summary:

Not a secret there's a ton of code duplication between two and more Intel
ethernet modules. Before introducing new changes, which would need to be
copied over again, start decoupling the already existing duplicate
functionality into a new module, which will be shared between several
Intel Ethernet drivers.
The first thing that came to my mind was "libie" -- "Intel Ethernet
common library". Also this sounds like "lovelie" and can be expanded as
"lib Internet Explorer" :P I'm open for anything else (but justified).
The series is only the beginning. From now on, adding every new feature
or doing any good driver refactoring will remove much more lines than add
for quite some time. There's a basic roadmap with some deduplications
planned already, not speaking of that touching every line now asks: "can
I share this?".
PP conversion for iavf lands within the same series as these two are tied
closely. libie will support Page Pool model only, so a driver can't use
much of the lib until it's converted. iavf is only the example, the rest
will eventually be converted soon on a per-driver basis. That is when it
will get really interesting. Stay tech.

...#6 tries to shortcut a bunch of calls and checks, Chris, please let me
know if it violates DMAnything (although I'll be missing my +100 Kpps
then =\ :D).

Alexander Lobakin (11):
  net: intel: introduce Intel Ethernet common library
  iavf: kill "legacy-rx" for good
  iavf: optimize Rx buffer allocation a bunch
  iavf: remove page splitting/recycling
  iavf: always use a full order-0 page
  net: page_pool: avoid calling no-op externals when possible
  net: page_pool: add DMA-sync-for-CPU inline helpers
  iavf: switch to Page Pool
  libie: add common queue stats
  libie: add per-queue Page Pool stats
  iavf: switch queue stats to libie

 MAINTAINERS                                   |   3 +-
 drivers/net/ethernet/intel/Kconfig            |  12 +-
 drivers/net/ethernet/intel/Makefile           |   1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c | 253 -------
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   1 +
 .../net/ethernet/intel/i40e/i40e_prototype.h  |   7 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  74 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  88 ---
 drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c | 253 -------
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 227 +-----
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  45 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |   7 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 715 +++++-------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   | 185 +----
 drivers/net/ethernet/intel/iavf/iavf_type.h   |  90 ---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  16 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 316 --------
 drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  74 +-
 drivers/net/ethernet/intel/libie/Makefile     |   7 +
 drivers/net/ethernet/intel/libie/internal.h   |  23 +
 drivers/net/ethernet/intel/libie/rx.c         | 158 ++++
 drivers/net/ethernet/intel/libie/stats.c      | 189 +++++
 include/linux/net/intel/libie/rx.h            | 170 +++++
 include/linux/net/intel/libie/stats.h         | 214 ++++++
 include/net/page_pool.h                       |  62 +-
 net/core/page_pool.c                          |  10 +
 28 files changed, 1125 insertions(+), 2078 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/Makefile
 create mode 100644 drivers/net/ethernet/intel/libie/internal.h
 create mode 100644 drivers/net/ethernet/intel/libie/rx.c
 create mode 100644 drivers/net/ethernet/intel/libie/stats.c
 create mode 100644 include/linux/net/intel/libie/rx.h
 create mode 100644 include/linux/net/intel/libie/stats.h

---
Directly to net-next, has core code changes.
-- 
2.40.1

