Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1973F6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjF0IQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjF0IQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:16:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE72130
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:16:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso13528635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687853766; x=1690445766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUbLXpYZ9hbHgMFkQBPgvaWFt2LORh/NmdLaZvqf0uc=;
        b=jFhwV6ZuhNVaBpcMZziyYNirG//4VbUqivdX3Lu4GjPup53xppjsMOSB+rUSMFDn5+
         5dzbs44NqIOHMSgTgrWTyLhD1Eh8SGeqY/w1vp4jUNH84CRe+DntXWVFiZPwhraIe2uD
         dLOPTQUTEXUMQLe7GlGoPLuwHhYVOi2+hDzu0O+iiNGv0h/7bsH4idE7AO2AJG3YC9BE
         l9yJ1+LBmgNPUzd2ooKm4EJvgXv1/AeRwL1XBe7JPAwb3nknTrChsvZuoquX7h07ayO5
         vVwnhcB7WmNmlnj1VtWaMRYIXAjKgrIALM4myXv2MRCbd54MkAHAfrVi+oYjjd3nyQ/p
         /WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853766; x=1690445766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUbLXpYZ9hbHgMFkQBPgvaWFt2LORh/NmdLaZvqf0uc=;
        b=NOI/Q64BvyFDc0kOAt3RtY7RT69ScXRoqaABJAKAkUzJYSj7z7mUvRxZZ++yD/Jyfi
         qV1fb6X6RT1pT6JNpRWTF1qqZGf6AC2B1QaXFq97y1gv9FSP2Wl/j3jAIDHgRn45CmED
         nGpt4/sVXz574z5em3j6XfWxAEoM2XEoldS7O+SRvHPhAJ2GJaVu+As89shXCOs/LGTL
         nGuD/L5Jzb3xrdp/3I40Tlti8GGF722UyOopsdto/Xk016sFcn2kekKvBEVmPukt7CAP
         osdTFOixplO23SSPd5XRr42AJD1SyO2lczqEMCQzn8tyXUJpfiK51745/cWmtyk+jyPE
         Dh/Q==
X-Gm-Message-State: AC+VfDxtbYBslIJMUMgGj7/EIA1iLNfRQfABUo9pwr1Ezq9a75Acb93f
        ipeRmJeEhsEM/khR9sFO8WBlWA==
X-Google-Smtp-Source: ACHHUZ7oLNUN9T3n36ev2QIwwRvlSKmUXzwmdjHeWPmlb6Kyxq6bjqhk6njoMIMj1puDA/+xsWNGSg==
X-Received: by 2002:a05:600c:2206:b0:3f9:515:ccfb with SMTP id z6-20020a05600c220600b003f90515ccfbmr32960384wml.12.1687853766256;
        Tue, 27 Jun 2023 01:16:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm3922480wmi.46.2023.06.27.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:16:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 27 Jun 2023 10:15:55 +0200
Subject: [PATCH v2 2/5] bluetooth: qca: use switch case for soc type
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v2-2-98b0043d31a4@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15642;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ApLQkypensJ5zfDyFrdxJsiq10gUUrb6Pxgj3YfcEtg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkmprApM/6Zm3Y2GuwwS4pkxo6TF/fDYhVRaMsZ+rw
 WqZnw1GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJqawAAKCRB33NvayMhJ0cEzEA
 CyM9WufFh6mNEVeyMm6x281vgCJlYK/Hl1sUfWDUrba++Q+Fr67SjiNtXqTA1cAh/YvnbEe714l41s
 sNYJpLzk21NDcZWZaSaEH7I7gKVe07mPtJ/DCvKpmA2c4igosxAzXOTdPglM6YQJwPjV+9sgIzHvEz
 7+IAEI3PTAT5KLAoNI2UINa3gjOqm/sLYR+dYNA8t439wP+7YTBgTcpgDyUqyidapEzYtyQLlF4Q2V
 x1MOyWrDIDjXvTygyYO6Uf55cWYOCtyONT5vAaxWbzYDrGvJvbQhmBhBfSyzPfCHTn6nHF13/zrXqK
 ZWZpafSqYPL1fd5uMb08OAHacMGfE8l3O61Q86HAevmaK25p9HWQRpmHqCI3hpt+6djjK42aqTt0AV
 Yw5Ei7i9OlzGbEGF6bU3HspSE7CtjRnnA5gJf1IX3KoZFGbdiRF4JJuSjaY9CEf3Y1Qw+ATa74WkdB
 yyqW9gPi+5s33j7mB6dP/1KMY6vvMoIo/eYTVl2kMoft3LZKwgYv3i/Wo4CM5Zx7A8JtDbVIGRVRxn
 IEqWEjPLf9OwbusksHjZDz7lLmdEKiMsjuHdnKj5eFdQbxjW4ddHEjd1/JjvCMNm+yqn7nh8EA1pfX
 K4R1pLQ55LFt1aNZey2F+ypvysefJr4XsoNr0m2hXSuwichWyKELyRfnWmGw==
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

