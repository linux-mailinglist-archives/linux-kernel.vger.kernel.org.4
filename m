Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2427018DA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbjEMR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjEMR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C62D58;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9410D61CBD;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618F6C43328;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=yG8vDtqqiK1WK8TQCMHYUP1uYhOMaAO3Fiu7oP+/IRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3UmBtBzYujtAOToBHXQB5QQh/9ETooV61MrDh8iy0QgQneHpvy3jnDOqLNPZOSKU
         /HsMAtr3gTg8Os3IZiUzfxuzpy5qSqPKOCWIYgiLckh6vRPxKBuPFgqUDbaRDozUf7
         M7IPOfJ2Bjh6N+OhzirSW9ekJ7c6MKgSY4wxzzxWRign0W9vH1D2lw2ukmfzjNIvU6
         HsaJqZf3tawNNbieThBUQ+jRhWz0fYa+1xC3PGkXF1cHqh7fKprEYlqLjc1qCV0gPQ
         TzuNBywmqgrxRrT2flCj4hp0n9AFF9jFsauRgsx198R9hStHVekBO75k+nibHwiRFO
         DpBuFASF2JDqA==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tyW-25;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Athanasios Oikonomou <athoik@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Robert Schlabbach <robert_s@gmx.net>,
        Tom Richardson <trichardson@availink.com>
Subject: [PATCH 23/24] media: dvb: add missing DVB-S2X FEC parameter values
Date:   Sat, 13 May 2023 18:57:40 +0100
Message-Id: <66236dd06ca793f89c940bd6f6c9c0e10a7aa2c7.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Athanasios Oikonomou <athoik@gmail.com>

This commit is adding the missing short FEC
Missed on commit 6508a50fe84f9858e8b59b53dce3847aaeeab744

More info: https://dvb.org/wp-content/uploads/2021/02/A083-2r2_DVB-S2X_Draft-EN-302-307-2-v131_Feb_2021.pdf
Table 1: S2X System configurations and application areas

Please note that 128APSK, 256APSK and 256APSK-L
and FEC 29/45, 31/45 are still missing from enums.

Link: https://lore.kernel.org/linux-media/20230111194608.1853-1-athoik@gmail.com
Cc: Robert Schlabbach <robert_s@gmx.net>
Cc: Tom Richardson <trichardson@availink.com>
Signed-off-by: Athanasios Oikonomou <athoik@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/uapi/linux/dvb/frontend.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
index 326f6a53f1f2..7e0983b987c2 100644
--- a/include/uapi/linux/dvb/frontend.h
+++ b/include/uapi/linux/dvb/frontend.h
@@ -296,6 +296,10 @@ enum fe_spectral_inversion {
  * @FEC_28_45: Forward Error Correction Code 28/45
  * @FEC_32_45: Forward Error Correction Code 32/45
  * @FEC_77_90: Forward Error Correction Code 77/90
+ * @FEC_11_45: Forward Error Correction Code 11/45
+ * @FEC_4_15: Forward Error Correction Code 4/15
+ * @FEC_14_45: Forward Error Correction Code 14/45
+ * @FEC_7_15: Forward Error Correction Code 7/15
  *
  * Please note that not all FEC types are supported by a given standard.
  */
@@ -329,6 +333,10 @@ enum fe_code_rate {
 	FEC_28_45,
 	FEC_32_45,
 	FEC_77_90,
+	FEC_11_45,
+	FEC_4_15,
+	FEC_14_45,
+	FEC_7_15,
 };
 
 /**
-- 
2.40.1

