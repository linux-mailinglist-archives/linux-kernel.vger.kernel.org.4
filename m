Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC68712674
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbjEZMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEZMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:19:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD7EA4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:19:48 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QSP7g4t7YzsRnm;
        Fri, 26 May 2023 20:17:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 20:19:44 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <rafael.j.wysocki@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anshuman.khandual@arm.com>,
        <wangkefeng.wang@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH] arm64: acpi: Export symbol for acpi_os_ioremap
Date:   Fri, 26 May 2023 20:17:51 +0800
Message-ID: <20230526121751.41060-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver who calls the acpi_os_ioremap() cannot be compiled if the 'M'
is selected for the driver. The compiling log is as follows:
-->
MODPOST Module.symvers
ERROR: modpost: "acpi_os_ioremap" [drivers/soc/hisilicon/xxx.ko] undefined!
scripts/Makefile.modpost:136: recipe for target 'Module.symvers' failed
make[1]: *** [Module.symvers] Error 1

So this patch exports symbol for acpi_os_ioremap.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 arch/arm64/kernel/acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dba8fcec7f33..ec0414caf3d1 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -354,6 +354,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 	}
 	return ioremap_prot(phys, size, pgprot_val(prot));
 }
+EXPORT_SYMBOL(acpi_os_ioremap);
 
 /*
  * Claim Synchronous External Aborts as a firmware first notification.
-- 
2.33.0

