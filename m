Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E4737051
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjFTPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjFTPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:19:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972DFDD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f909853509so27841145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687274383; x=1689866383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKBTtnZxa/2tExzfIZCQ4Te7VKqHXpRPurp/GzFyVgY=;
        b=JscU01IGd9Vwgg4xkhU35uMF0m5V+K7BazY2kg7F29l9vEtyaaMnQk0GpTdUqInogA
         dncXXmmHC8TvtLM816/HpeFjsYEoMRNywgQnCOiKSqvr/NL8ic9bk+77kZvOzd/YcCxx
         j20iMVfVygJrUz930SBTqtfnokJvhGtcF4Q4mTJyxNLmhk0M5SMAIlT0h95+iG37vpk5
         cxZySFY406xDYleuhdI5PBVJEgh5pxdZ7JUEvPI6oprCVz1P/K82ais+ioEUTb5HCWoh
         55BUhX/8A8PNPHNCdJXqxDPm/jilMjESyyaQKYIs8ZwFZJW8WH9gDuXfQEq3iNxYVmyF
         DC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274383; x=1689866383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKBTtnZxa/2tExzfIZCQ4Te7VKqHXpRPurp/GzFyVgY=;
        b=MX8P0L5SrQbCYqSFDONLUJgQTlKAhJ3mb3Pme8iAVx9oxUVppN083NCycOvJQjPvh5
         /raCpZk5ZH3wHd4CpGAiKgH3mDpJDzQowfyYi5WTvIuedNeGm1IxPqvHf+QlImZgWmuk
         P582HGOZUq3LBrFRYg55IiiPp5MUUCncAIPpLAiiMEy7mbQjIq8N+a7KOnzhPPxJl8m1
         b8Nr/KC3XU1LF2OhrNfgFVTKZIYIl8Zo615LssBtKBp5lORkwvpH2v+bDuIVXjxdPYmq
         dTvOAgM1KEVNjMUD7rRiRLviJwS+fqO4FGYXNqSu+67hvNjZHkaQUG2CDlQMh5GSpuI2
         FzjQ==
X-Gm-Message-State: AC+VfDyfK8miwCOazKSOKdoAdhq2xcRAKzlfGdPwvfYsycuccU7oAgpT
        yJO/i5iqnPRRzP459HNPHHAEpg==
X-Google-Smtp-Source: ACHHUZ5zNlWhXnXRfnSV/vz5u9V+HgjB42db3TKp5u+h6lagm24mDieUOGWyTtcGOY2EhFe1zPfe2w==
X-Received: by 2002:a1c:4b0c:0:b0:3f9:b0c2:9ffb with SMTP id y12-20020a1c4b0c000000b003f9b0c29ffbmr4226374wma.27.1687274382932;
        Tue, 20 Jun 2023 08:19:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b003f427687ba7sm2518659wmj.41.2023.06.20.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:19:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 20 Jun 2023 17:19:37 +0200
Subject: [PATCH 2/4] bluetooth: qca: add support for WCN7850
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v1-2-4728564f8872@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8144;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Gq8LZiezxiA3WfALerQOHLoboCnoV3kzmQz9WGu2iZ4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkcOJnHSDO/FhiyQFdBkHjegtgltdCxTpoc7vvt8G
 id4gnCeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJHDiQAKCRB33NvayMhJ0cSVD/
 9deZRQMNTjSiOfNKFbfxuc5A06h1sD+OZgPd3kh3nUNNiO9Wz32S9N7MYolo5r931BU/rvirBYlGHS
 PPIlYX8AvUyRbz7emthVVnG42DLy66MXy8JDNxk+KDIdnpRlKhevX3jmbn2mDbQEbZTgmheYVUFkdN
 b655ICrPTeTBypLCubpLkiSJ887mOjE+iClf4Wu55UP7AVD7QeTUy9nQeQUxAiottspv1Ic2NCgqbL
 AO5t5taqzbDk59bX/jGuxX4R1r7cusRJaJwmfR+dcTLJO2cfCl4TyXg7w1xicKZi8/MhMCrcOluClc
 vWwYCYNS+qt574TmWqXn5YZeFGRP5YrHvF0NQttp/wa5QeG6JgK/+sv8gFmV1GsujZtHb6+GCc7B3q
 uR3qCr9uA3P9uq0eP6SUZYfTxWd9h4q0pDF2jIIT7MYNzzwsV7v3ikhEn3PR/VAnThfIU/qFHGJPf2
 K0G1JEjbQSueSnC0Nqnf1t+N7eMpoRYqk6RAMQJ0i14oHTkeANBwRPSk/4AKBPn8+Vatm6TTtXA3Qh
 3kI6xcZ5y+3fgVrfPzIIRpmCmphh0epP+sQGfEKyTMtq6xAMluoCOVoNiJ22MHVQnzX/A42ylWEgf5
 NmOpvowUz1DFgPn4zaM4X5pNZPPKJJxn2e3l00GDBwtXsr+I8tj9WAUbHFjg==
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

