Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D026FBA13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjEHVks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjEHVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:40:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199019ED6;
        Mon,  8 May 2023 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683582009; x=1715118009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dRZzPxzLewIPgVj78LjUAdOR9w9k7vVpVmKgFwPjvo=;
  b=lKUPLwqkmjHr2u1poazvaXAsAAkfSBrinVxUAchMEUS+R9rjrEnVwyp/
   n3RKoxpLey/7vNSuxbQeD6qpJDL8j1HiFI94V+GhsfJNuDGlkiQIeNY7P
   TA9Eng/1rvLcnw5P3SZGxgvtWrYrVueWkUiu8MAA2mzvb4mZcO3WNo1fX
   /1Ek3wTBUIVvTvVsnCO8Djf9oIvj7+HY7UXIrLOTDzUq1OQQwytrvwdcA
   nUFgdzyLbc8oc0/fHV6ZYh7sZGNMjAvVHnO9kGwCubu3MWHlUDPbwLMCH
   T3mu8QIMCu3nmanBxX3r6K9OjOc6/4pb9luByl4VthNTZvBG9KpKeMjHY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349796697"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349796697"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945018724"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="945018724"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:59 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>
Subject: [PATCHv2 5/6] dt-bindings: hwmon: intel: add hardware monitor bindings for SoCFPGA
Date:   Mon,  8 May 2023 16:28:51 -0500
Message-Id: <20230508212852.8413-5-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

Document the hardware monitoring bindings for SoCFPGA 64-bit platforms.

Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
v2: Add intel,socfpga-agilex-hwmon, intel,socfpga-n5x-hwmon and
    intel,socfpga-stratix10-hwmon
    Add patternProperties
---
 .../bindings/hwmon/intel,socfpga-hwmon.yaml   | 258 ++++++++++++++++++
 1 file changed, 258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
