Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12264080A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiLBNzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiLBNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:55:46 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF2FBE4EC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:55:45 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a27so5121564qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=L5WmemJAO6bGk5YpyHsWgaHHqP8pQGgrhBueew2H9B5Ebuoy8da3D/W/R9F+NDZeiX
         Q1nKwO1vdtSB39YyxX5uuG4BhSutxQgLJdXYdyePxV0pyf4UhHyqMgoW1B0Ph526ZURO
         ZyN/xnkiLF/TdMISWsj0uIMog1cQZ2X8xFhoY/bMFrwZIiWp2PpOxFCeaVTUZQDWjgf6
         hJoP5YJ7c5Ao7nWD4+KTTGOhPe6ujxfIa41ZWwy5a8saDxUfKYxcjbPs78f8LQuM7ysn
         q/l9orAO4UjDMjYUCDLg8DxBEUnuhlFkvcmuJ8QPapS7rT18UKjNVZyOp+eYQ4fTQzsy
         t7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=T+yYX61U+19sqojiCein1GIrKzCn0D7jDlp1RqyUBmpMKUU/LoEqSvOWfMzhRYSKWs
         kp1dXZ4xMrRl+80f4NIvXvlt3FQ5N+uxtCjSsBrfC5gRM78hBxAadI9FBAsnsSp9OV9F
         ZL8eZUWtn1btVBqIrt39y0R/qBgz4UdGv9uivNwFpmHXFc0xa7pulBvAFI3VWKcdRmyb
         HzjRqkOAj+qC5ZZsVYBi9Fdz9IIjY0Upjvi8/2fl/bJ0cm57cE7whjWbZNhH15/h5zGW
         6VX6Rl5MvV1zOBYCqgEAKS3+KD/0YKiQ3RRwNgosl27/IRiOXRrnlzEmo5a31nxWSjRp
         AW0Q==
X-Gm-Message-State: ANoB5pnegCkX5d92tws2m2IEtJKJko/twsCG1bub47vDsAeVBWw3yZte
        5XFU2egprQtgPxBM/c26Ql6Lbg==
X-Google-Smtp-Source: AA0mqf6RbbADM2P3deLJnaVHTUgFXtpfJumgU78/FLtKT5oqsLxeyyOlmZY8ImRuVkI9x6MEslqLdA==
X-Received: by 2002:a05:622a:590e:b0:3a4:fcde:733d with SMTP id ga14-20020a05622a590e00b003a4fcde733dmr67306718qtb.269.1669989344644;
        Fri, 02 Dec 2022 05:55:44 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id x1-20020ac84d41000000b0039a610a04b1sm4122237qtv.37.2022.12.02.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:55:44 -0800 (PST)
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
Subject: [PATCH v4 1/3] mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with new octal modes as per JEDEC JESD216F
Date:   Fri,  2 Dec 2022 08:55:37 -0500
Message-Id: <20221202135539.271936-2-nathan.morrison@timesys.com>
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

This adds the new bit fields for
reading: 1S-1S-8S, 1S-8S-8S, 1D-8D-8D
programming: 1S-1S-8S, 1S-8S-8S

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/sfdp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 2257f1b4c2e2..e4e87815ba94 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -953,11 +953,16 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ SNOR_HWCAPS_READ_1_1_1_DTR,	BIT(13) },
 		{ SNOR_HWCAPS_READ_1_2_2_DTR,	BIT(14) },
 		{ SNOR_HWCAPS_READ_1_4_4_DTR,	BIT(15) },
+		{ SNOR_HWCAPS_READ_1_1_8,       BIT(20) },
+		{ SNOR_HWCAPS_READ_1_8_8,       BIT(21) },
+		{ SNOR_HWCAPS_READ_1_8_8_DTR,   BIT(22) },
 	};
 	static const struct sfdp_4bait programs[] = {
 		{ SNOR_HWCAPS_PP,		BIT(6) },
 		{ SNOR_HWCAPS_PP_1_1_4,		BIT(7) },
 		{ SNOR_HWCAPS_PP_1_4_4,		BIT(8) },
+		{ SNOR_HWCAPS_PP_1_1_8,         BIT(23) },
+		{ SNOR_HWCAPS_PP_1_8_8,         BIT(24) },
 	};
 	static const struct sfdp_4bait erases[SNOR_ERASE_TYPE_MAX] = {
 		{ 0u /* not used */,		BIT(9) },
-- 
2.30.2