Use switch/case to handle soc type specific behaviour,
the permit dropping the qca_is_xxx() inline functions
and maked the code clearer and easier to update for new
SoCs.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/bluetooth/btqca.c   |  72 ++++++++++-----
 drivers/bluetooth/btqca.h   |  29 ------
 drivers/bluetooth/hci_qca.c | 219 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 213 insertions(+), 107 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index e7e58a956d15..13820cebe5ba 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -601,23 +601,30 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
-	if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crbtfw%02x.tlv", rom_ver);
-	} else if (soc_type == QCA_QCA6390) {
+		break;
+	case QCA_QCA6390:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htbtfw%02x.tlv", rom_ver);
-	} else if (soc_type == QCA_WCN6750) {
+		break;
+	case QCA_WCN6750:
 		/* Choose mbn file by default.If mbn file is not found
 		 * then choose tlv file
 		 */
 		config.type = ELF_TYPE_PATCH;
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/msbtfw%02x.mbn", rom_ver);
-	} else if (soc_type == QCA_WCN6855) {
+		break;
+	case QCA_WCN6855:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hpbtfw%02x.tlv", rom_ver);
-	} else {
+		break;
+	default:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/rampatch_%08x.bin", soc_ver);
 	}
@@ -633,30 +640,40 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
-	if (firmware_name)
+	if (firmware_name) {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/%s", firmware_name);
-	else if (qca_is_wcn399x(soc_type)) {
-		if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
+	} else {
+		switch (soc_type) {
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
+				snprintf(config.fwname, sizeof(config.fwname),
+					 "qca/crnv%02xu.bin", rom_ver);
+			} else {
+				snprintf(config.fwname, sizeof(config.fwname),
+					 "qca/crnv%02x.bin", rom_ver);
+			}
+			break;
+		case QCA_QCA6390:
 			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/crnv%02xu.bin", rom_ver);
-		} else {
+				 "qca/htnv%02x.bin", rom_ver);
+			break;
+		case QCA_WCN6750:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/msnv%02x.bin", rom_ver);
+			break;
+		case QCA_WCN6855:
 			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/crnv%02x.bin", rom_ver);
+				 "qca/hpnv%02x.bin", rom_ver);
+			break;
+
+		default:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/nvm_%08x.bin", soc_ver);
 		}
 	}
-	else if (soc_type == QCA_QCA6390)
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/htnv%02x.bin", rom_ver);
-	else if (soc_type == QCA_WCN6750)
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/msnv%02x.bin", rom_ver);
-	else if (soc_type == QCA_WCN6855)
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/hpnv%02x.bin", rom_ver);
-	else
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/nvm_%08x.bin", soc_ver);
 
 	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
 	if (err < 0) {
@@ -664,10 +681,17 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		return err;
 	}
 