new file mode 100644
index 000000000000..e634311a0e81
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
@@ -0,0 +1,258 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/intel,socfpga-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel SoCFPGA Hardware monitor
+
+maintainers:
+  - Dinh Nguyen <dinh.nguyen@linux.intel.com>
+
+description: |
+  The Intel SoCFPGA hardware monitor unit provides on-chip voltage and
+  temperature sensors. You can use these sensors to monitor external
+  voltages and on-chip operating conditions such as internal power rails
+  and on-chip junction temperatures.
+
+  The specific sensor configurations vary for each device family and
+  each device within a family does not offer all potential sensor
+  options. The information below attempts to illustrate the super set of
+  possible sensor options that are potentially available within each
+  device family, but the user should check the documentation for the
+  specific device they are using to verify which sensor options it
+  actually provides.
+
+  Stratix 10 Device Family
+
+    Stratix 10 Voltage Sensors
+
+      page 0, channel 2 = 0.8V VCC
+      page 0, channel 3 = 1.0V VCCIO
+      page 0, channel 6 = 0.9V VCCERAM
+
+    Stratix 10 Temperature Sensors
+
+      page 0, channel 0 = main die
+      page 0, channel 1 = tile bottom left
+      page 0, channel 2 = tile middle left
+      page 0, channel 3 = tile top left
+      page 0, channel 4 = tile bottom right
+      page 0, channel 5 = tile middle right
+      page 0, channel 6 = tile top right
+      page 0, channel 7 = hbm2 bottom
+      page 0, channel 8 = hbm2 top
+
+  Agilex Device Family
+
+    Agilex Voltage Sensors
+
+      page 0, channel 2 = 0.8V VCC
+      page 0, channel 3 = 1.8V VCCIO_SDM
+      page 0, channel 4 = 1.8V VCCPT
+      page 0, channel 5 = 1.2V VCCRCORE
+      page 0, channel 6 = 0.9V VCCH
+      page 0, channel 7 = 0.8V VCCL
+
+    Agilex Temperature Sensors
+
+      page 0, channel 0 = main die sdm max
+      page 0, channel 1 = main die sdm 1
+
+      page 1, channel 0 = main die corner bottom left max
+      page 1, channel 1 = main die corner bottom left 1
+      page 1, channel 2 = main die corner bottom left 2
+
+      page 2, channel 0 = main die corner top left max
+      page 2, channel 1 = main die corner top left 1
+      page 2, channel 2 = main die corner top left 2
+
+      page 3, channel 0 = main die corner bottom right max
+      page 3, channel 1 = main die corner bottom right 1
+      page 3, channel 2 = main die corner bottom right 2
+
+      page 4, channel 0 = main die corner top right max
+      page 4, channel 1 = main die corner top right 1
+      page 4, channel 2 = main die corner top right 2
+
+      page 5, channel 0 = tile die bottom left max
+      page 5, channel 1 = tile die bottom left 1
+      page 5, channel 6..2 = tile die bottom left 6..2 R-tile only
+      page 5, channel 5..2 = tile die bottom left 5..2 F-tile only
+      page 5, channel 4..2 = tile die bottom left 4..2 E-tile only
+
+      page 7, channel 0 = tile die top left max
+      page 7, channel 1 = tile die top left 1
+      page 7, channel 6..2 = tile die top left 6..2 R-tile only
+      page 7, channel 5..2 = tile die top left 5..2 F-tile only
+      page 7, channel 4..2 = tile die top left 4..2 E-tile only
+
+      page 8, channel 0 = tile die bottom right max
+      page 8, channel 1 = tile die bottom right 1
+      page 8, channel 6..2 = tile die bottom right 6..2 R-tile only
+      page 8, channel 5..2 = tile die bottom right 5..2 F-tile only
+      page 8, channel 4..2 = tile die bottom right 4..2 E-tile only
+
+      page 10, channel 0 = tile die top right max
+      page 10, channel 1 = tile die top right 1
+      page 10, channel 6..2 = tile die top right 6..2 R-tile only
+      page 10, channel 5..2 = tile die top right 5..2 F-tile only
+      page 10, channel 4..2 = tile die top right 4..2 E-tile only
+
+  N5X Device Family
+
+    N5X Voltage Sensors
+
+      page 0, channel 2 = 0.8V VDD
+      page 0, channel 3 = 0.8V VDD_SDM
+      page 0, channel 4 = 1.8V VCCADC
+      page 0, channel 5 = 1.8V VCCPD
+      page 0, channel 6 = 1.8V VCCIO_SDM
+      page 0, channel 7 = 0.8V VDD_HPS
+
+    N5X Temperature Sensors
+
+      page 0, channel 0 = main die
+
+properties:
+  compatible:
+    enum:
+      - intel,socfpga-agilex-hwmon
+      - intel,socfpga-n5x-hwmon
+      - intel,socfpga-stratix10-hwmon
+      - intel,socfpga-hwmon
+
+patternProperties:
+  "^(voltage)|input@([2-7])$":
+    type: object
+    description: Specifies the possible mappings of the voltage sensors on the
+      SoCFPGA analog to digital converter of the Secure Device Manager(SDM).
+
+    properties:
+      reg:
+        description:
+          The bit mask of 0x1 represents channel 1. The supported
+          page and channel is dependent on the SoCFPGA variant.
+          Page number greater than 0 is only supported on the
+          temperature sensors.
+        items:
+          minimum: 0
+          maximum: 1
+
+      label:
+        description: A descriptive name for this channel, i.e "0.8V VCC" or "1.8V VCCIO_SDM".
+
+  "^(temperature)|input@([10001-40002])$":
+    type: object
+    description: Specifies the possible mappings of the temperature sensors on
+      the SoCFPGA analog to digital converter of the Secure Device Manager(SDM).
+
+    properties:
+      reg:
+        description:
+          The sensor mapping address is denoted by the lower 16-bits being
+          the channel mask location that defines the channel number.
+          The upper 16-bits denotes the page number.
+        items:
+          minimum: 0
+          maximum: 1
+
+      label:
+        description: A descriptive name for this channel, i.e "Main Die SDM" or
+          "Main Die corner bottom left 1".
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    hwmon {
+      compatible = "intel,socfpga-hwmon";
+
+      voltage {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        input@2 {
+          label = "0.8V VCC";
+          reg = <2>;
+        };
+
+        input@3 {
+          label = "1.8V VCCIO_SDM";
+          reg = <3>;
+        };
+
+        input@4 {
+          label = "1.8V VCCPT";
+          reg = <4>;
+        };
+
+        input@5 {
+          label = "1.2V VCCCRCORE";
+          reg = <5>;
+        };
+
+        input@6 {
+          label = "0.9V VCCH";
+          reg = <6>;
+        };
+
+        input@7 {
+          label = "0.8V VCCL";
+          reg = <7>;
+        };
+      };
+
+      temperature {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        input@0 {
+          label = "Main Die SDM";
+          reg = <0x0>;
+        };
+
+        input@10001 {
+          label = "Main Die corner bottom left 1";
+          reg = <0x10001>;
+        };
+
+        input@10002 {
+          label = "Main Die corner bottom left 2";
+          reg = <0x10002>;
+        };
+
+        input@20001 {
+          label = "Main Die corner top left 1";
+          reg = <0x20001>;
+        };
+
+        input@20002 {
+          label = "Main Die corner top left 2";
+          reg = <0x20002>;
+        };
+
+        input@30001 {
+          label = "Main Die corner bottom right 1";
+          reg = <0x30001>;
+        };
+
+        input@30002 {
+          label = "Main Die corner bottom right 2";
+          reg = <0x30002>;
+        };
+
+        input@40001 {
+          label = "Main Die corner top right 1 HPS";
+          reg = <0x40001>;
+        };
+
+        input@40002 {
+          label = "Main Die corner top right 2";
+          reg = <0x40002>;
+        };
+      };
+    };
-- 
2.40.0

