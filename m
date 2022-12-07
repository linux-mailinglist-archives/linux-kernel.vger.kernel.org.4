Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D46F6456B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLGJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLGJjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:39:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72653B64;
        Wed,  7 Dec 2022 01:39:51 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRsc26RZZzJp7r;
        Wed,  7 Dec 2022 17:36:18 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 17:39:13 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <xueshuai@linux.alibaba.com>, <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <lvying6@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH v1 0/2] ACPI: APEI: Make synchronization errors call
Date:   Wed, 7 Dec 2022 17:39:33 +0800
Message-ID: <20221207093935.1972530-1-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes RFC PATCH v1 -> RFC
============================
1. add TODO to explain current there is no good way to distinguish
ghes_proc_in_irq is called by synchronous or asynchronous error, so keep
consistent with the current implementation
2. filter out -EHWPOISON and -EOPNOTSUPP just like kill_me_maybe() 

Lv Ying (2):
  ACPI: APEI: Make memory_failure() triggered by synchronization errors
    execute in the current context
  ACPI: APEI: fix reboot caused by synchronous error loop because of
    memory_failure() failed

 drivers/acpi/apei/ghes.c | 36 ++++++++++++++++++++------------
 mm/memory-failure.c      | 45 ++++++++++++++++++++++++++++------------
 2 files changed, 55 insertions(+), 26 deletions(-)

-- 
2.36.1

