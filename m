Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0B629B92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKOOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKOOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:09:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B8656D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:09:13 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBScg0McJzqSPt
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:05:23 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 22:09:09 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: omap1: Fix build error when CONFIG_ARCH_OMAP1_ANY not set
Date:   Tue, 15 Nov 2022 14:07:24 +0000
Message-ID: <20221115140724.87521-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_BACKLIGHT_OMAP1=y && CONFIG_OMAP_MUX=y && CONFIG_ARCH_OMAP1_ANY=n,
building fails:

drivers/video/backlight/omap1_bl.o: in function `omapbl_probe':
omap1_bl.c:(.text+0x1a4): undefined reference to `omap_cfg_reg'

Make "extern int omap_cfg_reg" declaration under the control of macro 'CONFIG_OMAP_MUX'
and 'CONFIG_ARCH_OMAP1_ANY' to fix this.

Fixes: 615dce5bf736 ("ARM: omap1: fix build with no SoC selected")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 include/linux/soc/ti/omap1-mux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/ti/omap1-mux.h b/include/linux/soc/ti/omap1-mux.h
index 59c239b5569c..277a0e6c91bf 100644
--- a/include/linux/soc/ti/omap1-mux.h
+++ b/include/linux/soc/ti/omap1-mux.h
@@ -302,7 +302,7 @@ enum omap1xxx_index {

 };

-#ifdef CONFIG_OMAP_MUX
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP1_ANY)
 extern int omap_cfg_reg(unsigned long reg_cfg);
 #else
 static inline int omap_cfg_reg(unsigned long reg_cfg) { return 0; }
--
2.17.1

