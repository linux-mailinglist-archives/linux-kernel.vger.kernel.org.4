Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780672DBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbjFMH4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbjFMH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8CD10FC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so6289904e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642969; x=1689234969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtzYn96ig+lorMysgzvmIhs2jjpLBGL4+9ZV/9hvBQI=;
        b=k8TIUsB/iXI0lC5SdboEOO2KB3he+vQ7GEmCF8FiuPxg1nBZWhgQ3xzMKPDzsVTBZy
         u+9l2bmxoScub9n8Fz4RRxHqTCzMrCDtmQxiVRlTIYpEx8+z8Rcmg1x0EB0u/+IHaaOv
         dL/dIcJF4RRhMNFz8xsMYWH2KdTWHpfF8ObjYeW6/mnfGmZhistErnqxGWhhM/8sCSHA
         JU34YEb0SNnshzhqLaUsoUkxTUuNKnlrI+z6WFwkE0H9hiGPJCTcPt/KsXEOXTqNNWEL
         BHanTz3qm1VN+nc70Jf0gO1d6Bjb7hjs9Ed8shtEw8UAfeqgrFbSu7g6LIh+V6iNr+tm
         mdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642969; x=1689234969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtzYn96ig+lorMysgzvmIhs2jjpLBGL4+9ZV/9hvBQI=;
        b=Nv/ZA82yKJfq5OoHE64NBqhwuZ8pMYwpqnxUlReOpHM81/nG3VK3XoEN1NV5dgciIH
         VU/9m4yLyPfN1bp1IsavK+GWs9d8q7gDf+HmzTFIGJMX5qIxIQefT8Kd12tlFvP86yTM
         9nXNKIPl87Kw7GbYdbahWcksa00yzB6ANltKU+yUPiyZA5nGu0IrQ6g0WhP2LOU4106q
         IhMHE8kosc7bznAY6EtIHBtvNVNE42FLXX11NHfxl3/wbbQ84XMaIV4TqEG/bD/5YXRm
         It4jFWL50ZmyVkVAzZrGB0Sq406PJwghljZv/dLkbE5E6n64HIPDfp+KAZzW2UrPf2io
         Vl4A==
X-Gm-Message-State: AC+VfDw+Nmht5C2PYd66oe4k0X0jTP8zpd5U4VY3odGHMJrfbzK71Mdd
        wYJhmO+IP1vf1vIuMpx1h24wQA==
X-Google-Smtp-Source: ACHHUZ66ta5ooumpF/Z1eXdJbdZ/nGCsK+Bzeb5GVy76Dl8WBDN/8bFOIIwNbYj0YhWaHMg9bM94Zw==
X-Received: by 2002:a19:4f44:0:b0:4f3:802c:7725 with SMTP id a4-20020a194f44000000b004f3802c7725mr4646102lfk.30.1686642969626;
        Tue, 13 Jun 2023 00:56:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm13662316wmr.5.2023.06.13.00.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:56:09 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 13 Jun 2023 09:55:56 +0200
Subject: [PATCH v3 3/8] usb: ucsi: glink: use the connector orientation
 GPIO to provide switch events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v3-3-22c9973012b6@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dJsk94W4hJQWsF7UZ7NHEWxATRmNKuU8IakNNu3DGzw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiCES35zFxYcGDLdJLU638f1Y+Lvby72mcOP4IAUS
 45gwBFSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIghEgAKCRB33NvayMhJ0UbkD/
 wItZqCtSB/V4zzpWsPDA22v9WYMqYrVjwANTDvfUZkRGupbL/CbqOCFiq8usU0LX5h+BnAF5pLPygU
 qyB+VEQwgO2xhq8pqA3SOcaZsFV6GJ0UqAvQ9w3IEy0odji7lod2PJIYy4K+fLZHXh4cSi7j/l7jz+
 VqxvQue6Sd1JjDFYGVhKh71Xh6ppUVQwN6MCOhwtiZe3OgL6h1i01wuL/CTJk8jl1Uc/7/aOrNGXW2
 Kjesx+0N9oKB985iLcQ/fdBJTtoj1/xYbzRiCClzlERLUBaDWMZrEmRvstI+HWS+ssOBRMHQb6ME4b
 Ie6rvgolbNtDDDn7VEvw0dAEwtocN5GFy2O1cVpjEmO4US/73A1i96S5qZY7FvrqXIQywJYI+nF2Lc
 90c83t94Vn7OaHiQ20davjBfSQ9jU8jqpXQS4dvbdVB0WKT0NTpoHrKQC5rFQ3fAswAOv0NsJgLQOl
 SeniWLvYTAOiMEn3PemCRAkrnywN1Di0Z7cFStw2UDinWFF+5gY+vqRuSNLupp49sy5s7Ki4SkZPWI
 iihX6YbSCgIWjfhQneITzi9hziBCPYHt3+PnIt2kI9WCMjR0+IwaP2K2JHsdGDOc4dn5CkwJLuS6c0
 gfFozIKv/yfDdjz2o5V1InYAmJKMWLmBFwdvCqRQjFkf/lyXCBQksNsAEZCA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SM8550, the non-altmode orientation is not given anymore within
