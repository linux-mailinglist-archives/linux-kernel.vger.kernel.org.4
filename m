Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4E73FBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjF0MIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjF0MIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:08:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759B91999
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:08:42 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qr3Lv3X7czMnhv;
        Tue, 27 Jun 2023 20:05:27 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 20:08:37 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH 0/2] fix WARN_ON in add_to_avail_list
Date:   Tue, 27 Jun 2023 20:08:31 +0800
Message-ID: <20230627120833.2230766-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Our test find a WARN_ON in add_to_avail_list. During add_to_avail_list,
avail_lists is already in swap_avail_heads, while lead to this WARN_ON.

During swapoff, try_to_unuse fail to alloc memory due to memory limit and
this lead the failure of swapoff and casing re-insert swap space back into
swap_list. During _enable_swap_info, this swap device is added to avail
list even this swap device if full. At the same time, one entry in this
full swap device in released and try to add this device into avail list
and found it is already in the avail list. This cause this WARN_ON.

Ma Wupeng (2):
  swap: Cleanup duplicated WARN_ON in add_to_avail_list
  swap: Stop add to avail list is swap is full

 mm/swapfile.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

