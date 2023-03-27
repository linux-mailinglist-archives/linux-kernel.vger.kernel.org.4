Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE16CA2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjC0L4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0L4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:56:14 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0A3595
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:56:13 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=lizhaoyang04@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32RBsl3h004507-32RBsl3k004507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 27 Mar 2023 19:54:47 +0800
From:   Zhaoyang Li <lizhaoyang04@hust.edu.cn>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Zhaoyang Li <lizhaoyang04@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: bcm: brcmstb: biuctrl: fix of_iomap leak
Date:   Mon, 27 Mar 2023 19:54:22 +0800
Message-Id: <20230327115422.1536615-1-lizhaoyang04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lizhaoyang04@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

drivers/soc/bcm/brcmstb/biuctrl.c:291 setup_hifcpubiuctrl_regs() warn:
'cpubiuctrl_base' from of_iomap() not released on lines: 291.

This is because in setup_hifcpubiuctrl_regs(),
cpubiuctrl_base is not released when handle error, which may cause a leak.
To fix this, iounmap is added when handle error.

Fixes: 22f7a9116eba ("soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs")
Signed-off-by: Zhaoyang Li <lizhaoyang04@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
From static analysis. Untested
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index e1d7b4543248..c92693fad1d2 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -288,6 +288,10 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 	if (BRCM_ID(family_id) == 0x7260 && BRCM_REV(family_id) == 0)
 		cpubiuctrl_regs = b53_cpubiuctrl_no_wb_regs;
 out:
+	if (ret && cpubiuctrl_base) {
+		iounmap(cpubiuctrl_base);
+		cpubiuctrl_base = NULL;
+	}
 	return ret;
 }
 
-- 
2.25.1

