Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35068702D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBAU4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjBAU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:56:02 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99097C322
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:55:35 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-169ba826189so3234158fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeLd/Nd4b4e469QD3joHZ1BOJX9DeXbQDNwvbYRUV1I=;
        b=Le0E1lHqJU+F0j47fvyEO9e4ol9sdGF2DXOZN2ylw9JSEpo7B4hPdyBrBuceN/bQc6
         YtSUf4JWAT2lUeyOEuUjZz31bV+E5/l//+MZyNp5yl9KOMd8srgpB59y3HBDN7w9lSzV
         I+uyXCpdRpY6J/Mkyl7QL3oD3GxQrUyaPj/b+MC6L/uq7PaSOJvEWcmjHsENhssd/uJA
         0nLbepS5t6oBznb97YZJ3cEpsqQfeGFfz/bfTzYvOxXZzi9ofgYLo1A9j82Tu9582Md6
         fwxrE+r/0j/c+7YGxh9T+Go/v5rC+8x6iYRz5Gy+4Y/eYHgE6+3IXBthS2IOzkD0st4b
         LGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeLd/Nd4b4e469QD3joHZ1BOJX9DeXbQDNwvbYRUV1I=;
        b=kH4yraSfsl0wAmNA65sTUOSUa+HfI0JQFq5nT7Kil4xsNaKcjgbMs/VVnNLiOYGHGg
         WKjDB9avVSj5RF2yG7VFbAA7f3S43HjDaXg21pQnAdcr4EJe5qVeZGrxt1fcvcPkgnpo
         qWjQRoO7XBAgoxICCVslATI2X93ceDujs+9/Q47d+WQTHbZRptxxnvwDuDjVl8tpt/te
         4wKmDd9hAq5lZTq9HX8VQLva7tnMLH1hI6sNu+r3l064BMOLRz3BT1jOdkYK9oIDzAr9
         vZa/lQocgWhS17N1uBlB35OUZhPTtw8au1/iMqAzNhVq1kSBNBeyVbnF6GzaBVbjazlo
         Ldgg==
X-Gm-Message-State: AO0yUKV/7+eMSX+O1eLQ0evUje0RGMTg6UkbuMtF87dDCqGCyhcF1Q5r
        NDAs0p33sPghfSjYMOep1SM64Q==
X-Google-Smtp-Source: AK7set980F6LsXrVeJT1vu+ZMKBzX4HCzpLuzvY39OmUtsfPjVmLJSCay1+rzifobMCzBbyoD5zFLg==
X-Received: by 2002:a05:6871:441:b0:163:20a2:ddde with SMTP id e1-20020a056871044100b0016320a2dddemr2189604oag.42.1675284934880;
        Wed, 01 Feb 2023 12:55:34 -0800 (PST)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a056870971200b0014fe4867dc7sm8245908oaq.56.2023.02.01.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:55:34 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, alok.a.tiwari@oracle.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH v2 1/2] spi: intel: Fix device private data and PR_NUM for Broxton controllers
Date:   Wed,  1 Feb 2023 17:54:54 -0300
Message-Id: <20230201205455.550308-2-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201205455.550308-1-mauro.lima@eclypsium.com>
References: <20230201205455.550308-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some private data fields have to change from bxt_info to cnl_info.
Here is the list of Device IDs with the respective documentation taken for
validation:
    0xa0a4 - Intel® 500 Series Chipset Family On-Package PCH
    0x02a4 - Intel® 400 Series Chipset Family On-Package PCH
    0x06a4 - Intel® 400 Series Chipset Family Platform Controller Hub
    0x34a4 - Intel® 495 Chipset Family On-Package
    0xa3a4 - Intel® B460 and H410 Chipset

According to documentation Broxton controller type has five PR registers.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 10 +++++-----
 drivers/spi/spi-intel.c     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index f0d532ea40e8..10fa3a7fa4f5 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -60,12 +60,12 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 }
 
 static const struct pci_device_id intel_spi_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x02a4), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x06a4), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x02a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x06a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x18e0), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x19e0), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x1bca), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x34a4), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x34a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x38a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x43a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
@@ -75,11 +75,11 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index f619212b0d5c..1052fb4b7973 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -104,7 +104,7 @@
 #define BXT_PR				0x84
 #define BXT_SSFSTS_CTL			0xa0
 #define BXT_FREG_NUM			12
-#define BXT_PR_NUM			6
+#define BXT_PR_NUM			5
 
 #define CNL_PR				0x84
 #define CNL_FREG_NUM			6
-- 
2.39.1

