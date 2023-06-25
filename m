Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C8D73D16E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFYOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFYOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:21:41 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF4E4E;
        Sun, 25 Jun 2023 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687702901; x=1719238901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xOf7NZnUQximwIOSiAVcKVvthWSLkf2RWP5JPwMyfkM=;
  b=hlCan534UHgxcqsIhzGCfYS7fTjpM9iVqAOu3rONS9iU7GSRxGXD4hzy
   gQCa+7xIiRSFeyj4SF5NpC0RuKjcU9Lf59QN3ZPqOt9Wip+FX3/tQ10LL
   H+G3cO8wQTiaD9BtUZUNZMkfs2T/9k8qYXSjePKhoj8MXfzrctKtvcfzK
   s=;
X-IronPort-AV: E=Sophos;i="6.01,157,1684800000"; 
   d="scan'208";a="340868763"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 14:21:38 +0000
Received: from EX19D005EUB004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 6FE8D40BBE;
        Sun, 25 Jun 2023 14:21:35 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D005EUB004.ant.amazon.com (10.252.51.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 25 Jun 2023 14:21:34 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Sun, 25 Jun 2023 14:21:34
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 1C00B4F91; Sun, 25 Jun 2023 14:21:34 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <giometti@enneenne.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <farbere@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>
Subject: [PATCH 4/5] dt-bindings: pps: pps-gpio: introduce pulse-width properties
Date:   Sun, 25 Jun 2023 14:21:33 +0000
Message-ID: <20230625142134.33690-5-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625142134.33690-1-farbere@amazon.com>
References: <20230625142134.33690-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new optional properties to calculate PPS pulse-width in nano
seconds:
 - assert-pulse-width
 - clear-pulse-width

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 Documentation/devicetree/bindings/pps/pps-gpio.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 8d588e38c44e..9ecfd5fb3b63 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -18,6 +18,12 @@ Optional properties:
                  opposite of the assert edge (if assert is rising-edge then
                  clear is falling-edge and if assert is falling-edge then
                  clear is rising-edge).
+- assert-pulse-width: when present, assert pulse width will be calculated in
+                      nano seconds.
+                      It should be enabled only if 'capture-clear' is enabled.
+- clear-pulse-width: when present, clear pulse width will be calculated in
+                     nano seconds.
+                     It should be enabled only if 'capture-clear' is enabled.
 
 Example:
 	pps {
-- 
2.40.1

