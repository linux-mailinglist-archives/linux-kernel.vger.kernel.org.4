Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDC264A6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiLLSJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiLLSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6A5FB0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:51 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso4400723wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtPRqcnGnMJu3Lhjzyyt2cKQspWuIhSj33OJnrwCIF0=;
        b=dic+olsWhbv9Bdud+svAQHzZHug2lLj+vz7hVn19EyP7/8WryNdN+/Ac8gMCuGBZkU
         uYZwRo2TdqRr2c8T+9GTVOsdjr0TIK2krifSwPPBfojcXy38wrxCPtFgvLg/NfY76g7t
         8e/XIrRELDolos2n0GIeUN65WLoTfz2BkcpPlxs4fH3aWc+6fg+1UfhgDt9k/sQzXX/3
         qDcadSlnFCH7ygbGyjKNYFi0sxiqgIedHIgUjC5yA/Lw30AVOO8CAwWFHHIdo+IZigWT
         xbofJbDupAmmm8nls29Ol+1RZQDApqRklwcZZfKdp63b9my0f4ojm9npEEgof4KOHjHi
         lwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtPRqcnGnMJu3Lhjzyyt2cKQspWuIhSj33OJnrwCIF0=;
        b=seOzWEX8qjpWIUzcRogR6LFT09cxIFrGGEfnv5/MPzOtGXNnTP2PUB7MJ9UW6UFPER
         4OqaEMaa9b9Smk3IOXHDnxmRtjMfAxadIjuaaCn0EWbf5PIi3n7En1XKI10bnOYHZtiW
         KCEZ/Tm0VkcU4HjWGqhCgSpY6+3fNhW3O+6vrwR+A6Ysqzb+tGuAf8ruqMvdmc7+YgOv
         77KgBpYeZ9eSxSEV9gaVROyg6LdIBd8qp7gO1kcJdGylSURgp2Q9ckO6s3ORe3I2uzTZ
         9fMDxKBWv2RvxKPoY7xEbou0SilKZqiM1RIbKKATCff177pHgx+rrtyKK4BVWDyM945D
         U2wA==
X-Gm-Message-State: ANoB5pltXLVdqyvxtOej+8dWvUR5rhOTbIM65IXKMBGO4mJg6OpDo7Yu
        DTnegxBzmigD41xJ4kjlPHNWpA==
X-Google-Smtp-Source: AA0mqf6hJ3IGjFjKWW73Q+nkmeBNJDk+Q5JFDed1oLgVWBz52c2xQhXA5zTJWbzF7FiPmgqIn8pC9w==
X-Received: by 2002:a05:600c:4147:b0:3d2:2904:dfe9 with SMTP id h7-20020a05600c414700b003d22904dfe9mr2396260wmm.21.1670868471634;
        Mon, 12 Dec 2022 10:07:51 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:51 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 11/15] spi: dw: adjust size of mem_op
Date:   Mon, 12 Dec 2022 18:07:28 +0000
Message-Id: <20221212180732.79167-12-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In enhanced mode adjust the size of the data that can be sent or received
as this will then be used to set the NDF.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 75f5ce5f377ca..dff7b419af304 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -546,6 +546,13 @@ static void dw_spi_handle_err(struct spi_controller *master,
 	dw_spi_reset_chip(dws);
 }
 
+static int dw_spi_adjust_enh_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	op->data.nbytes = clamp_val(op->data.nbytes, 0, DW_SPI_NDF_MASK + 1);
+
+	return 0;
+}
+
 static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	if (op->data.dir == SPI_MEM_DATA_IN)
@@ -997,13 +1004,14 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 {
 	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
 	    !dws->set_cs) {
-		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
 		if (dws->caps & DW_SPI_CAP_EMODE) {
 			dws->mem_ops.exec_op = dw_spi_exec_enh_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
+			dws->mem_ops.adjust_op_size = dw_spi_adjust_enh_mem_op_size;
 		} else {
 			dws->mem_ops.exec_op = dw_spi_exec_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
+			dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
 		}
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
-- 
2.30.2

