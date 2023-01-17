Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6B66E1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAQPPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjAQPPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:15:34 -0500
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 07:15:32 PST
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801733460;
        Tue, 17 Jan 2023 07:15:32 -0800 (PST)
Received: from MTA-09-3.privateemail.com (mta-09.privateemail.com [198.54.127.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h7.fbrelay.privateemail.com (Postfix) with ESMTPS id 7901560222;
        Tue, 17 Jan 2023 10:09:11 -0500 (EST)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
        by mta-09.privateemail.com (Postfix) with ESMTP id ADA7818000A5;
        Tue, 17 Jan 2023 10:09:08 -0500 (EST)
Received: from bpappas-XPS-13-9310.ucf.edu (050-088-208-136.res.spectrum.com [50.88.208.136])
        by mta-09.privateemail.com (Postfix) with ESMTPA id 3525E18000A6;
        Tue, 17 Jan 2023 10:08:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1673968148;
        bh=ZBTABHRAmG+D05AOR8APAmPUuxMqGh+RixprC8KC7Fg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZtnUDEverhCjMgnJDlCnhUI7h5H3c8kniUIptA0zmVYo+aEOcUaiat+oSQD4yloR6
         hBA6xWBw3GinVz3D/O3H+bz3n6Hzst5Vo7TInceipqysJ1gL8ouZkvxp7XhdrJ7s+J
         AU9uB24zAq+TDpNPEz39gRdu+WNx0YPzbv/cfRJoBlDPP9huYpBM5Q2N/vdxTCMc6V
         amCczZc43PimUEekzqoZlLFrAunfTug1W9RqnJsI1Rhk/sRGnK4rH7JfeOmPvpCFvT
         y4+CtOqri1r+YwVearS2IwEW446tpKBT2jjPgqjG8F7Z9VtdQ+fJveBjzEFoE4fo7b
         KE7o1Ij3xNIQA==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     hdegoede@redhat.com
Cc:     mchehab@kernel.org, ailus@linux.intel.com,
        gregkh@linuxfoundation.org, andy@kernel.org, error27@gmail.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH] staging: media: atomisp: pci: Replace bytes macros with functions
Date:   Tue, 17 Jan 2023 10:08:41 -0500
Message-Id: <20230117150841.18061-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the function-like macros FPNTBL_BYTES, SCTBL_BYTES, and
MORPH_PLANE_BYTES with static inline functions to comply with Linux coding
style standards.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
 .../staging/media/atomisp/pci/sh_css_params.c | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
index f08564f58242..fe28d75a62a4 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -98,17 +98,23 @@
 #include "sh_css_frac.h"
 #include "ia_css_bufq.h"
 
-#define FPNTBL_BYTES(binary) \
-	(sizeof(char) * (binary)->in_frame_info.res.height * \
-	 (binary)->in_frame_info.padded_width)
+static inline size_t fpntbl_bytes(const struct ia_css_binary *binary)
+{
+	return (sizeof(char) * binary->in_frame_info.res.height *
+			binary->in_frame_info.padded_width);
+}
 
-#define SCTBL_BYTES(binary) \
-	(sizeof(unsigned short) * (binary)->sctbl_height * \
-	 (binary)->sctbl_aligned_width_per_color * IA_CSS_SC_NUM_COLORS)
+static inline size_t sctbl_bytes(const struct ia_css_binary *binary)
+{
+	return (sizeof(unsigned short) * binary->sctbl_height *
+			binary->sctbl_aligned_width_per_color * IA_CSS_SC_NUM_COLORS);
+}
 
-#define MORPH_PLANE_BYTES(binary) \
-	(SH_CSS_MORPH_TABLE_ELEM_BYTES * (binary)->morph_tbl_aligned_width * \
-	 (binary)->morph_tbl_height)
+static inline size_t morph_plane_bytes(const struct ia_css_binary *binary)
+{
+	return (SH_CSS_MORPH_TABLE_ELEM_BYTES *
+			binary->morph_tbl_aligned_width * binary->morph_tbl_height);
+}
 
 /* We keep a second copy of the ptr struct for the SP to access.
    Again, this would not be necessary on the chip. */
@@ -3279,7 +3285,7 @@ sh_css_params_write_to_ddr_internal(
 	if (binary->info->sp.enable.fpnr) {
 		buff_realloced = reallocate_buffer(&ddr_map->fpn_tbl,
 						   &ddr_map_size->fpn_tbl,
-						   (size_t)(FPNTBL_BYTES(binary)),
+						   fpntbl_bytes(binary),
 						   params->config_changed[IA_CSS_FPN_ID],
 						   &err);
 		if (err) {
@@ -3304,7 +3310,7 @@ sh_css_params_write_to_ddr_internal(
 
 		buff_realloced = reallocate_buffer(&ddr_map->sc_tbl,
 						   &ddr_map_size->sc_tbl,
-						   SCTBL_BYTES(binary),
+						   sctbl_bytes(binary),
 						   params->sc_table_changed,
 						   &err);
 		if (err) {
@@ -3538,8 +3544,7 @@ sh_css_params_write_to_ddr_internal(
 			buff_realloced |=
 			    reallocate_buffer(virt_addr_tetra_x[i],
 					    virt_size_tetra_x[i],
-					    (size_t)
-					    (MORPH_PLANE_BYTES(binary)),
+					    morph_plane_bytes(binary),
 					    params->morph_table_changed,
 					    &err);
 			if (err) {
@@ -3549,8 +3554,7 @@ sh_css_params_write_to_ddr_internal(
 			buff_realloced |=
 			    reallocate_buffer(virt_addr_tetra_y[i],
 					    virt_size_tetra_y[i],
-					    (size_t)
-					    (MORPH_PLANE_BYTES(binary)),
+					    morph_plane_bytes(binary),
 					    params->morph_table_changed,
 					    &err);
 			if (err) {
-- 
2.34.1

