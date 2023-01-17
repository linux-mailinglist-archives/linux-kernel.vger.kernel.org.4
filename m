Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35F66E6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjAQTbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjAQTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:20:58 -0500
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F92312D;
        Tue, 17 Jan 2023 10:32:30 -0800 (PST)
Received: from MTA-10-4.privateemail.com (mta-10.privateemail.com [68.65.122.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id 4F3726002B;
        Tue, 17 Jan 2023 18:32:29 +0000 (UTC)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
        by mta-10.privateemail.com (Postfix) with ESMTP id 5022918000A2;
        Tue, 17 Jan 2023 13:32:15 -0500 (EST)
Received: from bpappas-XPS-13-9310.net.ucf.edu (unknown [132.170.212.18])
        by mta-10.privateemail.com (Postfix) with ESMTPA id 156F9180009F;
        Tue, 17 Jan 2023 13:32:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1673980335;
        bh=9tfJHMfquKiMaSi0dIV592j2HgRcbJho137zYx7AinU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5m0mC81auHjGwcitxEiIW9qQZnWrm/aLrL5F6Vszpo803bmYPrx6OlmZpkvP3GBA
         jtr6lpaidV8qjwZnKQsRgK/IN9/VfGRCuFvArbUuEPqoNlp/ilH6fJf8H/t8h+0dB0
         Q+dZwhXl5MsqWiO5+3K6cfFbVNLRKHgUHQbZTKEGQMM3Q7MdgWNmAPpSGpO25Gnk5h
         Kzjug6I9Un70kzSl4q0Ntj4zdLUBNj/V7loq0afDt5bgWnaoWyBdEf+qHbwOngD16F
         9lPOJiVt5Cf9YObHfW/4LEFKvhJkh1dMOnDCZjVEzbLFmkMLUdE4KdELWOwWmhlUD6
         C8jMuh6ZeypFQ==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     andy.shevchenko@gmail.com
Cc:     ailus@linux.intel.com, andy@kernel.org, bpappas@pappasbrent.com,
        error27@gmail.com, gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: [PATCH v3] media: atomisp: pci: Replace bytes macros with functions
Date:   Tue, 17 Jan 2023 13:31:52 -0500
Message-Id: <20230117183152.6521-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHp75VcxaSXeMNmkPoMnA+zjp+JWmHp5aE+2yPhXaqxMC6QWEQ@mail.gmail.com>
References: <CAHp75VcxaSXeMNmkPoMnA+zjp+JWmHp5aE+2yPhXaqxMC6QWEQ@mail.gmail.com>
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

Replace the function-like macros FPNTBL_BYTES, SCTBL_BYTES, and
MORPH_PLANE_BYTES with static inline functions to comply with Linux coding
style standards.
Replace multiplication with calls to size_mul to prevent accidental
arithmetic overflow.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
Changelog:
V1 -> V2: Use size_mul to perform size_t multiplication without risk of
		  overflow.
		  Remove the inline keyword from function definitions.

V2 -> V3: Add commit message.

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

