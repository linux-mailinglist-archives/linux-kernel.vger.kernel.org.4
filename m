Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC56E6853
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDRPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjDRPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B021447E;
        Tue, 18 Apr 2023 08:32:17 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IBVxHj019523;
        Tue, 18 Apr 2023 15:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=mh5ckzc+JZwqQOEFdmXTbYFSjoiyihF7h8qoI41tmA0=;
 b=Vh3Df0Wq1qkYgkt8p2dzdwm5WxLasaljreZ5lMjHokkf9AWEhPRz0/3YZo9Y5M+KUDo8
 n0ASdIzjUret7utmyP/azMTEho1ch7PAF3H6Miu7gr0p0MrkaFyymYuuYwY9sqzAsXqJ
 qzTzUpNcqkkzSkdbsL2sj9xu9nzlw20pMrp8HXFT4f00Y8YzuvBTbNOy+2ZJodzFJe36
 kWMRCbtbbTJPObN1KbFKmeAot/G0riiFmZ2sPAW+M39ykiW58QSkAgRRzJF1k4PDZZ7a
 0UC3xr03c81Fg9KXqWZ4MglKnTfFGELEvCKiPyj+t+FJut5kYrKesKzNjye6z/uLpvQD 8w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q1t6pj41n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:39 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 2AFB412E80;
        Tue, 18 Apr 2023 15:31:39 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 86E9B81733B;
        Tue, 18 Apr 2023 15:31:38 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 6/9] dt-bindings: hwmon: Add HPE GXP PSU Support
Date:   Tue, 18 Apr 2023 10:28:21 -0500
Message-Id: <20230418152824.110823-7-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418152824.110823-1-nick.hawkins@hpe.com>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: llG_UHI9fBhjAXZ7JLrgV-1tJt87eTRh
X-Proofpoint-ORIG-GUID: llG_UHI9fBhjAXZ7JLrgV-1tJt87eTRh
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Provide i2c register information and CPLD register information to the
driver.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/hwmon/hpe,gxp-psu.yaml           | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml
new file mode 100644
index 000000000000..60ca0f6ace46
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/hpe,gxp-psu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP psu controller
+
+maintainers:
+  - Nicholas Hawkins <nick.hawkins@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp-psu
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  hpe,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the global status registers shared between each psu
+      controller instance.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        psu@48 {
+            compatible = "hpe,gxp-psu";
+            reg = <0x48>;
+            hpe,sysreg = <&sysreg_system_controller2>;
+        };
+    };
-- 
2.17.1

