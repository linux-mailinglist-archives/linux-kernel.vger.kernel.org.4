Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD43A6DD5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjDKIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:46:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649F121
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:46:32 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PwfYJ4cSqznVXH;
        Tue, 11 Apr 2023 16:45:08 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Apr
 2023 16:46:30 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v9 0/3] Delay the initialization of zswap
Date:   Tue, 11 Apr 2023 17:36:29 +0800
Message-ID: <20230411093632.822290-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

v8->v9: Fix some pattern problem suggested by Christoph.
v7->v8: Do some cleanup. And remove the second patch in v7 which is unrelated
	to the initialization of zswap.
v6->v7: Add two new patch[1,3] to cleanup the code. And cover zswap_init_*
	parameter by zswap_init_lock to protect against conflicts.
v5->v6: Simplify the code and delete the patches about frontswap suggested
	by Christoph.

Liu Shixin (3):
  mm/zswap: remove zswap_entry_cache_{create,destroy} helper function
  mm/zswap: replace zswap_init_{started/failed} with zswap_init_state
  mm/zswap: delay the initialization of zswap

 mm/zswap.c | 122 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 45 deletions(-)

-- 
2.25.1

