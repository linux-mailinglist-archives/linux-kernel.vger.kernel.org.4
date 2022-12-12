Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412CD64A6AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiLLSJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiLLSIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B56431
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so5940973wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PouWW9hJEcBYWxPnr69aXYCEVweHPkB0XRBnvDzgi8=;
        b=hJkN3oUoHsJGYB6mkIx6Fb/Ziw+PnIzJMRXqveDSUGoW4Qe88FEqNgv8X4Sumt2D8X
         zNo5iEI6lcKh7/8fV3Ljs5yOEudvyH0YLhMMDK6bk4wPRwuUvrIcRBnZHyXnHt0iydtl
         dY3FDCnzxyxHe48B6rAFV72pFRR1b+EkqInEEukRfTuqs8+vR0kZHxxFGGaBgIIUsSzp
         sYemv3inoKIZOS/+fwqnXQdZyP+ndDxc2aRYzvls7+GHBt5ZBxDGgTobD9Y1bLGrAE7h
         LeyV5W6jyvKVHlF5T/bgFltIAD4sRHeJpChBwcwKPSlkkpVPEk8ocTjQnsu/gzlXaA7h
         at9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PouWW9hJEcBYWxPnr69aXYCEVweHPkB0XRBnvDzgi8=;
        b=vuVrZ5/EVaWyQvdMxcdlVqBPBD1WszEL8iRYZJOQWGXYztut+Rczn12RiqxU+111HF
         gKnyft1UXPSwLWC0HV2ddAdxukL+pqS8IGgFKwY3zyweIxRWRU+WrIhAjuJP/NY4n0rL
         cLpdtnN7fZ6l6T/zdeIpaIiG1sX24lDzh/9sUnScEZbwScqGzrAAXaaZPTMhV7kCyNm/
         GOof35pCsTMhqcWwEpR5fHc/oCY3ZNAAaYL6aHOcv3db3KF9dZ2oRobOrpWa0WaGr7dN
         +l5HXSMiUitQw3qHwSliV2OfTzD83ZOLpihVif4fHnxDTl30FH/sR619Ajl/xSAmHF3E
         j+Fg==
X-Gm-Message-State: ANoB5pn5zvtGxziRTDZpy7IBJ4J8cpAnOMtOD6lQhctf8JeHIK47AXXn
        CSF0lt2Ci5N0gTcxIeDqcojQ0Q==
X-Google-Smtp-Source: AA0mqf6KuqKuwKMEwSFXB8pvf+HvVTEihfH4JWO5hjhU1Jcfgqd81BUXqa0E90oL+N7afvvLGkNRZw==
X-Received: by 2002:a05:600c:2215:b0:3cf:6d5b:875e with SMTP id z21-20020a05600c221500b003cf6d5b875emr13385573wml.12.1670868472465;
        Mon, 12 Dec 2022 10:07:52 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:52 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 12/15] spi: dw: Add retry for enhanced spi mode
Date:   Mon, 12 Dec 2022 18:07:29 +0000
Message-Id: <20221212180732.79167-13-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
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

If the connection to the spi device is not stable then the transfer can
fail. Add retry for DW_SPI_WAIT_RETRIES times and print error if it still
fails.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index dff7b419af304..cef56acd8d8fd 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -906,7 +906,7 @@ static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_o
 	}
 }
 
-static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int dw_spi_try_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
@@ -991,6 +991,21 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	return ret;
 }
 
+static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	int retry, ret = -EIO;
+
+	for (retry = 0; retry < DW_SPI_WAIT_RETRIES && ret != 0; retry++)
+		ret = dw_spi_try_enh_mem_op(mem, op);
+
+	if (retry == DW_SPI_WAIT_RETRIES)
+		dev_err(&dws->master->dev, "Retry of enh_mem_op failed\n");
+
+	return ret;
+}
+
 /*
  * Initialize the default memory operations if a glue layer hasn't specified
  * custom ones. Direct mapping operations will be preserved anyway since DW SPI
-- 
2.30.2

