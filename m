Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15734718E46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjEaWOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjEaWOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:14:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D9137;
        Wed, 31 May 2023 15:14:13 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RyAuRqTy1fbN+GDp6EbhCMVykYjZ/OHOgmYeMhxygFc=;
        b=J/7UYao1W4ti4EVmSs31Mr5tfk4+QGhT0Uonms83G1NrBgJzDnAAIhILcgni0O9SSexpaj
        6+DHVYAeTfYrn/b8Ahl4Rncjgg+cHTqeNItO3ee1vrMtxRkNiazOmOp+XE+IbTTfd+pEEv
        CJ3HJEif+gTfW/x0YlUHSHsC92jWMK4eO/wvGH/3LardIlN37qiDncOVvMUzinx9p4zLcv
        B6S60SWPjzE6pIzHriav71EOfpwMd7y6LV/a2t6bbcBFUVqBv1YVUsDtdOr7lFQ6zuxsPH
        bSgcvRa471z7P1z9SrOnB1hOdpb6aLhSUPRaW46/w6+yH4wp8BEn97PWDJDNXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RyAuRqTy1fbN+GDp6EbhCMVykYjZ/OHOgmYeMhxygFc=;
        b=kh9xDv+97fpuW2hZWEJ9VRu5E+2URCxUP+Bjg6MCtuDEiyNyoOkwMHsyLUf3NWp3T2GI3X
        OKaSnr3xdyOW0iCw==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add platform resolving #defines
 for misc GAM_MMIOH_REDIRECT*
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121922.404.12896947881477321442.tip-bot2@tip-bot2>
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

Commit-ID:     fd27bea340012412a5ad1476b0a40381d7407550
Gitweb:        https://git.kernel.org/tip/fd27bea340012412a5ad1476b0a40381d7407550
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:45 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:34:59 -07:00

x86/platform/uv: Add platform resolving #defines for misc GAM_MMIOH_REDIRECT*

Upcoming changes will require use of new #defines
UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK and
UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK, which provide the
appropriate values on different uv platforms.

Also, fix typo that defined a couple of "*_CONFIG0_*" values twice
where "*_CONFIG1_*" was intended.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-2-steve.wahl%40hpe.com
---
 arch/x86/include/asm/uv/uv_mmrs.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index 57fa673..bb45812 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -4199,6 +4199,13 @@ union uvh_rh_gam_mmioh_overlay_config1_u {
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_SHFT	0
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK	0x0000000000007fffUL
 
+/* UVH common defines */
+#define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK (			\
+	is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :	\
+	is_uv(UV4)  ?  UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :	\
+	is_uv(UV3)  ?  UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :	\
+	0)
+
 
 union uvh_rh_gam_mmioh_redirect_config0_u {
 	unsigned long	v;
@@ -4247,8 +4254,8 @@ union uvh_rh_gam_mmioh_redirect_config0_u {
 	0)
 
 /* UV4A unique defines */
-#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_SHFT	0
-#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK	0x0000000000000fffUL
+#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_SHFT	0
+#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK	0x0000000000000fffUL
 
 /* UV4 unique defines */
 #define UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_SHFT	0
@@ -4258,6 +4265,13 @@ union uvh_rh_gam_mmioh_redirect_config0_u {
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_SHFT	0
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK	0x0000000000007fffUL
 
+/* UVH common defines */
+#define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK (			\
+	is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :	\
+	is_uv(UV4)  ?  UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :	\
+	is_uv(UV3)  ?  UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :	\
+	0)
+
 
 union uvh_rh_gam_mmioh_redirect_config1_u {
 	unsigned long	v;
