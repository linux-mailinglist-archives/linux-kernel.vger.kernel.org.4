Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC2672024
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjAROud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjAROuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:50:04 -0500
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679F86B3;
        Wed, 18 Jan 2023 06:42:48 -0800 (PST)
Received: from MTA-07-4.privateemail.com (unknown [198.54.122.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id D3C3B60730;
        Wed, 18 Jan 2023 14:42:46 +0000 (UTC)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id 404D41801119;
        Wed, 18 Jan 2023 09:42:40 -0500 (EST)
Received: from bpappas-XPS-13-9310.ucf.edu (050-088-208-136.res.spectrum.com [50.88.208.136])
        by mta-07.privateemail.com (Postfix) with ESMTPA id CE0201801126;
        Wed, 18 Jan 2023 09:42:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674052960;
        bh=FqDHCHvsB52HFi8bEmC/gtO/khX/839t5pQ/ZUuPeVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDX1ABUr4GRiT7rKx/G8R8mJ4M0QNyUby6oxCSCAIF8TZ59UJ4aBGuazu6aDiVKTj
         7JQ6ivf3fjLUcnHsVKDN2YOfFILVvLrXNTIJOjb6WtC57SZe5GViJxANiGVt2N46bk
         3V8m/8olN4+7A9jBysabb5U7Fq/gVWg7s49keBD3yONjEJE0LLD3WGtYUqFvxhEsT9
         mkqi690Mb2asL7jo6rnP8wT/oPcLK8HmEIVxy61RwGeJ70jbCMs7H+gxNyhmMJX+YY
         TZHyRzNnsP5Hyf002ikc9joVMOGp1YQZIZP1z0jfmYdRtTmOnChkjCkT8p4hLb4ztl
         YByZgGmFc6qrQ==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     andy.shevchenko@gmail.com
Cc:     ailus@linux.intel.com, bpappas@pappasbrent.com, error27@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: [PATCH v4] media: atomisp: pci: Replace bytes macros with functions
Date:   Wed, 18 Jan 2023 09:42:26 -0500
Message-Id: <20230118144226.13127-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y8bq25jjRdgTTd7/@smile.fi.intel.com>
References: <Y8bq25jjRdgTTd7/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the function-like macros FPNTBL_BYTES(), SCTBL_BYTES(), and
MORPH_PLANE_BYTES() with functions to comply with Linux coding style
standards.
Replace multiplication with calls to functions/macros from overflow.h
to prevent accidental arithmetic overflow.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
Changelog:
V1 -> V2: Use size_mul() to perform size_t multiplication without risk of
		  overflow.
		  Remove the inline keyword from function definitions.

V2 -> V3: Add commit message.

V3 -> V4: Use array_size() and array3_size() for multiplication.

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
+	return array3_size(sizeof(char),
+			binary->in_frame_info.res.height,
+				 binary->in_frame_info.padded_width);
+}
 
-#define SCTBL_BYTES(binary) \
-	(sizeof(unsigned short) * (binary)->sctbl_height * \
-	 (binary)->sctbl_aligned_width_per_color * IA_CSS_SC_NUM_COLORS)
+static size_t sctbl_bytes(const struct ia_css_binary *binary)
+{
+	return array_size(sizeof(unsigned short),
+				array3_size(binary->sctbl_height,
+					    binary->sctbl_aligned_width_per_color,
+						  IA_CSS_SC_NUM_COLORS));
+}
 
-#define MORPH_PLANE_BYTES(binary) \
-	(SH_CSS_MORPH_TABLE_ELEM_BYTES * (binary)->morph_tbl_aligned_width * \
-	 (binary)->morph_tbl_height)
+static size_t morph_plane_bytes(const struct ia_css_binary *binary)
+{
+	return array3_size(SH_CSS_MORPH_TABLE_ELEM_BYTES,
+					binary->morph_tbl_aligned_width,
+						 binary->morph_tbl_height);
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

