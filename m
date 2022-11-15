Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F79629EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiKOQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKOQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:23:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB7F5E;
        Tue, 15 Nov 2022 08:23:28 -0800 (PST)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBWbb1rxszqSMb;
        Wed, 16 Nov 2022 00:19:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 00:23:25 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <rafael@kernel.org>, <tony.luck@intel.com>,
        <robert.moore@intel.com>, <bp@alien8.de>, <devel@acpica.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <lvying6@huawei.com>
Subject: [PATCH v2 0/2] arm64: fix error unhandling in synchronous External Data Abort
Date:   Wed, 16 Nov 2022 00:41:44 +0800
Message-ID: <20221115164146.106005-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RAS documentation, if we cannot determine the impact
of the error based on the details of the error when an SEA occurs, the
process cannot safely continue to run. Therefore, for unhandled error,
we should signal the system and terminate the process immediately.

PATCH 1: fix compile warning reported by kernel test robot.
PATCH 2: kill current process for unknown errors in when an SEA occurs..

---
v2: fix compile warning reported by kernel test robot.

Xie XiuQi (2):
  ACPI: APEI: include missing acpi/apei.h
  arm64: fix error unhandling in synchronous External Data Abort

 arch/arm64/kernel/acpi.c      |  6 ++++++
 drivers/acpi/apei/apei-base.c |  5 +++++
 drivers/acpi/apei/ghes.c      | 14 +++++++++++---
 include/acpi/apei.h           |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.20.1

