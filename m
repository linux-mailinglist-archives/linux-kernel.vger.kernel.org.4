Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6565B92F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIODQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIODQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:16:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA28E99B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:16:09 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSj0L60j5zNmK3;
        Thu, 15 Sep 2022 11:11:30 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 11:16:06 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 11:16:05 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 0/5] Delay the initializaton of zswap
Date:   Thu, 15 Sep 2022 11:49:58 +0800
Message-ID: <20220915035003.3347466-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the initialization of zswap, about 18MB memory will be allocated for       
zswap_pool. Since not all users use zswap, the memory may be wasted. Save  
the memory for these users by delaying the initialization of zswap to         
first enablement.                                                             

v4->v5: Rebase on next-20220913, the previous first patch is superseded
by patch ("frontswap: don't call ->init if no ops are registered").
v3->v4: Revert three patches to replace previous patch[1-2] suggested by
Vitaly.
v2->v3: Fix frontswap_ops NULL reported by Nathan and add init for online
swap device in backend register.
v1->v2: Change init_zswap to zswap_init suggested by Andrew.

Liu Shixin (5):
  Revert "mm: mark swap_lock and swap_active_head static"
  Revert "frontswap: simplify frontswap_register_ops"
  mm/zswap: replace zswap_init_{started/failed} with zswap_init_state
  mm/zswap: delay the initializaton of zswap until the first enablement
  mm/zswap: skip confusing print info

 include/linux/swapfile.h |  2 ++
 mm/frontswap.c           | 42 ++++++++++++++++++++++
 mm/swapfile.c            |  4 +--
 mm/zswap.c               | 77 ++++++++++++++++++++++++++++++----------
 4 files changed, 104 insertions(+), 21 deletions(-)

-- 
2.25.1