-	if (soc_type >= QCA_WCN3991) {
+	switch (soc_type) {
+	case QCA_WCN3991:
+	case QCA_QCA6390:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		err = qca_disable_soc_logging(hdev);
 		if (err < 0)
 			return err;
+		break;
+	default:
+		break;
 	}
 
 	/* WCN399x and WCN6750 supports the Microsoft vendor extension with 0xFD70 as the
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index b884095bcd9d..e7d50a821bb7 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -160,20 +160,6 @@ int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type);
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_send_pre_shutdown_cmd(struct hci_dev *hdev);
-static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
-{
-	return soc_type == QCA_WCN3990 || soc_type == QCA_WCN3991 ||
-	       soc_type == QCA_WCN3998;
-}
-static inline bool qca_is_wcn6750(enum qca_btsoc_type soc_type)
-{
-	return soc_type == QCA_WCN6750;
-}
-static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
-{
-	return soc_type == QCA_WCN6855;
-}
-
 #else
 
 static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
@@ -201,21 +187,6 @@ static inline int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
-static inline bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
-{
-	return false;
-}
-
-static inline bool qca_is_wcn6750(enum qca_btsoc_type soc_type)
-{
-	return false;
-}
-
-static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
-{
-	return false;
-}
-
 static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1b064504b388..25f1eeb605b6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -605,9 +605,17 @@ static int qca_open(struct hci_uart *hu)
 	if (hu->serdev) {
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 
-		if (qca_is_wcn399x(qcadev->btsoc_type) ||
-		    qca_is_wcn6750(qcadev->btsoc_type))
+		switch (qcadev->btsoc_type) {
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+		case QCA_WCN6750:
 			hu->init_speed = qcadev->init_speed;
+			break;
+
+		default:
+			break;
+		}
 
 		if (qcadev->oper_speed)
 			hu->oper_speed = qcadev->oper_speed;
@@ -1316,12 +1324,18 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
 
 	/* Give the controller time to process the request */
-	if (qca_is_wcn399x(qca_soc_type(hu)) ||
-	    qca_is_wcn6750(qca_soc_type(hu)) ||
-	    qca_is_wcn6855(qca_soc_type(hu)))
+	switch (qca_soc_type(hu)) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		usleep_range(1000, 10000);
-	else
+		break;
+
+	default:
 		msleep(300);
+	}
 
 	return 0;
 }
@@ -1394,13 +1408,18 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 
 static int qca_check_speeds(struct hci_uart *hu)
 {
-	if (qca_is_wcn399x(qca_soc_type(hu)) ||
-	    qca_is_wcn6750(qca_soc_type(hu)) ||
-	    qca_is_wcn6855(qca_soc_type(hu))) {
+	switch (qca_soc_type(hu)) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
-	} else {
+		break;
+
+	default:
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1429,14 +1448,27 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		/* Disable flow control for wcn3990 to deassert RTS while
 		 * changing the baudrate of chip and host.
 		 */
-		if (qca_is_wcn399x(soc_type) ||
-		    qca_is_wcn6750(soc_type) ||
-		    qca_is_wcn6855(soc_type))
+		switch (soc_type) {
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+		case QCA_WCN6750:
+		case QCA_WCN6855:
 			hci_uart_set_flow_control(hu, true);
+			break;
 
-		if (soc_type == QCA_WCN3990) {
+		default:
+			break;
+		}
+
+		switch (soc_type) {
+		case QCA_WCN3990:
 			reinit_completion(&qca->drop_ev_comp);
 			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+			break;
+
+		default:
+			break;
 		}
 
 		qca_baudrate = qca_get_baudrate_value(speed);
@@ -1448,12 +1480,21 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		host_set_baudrate(hu, speed);
 
 error:
-		if (qca_is_wcn399x(soc_type) ||
-		    qca_is_wcn6750(soc_type) ||
-		    qca_is_wcn6855(soc_type))
+		switch (soc_type) {
+		case QCA_WCN3990:
+		case QCA_WCN3991:
+		case QCA_WCN3998:
+		case QCA_WCN6750:
+		case QCA_WCN6855:
 			hci_uart_set_flow_control(hu, false);
+			break;
 
-		if (soc_type == QCA_WCN3990) {
+		default:
+			break;
+		}
+
+		switch (soc_type) {
+		case QCA_WCN3990:
 			/* Wait for the controller to send the vendor event
 			 * for the baudrate change command.
 			 */
@@ -1465,6 +1506,10 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 			}
 
 			clear_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+			break;
+
+		default:
+			break;
 		}
 	}
 
@@ -1626,12 +1671,19 @@ static int qca_regulator_init(struct hci_uart *hu)
 		}
 	}
 
-	if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		/* Forcefully enable wcn399x to enter in to boot mode. */
 		host_set_baudrate(hu, 2400);
 		ret = qca_send_power_pulse(hu, false);
 		if (ret)
 			return ret;
+		break;
+
+	default:
+		break;
 	}
 
 	/* For wcn6750 need to enable gpio bt_en */
@@ -1648,10 +1700,17 @@ static int qca_regulator_init(struct hci_uart *hu)
 
 	qca_set_speed(hu, QCA_INIT_SPEED);
 
-	if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		ret = qca_send_power_pulse(hu, true);
 		if (ret)
 			return ret;
