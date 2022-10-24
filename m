Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4938B60BDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJXWmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJXWmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:42:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D602C5038
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:05:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so10687243wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MapDRT5dNGASoX9QyAbNVX+bGdkTmm7KMRPKd1Tm+M4=;
        b=i5ooe42/LGtwRVk6Fm9rlX8w/3VFfYlD6oObY1NMK88c8CiENjjDBfqIDPWNfhutok
         JggtbuYbiNyS3SeJdRF+0/dxazx8zsA7Fgg1BM3Lf0jzauCRF/jWNVwn6TyGaxgOvHkE
         iMs4FDW/ygDvgGaTH55NRxsHvaRlvr/xmPy95JcbOPUMw46ktrFi/1EhQ07F2TF/b8it
         xCaSZZdnFQokmYv6hEugQdRJolljB3gUE3ojrzwgTfKrRdF59UqxVTjhPufApFtcNKmp
         QQiPnVKEKRjuXfXDrFWUblm+0c1v7IJDmkvg+vcwBkabPVkQ0Z9Cb9jtIWvO5VyTYSYT
         A0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MapDRT5dNGASoX9QyAbNVX+bGdkTmm7KMRPKd1Tm+M4=;
        b=BWGKgLyW0vyck1ndgYS3fLEg/klWu8g7X8yNWmIcw0LaNbehNFv3UrGBAmcZTyp9xe
         Nb9tcRL5+0p0yHR8SxiUP2qCbES6FiDKUQZ8ntLoPTx0SIj+SkqKd4qnB34DdwE4GYpN
         BKPnMnYpi2o3/cUS2o4yVUdkD+qIthjyB9/IQOievoBFb9UsyM9N3V7t0hNsmkJaxYLp
         KogGtRJ2lKQwQj9J/lJ5CjOqoz0WhkNLG2E4a+USoSG9hHLDts5O7EVk9ZPwpx/Eq54G
         Dk41NZsDyYgAusORKnkSiN5WW+WDcWnlnTPzuZPPVjxGeIqE03nVNfRoHqPcXzOGylGX
         uLTg==
X-Gm-Message-State: ACrzQf2erX9q/2sIzNGnowGjY3biI/bn9qdAqYdaEl7HBIYsqJSbksKY
        OqQ2ewrfBVria+gf0Q3O9Z30bw==
X-Google-Smtp-Source: AMsMyM5URCE3faIxsqvfNIOlafUybNvkX6/hd4hwA8YsYpyvm5UXp+si7QTU7sb6WMDOe9Uk04IDHQ==
X-Received: by 2002:a7b:c4d9:0:b0:3c4:e77f:b991 with SMTP id g25-20020a7bc4d9000000b003c4e77fb991mr24355779wmk.104.1666645437924;
        Mon, 24 Oct 2022 14:03:57 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id i17-20020adfded1000000b002364835caacsm602371wrn.112.2022.10.24.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:03:57 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Alex Elder <elder@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jami Kettunen <jami.kettunen@somainline.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Alex Elder <elder@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 2/2] net: ipa: fix v3.1 resource limit masks
Date:   Mon, 24 Oct 2022 22:03:32 +0100
Message-Id: <20221024210336.4014983-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024210336.4014983-1-caleb.connolly@linaro.org>
References: <20221024210336.4014983-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource group limits for IPA v3.1 mistakenly used 6 bit wide mask
values, when the hardware actually uses 8. Out of range values were
silently ignored before, so the IPA worked as expected. However the
new generalised register definitions introduce stricter checking here,
they now cause some splats and result in the value 0 being written
instead. Fix the limit bitmask widths so that the correct values can be
written.

Fixes: 1c418c4a929c ("net: ipa: define resource group/type IPA register fields")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/net/ipa/reg/ipa_reg-v3.1.c | 96 ++++++++++--------------------
 1 file changed, 32 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ipa/reg/ipa_reg-v3.1.c b/drivers/net/ipa/reg/ipa_reg-v3.1.c
index 116b27717e3d..0d002c3c38a2 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.1.c
@@ -127,112 +127,80 @@ static const u32 ipa_reg_counter_cfg_fmask[] = {
 IPA_REG_FIELDS(COUNTER_CFG, counter_cfg, 0x000001f0);
 
 static const u32 ipa_reg_src_rsrc_grp_01_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(SRC_RSRC_GRP_01_RSRC_TYPE, src_rsrc_grp_01_rsrc_type,
 		      0x00000400, 0x0020);
 
 static const u32 ipa_reg_src_rsrc_grp_23_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(SRC_RSRC_GRP_23_RSRC_TYPE, src_rsrc_grp_23_rsrc_type,
 		      0x00000404, 0x0020);
 
 static const u32 ipa_reg_src_rsrc_grp_45_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(SRC_RSRC_GRP_45_RSRC_TYPE, src_rsrc_grp_45_rsrc_type,
 		      0x00000408, 0x0020);
 
 static const u32 ipa_reg_src_rsrc_grp_67_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(SRC_RSRC_GRP_67_RSRC_TYPE, src_rsrc_grp_67_rsrc_type,
 		      0x0000040c, 0x0020);
 
 static const u32 ipa_reg_dst_rsrc_grp_01_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(DST_RSRC_GRP_01_RSRC_TYPE, dst_rsrc_grp_01_rsrc_type,
 		      0x00000500, 0x0020);
 
 static const u32 ipa_reg_dst_rsrc_grp_23_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(DST_RSRC_GRP_23_RSRC_TYPE, dst_rsrc_grp_23_rsrc_type,
 		      0x00000504, 0x0020);
 
 static const u32 ipa_reg_dst_rsrc_grp_45_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(DST_RSRC_GRP_45_RSRC_TYPE, dst_rsrc_grp_45_rsrc_type,
 		      0x00000508, 0x0020);
 
 static const u32 ipa_reg_dst_rsrc_grp_67_rsrc_type_fmask[] = {
-	[X_MIN_LIM]					= GENMASK(5, 0),
-						/* Bits 6-7 reserved */
-	[X_MAX_LIM]					= GENMASK(13, 8),
-						/* Bits 14-15 reserved */
-	[Y_MIN_LIM]					= GENMASK(21, 16),
-						/* Bits 22-23 reserved */
-	[Y_MAX_LIM]					= GENMASK(29, 24),
-						/* Bits 30-31 reserved */
+	[X_MIN_LIM]					= GENMASK(7, 0),
+	[X_MAX_LIM]					= GENMASK(15, 8),
+	[Y_MIN_LIM]					= GENMASK(23, 16),
+	[Y_MAX_LIM]					= GENMASK(31, 24),
 };
 
 IPA_REG_STRIDE_FIELDS(DST_RSRC_GRP_67_RSRC_TYPE, dst_rsrc_grp_67_rsrc_type,
-- 
2.38.1

