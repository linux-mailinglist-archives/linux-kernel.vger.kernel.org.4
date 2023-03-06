Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61A6AC4F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCFP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCFP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:27:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8285B30E9A;
        Mon,  6 Mar 2023 07:27:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A510E12FC;
        Mon,  6 Mar 2023 07:28:33 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A26133F71A;
        Mon,  6 Mar 2023 07:27:47 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 4/4] serial: qcom_geni: Use devm_krealloc_array
Date:   Mon,  6 Mar 2023 15:27:23 +0000
Message-Id: <20230306152723.3090195-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306152723.3090195-1-james.clark@arm.com>
References: <20230306152723.3090195-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it exists, use it instead of doing the multiplication manually.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d69592e5e2ec..23fc33d182ac 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1056,9 +1056,9 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
 		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
 
 	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
-		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
-					     port->rx_fifo_depth * sizeof(u32),
-					     GFP_KERNEL);
+		port->rx_buf = devm_krealloc_array(uport->dev, port->rx_buf,
+						   port->rx_fifo_depth, sizeof(u32),
+						   GFP_KERNEL);
 		if (!port->rx_buf)
 			return -ENOMEM;
 	}
-- 
2.34.1

