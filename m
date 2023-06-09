Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23890729B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbjFINUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjFINTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:19:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1D30CD;
        Fri,  9 Jun 2023 06:19:49 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qd1lL6PSQzqTyR;
        Fri,  9 Jun 2023 21:14:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 21:19:45 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v3 0/4] introduce page_pool_alloc() API
Date:   Fri, 9 Jun 2023 21:17:35 +0800
Message-ID: <20230609131740.7496-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1] & [2], there are usecases for veth and virtio_net to
use frag support in page pool to reduce memory usage, and it
may request different frag size depending on the head/tail
room space for xdp_frame/shinfo and mtu/packet size. When the
requested frag size is large enough that a single page can not
be split into more than one frag, using frag support only have
performance penalty because of the extra frag count handling
for frag support.

So this patchset provides a page pool API for the driver to
allocate memory with least memory utilization and performance
penalty when it doesn't know the size of memory it need
beforehand.

1. https://patchwork.kernel.org/project/netdevbpf/patch/d3ae6bd3537fbce379382ac6a42f67e22f27ece2.1683896626.git.lorenzo@kernel.org/
2. https://patchwork.kernel.org/project/netdevbpf/patch/20230526054621.18371-3-liangchen.linux@gmail.com/

V3: Incorporate changes from the disscusion with Alexander,
    mostly the inline wraper, PAGE_POOL_DMA_USE_PP_FRAG_COUNT
    change split to separate patch and comment change.
V2: Add patch to remove PP_FLAG_PAGE_FRAG flags and mention
    virtio_net usecase in the cover letter.
V1: Drop RFC tag and page_pool_frag patch.

Yunsheng Lin (4):
  page_pool: frag API support for 32-bit arch with 64-bit DMA
  page_pool: unify frag_count handling in page_pool_is_last_frag()
  page_pool: introduce page_pool_alloc() API
  page_pool: remove PP_FLAG_PAGE_FRAG flag

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   3 +-
 .../marvell/octeontx2/nic/otx2_common.c       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  11 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 include/net/page_pool.h                       | 131 +++++++++++++++---
 net/core/page_pool.c                          |  26 ++--
 net/core/skbuff.c                             |   2 +-
 7 files changed, 139 insertions(+), 38 deletions(-)

-- 
2.33.0

