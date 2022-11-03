Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B897B6173AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKCBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKCBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:20:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862912745
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:20:02 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N2mBz6kbGzbcDF;
        Thu,  3 Nov 2022 09:19:55 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 09:20:00 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <linux@armlinux.org.uk>, <liaochang1@huawei.com>,
        <nico@fluxnic.net>, <tixy@yxit.co.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ARM: kprobes: Improve robustness for kprobe coverage testing
Date:   Thu, 3 Nov 2022 09:16:45 +0800
Message-ID: <20221103011645.138749-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve robustness for kprobe coverage testing, avoid to access NULL
pointer in coverage_start_fn.

Fixes: 963780dfe390 ("ARM: kprobes: Add decoding table test coverage analysis")
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm/probes/kprobes/test-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index c562832b8627..e6a932e863bb 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -766,6 +766,11 @@ static int coverage_start(const union decode_item *table)
 	coverage.base = kmalloc_array(MAX_COVERAGE_ENTRIES,
 				      sizeof(struct coverage_entry),
 				      GFP_KERNEL);
+	if (!coverage.base) {
+		pr_err("FAIL: Out of space for allocating coverage entries");
+		return -ENOMEM;
+	}
+
 	coverage.num_entries = 0;
 	coverage.nesting = 0;
 	return table_iter(table, coverage_start_fn, &coverage);
-- 
2.17.1

