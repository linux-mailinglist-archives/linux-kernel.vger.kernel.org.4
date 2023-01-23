Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC4767836E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjAWRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjAWRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:39:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36229157;
        Mon, 23 Jan 2023 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674495552; x=1706031552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LNho4sfT75NePcn4eH8u+6snEN8uGq86xx6e7f3JM4=;
  b=OkXdA03C8U+SdjVrMvao70Bayq6rFilxKXFzR5+LqMO0VuiiAdnvTQ7e
   bp1tsKAF1VCk/xgf+lryF8TQBiHBev+q5Tcpqk3CwDBq7xpGTh//rLNGh
   Exl/+KB+3v2OM+r2XApsiNE8yC0t96elv5jWxXfbQh5Galim19Q3jflMx
   m5QOXIDTnrIFsGvr58Icw363ogXqdyO0YrDOafF7CJlGgIUS+qB4ZFAUg
   qUa/ddR7kVqfnAw/zFQcrETWVMTI1HLIhcIT1lqftTinQoPcFFF1agevp
   aLrhkwY941e3KcHN0hn6Pu79IWPlnR6eW2reCTv5K41iI0Pj4ILMQtxu4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390601978"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390601978"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:39:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694017767"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694017767"
Received: from giangiac-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.71])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:39:09 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] serial: qcom_geni: Fix variable naming
Date:   Mon, 23 Jan 2023 19:38:56 +0200
Message-Id: <20230123173857.40695-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
References: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for
serial engine DMA") renamed rx_fifo member to rf_buf which caused a
build failure when b8caf69a6946 ("tty: serial: qcom-geni-serial: fix
slab-out-of-bounds on RX FIFO buffer") from tty-linus was merged into
tty-next.

Fix the member variable name.

Fixes: 7a6aa989f2e8 ("Merge 6.2-rc5 into tty-next")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d98e0a8aae7c..7c49194ec8ac 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1055,11 +1055,11 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
 	uport->fifosize =
 		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
 
-	if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
-		port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
-					      port->rx_fifo_depth * sizeof(u32),
-					      GFP_KERNEL);
-		if (!port->rx_fifo)
+	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
+		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
+					     port->rx_fifo_depth * sizeof(u32),
+					     GFP_KERNEL);
+		if (!port->rx_buf)
 			return -ENOMEM;
 	}
 
-- 
2.30.2

