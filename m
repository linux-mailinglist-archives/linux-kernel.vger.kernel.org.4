Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8CD685EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjBAFFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBAFFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:05:16 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482D4ED23
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:05:13 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e21-20020a9d5615000000b006884e5dce99so6099346oti.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC6IpfrRtaolTBtBXQnK4Tbg6VHGS7OhoKF9+jdKZ1M=;
        b=LteX0C8RuM8rK8FapkxofHtKEc6fX0UhGEoMI0Qd+HKqhnAPKcRuXQWaQDNN47aopu
         O3qNQgSCMjlVBvX7MJT6mHxgL1EtGLY6vvbUZs3iOEAbcyOpdWVgGv+0QQX8gQIAnuRT
         X12kakC2ST0SWP2NGUt+apxREHRo1O75zBJsZtUTjdyO13MDWuCMpmT8ekypBwWDQzLR
         +qe+WrhWZN99tLglWeqEI1qQAFVSCIOtiEQv3KWDLVow8tY6mGfCT8ec9XDYc0IpX/Wd
         vW1xqV7KfbrDbt6SnwjjfeqVOSRIvqohNNw3uLFxynzTgURirnQwYsFpADgSxO8klaqm
         /rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MC6IpfrRtaolTBtBXQnK4Tbg6VHGS7OhoKF9+jdKZ1M=;
        b=z/yDTHlVHjFaN1aYc9Lfd6epXUyvAMrknktlB8uukKtKoTyavwmJi15C9GS70MJXZW
         0aShRATuLxb1dC9OPjGIDgi/qUufUyJ+f92LOF/sgJAvYkpPjC3kFyy8LJumMl8X8r3f
         LglN3eywxvzMjaUUFziL2a4crTHFWoyPOxKQzhe2OCWy8at8n1HB+PKZtQK+X1w1xo+F
         5WX2yVSfQ9tI1MnIw77R4iMwuKkGZyOvCsWZtL8reKJsqbdUt/gxCXwsCoocVmRrTgSN
         zRBqJhkDCW+X8GQFhTKnD8iXCDmEpj+KeGp7n6WMnssEGhx18kLWPaXVZJ9WQtKJQFe5
         +s2A==
X-Gm-Message-State: AO0yUKXNy+w7SKaTeUFl1JqiXKuLT/Go4Il1KHhiBvksF4thkuIYUDaa
        gmAx0tp53EQmPwLG6buEJSbdAw==
X-Google-Smtp-Source: AK7set81jzCzLEL3SjggV9XQelmZwnU7B4y5JCAsagVTD3lBddTVFU+BKa0iLn7v7l2x9enmhSnkFg==
X-Received: by 2002:a9d:6243:0:b0:68b:c67c:5d0b with SMTP id i3-20020a9d6243000000b0068bc67c5d0bmr657318otk.10.1675227913459;
        Tue, 31 Jan 2023 21:05:13 -0800 (PST)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id cd26-20020a056830621a00b0068be61a7ac6sm1123445otb.56.2023.01.31.21.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 21:05:13 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 1/2] spi: intel: Fix device private data and PR_NUM for BXT
Date:   Wed,  1 Feb 2023 02:04:54 -0300
Message-Id: <20230201050455.505135-2-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201050455.505135-1-mauro.lima@eclypsium.com>
References: <20230201050455.505135-1-mauro.lima@eclypsium.com>
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
    0xa0a4 - Intel® 500 Series Chipset Family On-Package Platform Controller Hub
    0x02a4 - Intel® 400 Series Chipset Family On-Package PCH
    0x06a4 - Intel® 400 Series Chipset Family Platform Controller Hub
    0x34a4 - Intel® 495 Chipset Family On-Package
    0xa3a4 - Intel® B460 and H410 Chipset

According to documentation BXT has five PR registers.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
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

