Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CAB6A8F6A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 03:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCCCvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 21:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCCvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:51:38 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B0515C8;
        Thu,  2 Mar 2023 18:51:37 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8F82A1A009FD;
        Fri,  3 Mar 2023 10:52:21 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P0HFerBptk8g; Fri,  3 Mar 2023 10:52:20 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1FAA01A00994;
        Fri,  3 Mar 2023 10:52:20 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        hewenliang4@huawei.com, renzhijie2@huawei.com,
        haibinzhang@tencent.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] arm64: armv8_deprecated: remove unnecessary (void*) conversions
Date:   Fri,  3 Mar 2023 10:50:47 +0800
Message-Id: <20230303025047.19717-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 8a9052cf3013..1febd412b4d2 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -420,14 +420,14 @@ static DEFINE_MUTEX(insn_emulation_mutex);
 
 static void enable_insn_hw_mode(void *data)
 {
-	struct insn_emulation *insn = (struct insn_emulation *)data;
+	struct insn_emulation *insn = data;
 	if (insn->set_hw_mode)
 		insn->set_hw_mode(true);
 }
 
 static void disable_insn_hw_mode(void *data)
 {
-	struct insn_emulation *insn = (struct insn_emulation *)data;
+	struct insn_emulation *insn = data;
 	if (insn->set_hw_mode)
 		insn->set_hw_mode(false);
 }
-- 
2.11.0

