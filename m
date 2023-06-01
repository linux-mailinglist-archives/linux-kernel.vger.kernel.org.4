Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D09719F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjFAOHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjFAOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1F1AE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so8853035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628430; x=1688220430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3z35kLjtVuNkh8LHdIFDlyQAvirx/CBbOVPwkvzphA=;
        b=y5/oETRa03uuSXHwuLiyXWSVNCC9Qnzt7sq7Cb0qYu6SBkus46f5CLA5UxoSVa5vW4
         64LS13I8FXyBoe1VP8sZ8owpBA91KvBi59IBoY3gI50hG2JELRBGNkP0tjORl/2/n/ho
         ioTLw7HG8+2038f63E9yme8Pxim4GCruGImjeeGRBecCgyUaEhUtk2Tye5Dhh8yo5jzC
         hGtoBLNheflJP/w4QkJYSSb5WiMGU99cCEnqP0hGET2BpqSXqgr/Yh8TnfhzSaV2UDvD
         29JYf1PAoz4ZJfVJCNqnPkp1VGASNwS/4DlRU3U++PwQ5TZu+PK7u+PrIvgVExBBMSLf
         V3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628430; x=1688220430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3z35kLjtVuNkh8LHdIFDlyQAvirx/CBbOVPwkvzphA=;
        b=QiUtwXcdE/jo1ATrVidiWzLRfhbXqahMrzqUSdzCLiNHLU+bnVFy+SeU/JufSwwKzx
         BzYJjK3XZLAKogUqq0r30gEKSs4t9HVmEaXtetuYMweSowIvdw7XRJlvoJsBMBHxPeMJ
         JqE2BUN9UgjSJLWzBPslCsZT9vdMzAcYExk/MHgfgS1MJitUV7kwKdB6gwyToQwz5Ivd
         Ist2gYUBgB6+WHdFA1TsUBmBMSE1xPUJW5IL/tebK6VYREN3VBQwqax9Lnkz0dQtVktG
         i8UdwRi7m9qKcaILqZnorUxdn4go6gmENmoQLWUkOf8biOFttpHHTe68rXtKgf5IMVvz
         djoA==
X-Gm-Message-State: AC+VfDyOH7wHZaKKMRNldITJtjwnP/otF58GdfK6ptmQwL/nCe2H8gT5
        tgf5JARS8JB8Nf4R4zC6/oDvlA==
X-Google-Smtp-Source: ACHHUZ5CzLNx60c1NjSH+2PVivdCwFMDwJYuA3ptSoHHTHGRrdd+pilefHfzahocA+HHdcNzW0ffkw==
X-Received: by 2002:adf:ee49:0:b0:306:3da7:f33c with SMTP id w9-20020adfee49000000b003063da7f33cmr2145483wro.63.1685628429947;
        Thu, 01 Jun 2023 07:07:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b003078a3f3a24sm10504166wrm.114.2023.06.01.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:07:09 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 16:07:03 +0200
Subject: [PATCH RFC 3/7] usb: ucsi: glink: use the connector orientation
 GPIO to provide switch events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v1-3-d4d97b4d8bab@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nJzT9fSe7XhRaSGcBOCqWkQuuh2QqOFxCUaZKNz/46s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeKYIcAjNdfLajEPadXGFRYAAiXnX1eiGjYcS0J1r
 3lfUSwOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHimCAAKCRB33NvayMhJ0UkID/
 wK4HWOcabQ64d8G4yr346nWvW3b/N0rmtpPOOcx7H0jLxfL6rrDvs0fDdvei5eDdEVrEJPGhg9cZl2
 XMcJan2rmkEsdTccIEwzO1rc+FKSaT8GmMfi2aTckhTLB4oa0Wu/lnibmisRqTo4Dp0GsZrMPR4G+b
 yPdqkFgHbxd2F44bYT8YW2V5sChJY8qFhnHprkxTveAxSpmJgdfPTTSqXs2GKeUq60IDf21FRus7SJ
 lLj6d3LtTmN6Mnc+qyfDF3F4cRV9BDGXZquNOsVFS7vc2sSiS76DSg/qN8qpLO9ZiLbR7oXdmBfwGi
 fwtUYOnpR8aKnMXIOiXI6nHox7e65Cjnp5L+nCcE9Ny/OKYGH6onM06FRlabhuNccVmoN9nnqjdK1/
 5OszzVugczqk8TLN8IbsFGr7YMewNdihVFIzTRMd0dd3hHIzZl6hlgiP7rUk5wWKbhGXCie/anlM4h
 62VnNLq9RYqgvRsm3FZD+7KckM0C+EqqAsUeIs44W5C94DVa+gdENeJUldXsXpPxJUXQfhFUgHWJvw
 i5Ejwql6VLXDLb0xRLyUXgbtSEb+Zd8w53ZY+ufO6QQ/ijeYSI7I82bScSRciFayIQLfaLjcp7gaE8
 DwibO4KP4aKnI9PAvt8M3u5BP2wsaviTMeBxYKCeubkjvDdUuOsiRx/XyMmQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

