Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8286C1617
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjCTPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjCTPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:01:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C55D2C642;
        Mon, 20 Mar 2023 07:58:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47E521063;
        Mon, 20 Mar 2023 07:58:18 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.18.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FEC73F71E;
        Mon, 20 Mar 2023 07:57:31 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com
Cc:     James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v3 4/4] serial: qcom_geni: Comment use of devm_krealloc rather than devm_krealloc_array
Date:   Mon, 20 Mar 2023 14:57:09 +0000
Message-Id: <20230320145710.1120469-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320145710.1120469-1-james.clark@arm.com>
References: <20230320145710.1120469-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that devm_krealloc_array is available, add a comment justifying not
changing this occurrence to avoid any future auto fixups.

Link: https://lore.kernel.org/all/20230318173402.20a4f60d@jic23-huawei/
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 28fbc927a546..8ae1fb7c2636 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1055,6 +1055,11 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
 		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
 
 	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
+		/*
+		 * Use krealloc rather than krealloc_array because rx_buf is
+		 * accessed as 1 byte entries as well as 4 byte entries so it's
+		 * not necessarily an array.
+		 */
 		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
 					     port->rx_fifo_depth * sizeof(u32),
 					     GFP_KERNEL);
-- 
2.34.1

