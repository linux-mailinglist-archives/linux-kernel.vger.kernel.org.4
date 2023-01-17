Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE966E33F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAQQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjAQQR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:17:29 -0500
X-Greylist: delayed 2894 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 08:17:26 PST
Received: from MTA-06-3.privateemail.com (mta-06-3.privateemail.com [198.54.127.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83713D082
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:17:26 -0800 (PST)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id C01FD18000A0;
        Tue, 17 Jan 2023 11:17:25 -0500 (EST)
Received: from bpappas-XPS-13-9310.ucf.edu (050-088-208-136.res.spectrum.com [50.88.208.136])
        by mta-06.privateemail.com (Postfix) with ESMTPA id 33D7418000AA;
        Tue, 17 Jan 2023 11:17:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1673972245;
        bh=2SmQASqnGnVtA5Kz3u+Cb46Sf35Z/fNjuOekQAR+6fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFROjVOR69QpsJhr6SmMOchJrEhs1Zog59GnudKjzVLI8LcYH2khYP6v6y5NWngA0
         p/OFzS07M/QPDyyxlE1RAN8pk5wnf2f2XZV7+DssRBUrT6Kto8YRMl5diB/ttDMNnj
         IgHbQZ9F5n0sbgUJ6soy4hqIIkze9J50ctLimJtV4gPvJbPDoj6EjlIUOElzUHRmGd
         uvoGYX2ryVbmOrIFx7nRdkoFq+gq+vzHtlrInKRk9C3oBbOwRDOkxN802Bf/9nRV2M
         Maf3aMWhHXpT8hLdcyqKmpL4vBjxZdR3vV2kAI98vY+UJDBewN2q1RC8XdOT3TE3cQ
         MnKuXqhS5NEqw==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     andy@kernel.org
Cc:     ailus@linux.intel.com, bpappas@pappasbrent.com, error27@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: [PATCH v2] media: atomisp: pci: Replace bytes macros with functions
Date:   Tue, 17 Jan 2023 11:16:59 -0500
Message-Id: <20230117161659.31232-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y8bARLuFubMVILIN@smile.fi.intel.com>
References: <Y8bARLuFubMVILIN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the advice Andy.
I took a look in overflow.h and found the size_mul function, I assume this
is what I should be using to prevent accidental overflow.
I also removed the inline keyword from the function definitions because
Dan (error27@gmail.com) recommended that I do so in reply to an earlier
patch I submitted.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
Changelog:
V1 -> V2: Use size_mul to perform size_t multiplication without risk of
		  overflow.
		  Remove the inline keyword from function definitions.

 .../staging/media/atomisp/pci/sh_css_params.c | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
index f08564f58242..7e111df5c09d 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -98,17 +98,27 @@
 #include "sh_css_frac.h"
 #include "ia_css_bufq.h"
 
-#define FPNTBL_BYTES(binary) \
-	(sizeof(char) * (binary)->in_frame_info.res.height * \
-	 (binary)->in_frame_info.padded_width)
+static size_t fpntbl_bytes(const struct ia_css_binary *binary)
+{
+	return size_mul(sizeof(char),
+			size_mul(binary->in_frame_info.res.height,
+				 binary->in_frame_info.padded_width));
+}
 
-#define SCTBL_BYTES(binary) \
-	(sizeof(unsigned short) * (binary)->sctbl_height * \
-	 (binary)->sctbl_aligned_width_per_color * IA_CSS_SC_NUM_COLORS)
+static size_t sctbl_bytes(const struct ia_css_binary *binary)
+{
+	return size_mul(sizeof(unsigned short),
+				size_mul(binary->sctbl_height,
+					 size_mul(binary->sctbl_aligned_width_per_color,
+						  IA_CSS_SC_NUM_COLORS)));
+}
 
-#define MORPH_PLANE_BYTES(binary) \
-	(SH_CSS_MORPH_TABLE_ELEM_BYTES * (binary)->morph_tbl_aligned_width * \
-	 (binary)->morph_tbl_height)
+static size_t morph_plane_bytes(const struct ia_css_binary *binary)
+{
+	return size_mul(SH_CSS_MORPH_TABLE_ELEM_BYTES,
+					size_mul(binary->morph_tbl_aligned_width,
+						 binary->morph_tbl_height));
+}
 
 /* We keep a second copy of the ptr struct for the SP to access.
    Again, this would not be necessary on the chip. */
@@ -3279,7 +3289,7 @@ sh_css_params_write_to_ddr_internal(
 	if (binary->info->sp.enable.fpnr) {
 		buff_realloced = reallocate_buffer(&ddr_map->fpn_tbl,
 						   &ddr_map_size->fpn_tbl,
-						   (size_t)(FPNTBL_BYTES(binary)),
+						   fpntbl_bytes(binary),
 						   params->config_changed[IA_CSS_FPN_ID],
 						   &err);
 		if (err) {
@@ -3304,7 +3314,7 @@ sh_css_params_write_to_ddr_internal(
 
 		buff_realloced = reallocate_buffer(&ddr_map->sc_tbl,
 						   &ddr_map_size->sc_tbl,
-						   SCTBL_BYTES(binary),
+						   sctbl_bytes(binary),
 						   params->sc_table_changed,
 						   &err);
 		if (err) {
@@ -3538,8 +3548,7 @@ sh_css_params_write_to_ddr_internal(
 			buff_realloced |=
 			    reallocate_buffer(virt_addr_tetra_x[i],
 					    virt_size_tetra_x[i],
-					    (size_t)
-					    (MORPH_PLANE_BYTES(binary)),
+					    morph_plane_bytes(binary),
 					    params->morph_table_changed,
 					    &err);
 			if (err) {
@@ -3549,8 +3558,7 @@ sh_css_params_write_to_ddr_internal(
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

