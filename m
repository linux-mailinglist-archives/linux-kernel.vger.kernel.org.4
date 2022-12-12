Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26DE64A686
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiLLSIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiLLSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E05F78
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg10so6227267wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJpkfVk+rL7x2b/nU0sS6OBZ4oN2z+03SLnndpdgjrU=;
        b=coay2wl1/s4NDUzaAH2FelFujb/pQqhfoq0CyZRpTKnSSwiKcrzDD+0bA4jNeymiZq
         G6f/dJWF/DY2krfbefg0qOwxesLZjGG9xa095p/CHtnx54LwSN/fhQvceSupQdQjrTDu
         n9E3MRzbuQI1d3G16erMlXsPmD/wqVgbaDynUY2jXO9sWteacVm0Jm0htSHkQqurCeEL
         lbZiNQLFjqXhS98gCH2lw+ifkT5cVUP6awQdApA5uARg4sBrrqBSR03Fq6a2eRVB2vkg
         X3tUGPhyuNH5knqXkzt3HFg3bzQJ8dgYnSZu5Hp8LcAu7q9DqCXjL5fSNOF1q99kpYSi
         CuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJpkfVk+rL7x2b/nU0sS6OBZ4oN2z+03SLnndpdgjrU=;
        b=7seAwIMbOOdXh2+3C5Y8d1AOzg8V5ejFZycIrdWxzNea3CuZgcE9Ws2bsRwN1+jBAQ
         rA5BFeNUWFROOEE9v5+m/qkD6gHbyo7WOH58JA+/1QHsqgrGvEmuyzviSXXQrC3fgWF0
         Ly+9Sx8oHCyFVv8px1EX+lvm2KemLpoimPInKamYgVL9a3J6OG69ovZ8hQUzdMFhYiCs
         CYUJN7dJG0sOIlS5j+s0StoyCdb0VQgVvgmwJ88/zJvG3C2vz4iDwqjS9Pu2Eu1Eg6Rf
         4lvnC2734xVwOzQT7s720UnUhVWrZe+p8ck09sH1TUw/jHYwhdSdyUqmPWQbu3K91nsq
         drrg==
X-Gm-Message-State: ANoB5pniIgaKoaZ0DSiLQz3ClIWmKxyDRveWinyBXrj4dcAq/CDVhtn/
        jcBJzS1cwf6uGhLGzeIS7gvCIQ==
X-Google-Smtp-Source: AA0mqf5cAskf49A0ST3HZiQkCFRj43GVuLuMuTT6xeW8YU6CvinMbu6M9kKaMkfbKpgF9qujMnRkLw==
X-Received: by 2002:a7b:c5c4:0:b0:3d1:f234:12cc with SMTP id n4-20020a7bc5c4000000b003d1f23412ccmr12919514wmk.33.1670868463449;
        Mon, 12 Dec 2022 10:07:43 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:43 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 02/15] spi: dw: update NDF while using enhanced spi mode
Date:   Mon, 12 Dec 2022 18:07:19 +0000
Message-Id: <20221212180732.79167-3-sudip.mukherjee@sifive.com>
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

If the transfer of Transmit only mode is using dual/quad/octal SPI then
NDF needs to be updated with the number of data frames.
If the Transmit FIFO goes empty in-between, DWC_ssi masks the serial
clock and wait for rest of the data until the programmed amount of
frames are transferred successfully.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 77c23772bb3d9..8c47a4d14b666 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -346,7 +346,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
-	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
+	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO ||
+	    (cfg->tmode == DW_SPI_CTRLR0_TMOD_TO &&
+	     cfg->spi_frf != DW_SPI_CTRLR0_SPI_FRF_STD_SPI))
 		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
 
 	/* Note DW APB SSI clock divider doesn't support odd numbers */
-- 
2.30.2

