Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA35F742D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJGGXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:23:17 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF4DBEFBB;
        Thu,  6 Oct 2022 23:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665123796; x=1696659796;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AnjXIevw6E577XhDpi0+GryOxpURKeviN/3VExojvZ4=;
  b=N5s03SsbrqQA5+nLQDJE/cVrmqtFFCZOIeIosA6rqJfaRdXBaKLQhfSb
   3uy40r0CMDu37kKU2BUyPs3OYtyAoCUnq+U1bh2vmJYfxdyPH6yixIkDH
   ORKn+95It6SGs9iUpSxsyxdAOY7b6cANqQQ6bwsIDK+H7rNW1SULKzy+m
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Oct 2022 23:23:15 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 23:23:15 -0700
Received: from hu-arandive-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 23:23:11 -0700
From:   Aniket Randive <quic_arandive@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <nicolas.dechesne@linaro.org>,
        <vinod.koul@linaro.org>, <quic_vnivarth@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_ramkri@quicinc.com>,
        Aniket Randive <quic_arandive@quicinc.com>
Subject: [PATCH] tty: serial: qcom-geni-serial: Add support for Hibernation feature
Date:   Fri, 7 Oct 2022 11:53:00 +0530
Message-ID: <1665123780-20557-1-git-send-email-quic_arandive@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added changes to support the hibernation feature for serial UART.
Added support for freeze, restore and thaw callbacks to put the
device into hibernation.

Signed-off-by: Aniket Randive <quic_arandive@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 83b66b7..b487823 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -924,6 +924,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 			       false, true, true);
 	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
 	geni_se_select_mode(&port->se, GENI_SE_FIFO);
+	qcom_geni_serial_start_rx(uport);
 	port->setup = true;
 
 	return 0;
@@ -1547,9 +1548,43 @@ static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 	return ret;
 }
 
+static int qcom_geni_serial_sys_hib_resume(struct device *dev)
+{
+	int ret = 0;
+	struct uart_port *uport;
+	struct qcom_geni_private_data *private_data;
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
+
+	uport = &port->uport;
+	private_data = uport->private_data;
+
+	if (uart_console(uport)) {
+		geni_icc_set_tag(&port->se, 0x7);
+		geni_icc_set_bw(&port->se);
+		ret = uart_resume_port(private_data->drv, uport);
+		/*
+		 * For hibernation usecase clients for
+		 * console UART won't call port setup during restore,
+		 * hence call port setup for console uart.
+		 */
+		qcom_geni_serial_port_setup(uport);
+	} else {
+		/*
+		 * Peripheral register settings are lost during hibernation.
+		 * Update setup flag such that port setup happens again
+		 * during next session. Clients of HS-UART will close and
+		 * open the port during hibernation.
+		 */
+		port->setup = false;
+	}
+	return ret;
+}
+
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
 					qcom_geni_serial_sys_resume)
+	.restore = qcom_geni_serial_sys_hib_resume,
+	.thaw = qcom_geni_serial_sys_hib_resume,
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
-- 
2.7.4