Add support for the WCN7850 Bluetooth chipset.

Tested on the SM8550 QRD platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/bluetooth/btqca.c   |  7 +++++++
 drivers/bluetooth/btqca.h   | 10 ++++++++++
 drivers/bluetooth/hci_qca.c | 48 ++++++++++++++++++++++++++++++++++-----------
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index e7e58a956d15..037146b476ff 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -617,6 +617,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	} else if (soc_type == QCA_WCN6855) {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hpbtfw%02x.tlv", rom_ver);
+	} else if (soc_type == QCA_WCN7850) {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hmtbtfw%02x.tlv", rom_ver);
 	} else {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/rampatch_%08x.bin", soc_ver);
@@ -654,6 +657,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	else if (soc_type == QCA_WCN6855)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hpnv%02x.bin", rom_ver);
+	else if (soc_type == QCA_WCN7850)
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hmtnv%02x.bin", rom_ver);
 	else
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/nvm_%08x.bin", soc_ver);
@@ -695,6 +701,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_WCN7850:
 		/* get fw build info */
 		err = qca_read_fw_build_info(hdev);
 		if (err < 0)
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index b884095bcd9d..ff1850e984fe 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -148,6 +148,7 @@ enum qca_btsoc_type {
 	QCA_QCA6390,
 	QCA_WCN6750,
 	QCA_WCN6855,
+	QCA_WCN7850,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
@@ -173,6 +174,10 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
 {
 	return soc_type == QCA_WCN6855;
 }
+static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
+{
+	return soc_type == QCA_WCN7850;
+}
 
 #else
 
@@ -216,6 +221,11 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
 	return false;
 }
 
+static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
+{
+	return false;
+}
+
 static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e30c979535b1..49b8d75d271e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1322,7 +1322,8 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	/* Give the controller time to process the request */
 	if (qca_is_wcn399x(qca_soc_type(hu)) ||
 	    qca_is_wcn6750(qca_soc_type(hu)) ||
-	    qca_is_wcn6855(qca_soc_type(hu)))
+	    qca_is_wcn6855(qca_soc_type(hu)) ||
+	    qca_is_wcn7850(qca_soc_type(hu)))
 		usleep_range(1000, 10000);
 	else
 		msleep(300);
