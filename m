Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88678731531
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbjFOK0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbjFOK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:26:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1BAC;
        Thu, 15 Jun 2023 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686824786; x=1718360786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r63UoZs8IydR3AxSZrbmRM0w8YM1nnTBQ0jMQ1No3s8=;
  b=bZvZS+RS107VES6LpI/JztcqLmLPdVSONKzM+Smdlpj+ydgvTskoASF6
   l25yuifnNfsldb9lYxxonLvKEPKa/YwLHuhrEu9CUUUYyl5scO6HTIlm0
   i7CWZfg087J8Y5BtAw/NzufHWQMdJA6VnVi3bgB7dsfKn/YfD7A7DgVD/
   Ud6shAaYK+25nIEZ3KSRh0q059CzNFgytnjJgmxbCBS9gl/uP+WyavTnm
   f2FBYBhehrw83WhW7v7BPUZ5jLuqnYlI05XyDPUxWwxpyeecZA4g/Hb4N
   kbHMANZ7hbeuxhqe/K5csPAsdUukMEVVA8ZxsFEF9ehypnurslV7N0BS9
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="218002511"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 03:26:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 03:26:25 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 03:26:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <amahesh@qti.qualcomm.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH] misc: fastrpc: check return value of devm_kasprintf()
Date:   Thu, 15 Jun 2023 13:25:46 +0300
Message-ID: <20230615102546.581899-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 3abe3ab3cdab ("misc: fastrpc: add secure domain support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi,

This has been addressed using kmerr.cocci script proposed for update
at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/

 drivers/misc/fastrpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..ea69c79ba848 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2213,6 +2213,9 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	fdev->miscdev.fops = &fastrpc_fops;
 	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s%s",
 					    domain, is_secured ? "-secure" : "");
+	if (!fdev->miscdev.name)
+		return -ENOMEM;
+
 	err = misc_register(&fdev->miscdev);
 	if (!err) {
 		if (is_secured)
-- 
2.34.1

