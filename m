Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D457A67DFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjA0JLn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Jan 2023 04:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjA0JLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:11:40 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C78D783CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:11:28 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id AE99224E02F;
        Fri, 27 Jan 2023 17:11:27 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 27 Jan
 2023 17:11:27 +0800
Received: from jsia-virtual-machine.localdomain (60.50.196.81) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 27 Jan 2023 17:11:23 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>
Subject: [PATCH v3 3/4] RISC-V: mm: Enable huge page support to kernel_page_present() function
Date:   Fri, 27 Jan 2023 17:10:50 +0800
Message-ID: <20230127091051.1465278-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [60.50.196.81]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kernel_page_present() function doesn't support huge page
detection causes the function to mistakenly return false to the
hibernation core.

Add huge page detection to the function to solve the problem.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 arch/riscv/mm/pageattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 86c56616e5de..792b8d10cdfc 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -221,14 +221,20 @@ bool kernel_page_present(struct page *page)
 	p4d = p4d_offset(pgd, addr);
 	if (!p4d_present(*p4d))
 		return false;
+	if (p4d_leaf(*p4d))
+		return true;
 
 	pud = pud_offset(p4d, addr);
 	if (!pud_present(*pud))
 		return false;
+	if (pud_leaf(*pud))
+		return true;
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd))
 		return false;
+	if (pmd_leaf(*pmd))
+		return true;
 
 	pte = pte_offset_kernel(pmd, addr);
 	return pte_present(*pte);
-- 
2.34.1

