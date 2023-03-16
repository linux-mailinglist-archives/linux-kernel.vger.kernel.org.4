Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEE6BCC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCPKHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCPKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:07:46 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 03:07:21 PDT
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2657CA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1480; q=dns/txt; s=iport;
  t=1678961242; x=1680170842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OVXQaSJYs4YrFkVhAm2aBqtWlRGSeNBSoPr3E/J8Wu8=;
  b=KOOFyQWa1icG62wj/X5bBpC6Q0qdhiq8gvrMjE5lWQ2RVlk9RZ4i4bzw
   bNdTtEmZjZDLEqfRECEbpP/5ZPn+JxvXhBXc02YUy86UR0Q97UoEav1hM
   YvxbpCM7A1ZQqjBy7jDwJEffQnINHykb1e2WWlyP49cpQiZnFXaqPt2sS
   o=;
X-IronPort-AV: E=Sophos;i="5.98,265,1673913600"; 
   d="scan'208";a="80946565"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Mar 2023 10:04:09 +0000
Received: from sjc-ads-7158.cisco.com (sjc-ads-7158.cisco.com [10.30.217.233])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 32GA45lM002360
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Mar 2023 10:04:08 GMT
Received: by sjc-ads-7158.cisco.com (Postfix, from userid 1776881)
        id C1D32CBEFAB; Thu, 16 Mar 2023 03:04:04 -0700 (PDT)
From:   Bartosz Wawrzyniak <bwawrzyn@cisco.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com,
        mawierzb@cisco.com, Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Subject: [PATCH] net: macb: Set MDIO clock divisor for pclk higher than 160MHz
Date:   Thu, 16 Mar 2023 10:03:39 +0000
Message-Id: <20230316100339.1302212-1-bwawrzyn@cisco.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.217.233, sjc-ads-7158.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently macb sets clock divisor for pclk up to 160 MHz.
Function gem_mdc_clk_div was updated to enable divisor
for higher values of pclk.

Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
---
 drivers/net/ethernet/cadence/macb.h      | 2 ++
 drivers/net/ethernet/cadence/macb_main.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 14dfec4db8f9..c1fc91c97cee 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -692,6 +692,8 @@
 #define GEM_CLK_DIV48				3
 #define GEM_CLK_DIV64				4
 #define GEM_CLK_DIV96				5
+#define GEM_CLK_DIV128				6
+#define GEM_CLK_DIV224				7
 
 /* Constants for MAN register */
 #define MACB_MAN_C22_SOF			1
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6e141a8bbf43..8708af6d25ed 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2641,8 +2641,12 @@ static u32 gem_mdc_clk_div(struct macb *bp)
 		config = GEM_BF(CLK, GEM_CLK_DIV48);
 	else if (pclk_hz <= 160000000)
 		config = GEM_BF(CLK, GEM_CLK_DIV64);
-	else
+	else if (pclk_hz <= 240000000)
 		config = GEM_BF(CLK, GEM_CLK_DIV96);
+	else if (pclk_hz <= 320000000)
+		config = GEM_BF(CLK, GEM_CLK_DIV128);
+	else
+		config = GEM_BF(CLK, GEM_CLK_DIV224);
 
 	return config;
 }
-- 
2.33.0

