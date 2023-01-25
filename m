Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698FC67AB61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjAYILO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjAYILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:11:12 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AA346733;
        Wed, 25 Jan 2023 00:11:10 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30P8As6I011847;
        Wed, 25 Jan 2023 02:10:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674634254;
        bh=eNbchGJC+m7Z4S8cdQhmzaRMkS8co3zGkOBT6wpgpHk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=j7gB/YsZlksX1b4LpewIFD5sKJil4cqsuQtgAiuJkS29kXj67YzEKnfLj+gEuVefd
         tpNf+27cln3H9Mvu+IH8mRrwlIGgBNWT4Ydbap5Fu03gL1UL+QZ2uHAstWTbCyTLZZ
         qeFjZX3mZXLkD6VNnSexFwvKxtMTiL7W63uV0vJY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30P8AsLI124978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 02:10:54 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 02:10:53 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 02:10:53 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30P8Aqag075469;
        Wed, 25 Jan 2023 02:10:53 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Takahiro.Kuwano@infineon.com>, Pratyush Yadav <ptyadav@amazon.de>
Subject: [PATCH v2 1/4] spi: cadence-quadspi: Reset CMD_CTRL Reg on cmd r/w completion
Date:   Wed, 25 Jan 2023 13:40:20 +0530
Message-ID: <20230125081023.1573712-2-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125081023.1573712-1-d-gole@ti.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one leaves the CQSPI_REG_CMDCTRL in an unclean state this may cause
issues in future command reads. This issue came to light when some flash
reads in STIG mode were coming back dirty.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 676313e1bdad..6030da942c6e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -549,6 +549,9 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 		memcpy(rxbuf, &reg, read_len);
 	}

+	/* Reset CMD_CTRL Reg once command read completes */
+	writel(0, reg_base + CQSPI_REG_CMDCTRL);
+
 	return 0;
 }

@@ -613,7 +616,12 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 		}
 	}

-	return cqspi_exec_flash_cmd(cqspi, reg);
+	ret = cqspi_exec_flash_cmd(cqspi, reg);
+
+	/* Reset CMD_CTRL Reg once command write completes */
+	writel(0, reg_base + CQSPI_REG_CMDCTRL);
+
+	return ret;
 }

 static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
--
2.25.1

