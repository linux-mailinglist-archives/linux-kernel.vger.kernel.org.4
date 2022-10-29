Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8F611F27
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ2BqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJ2Bpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:45:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EFA1DF43D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:45:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso11391272pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxI9jHgzXaAhc4fAzAdj535D2gJQxDQasWe16RCa7hY=;
        b=btNSggHejSRBsGiBwnCHivRNhwZ21zugNTd9CYmEGhneNzfLE3Yc+h0amKP0iHTzNy
         W4uQUb8DRtxJwiCVdUFo8AowXQrCJHzXaVimsHfqb0ASDk4Y2ex+RiXI5uF48zjPCvgq
         Vg7Ei/3f1w2l7p78GCLdYa/8RgH73Qgeqx/JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxI9jHgzXaAhc4fAzAdj535D2gJQxDQasWe16RCa7hY=;
        b=GU6n/HV3Ys0I9eWVLkrtNqCzVp+XHjOeeG/KSTeLrMWva70KObrBtfL+Y3Jwry2UdA
         Db0qmatv4eLBsvQf6BFFLGGUWRwWyJefaPHxtt2trT3gFCDhP6Lw/+HWrfUNCz4BVSvS
         pJSRxaXVR8L2nZADDSio7QIqgv4XouDYY75FELUuTapxTCtBXZYGYqKbIQ0p5k2FAEG+
         A/xrzjV/X6b5ZbgYGZQHHIMj5kEzml35FkYEEODLCEj3TiDd65gU4k12DhekcxWV6IRy
         z8pmPSYfdPCLXQtXQbLNz5hEA0w7h1RWhw6WMiNAQkOqp6bEK4eXgRdilZegcVQ3x+cr
         N7RA==
X-Gm-Message-State: ACrzQf1P8u/RQznTkNq48m0v/ZA7HpckFyq6SQGKEdiJqH8UcWIcX8ry
        HjjpK11/pb/Jrh0Tw1T3W4CcGw==
X-Google-Smtp-Source: AMsMyM4TXyjJQWrPr0aWD4niC9hvjhk0Vgp8VK1Dql/gMk3EKG/HNUNFtw341fCTkGVMRZH2lBOLEA==
X-Received: by 2002:a17:902:e892:b0:187:35b:5a50 with SMTP id w18-20020a170902e89200b00187035b5a50mr2052841plg.160.1667007948593;
        Fri, 28 Oct 2022 18:45:48 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id v17-20020aa799d1000000b0056bb191f176sm122684pfi.14.2022.10.28.18.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 18:45:48 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 2/2] usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 18:45:35 -0700
Message-Id: <20221028184507.v2.2.I5a309231785d3a4e37118a25e84f5caa0136a343@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028184507.v2.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
References: <20221028184507.v2.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
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

This driver often takes on the order of 10ms to start, but in some cases
takes more than 100ms. It shouldn't have many cross-device dependencies
to race with, nor racy access to shared state with other drivers, so
this should be a relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - Move outside #ifdef CONFIG_PM (oops; thanks Alan)

 drivers/usb/host/xhci-pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 40228a3d77a0..5bbb1fed32d2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -687,11 +687,12 @@ static struct pci_driver xhci_pci_driver = {
 	/* suspend and resume implemented later */
 
 	.shutdown = 	usb_hcd_pci_shutdown,
-#ifdef CONFIG_PM
 	.driver = {
-		.pm = &usb_hcd_pci_pm_ops
-	},
+#ifdef CONFIG_PM
+		.pm = &usb_hcd_pci_pm_ops,
 #endif
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init xhci_pci_init(void)
-- 
2.38.1.273.g43a17bfeac-goog