altmode events, even with USB SVIDs events.

On the other side, the Type-C connector orientation is correctly
reported by a signal from the PMIC.

Take this gpio signal when we detect some Type-C port activity
to notify any Type-C switches tied to the Type-C port connectors.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 52 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 1fe9cb5b6bd9..88491dbff7e3 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -9,9 +9,13 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/gpio/consumer.h>
 #include <linux/soc/qcom/pmic_glink.h>
 #include "ucsi.h"
 
+#define PMIC_GLINK_MAX_PORTS	2
+
 #define UCSI_BUF_SIZE                   48
 
 #define MSG_TYPE_REQ_RESP               1
@@ -53,6 +57,9 @@ struct ucsi_notify_ind_msg {
 struct pmic_glink_ucsi {
 	struct device *dev;
 
+	struct gpio_desc *port_orientation[PMIC_GLINK_MAX_PORTS];
+	struct typec_switch *port_switch[PMIC_GLINK_MAX_PORTS];
+
 	struct pmic_glink_client *client;
 
 	struct ucsi *ucsi;
@@ -221,8 +228,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 	}
 
 	con_num = UCSI_CCI_CONNECTOR(cci);
-	if (con_num)
+	if (con_num) {
+		if (con_num < PMIC_GLINK_MAX_PORTS &&
+		    ucsi->port_orientation[con_num - 1]) {
+			int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
+
+			if (orientation >= 0) {
+				typec_switch_set(ucsi->port_switch[con_num - 1],
+						 orientation ? TYPEC_ORIENTATION_REVERSE
+							     : TYPEC_ORIENTATION_NORMAL);
+			}
+		}
+
 		ucsi_connector_change(ucsi->ucsi, con_num);
+	}
 
 	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
 		ucsi->sync_val = -EBUSY;
@@ -283,6 +302,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 {
 	struct pmic_glink_ucsi *ucsi;
 	struct device *dev = &adev->dev;
+	struct fwnode_handle *fwnode;
 	int ret;
 
 	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
@@ -310,6 +330,36 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 
 	ucsi_set_drvdata(ucsi->ucsi, ucsi);
 
+	device_for_each_child_node(dev, fwnode) {
+		u32 port;
+
+		ret = fwnode_property_read_u32(fwnode, "reg", &port);
+		if (ret < 0) {
+			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
+			return ret;
+		}
+
+		if (port >= PMIC_GLINK_MAX_PORTS) {
+			dev_warn(dev, "invalid connector number, ignoring\n");
+			continue;
+		}
+
+		ucsi->port_orientation[port] = devm_fwnode_gpiod_get(&adev->dev, fwnode,
+								     "orientation",
+								     GPIOD_IN, NULL);
+		if (IS_ERR(ucsi->port_orientation[port]))
+			return dev_err_probe(dev, PTR_ERR(ucsi->port_orientation[port]),
+					     "unable to acquire orientation gpio\n");
+
+		if (!ucsi->port_orientation[port])
+			continue;
+
+		ucsi->port_switch[port] = fwnode_typec_switch_get(fwnode);
+		if (IS_ERR(ucsi->port_switch[port]))
+			return dev_err_probe(dev, PTR_ERR(ucsi->port_switch[port]),
+					"failed to acquire orientation-switch\n");
+	}
+
 	ucsi->client = devm_pmic_glink_register_client(dev,
 						       PMIC_GLINK_OWNER_USBC,
 						       pmic_glink_ucsi_callback,

-- 
2.34.1

