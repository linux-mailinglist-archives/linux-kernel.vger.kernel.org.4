Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD273D16C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjFYOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFYOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:21:40 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF051B1;
        Sun, 25 Jun 2023 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687702899; x=1719238899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvMgTuAn0uYdFTGp+Tc21ooe+rx3n9Gtbjp0LnEzoh8=;
  b=GgKMlIDbbeVWYpb8SvoHoqsXCHUOtOPJcGEBCwJ8nexHvGl5hssu3K6P
   FhiJBn6JPQMhK6vCM7370V7IkFvSKc9HNyIkTRyqPQwG+eOt4tA4Z6mfy
   24WNvX1QAylO4QbiWyQU/yG3JYkv7GmfmKqOcmo3P/Zu4rLPF/m6PMgA2
   s=;
X-IronPort-AV: E=Sophos;i="6.01,157,1684800000"; 
   d="scan'208";a="12280813"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 14:21:37 +0000
Received: from EX19D016EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id F3A3F40D47;
        Sun, 25 Jun 2023 14:21:36 +0000 (UTC)
Received: from EX19D034EUC001.ant.amazon.com (10.252.61.138) by
 EX19D016EUA004.ant.amazon.com (10.252.50.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 25 Jun 2023 14:21:35 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D034EUC001.ant.amazon.com (10.252.61.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 25 Jun 2023 14:21:35 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Sun, 25 Jun 2023 14:21:35
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 1F5066DA4; Sun, 25 Jun 2023 14:21:34 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <giometti@enneenne.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <farbere@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>
Subject: [PATCH 5/5] pps: clients: gpio: enable pps pulse-width calculations based on device-tree
Date:   Sun, 25 Jun 2023 14:21:34 +0000
Message-ID: <20230625142134.33690-6-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625142134.33690-1-farbere@amazon.com>
References: <20230625142134.33690-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds setting of PPS_WIDTHASSERT and PPS_WIDTHCLEAR modes to
enable PPS pulse-width calculation.

Width calculation will be enabled if
 - assert-pulse-width
 - clear-pulse-width
boolean properties exist in device-tree.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/pps/clients/pps-gpio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index a61dc1299ce9..ca4b8047e924 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -33,6 +33,8 @@ struct pps_gpio_device_data {
 	struct timer_list echo_timer;	/* timer to reset echo active state */
 	bool assert_falling_edge;
 	bool capture_clear;
+	bool assert_pulse_width;
+	bool clear_pulse_width;
 	unsigned int echo_active_ms;	/* PPS echo active duration */
 	unsigned long echo_timeout;	/* timer timeout value in jiffies */
 };
@@ -113,6 +115,10 @@ static int pps_gpio_setup(struct device *dev)
 	data->assert_falling_edge =
 		device_property_read_bool(dev, "assert-falling-edge");
 	data->capture_clear = device_property_read_bool(dev, "capture-clear");
+	data->assert_pulse_width =
+		device_property_read_bool(dev, "assert-pulse-width");
+	data->clear_pulse_width =
+		device_property_read_bool(dev, "clear-pulse-width");
 
 	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
 	if (IS_ERR(data->echo_pin))
@@ -186,6 +192,10 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	if (data->capture_clear)
 		data->info.mode |= PPS_CAPTURECLEAR | PPS_OFFSETCLEAR |
 			PPS_ECHOCLEAR;
+	if (data->assert_pulse_width)
+		data->info.mode |= PPS_WIDTHASSERT;
+	if (data->clear_pulse_width)
+		data->info.mode |= PPS_WIDTHCLEAR;
 	data->info.owner = THIS_MODULE;
 	snprintf(data->info.name, PPS_MAX_NAME_LEN - 1, "%s.%d",
 		 pdev->name, pdev->id);
@@ -199,6 +209,10 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	pps_default_params = PPS_CAPTUREASSERT | PPS_OFFSETASSERT;
 	if (data->capture_clear)
 		pps_default_params |= PPS_CAPTURECLEAR | PPS_OFFSETCLEAR;
+	if (data->assert_pulse_width)
+		pps_default_params |= PPS_WIDTHASSERT;
+	if (data->clear_pulse_width)
+		pps_default_params |= PPS_WIDTHCLEAR;
 	data->pps = pps_register_source(&data->info, pps_default_params);
 	if (IS_ERR(data->pps)) {
 		dev_err(dev, "failed to register IRQ %d as PPS source\n",
-- 
2.40.1

