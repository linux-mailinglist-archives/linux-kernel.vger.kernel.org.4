Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C6611F25
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ2Bp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Bpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:45:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203AF1DC0B7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:45:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h2so6280041pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qM8nxynBORd1dgNqUGTIshaYiyUYjNtO678amsvAS0I=;
        b=UScndsRn651QoQYPyDtDE1dxqK1J2kHtPg+BMI0KUWd1dVnmpXxqw/yvtk/NYRmsYl
         4SGTHXSm2FXQ1SNGbsa9cZcvNbjjYOk91pj5+HzccdtZtzB5pTduj8Rr+gBbMaXDActE
         gvlaTZJIy4DsAItV2zRb+Pziit7YfXcbnZ7H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qM8nxynBORd1dgNqUGTIshaYiyUYjNtO678amsvAS0I=;
        b=iwuv4j/0VevpTRJ6dCJ0MUU/Ugq1fcEtv9noSHCaLpHIeHqw54PoKX1R/G6D+zJ4Fw
         cNG/1VkxZPzvdmMNpgbbR2xPY6w4u+UbgBuAvpapxolI5JXIxQkCV8kq+WC1p+T/eb3H
         H9c8GEfjOn3amBSNfQebtnn+0OBR17KscWquZg5UfllS4+HcpBwVZ1O18WDkx7BYWnYT
         /o23gBzvo+ItHlEAnitlS6x9WpwycPuU5nO9tfiRuFL0VmkovQ92ojWIgmpG+zbe4MK5
         7BSY7hjTXDx5AyCwNsptFoaxFccd/70fcoc+vz9JG0ZWKY4KbHEjz20+VDgt89ULd8lP
         LpwA==
X-Gm-Message-State: ACrzQf1Ejt/5QUuhNjIJsYpUmpHehaEidu3eh+sDvbrpe3SV8HGLye6o
        G83E2kM0vdu6XXU12bL0h02Ygw==
X-Google-Smtp-Source: AMsMyM4XRnoETEL36K04tlkw4gfy07JBumLkFfrx7BJvdcN1bLC9XX2PCuvYdYrUhje2h2okggUdrA==
X-Received: by 2002:a65:5c0c:0:b0:46e:f582:7378 with SMTP id u12-20020a655c0c000000b0046ef5827378mr2151362pgr.120.1667007946718;
        Fri, 28 Oct 2022 18:45:46 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id k6-20020a170902ce0600b00186e2b3e12fsm85978plg.261.2022.10.28.18.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 18:45:46 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] usb: ehci-pci: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 18:45:34 -0700
Message-Id: <20221028184507.v2.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver often takes on the order of 8ms to start, but every little
bit counts. It shouldn't have many cross-device dependencies to
race with, nor racy access to shared state with other drivers, so this
should be a relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---

Changes in v2:
 - Add Alan's Ack

 drivers/usb/host/ehci-pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 17f8b6ea0c35..4b148fe5e43b 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -411,11 +411,12 @@ static struct pci_driver ehci_pci_driver = {
 	.remove =	ehci_pci_remove,
 	.shutdown = 	usb_hcd_pci_shutdown,
 
-#ifdef CONFIG_PM
 	.driver =	{
-		.pm =	&usb_hcd_pci_pm_ops
-	},
+#ifdef CONFIG_PM
+		.pm =	&usb_hcd_pci_pm_ops,
 #endif
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init ehci_pci_init(void)
-- 
2.38.1.273.g43a17bfeac-goog