@@ -1400,7 +1401,8 @@ static int qca_check_speeds(struct hci_uart *hu)
 {
 	if (qca_is_wcn399x(qca_soc_type(hu)) ||
 	    qca_is_wcn6750(qca_soc_type(hu)) ||
-	    qca_is_wcn6855(qca_soc_type(hu))) {
+	    qca_is_wcn6855(qca_soc_type(hu)) ||
+	    qca_is_wcn7850(qca_soc_type(hu))) {
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1435,7 +1437,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		 */
 		if (qca_is_wcn399x(soc_type) ||
 		    qca_is_wcn6750(soc_type) ||
-		    qca_is_wcn6855(soc_type))
+		    qca_is_wcn6855(soc_type) ||
+		    qca_is_wcn7850(soc_type))
 			hci_uart_set_flow_control(hu, true);
 
 		if (soc_type == QCA_WCN3990) {
@@ -1454,7 +1457,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 error:
 		if (qca_is_wcn399x(soc_type) ||
 		    qca_is_wcn6750(soc_type) ||
-		    qca_is_wcn6855(soc_type))
+		    qca_is_wcn6855(soc_type) ||
+		    qca_is_wcn7850(soc_type))
 			hci_uart_set_flow_control(hu, false);
 
 		if (soc_type == QCA_WCN3990) {
@@ -1691,7 +1695,8 @@ static int qca_power_on(struct hci_dev *hdev)
 
 	if (qca_is_wcn399x(soc_type) ||
 	    qca_is_wcn6750(soc_type) ||
-	    qca_is_wcn6855(soc_type)) {
+	    qca_is_wcn6855(soc_type) ||
+	    qca_is_wcn7850(soc_type)) {
 		ret = qca_regulator_init(hu);
 	} else {
 		qcadev = serdev_device_get_drvdata(hu->serdev);
@@ -1733,7 +1738,8 @@ static int qca_setup(struct hci_uart *hu)
 	bt_dev_info(hdev, "setting up %s",
 		qca_is_wcn399x(soc_type) ? "wcn399x" :
 		(soc_type == QCA_WCN6750) ? "wcn6750" :
-		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
+		(soc_type == QCA_WCN6855) ? "wcn6855" :
+		(soc_type == QCA_WCN7850) ? "wcn7850" : "ROME/QCA6390");
 
 	qca->memdump_state = QCA_MEMDUMP_IDLE;
 
@@ -1746,7 +1752,8 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (qca_is_wcn399x(soc_type) ||
 	    qca_is_wcn6750(soc_type) ||
-	    qca_is_wcn6855(soc_type)) {
+	    qca_is_wcn6855(soc_type) ||
+	    qca_is_wcn7850(soc_type)) {
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
 
@@ -1769,7 +1776,8 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (!(qca_is_wcn399x(soc_type) ||
 	      qca_is_wcn6750(soc_type) ||
-	      qca_is_wcn6855(soc_type))) {
+	      qca_is_wcn6855(soc_type) ||
+	      qca_is_wcn7850(soc_type))) {
 		/* Get QCA version information */
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
@@ -1909,6 +1917,20 @@ static const struct qca_device_data qca_soc_data_wcn6855 __maybe_unused = {
 	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
+static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unused = {
+	.soc_type = QCA_WCN7850,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 5000 },
+		{ "vddaon", 26000 },
+		{ "vdddig", 126000 },
+		{ "vddrfa0p8", 102000 },
+		{ "vddrfa1p2", 257000 },
+		{ "vddrfa1p9", 302000 },
+	},
+	.num_vregs = 6,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+};
+
 static void qca_power_shutdown(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
@@ -2074,7 +2096,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (data &&
 	    (qca_is_wcn399x(data->soc_type) ||
 	     qca_is_wcn6750(data->soc_type) ||
-	     qca_is_wcn6855(data->soc_type))) {
+	     qca_is_wcn6855(data->soc_type) ||
+	     qca_is_wcn7850(data->soc_type))) {
 		qcadev->btsoc_type = data->soc_type;
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
@@ -2105,7 +2128,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 					       GPIOD_IN);
 		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
-		     data->soc_type == QCA_WCN6855))
+		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_WCN7850))
 			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
@@ -2182,7 +2206,8 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 
 	if ((qca_is_wcn399x(qcadev->btsoc_type) ||
 	     qca_is_wcn6750(qcadev->btsoc_type) ||
-	     qca_is_wcn6855(qcadev->btsoc_type)) &&
+	     qca_is_wcn6855(qcadev->btsoc_type) ||
+	     qca_is_wcn7850(qcadev->btsoc_type)) &&
 	    power->vregs_on)
 		qca_power_shutdown(&qcadev->serdev_hu);
 	else if (qcadev->susclk)
@@ -2368,6 +2393,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
 	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
+	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);

-- 
2.34.1

