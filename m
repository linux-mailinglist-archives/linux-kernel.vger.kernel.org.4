Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACA474E517
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGKDF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjGKDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:04:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E59BE6C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:03:45 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0Qf01RnXzVhpV;
        Tue, 11 Jul 2023 11:02:32 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 11:03:42 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <guohanjun@huawei.com>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>, <thunder.leizhen@huawei.com>,
        <zhangzekun11@huawei.com>
Subject: [PATCH -next 0/2] iommu/iova: optimize the iova rcache 
Date:   Tue, 11 Jul 2023 10:54:50 +0800
Message-ID: <20230711025452.35475-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct of iova rcache has diffcult in dealing with machine with
lots of cpus, because every cpu has a cpu_rcache and they need to
exchange iova in a fixed length buffer rcache->depot, this buffer
can sometimes become a bottle neck of allocating iova from iova_rcache.
The number of iova_cpu_rcache can grow with the number of cpus in
iova_rcache, but the size of rcache->depot will not. The deeper of
rcache->depot can help iova_rcache cache more iovas, and can help
iova_rcache better dealing with senarios in which drivers allocating
and free iovas on different cpu cores. We only let the size of rcache->depot
to grow with the number of cpus which is larger than 32 to avoid potential
performance decrease on machines which don't have much cpus.

Also, it is unsafe to directly free cpu rcache magazines in free_iova_rcaches,
add check before freeing it.

Zhang Zekun (2):
  iommu/iova: Add check for cpu_rcache in free_iova_rcaches
  iommu/iova: allocate iova_rcache->depot dynamicly

 drivers/iommu/iova.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.17.1

