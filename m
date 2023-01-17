Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE466DADB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbjAQKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjAQKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:24:01 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA926593;
        Tue, 17 Jan 2023 02:23:58 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Nx4k46yL0z4xq20;
        Tue, 17 Jan 2023 18:23:56 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 30HANicF048677;
        Tue, 17 Jan 2023 18:23:44 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 17 Jan 2023 18:23:47 +0800 (CST)
Date:   Tue, 17 Jan 2023 18:23:47 +0800 (CST)
X-Zmail-TransId: 2af963c67733ffffffffed689a60
X-Mailer: Zmail v1.0
Message-ID: <202301171823476416320@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <richard.henderson@linaro.org>
Cc:     <ink@jurassic.park.msu.ru>, <mattst88@gmail.com>,
        <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBhbHBoYTogcG90ZW50aWFsIGRlcmVmZXJlbmNlIG9mIG51bGwgcG9pbnRlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30HANicF048677
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C6773C.000/4Nx4k46yL0z4xq20
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The return value of kmalloc() needs to be checked.
To avoid use of null pointer in case of the failure of alloc.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/alpha/kernel/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
index 5b60c248de9e..5442b75a98c2 100644
--- a/arch/alpha/kernel/module.c
+++ b/arch/alpha/kernel/module.c
@@ -47,6 +47,8 @@ process_reloc_for_got(Elf64_Rela *rela,
 		}

 	g = kmalloc (sizeof (*g), GFP_KERNEL);
+	if (!g)
+		return;
 	g->next = chains[r_sym].next;
 	g->r_addend = r_addend;
 	g->got_offset = *poffset;
-- 
2.25.1