+		break;
+
+	default:
+		break;
 	}
 
 	/* Now the device is in ready state to communicate with host.
@@ -1685,11 +1744,16 @@ static int qca_power_on(struct hci_dev *hdev)
 	if (!hu->serdev)
 		return 0;
 
-	if (qca_is_wcn399x(soc_type) ||
-	    qca_is_wcn6750(soc_type) ||
-	    qca_is_wcn6855(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		ret = qca_regulator_init(hu);
-	} else {
+		break;
+
+	default:
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
@@ -1712,6 +1776,7 @@ static int qca_setup(struct hci_uart *hu)
 	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
 	struct qca_btsoc_version ver;
+	const char *soc_name;
 
 	ret = qca_check_speeds(hu);
 	if (ret)
@@ -1726,10 +1791,25 @@ static int qca_setup(struct hci_uart *hu)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
-	bt_dev_info(hdev, "setting up %s",
-		qca_is_wcn399x(soc_type) ? "wcn399x" :
-		(soc_type == QCA_WCN6750) ? "wcn6750" :
-		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		soc_name = "wcn399x";
+		break;
+
+	case QCA_WCN6750:
+		soc_name = "wcn6750";
+		break;
+
+	case QCA_WCN6855:
+		soc_name = "wcn6855";
+		break;
+
+	default:
+		soc_name = "ROME/QCA6390";
+	}
+	bt_dev_info(hdev, "setting up %s", soc_name);
 
 	qca->memdump_state = QCA_MEMDUMP_IDLE;
 
@@ -1740,16 +1820,21 @@ static int qca_setup(struct hci_uart *hu)
 
 	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
 
-	if (qca_is_wcn399x(soc_type) ||
-	    qca_is_wcn6750(soc_type) ||
-	    qca_is_wcn6855(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
 			goto out;
-	} else {
+		break;
+
+	default:
 		qca_set_speed(hu, QCA_INIT_SPEED);
 	}
 
@@ -1763,9 +1848,15 @@ static int qca_setup(struct hci_uart *hu)
 		qca_baudrate = qca_get_baudrate_value(speed);
 	}
 
-	if (!(qca_is_wcn399x(soc_type) ||
-	      qca_is_wcn6750(soc_type) ||
-	      qca_is_wcn6855(soc_type))) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
+		break;
+
+	default:
 		/* Get QCA version information */
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
@@ -1930,11 +2021,17 @@ static void qca_power_shutdown(struct hci_uart *hu)
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (qca_is_wcn399x(soc_type)) {
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 		host_set_baudrate(hu, 2400);
 		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
-	} else if (soc_type == QCA_WCN6750 || soc_type == QCA_WCN6855) {
+		break;
+
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
 		qca_regulator_disable(qcadev);
@@ -1942,7 +2039,9 @@ static void qca_power_shutdown(struct hci_uart *hu)
 			sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
 			bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
 		}
-	} else if (qcadev->bt_en) {
+		break;
+
+	default:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
 
@@ -2067,11 +2166,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (!qcadev->oper_speed)
 		BT_DBG("UART will pick default operating speed");
 
-	if (data &&
-	    (qca_is_wcn399x(data->soc_type) ||
-	     qca_is_wcn6750(data->soc_type) ||
-	     qca_is_wcn6855(data->soc_type))) {
+	if (data)
 		qcadev->btsoc_type = data->soc_type;
+	else
+		qcadev->btsoc_type = QCA_ROME;
+
+	switch (qcadev->btsoc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2115,12 +2220,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			BT_ERR("wcn3990 serdev registration failed");
 			return err;
 		}
-	} else {
-		if (data)
-			qcadev->btsoc_type = data->soc_type;
-		else
-			qcadev->btsoc_type = QCA_ROME;
+		break;
 
+	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
@@ -2176,13 +2278,22 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct qca_power *power = qcadev->bt_power;
 
-	if ((qca_is_wcn399x(qcadev->btsoc_type) ||
-	     qca_is_wcn6750(qcadev->btsoc_type) ||
-	     qca_is_wcn6855(qcadev->btsoc_type)) &&
-	    power->vregs_on)
-		qca_power_shutdown(&qcadev->serdev_hu);
-	else if (qcadev->susclk)
-		clk_disable_unprepare(qcadev->susclk);
+	switch (qcadev->btsoc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
+		if (power->vregs_on) {
+			qca_power_shutdown(&qcadev->serdev_hu);
+			break;
+		}
+		fallthrough;
+
+	default:
+		if (qcadev->susclk)
+			clk_disable_unprepare(qcadev->susclk);
+	}
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }

-- 
2.34.1

