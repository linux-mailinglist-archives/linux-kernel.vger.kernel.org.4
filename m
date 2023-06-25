Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4773D170
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjFYOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjFYOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:21:41 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FACDE4C;
        Sun, 25 Jun 2023 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687702900; x=1719238900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzkmriAJdrDXAPOXkzYgl+u0BMBeF3csMzsxYQTdpVE=;
  b=v+j4JMfZ7mgF092SNpNm3yrnhkLLXRlEk5L62XHeiEMLTiawXfi6av28
   yhX3SXnnZvQo0dj7zx77YGSxrcAAuLaVXyjFDmezGXQjxcPbNswqM7B4r
   zbejXwDy1uSMCR8gOpkVkvmeCWqBodmRpVGriD/V+15aQsj6bsjKeGg0s
   o=;
X-IronPort-AV: E=Sophos;i="6.01,157,1684800000"; 
   d="scan'208";a="336051270"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 14:21:37 +0000
Received: from EX19D005EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id EEDCB40AEB;
        Sun, 25 Jun 2023 14:21:35 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D005EUA004.ant.amazon.com (10.252.50.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 25 Jun 2023 14:21:34 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1118.26 via Frontend Transport; Sun, 25 Jun 2023 14:21:34
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 18A034F0D; Sun, 25 Jun 2023 14:21:34 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <giometti@enneenne.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <farbere@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>
Subject: [PATCH 3/5] pps: clients: gpio: add option to set capture-clear from device-tree
Date:   Sun, 25 Jun 2023 14:21:32 +0000
Message-ID: <20230625142134.33690-4-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625142134.33690-1-farbere@amazon.com>
References: <20230625142134.33690-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable capture clear events if "capture-clear" boolean property exists
in device-tree.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/pps/clients/pps-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..a61dc1299ce9 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -112,6 +112,7 @@ static int pps_gpio_setup(struct device *dev)
 
 	data->assert_falling_edge =
 		device_property_read_bool(dev, "assert-falling-edge");
+	data->capture_clear = device_property_read_bool(dev, "capture-clear");
 
 	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
 	if (IS_ERR(data->echo_pin))
-- 
2.40.1

