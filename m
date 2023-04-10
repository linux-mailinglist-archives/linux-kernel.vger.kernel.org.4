Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EA6DC8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDJPnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjDJPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:42:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798446A6F;
        Mon, 10 Apr 2023 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681141376; x=1712677376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trHqY1v/O5NAH+crey30dQa0DkZ2iW+8Iz3xoPwCHK0=;
  b=Sj8Hz7Tju51IfGqZnZKAveKQHfcY23ctRQ4ygMFRRc6pPxf0+n6x0PSY
   uAc+fVCVBroakxGdDUqtj40/Cq5wUgMroYzA6bjGnxEwhwE4+eRSwbInp
   p34E/qjkTfE23hTeaVMkGsziXZcmmSfZczV1ygc9+fjOl9rzJFDfy0Jkg
   qJywtGsUss7dRbk/sU6Lh6Uhae1aIJ9bR331TCBJrLJVdRLgdvukyuMZ9
   NwJ9YViy4BVPcIWYAy5OJZcxyQRtyAZq7aQbPSY8078LW+tYa6/KF8uua
   TV6NoaF42s5n/ulsyE5yZvFDPbzrHRay8QAuSe/pgCahyeypZfFYVif0n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340868153"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="340868153"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757482048"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="757482048"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:55 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>
Subject: [PATCH 2/5] dt-bindings: hwmon: intel: add hardware monitor bindings for SoCFPGA
Date:   Mon, 10 Apr 2023 10:33:11 -0500
Message-Id: <20230410153314.27127-2-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

Document the hardware monitoring bindings for SoCFPGA 64-bit platforms.

Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
 .../bindings/hwmon/intel,socfpga-hwmon.yaml   | 241 ++++++++++++++++++
 1 file changed, 241 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
new file mode 100644
index 000000000000..ec9d9eabdc37
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
@@ -0,0 +1,241 @@
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
+      - intel,socfpga-hwmon
+
+  reg:
+    maxItems: 1
+    description:
+      The sensor mapping address is denoted by the lower 16-bits being
+      the channel mask location that defines the channel number.
+      The upper 16-bits denotes the page number.
+      The bit mask of 0x1 represents channel 1. The supported
+      page and channel is dependent on the SoCFPGA variant.
+      Page number greater than 0 is only supported on the
+      temperature sensors.
+
+  temperature:
+    description:
+      Specifies the possible mappings of temperature sensors
+      diodes on the SoCFPGA main die and tile die.
+
+  voltage:
+    description:
+      Specifies the possible mappings of the voltage sensors on the
+      SoCFPGA analog to digital converter of the Secure Device Manager
+      (SDM).
+
+  input:
+    description:
+      Specifies each sensor.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    temp_volt {
+      compatible = "intel,socfpga-hwmon";
+      voltage {
+        #address-cells = <1>;
+        #size-cells = <0>;
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

