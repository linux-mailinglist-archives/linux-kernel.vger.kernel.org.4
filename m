Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D17256D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbjFGIFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjFGIFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1BF196
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30af56f5f52so5860704f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125110; x=1688717110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtzYn96ig+lorMysgzvmIhs2jjpLBGL4+9ZV/9hvBQI=;
        b=uNYTQtE0Za4Fy+tKFPNhJ5JJ7XmY3nhTJ0LHaaoKZajPOjUK/aXGdu+bOtrlW2uJhF
         nNC10FIKbMoaBQ2KfdE4o3xxxysUJ+l2MepabkB8b8KXeS/NGgk8zZ5SG6lQnWzeKZPA
         XU4U3CldeyTxvAjn/Qd1BJXQ3GXP/L78T2BVIP2JVEaDmmB+wFv0/I9TRB8JDvX937Jl
         1R5VfPRioTjeQvjJDF83ZPwW5JTUctlbEYa7+33MTaAkH7n6nTMZsKTAOgpRpf7UEkw0
         b3aV1Y1j/p2FPqkOl6k36PrKGM7UPpzlS/3IclDSLRxp+Bb6unTkHlxCjnLz6AFDanAV
         pvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125110; x=1688717110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtzYn96ig+lorMysgzvmIhs2jjpLBGL4+9ZV/9hvBQI=;
        b=TKtM/POleQuNgpouRPJq0pbrmWfptcRcMZgc3d9zYZwX3jC7+k1abJNDUCTxgbgfbS
         iJ6U/rIpq0mruT4iteqchkYGAIoTAMaeN+g0PGqSOxhLhkztzWbc6xj+KOmdzItrMmDt
         h39n3Y1jSnCmzz5rtvjfHpI1r3Y/nyve9+1ZfinzjEqa/h3oD5lGVWlT56t+4lndQ2Yi
         dzrB4x1yKQppbc3mtVRiv2u36zJVcAUorRypLB7a1q8m3D2lDdPeXy1+NRuGUqz1aT6m
         ZLPosDxZZoTp7HkRwv54/DcAl7RMwhJN6MXObjV46F8TLLhJzwiio4jC/k1SXYxmGBh8
         DC1g==
X-Gm-Message-State: AC+VfDxx0wU2sEsEd7UFGyLk0SZnOIjStXDPxlPcXHyxEJ+jg9lgYhx7
        b1XHMkOQUkMP9rEg58/rlQcRFg==
X-Google-Smtp-Source: ACHHUZ4FuRhoHzUiKf+yOibOeZljiDY9bUJxusfzOPQix1/WrJYnTWsWIjkHZ/PZsWdwMuC17ndy7Q==
X-Received: by 2002:a05:6000:550:b0:30e:3c81:ca1c with SMTP id b16-20020a056000055000b0030e3c81ca1cmr3432223wrf.29.1686125109803;
        Wed, 07 Jun 2023 01:05:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm14706269wrm.17.2023.06.07.01.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:05:09 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 10:05:02 +0200
Subject: [PATCH v2 3/8] usb: ucsi: glink: use the connector orientation
 GPIO to provide switch events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v2-3-3bbdf37575c3@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDou7uKydBdy68HGNJVUOuX2u93V9pItw/FCCqCb
 S3p9hguJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA6LgAKCRB33NvayMhJ0e3SEA
 CCKMPH4CVrYSjY5mzcsv9iYk6a/p4pT35wnTqwE4FxqM0mL+Ce2XQ70S7Ez0g09/x9QASPNdJwNhLp
 ksqByU/Tr+JT9NWRMEShlMz3b8ojNOUG2Qq20rhIMXYzNMoIE2Utu/lHbvcdnTjzP+d8UQGOyx3GLv
 SuQ171ozUEGtD+1vNjVkwHUFkFnMh1hKn6peJjkQRG42rGwXaVC/TTvaGJwndI1kGeOkXiMc6LLIEG
 wl1jZ9+hMoJ7vGg8MgGYAJf/zF+pfPUGQd+PI14vbuTA3dfoKu19pX02bZ5j47P81khssnJqo8aWcq
 Ek+Xy3VYLkb6ALlzvBrfaTzItKXu/P+tARUe1Qmo5AJlGedOkDCl6ebJHOYYFSWhjTG3samL0TGemj
 X8NUIwXkV5dG66DKq5FVQb6vvNoV83afeOBvWTShRHqTpQ8bKGevB+lJMKbKj4cE4IkQr3P0dgx3kO
 bOskE6XWSTkDOBqhslAe5Jn3Aql1g3RkHeSrFBonCfZX/SXofmb5W2IhR7W3LpI3lmZBuOsU4u3zRp
 t5O6kfZHdrKQCKENfZ4GKLRUYKwkYOOhU6W7sVulA4ZXXr0XDIgw2VKF/FQU917AzwR3I/iElaLon0
 Tf4QEU1ZEsr35JGok73G4Q/m+7Vv1Px8PNMUyAM33elYM5wZ5GIuWSrjtFiA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

