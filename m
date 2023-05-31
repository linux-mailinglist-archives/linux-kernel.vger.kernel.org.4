Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159C7718E48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjEaWP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjEaWOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:14:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD97125;
        Wed, 31 May 2023 15:14:13 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Dfl+bzG7o/eFPC1aATqO2T6EL2+L+fj78OJOHP/rVCo=;
        b=ZXHUw++WVAZX5OczPrYoXGhvs7T3Jk2dK+hoMbGkXHd7vxIsIMI8YfcMSSu8mBfGD1D9mv
        zi8A4OHadE/wI0K7BiRVMMwTndW4Dwoa55nEiZVha0iCeXYAJII0wJAlzjGB0teuPlBB4U
        EF6zMw2hJ4fw0A+NpWxEIjgXeDSdh6PM6iiScVVOpG6FSlcdO8NZD58hRrSRFA3tciLPV+
        fPxvD9WAh9tBkE7VOQgpbyyhg1IXcShNpiiP0ZwVdoiQMdqq7cd3l+jGDR3ykK5og++9Uu
        UGKm/Y4A/ffW+QyaPrZPs2z2W7qDLIvUqsvjnwQac2ESAzzdHNC03Vo0mZYzjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Dfl+bzG7o/eFPC1aATqO2T6EL2+L+fj78OJOHP/rVCo=;
        b=tjjEGn1l83E70fnFPETZH17fA3/vJMHaxmZWFnkMuy9XavpVvOV34GEf6sa4oHAIi748qf
        6yTT1f0phCzSEqBQ==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Fix printed information in
 calc_mmioh_map
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121818.404.10436980757207022007.tip-bot2@tip-bot2>
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

Commit-ID:     e4860f03779cadff011a7a8685c7157ebc133bda
Gitweb:        https://git.kernel.org/tip/e4860f03779cadff011a7a8685c7157ebc133bda
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:47 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:34:59 -07:00

x86/platform/uv: Fix printed information in calc_mmioh_map

Fix incorrect mask names and values in calc_mmioh_map() that caused it
to print wrong NASID information. And an unused blade position is not
an error condition, but will yield an invalid NASID value, so change
the invalid NASID message from an error to a debug message.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-4-steve.wahl%40hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 4828552..6d2739e 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1022,7 +1022,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 	switch (index) {
 	case UVY_MMIOH0:
 		mmr = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG0;
-		nasid_mask = UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
+		nasid_mask = UVYH_RH10_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK;
 		n = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
 		min_nasid = min_pnode;
 		max_nasid = max_pnode;
@@ -1030,7 +1030,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 		break;
 	case UVY_MMIOH1:
 		mmr = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG1;
-		nasid_mask = UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
+		nasid_mask = UVYH_RH10_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK;
 		n = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG1_DEPTH;
 		min_nasid = min_pnode;
 		max_nasid = max_pnode;
@@ -1038,7 +1038,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 		break;
 	case UVX_MMIOH0:
 		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0;
-		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
+		nasid_mask = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK;
 		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
 		min_nasid = min_pnode * 2;
 		max_nasid = max_pnode * 2;
@@ -1046,7 +1046,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 		break;
 	case UVX_MMIOH1:
 		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1;
-		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
+		nasid_mask = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK;
 		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_DEPTH;
 		min_nasid = min_pnode * 2;
 		max_nasid = max_pnode * 2;
@@ -1072,8 +1072,9 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 
 		/* Invalid NASID check */
 		if (nasid < min_nasid || max_nasid < nasid) {
-			pr_err("UV:%s:Invalid NASID:%x (range:%x..%x)\n",
-				__func__, index, min_nasid, max_nasid);
+			/* Not an error: unused table entries get "poison" values */
+			pr_debug("UV:%s:Invalid NASID(%x):%x (range:%x..%x)\n",
+			       __func__, index, nasid, min_nasid, max_nasid);
 			nasid = -1;
 		}
 
