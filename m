Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0691C718E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjEaWOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjEaWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:14:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174619A;
        Wed, 31 May 2023 15:13:52 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YrgTPga6J61LSfCLS2B6c+/0p6QnQhXRIHUc2Gpyhtw=;
        b=ySC/4oie/aRAggRZSV7nLpi4+YnIrxHpBpuCCg5H/lOWd9jHODUFYddXF0pz4RaouflFHO
        BedlzetsNbl+DMamH4cc/slFigJIzGaMZdwX9NE1MfeaiKrC2C6ap2x+i2HoK5FcWTXTEO
        kPTJts0vrGlNtANBVvRDzL/V/+4Xf4hbQTfufMvLzNg4UuxZ2VMZya3b/RXmyouVNauakT
        2TJjp/cKUw+5MtAY/Z6aTpS9HmAu2JT2z1lhCXAMXoWu4+8D2LoBUMgXCroPlsU+LruwVl
        eGxvaggFGXeOOjR1E2CBhHiFRw6kMq/mlyqqCcdmYaURhrTtiJDkpfNsQ705jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YrgTPga6J61LSfCLS2B6c+/0p6QnQhXRIHUc2Gpyhtw=;
        b=e3sODbdebME0czWAKdqcVDWV8t46o/zrxTLj3CTFTNL5Vm9BIAw9lqdIIGXL2cGNDi36LY
        wh2E18XaOl6YH5CQ==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: When searching for minimums,
 start at INT_MAX not 99999
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121766.404.495395130492579199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     35bd896ccc2fa8dfb20df705a44e9d26665f1085
Gitweb:        https://git.kernel.org/tip/35bd896ccc2fa8dfb20df705a44e9d26665f1085
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:48 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:34:59 -07:00

x86/platform/uv: When searching for minimums, start at INT_MAX not 99999

Using a starting value of INT_MAX rather than 999999 or 99999 means
this algorithm won't fail should the numbers being compared ever
exceed this value.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-5-steve.wahl%40hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 6d2739e..2da84be 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1349,7 +1349,7 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 	struct uv_gam_range_entry *gre = (struct uv_gam_range_entry *)ptr;
 	unsigned long lgre = 0, gend = 0;
 	int index = 0;
-	int sock_min = 999999, pnode_min = 99999;
+	int sock_min = INT_MAX, pnode_min = INT_MAX;
 	int sock_max = -1, pnode_max = -1;
 
 	uv_gre_table = gre;
@@ -1694,7 +1694,7 @@ static void __init uv_system_init_hub(void)
 {
 	struct uv_hub_info_s hub_info = {0};
 	int bytes, cpu, nodeid;
-	unsigned short min_pnode = 9999, max_pnode = 0;
+	unsigned short min_pnode = USHRT_MAX, max_pnode = 0;
 	char *hub = is_uv5_hub() ? "UV500" :
 		    is_uv4_hub() ? "UV400" :
 		    is_uv3_hub() ? "UV300" :
