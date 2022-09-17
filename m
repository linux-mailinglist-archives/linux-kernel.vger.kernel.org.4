Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872FA5BB6C8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIQGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQGyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:54:05 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841F3558EA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xv1x0
        2tQyisnebJpxSQgf/+7jhZQcpLjvEsag0vrxQ8=; b=co/Z4MNS25lHG9fhaF5Wf
        3i9/qNISt2mCg7fV/xziApyB0VM+ot0qa6f0bpuwfZSi1lTpBlnba7LtrLB3L2rb
        DT+vnqm6W9pZe6OEavMSGbAV/nwMUnSv5CBzR/aWd4dO2lCkFMt5YRVkgWS0vjCL
        EMV951I0uZnAKnnzPfAGq4=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp2 (Coremail) with SMTP id GtxpCgAHSfv8biVjfyE+eQ--.63538S2;
        Sat, 17 Sep 2022 14:53:49 +0800 (CST)
From:   williamsukatube@163.com
To:     chenhuacai@kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kernel@xen0n.name, William Dean <williamsukatube@163.com>
Subject: [PATCH -next] LoongArch: simplify code in apply_r_larch_sop_push_dup
Date:   Sat, 17 Sep 2022 14:53:45 +0800
Message-Id: <20220917065345.2595-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgAHSfv8biVjfyE+eQ--.63538S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWktFW7KF4DCF4kZr1UZFb_yoWDJFg_Zw
        17AayrWr1DJa1UZw18Jw4rAw4xK3yvgFyFvF92qF47ZF1UGrs7uFs8W398Crn3tFW8Kr45
        JrWvk34qkrsFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM3ktUUUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB6A5-g2BHKJKnZgAAsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@163.com>

It could directly return 'rela_stack_push' to simplify code.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 arch/loongarch/kernel/module.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 638427ff0d51..a8f90d51d9ae 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -99,13 +99,10 @@ static int apply_r_larch_sop_push_dup(struct module *mod, u32 *location, Elf_Add
 	if (err)
 		return err;
 	err = rela_stack_push(opr1, rela_stack, rela_stack_top);
-	if (err)
-		return err;
-	err = rela_stack_push(opr1, rela_stack, rela_stack_top);
 	if (err)
 		return err;

-	return 0;
+	return rela_stack_push(opr1, rela_stack, rela_stack_top);
 }

 static int apply_r_larch_sop_push_plt_pcrel(struct module *mod, u32 *location, Elf_Addr v,
--
2.25.1

