Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8456C8BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjCYGYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYGYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:24:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC315174
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:24:25 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pk8DF1KNjzKmMW;
        Sat, 25 Mar 2023 14:23:57 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 25 Mar
 2023 14:24:21 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v7 0/4] Delay the initialization of zswap
Date:   Sat, 25 Mar 2023 15:14:16 +0800
Message-ID: <20230325071420.2246461-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the initialization of zswap, about 18MB memory will be allocated for
zswap_pool. Since some users may not use zswap, the zswap_pool is wasted.
Save memory by delaying the initialization of zswap until enabled.

v6->v7: Add two new patch[1,3] to cleanup the code. And cover zswap_init_*
	parameter by zswap_init_lock to protect against conflicts.
v5->v6: Simplify the code and delete the patches about frontswap suggested
	by Christoph.

Liu Shixin (4):
  mm/zswap: remove zswap_entry_cache_{create,destroy} helper function
  mm/zswap: skip invalid or unchanged parameter
  mm/zswap: replace zswap_init_{started/failed} with zswap_init_state
  mm/zswap: delay the initializaton of zswap

 mm/zswap.c | 94 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 33 deletions(-)

-- 
2.25.1

