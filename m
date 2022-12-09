Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01D648071
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLIJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:54:20 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4800F379D3;
        Fri,  9 Dec 2022 01:54:18 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NT5tp4rJdzRprb;
        Fri,  9 Dec 2022 17:53:22 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 9 Dec
 2022 17:53:45 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <xueshuai@linux.alibaba.com>, <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <cuibixuan@linux.alibaba.com>, <lvying6@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [RFC PATCH v2 0/1] ACPI: APEI: Make synchronization errors call 
Date:   Fri, 9 Dec 2022 17:54:06 +0800
Message-ID: <20221209095407.383211-1-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC PATCH v2 -> RFC PATCH v1 CHANGE:
====================================
1. based on Shuai and XiuQi's suggestion, this patchset just
consider SEA notification is synchronous error in APEI NMI-like
notification(NMI, SEA, SDEI)[1][2]
2. based on Bixuan's suggestion[3], based on the work of RFC PATCH v1 first
patch, the problem described in RFC PATCH V1 second patch commit message no
longer exists. Integrate the second patch into the first patch.[2]

[1] https://lore.kernel.org/lkml/5afef5fd-7e44-32ae-fa94-5fcf47d4b4df@linux.alibaba.com/
[2] https://lore.kernel.org/lkml/6c9a17ad-fe68-bbb5-bb37-edbcfbbc2fee@huawei.com/
[3] https://lore.kernel.org/lkml/ddc81946-8b76-ea49-ebf5-f2de2e30540d@linux.alibaba.com/

Lv Ying (1):
  ACPI: APEI: Make memory_failure() triggered by synchronization errors
    execute in the current context

 drivers/acpi/apei/ghes.c | 20 +++++++++-------
 mm/memory-failure.c      | 50 +++++++++++++++++++++++++++++-----------
 2 files changed, 48 insertions(+), 22 deletions(-)

-- 
2.36.1

