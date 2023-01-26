Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6D67C329
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjAZDPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjAZDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:14:57 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B8865EF5;
        Wed, 25 Jan 2023 19:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674702891; x=1706238891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yGFwuojaQ5ML4dsz23/al/799O12g89UeuaQci4f9LM=;
  b=lhcMoYT3uo0e0XuZyVNr7Q3whei7ZHcPMjlASdqmCw09zDoSVCZI4IqK
   zqSubjlucP9E2qZb07G6N4Vod18LJ4/6AHcptfY8ctlhjUsz865lS/r2P
   SjMvXMK2jP2ff/RlFbAX5Zta7pcXf8x633+ND73nFMGM67JfU0WQPqhKl
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jan 2023 19:14:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 19:14:50 -0800
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:50 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH v2 21/22] ASoC: dt-bindings: Add Q6USB backend bindings
Date:   Wed, 25 Jan 2023 19:14:23 -0800
Message-ID: <20230126031424.14582-22-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt-binding to describe the definition of enabling the Q6 USB backend
device for audio offloading.  The node carries information, which is passed
along to the QC USB SND class driver counterpart.  These parameters will be
utilized during QMI stream enable requests.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 .../bindings/sound/qcom,q6usb-dais.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
new file mode 100644
index 000000000000..e24b4d52fa7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm ASoC USB backend DAI
+
+maintainers:
+  - Wesley Cheng <quic_wcheng@quicinc.com>
+
+description:
+  The Q6USB backend is a supported AFE port on the Q6DSP. This backend
+  driver will communicate the required settings to the QC USB SND class
+  driver for properly enabling the audio stream.  Parameters defined
+  under this node will carry settings, which will be passed along during
+  the QMI stream enable request.
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6usb-dais
+
+  iommus:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  qcom,usb-audio-stream-id:
+    description:
+      SID for the Q6DSP processor for IOMMU mapping.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  qcom,usb-audio-intr-num:
+    description:
+      Desired XHCI interrupter number to use.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+  - qcom,usb-audio-intr-num
+
+additionalProperties: false
+
+examples:
+  - |
+    usbdai: usbd {
+      compatible = "qcom,q6usb-dais";
+      #sound-dai-cells = <1>;
+      iommus = <&apps_smmu 0x180f 0x0>;
+      qcom,usb-audio-stream-id = <0xf>;
+      qcom,usb-audio-intr-num = <2>;
+    };
