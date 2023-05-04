Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C36F6EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjEDPKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjEDPKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:10:11 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653749D5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:09:58 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 973BE3423BE;
        Thu,  4 May 2023 17:55:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:message-id:mime-version:reply-to:subject:subject:to
        :to; s=mta-01; bh=68wUneiVNcXZoNX1Bc3JXuJySdZb7HLrPTxieBFi0IQ=; b=
        GbJ5qoCUqBrhvdPQq+pRMf6+pC/nOfnxIlCVStXN1GkCze8aKUhntDM2kcwodem/
        to1EtAp3YkNVDq/ismn27PBPn8wwQstBiIKsEDoGBvfF50q/7uX2pkr53g44S61t
        ltu8izKyujcLcwkgcvySA5VtmTFy3LZnQ18rLu6C4uU=
Received: from T-EXCH-07.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 8D99E342192;
        Thu,  4 May 2023 17:55:11 +0300 (MSK)
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-07.corp.yadro.com (172.17.11.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Thu, 4 May 2023 17:55:11 +0300
Received: from rdma-x86-2.dev.yadro.com (172.17.27.123) by
 T-Exch-05.corp.yadro.com (172.17.10.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Thu, 4 May 2023 17:55:10 +0300
From:   Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
CC:     <linux@yadro.com>,
        Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] perf: RISC-V: Limit the number of counters returned from SBI
Date:   Thu, 4 May 2023 14:54:52 +0000
Message-ID: <20230504145453.981767-1-v.v.mitrofanov@yadro.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.27.123]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-Exch-05.corp.yadro.com (172.17.10.109)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf gets the number of supported counters from SBI. If it happens that
the number of returned counters more than RISCV_MAX_COUNTERS the code
trusts it. It does not lead to an immediate problem but can potentially
lead to it. Prevent getting more than RISCV_MAX_COUNTERS from SBI.

Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
Changes in v2:
- Add new line
- Substitute pr_warn for pr_info

 drivers/perf/riscv_pmu_sbi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 70cb50fd41c2..9d07af2b6be0 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -868,6 +868,12 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
+	/* It is possible to get from SBI more than max number of counters */
+	if (num_counters > RISCV_MAX_COUNTERS) {
+		pr_info("SBI returned more than maximum number of counters\n");
+		num_counters = RISCV_MAX_COUNTERS;
+	}
+
 	/* cache all the information about counters now */
 	if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
 		goto out_free;
-- 
2.37.2


