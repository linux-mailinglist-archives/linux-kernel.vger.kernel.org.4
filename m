Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C51723781
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjFFGV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjFFGVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD5E49
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:20:47 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qb0hS5Fj7zTkqG;
        Tue,  6 Jun 2023 14:20:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 14:20:42 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
        <sidhartha.kumar@oracle.com>
CC:     <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 0/3] Convert several functions in hugetlb.c to use a folio
Date:   Tue, 6 Jun 2023 14:20:10 +0800
Message-ID: <20230606062013.2947002-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

This patch series converts three functions in hugetlb.c to use a folio,
which can remove several implicit calls to compound_head().

Change log:
v2:
- Remove ptepage in copy_hugetlb_page_range() and old_page in
  hugetlb_wp(), suggested by Matthew Wilcox and Mike Kravetz. (Patch 1-2)
- Add RB from Muchun Song and Sidhartha Kumar. (Patch 1-2)
- Add a new patch to use a folio in hugetlb_fault(). (Patch 3)

ZhangPeng (3):
  mm/hugetlb: Use a folio in copy_hugetlb_page_range()
  mm/hugetlb: Use a folio in hugetlb_wp()
  mm/hugetlb: Use a folio in hugetlb_fault()

 mm/hugetlb.c | 72 ++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

-- 
2.25.1

