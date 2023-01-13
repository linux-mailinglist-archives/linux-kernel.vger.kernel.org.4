Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88D669666
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjAMMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjAMMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:07:31 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0A3AB13;
        Fri, 13 Jan 2023 03:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673611149; x=1705147149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=B/FJ28V5OM9qQHwIsioJH73Z9oXDZRZjd2zV9nWXUuI=;
  b=ucKD6SB+OpCcVChs6yWgzlnfkj2r47Gfs0GyrKdfYT2rzDyhxaBfqJVh
   /RKH8ZzRyOOPqM2lFttem9jueqjrTQczlygm6qbvp8Z2+WpZ4jMuLgPWW
   9Q3J+gpvndTUBXBH87Mev6hp1UBMPEQFKAO0xDch/6MCIJWHlQvJbt6HV
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jan 2023 03:59:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:59:09 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 03:59:05 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <keescook@chromium.org>, <gpiccoli@igalia.com>, <corbet@lwn.net>,
        <tony.luck@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2 2/3] Documentation: admin-guide: ramoops.rst: Update the ramoops document
Date:   Fri, 13 Jan 2023 17:28:45 +0530
Message-ID: <1673611126-13803-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
References: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This is not desirable
in environments where it is preferred the region to be dynamically
allocated at runtime. So, update the document while adding the
support in the driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Change in v2:
  - Added this patch as per changes going to be done in patch 3/3

 Documentation/admin-guide/ramoops.rst | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index e9f8514..88884b2 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -16,8 +16,9 @@ survive after a restart.
 Ramoops concepts
 ----------------
 
-Ramoops uses a predefined memory area to store the dump. The start and size
-and type of the memory area are set using three variables:
+Ramoops uses both predefined and dynamically memory area to store the dump.
+The start and size and type of the memory area are set using three
+variables:
 
   * ``mem_address`` for the start
   * ``mem_size`` for the size. The memory size will be rounded down to a
@@ -70,7 +71,8 @@ Setting the ramoops parameters can be done in several different manners:
 
  B. Use Device Tree bindings, as described in
  ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
- For example::
+
+ Example of statically reserved ramoops region::
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -85,6 +87,23 @@ Setting the ramoops parameters can be done in several different manners:
 		};
 	};
 
+ Example of dynamically reserved ramoops region::
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops@8f000000 {
+			compatible = "ramoops";
+			alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
+			size = <0 0x100000>;
+			record-size = <0x4000>;
+			console-size = <0x4000>;
+		};
+	};
+
+
  C. Use a platform device and set the platform data. The parameters can then
  be set through that platform data. An example of doing that is:
 
-- 
2.7.4

