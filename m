Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E787640809
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiLBNzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiLBNzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:55:47 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89943B957C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:55:46 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u10so3442647qvp.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 05:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGjb7Uqfw2TGFRhH8/MDvnTU61at8sAfSWXXepkn37Q=;
        b=uiLT3I4vgcsnSV/JwiTu0ZuYVwmaObX0mKCt6uVP215+MyIgPPlR2p9kLRQalYp964
         OHyPYDm2UevA8Pu+qA3v5CKAU73uTqt2Zw7EgPb0Dq4+5T1oN1/m6pM5qxL3g8sLffh4
         mlnti0ZmLHEIiM0gEDUEnnizIGBFlm792Z/mysV4DJQERCfG62ZlLxY5NngJXoq637IV
         m3fyj9RIrWiuCHfgDkZoy/9/aDnpwl6H36vS2gVE937kEq2AfDo3YDlY5ZFUoxR4YOD2
         ZUVedzGjYndMrQXC4xlTwEyG0sM8S/XeE+RRPkSBICPEDjZpgwxRGFK75EonDG21KNlA
         l5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGjb7Uqfw2TGFRhH8/MDvnTU61at8sAfSWXXepkn37Q=;
        b=BVUsd+00aea4rkKxpIb1gfxsjcIms2OTR1JHj5B0j0uNupDZaz4jLEUUU3m6qLMdXW
         t5BhK/TwTI59mqQg1D83DRHG1lpjKN/j4QlFUEs+nQ7IZMDfuuKmDtgv8nmPuVmPNikE
         ztSO8oIGMAv8nX+vgc0yk07qtolB/0dVtSQxs9Xa+ynUedwcneSPgBIMJr9Wl9HzZSUD
         GekFbXiF1Gz1hVk/4Bz3OGcmiNMjzF4A0UCaERB9rTA/mFR215z0xHeM6IYarPPC5//m
         7ZJhDldnDYrAqi+8wgqUMvfSNL5ELhm2qCRr0vAbMUvnSEFxe072EzKdFLsIssj4TioM
         TGDw==
X-Gm-Message-State: ANoB5pkcJnBB6mD1t5WbdnwYBiI0xJc5UByKPS2+7uMHAT7AK1W72IrR
        V0Vq6U66Shj3k9nftIy9S2Tl3A==
X-Google-Smtp-Source: AA0mqf6XvaeEobvBP2i9JJSMxX4HladcBggX2v4svUzodqC/5Pwl4RQH84EVyVDtnyE1B3eGwqWNdQ==
X-Received: by 2002:ad4:44b4:0:b0:4c6:d91c:441f with SMTP id n20-20020ad444b4000000b004c6d91c441fmr37090751qvt.118.1669989345678;
        Fri, 02 Dec 2022 05:55:45 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id x1-20020ac84d41000000b0039a610a04b1sm4122237qtv.37.2022.12.02.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:55:45 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/3] mtd: spi-nor: Add additional octal-mode page program flags to be checked during SFDP 4BAIT parsing
Date:   Fri,  2 Dec 2022 08:55:38 -0500
Message-Id: <20221202135539.271936-3-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202135539.271936-1-nathan.morrison@timesys.com>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some support for automatically searching a chip's SFDP table for:

program commands: 1S-1S-8S, 1S-8S-8S

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index e4e87815ba94..e1b7547bf81e 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1089,6 +1089,14 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_4_4],
 					SPINOR_OP_PP_1_4_4_4B,
 					SNOR_PROTO_1_4_4);
+	if (pp_hwcaps & SNOR_HWCAPS_PP_1_1_8)
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_1_8],
+					SPINOR_OP_PP_1_1_8_4B,
+					SNOR_PROTO_1_1_8);
+	if (pp_hwcaps & SNOR_HWCAPS_PP_1_8_8)
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_8_8],
+					SPINOR_OP_PP_1_8_8_4B,
+					SNOR_PROTO_1_8_8);
 
 	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
 		if (erase_mask & BIT(i))
-- 
2.30.2

