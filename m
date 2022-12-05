Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957B0642C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiLEPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiLEPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:43:32 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC1AE76;
        Mon,  5 Dec 2022 07:43:30 -0800 (PST)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NQnmZ61PtzJnfJ;
        Mon,  5 Dec 2022 23:39:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 23:43:27 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <rafael@kernel.org>, <tony.luck@intel.com>,
        <robert.moore@intel.com>, <bp@alien8.de>, <devel@acpica.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <lvying6@huawei.com>, <naoya.horiguchi@nec.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/4] arm64: improve handle synchronous External Data Abort
Date:   Tue, 6 Dec 2022 00:00:39 +0800
Message-ID: <20221205160043.57465-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix some issue for arm64 synchronous External Data Abort.

1. fix unhandled processor error
According to the RAS documentation, if we cannot determine the impact
of the error based on the details of the error when an SEA occurs, the
process cannot safely continue to run. Therefore, for unhandled error,
we should signal the system and terminate the process immediately.

2. improve for handling memory errors

If error happened in current execution context, we need pass
MF_ACTION_REQUIRED flag to memory_failure(), and if memory_failure()
recovery failed, we must handle this case, other than ignore it.

---
v3: add improve for handing memory errors
v2: fix compile warning reported by kernel test robot.

Xie XiuQi (4):
  ACPI: APEI: include missing acpi/apei.h
  arm64: ghes: fix error unhandling in synchronous External Data Abort
  arm64: ghes: handle the case when memory_failure recovery failed
  arm64: ghes: pass MF_ACTION_REQUIRED to memory_failure when sea

 arch/arm64/kernel/acpi.c      |  6 ++++++
 drivers/acpi/apei/apei-base.c |  5 +++++
 drivers/acpi/apei/ghes.c      | 31 ++++++++++++++++++++++++-------
 include/acpi/apei.h           |  1 +
 include/linux/mm.h            |  2 +-
 mm/memory-failure.c           | 24 +++++++++++++++++-------
 6 files changed, 54 insertions(+), 15 deletions(-)

-- 
2.20.1

