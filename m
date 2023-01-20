Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4771675CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjATS0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjATS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:26:40 -0500
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com [198.54.127.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA378ABC;
        Fri, 20 Jan 2023 10:26:39 -0800 (PST)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 3B6EB18000AE;
        Fri, 20 Jan 2023 13:26:38 -0500 (EST)
Received: from bpappas-XPS-13-9310.. (rrcs-24-173-168-34.se.biz.rr.com [24.173.168.34])
        by mta-12.privateemail.com (Postfix) with ESMTPA id BE92018000B1;
        Fri, 20 Jan 2023 13:26:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674239198;
        bh=254NmRTKKpoPDDbLe8JkEKobrM4zw72lP3QGnoDEAjA=;
        h=From:To:Cc:Subject:Date:From;
        b=D8RTm9mcholnkiKBj+Nepe6m4W+9L8jfvSJmEtJ+XlCZIyPNzKmup55Iua8wD/LVf
         tEs9v3nLPKGjuPputi28LHngKkiQ+EhMrx1mel4A1sLat38J332en/kXtNrpPTwLQN
         csGcOM7UP8X6EHy5V3JEE1N+JYEcBTeBPZs2HDRk7W+Zp58QW9E1o48hsOBUWsLNS2
         hMO/zkYf1DwJRnhuEBA3vmIr0/36vkPzFc0rSNdiUd/nz7w8+OwJofv+zr7z0973Hw
         91JxTA7mljja5Q/NyLLInwbX3btYABuqkiW6rNsOHFFzGs6TxakIe9Gd3QukmiDXGs
         tDq5ZxeTAl00Q==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     hdegoede@redhat.com
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH] media: atomisp: pci: hive_isp_css_common: host: vmem: Replace SUBWORD macros with functions
Date:   Fri, 20 Jan 2023 13:26:25 -0500
Message-Id: <20230120182625.23227-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the macros SUBWORD() and INV_SUBWORD() with functions to comply
with Linux coding style standards.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
I am not sure if it would better to inline SUBWORD() or turn it into
a function.
On the one hand, SUBWORD() is only invoked once, so it may be better to
to inline it.
On the other hand, the macro defined beside it, INV_SUBWORD() should be
turned into to a function because it is invoked multiple times, so it
may make sense to turn SUBWORD() into a function as well.
I have opted to turn SUBWORD() into a function.

 .../pci/hive_isp_css_common/host/vmem.c       | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
index 6620f091442f..316abfb72a83 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
@@ -28,10 +28,19 @@ typedef hive_uedge *hive_wide;
 /* Copied from SDK: sim_semantics.c */
 
 /* subword bits move like this:         MSB[____xxxx____]LSB -> MSB[00000000xxxx]LSB */
-#define SUBWORD(w, start, end)     (((w) & (((1ULL << ((end) - 1)) - 1) << 1 | 1)) >> (start))
+static inline hive_uedge
+subword(hive_uedge w, unsigned int start, unsigned int end)
+{
+	return (w & (((1ULL << (end - 1)) - 1) << 1 | 1)) >> start;
+}
 
 /* inverse subword bits move like this: MSB[xxxx____xxxx]LSB -> MSB[xxxx0000xxxx]LSB */
-#define INV_SUBWORD(w, start, end) ((w) & (~(((1ULL << ((end) - 1)) - 1) << 1 | 1) | ((1ULL << (start)) - 1)))
+static inline hive_uedge
+inv_subword(hive_uedge w, unsigned int start, unsigned int end)
+{
+	return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) |
+		    ((1ULL << start) - 1));
+}
 
 #define uedge_bits (8 * sizeof(hive_uedge))
 #define move_lower_bits(target, target_bit, src, src_bit) move_subword(target, target_bit, src, 0, src_bit)
@@ -50,18 +59,18 @@ move_subword(
 	unsigned int start_bit  = target_bit % uedge_bits;
 	unsigned int subword_width = src_end - src_start;
 
-	hive_uedge src_subword = SUBWORD(src, src_start, src_end);
+	hive_uedge src_subword = subword(src, src_start, src_end);
 
 	if (subword_width + start_bit > uedge_bits) { /* overlap */
 		hive_uedge old_val1;
-		hive_uedge old_val0 = INV_SUBWORD(target[start_elem], start_bit, uedge_bits);
+		hive_uedge old_val0 = inv_subword(target[start_elem], start_bit, uedge_bits);
 
 		target[start_elem] = old_val0 | (src_subword << start_bit);
-		old_val1 = INV_SUBWORD(target[start_elem + 1], 0,
+		old_val1 = inv_subword(target[start_elem + 1], 0,
 				       subword_width + start_bit - uedge_bits);
 		target[start_elem + 1] = old_val1 | (src_subword >> (uedge_bits - start_bit));
 	} else {
-		hive_uedge old_val = INV_SUBWORD(target[start_elem], start_bit,
+		hive_uedge old_val = inv_subword(target[start_elem], start_bit,
 						 start_bit + subword_width);
 
 		target[start_elem] = old_val | (src_subword << start_bit);
-- 
2.34.1

