Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868DF64DF10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLOQzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLOQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:55:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA09389FF;
        Thu, 15 Dec 2022 08:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0DC61E50;
        Thu, 15 Dec 2022 16:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27427C433F0;
        Thu, 15 Dec 2022 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123299;
        bh=ZKM76IKVl+oE/V0fQ6ck+h5jxYKKktSIJud+zEgrvtw=;
        h=From:To:Cc:Subject:Date:From;
        b=FUCD/0mGC+mr3xUpe1YDVg3Porf4rdwuX1j3GZbLYLmsTjoSJBArBSPXRWWMr18YM
         +KCVjQWfZRGvxISu7QdnUE+ORzVgZstqZSyrXufueEmZphky1YTM45xgzczB5AxAIn
         4iCRnmt3mV5vLaVJYl/+VOyKujyYwS1vQx+PEeRE7cwYx8GpmI9JP7jXvxH8Xh1l/a
         rCil2nKv4khTnlniQ7uC/MuSekCXUc6Hjmf7MiqJvVF5FhT2yugGYujDS3TabPXiOk
         aWEicCIQxvXf01s3v683x+mGYVkfVSudRvCh+vNi2bdCrwP9BRQYHCGhIXyytx7rhj
         /2yMhk8sgtQIg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Aniket Randive <quic_arandive@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: qcom_geni: avoid duplicate struct member init
Date:   Thu, 15 Dec 2022 17:54:24 +0100
Message-Id: <20221215165453.1864836-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When -Woverride-init is enabled in a build, gcc points out that
qcom_geni_serial_pm_ops contains conflicting initializers:

drivers/tty/serial/qcom_geni_serial.c:1586:20: error: initialized field overwritten [-Werror=override-init]
 1586 |         .restore = qcom_geni_serial_sys_hib_resume,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/qcom_geni_serial.c:1586:20: note: (near initialization for 'qcom_geni_serial_pm_ops.restore')
drivers/tty/serial/qcom_geni_serial.c:1587:17: error: initialized field overwritten [-Werror=override-init]
 1587 |         .thaw = qcom_geni_serial_sys_hib_resume,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Open-code the initializers with the version that was already used,
and use the pm_sleep_ptr() method to deal with unused ones,
in place of the __maybe_unused annotation.

Fixes: 35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibernation feature")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/qcom_geni_serial.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b487823f0e61..03dda47184d9 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1516,7 +1516,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
+static int qcom_geni_serial_sys_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
@@ -1533,7 +1533,7 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 	return uart_suspend_port(private_data->drv, uport);
 }
 
-static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
+static int qcom_geni_serial_sys_resume(struct device *dev)
 {
 	int ret;
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
@@ -1581,10 +1581,12 @@ static int qcom_geni_serial_sys_hib_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
-					qcom_geni_serial_sys_resume)
-	.restore = qcom_geni_serial_sys_hib_resume,
-	.thaw = qcom_geni_serial_sys_hib_resume,
+	.suspend = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
+	.resume = pm_sleep_ptr(qcom_geni_serial_sys_resume),
+	.freeze = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
+	.poweroff = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
+	.restore = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
+	.thaw = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
-- 
2.35.1

